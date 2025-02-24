Return-Path: <linux-kernel+bounces-529166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA625A420A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A913A8A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069A202C24;
	Mon, 24 Feb 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XUH5JFaZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355523BD0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403665; cv=none; b=AngNDD7mmS+75jVTDMtlMWGTLRSF0MnPHuBAmXc/9YJ4AuU7S38JOLX90sRS2QAvqaB/5Cxgop1flT6+F55qb1993Y41cXykYN0FPYXnjx5Af1n9WAllzPKVF9QjoxYZv1RIQxKjAoBkCic+5rc3tll1ryGYiHtMddQgpXeP4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403665; c=relaxed/simple;
	bh=/grIuiZywzsMY763MHhi+QPPUc0knKJ6tVncnEuQrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs2Ltf3PcHgEKwLTHEcif3ugDzn4CZmwyRq8X+rjZkGF2gjCWf6Tqhs4vzx5pG8ZtcO9M6Ov74q3/ju4DsBlWTYgCNXJWMdrhQRXNoIbn36pZUI3eoovkLu8UCrIX9hMCnXeGeXdFXJGtkpP9zhGe0MIX1JtjzV+Z02cvFullkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XUH5JFaZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB96340E01AE;
	Mon, 24 Feb 2025 13:27:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D40K1DOUZCW5; Mon, 24 Feb 2025 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740403656; bh=nU4YjKrCdJrQ43SsXSMujezi/S/NNo/oWAq01RiCUyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUH5JFaZgYJJSSFgf5faHLPM8O8RDdEgsSNkw81Ph+aEJrcF5x698AuVCK5BOuLy8
	 xsdNhicmqam2etoK4s8wlriNhUpOeLwSdzdAZ4i2GTkrMEETzkCiNNpzD6d3zZAYyM
	 bIDILAjDKAZ/iqKC9xyU4o+2A00+avZ++389qtzEduSu1wL8Vne3uEqKteMIV/kihY
	 8dN9et1/vMq2X4yy5viUF0eyQiiA09dbYXY2Ib8wVmdqjI9lnIDvDNjtfstKBO181N
	 87CWTaXclKuhWquOfR3sTpK9djW470hUL31DXeimbC+Zl2y+c7qrOgDBbh3z+Qk+fH
	 A96mvky98LHRLY8QmrFiHSOj8m3MwQtejG6rWGscgDoI3Vnl1VZv2srKzzJ4sPLPFp
	 I65CahpdS6fUTieCD9o9pSxBQIG/rYjPRyh00ixUkv/RXaPSioBXDNUnCubLewRiqd
	 SJY7/5wkQPONAXJwr1u62sugCtBY6zLcdkub/p67UH2xKhRYjBMMn2VCNyOIC5xZ9l
	 fCXs823CtQVU7oTjpPbCGlC8cHFN3ZTGWF+JlUuO17rkNBiyDOUIKTZpq+vZBeXXdd
	 53STS4iN0vN7wmeR/mRkPyw3ot9eXKW+Ck6BfkikWfH30YfOllKaluqdEP3yaxvESx
	 ymB96NxxXABWbMTzW9VV4cWI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10E1A40E015F;
	Mon, 24 Feb 2025 13:27:19 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:27:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
Message-ID: <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-7-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:56PM -0500, Rik van Riel wrote:
> In the page reclaim code, we only track the CPU(s) where the TLB needs
> to be flushed, rather than all the individual mappings that may be getting
> invalidated.
> 
> Use broadcast TLB flushing when that is available.
> 
> This is a temporary hack to ensure that the PCID context for
> tasks in the next patch gets properly flushed from the page

There's no "next patch" in git - just merge this three-liner with the next
one.

> reclaim code, because the IPI based flushing in arch_tlbbatch_flush
> only flushes the currently loaded TLB context on each CPU.
> 
> Patch 10 replaces this with the actual mechanism used to do

Same. No "patch 10" in git.

> broadcast TLB flushing from the page reclaim code.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/mm/tlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 2d7ed0fda61f..16839651f67f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1326,7 +1326,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  	 * a local TLB flush is needed. Optimize this use-case by calling
>  	 * flush_tlb_func_local() directly in this case.
>  	 */
> -	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> +		invlpgb_flush_all_nonglobals();

I'm confused. The docs say rAX needs to be 0x6 to do "Invalidate all TLB
entries that match {ASID, PCID} excluding Global". But you're calling INVLPGB
with rAX==0 and the APM doesn't say what this does.

I'm guessing you want this to mean invalidate all non-globals for any ASID and
PCID. So I muss be missing the place in the docs where it says so...

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

