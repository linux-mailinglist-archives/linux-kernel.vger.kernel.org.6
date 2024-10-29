Return-Path: <linux-kernel+bounces-387460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F39B5198
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C03CB231DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB511FB8BF;
	Tue, 29 Oct 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CqnPLbNZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D941CC17A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225486; cv=none; b=agqzD15XKdN7B7FYOlsOPQkugdHqZGZ8fc/aS3I7X2qwe4MmT1n5tOjI0TjqkDK+lh9wMaFEJRCdEPZLknxALgyZ1jb1C7xMlw/ce9NXJHalMkS0fNo/6LNN4NovTmtCsvc0skc/CkOWnl58ycOsSUpkJOquCoGCe4OA6ip6f18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225486; c=relaxed/simple;
	bh=FLk7Y1VVgOPReJv+P14u5P2ciQaIrEWv0Ieic5HyP4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ZD5/Uf4Qk8igrAhPBDI+AbONqdY5yq42mcQ7JoetMM3KZnxqIh4pyzO4eiDUGL8xgk8kJ7yUPVKYcOc9VeR9Umeu/PI1k/V0wQIpXotQoBW0Rr2g1xGNF4e5PKP+MhLh2znj+JeH5WDO76Msl5QKekYboaCD1NpuE77EL/zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CqnPLbNZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E470140E0219;
	Tue, 29 Oct 2024 18:11:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1jUAB7o3tzMk; Tue, 29 Oct 2024 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730225476; bh=6Fu6LG6Vbq5lMPm5XWcRJQzu3wtX0SK7peh7dKKVOeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqnPLbNZvNDu/GWN1P7RVVqFeuW1y5LP8a/bS/v6+1GCoF3D7Nvr0sVaaNEEzXKca
	 VjsHvLKArsgaYUYVl1bW9luZ8E+jDkNGBOgG4S8Waq/yuyD/RM7tI77mIhIopU9EQQ
	 0AgJjpEH385uvOfCQwbxVaSY/qaapfAEJH2cwD+fIBrogtG9sL8VdtLhEAqBtkFpUB
	 vYeFiwCVgWfcL5qeUHQP/r005V4tF3JlP9CNG6NhweXMWn2AF2C2ss5KbThAzagydt
	 ln1Y1Uvek14D9dL3PSg22Cea27lx8TKjOvHI7GJbSUS1EtaYRms92ty5Di2gKv8wZI
	 FEMOCfTkbDWHsRWKNJSa87wdVXONjh/bTRsegKVYutm/WhipVYPeW1myYcR+URvsGy
	 DaNbdWYPqjxGdyA6L+0kKfB6oINqZ4LfXbnKVHq0lo6PLRSg8TlCIDMJwMhVZ6zQGb
	 k31ottzjD9kxO/1GOO3yfZbHWBH1b51Gw97uTXQlnobbd6s4hQOzP/MK3Ym1tlNGhG
	 hIJO86HuJioZTEgZMjKhG/5AtXRU1RXrqb21ZAwD4khJozY0cHpWTN1yTRze78kXcH
	 XFCuZSlihelQmi/6HFYkuniS+uXwDzAu6qa4bvvNzSJQ5CRWLLwk0XmdJQUtLMoXoU
	 wJC06yLzsdwCKS+BhvzSK2TQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A77E40E02BD;
	Tue, 29 Oct 2024 18:11:07 +0000 (UTC)
Date: Tue, 29 Oct 2024 19:11:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911081615.262202-2-bhe@redhat.com>

On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> In function early_memremap_is_setup_data(), parameter 'size' passed has
> the same name as the local variable inside the while loop. That
> confuses people who sometime mix up them when reading code.
> 
> Here rename the local variable 'size' inside while loop to 'sd_size'.
> 
> And also add one local variable 'sd_size' likewise in function
> memremap_is_setup_data() to simplify code. In later patch, this can also
> be used.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d279321ea..f1ee8822ddf1 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,

Huh?

---
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70b02fc61d93..e461d8e26871 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -632,8 +632,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
  */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool memremap_is_setup_data(resource_size_t phys_addr)
 {
 	struct setup_indirect *indirect;
 	struct setup_data *data;
@@ -769,7 +768,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 		return false;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (memremap_is_setup_data(phys_addr, size) ||
+		if (memremap_is_setup_data(phys_addr) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

