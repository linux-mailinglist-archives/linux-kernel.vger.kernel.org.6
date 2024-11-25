Return-Path: <linux-kernel+bounces-420542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F99D7C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8A16321B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE6161320;
	Mon, 25 Nov 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+nBbfYp"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40614AD2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521109; cv=none; b=CWPOIZZPeIxqLpzVgMSt0GZxNuhlnX4j7mNhZYRNBCuveLmHUoqcYKD3CqqTVF2Vrtpt36gTJcibdyeE3ny1a7Ara97Zx6tpwBntDEGP6dbbYG6p8Tw9cfTcBSVUHKJo9mV8tmNECFGpBW72fKk0TlAP7MLw2ouekL2hVV7u03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521109; c=relaxed/simple;
	bh=rVtpEO96pPW0BdZDEbTuzmLhsIyuF9StiNZje8p3x1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oepg1IneCTnnn4ixgpKBBuHYOXAkYSLdVEu/J4XQvl9w9c6D2fj4ITcpdAN2ZfzidqY2LkAAd1/lTVGgZ+KykWLlg4rAlmmCjCddKOUGYTq6AxF5tXZRKqaz8Z+LHEfASF//4h6YIq715j/b1+n3BLLqxK/gebZ+mlqLeFsGdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+nBbfYp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso592932266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732521106; x=1733125906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HseCuxVcgTTpliTcRhjccSaoiUYsiM7w60CZwC55taM=;
        b=S+nBbfYp7PBkrithu98siH0KTN71pR6BScjRszhTXmHPRMlUGThIxgwkMWEkiGSz3d
         rL2+Dsnybg6N8+xREBud2Vf4h8HNklxsWiKBglpytdbSctGXXeM/NcZBCjuT7Oqzr1fe
         iGaAEKzqu3VO3dYbH2Lqo4t7CpwITbQGN9dyAEW5x+klQkNIfVTB4l6smKiwFPWCjwi0
         pYLEkj83btcQsJZJw6AntcPdL6z8xfPs4WiOuZsAar+uzoleWKK8N7od8epUzvasiH+q
         KWcyfQgBdp3l44x1B9FcRnnNura//T5KiUyA7nZOLxamnCRWFWks8Tk8NzZuZ0I0wxiM
         vB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521106; x=1733125906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HseCuxVcgTTpliTcRhjccSaoiUYsiM7w60CZwC55taM=;
        b=v1DGcHRtgK9hkqQR01pzKL8ivzSSyxIJc87RdI6nazmnVCD3s8kSXeXBvwBP6V9x7o
         vlcrA6x/dI3PAXZ9A1rlfW0vvlqUtHo82Nei38Yezy0nAW6w6fr74jLawjMzoSczoYlT
         kHXcMPhWMdElAhbrCZ2kCopG52wMASJvFFcr7GrKzBBGTApiFVsmvnMUGABZdlMuZ3NB
         Kq7W4M6FayYx/k7JfIKegdNEpuZht1S2rP8boFnwTWutm6bCd+GeGfC/AQse4GCOBNmy
         p0X+0u1sKKE0kQOniS4YcTzLR+O0sUFbALccr9U5aQXdbccZWUSo/1/5t0ZtoIep/uwT
         Vx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHMzeTbMZmBmomFph0Wz+tZTpYryJHtqdKkx9cT6DABDxMIIILuavjmcfAtuu2IoJwPQdw6sQHUWoevW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLax9cZoYRNq2doFuIucRGgeKDu8W0JxvK+o8V4zqpn9xVRWJD
	eQ51TNzXJBfWfa/hDRjHRvvJSiNvOYctXvJ3MmUEeYAbRJFWw+nWDLGm5iMhrYd0Uz1KGeiP1JA
	hYQnzUzkE8as3ByMKnBXpMy+gmDo=
X-Gm-Gg: ASbGncu6WPpq2SiKpfMQX6hV16dPElVJgg5x18OaSy5mdDmXnrFStYCyWRv+9F/nObg
	wsnOD0io1aTK/c0L/0iVV8rhOTDVC7VE=
X-Google-Smtp-Source: AGHT+IErwpMqN0sd6ADDPNbcLBIAW3pMNYH7sBc8m/479mXRYyIOd/NUmzu3eps1LMnCEJhREs7F9fQCqO/Cj6eVZ/g=
X-Received: by 2002:a17:906:4c1:b0:aa5:c1b:2203 with SMTP id
 a640c23a62f3a-aa50c1b22a1mr797032366b.42.1732521106154; Sun, 24 Nov 2024
 23:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732368538.git.chunguang.xu@shopee.com> <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
 <20241125072400.GD15647@lst.de>
In-Reply-To: <20241125072400.GD15647@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 25 Nov 2024 15:51:34 +0800
Message-ID: <CADtkEecQ=vQZB+gAiG9peeqfAcMpLkQF=JFCHVxCF3k_ZAWN+A@mail.gmail.com>
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 15:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 23, 2024 at 09:37:40PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> > the code and avoid unnecessary call of nvme_tcp_stop_io_queues().
>
> Please split the behavior change from the cleanup, and explain why
> the behavior change is fine and desirable.
I think what really change is  removed the unnecessary call of
nvme_tcp_stop_io_queues(),
as we have do it outside of nvme_tcp_destroy_io_queues(), no other
behaviour changed,
inaddition align with the code nvme-rdma, so it is easy to maintaince.

>

