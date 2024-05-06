Return-Path: <linux-kernel+bounces-170096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801768BD1CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E5285109
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D336E156221;
	Mon,  6 May 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPaGlfry"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BD155752
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010677; cv=none; b=KT9aVNuuHvh7CfxIqJ0HI0na/lQZkP3t+qWNjrVItPQ994aUThcN3wZujgpvNbYzrOxv8VWF/9yPxoOe0Tm2u9j3GgbFJ6Kg+C0hjrmgEHZui37mzaDuoWYfwTBKPIiL1D1JCh+/dmBXT6627an05zwJOTZz+Nkiz483OJenV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010677; c=relaxed/simple;
	bh=fmEi8zy2BYzKQV1pUEcAJYNE1lGiyqt68S/HH8iGNRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVwA8hdQICOFkvL3Le5vyhomribgjAdVztvBWIEt2p3AqS5F6d900NXdpylBFgxEJkSudWL4Bi8aZbz4zWpeb5iP37Di5qp8QloF4uenqGYCojWdkksrJgJipY95v0jX/MQX27DmlOdCbjoqQXAB/ZEq0+7cDPhmSfJQrjYdSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IPaGlfry; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so1462699b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715010675; x=1715615475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT0SnIs/02MaTW5fVT9bWl8NEc4i33rHG9BmlMKJ30=;
        b=IPaGlfryY4sMe6LVrfg/j2Omt18j/Wq9+68aZQmqiK6585g7gtdcYfZLE+oaItT6EA
         z0Rc4BtW7P89j4dZ18sGgQXdP1LxhCzZb3BI9Eu9sN3Gvr4zpPx4AocYCucbZaSsiAPQ
         /WC9gs9PBqNais7yaaoxuFJsvhpTvWNzWLB+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010675; x=1715615475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZT0SnIs/02MaTW5fVT9bWl8NEc4i33rHG9BmlMKJ30=;
        b=hIaQfHTV+alHdjadEMGqXlj7TaukhXPfJA0+3PFIeL0g+DsUByNOgbxCNg1xcW8h74
         /OgrqE6Q3CN46NcGsVvpFCifc0kd8LCDC0bBeqciB0AeL+nDq5tivqJ1yKj5iSoTZSak
         bjqzXvf+I8NM9hqT7qFgd4Ge8DsXM8cmZiD3/c2T09m745KWRMSuZYGTe5g/ZxatjX/N
         VaQFaT8PRs1iK0ZxIUzwNnQRlTa7EBD/wtyzmivVm8/lNi4m1VDY6liNL6A8zf4C/WqL
         Fpt8vKFKwtnhK37+NKi+65fi2Xik6dck+Q9qgmOItlgNX7U9KZSP5TuBpR/tzZxHfEgj
         G7xA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wOQj6l1cTD5/jS69xZ1mnhofOsl9cFhXB7bp5eZhPBxJTsdJGvRK3x0j8JhFFQvW0s2v/1L3Uf+CrcBTyu2NQ7xmXa+Gn1NNVeHz
X-Gm-Message-State: AOJu0Ywqny1BJDLwi+hnQEYCwjx5Btb8WxH3/DoGXLzFDeYeWbIB8CWX
	fQSi1h5dSGwV/P67S83bZGLcoURlyMbLtfAdWHSybWBwW1SQzGWMe8PeldW48Q==
X-Google-Smtp-Source: AGHT+IEqWz6K1mwJRhCqCbBA0Av6HQv0svI8UuMxadH0lzdvFFlLmeBRo6SluuH2wnsaFOE8YXXukw==
X-Received: by 2002:a05:6a20:c704:b0:1af:8bc4:c7b6 with SMTP id hi4-20020a056a20c70400b001af8bc4c7b6mr10767852pzb.53.1715010674988;
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f24-20020a056a000b1800b006ed0f719a5fsm7888759pfu.81.2024.05.06.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
Date: Mon, 6 May 2024 08:51:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Youling Tang <tangyouling@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] objtool: Provide origin hint for
 elf_init_reloc_text_sym() errors
Message-ID: <202405060831.089E820@keescook>
References: <20240430235106.work.680-kees@kernel.org>
 <20240504222402.p24zt6dc2zkyxqti@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504222402.p24zt6dc2zkyxqti@treble>

On Sat, May 04, 2024 at 03:24:02PM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 30, 2024 at 04:51:07PM -0700, Kees Cook wrote:
> > @@ -891,8 +892,8 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
> >  	int addend = insn_off;
> >  
> >  	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
> > -		WARN("bad call to %s() for data symbol %s",
> > -		     __func__, sym->name);
> > +		WARN("bad call to %s() for %s symbol %s",
> > +		     __func__, origin, sym->name);
> >  		return NULL;
> 
> Thanks for the patch.
> 
> That warning was already phrased pretty awkwardly which was probably
> part of the confusion.  It could be rephrased to make it a little
> clearer:
> 
> Something like:
> 
>   .cfi_sites: unexpected reference to non-executable symbol 'execute_location'
> 
> And ".cfi_sites" is already in 'sec->name', so you wouldn't need to add
> the new 'origin' arg.

What's so odd is that "execute_location" wasn't being reported at all.
Just ".rodata": 

vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for data symbol .rodata

But yes, sec->name has what I want, so I can do this easily:

-               WARN("bad call to %s() for data symbol %s",
-                    __func__, sym->name);
+               WARN("bad call to %s() for %s symbol %s",
+                    __func__, sec->name, sym->name);

vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for .cfi_sites symbol .rodata

I think the symbol is missing because this is coming from
create_cfi_sections()/elf_create_section_pair().

Regardless, I'll send a v2...

Thanks!

-- 
Kees Cook

