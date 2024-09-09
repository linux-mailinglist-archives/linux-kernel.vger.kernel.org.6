Return-Path: <linux-kernel+bounces-320769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31253971001
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E350C281B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268871AF4F1;
	Mon,  9 Sep 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Df+yyUuj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF01AE055
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867642; cv=none; b=B4CAKYwt1GBFDBiOZZ88xar4NEdJYiLs3mer0fGlJDlzuXh2aFRSD277IsVDsdhsj6G0h4ZjKnb4WJgvzwdcJ3GQbZitWCsCyVqx2/sp+AKVZFUvXnv0muAmOU8fUWYvtoySB1d15TJuSeXNuuBXGpj+H8qvg4rThIMNreFLO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867642; c=relaxed/simple;
	bh=UxNG104SdunqMkFngXFGvHzSLaLcGrl3Ka4Dw3p5Z5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOY9HV83l3soYCwQ/X3k5QCWOB8Q5UJPXJSlpkPIp7NYcxoUmk0q34pirK167XNqjHYhvfBfUv9VvF4ijvgE2w7j75g1A60lIK75NH0fJ0hYmzAZgK30z9EJP6uMVCsyMDssLFSJUV4+0jWcwVaNZ+zMh/PFhnaNhdSkfB1xpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Df+yyUuj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso4188545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725867639; x=1726472439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSRoG8tK9Qzdn5ZF5Thjq6HAamLJOlkqFyKHUb902Ao=;
        b=Df+yyUujmD6BG36HLJH1xGBmAuTWCLEZKsYN7N+IS4fdLQ5RxiM+48LjPHz5aTe5vX
         pIh9qWzSA5vQx79IS26lS6OkuMVRwGXCWGiCLJlsgncBDbCF0SVwRXyP73UET2YcxJ7e
         IhV52OAwBPtAxnpVPdWkyLYEeiDslOFJ5xJUs8/hKWrHCd599LVHGBRXQnMglK8euy6I
         kh+m7XIN1Zlz1GVyIcXCIMAZU1SH7OCXvdQt1KtmOSL1HQ/GNCDtzwxmFaJquAK8ix/D
         XY1ZT6M8nRbyNUEINOofhlSRpIPLYLjfiK4qb5cpzGMN0RxQsSxNyawM+PwUSwZQYHS4
         rt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725867639; x=1726472439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSRoG8tK9Qzdn5ZF5Thjq6HAamLJOlkqFyKHUb902Ao=;
        b=CUkTKb/dDsyOgdyGexW4Kv3tbnha/vqvDS+rsicEGrZDdHxFcxTSs0cROmiwShJaug
         mKvP9BmNCAb6pG6XBkZrtfUFTE8qKxm8e0G3yFhLyKonHEM9AeIZRDNeJBqu4NuIDzYM
         MPEmf0fN2yukQwZKu+ACPJ7ZNRV05KBjNPNVzgOoxuhDqNq+FBIkAyA7MdA177gX9FxA
         6nsU3w0gYeEMT5KjlWii95pTvwEtGP5zz4zUqBT9216jMPPsoaYLikbW1TbGBpzAYunO
         QvCfpahWqs1knL3orSVZY1Z3aL5b8lipS8HUGfqxtk+cEgoC5VTibxBt9LWPMMMy5CxI
         d63A==
X-Forwarded-Encrypted: i=1; AJvYcCW66quX+frTl0lPu5VmW0EUFlDzbAOFiqCiy76m+GX0285KW9F+uf1IRqcdqttPDT98d8AqBPSRvOn4hdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Yp4fguKx5rIGkc7HDq0YIMCf38QjJAoEl9UJvzN/UTh2ksja
	lq3K3k+Os4n1N0lvWpfBnnJwQ6IQK3b/OWo4DFD+rHO/vgryGLn09mRmJkVchg==
X-Google-Smtp-Source: AGHT+IGQ/ZFD3mkNZDTh6saUtZfGvLfnY0CjLqXgpaKRFJwBWYtBgPQqa4vfHxZ3vJl18MzgOgP5DA==
X-Received: by 2002:adf:fa81:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-3779bd187acmr10031803f8f.28.1725867638858;
        Mon, 09 Sep 2024 00:40:38 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a73sm68386085e9.3.2024.09.09.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:40:38 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:40:34 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] module: Refine kmemleak scanned areas
Message-ID: <Zt6mcvkzPI8WNgHl@google.com>
References: <20240906153856.22204-1-vdonnefort@google.com>
 <ZtxenHsGPyDoYnzY@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtxenHsGPyDoYnzY@arm.com>

On Sat, Sep 07, 2024 at 03:12:13PM +0100, Catalin Marinas wrote:
> On Fri, Sep 06, 2024 at 04:38:56PM +0100, Vincent Donnefort wrote:
> > commit ac3b43283923 ("module: replace module_layout with module_memory")
> > introduced a set of memory regions for the module layout sharing the
> > same attributes but didn't update the kmemleak scanned areas which
> > intended to limit kmemleak scan to sections containing writable data.
> > This means sections such as .text and .rodata are scanned by kmemleak.
> > 
> > Refine the scanned areas for modules by limiting it to MOD_TEXT and
> > MOD_INIT_TEXT mod_mem regions.
> > 
> > CC: Song Liu <song@kernel.org>
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
> > index 12a569d361e8..b4cc03842d70 100644
> > --- a/kernel/module/debug_kmemleak.c
> > +++ b/kernel/module/debug_kmemleak.c
> > @@ -12,19 +12,9 @@
> >  void kmemleak_load_module(const struct module *mod,
> >  			  const struct load_info *info)
> >  {
> > -	unsigned int i;
> > -
> > -	/* only scan the sections containing data */
> > -	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
> > -
> > -	for (i = 1; i < info->hdr->e_shnum; i++) {
> > -		/* Scan all writable sections that's not executable */
> > -		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
> > -		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
> > -		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
> > -			continue;
> > -
> > -		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
> > -				   info->sechdrs[i].sh_size, GFP_KERNEL);
> > +	/* only scan writable, non-executable sections */
> > +	for_each_mod_mem_type(type) {
> > +		if (type != MOD_DATA && type != MOD_INIT_DATA)
> > +			kmemleak_no_scan(mod->mem[type].base);
> >  	}
> >  }
> 
> I lost track of how module memory allocation works. Is struct module
> still scanned after this change?

That section being RW, it will be part of the MOD_DATA vmalloc and scanned.

-- 
Vincent

> 
> -- 
> Catalin

