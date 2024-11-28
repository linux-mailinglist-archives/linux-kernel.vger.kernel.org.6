Return-Path: <linux-kernel+bounces-424399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA39DB3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5196281B00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7FA14F115;
	Thu, 28 Nov 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/S6bdZg"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21814AD22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783207; cv=none; b=apnNtGYBMJrXZ7wTmdlW/VW9UR0qaIap1wKm3Rqw7R08w2UTddpK7fa0WTlQLUakkMBG5quOInbzEMSFG+5jeW9f8wzMBHMM2U+o+4kExMVlyBLHrZdtzCwg4oerq1iNAMTbwg4ooMviCOuBxhDgO5HVDUbcUwxLHVlVJK48hzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783207; c=relaxed/simple;
	bh=l8r4E+fAxvn95ykDQ3t+Nmyf8EYUz2dFT+lg2PPw2HI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RAkYx1A3cMt2sGv0Bh/iNM1RZikVQhBOWenRjMnDpjUSmRV3Qk7j6X2d4ihwMjGKY7pPnWReLfWLROZM15SFLxbFw1BIBq5LKnj1OjKba2kjr5t/XqGFJkaDeAP3zNcXvryppL6fGNTjgRAWFKEmpww0jnBm40PMmFJ879hGBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/S6bdZg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3823e45339bso437045f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732783204; x=1733388004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l8r4E+fAxvn95ykDQ3t+Nmyf8EYUz2dFT+lg2PPw2HI=;
        b=a/S6bdZgISDO9ZAz2kcR92XlvcoculYKlo91vd/zFSU/Sw2kFgYepEZSJAfhGb0apL
         UX5CgaJblqb9vJPKkyMxX3mqTari/FvD9vZoA9q8qYfICycwNN3QAzUioKRw4xgMlvKC
         xWSZMA0ZcdymKsrVsJ5KcrIZxP6dZBfXxQM/3EXvNFlVM2cjbTChgBV6TMeFP+zVDOdj
         NAi9nHvlE8mbue0940anXfAK4DBdYn5byMbJUEFqhAVeZciSQHpE6u8n3TpGJK9l0+GO
         /UtjV6wkKU9nR9h5kZZPNSJn5eRKz9OhrhnqVY6NwM/e38j79n6QSq33k4yftpGgrFXx
         GbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783204; x=1733388004;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8r4E+fAxvn95ykDQ3t+Nmyf8EYUz2dFT+lg2PPw2HI=;
        b=BNm9Z1Gue9Gyc5jgait09068ikkYM/50tQcNW11qnc+nzzlm47xei2b8j6bQH7363y
         pPeJ5B1uNGueF5uAnDVPGWK1Vonf8iaIiNMaThLmX+7m75DVPCRYVx4zDchVqQOdQEDS
         R8ewSx4B2nCto0y/r+lDh1rt2TjFvNGncewlvMnthx7QICyhztjl+G0XZFoAGSWvdgpl
         leaWQ+AEdF7tGOfLbpddtmy4Magys1PB4uHw0ElEES2nHkA37s9n9dyfs92hOUxdB4Bs
         +xsw1oiAOMZGMShriR3P/bKI+FRwP5G9VT4H+ZcAFqVaYtRVd++yO+m//NdWEMSS0+mZ
         WbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGhJlRJmIrU+z4/4WN/UduCuHb9lTU5MTRWmlBwwS55S7zy7bzTRMerYZ00YSEXRXKWIsFJJg0urvyVGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvW/nI5hVo5w4IOdPAVYp4OWmsrFhLdGCMcU3V5LQvqQ3Tpva
	2+l0C/y86YMianYb2uZsyRSmPtzHDKlM7vPwIRFjBCfgJ0BqugNGFIafMK9RtWw=
X-Gm-Gg: ASbGnctwEJbU61oU6x3XG6En6xyy1zkJyWE1dgg2aanGrcXdkxBkbWdgH11FPPbN2bL
	+UXKymFvQyy4DprN59Q45pb8Awz7f+qNCo1LxdpBKV5yROC6SXsJhMQ6wCx1IX1ccsX7Yxo3c00
	rvAAiI5IMyfpuaiPj3+DrwJNUIQDlg2D2q4zhqlv4zapCqRVguiixch6iTFUyjT9ugCEjix5sos
	HxDYAPBX1c63HIxWFsdLVvvnIMPV0B8SWAN6SaCGx3Rs1c1KG/w1jQ=
X-Google-Smtp-Source: AGHT+IHLCVGEBiGpNB3pr06gJDHBvejAWzRugYtAncqUTz6NJIMOpbiyuWDq3lH6CC8FDjfooG1oIw==
X-Received: by 2002:a05:6000:2d8a:b0:382:2f62:bd45 with SMTP id ffacd0b85a97d-385c6ec0980mr3638454f8f.29.1732783204673;
        Thu, 28 Nov 2024 00:40:04 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccce7859sm1096280f8f.0.2024.11.28.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:40:04 -0800 (PST)
Message-ID: <5d2a32a9bcc38f31beef56c04d07f6d53aa49e06.camel@linaro.org>
Subject: Re: [PATCH 2/6] dt-bindings: usb: max33359: add max77759 flavor
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>,  Alim Akhtar
 <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-samsung-soc@vger.kernel.org
Date: Thu, 28 Nov 2024 08:40:03 +0000
In-Reply-To: <8325415b-4af9-4bef-8310-39410b10aa84@kernel.org>
References: 
	<20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-dts-v1-2-5222d8508b71@linaro.org>
	 <8325415b-4af9-4bef-8310-39410b10aa84@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 09:17 +0100, Krzysztof Kozlowski wrote:
> On 27/11/2024 12:01, Andr=C3=A9 Draszik wrote:
> > On the surface, Maxim's max77759 appears identical to max33359. It
> > should still have a dedicated compatible, though, as it is a different
> > IC. This will allow for handling differences in case they are
> > discovered in the future.
> >=20
> > max77759 is used on Google Pixel 6 and Pixel 6 Pro.
> >=20
> > Add a dedicated compatible to allow for potential differences in the
> > future.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> This should be sent separately to USB.

Sorry, it slipped through into this series somehow. Will do.

Thanks
Andre


