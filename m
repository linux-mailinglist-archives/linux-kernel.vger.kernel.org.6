Return-Path: <linux-kernel+bounces-258155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF2938478
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E7B281544
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5315FCEA;
	Sun, 21 Jul 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWN1tpZp"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616D2BB13;
	Sun, 21 Jul 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721562061; cv=none; b=qt9iT4rwg6XAmXSV+aSiYvkFuX+Ea85MYtM4IxW2LSIJWpYRefTOLNeb/HB+hCaaahzvzJoLp0FvguLvzBjrhdb68g33+9h64fET0fK2k1+5m7VLffuCl/4OxBDWh+IMWXPw6MY3LW6Z8Fo9Q0wqwtvZP2umUUUfhQEfZ71INkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721562061; c=relaxed/simple;
	bh=Q+EyK5KSVXoDYojQseP6uaAw9ms6O/Cd9wFUQCgWJuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LorEiQ/j94cWAAc3LyNiSoYZKcoN5w3M3jidL1mTzJtWbakpYZNFnvIwlIG0Arq+oONJpDh8ww7P0JantxpxxRHPSV12h7JXb+BxZ38ITLUx0DP9V+iSASRkbPDCPP2/QeAdCcG9juOj86FQSca4Ffr8oQl3lt4OI5UQ+NRJp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWN1tpZp; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2610623f445so1520018fac.1;
        Sun, 21 Jul 2024 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721562059; x=1722166859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+EyK5KSVXoDYojQseP6uaAw9ms6O/Cd9wFUQCgWJuA=;
        b=DWN1tpZpIK7gc31YiVARCXG1ZFnab5aiBkoUiYbzf2LiOb8imw1cmAnA9odnC/PgM3
         +7QAPXVlb/sr62Z6jOEnKjxn0Kav/l2e2WljEiamkZhGkFZMCep5Q+QXhFF6TKnYeN2S
         ym7q2DUdR7dxL2QYQAbxcF+I7yCWTq0wbNMryCV6/RioWJsGw2qrWe5hCPE3h9cnmpXj
         Ja5ido3TWI1LWwYZYv5K//BMfvfOaxlB9QOh0S54vv1kkTTZI1fOzwCZnScALVOSRiXV
         fZXxkC6hI3vL0+Gb9gq91Y6S+NRo67SUvsBClE1eHlSffi5Fx6r/ub63pjwEtHX/kW/1
         8B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721562059; x=1722166859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+EyK5KSVXoDYojQseP6uaAw9ms6O/Cd9wFUQCgWJuA=;
        b=tM/crO/6LOVSHkNLTZvDvYey7a+rUY0wwAybppTz3NXTia2591uQj5WhHriWJA7EVD
         s32mZz4x2h9pfmQxeWvejy0+PRX+W122bcms1uKUFfVtr2DlS/ZgPQF492rrgOMW2tUH
         ND7C1guplS4VXk0c7h4IlGrXp8evq0gfLq40NTyAMFsh4Js0FEN7R4z1Wp9aCpaH32hO
         niW6aKbDM/tV0Du0GixDSg42rCeqUYj/TdL8jY7cuqKY5LaD9zReOi/9Lhl55C3WSXq4
         Pdz6YuitiG05uPUaJx9wZN3tSAUxUOSPe3e9R92am08Zf8lr5gVia+ME0rdJlI5YsFT/
         g+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMB7oxkXq79sDj22CvotcuqvnB936HDyT5LmJjcoV5hKEuWfh5wwETIpRzgUCTyBz6xQPD972ary0Q6pKLZCrQMTM31lXJ5eyCwJ/bHFqNMDS8SYBtITvNhT1O5dxLcs6PYAXb3CegsdwuS21WqIukg/ZwOrpo6OFK/LxtUtKWc2Rk5Ccl
X-Gm-Message-State: AOJu0Yy81wrr4DInFjuls+bBO22xvDerekskCNnjiNtRnCeTsBeWYtj5
	RV1ly75VX9MadDVReE9OH1kCOmYS1FX3Ofn004nKJlpYJuc8D07iZ/Eh6zyiTXSm+AOpqAdWMqD
	wPI2zqtOBk+KIRTjJTgCcziG5nU0=
X-Google-Smtp-Source: AGHT+IHTBah8cNq3NdWznUVOIfFXR+nEtBvDOnHrlzv0ICb1QiXJ2G+KHa+o03Qbt8HTjzossc9zMGclNbnKTjzzTMw=
X-Received: by 2002:a05:6870:970f:b0:261:1600:b1eb with SMTP id
 586e51a60fabf-261214eac1emr4705877fac.31.1721562058704; Sun, 21 Jul 2024
 04:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720100848.203546-1-animeshagarwal28@gmail.com> <ac09aec1-0c42-4f8a-b4cb-64eb67018d15@kernel.org>
In-Reply-To: <ac09aec1-0c42-4f8a-b4cb-64eb67018d15@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Sun, 21 Jul 2024 17:10:47 +0530
Message-ID: <CAE3Oz81jhzAiwJXPiE4rQjD8TzBghugvA9sWV+Tb_kz9CdQyiQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,imx-audio-es8328: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 3:03=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> That's not a DAI but audio card / complex. Drop.

A reference to sound-card-common.yaml is required instead, if I'm not wrong=
?

