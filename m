Return-Path: <linux-kernel+bounces-364515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AA99D59B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4FDB23555
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C591C3027;
	Mon, 14 Oct 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQkuyJpa"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA21BDABD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926997; cv=none; b=p4lznztD6+omzktMX2nS+QFkEMEC1I2Nt0ZAqNw4MIdHGLocOHz8yXdpLddzFPZLEp9O0vHhVkoIYidcoP8vPFdFdqfOKEreqYlKZ9fuF5ySSYSDtiV78yVPTgT3lcqnuQDaBFjxGnDRYu03bUK1jat60Y7KSnDHtS+sv9hRrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926997; c=relaxed/simple;
	bh=CSNMcFDDijo4DbM019qkbO66k2XIx9LLGy8ogcn3trE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvBk4zKkHBCS09Hrc2nmYDzzDXgWbhjs+AyLWnqt4LuiwZdRnf2Fwo5sUROXlhxQuxTd52SMBtH/9Mh8/xvB5rRI9NNhQt47V5Ldg6JTQmwJZM5kBL4j8gxRcvjWmk62cB0EavFP4Q+sMDu4yb5GkeGWsg7DspQQzcJsM7NybB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KQkuyJpa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a01810fffso239394166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728926993; x=1729531793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvsjTSFhK62MPvXHA5L9zbPkhQe3PYzLzcOgzWx9lrk=;
        b=KQkuyJpaey1t0ZAJigEbOBg7DLEkWgBYwh/nxtuk9laSaHZz+NSiIvB0jl9n73xsm3
         LVllI5HkbKsBZT0fJ0TYBqrxuPUY4ZMHLJGE+NFg7IUGJHBiPO0wcrdWrepXbaFdsAyv
         cX5WCwFV01s7UBVJBeXzvWr9gh5t5a9X8HqCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926993; x=1729531793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvsjTSFhK62MPvXHA5L9zbPkhQe3PYzLzcOgzWx9lrk=;
        b=GVTEgqAwwPjQDUwn1cLYcUq67+8NeZlZ+kl5h4PG/Gf0trltIi28+YvNMdTnX1klQl
         HQTbhRCJOYPxa89F2ch2sHTkb7eQRDCp7+OAWvz40+pi+sFF1utWSpmak9IRv5l7pqd6
         isBuwStnn2949xUpuXfpTfewo+oPO6DZza92aHNtiIlU6ur1QXxcAk7LALNx1NcfJ2OV
         LjpOx3SQzmdBcS40vySc560KFOJiMxDXhDjL+4ax7jnV2UTQDrJXTEw2xiwbrVaQdQGU
         iwfQ/auW/lRUPkFC+UNGUVn7e5mMqDngOvWrahhCO8XQb1a4oTRFkDYu7Xah1RUjw57O
         zwkQ==
X-Gm-Message-State: AOJu0YxMRLLmV1MnRdif2uTmo4l3bl3LIjfMIpDsbfdzrk4pXXRWqwvq
	5zen8UEprr9kixhckzFcowL6nWgzRM4M2F0uJ4z7OCZhBSLzgo/umbt9iFvx2aaiAstSuntC8xY
	JSIKrkw==
X-Google-Smtp-Source: AGHT+IEthVhU31roBJIYPA3Q/ez9Ng8iT5AloxOJjrbdAVBKW3ac3Xx1qWynoKesHdzxdmdW62prtA==
X-Received: by 2002:a17:907:9452:b0:a99:379b:6b2c with SMTP id a640c23a62f3a-a99e3e3f8f9mr786188366b.42.1728926993373;
        Mon, 14 Oct 2024 10:29:53 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f2536984sm349496866b.10.2024.10.14.10.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:29:52 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99650da839so792393766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:29:52 -0700 (PDT)
X-Received: by 2002:a17:907:3f23:b0:a9a:a32:bbe4 with SMTP id
 a640c23a62f3a-a9a0a32bcb5mr437123266b.12.1728926991727; Mon, 14 Oct 2024
 10:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com>
In-Reply-To: <20241014125703.2287936-4-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Oct 2024 10:29:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
Message-ID: <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use dot prefixes for section names
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 05:57, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Pre-existing code uses a dot prefix or double underscore to prefix ELF
> section names. strip_relocs on x86 relies on this, and other out of tree
> tools that mangle vmlinux (kexec or live patching) may rely on this as
> well.
>
> So let's not deviate from this and use a dot prefix for runtime-const
> and alloc_tags sections.

I'm not following what the actual problem is. Yes, I see that you
report that it results in section names like ".relaalloc_tags", but
what's the actual _issue_ with that? It seems entirely harmless.

In fact, when I was going the runtime sections, I was thinking how
convenient it was for the linker to generate the start/stop symbols
for us, and that we should perhaps *expand* on that pattern.

So this seems a step backwards to me, with no real explanation of what
the actual problem is.

Yes, we have (two different) pre-existing patterns, but neither
pattern seems to be an actual improvement.

           Linus

