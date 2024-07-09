Return-Path: <linux-kernel+bounces-246458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F092C1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180D61C23114
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91D180029;
	Tue,  9 Jul 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WzjSINuN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2C17B025
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543626; cv=none; b=EeeDlAJVGooMGVMBBazjmxuMZJhUes3Y+vsmBjQ8M3rGM4wmKzrr9Ped28JvlY5FGLVu7/ZD70Oi/Ut9J/+/J7tQCtujp0g0WjOvSwDEMBJLPWnpnBwYadyxFVMOxZTLtc1VyA7Wh9dBu0x32QhuHjy2+agh7EWZ8tctvtjDG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543626; c=relaxed/simple;
	bh=JifuwgFOmrYg3pzmXybExoHMduvDlSiEZu+m7R3LRvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deUGEQT4jKnGy/3TAEOi1mx2rNkHrBaYk73Dq1q7juNCa8EKpLQaqv3tGY9blGjTyLOD94c/15ybM91ZzAFbUWvw4B1o18smXSfYv8mNRxQfTL+6GYok4xcl+re8fiDTW0tO7uCXt+yRYpZZpC+7zjtBCCRDoxfH++k4o9LvbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WzjSINuN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 115BD40E019D;
	Tue,  9 Jul 2024 16:47:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5NPr5Lr4haEI; Tue,  9 Jul 2024 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720543612; bh=8i+4rOYzymslDf2epGo0HMtbWDgtnBBnW7amzKV2sSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzjSINuNeDdHVqa1aNCOABZrOwdvwuTm9Hbjx1aHv6LfKg7CP962Q8WbRrBVYaM2N
	 YrW0dQEWTms2/eh0lGGzYSa/E+STZ8n9ErvdRxiQtaGRc9V9x1gvlGFGDW5gi7cv6g
	 z97k7BRFgPsSePZW0uwXEayA6GQzUm1G2K/RpTQzoywTUT2oHOSY+/tZhtkMWfsiNc
	 RmxbB44WeqWNWdBW1YifXRNls9qwm494r7L20Dmo3V1JTZQuXrIuxGxREeEmE5xJrm
	 PjtJq7ifaen/HGmE17Hdq6Crvk3tm1fzjRfZH06rsTqbCS+a+GD1lHMHIx8i8Fx58f
	 srr03HANGLxpbvJ4rxO0pC2ES3IdtFeICCHj+sfcql51cEc2j49mEi6Zi3q+P2O5rI
	 ko+jgwnjakgw9YeeVOxx6H4q8+7E2e2W8q3KPbYNuI5n6WZCmT6jwVlsLbiVYr3tBw
	 JRYflHVgMM4j0mVIGTQnsUE9UcknA0sOtV/gGhBSdLYEwA+NQ7zEfVUwUIl1LqvbbW
	 sVMpo2dzLGDtwRbhZyD4mhm6SzWWL0FtvEajz2xzGnhg70uXgHFPUXgKqXZ9w2ZHqq
	 JroWIfU4eAW9nd8EGHv4emHie6QLcIpE2wV5D6Q1gDBMGXBBd9eVs6vieeouXPJysN
	 iuBOO9jXyDgsbWF2oNNdsdzc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F19040E019C;
	Tue,  9 Jul 2024 16:46:26 +0000 (UTC)
Date: Tue, 9 Jul 2024 18:46:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240709164620.GLZo1pXPiG42JH4ylN@fat_crate.local>
References: <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
 <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
 <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>

On Tue, Jul 09, 2024 at 10:07:48AM -0500, Steve Wahl wrote:
> I think perhaps the cover letter was also too verbose on the history
> and unintentionally hid the information necesary to understand the
> situation.  I will try to make it more concise.

Thanks.

And while we're at it, I think we should do this too.

Which should actually fix your issue too.

---
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index cd44e120fe53..a838cad72532 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -484,6 +484,15 @@ static bool early_snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
+	/*
+	 * Bail out if not running on a hypervisor (HV). If the HV
+	 * doesn't set the bit, that's an easy SEV-* guest DOS but that
+	 * HV has then bigger problems: the SEV-* guest simply won't
+	 * start.
+	 */
+	if (!(native_cpuid_ecx(1) & BIT(31)))
+		return false;
+
 	if (!bp)
 		return false;
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

