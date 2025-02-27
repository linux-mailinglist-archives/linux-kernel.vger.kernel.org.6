Return-Path: <linux-kernel+bounces-535175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD182A46FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25BD7A569A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBB4409;
	Thu, 27 Feb 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b/pU9mfD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F165322B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614685; cv=none; b=P2iTF28yNbEHOL60LHMNDzYU+VfgNYJnyvaulogDg/X13U/Ao5l/7910UlkFLPgIE+AI/XQhvmSwXIO1vsC2gDvBYwxymXYRqiQmIib4qt9DJa7i0LDP1JjCUONDSYazNWZoDqSLwgo6VJQ6fg5wuEtNPvKCGJ/OLvfyfk9nNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614685; c=relaxed/simple;
	bh=ebhWn3IvQK84c2iP54rZ5HLxq8SDs5x2uyrN0khsg8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIbxcWbC9rBRJxsAW5/iqNZ+95NC/uxijy+rbb/jpvnCZ9rGBVUittkAqn/hvBdIJkWdgt8eKdHu/yAicY6idV26MctmwWXiH2FMLmjo3alQInciO1IEmG1iuKaQ8YylnGeAE3IKf0Hm0n42KKjhu6imVdvFWoZCVH9PkfWhPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b/pU9mfD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso369801a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740614679; x=1741219479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=btG8mYMCiICkMqPGz84Q01oKttOQmb9UxH7nIH/qm+k=;
        b=b/pU9mfDlOt2QH672lGVJVO7hJBVfaUg1PGEHvo1TbqF99Oqw/aINduGqfvMFBU4gD
         JNI2ROkGgvet7/1PrKwRws5F4vgeB0aQvmCthkLZZzyWSEfEL20v+qtXRQHcHbhexC0f
         +4c6R/g1eHPn8Jk6PIJYPvHwb6br5Vdo/ARwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740614679; x=1741219479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btG8mYMCiICkMqPGz84Q01oKttOQmb9UxH7nIH/qm+k=;
        b=eun3/RmqTPmpa70YCnkkbKB+yUiltrbRS9+dMYpyUvrmNBjKGm3nk2rlSPiH43BSN+
         IbNt0An8qKMEdBC0DXr9Qgnyr7wBtqssRALI5quykRyBHvOCoY5mNkpyGpZQY/1XlsKg
         F5UBBwMryfView/bCNK6eYrW+IW4EnvAFUJqIMTEWYEApWsl66rdKyrfSIg37CBaV1iN
         x0vR6k2Fslhyiph5mePiFgR1EJE/xymFNle/mzxzvo3K22+Z71PJD53fekrx6Xz44E3k
         XHKRz5rXs8owBIt4b69jjcXYgY+dRIcdYN6lwOQr0+iELd2On6oAGLWqyNBR6IORb4o+
         AtOA==
X-Forwarded-Encrypted: i=1; AJvYcCVNJoLEyimtgxOpPz3BUtfH/kjxLhigodHDR33rrl54T+oycZjfxAlUAiBgWAWHrPMErNsrT4PAIzRr3gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uovhoTjF0BG+PQwsBIIrtZnKdgsjA4YEogrNZkx+znKJNPW4
	BapbkCg+ciTtxfpQ/8RdZUcOXxuaCDgaxFi8HlmsMObfGlKgMiY+6DCGXjlmZar8tZmUIKXkTvd
	z22whUg==
X-Gm-Gg: ASbGncvV5SbZttb4UdvRSjBSxxnMFNTgzo6whdN5wcei42uSnQKydb9WkpIFLdDBssM
	hFAkQjGbGfIdyYikP3itjGyc2i3HHQ+lhxLnvE+OZtp0C3xaEidU02EMJjTLZekeIUVOHJg6wlB
	1jTL76/mXpHOJLQNL8BEorrqTQTyW3vSeTjYArEeEtceuxctlfPQA8yNFL0Po4FHSyyS0d2Mo45
	isywz5Eh43PBiSqurJhOgfhDyIPHFllPyW/gXD6ArCfbGuHrgWai+3GZUX95dHTY3WVKEK5En0r
	dys35xjxiOqQ0PrAtDBknjnpJnbKCqix+YbWgeSMA3uJeOlW/zuEwT4UnvtgqnBmMkjPzo06M1a
	K
X-Google-Smtp-Source: AGHT+IEIzVo2US/TkMzlHwxSEVONPClmXonlu2aIaqE4+ziFVNaFA1UOazXiuFdf/lein6cpmJycVw==
X-Received: by 2002:a05:6402:2115:b0:5e0:82a0:50d9 with SMTP id 4fb4d7f45d1cf-5e44a254530mr11144440a12.25.1740614679626;
        Wed, 26 Feb 2025 16:04:39 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm226640a12.1.2025.02.26.16.04.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:04:38 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb9709b5b5so52783066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:04:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH44puffKzajkB5YHtVGPWCHhjd99PIrxvX3OwyWVIRrfeAOW6N23frjX29ALvBgDNlO4OPN5rKJLakSI=@vger.kernel.org
X-Received: by 2002:a17:907:97cd:b0:abc:28a5:cbe2 with SMTP id
 a640c23a62f3a-abed10fa38dmr1141732466b.55.1740614675833; Wed, 26 Feb 2025
 16:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home> <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home> <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home> <CAHk-=whvzK6ugXhCdrTfXnkFR+u_+sCtwz4aDODJ_h-RJ3kOKw@mail.gmail.com>
 <20250226182809.5027e483@gandalf.local.home>
In-Reply-To: <20250226182809.5027e483@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 16:04:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsAoXTR+7=SxHykUs3zYzjSkY8Up2MDpjJF_PK8yVYQg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr4t0-VhZe9fJeoxS_YfOncjbgQB41_Y7QaZ9cZa_P903tC8ltOlxJUG6E
Message-ID: <CAHk-=whsAoXTR+7=SxHykUs3zYzjSkY8Up2MDpjJF_PK8yVYQg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 15:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> My point is that the compiler is free to turn that into:
>
>         r = READ_ONCE(global);
>         if (r > 1000)
>                 goto out;
>         x = r;
>
> and not change the expected result.

Yes.

It is safe to *combine* reads - it's what the CPU will effectively do
anyway (modulo MMIO, which as mentioned is why volatile is so special
and so different).

It's just not safe to split them.

        Linus

