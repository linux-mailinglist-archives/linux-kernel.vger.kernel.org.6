Return-Path: <linux-kernel+bounces-299311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD495D2CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5C11C231D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED54191F85;
	Fri, 23 Aug 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7lF8JQx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4F1922C5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429559; cv=none; b=dNcrkf2s4PYJfvyaJgppJjOXTgNcBRIS6TUp0UZvmQUSZguH4irRu3lHAKh7Uau9xs4y1FSbeOPPAUFp+Oc7fRllvjrdrD/sM5F6TB6aA05XHsZJsnDAQKqousvoxzxiOJllmJJXkMxe7EpKbyudNghyeoq2gAJFHWSiq67tBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429559; c=relaxed/simple;
	bh=foDX8nSpdBE7Stl1C+tjFDYcGaddTLXx38TRzjSaijg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNlwjdB0DQ/LoS13hQBzcu8454WUnKyv0jsvX5g7kOfD2Q9eoGPs6MCJxkpPhfm0cSWY+udGHOB9OEFjKoiINXAZgNOhcQGc+eVwWR8J8tOXJyTV4/mSxohOyTMKFIEk3JUEjQ1SKa4Wea6jzpOMoaP96D595W7dxCk8UofeZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q7lF8JQx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efdf02d13so3148091e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429555; x=1725034355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1jmXMGgCEe3vyECBk95vJ+hBk5w1rZzr4yvt3CADUo=;
        b=q7lF8JQx9kaMQYqIConQky3t+HpxtW3GmsnxciWj2X5f+e6FAQhKUEiPASxiYC9Ubs
         ly45/guzT1gcKdyizYSAT+I/IgQ8qvv+Q8RZoow/GEAbxjdfeCaEZ7gS7eBzMA4O7icu
         P2XGLCnVA4NBCsGjP7FkdPwtZvf0mS6bi8/A5U4k5qhOdqahRHDLuPa7aoHV1orSzX3w
         m+OmPjQXNtDI70BapCyWG4wfxhl8/5n9YgOB2r5dTI/iCsvrqEFcapPRVpe6H2ZrmloI
         kAmtTAUpoooM4By7rNfB21Lfd3kD/B4vBd+7fkUcTWvtZ3c0tgPd03mBXCXFCRfRi0j2
         pClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429555; x=1725034355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1jmXMGgCEe3vyECBk95vJ+hBk5w1rZzr4yvt3CADUo=;
        b=ZnV9GFXMH+5kQbAVKBiHbJmO3vrkGimrC9pBsMngbICMI+TAXeDejUhj2sHhElqt1c
         ni+/a3VP2LGpVaiFe4xl0Se0V/jtH/G6srTmD0fUdrjT5u1oNZxX7O19sdAggcHQYVgR
         IPjMQQ3lXMuI3HdA23zc3uFDGOW6eKtCgcsDn74/qpe2tpoRBqRgsuKkkFy/8OCTtzPD
         7he52HOx/7ZIKnpIVMjNhlop/x0TXL7j2X1TtR6P+d1IqpJQPYNSXadFxPifVYECnKWQ
         os5xOYH7Lpa3HBUY9+b/L/KhRP4GkY5uuWSat+JdqLOesHQKsK/FbsfFjhHshIVhmfLz
         tpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4QI2JUQjYN17COAKS8rQTb90l2Mo0ipDSI4zVmG3Y1e4vu1QXpV9rpSzdtbZZI0X6qYWK3Mw7KMRONQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3lzLZxobeJGN8sE769Tyg40MjqRW9SHXI6csvWYKAZCubMR3
	QS19fQLdj6cEnCU9OKZ+4ZxprE/DZmGdKFYyQC6RfjI5pgyIw75vOL84h2WvDpYf+bxQW1C/56Z
	r098Yp6EVDB5FcLENAdn+lR5oPE+iOwrAP2eLyQ==
X-Google-Smtp-Source: AGHT+IG7mSCIWYZ8bpH8IAQGda1ENwR9WbQciD7o/G7QbH41YO9wcFnvMe+Pbl1EVS7OeQRr0SFN9rrPBxhDD4ALEaE=
X-Received: by 2002:a05:6512:b22:b0:52c:ddef:4eb7 with SMTP id
 2adb3069b0e04-53438846f4cmr2471437e87.20.1724429554337; Fri, 23 Aug 2024
 09:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
 <20240811-dt-bindings-serial-peripheral-props-v1-4-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-4-1dba258b7492@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:12:23 +0200
Message-ID: <CACRpkdbaHqJfK7989rx8OaS9mpmdYO2Hpna6dUty_fDgYa3chA@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: gnss: reference serial-peripheral-props.yaml
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johan Hovold <johan@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Kaehn <kaehndan@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 8:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The "current-speed" property is not a common property for all GNSS
> devices, but only to these connected with serial.  Drop the property
> from the common GNSS properties schema and instead reference common
> serial properties schema (for children of UART controllers).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

