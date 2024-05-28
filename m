Return-Path: <linux-kernel+bounces-192185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37048D19B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0F1F227AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69F16C845;
	Tue, 28 May 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAY2RnMq"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CF16ABC1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896156; cv=none; b=R20Ql2tMF6DgXvFGntHZT6sr5r7NsiJylVTp2d46qXXSDtp7IvJq2BvswHMd9MSPFbidci6Vv4IjSET5By1fcAwGvDO0NWtUzVgLjCkyS00QvsMEcyl2s0kGrwZLq2DunoB6ROtGBfN+rA1GeHEd/L537WYkUIlipsFHMBAz7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896156; c=relaxed/simple;
	bh=Xfp2r9ij1P5CTBREktxWD4UygAf6m4hovDM0hqYiyiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Du/N3GyoLaM5ksCkCp9qiT6W3Okw+KtEzR94stsBlwaUtMrglgpVm1whMDpKndbOkG3Ad/WWm48vAdENmR3utZfW4BZk6s9U9t0Ddy0yvavelTz1ONs2m2sFAIojXDk85proq5dlMqRIU7e1IClFu2woIdyUP/EU7vbzibwpr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nAY2RnMq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4dda88ce9so520653276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896153; x=1717500953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfp2r9ij1P5CTBREktxWD4UygAf6m4hovDM0hqYiyiQ=;
        b=nAY2RnMqefPp9GsQ5HwjB8VBIIC52JvwHZEG1fLjBqTgZ1lyPzoGp+8EhReVFmL5AN
         77gbMnJ0xhVEzF9SU1Yu3ARhEHwcHV4rIIBwHYmPSfphIF094BiQVoJ8VgFU4cwRtopt
         HxeHUrjm8ige+OPbW/wyRbJxH3LteAP+rBHCIUCE2Dj0zWgQEpidBc1xEp0Z3ouFtkOc
         ipW+XwqHj04f0rPPavJSOqgSzxrS6V2y9brG32qbeL/ExYHrrHUxCB7bs7oHE3W/RT1V
         xpM0uTWrigYcDOaHdjg5JSTSKuj79NyYh0vNMCTEwme2ilu9wSuvJ2QruKJ1D1X6M7KL
         wcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896153; x=1717500953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xfp2r9ij1P5CTBREktxWD4UygAf6m4hovDM0hqYiyiQ=;
        b=PsgoP080spQxXARGH0xBc3J/yN6P6Tfz72mVWqItnbsAaiAAxaMbXrfnhdptt1AV42
         jJB4zTWl70OrFqBmIyndx2F3dw49UCoTiUZvuIcBiiadQebUew3O/iCqJWu5G0LwGcPQ
         X+KAsIzigdjfQKaO1LvhztczGRF9AtGmKbfUoUNYC7YH1ieL3VmV46zB9ugQxb587ShC
         7p4CMZKyc68wDVJlT0lF3/V5k50WpHrMB5BIapWXlal1W2icm+eOqbVsOurM8Slnbpqv
         9JjD/6J9j3BxKCxuFRnkYBAlIlW0vGFRGH+dYoiVezUFntT8p71/scZtVVA/KE4qMdb1
         u6pA==
X-Forwarded-Encrypted: i=1; AJvYcCWG3CixOYiz6wjHmgY6JVJsmBU6bNRqhexDdJ1LAG9fOl6qh9H0D0pR3ejFc0RaTxGdAYTGh0Ej4oQWxHlffTQ28skR1YR0k+oqjEYB
X-Gm-Message-State: AOJu0YwrikGEpi7E500wYeK7jaeGHYNwwzJ5KsFmW39W/6NQz5N8ivqq
	bFae+jtSjcs+quzVBJSfWIoNc2Mp2UEEb4uYm9bGBCkJ0TiQyJ5VX1h6L2PM5ZuW+paWQ4348Wb
	Crzmo6r8Zqm3CsdVoSVU7Dkcq65wojdM6vT4EBQ==
X-Google-Smtp-Source: AGHT+IHSwsTlGSMEArMj/xYL1c6lzKrxuJrq44fZGDxcHYJAGPi+BVhhdCd/jcFDvVhiG/t2ufjdh49VsD3tEdeK98I=
X-Received: by 2002:a05:6902:10c3:b0:df7:93d4:61ef with SMTP id
 3f1490d57ef6-df793d46655mr7431246276.26.1716896153602; Tue, 28 May 2024
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
In-Reply-To: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:35:42 +0200
Message-ID: <CACRpkdbTo=oJoKmF5SPbSyzpnfrVtMcAL8ZxAXUz59jWm6JkEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PMC8380 PMIC pinctrl
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 1:37=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
org> wrote:

> nothing special, just some boilerplate
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Patches applied!

Yours,
Linus Walleij

