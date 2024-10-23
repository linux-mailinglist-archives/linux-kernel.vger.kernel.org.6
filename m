Return-Path: <linux-kernel+bounces-379009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069769AD897
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347AD1C21E42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE51A2658;
	Wed, 23 Oct 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3o2pHVi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BB158858;
	Wed, 23 Oct 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727113; cv=none; b=utCiDRlz+4gfCP9RixuZ0cTfU4kCdmBesjhsxZIPqJ4rXQLMHPRketReqgHV9+EDlWK0z9a8REuS6Cy8SfLdwY3pRTJjk0nmYvdtizCgWTXymnRwfbm/1/hWWb5ITZZz/EDRKFyw2YUiE4zbdM3UPdSH6agjjQ9NIsIgV+d1UmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727113; c=relaxed/simple;
	bh=fzf50MUZplBxsUpuKQW50cchRIYkDdV0j2dgIHJIcLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRmoWCaTJ2HZ22GuMPW9P9++W1hWuEl6kUk6+r6QgEQ8Q1n16d5m3/OTMINAEDWg+FWqEC8/AWllaabG2ElW5sMqqfdphHoQn8rApzifZGhUJJtvqQ09AyVKYDeD9r9PKDLVw9rgf5QyGydwTEeJMVutFSsCXnG1sSSGbJtLq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3o2pHVi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so267227e87.1;
        Wed, 23 Oct 2024 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729727109; x=1730331909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH7t34m9dnmNlx93O1yGS5tEDefFHyWRqMdXdmIkhjw=;
        b=h3o2pHVihsnldWuvhsYLSfb9/ijTsKqM/KJLbnMG3n3dXKJRKo9F2wM87aC3l+O7kc
         5fmyPo5n9ixuUsCnOEhX3zEKYfTnz8Puf8h4aatBzLV3jQUHobc6MOo7khHn9qc2WJ9V
         B8XHH+mXqSvRi60uOrb3u2HmDVFP6CUmgtuDwqnmZFYf1KQsGSIaRKYnrlP8eL0xZ8O7
         lUO0wP03V91+5cjHxFQ4vRC2FnVsgBmBuVCVA+fb2elJJ7e87/c1wEI6X7d6Dh9rX7c6
         dPud/YsxMIib9bgN1zxlpOdGht9KaP8DI+6rkC0JV47mxuEPIyJO4Qd6wv3s/GRhQvk/
         6TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727109; x=1730331909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH7t34m9dnmNlx93O1yGS5tEDefFHyWRqMdXdmIkhjw=;
        b=BL+g/Q9GwiVBpO9w1/IYfSCjMTGxJrsh0IU46FeshUiMJMJX3conEPlzNO5NEIuAGX
         kVpSr9FxuBbcNB2CBckXTcdcSHQHTdAdlTaWxO2LtS3udKi1SAH8hH5CVFMKbvgJht3M
         OeFgGr3UsgQI1U/L+2/tuwuBp62SAsiY2oZ1WvduBMzCuHtOOrrehh9B8Y3fe2ik3FmR
         FhqMX0fetU5lQyklXFi8L0rdz+6J1ynUPV1h511s+EL+YR1S3EYLaOIodnClj2elgzCk
         bn+rdkoj+wMtxmTlL6HYggXOOENGXjGDCKJiu8lvzqtMBfo8iXdSyloRcF4DukfhwLhl
         Wj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUIto/opLkDBZibx0AorTalS6sRV9204AwXsTg5eepMcto0hyctkI7sWbVwwDTrh3mTYN89zNCcIQsTOgt@vger.kernel.org, AJvYcCWiTnNzumEYUEaYbQ+kfxKdRBD3SOXoqsrB3j56wF48yo99OrYjpPd1nuo24ygBrr4Xd/NoO8cGY2Rc@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRsSgEWQA2EfV3niq7bzxV1qXnYQNipQz96ZPp5EbTbX3lmCY
	W2vPgRKDzvn1eJe6EGiuQmu0zam+7Os/3MQGtf05AAdXypBsJl7rq6/65GQjYfehXMRTbYJ04iy
	+LqhCBmdTIBdLqU+27qqmlnJu/is=
X-Google-Smtp-Source: AGHT+IEASdtebovTt/XdTVLz8Q7Z69ffMVx0+m03VPWdJ2zICo/83A8gUVc3cJP1yjUZ/fTdn/o+yvavDg7XA0S174U=
X-Received: by 2002:a05:6512:31c3:b0:539:8980:2009 with SMTP id
 2adb3069b0e04-53b23e37dfemr7297e87.36.1729727108832; Wed, 23 Oct 2024
 16:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023221112.1393280-1-Frank.Li@nxp.com>
In-Reply-To: <20241023221112.1393280-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Oct 2024 20:44:56 -0300
Message-ID: <CAOMZO5AL9nFHbcLe9HP8Rf99UBX-Pk76xc1zU8TaLgA1tgNH-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-bsh-smm-s2pro: remove undocument
 property 'clocks' for audio-codec@18
To: Frank Li <Frank.Li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Wed, Oct 23, 2024 at 7:11=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Remove undocument property 'clocks' for audio-codec@18, which compatible
> string is 'ti,tlv320dac3101'.
>
> Fix below CHECK_DTBS warning:
>  audio-codec@18: Unevaluated properties are not allowed ('clocks' was une=
xpected)
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I have already submitted this change:

https://lore.kernel.org/linux-arm-kernel/CAOf5uwmg83-TVQvbNOCnzBh9JdQAC=3D5=
hpgbCeT-6qJ=3D+YBrssg@mail.gmail.com/

I am waiting for Michael to test it.

