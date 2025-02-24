Return-Path: <linux-kernel+bounces-529089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C057A41FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0843164794
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CF23BCE8;
	Mon, 24 Feb 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tftfdh5x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129323373C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401205; cv=none; b=n8u0FQ5KYUDsqXlrE2CHZ2pE6vrrIuV5FnVGvVcVxvmFaa3d6N7xjE7ysnGMpKobwGuE92hocBKNwsV54Jy998xYrzFq4rSn5wZcfwHpAAi0VLBFtw/YKW1l5ALAgal+ouUBy084vy+ngJvusHcbXc8b2i3UGlLqGKdJBQKI1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401205; c=relaxed/simple;
	bh=C917u6T4jfg0c9cJ9l1ouE+03Feeq04jBiwMklKuPVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9+J6Zrg/5/UGhWd+o6Wb8sx70dTTLQBnAJDmg+XIzyVfLCckJIJokZ3p9alDTrc50WfObJfbFPV+urTLEO8r0dyYYj4pZ+qeJrZ1w2uMghmZImVLiuh3zbwV3Zv//HtWmzyx9XubzUEBPVKR+qhhlJylotqpBGAbZKrZSH+8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tftfdh5x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D4C2140E015F;
	Mon, 24 Feb 2025 12:46:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zIGJtjT7ztu8; Mon, 24 Feb 2025 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740401195; bh=r4zJ7NGL8jaiq+rMES5kwpX3x3oY70MnfLBpgKugJOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tftfdh5xa8q24B8D7TqVCt5+HY4WFIG5+EFq2AcQmrkMf1YTEPpXCgxqYEneQBBV+
	 Yy9321QMWpjx0jcPxuUw5s5Xm5B3ndWMkTnAo1RH0+Wk9v99j7seJODYaRlja9s0f8
	 Op+C9liFejQ4RgHF6J88n/AZfWAkX24yOzE+DRtIztm6DspT1DJ2OhycUZ0JcR322v
	 xhuetgS++S0I13RUmyhMplVZlxe10Iz0KwFONZ0q1Fg2MTJgqDf8XhuPykkeMlHlbF
	 P1STo99C8DXzhWLseJCfIYBBnKmP5u/p46+94kqqiJWdpsViWwPAk/f6KfCrVGmsaE
	 Ew8hAcBbmmI0eurIq7bViT00ynP/oaU2YrTFAWnCAnrobCkVmlRdkcG4NwyCichr/2
	 vbU0cofcY5PgR/M8cTfHAzZ+tunWlUuVT1eJab7FW2v7UbOdKqG7AJv/ZFcXNppfmq
	 p/YvTjxLfxIlESNnTvpUkiYdbW+Wfg+odltsFDdblx6V5QvpbdfWc71iS5G5Xkj1lJ
	 M5U7Cafn//jELR0G8V+CpVgC5+5binv/GhVsJ27eebFc8pAxvr5Q//DWB6pB1E/UZv
	 k+1SBKEYHH+VvLi0MUMWo2eZ/EQYf5RqdLySJBmmWxopcWJFLJGZJncPft0GsAolr6
	 dyZgYz6Vq+Sy2/k8Rd20/M1I=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F56140E01A3;
	Mon, 24 Feb 2025 12:46:18 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:46:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 05/14] x86/mm: use INVLPGB in flush_tlb_all
Message-ID: <20250224124612.GGZ7xqFMYXmoRXqKdP@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-6-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-6-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:55PM -0500, Rik van Riel wrote:
> The flush_tlb_all() function is not used a whole lot, but we might
> as well use broadcast TLB flushing there, too.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/mm/tlb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 59396a3c6e9c..2d7ed0fda61f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1065,6 +1065,16 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  }
>  
>  
> +static bool broadcast_flush_tlb_all(void)

broadcast?

All those INVLPGB functions have a "invlpgb_" prefix...

In any case, get rid of that function:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2d7ed0fda61f..feaca53b7685 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1065,16 +1065,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 }
 
 
-static bool broadcast_flush_tlb_all(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
-		return false;
-
-	guard(preempt)();
-	invlpgb_flush_all();
-	return true;
-}
-
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
@@ -1085,9 +1075,11 @@ void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 
-	/* First try (faster) hardware-assisted TLB invalidation. */
-	if (broadcast_flush_tlb_all())
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		guard(preempt)();
+		invlpgb_flush_all();
 		return;
+	}
 
 	/* Fall back to the IPI-based invalidation. */
 	on_each_cpu(do_flush_tlb_all, NULL, 1);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

