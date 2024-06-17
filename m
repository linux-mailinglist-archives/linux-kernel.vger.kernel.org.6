Return-Path: <linux-kernel+bounces-217697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A50190B316
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3A1F25CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3897D07E;
	Mon, 17 Jun 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="3ePdo4cD"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9527347F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633104; cv=none; b=Qs4cmLUSsvfWxvf5QRTFY+0ZcraALMDsxvYlriM3vMC9TUmK7dQ0JTLiuxjpQupxO5NPUCS5hUgznHeU+/XkuZ3IzyxGNry8temny/Xd+Ir21KwfNwzKObC4Erub9YWHQQS8powqPPtvNO0ueh+Aoz2JzzlZQwImnwe39H29iDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633104; c=relaxed/simple;
	bh=Zm/QwU2rpGsbu0eOFvD6iNkDmhJOG975MRanNZtbJZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fHEcArs1B0WMLJQ5kiO/+327/NU33MsPNAauMwHXK8t0YhBE93eGeM8YjJj6BrAUv+jwNaZGHnsbOalMaOxG/SU3RJb1m3hNLLuKJAbOXY2EQezua+EQb3c8kTW48VxxpoUs7fiBw7xQ/iAi+ldPiA0u9HKsLV8xKrI5KIeeVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=3ePdo4cD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955f3d4516so483277285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1718633101; x=1719237901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYuchBzcVq+nntl0rByVP4I0/xMFrP/odXfBrhxA/v4=;
        b=3ePdo4cDb1pLWtSEQnGyNZqYiC74GZ9aru+O2qwjphZCNZpj+e0HcyOHowQeC2vl52
         O7wPIr0SRo6teM4XqHcKVvMikmF9J4f7Jib4ZMXqMwf9UR1DiFM4C2gRfKy8/vaipRKb
         Km7kDMDz1tH569gYMP4jrifl/euglp/fU84jNK1Jr2hyS6JsNAXEPhj5nj8JucAw+zUL
         472lO5k9GzHFnP6z4YD7+SO7Jjw6dfmEB5IM9vntZR+aDkA6bfyeJSWRRYkwW0F6SN6k
         Oh5DTT7zhPBUV9xpcQoQoNBja0VnBnbMGI4jVl9pdAfY6yTMbrynSSLtly5AhtlSR96k
         su/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633101; x=1719237901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYuchBzcVq+nntl0rByVP4I0/xMFrP/odXfBrhxA/v4=;
        b=UVmkKfeZKz0VpzzAVdX1+/xPsYKgh/P8SFAwRmkKtONI5Hu39yxFjtwCmwXlKr3E/v
         CpPaNx9xtLKXn9PoAW685Af3fNiygA9dxPJFK6mlnnaaSEqS7aXFYWPMdM1hORZhV3Pr
         1V61eD7qIUKPpuiGjnGjEO/JrGb4KD8Uzl4hqfhHO5EoAz2PfZ3fQAsoFYScxUUbD81Z
         C4q1Sse0l67oYCJa9qfg+REWMT4/w75w+LKdneWC1P25w9rojuQdzqTOiMEjNEjithuW
         vxB05LGlpqNcKMs0wwlYkbpKt7xdRUbXjokOX6A2a0fKxZnD6oTosZzvbQZOF0z0VF5Y
         tlLA==
X-Forwarded-Encrypted: i=1; AJvYcCWD7bQsE+6Hcqu1RF+hfThFfn+eJKwX4Y7HAhJyHqzpslHvzrB0+5cIRC1UdGgW92hX8SgQtr7++vPUpfj/HmEpCXNo2Dt1npl6YZB7
X-Gm-Message-State: AOJu0Yxb1u77+nIxGkD3kSpBFGwE6frjgeEoqLpWDu1vK8pnHxnk2unP
	qoaUWr2RFCXHCgT+3LUE7Jy4C65N98seDS1Uj9cvumxzuPGWU8un/Ivy/DGF7+k=
X-Google-Smtp-Source: AGHT+IFk6OpTSQ6HI1XE/Anmj9+FlmPZSHzWjQ2P2c9rtwWOS09Hy7PV7JVncckLBidfUl/d/TkDUg==
X-Received: by 2002:a05:620a:29c1:b0:798:d789:c494 with SMTP id af79cd13be357-798d789c9c6mr1428684685a.29.1718633101025;
        Mon, 17 Jun 2024 07:05:01 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:15:57da::7a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe6a973sm429001985a.128.2024.06.17.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:05:00 -0700 (PDT)
