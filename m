Return-Path: <linux-kernel+bounces-338088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F9985338
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F60286730
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76C15687C;
	Wed, 25 Sep 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBdQM5sd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FC156661;
	Wed, 25 Sep 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246980; cv=none; b=NNMeIG/tbup9qtHmuw1+1hMoRsr71rnKxf3F38/ESLJU3nS8JDZdTbI/oFW1lvDzKnDa7ImEvsWzfvZpYCH7rOTytfmRWXTUSlmKEi0uA6BIAQoQd5cZx0lngUC2p7cN7VdUlQYOtktXgDdklrkZTqn7k7Inx1/59OBj+e9+yqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246980; c=relaxed/simple;
	bh=kk0Mt/+Hyj4BQOBJfxHEcKPbnwRr+BiwB73GhiBhJzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdz84cM4tvmrLCGNrxB+in7qFMqZXY6brOatatFcHUP2UR+5Xou/Vd7cCZgeRg6tf2FfLKMCUeTOGYnuK/RYxGY20xf4oWqwkCrxV3lFWU9XlqdS5O0gyPBLta3kDoBbA5e7rduV/uQkG6OMBABfHbBKhuppynGW2UmkwXbwEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBdQM5sd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2daa2262so813145366b.1;
        Tue, 24 Sep 2024 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727246977; x=1727851777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk0Mt/+Hyj4BQOBJfxHEcKPbnwRr+BiwB73GhiBhJzc=;
        b=lBdQM5sd7SDm45Z7utkeeTelriQ/HvtPDDmml5SpHVPUml+tXFR/5PE4HCVhfKVeOg
         wgdFd6iJHBmophsQCSHR/rqjK/nGojRsOEONXyFf8yGEVGTNidtoCkYQT9Z0nUspp0rv
         mY+8Dz17irJHG48+45YtpNXAoR7pZHuCZiIgWv6dSECJVEgR/CFOhQRzOwCffqG5e7E9
         jdVmQBejgRuEMmmyDVR0lJeqabLeJXLrf1rafFQ54Ck0NdaNZi6g2b9Hch96feYkNZXT
         KmrGR8inQWuOucWrUIUSFaSlZkkFwkWKoVzL/AQsiQjjPfhkJWl5xfq2GNXUfD8pXPgY
         5GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727246977; x=1727851777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk0Mt/+Hyj4BQOBJfxHEcKPbnwRr+BiwB73GhiBhJzc=;
        b=k5y4wOiyKKD9kP0G/gH9SDXzkP79iabCUiWS2+QHg/6wVddjklYcV1B12KOtLz4nRD
         M25GcRtNRmV0EfRPpehYs3nWQPdwihF4lLKXVRgEQygSJTmaifrHtTe8ylUTsBPXOnLQ
         n2ygT92yIYEliZ1lrSerPA+/chibb7327juNCs04qjAyB8xtPzQwwsixQzAWZWTTotTd
         CDGf7FO6VKUGfw5V3FBlbBQmhG4opKsMC6KiR7MEZXPZarpUM68XtplNK7O+MH2+Jiou
         Q0NrcXOuKJ2uElfWyr1zPn5Z18yDYlMIuPpfps6IZKjNcdZqwWoMlmHYydWTyAaIT6bN
         /t2g==
X-Forwarded-Encrypted: i=1; AJvYcCUHUHWxi+4n1+imXFDiQOa1NPPVFkoZqbZIGPNdoqX9ueeuoSy3DYz4WDntDuhQ3irSpgkvqnUgQf9bVN8=@vger.kernel.org, AJvYcCXb/zLVsw5+SMnKT+mDKslMU04ORPoVxd64W8to7laZgP7EeNOSRcykeSuU+Ne7392gIeyOumgDo4PirJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2pA5gN1FPiNSVOjCUhjOzoVD6A/TV/tXcHh1NIF2Jq0tF88v
	5r4K/bBpfv6Pii0f6ILLX1WiXitQSOe4OQiXGUVQIxBtmt4UIBQ1/SIOuC2AGnz1OKbBi6u0M2l
	73rSYAs077j8z/Q0HE7Sq1csQQYA=
X-Google-Smtp-Source: AGHT+IG4EhVNx4ZXTlcmLKwxSpAi+1Cc6wEcJlS0M5tzYd1bPulq0A8B/RQMJgdldFEu+s5xV1faX8OGR4qz9F9spEc=
X-Received: by 2002:a17:907:c7d5:b0:a86:86d7:2890 with SMTP id
 a640c23a62f3a-a93a05d6507mr137992666b.50.1727246976510; Tue, 24 Sep 2024
 23:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
In-Reply-To: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 25 Sep 2024 09:50:35 +0300
Message-ID: <CAEnQRZBde3AV7Dvu-jtXCTbZnBg60COdp7eheSdyfE_6mP9GQw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Use maple tree register cache
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 4:59=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Several of the NXP drivers use regmaps with a rbtree register cache. Sinc=
e
> the maple tree cache is uisng a generally more modern data structure whic=
h
> makes implementation choices more suitable for modern systems let's conve=
rt
> these drivers to it. This should have no practical impact.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

