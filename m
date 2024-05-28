Return-Path: <linux-kernel+bounces-191863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2538D153A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D0E284A89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCB7346B;
	Tue, 28 May 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="BScC7aYW"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407073465
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880753; cv=none; b=bybUH865kxbocA1IbLP2cfSH3Mm9RZFfrAgH+mweTZCbI2JVB7gllsmAXtZAM21ondvo4Ww8RSxUqMdK18ONR+c+LLOGLH1gxSrVY/rNuZA4UhjzTt+1Nwso1Izv9Hy9AA0SBjgzvNd+U9HUp0Ux+GPwwO6AEEG1CR6EjdBlAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880753; c=relaxed/simple;
	bh=kYF5IHcfckC0APtkdja1Ko0BdMw5bz3HKSZAuIfw6hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwGUMyWFjNAzzh/t5mPMu3TctRgIGan/qmPUettsks7RqZn2Xo3AbboUO3R/RBj0y7robCjrX9tF0S3m6U+C8W8utzvW5IXZ6H2ztJkCYhB7Ugnrc409aw/dhkIdMK47JxV8UnD3p2owfm8lXo7SLIxNdfKzWWs7uQpDWLK1mbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=BScC7aYW; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b53bb4bebaso302103eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716880751; x=1717485551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYF5IHcfckC0APtkdja1Ko0BdMw5bz3HKSZAuIfw6hQ=;
        b=BScC7aYW+pWEr+qyvBUu7rIL+dfHBF7G9E3ZTNqxbE8aY9Ckid1yxyiEMKvfRTmTOR
         +7YW42PjkuMmD132/MXED/ZiMITE1SCaRzihRTP7gwAUOKVCrLCjj6rRrhPWEzMebsDM
         8P4p4YXeFIAbFjOT2ToDGKeLIYvPJt7kMFIDHK3lpugGJXRLOfhKIiyx6OGNMyCpVN20
         rtbRJLu+rxEccJzU7Um2xnarGDlN/9QqYyFGdOrYDVXJxDfQi+KdjdQ4mbUnv82rvCmL
         SxVUJ7x5t1HnMImzO/aN6GfyA3KznD42WfPorVEi1MkZD9h6/VYu+Zw2oVPoWyILTUBa
         viVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880751; x=1717485551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYF5IHcfckC0APtkdja1Ko0BdMw5bz3HKSZAuIfw6hQ=;
        b=UU7Id9pEO4qf3OaxORnC8oWKfdMcrOXfZgUKbRUCFO0nKY86+C3WfVC0Ro+5Fpap3X
         qTc2CxDYqP0vJz8OA64/m0g2HXVvRyQ5llY7dIIH1SqUu/FOpr3iFROQ/RNtTUv08gpA
         YzhXs9PXWh8a5TWAdGMi3QVDhmwErbRfz0Pmdg4HJB7QZXpoPNONFcHJWZwnwGQfnvU7
         1m2l/wRY0dAp5hcYJ8tQ1dj7RO5C/GLpJr8+myQg8TI5DNYao9tfbguPaHyahw3Ljcnb
         tgDnnWZXXUW7e/cOo1T8M7KGfNjP2qlI40FVz037HgF2+QJwq4dzHjO2eaHUjasIOrD4
         38hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSP9ZRlu/VkOJjHItcYoHde64PW4Ma/CWW3zE3DLopKFe1fJVc1k7Rbu9mxxBRPTlU0pL0GTUEeWvrXJBT308RJSLAuaxpVpKtqLtU
X-Gm-Message-State: AOJu0YyGuZESsWiZpFYIvuyqG1vK7xYPL0JegpHAw0/2KVjPmp6zLt8Q
	0hObxn96fbNEBJL8+XaxqW2VxT3HHofK+037roRUn5cEUIctCbD26iCUwUnslk5pFI4dnu7lQR9
	rAj0=
X-Google-Smtp-Source: AGHT+IE1aKv7uBgkS/HjzlS6fWXXb4CP/71HeAZDAtaMPcQF0udrzy88blNjX1GxxNNrobvOvqeWXw==
X-Received: by 2002:a05:6820:1ac1:b0:5b8:75ce:1787 with SMTP id 006d021491bc7-5b961fa50c9mr12941975eaf.6.1716880750833;
        Tue, 28 May 2024 00:19:10 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c4afb24sm2095340eaf.12.2024.05.28.00.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 00:19:10 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1b7ad2283so265819b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+FR+5n4k1FLdJR1pMrGYRWSYppYa+vvtX/UNhkOgrWRZc3nz9uOMpKLotnWCQNti1d+dQcF3v4UcybmrjDTplF69s1cIC2wOoCZSo
X-Received: by 2002:a81:49cf:0:b0:61b:3346:eb60 with SMTP id
 00721157ae682-62a08d87da6mr111183687b3.22.1716880416501; Tue, 28 May 2024
 00:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
 <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
In-Reply-To: <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 28 May 2024 09:13:25 +0200
X-Gmail-Original-Message-ID: <CAAObsKBdpoGF0B9XgQxbG0P4JXAXSdLLdhzhrdAkt7J7rtCZ6Q@mail.gmail.com>
Message-ID: <CAAObsKBdpoGF0B9XgQxbG0P4JXAXSdLLdhzhrdAkt7J7rtCZ6Q@mail.gmail.com>
Subject: Re: DRM Accel BoF at Linux Plumbers
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, open list <linux-kernel@vger.kernel.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Christian Gmeiner <christian.gmeiner@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>, 
	Lucas Stach <l.stach@pengutronix.de>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Cancan Chang <Cancan.Chang@amlogic.com>, Jiho Chu <jiho.chu@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Alexandre Bailon <abailon@baylibre.com>, 
	Dejia Shang <Dejia.Shang@armchina.com>, Toby Huang <toby.huang@armchina.com>, 
	Chengkun Sun <CK.Sun@armchina.com>, Cai Huoqing <cai.huoqing@linux.dev>, matthew.bentham@arm.com, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 2:12=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
> > Hi,
> >
> > I would like to use the chance at the next Plumbers to discuss the
> > present challenges related to ML accelerators in mainline.
> >
> > I'm myself more oriented towards edge-oriented deployments, and don't
> > know enough about how these accelerators are being used in the cloud
> > (and maybe desktop?) to tell if there is enough overlap to warrant a
> > common BoF.
> >
> > In any case, these are the topics I would like to discuss, some
> > probably more relevant to the edge than to the cloud or desktop:
> >
> > * What is stopping vendors from mainlining their drivers?
> >
> > * How could we make it easier for them?
> >
> > * Userspace API: how close are we from a common API that we can ask
> > userspace drivers to implement? What can be done to further this goal?
> >
> > * Automated testing: DRM CI can be used, but would be good to have a
> > common test suite to run there. This is probably dependent on a common
> > userspace API.
> >
> > * Other shared userspace infrastructure (compiler, execution,
> > synchronization, virtualization, ...)
> >
> > * Firmware-mediated IP: what should we do about it, if anything?
> >
> > * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
> > that are hurting accel drivers?
> >
> > What do people think, should we have a drivers/accel-wide BoF at
> > Plumbers? If so, what other topics should we have in the agenda?
>
> Yeah sounds good, and I'll try to at least attend lpc this year since it'=
s
> rather close ... Might be good to explicitly ping teams of merged and
> in-flight drivers we have in accel already.

Good point, I'm adding a bunch of people to CC, but I will be for sure
missing at least some, so I would be glad if people can check that
those that they know weren't missed.

Thanks,

Tomeu

