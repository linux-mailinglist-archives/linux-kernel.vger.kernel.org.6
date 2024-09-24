Return-Path: <linux-kernel+bounces-337015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD798442A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF261C22F33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C21A4F08;
	Tue, 24 Sep 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aevtzSmy"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43E1F5FF;
	Tue, 24 Sep 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176055; cv=none; b=vGg+DTQXcVUjHtOTwt0x0nqAxE7LecdbizjektX82a/PfF1mWHBcogaAVo9orszp4Obp14u09eMkofcWXfUPSpWnr2XjP2h3RIhG+yypH2z9+JosbdvGosN6BECMhvoduWdc0qyG7WhogkT0brc1bvmbf7tiFt2XIfd8wnBwV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176055; c=relaxed/simple;
	bh=vDlY6jpRSj+T7ZW8ZDZhyMjjU6W0gpKFuQ3eH2CfT9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C12DAW73p8AcAd7K9nPQ2mBmKfAlS/+ZrnoJQqX6H0swKZ11m1Z9pXdqSWqxl/Vuil1Et8FihQMCByvb/U+LSaGuZIAvmO8NdhrNqUDATa5rZhQlfWYiReWNCfNLBNaswtURCRV46gizyebxjhPGkvDObGgh4SOE6tKs8qSUw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aevtzSmy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d43657255so845249966b.0;
        Tue, 24 Sep 2024 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176052; x=1727780852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDlY6jpRSj+T7ZW8ZDZhyMjjU6W0gpKFuQ3eH2CfT9A=;
        b=aevtzSmyc+OLPRWfZa2T1uJ/cxB4pGl2HFcbi2nb2Nm1lvQUXMgR23NZ3BkxHxXDpr
         fuNuMc7U36KoMT4ZGq7ahbFeFIbVlBhCRxAtIAH3A9SalZwr2tI0ZOsQqfHF8dXkfsAR
         Yoj3qy7srLFLywwyFT90IGuUHv67cqjbmGRpRijPawNS5O5HbMEoEnVKof3mpx5J+TXK
         BrqyK5X02EsM2HBniMipGhGUAiuXMNDXTMEPN0yAou1KkcAVyETr/Jd1uYDNkfmUgkt7
         Ke9rk+GZcGQtdjgD+BlQF18Jm9UpQ7Ghn+412b/YhojcP0mRPkhLQ3bXOjM32aZCLqXl
         7QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176052; x=1727780852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDlY6jpRSj+T7ZW8ZDZhyMjjU6W0gpKFuQ3eH2CfT9A=;
        b=fyjnK3yZiq/mIz+FSQV22Pwyxni91VF235wOpKkR0IhGNwlG2pYyyHHoDCRYspC4RN
         z6TxKvXdauWhHBGGfBcxiNp6P/dh70e1JTOGAAexm1T+peFQsfwXLP0+09rqVpFYAefj
         qShvAgUA06o/86EvcDnOXyJFYATzoA8HRNXKkmsCNt7eLvDKWLIgvoUSTV1wt6l4/SNm
         O40PCildzwZTb7iJnGdcGSmo5Rk2oaMAWobp5KBULc71KV7g5LhBZrIoVe8Ipf5Dv0Ia
         BsUnApFGA3vsxlHSNYZAacKrRp9/hlezL8YcJbBUUtlyCUxUIEO2FzS/PkSw2fANPBmd
         lemg==
X-Forwarded-Encrypted: i=1; AJvYcCUU4y04kPJpV5lJjn36RXL1yGAWovzdBK7Dht9s7o9h4I0+hOICte11tMbXktYKL6gC3AmHNLLWcaco@vger.kernel.org, AJvYcCWoKBDIiaIVywuf8rmj6usdBkdirtZCjxhq4iPwlE+R0U/pGTi1UUNaFpZkJVJ1KQ+o4cymP9d7/PDkHroM@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfcsSr0ExoZfjxKCZOqoa+o/W+9CxBx1orJozdeSq5PGhlnkx
	A3nMfIUzTAmti03vTYciZIqxAn85o3eTvnGuCwGqdbZT6Aakvd/W0lGmTMJpcIXtS0DXCyDBYEl
	gh4AYqXqD/tzXciZ21AcfZGP+r5s=
X-Google-Smtp-Source: AGHT+IG3HdsRc7QM+IEwBYc/UDvbaTCxK9b+KAf5uClMdu8Xw/sPwq5oksTAoaulH/zR28+iDEGNfb6BD1GYhNSiPoQ=
X-Received: by 2002:a17:906:99c5:b0:a88:b90a:ff30 with SMTP id
 a640c23a62f3a-a90d50d6ee5mr1627389266b.50.1727176051720; Tue, 24 Sep 2024
 04:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922174225.75948-1-laurentiumihalcea111@gmail.com> <20240922174225.75948-4-laurentiumihalcea111@gmail.com>
In-Reply-To: <20240922174225.75948-4-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 24 Sep 2024 14:08:31 +0300
Message-ID: <CAEnQRZAF3oDS8xas6+p2f--XduKvX+jc09=x52LFLf55EjC=Mg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: imx8ulp: add AVD-SIM node
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 8:43=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add node for imx8ulp's AVD-SIM module. This also
> includes its children.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