Message-ID: <f295f41ef1c9ee920ac3ac8e70ccf672ba7c9648.camel@ndufresne.ca>
Subject: Re: [PATCH 1/3] media: rockchip: Introduce the rkvdec2 driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, detlev.casanova@collabora.com
Cc: alchark@gmail.com, andy.yan@rock-chips.com, conor+dt@kernel.org, 
	cristian.ciocaltea@collabora.com, devicetree@vger.kernel.org, 
	didi.debian@cknow.org, dsimic@manjaro.org, gregkh@linuxfoundation.org, 
	heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev, 
	mchehab@kernel.org, robh@kernel.org, sebastian.reichel@collabora.com
Date: Mon, 17 Jun 2024 10:04:59 -0400
In-Reply-To: <20240617094735.27928-1-liujianfeng1994@gmail.com>
References: <20240615015734.1612108-2-detlev.casanova@collabora.com>
	 <20240617094735.27928-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le lundi 17 juin 2024 =C3=A0 17:47 +0800, Jianfeng Liu a =C3=A9crit=C2=A0:
> Hi Detlev,
>=20
> Thanks a lot for your work! I try to use rkvdec2 with chromium but it
> can't play h264 video. Here is the log of chromium:
>=20
> [5799:5873:0617/171224.850061:VERBOSE2:video_decoder_pipeline.cc(473)] In=
itialize(): config: codec: h264, profile: h264 high, level: not available, =
alpha_mode: is_opaque, coded size: [1920,1080], visible rect: [0,0,1920,108=
0], natural size: [1920,1080], has extra data: true, encryption scheme: Une=
ncrypted, rotation: 0=C2=B0, flipped: 0, color space: {primaries:BT709, tra=
nsfer:BT709, matrix:BT709, range:LIMITED}
> [5799:5886:0617/171224.850915:VERBOSE2:v4l2_video_decoder.cc(182)] V4L2Vi=
deoDecoder():
> [5799:5886:0617/171224.851218:VERBOSE1:v4l2_device.cc(128)] Open(): No de=
vices supporting H264 for type: 0
> [5799:5886:0617/171224.851346:VERBOSE4:v4l2_queue.cc(1069)] This queue do=
es  support requests.: No such file or directory (2)

This one indicates that V4L2_BUF_CAP_SUPPORTS_REQUESTS might be missing in =
the
REQBUFS implementation. I suspect GStreamer simply assumes this today for d=
river
exposing stateless formats (which is fair, its not a compliance test, and w=
e
don't have a codec compliance yet).

I'd suggest to check and fix this one, and retry, might only be noise, migh=
t be
the main cause, we cannot tell.

> [5799:5886:0617/171224.851426:VERBOSE1:v4l2_video_decoder.cc(476)] Initia=
lizeBackend(): Using a stateless API for profile: h264 high and fourcc: S26=
4
> [5799:5886:0617/171224.851687:VERBOSE1:v4l2_video_decoder.cc(598)] SetupI=
nputFormat(): Input (OUTPUT queue) Fourcc: S264
> [5799:5886:0617/171224.851797:VERBOSE1:v4l2_video_decoder.cc(636)] Alloca=
teInputBuffers(): Requesting: 17 OUTPUT buffers of type V4L2_MEMORY_MMAP
> [5799:5886:0617/171224.867687:VERBOSE1:v4l2_queue.cc(1511)] Streamon(): (=
OUTPUT_MPLANE) VIDIOC_STREAMON failed: Invalid argument (22)
> [5799:5886:0617/171224.867902:VERBOSE1:v4l2_video_decoder.cc(937)] StartS=
treamV4L2Queue(): Failed to streamon V4L2 queue.
> [5799:5886:0617/171224.868009:VERBOSE1:v4l2_video_decoder.cc(1377)] SetSt=
ate(): Error occurred, stopping queues.
> [5799:5886:0617/171224.868105:ERROR:v4l2_video_decoder.cc(120)] StartStre=
amV4L2Queue failed at Decode@media/gpu/v4l2/v4l2_video_decoder.cc:915
> [5799:5886:0617/171224.871898:WARNING:v4l2_video_decoder_backend_stateles=
s.cc(126)] There is/are 0 pending CAPTURE queue buffers pending dequeuing. =
This might be fine or a problem depending on the destruction semantics (of =
theclient code.
>=20
> Here is the chromium code failed when calling VIDIOC_STREAMON:
> https://github.com/chromium/chromium/blob/125.0.6422.60/media/gpu/v4l2/v4=
l2_queue.cc#L1508
>=20
> I'm running chromium v125.0.6422.60 and I can decode 1080p h264 with
> hantro g1 decoder on rk3588.

Are you using minigbm ? Because if you do, we don't have minigbm code for t=
his
driver (and have no plan to do so, since we don't aim for ChromeOS support)=
.

Nicolas

>=20
> Best regards,
> Jianfeng
>=20


