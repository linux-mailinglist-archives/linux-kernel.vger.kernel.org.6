Return-Path: <linux-kernel+bounces-231836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72626919EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2527B1F239CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69620B12;
	Thu, 27 Jun 2024 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtBgvqFk"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900652D7B8;
	Thu, 27 Jun 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467742; cv=none; b=lWP128BmMBK9QECDY/aKgh81zEOfJs8w4VacWX/3VpjDSQaWq4aJfcTKbVeG/7qa+kAmPs8WxWkwm8e8eb0asr0lrlxvtpHmLpga8c/jJjtZ2T9GAZCqDeMFR4G6JHtj9pAV1tTEfZmA4Sc/n5T42bXj65HZYLrTBsLu/dT/A4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467742; c=relaxed/simple;
	bh=nzcFDM2niXQIkdNxIgMR8I1cWP28G3hlAo/TFN8xeIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5GEhF8VGASH1Jtrtypn1zIKDaNmeN+0djqC5WbZ0oT7ql5AG9tVE539dqZHbPofbXNMWbeHD6AkRoRjgwp09zgpXCU9eTB8OuLm4jEeMC5ZSTF8lQDkST7gu99JGh/fIzYdmIjVJwXJH6db8V9csonG8FjR9m+To97SZ7wMzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtBgvqFk; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25c9af0102cso3915232fac.0;
        Wed, 26 Jun 2024 22:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719467739; x=1720072539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VccrS9oPU1ye1fWfgnUFd7cSSguSuURiGt+E889sUx4=;
        b=PtBgvqFkHSSu2aFH+0ZJngYycwFd+RgaQEQJOsx/HO3ssNzq8zGOZO1WAeYqW8SplC
         +OueiU1npt/Hsai3PPw+d06d0h2oN6/VxttXqyHu1iUN+gSWbm2CVUsDl9qd1oQ4HG8B
         lGeDLSlW/DpebDhHcxkhydMKR7MXPkbUi+GBObk5ko+CpcBoIaZsFy/qmoDiZEX3GFyj
         6eoFunBVhcxQQkvjToMoo470E0sOOL8TjGC5L1bjv5RJSLdeLlzhPjPnaYl13L7CT0E4
         V+DAFH+t7b0bsMdoDeKBn++rU8WotwV+6NgHmqHvrQIwbQJVuCMDmgjiZrc97dkm44Ln
         FVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719467739; x=1720072539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VccrS9oPU1ye1fWfgnUFd7cSSguSuURiGt+E889sUx4=;
        b=GgU2wv/WpD0cTgBNpv9+5T7WDtSUEsY7NJUjwmfThjfclGy/ALT27x/zonHBE52kt5
         xl3LsGtyFZHz0sNGk+yrlJaWg9um3SH0FKTlwPskwItsnxcaKWF9jFXmxRiwMpXlQgSH
         SLk19NpRCAB5BfxoiQHbaI3ijcr4FfRHQO9I41X4PNvxK+2qVzSJjsU+RwVEt61ksB1Y
         sQ5yvlmUEexoJjfxscnNe0EQ52kxZhxXftHkVxPaY3CJd+1aheGr58Jxtg0EL7A+XXu4
         AfLds7HVRXwxWEY+vwOdgHwVyh4Sgp2GZQmhYb+sOGbztUmiCq6zmq3HPVALFbFtvHfk
         J3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXo04BCcsnCHKDk9IpA5cMRN1F+iKzuH7Y4CsGzftX+lJQrG/Ei03lqFKhg5iz7IAI1SPRwjstvfpAn3qeD3QMaG+AX0DjB19MyttckzQCMqExRxPu16x49p99lnT5lv1V/h79kJIz/ViqEfTEh/tG2wc63oF9tBC3UsYR7IYWJzQzHXiRc
X-Gm-Message-State: AOJu0YykQE3ItRdGrlA9BRrIMWNtPC+3weM0inOfyI3tW8CZ+U8vGWnR
	g467eRYgKztiXMCzgLQ2o+d8ea4M3P+bwyQkODXWxMwSSGMpG1WAFKx5zh0CT/Wf+AdcTdFEP1Z
	oAGahG2ug3hByj2GmH9kkoAxLFts=
X-Google-Smtp-Source: AGHT+IEBY6fBXEOo5NjUT93gJPq+5n8+qrx1SLSyDoe9rA0gihe1G3GUFw8JoFZzmBelp2TlWCxRS4xPUuoo6ZetyHM=
X-Received: by 2002:a05:6870:8088:b0:25c:b3c9:ecb9 with SMTP id
 586e51a60fabf-25d0163f70dmr13717557fac.4.1719467739480; Wed, 26 Jun 2024
 22:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625092214.88005-1-animeshagarwal28@gmail.com> <254c5205-06d6-49e2-a703-b6a33c7cb1a1@kernel.org>
In-Reply-To: <254c5205-06d6-49e2-a703-b6a33c7cb1a1@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Thu, 27 Jun 2024 11:25:28 +0530
Message-ID: <CAE3Oz81hV_Wfy5xHMKQ-gZ5GZqDxHUJN9=ywuC5XHRDFEhUqUQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 25/06/2024 11:22, Animesh Agarwal wrote:
> > Convert the RT5677 audio CODEC bindings to DT schema.
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
> > +  realtek,gpio-config:
> > +    description: |
> > +      Array of six 8bit elements that configures GPIO.
> > +      0 - floating (reset value)
> > +      1 - pull down
> > +      2 - pull up
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 6
> > +    maxItems: 6
> > +    items:
> > +      maximum: 2
> > +
> > +patternProperties:
> > +  "^realtek,in[1-2]-differential$":
>
> In the future, please use consistent quotes, so either ' or ".
>
Sure.
> > +    type: boolean
> > +    description: Indicate MIC1/2 input are differential, rather than
> > +      single-ended.
> > +
> > +  "^realtek,lout[1-3]-differential$":
> > +    type: boolean
> > +    description: Indicate LOUT1/2/3 outputs are differential, rather t=
han
> > +      single-ended.
> > +
> > +  "^realtek,jd[1-3]-gpio$":
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0 # OFF
> > +      - 1 # GPIO1 for jd1 and GPIO4 for jd2.
> > +      - 2 # GPIO2 for jd1 and GPIO5 for jd2.
> > +      - 3 # GPIO3 for jd1 and GPIO6 for jd2.
>
>
> I don't quite get it. What about jd3? I think it would be clearer if
> these were listed as properties, not pattern properties.
>
Ok, I'll list them as separate properties.
> > +    description: Configures GPIO Mic Jack detection 1, 2 and 3.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +
> > +unevaluatedProperties: false
>
> Best regards,
> Krzysztof
>

