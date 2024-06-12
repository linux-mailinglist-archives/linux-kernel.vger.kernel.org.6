Return-Path: <linux-kernel+bounces-211126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF69904D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F6287D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789416C688;
	Wed, 12 Jun 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="3Y4DHdeQ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766B4696
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179385; cv=none; b=juSMM9anB+ZkLAMOMKFIhEm7jeTcsgfgudFekL9tfs4TeEaWoLLGFNsL83Zb/AP5F5WdzvEGvXuZL9PdpA0lF1kurJaf50gsjMMy9EMa33e7HZzxU/ko2SP6WarLqgPytzztxpPvGogEBrpSn4gL16avgNIOCoAgtzB5pAHRGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179385; c=relaxed/simple;
	bh=oZhvy6kkbKYCk5v6xkrBCIcY4DF51uW5QFIx01DmAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOiSPXmI6u9sepOV6wooLMIfqDBs4PyEZQydlb4ZCQOfu/wkjuDib8E9a77ZDGamN5ypqPRtwGWB8r/tAGk6SiZCx56T90kxdOh6hwPITw370Zg9meTYvnh4yBVwwa0kGlBOzv1decKegNMdJjbXC05GBumirxqRwkvry4zaRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=3Y4DHdeQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b063047958so25028236d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718179383; x=1718784183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZhvy6kkbKYCk5v6xkrBCIcY4DF51uW5QFIx01DmAzk=;
        b=3Y4DHdeQXtPkZ5hp70y6YIwp1yaSi3QMjJKn1BSGUxTdLUy5r7hty7Ih5ewK+K/rHy
         /Q8+gO03CrVScBzLNsz+wc919MfFLZbbReyRQKr6oXZE4m+TlG/o9yGaTlGoEVRlEGkd
         tdtaQf/tJEHK2qAhqgxulimP8CUWRTwIwUCDo+MwpkGcd8rkNR4rWkk8iFIIEKBFKd7V
         R9WsR9GFvg/lMnDa3t/WrQoPZZytJ/Eaufuu3WHxCUO5TqrJkf/tvESNQZR0ibVZuXlV
         BoNZ75jCj0yIbFL2SD1e73NE1szeH/TSDEomNI/pCt8+LPMNRJvm60jvkUB5Y+0NsQcC
         5FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179383; x=1718784183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZhvy6kkbKYCk5v6xkrBCIcY4DF51uW5QFIx01DmAzk=;
        b=HWMVo9DrgtQb0rRyTzkY+V7X8UM1ennT+T3tOlvXD6YWcF1Dfw+RQz4J0JEfEtSOBg
         CeF4RDRVZh6wajy1cMtPPE+s8vQsoU1uPNuv/nruAH5vyH8tZ+XvRmXlnQe+iygiNkSr
         YrrhAwkABc0KgIZl1sd6GPHGR8lD6uTMfpZHwe1Eo1qi/BfS8wtw/yu9Q/r8M1ANMriV
         h1JQ715+CJqZjnutWs/3id71/ceQp3YZtlmICPLaeTK0w6z1hE89YX/1YpR8V94GZ9xk
         N199SIXHZ+9oc+9q6Zu2K2sm0jWGNEwDl+flCoxkyO5588+/EcY+xFMIaBwkvfLmGRz1
         2TDw==
X-Forwarded-Encrypted: i=1; AJvYcCVdMTfvbPG9OoaCH7N3A+5ruC2SXWYu9t1LMe2wk0CpqqJK1sx5wjlNKvsljrtCGq+mKhUHDHN/95co5/B8DgdL+KVf9jlGsyRyO0Jw
X-Gm-Message-State: AOJu0YzGOpOTQlsFkMjP2eNFhq7f+DEld/HolA84X9CtPoQSv/bBlme8
	qBT86+tsiPlzn0mPWoqlbkBq+fRWgoerypKoHl5Jp6REcd0jTBTiaMySePZwbSyE1EVfRiluAZX
	NZYRqL54SWW6UmuKyAMmtMMDUtRGv4Ut66yeOoA==
X-Google-Smtp-Source: AGHT+IFBoGLGnRCfXUTT6MkmXv5tkb/vW4wlOs2DaIN1mKJ7KPlKywflPDae5tbSNQuiVC2G0raN2IzC+x3zhZJMYtQ=
X-Received: by 2002:a05:6214:4606:b0:6b0:77fb:8f16 with SMTP id
 6a1803df08f44-6b191778bdbmr10576316d6.21.1718179382867; Wed, 12 Jun 2024
 01:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com> <1ea92ff0-7e2d-4a9f-bef4-d50fc93b86e6@kernel.org>
In-Reply-To: <1ea92ff0-7e2d-4a9f-bef4-d50fc93b86e6@kernel.org>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 12 Jun 2024 10:02:51 +0200
Message-ID: <CAG+cZ07jpi0dobjf8JYt263qqy1tYWAvzsV9cgKaAW05mBoCeQ@mail.gmail.com>
Subject: Re: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:18=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> I do not see my comment about DAI being addressed.
Were you asking if it's a DAI? yes it is.

--=20
Piotr Wojtaszczyk
Timesys

