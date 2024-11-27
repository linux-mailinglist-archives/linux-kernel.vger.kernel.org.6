Return-Path: <linux-kernel+bounces-423441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5679DA765
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721D9164F20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FA1FAC49;
	Wed, 27 Nov 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URcUIMxM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4A1FA14F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709259; cv=none; b=EWzdOCk+jrHW/t0Bs1I2/kvrcRSmANqCm/gT8pDxx+Wjjz8MVWCnINh3PhlRT9GMP/wszeEBTuGEZiywx8KGMWfM5aXGEiykGfLkXTJvPu/iu6+tGepVzcCAdLQH0k55N2HAhxerZi840L02RFPz7X1a0IQGaRViZEWCJx9lXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709259; c=relaxed/simple;
	bh=0DAwBIuwfDFeVjAyyl2kiKCxxuWS8YClRsH5Rv23TIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq4r9XFcuT9Yj77SqWJfqxzVpfbbq3KlXeoyOEjI07/X4bSxmBOGms4+xsV+WRBGTUdayelLLE9OAhl2G/JbwXcU9i9UtIXXX0Ttd0vc50kw6iaXh8MTkyUTOBsV/Ejzv6Rc7M6JGU0DSTq8Hg9dnQ2OMj43n5rdlNtg9Eyds6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URcUIMxM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a8640763so13123345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732709256; x=1733314056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWm1TWYufvmfNpaeEtp42v64UUjDvzA4BzbXGW2BVf4=;
        b=URcUIMxM2JgU/l7fv0KICPc3EXgFW0pXWeyjfUsjvtJOKZF3nPYPRTAA9K9XlkOKfG
         53NiJ0TTt59eWldO82zD88rYN2xWAdQTUe7XrJSTHR8RE8Sc4tef8Far0cIckITXbZtt
         wYHLDWbbJp4EtJsRwtE9yb3Vl6JuHFho4yjKfXZ5QYU51nWT9ZxN78QdLpddbmX/aMfj
         sUfK08XdoWmtFYuoc/AnI6D1DkHZePEU+pOJ49E1XPIUKBIFHzpNAgD9aoIJNXwQj5Oe
         9KwAKYbfDYej3IJLnRZFS3sNlfc0MpsrUqopyPaZEiCKKBQLs49eNWH73LI0YUcWNvya
         bNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709256; x=1733314056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWm1TWYufvmfNpaeEtp42v64UUjDvzA4BzbXGW2BVf4=;
        b=N7/mtuhJEBRvI5idqJZqvTmeujZMBC3QBMZwX5K0789jev5a9smB4WX4MFBUWZCtcB
         35RZQg+seHNdJgFv8AvRedaIGkxKZKEY84bVRWvfGvERmdvFlqvlQT20eChYMi5bHgEh
         j7jHwv0aQju3IGB4tjOTm+R5MBY0xgtlhpbcIbcH0g9FKv51eTMdy7iK1r69A5YDgJBq
         O5EQv7NZm8czOcQifj4oPzrFR1xf5rUr2aSywdKIze7dF/P/ZQM8x4HRLdpxJwz6DZ/g
         s7jxEl8PcYDnTCSOByrBgru4BEa5ySEJrHleGB/bW8W6yl2ujIJSKt3uspo7ckL95C4x
         /OvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5Hddr8eNLxDsi8OAsxDfA1SQH8YaotAchqKEfS+T3xe+cO1v6QWbY8p9gCENN3vbMRTeh4eeySSGhfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVds1Lgg3d4o6NRiDItssOSzRzFcv8USJQ6UHtOdHvdV7o2uQ
	y0gU55iZGb1rx6y+cbTeXzNrz3Q2Tv0Jw3bVmKFajl8qvXT/spivo2qIcP1OEuYZ0AF5aphvTzt
	2/yIz/QeF7KJP9tB+oihU3GIbC4GOkw6HxQdh
X-Gm-Gg: ASbGncuJRZTBKzauAR68gjUmEJi5Htl1kKm/apV/VZQL6Fi+aeC02nI92Baf5KEh+pe
	Ke8zpCCZDLM52thdM8K7eyXWNszKe99GJxx21spu/lNR2tzc3P+xoyS4Kr4j26w==
X-Google-Smtp-Source: AGHT+IEU7sCQZACTxRM+APpfp1z3LglXVBsKbLEmt9jC3z9LLn6MH3hFnU0ce83BO+yNXFOxsujS3zXOPd85Sp63IP0=
X-Received: by 2002:a05:6000:1fad:b0:382:4b80:abc8 with SMTP id
 ffacd0b85a97d-385c6eddaf1mr1952403f8f.46.1732709256079; Wed, 27 Nov 2024
 04:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411271011.gFsgMWRv-lkp@intel.com>
In-Reply-To: <202411271011.gFsgMWRv-lkp@intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:07:24 +0100
Message-ID: <CAH5fLgiH+hu-VA4GTCWRaEBVXoENX36P16EQzDadJptNi=vk8Q@mail.gmail.com>
Subject: Re: rust/helpers/jump_label.c:10:5: sparse: sparse: symbol
 'rust_helper_static_key_count' was not declared. Should it be static?
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 3:38=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   b50ecc5aca4d18f1f0c4942f5c797bc85edef144
> commit: 6e59bcc9c8adec9a5bbedfa95a89946c56c510d9 rust: add static_branch_=
unlikely for static_key_false
> date:   3 weeks ago
> config: um-randconfig-r111-20241126 (https://download.01.org/0day-ci/arch=
ive/20241127/202411271011.gFsgMWRv-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241127/202411271011.gFsgMWRv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411271011.gFsgMWRv-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
> >> rust/helpers/jump_label.c:10:5: sparse: sparse: symbol 'rust_helper_st=
atic_key_count' was not declared. Should it be static?
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/mutex.c:11:6: sparse: sparse: symbol 'rust_helper___mutex=
_init' was not declared. Should it be static?
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/helpers.c: note: in included file:
>    rust/helpers/spinlock.c:16:6: sparse: sparse: context imbalance in 'ru=
st_helper_spin_lock' - wrong count at exit
>    rust/helpers/spinlock.c:21:6: sparse: sparse: context imbalance in 'ru=
st_helper_spin_unlock' - unexpected unlock
>
> vim +/rust_helper_static_key_count +10 rust/helpers/jump_label.c
>
>      8
>      9  #ifndef CONFIG_JUMP_LABEL
>   > 10  int rust_helper_static_key_count(struct static_key *key)

Can we turn off sparse warnings for rust/helpers?

Alice

