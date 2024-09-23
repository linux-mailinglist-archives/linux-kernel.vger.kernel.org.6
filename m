Return-Path: <linux-kernel+bounces-336253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6AD97F119
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1D22829AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D26433A7;
	Mon, 23 Sep 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MwsbHa/z"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC76BB4B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118465; cv=none; b=VMNHVisc5I8pAXf3llwiENNkOKk7d2PHAqOI6ZMaNYcSsuSJGuDosRqqqw3kNLxg3BQcpkaoYoARK+pZl0gmLZLHAcBPY7h0uV9OXWq3+NXUlC8M5CZp/r8vH5mV5ABLJ7ml31DQ+NWiFOa4Kyn2242DnZ6AK9wm9PosEvR28L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118465; c=relaxed/simple;
	bh=6oA7gDJzUeZfHw/vFTOmEelPMtY95bHTlj5TQt3Oydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC8+SG11F0EluNniZLEl4AAunYO4GQj13pONoAqF5sVx4L3ASI2udrGLg7gVAtOwFHHnruZMw3liV3OxfbZzCYXZk0xPsJV5t2ZOZ6YtA4/sh2RtvS/9xiKOmq1dB9LY+kR04fJ+ml6FcfLpFnoidJcPYVu6gzovcZbxqBxiLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MwsbHa/z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365aa568ceso5463959e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727118461; x=1727723261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJ3u8jesj1qGHjIV/QOFO/xQy5KMIpe78wId6CJClM=;
        b=MwsbHa/zS6VVHi1Fluy3pvzmtUaIrWRL0z0nUgG9tSJGIhDYJHIgo9SBn+jS45ECjd
         Dx5aPQvjrZ/Jnaq4sYK6iUZg26okakppkxmpDW9jgJYFhGpd4s6FwYrYjeL8OVNtIz2h
         /7NgstlMnZAuzmAac8+5+Edai6zwLZQ5w2UK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118461; x=1727723261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdJ3u8jesj1qGHjIV/QOFO/xQy5KMIpe78wId6CJClM=;
        b=duiNKTel6wvShrgHJXNfTPYtHkbrfm3QSRHKYTRXt8650zR0Cy58usD+o+YkqIZ4Kc
         EHMuMRW+xV/8O9cgnDqhmHsxWowfvPJMGIB074UUmygpgQc3szfaNVtK1kkMNVA2j9Sc
         kCfKvezkm7O4DMdW2RoU2Z5ZOeMw4iEaoqbBG9ybUS37+rb+CPjrutkIksAgFw+KhzyO
         JUCd9rQBUUjObujnnXVtmu7ufgBRp4G1/AUl3/yNRwhw4OfPnSF4l8yiBuVko1je5rOl
         Y4usicwkC4dBXPRl7OuHWb7p/GNiXwl3fqLydRzWZN8K25zydkojAXvPCk6OKkd6IYtY
         +UXg==
X-Forwarded-Encrypted: i=1; AJvYcCXBgSkDzvcJVAVy/tCIytAD3cvCkiaBzzLFl+/eDQw6w0N6zzVdEXV0mWcfZ+Cc7FajRnwG4g0yImfKvM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nufVibCrc8sr+2/i7WX+49Fs6bhb0OCfXiv/1t6CrS2tYrWg
	IMRIhO1w2dj9rLgz7Jl/PFb01oiV7P05HZZw983RDNoXLX7HOFi0RbtQyqhR84BCYWU6PTrInv5
	KP9I=
X-Google-Smtp-Source: AGHT+IGY2CeRrT/PN8O3924QqaF1quHhAhqQstc1A7xVk9Nr6f1Hl8w1ahaem/uxJP4IkjlwrBUmFw==
X-Received: by 2002:a05:6512:3d0e:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-536ac2e5a42mr8347064e87.20.1727118461465;
        Mon, 23 Sep 2024 12:07:41 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a91051e5244sm226443666b.109.2024.09.23.12.07.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:07:41 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so60850335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1Kdgn0Fl3viIgNYQ8gd0LccAXTxdlPT5qKWmSRKp6csAO28ENKD4RmZxSr8g0R5a1giSvQH2LNgTnBPc=@vger.kernel.org
X-Received: by 2002:a5d:5e0d:0:b0:37a:4713:3de5 with SMTP id
 ffacd0b85a97d-37a47133f2emr9049324f8f.26.1727118460522; Mon, 23 Sep 2024
 12:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm> <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
In-Reply-To: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 12:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
Message-ID: <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 10:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > We're now using an rhashtable instead of the system inode hash table;
> > this is another significant performance improvement on multithreaded
> > metadata workloads, eliminating more lock contention.
>
> So I've pulled this, but I reacted to this issue - what is the load
> where the inode hash table is actually causing issues?

Oh, and I also only now noticed that a third of the commits are fairly
recent and from after the merge window even started.

Maybe there's a good reason for that, but it sure wasn't explained in
the pull request. Grr.

                 Linus

