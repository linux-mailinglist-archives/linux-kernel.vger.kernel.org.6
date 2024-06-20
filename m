Return-Path: <linux-kernel+bounces-223397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C46911252
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7816E1C22FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DA1BA061;
	Thu, 20 Jun 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="L45gmfK2"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AB1B581D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912385; cv=none; b=So/bEXRTZxStqEOQp/7vgy1zwedPGqqyRzsltk6UvhTNaGiEp3/wFGUtjAd+jyYrUtBz+0jgXSfTKH3lEttQuQltG5TMXAmVVHbFZ9vwTPVa+t9HYls27LxSjb9Hs830R8ebUCvMSlhYlv3QxEx7sPbVGq/bVB+pNdsUooeD2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912385; c=relaxed/simple;
	bh=yCG4889P6sBEqQekLOYYbsBVgi2xazE4U587EpbpMiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYXJVuVH9Oxn5as3XRd/T5Dsu7BFgm3w1dFYakmG1uI7EDlfJ+v4AA6+3+sc+heRX0TMwjRSrj8wgiKpqEr2N/ek/35VY9Se29K7AJTz1990dqamQrfdbAYmxsPLUZtjCvdOYnl5EiMwphLA+BW925cX1GlxgyqKV0hTsJZwu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=L45gmfK2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d229baccc4so674563b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1718912383; x=1719517183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVPLtuShufVqL2WCjpTc8rDVep4hA7cgotqlwBxgDE8=;
        b=L45gmfK2e9vUbjopiho2Rr+/HMykcLPtQmhz0X6kPvce8kwZkh+stuo4flUnxJkPzR
         eC7QnJlpoJ5izVbksOQhJ+uiZJOBVwkgNl8DyPkmTCfq0KVwsn3szzmWXwoCYvOA320P
         W2EVDo2t1BaeD05+snY6ODs+L8pcpOvNQWR62/Dv9qZy9jORGrsylW9H2xO3k7xajwWo
         xBy8GhBsFj9KlxLtcRotfBaq8ndscoV7kJL3GdqjilNoMUEYivHa90SjbUxAQaUjlpbH
         QgkAqkerxFEUG1jSw6yw1mvWlvdI7kR2hINfGONaEMtaMYriSBPB1K3+Tun5KGEyS/EZ
         N63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912383; x=1719517183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVPLtuShufVqL2WCjpTc8rDVep4hA7cgotqlwBxgDE8=;
        b=R108ZBmLCc5bJAx+KhuN85OKkl5YHTy8B9j81Lgz7WBCfpdGvxhE/FR8EJyUEjH9qN
         uXyCyjfu2gVy/rzpd7igT6aTsW6K/fPT2uu0rlIQByVFNoVVq043cCZ5LXkH1w1NJJVp
         gjDD/InT+N1pfI7yOJUZY8r6ZxirXNV7AVKrJ4BXZvCnZp4qTLhXfEFF/oAt9h/V1LzR
         CeFvetJViD4VG2kH9QOUAGiWehyt/KaWFvqKpIYX7EvQxV1YBJt7ojskKCEh36KU9gBv
         ayvzzSY7YVZDaLREDDEfG0Lj0kcH4NmGsJ75vu6xN97Arsbxni5SJk8a298YtjUBCgaL
         k8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXupdu24zRErTAOOZpUvSs7R0qx+rxnNzsEEvfxgvniTcoyVdvS6jmqLbX0+U733mTJSG3Lr8yJ4cBtgDY3H4tx/reljqeWvXTN//cA
X-Gm-Message-State: AOJu0YwmRV66Ubd5aj+CgzfZxMwArXDEPorTRe+c5yozMf62UBvNODrB
	vqAFtbUxZXRH4E4jE8Y5WV5lQeEiEZ7yfcY4IrRHQSUD8yBMOZsJ9MY+sKksSbU=
X-Google-Smtp-Source: AGHT+IEaK9J7/frv8gK0LaWNtaMRBnzNtHqmvVCsYQHf1z13p7M8pNmPXqLPyAWQ+uIHjvEuKMCEXg==
X-Received: by 2002:a05:6870:d60a:b0:258:38d5:6518 with SMTP id 586e51a60fabf-25c948e3e2amr6593718fac.4.1718912382995;
        Thu, 20 Jun 2024 12:39:42 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:6d4e::580])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce933e28sm3775885a.120.2024.06.20.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:39:42 -0700 (PDT)
Message-ID: <0d5f4addd82729cdae08740c80b48f01ab9681c4.camel@ndufresne.ca>
Subject: Re: [PATCH 0/4] Support MediaTek MT8188 Media Data Path 3 (MDP3)
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl, 
	sebastian.fricke@collabora.com
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, amergnat@baylibre.com, 
 moudy.ho@mediatek.com, u.kleine-koenig@pengutronix.de,
 chunkuang.hu@kernel.org,  p.zabel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com
Date: Thu, 20 Jun 2024 15:39:41 -0400
In-Reply-To: <d31f18cae640095ca0704185f8238184c13cf93b.camel@ndufresne.ca>
References: 
	<20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
	 <4e1a8383-fdcb-45b9-b3d8-7019ed8c07bb@collabora.com>
	 <d31f18cae640095ca0704185f8238184c13cf93b.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 20 juin 2024 =C3=A0 15:37 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le mercredi 19 juin 2024 =C3=A0 11:23 +0200, AngeloGioacchino Del Regno a=
 =C3=A9crit=C2=A0:
> > Il 22/03/24 10:28, AngeloGioacchino Del Regno ha scritto:
> > > This series adds code to support for the MDP3 block found in the
> > > MediaTek MT8188 SoC, including the necessary bits for mtk-mutex
> > > and platform data for the MDP3 driver.
> > >=20
> > > This is mostly compatible with MT8195, with a few differences
> > > "here and there", with the former having less instances of some
> > > of the MDP3 IPs compared to the latter.
> > >=20
> >=20
> > Gentle ping for this series getting stale.
> >=20
> > The soc bindings and commits are already upstream (v6.10).
> >=20
> > The commits that would go through the media tree [3/4], [4/4] still app=
ly
> > cleanly as they are.
> >=20
> > Should I resend this, or ... ?
>=20
> If 1 and 2 is merged already, a rebase and resend makes a lot of sense.

Ignore this, I see Sebastian did it for you and sent a PR already.

Nicolas

>=20
> Nicolas
>=20
> >=20
> > Cheers,
> > Angelo
> >=20
> > >=20
> > > AngeloGioacchino Del Regno (4):
> > >    dt-bindings: soc: mediatek: Add support for MT8188 VPPSYS
> > >    soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS
> > >    dt-bindings: media: mediatek: mdp3: Add support for MT8188 RDMA
> > >    media: platform: mtk-mdp3: Add support for MT8188 MDP3 components
> > >=20
> > >   .../bindings/media/mediatek,mdp3-rdma.yaml    |   1 +
> > >   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
> > >   .../platform/mediatek/mdp3/mdp_cfg_data.c     | 280 +++++++++++++++=
+++
> > >   .../platform/mediatek/mdp3/mtk-img-ipi.h      |   1 +
> > >   .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   1 +
> > >   .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   3 +
> > >   drivers/soc/mediatek/mtk-mutex.c              |  41 +++
> > >   7 files changed, 328 insertions(+)
> >=20
> >=20
>=20


