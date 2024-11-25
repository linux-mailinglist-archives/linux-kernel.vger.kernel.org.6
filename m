Return-Path: <linux-kernel+bounces-420384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4360A9D79C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86DDB22794
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A368DDBE;
	Mon, 25 Nov 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CVuzn8QU"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87C8BEC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732498006; cv=none; b=A3QHwJI9Mow8mcgAHKAvSo2Z6evvb2cUjF2Id+F3Hno2Ph7DhuckP+V5TmIqABS9D8PJLW2BeeCy70qqv+DC2k2gt/aDD+kwnPUstjiGcgEmEAAR4nkufDew2Ap6Gj7asCU/9QO/FfXKDvc6RADgJ4muU5lY9i2L0E/WmJxUpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732498006; c=relaxed/simple;
	bh=mQBlwudP0DfgTUBOWsoqAJWn9pKuKv5wOYnWBD/F4ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gal15pXYVM8V3KxGE7GIdsTEBy/WKh6g6vX2qE1B9w25d49DOmntOQ+le/MaygZQVvJ5bcplUWktgIm7uG0M2Vl0IUqzPTEnV0/0xIxCkxyJti13N0K4zj8kE2f4BRq42bW5JB5Kg/hToff/bAv/sZiMbEydWi6xc5DVzA/KqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CVuzn8QU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de582163fso153690e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732498003; x=1733102803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieFB/E3uQUpwOL5elkCs1Fu1xJKYr7cXOoEikGe05FE=;
        b=CVuzn8QUF349aqn0HAAEETIfz8NBpU/pdoMbw5rjVP6QMsYSUCW2WP4Gri0GfAbo3I
         XdW14yMllXmTRq7dKVEoOFn6YR+MNMWugk3nkTJGcgIzXFVbMRX0U8ieriGIyzVrcv9X
         nI6Az/Xejr0FO+mRyvwqhuBijGhHLca6XU1aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732498003; x=1733102803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieFB/E3uQUpwOL5elkCs1Fu1xJKYr7cXOoEikGe05FE=;
        b=t5mgM38vblHLrBv5Kpdk8BnPlq8wIN/nDWCkmIjKI2/l8iHnrIwnHulrWn0CbbudMi
         NQAjnOuBTeZWvoRcHX6Pf4089HwQQHzeNFDfYzpkou+T3iPqV1KRSwcye8UKs9ABysdS
         wpkJ64iLP+Pb0/gXDfaZFGjbslSEA9HtC+T5fFbVDL6l0Ujek+IWqdbMqSGLhf140o3a
         YLu47TSOYGVZ1hmOJ1B5zeAMb3S166gmBWmd2mBC3Bj3ISgomgVlRgQ+NNNjU6fWDv1d
         c6npQ6iLGaz6NbvCB659vmG/POAw3AN6cAaKJP8Ymj4D1DVh6OiONhzW40DaYH+tIrPx
         zijw==
X-Forwarded-Encrypted: i=1; AJvYcCVH0yv6k5+qpQKNDy2RISCG84ZuwVJdlGkvD7y2vcv9JfnlR5zUT3uQY/bj0veDtkYxWO5JGPblUrXsJh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2JZYa9hnk/fk8xmR2ugQmZ4i8ZSiXBmbB4GzpGibpozutugQ
	foUHFKmvbWYeC6fltkHhwP7JNCZDz6ivw3qWf9nA1EugBzpBv2OOU1zTSyDttbTiFjMOA7bnJoz
	6MHJBeQ==
X-Gm-Gg: ASbGncsfvp/3naRS9lja4dn3ajws3ym7tJBbKyGUlEyFQRAFSYYqRP6oR2ta/H2o9ix
	XBIB9+KMUy5sWAAJqz9wmlcjDRf8MDguio4otbjv3jvVNSa7Yl2O0Gc+Qz4f51+LYr6OcF7ySDf
	W6z9foSKQD3D7JymATwdVU9Y82nMI9XF4v/ZkCYDwtU890j1BbZznmonCJwdgv7903nFUvzgs91
	/fQoE2E3OTZxom4Gfbi36tS926EyrGirJSg/8ih1avHEqQlD+IGNLefuKzUVLQ8s/HkYLBkL5sL
	CJluaj5eSExxhiS3H6fD6bvd
X-Google-Smtp-Source: AGHT+IHSMWJkyXR4slq35aDHKHpGYzbTgXcQvLolP9ysMc6tUTM/dABPT5IIj2mZu5LRGpgL1P13QQ==
X-Received: by 2002:a05:6512:3ba2:b0:53d:85dc:7c58 with SMTP id 2adb3069b0e04-53dd39b4a8dmr7663058e87.50.1732498002795;
        Sun, 24 Nov 2024 17:26:42 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53fc0f73asm186387666b.127.2024.11.24.17.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 17:26:41 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a044dce2so3675775e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:26:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDILFDcXEAay2c2NDTOQFkC04N+ICsXP/KS9VPtfWOy+Z6eFgp20H0QgxKCA94XC7sWRasObRBQ4IsrfQ=@vger.kernel.org
X-Received: by 2002:a05:6000:42c6:b0:382:5070:53a5 with SMTP id
 ffacd0b85a97d-38260b552dbmr7674736f8f.22.1732498000442; Sun, 24 Nov 2024
 17:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs> <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
 <Z0O8ZYHI_1KAXSBF@casper.infradead.org> <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
 <Z0PPl_B6kxGRCZk7@casper.infradead.org>
In-Reply-To: <Z0PPl_B6kxGRCZk7@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 17:26:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC9fB-Fq=pZQBDC0nZBWkxPRz-R95vbKjwHmSyU7Ex3w@mail.gmail.com>
Message-ID: <CAHk-=wgC9fB-Fq=pZQBDC0nZBWkxPRz-R95vbKjwHmSyU7Ex3w@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 17:15, Matthew Wilcox <willy@infradead.org> wrote:
>
> I literally said that.

Bah, I misunderstood you.

Then yes, if all the writers are always in order, and you don't
actually care about exact time matching but only ordering, I guess it
might work.

But since you need all the same barriers that you would need for just
doing it right with a seqcount, it's not much of an advantage, and it
doesn't give you consistency for any other kind of action.

             Linus

