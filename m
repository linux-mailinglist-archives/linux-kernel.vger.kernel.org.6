Return-Path: <linux-kernel+bounces-231399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C760919844
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838621C210E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D5191473;
	Wed, 26 Jun 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="MXyKsdrz"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111ED15B7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429978; cv=none; b=e1a6cHzNONIC9+R0NKuVLKuzpkAOlv6eWK897mvIwkCw36QlVEvzUmrxT1ZqDfxCIMslcF2/Jn6RaiczoQy0bH3gNwFoHfNTFatz+WSJ3INhXuhBmYf8Qt1ull545R3riRaW7MGSiujxxtA2iit9q1DRwO2oRPmLw8/I2LqhpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429978; c=relaxed/simple;
	bh=GVl4BQ6sqlR4mjMHtG/aBZ04wixynHgTyVj8qKUVA2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoWnKPppN+osd2PmKoGk261edPxnB7oQUWlaerBOCRq5nkwQDeOmFSjleNfM52RZdSTTPuZhsYawfETmNw+4IfLSSu7UH8ANpJNKLtNJwRv4ljRI+gkLLMk5EqgRPfKxomkxIAtqqaAWVRKzqoh2YstSUTkMW69dwUgRbEFwiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=MXyKsdrz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff0712ede2so6776551276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1719429976; x=1720034776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVl4BQ6sqlR4mjMHtG/aBZ04wixynHgTyVj8qKUVA2Q=;
        b=MXyKsdrz5ZIOhr1AtpeEPYBI/+4JvC75ugSpqlskLxLxINIWcuYGemxysPaJsMngnM
         q259U8xN1eaJ5y2+IL5WPHHksHysveqwlwTiO2RFisH0Z+1H3bnAFRpm8l2djjflvO49
         WuToqhne6YcjCmA7R80Q2vM1g1yxP7r0kBkOHaXqj3D3MKJxMF3lXVEQVsRWmVC9RGHf
         ATttALM/oh4QnwgNDx7gHXgpQeMHwfdC7SAeX/tcDdZWSp13WCYAbH6okTmHM4SAis+r
         7da14cxaNiCVMhyxJhvHwbddOw8+MWN2moaFfXYIvs2pNjEsK9HIq/YaAXHDccnyFd89
         QrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429976; x=1720034776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVl4BQ6sqlR4mjMHtG/aBZ04wixynHgTyVj8qKUVA2Q=;
        b=tsMIXNZZ5KBxuj5lzWnt94xyWTgEpiKPnXBap5zHv4+d5arbvkLyhTqS7XFmVnG5zg
         qLu055xHky7biqt4vDPf9CZaHWiGLs8uRVbazPZIZ7tQcWRb1EW9PQpR/44vFHDUPDsv
         9FY/QDv889vbn/vH7Nyihy7i4KSdgBqusWY7YGP+vXIvFnRg1zGAu6v0GtsFe8ia7Qvv
         lI3t8Ma41BlWD5MUphg4+ZMQ81z6S6qIdYir+EoM+XIpDobSXqaKfl7LBfQ3Ad5v7YXM
         mahUp3tGSDgClWuhUKvB72I9vEsKEfLFprDOUsObQfI74GBTQGirlxZg34rYF9cojBfH
         61oA==
X-Forwarded-Encrypted: i=1; AJvYcCU3AWO9Gc+7S8sSrzMN0c0mp0HtZPb87ra9uHnkhIqHAFQ2deiDsESlwxDwfl9xwPk6tu9eFMEytiMoOtZkTB0+s0qoIbwdRCNTMP6V
X-Gm-Message-State: AOJu0YwLixh/+wks/OWEmhh2PdC9mhJ2nWCw+g1vRpiKP/0zVYwbp3ro
	A5dURb/GKro/xaXJ7jzSwuBPBnLLwemM1q9XRaScN9t9Om3Vmjm3+33uwQDcr4vFxqXffBq7rlm
	Xks42V7G56lrEtp0T9mHXZIoqEA3x7Baw1zvihQ==
X-Google-Smtp-Source: AGHT+IFt9KNQizJBtwoRXxWdC6bUl1zuw9W0N9wHHiqYCJjNt45BiH7o0/gvXjy2ppmL5ZWgdXc1asVtAQt+LlPdi30=
X-Received: by 2002:a25:b2a3:0:b0:e02:be9e:ba8 with SMTP id
 3f1490d57ef6-e0303ffb60cmr11195525276.44.1719429975867; Wed, 26 Jun 2024
 12:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local> <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
 <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com> <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local>
In-Reply-To: <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Jun 2024 20:26:04 +0100
Message-ID: <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Daniel Stone <daniel@fooishbar.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Daniel Stone <daniels@collabora.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 18:52, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 26, 2024 at 11:39:01AM +0100, Daniel Stone wrote:
> > On Wed, 26 Jun 2024 at 09:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> > > So we are kind of stuck here between breaking one or the other use-
> > > case. I'm leaning heavily into the direction of just fixing Mesa, so we
> > > can specify the type of screen we need at creation time to avoid the
> > > renderonly issue, porting this change as far back as reasonably
> > > possible and file old userspace into shit-happens.
> >
> > Yeah, honestly this sounds like the best solution to me too.
>
> Yeah mesa sounds kinda broken here ...
>
> What might work in the kernel is if you publish a fake 3d engine that's
> too new for broken mesa, if that's enough to make it fail to bind? And if
> mesa still happily binds against that, then yeah it's probably too broken
> and we need etnaviv-v2 (as a drm driver uapi name, I think that's what
> mesa filters?) for anything new (including the NN-only ones).
>
> I would still try to avoid that, but just in case someone screams about
> regressions.

It's not just etnaviv, it's literally every Mesa driver which works
with decoupled render/display. So that would be etnaviv-v2,
panfrost-v2, panthor-v2, v3d-v2, powervr-v2, ... albeit those don't
tend to have multiple instances.

Anyway, I'm still leaning towards the answer being: this is not an
etnaviv regression caused by NPU, it's a longstanding generic Mesa
issue for which the answer is to fix the known fragility.

Cheers,
Daniel

