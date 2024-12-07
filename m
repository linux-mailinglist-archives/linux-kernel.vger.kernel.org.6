Return-Path: <linux-kernel+bounces-436052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF39E8082
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CD2281D1F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69E1448E4;
	Sat,  7 Dec 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ty92Kd72"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB328ECF
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587476; cv=none; b=I91KJ1MjRb3/GHdVjvELKUnOilXHhdeGgC9cMgoy89W4fmhppJc8jpnOnV01UlLW0Wdxla3yLeIcRtOQoM5me9lY/E3hibq8Fc9NtMYYKVvWLUn+d8m3AYPNwxqdUN+ZLa7wty/NZkLgTmqKd90DmxIEh4v5kY8cUGIKmJu7xiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587476; c=relaxed/simple;
	bh=h/gfrjcG6QzHZ0wUgv/qMhsA4m4rPaFrBDAR2Mx8i4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0CRLJREgUP1QKQ/A1XN0GewuGPFansc1JDAegdK5z79fvEwrACxDaweVYIhTKD7UCzyTbdVmk/4u5HHfhQiUAdc1NL80Rp4J5wmyF4rT9HuSsgG/pjeFt25sCQqzpfBK5ZP0ZgAjGmvpoNNF1xL7RoGVYOGtb1OJ+wN4WdmDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ty92Kd72; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6076340E01A2;
	Sat,  7 Dec 2024 16:04:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F4RsM7jkQtwI; Sat,  7 Dec 2024 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733587462; bh=bNejE0pr6QI0murC285qHwFbNcoC3uJ3M5IYTto9fVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ty92Kd72LC11EcEzUET0gUzW6eG/wbI0M17tjAczdzWjm7Fs2WfAQ6Pqw/BwGq3P4
	 pgaZwkXuEaPB+dNcnr1Jh1UKsW9x0vEAd1ezIBnWsMHfybYMCe8meo4THQ+zyqNQJa
	 0GKGy45VmgXjpSY4LUz1+rqhrQkXDazrh9nfaZyRpuVRFIHbNxV2A4FUNJ6N2Tn76S
	 feFrNRMo4ujE4FZFGXQQfI6NzvNHVum0O4Pd9k/gY66q/vMU8bA+Z868CwfKeSJ9gf
	 yq6iKKImzKBpPD8j+GnGLSk1t/MbFrz8435SieJ+HFqqGTudDYwXdzYOeaKsP7JYFF
	 ILsvEPAZa1GYUlu9/N0+Lahq6GzqHH4NkUmQ6SQyQh2xv+gvnVQMFgELsWJqXZANiV
	 4w7j53JuiehZhd2drJhA0Sd+E+3VloBJRI8N7eg2xi3XnnJQeYuMI69aYsI9uTVNnV
	 wBh/WabzFE+DhSO4FfFJO8tLhOMf05xoKYEO5zIF0raRgGm5oi50tGppfblv7p1E6L
	 XBMt0t8A0puHmzQtHaozcwnRINQug3kPuECohdGk5C1srKhyhIuDy1HySccSuVaVkf
	 u92h8gkh66JEmGf8u5IsuAhe+o72RHV73+DOk3ykJLE5V2JC8RZkXBIrCXetacYEx9
	 Iy3o3J8iMTt5vhU8mYw/jTpo=
Received: from zn.tnic (p200300eA971F9358329c23fFfEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9358:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A23040E016C;
	Sat,  7 Dec 2024 16:04:17 +0000 (UTC)
Date: Sat, 7 Dec 2024 17:04:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: mingo@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/3] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <20241207160411.GAZ1Rx-9eQHH1IXOwP@fat_crate.local>
References: <20241123114221.149383-1-bhe@redhat.com>
 <20241123114221.149383-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241123114221.149383-2-bhe@redhat.com>

On Sat, Nov 23, 2024 at 07:42:19PM +0800, Baoquan He wrote:
> Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> share completely the same process and handling, except of the
> different memremap/unmap invocations.
> 
> So add helper __memremap_is_setup_data() to extract the common part,
> parameter 'early' is used to decide what kind of memremap/unmap
> APIs are called. This simplifies codes a lot by removing the duplicated
> codes, and also removes the similar code comment above them.
> 
> And '__ref' is added to __memremap_is_setup_data() to suppress below
> section mismatch warning:
> 
> ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
> early_memunmap (section: .init.text)
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 104 ++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 69 deletions(-)

Some touchups ontop:

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aaf40a712b04..fe44e8180bdd 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -632,9 +632,9 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
  */
-static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
-						bool early)
+static bool __ref __memremap_is_setup_data(resource_size_t phys_addr, bool early)
 {
+	unsigned int setup_data_sz = sizeof(struct setup_data);
 	struct setup_indirect *indirect;
 	struct setup_data *data;
 	u64 paddr, paddr_next;
@@ -647,24 +647,23 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 
 		if (early)
-			data = early_memremap_decrypted(paddr, sizeof(*data));
+			data = early_memremap_decrypted(paddr, setup_data_sz);
 		else
-			data = memremap(paddr, sizeof(*data),
-					MEMREMAP_WB | MEMREMAP_DEC);
+			data = memremap(paddr, setup_data_sz, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!data) {
-			pr_warn("failed to memremap setup_data entry\n");
+			pr_warn("failed to remap setup_data entry\n");
 			return false;
 		}
 
-		size = sizeof(*data);
+		size = setup_data_sz;
 
 		paddr_next = data->next;
 		len = data->len;
 
 		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(*data) + len))) {
+		    (phys_addr < (paddr + setup_data_sz + len))) {
 			if (early)
-				early_memunmap(data, sizeof(*data));
+				early_memunmap(data, setup_data_sz);
 			else
 				memunmap(data);
 			return true;
@@ -673,15 +672,14 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 		if (data->type == SETUP_INDIRECT) {
 			size += len;
 			if (early) {
-				early_memunmap(data, sizeof(*data));
+				early_memunmap(data, setup_data_sz);
 				data = early_memremap_decrypted(paddr, size);
 			} else {
 				memunmap(data);
-				data = memremap(paddr, size,
-						MEMREMAP_WB | MEMREMAP_DEC);
+				data = memremap(paddr, size, MEMREMAP_WB | MEMREMAP_DEC);
 			}
 			if (!data) {
-				pr_warn("failed to memremap indirect setup_data\n");
+				pr_warn("failed to remap indirect setup_data\n");
 				return false;
 			}
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

