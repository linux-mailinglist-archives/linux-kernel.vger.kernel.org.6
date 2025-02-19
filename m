Return-Path: <linux-kernel+bounces-521393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89275A3BCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DE57A57C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7A1DEFCD;
	Wed, 19 Feb 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NEzVym+W"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1C43151
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964120; cv=none; b=YjBbz595b+OgCpQMzqhMoa32Py38uldz3UtD0CU6A8KWBBDr2Q8vsTNUHNSq69N7Ry3rhmJUPGCI16P67rEtPHiXBswUg+pBJFOMS5ItUyLIum2SvaEDHYD2ItzjoNV0My56tiCfUhN9j+Z6VzRs8R1293hB0MCeR5N6pAmMcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964120; c=relaxed/simple;
	bh=vw7n+6Q82aUZc1be5yOiJLV0VU2XP9yUb2Yh/0QNfsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EksBk96PK9lPnGz46g9uBqA3ALh4DDyDXdK5dYbGBbtE7Rthrg6iXSQYcU3WB3OskmPQFNnrTEZJUMFHWlK7KosBB967NTGBTtMRdvGNttsGQPNQcgrO2lQnCUsJzUbnwKdOejUq1Bx3yw0uwLyrekMZtmGVXknAL0rhys5vVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NEzVym+W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A50A840E0221;
	Wed, 19 Feb 2025 11:21:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JQqlS3ylZ2JE; Wed, 19 Feb 2025 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739964105; bh=eTUjwt5//DA+LtwykcARc8xiBAvEsEq/rmX8J9I+2jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEzVym+Wqml9nKrSyHOg0USrV+lln8p6KXwRZXlGOD+fD06ZYGHMy7xJXVMBhWhrf
	 LH4zjdP1dgoQeBx4j2CzCC2kty6OIiQJsRo0NIIgfIiWhQiXgcK/J4o4t97uJUdw+O
	 cjSv5iX7F3Ech98+B8qeUcN+Wp0jvlt/uwf58SOmnsl8sPnrQWQQkZltWkYHI+T0GZ
	 1rEnP5iNhF9JA08X3NhLVD9YxMtX9c6rXDmVB/gzXoVwyD2otZHhJ+b6811+wKMbZG
	 HK1YbaRh0+VIPJva36Al9ObTGLw7WpaK1+IAzpaW/Ari/DVhRx6bhzcoToquS1e9mB
	 GHJjUTTIUTzk5h7o1QF2vPBKW7Fn5WP25OhMvC1xl+pllxI3HtyD7U6D4ebA3qYgBW
	 w8uhfZtl3TBj5ctTR+HIdSSLHiSU0q3HKwLEYmBxyi8jZMc69HvXhatcHlif7OqaM2
	 fTwuUkvCPwq9VUxdmsRPTr9YLBOWti0O0kZR7HFh5mImzVKoCITpDMBxuuZwU2Iedq
	 Zp/9wCj85JskDDZIT8B+7tv6PzuWxr804ANGMmTPdyVXr/DbZHAdtqH02k1YvCXINo
	 U3Orryzmvt7bKgIe/ohxIEPVm89C3oOUSAsOmr4k9dhH8y+EPcAzwWgurwoOPDYqRk
	 eO7SaKuAvscarQMzSzuWW4Sg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3297C40E01B2;
	Wed, 19 Feb 2025 11:21:29 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:21:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 03/12] x86/mm: consolidate full flush threshold
 decision
Message-ID: <20250219112122.GLZ7W-sjOTi-LXlRp4@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213161423.449435-4-riel@surriel.com>

On Thu, Feb 13, 2025 at 11:13:54AM -0500, Rik van Riel wrote:
> @@ -1009,6 +1009,15 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>  	info->initiating_cpu	= smp_processor_id();
>  	info->trim_cpumask	= 0;
>  
> +	/*
> +	 * If the number of flushes is so large that a full flush
> +	 * would be faster, do a full flush.
> +	 */
> +	if ((end - start) >> stride_shift > tlb_single_page_flush_ceiling) {
> +		info->start = 0;
> +		info->end = TLB_FLUSH_ALL;
> +	}

And if you move the range decision before the info-> struct members
assignment, it becomes even more readable because you're using start and end
in the check and then you assign it so a reader doesn't have to go and look
whether start and end are the same as info->start and info->end:

        /*
         * If the number of flushes is so large that a full flush
         * would be faster, do a full flush.
         */
        if ((end - start) >> stride_shift > tlb_single_page_flush_ceiling) {
                start = 0;
                end = TLB_FLUSH_ALL;
        }

        info->start             = start;
        info->end               = end;
        info->mm                = mm;
        info->stride_shift      = stride_shift;
        info->freed_tables      = freed_tables;
        info->new_tlb_gen       = new_tlb_gen;
        info->initiating_cpu    = smp_processor_id();
        info->trim_cpumask      = 0;

        return info;
}

with that:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

