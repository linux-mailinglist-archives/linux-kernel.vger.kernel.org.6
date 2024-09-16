Return-Path: <linux-kernel+bounces-330951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E797A66A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C0E1F2225F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9C155CBA;
	Mon, 16 Sep 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONHj/8w+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFB1CA85
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506088; cv=none; b=XethqA6TV528x52u3Ud/rQzA1s9aSGRWrWaBmvTWsFAVr17ej44c0aZO677qoKIoSKPaeL4SfSgmjIoMYLMyQc39Ba3mzG8GuthqhKmavsxh/FkB4ashqAHc8/vJkhmMMQtLI3DYu7EpgfsUqzay4ulIxhAInEAFGhbnNuPTyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506088; c=relaxed/simple;
	bh=48e6Kxirghoxt/50oW26tPAHg2OJLSQ3Ti0IeTafAPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQRuDH2oynOgzY8yUS8SQAQLJpqIHSxQxTY1kHSj3f3AkIIhwLV2cKx91ADx7G/8LQcvanRuBJmYI/Y/9X+DzgGxiRsCj4ePPxxPA7mgDLSGOtH3X/5mH9vjJW4ZOwvZoiKKJsv4t1M4QXN6XfEzikRmjj0/UoCwpltxVla8oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONHj/8w+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so459853266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726506084; x=1727110884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48e6Kxirghoxt/50oW26tPAHg2OJLSQ3Ti0IeTafAPQ=;
        b=ONHj/8w+3WLaTJxBab6E0nedoScCQmG5huM/R4oH9NJtJcsIMnptjetDAbCx0suCcF
         JKnld82j3jZsIfLS2diouFHmUgVr2qq1RgZl2KDoF6IrHe7oyMjcTc/JLb4B65Eqfinm
         hKfRpiCZlGlTzcfQUUHmxBaLW+lhBmssx7FyN0IOYkY04rJ3ox3CGKQWDZxdEhb+yDNW
         kutZTcp3kpqPqcAkC7iSZt5Jfs+75ZOYFdZ8iJaDFwm99wslrKEtmByuT+yPAuaTYUaB
         kWHALzuqatYR2jaw2J1qd365yXcIIxjI5r7HhNJAobnavqu376XVJkvb3w0nEvz41mpy
         REiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726506084; x=1727110884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48e6Kxirghoxt/50oW26tPAHg2OJLSQ3Ti0IeTafAPQ=;
        b=BrAZmSN7lsgbJGk/fFBJr7ewPhcB+DGExLuX+T9gy/n6pboEdtnWyLMrYqnQmyNhtD
         ngO3ZGR/rymnKLG74RpgTB/yGvXUoUkdLjEusw91myEMW3wQuseZtCrS6pdXmfZ+axK5
         IQ+8l0HCOBM/7PGVGVmpCPmfv0MgFcuT9SEvF28OauvPar9l1Bfo2OkNNNm1fnneSH8H
         n5ZX9HxoEiBi9y38lNpJdv1bR/PmSD/ywkTbuShSvgMXpPDH1kCelXJdwqs5AyMU262x
         JwNlRo4GYWPH2WSRKx143cwyJMfeA8hlXsEGe9SYl5yrcSlQEztHm7LJA2hHBr+BoFFA
         YqVA==
X-Forwarded-Encrypted: i=1; AJvYcCUGanQoAhRXFRwaTV7jpmzYHotbG3B+TV9D1hTNNLPEkWlwHxxQz1iYq2NNtQXvXSJYWhELerhVRX7sBIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hDxqMrI728QUn+qQ4t6qRYNDXkRC7XJ4WdIlUIGpvH+fWkqG
	qplq9trS2fL2gM08fhLxsnDC/GcpNL9zFFvd3VFiqqOHs2XTBmsjqgWbi/uvjYQ=
X-Google-Smtp-Source: AGHT+IGe1TfoP2o2Ws9yKVCIHm4ikg6tF6P50uYijZWW42Vu7qlvA6T51QZHhAyvGZGYqDh7YI/JJg==
X-Received: by 2002:a17:906:d54a:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a9047b4750cmr1204277866b.8.1726506083760;
        Mon, 16 Sep 2024 10:01:23 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38desm340386566b.121.2024.09.16.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:01:22 -0700 (PDT)
Message-ID: <1ab324b0702c87371b9e92a72dc639d49ec055d0.camel@linaro.org>
Subject: Re: [PATCH 0/2] Maxim MAX20339 regulator driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Mon, 16 Sep 2024 18:01:21 +0100
In-Reply-To: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 17:48 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> This series adds a regulator driver for the Maxim MAX20339 overvoltage
> protector with load switches.
>=20
> The MAX20339 is an overvoltage protection (OVP) device with integrated
> load switches and ESD Protection for USB Type-C applications. It
> protects low voltage systems against voltage faults and surges. It also
> integrates two load switches with current limiting, configurable by
> hard- and software.
>=20
> It is used on the Google Pixel 6 (oriole).
>=20
> To make maintainers' work easier, the relevant DTS and defconfig
> changes will be sent via a different series.

For reference, DTS and related changes for Pixel 6 are in
https://lore.kernel.org/all/20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.=
org/

Cheers,
Andre'


