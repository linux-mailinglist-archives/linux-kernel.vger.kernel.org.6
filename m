Return-Path: <linux-kernel+bounces-366771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8C99FA29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909FD28499F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F541D63E2;
	Tue, 15 Oct 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gNMcktVB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22681D63C8;
	Tue, 15 Oct 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028176; cv=none; b=MG1uCbquh+HaM5uXszNLWT7eQYt8tN1f+SUZGtuUWXnbDnd0VaNqxWNEUIGnPfkGePDjgLMh682SBkQkdiNGiP4yU1R2vqTG2AUftAydhnbs06F/+MOTRdT/r/Y1VlDwRgQoCdqQNHIwDR1QE6/M4ytYp4/uWOKCkdX0wtu8G7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028176; c=relaxed/simple;
	bh=TUHbc2NCTZoEqVKU7wn/lP9FbtA0R/gTWuGh32oa8nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCdVOLN5DUA3wUcLpgvypsvUOwRgmyKvcV6xTonxX5xM2dGtAizaq4PRprNXYNkaL6ubBJDPKkO7q1NDWzXo9scPer1NRkh4d6tE+bCB5w9FuZ297ijZu2PFcedT2wnH2vAn3deSzOzTXZoJjGU3vGxEnBEwOJei8cpQKN0wHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gNMcktVB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbca51687so32296205ad.1;
        Tue, 15 Oct 2024 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729028174; x=1729632974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUHbc2NCTZoEqVKU7wn/lP9FbtA0R/gTWuGh32oa8nQ=;
        b=gNMcktVBGtPT4YJR26v+FuG1z5zFhWZKEsaGsMqYL4kVnwiixBsn0ogFfucxRimuhb
         qH2Ny5mfdkYc3ursn1dXoPvDC1DAKCiZv6OpFR/0eZKd8IMlm+saItyOsnZaXXAFvEqV
         Q8Sn++V5tUfzrGI8yv9+JDy7IYIYAdZJqMtaKHeNf4EECpybdRxAElQoHr5/uDyf49iV
         Emqf4f2dpnuvEandsCouxfEdmIL75fLu8T1Gag3rJHuX9lUsJ24cKjOL3sp56Koh+09k
         ciGlIP4F9lDcbcTSJ91ckX/AaYHYoqVDqHoieZU70Jn+qctsTaradt1q6oWJME4aSFIh
         y2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028174; x=1729632974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUHbc2NCTZoEqVKU7wn/lP9FbtA0R/gTWuGh32oa8nQ=;
        b=eFAzhj/N+YhaekiV5FH+obHtSkm6ZWrjA4FC3KfxJeNRvo9d7jCs+KYk94kJ6jpcBp
         4LmYqGWvD82VzsHw8fpO4eDRy8xjnNuIuojrE8p5SSE12UhbPH4wRxznLBxP9cJ/64AZ
         gXzlNmg2RNQRudRqKzWc3eaDbFFPPeola4ExAeqWwa89J49XT520W34avd8DOA9ADhIr
         lMjT5vAjJNXPZEN0CNQN09wJhcGmny/yBDWzRcQLQ75xvpvRz1SRUbuucs/HCO6LfbH4
         YBfAfJZi0ZrDEvO7o8CWyXH1BtnaoEm6x/WWAP1oYojl54sEX2Xj232XkY3xfdQ6Qc17
         NyUA==
X-Forwarded-Encrypted: i=1; AJvYcCUteaHQKHfxAHRZt/P0f+ESZzs+EO5kn5WPHTgQJquaOwTwapfui8Z9YT61cTV+Q7XRIyDfrhl1Syln@vger.kernel.org, AJvYcCVFUJKEDXYrIMqm+SrwkvV3wnxdZBoVW+bEMiqQkhRoXTwndugvssxCjd74gP3dFlflEGwTq9ORDvXCT0Af@vger.kernel.org
X-Gm-Message-State: AOJu0YyzfNh0AlfvzFCD3UQtTmiFPXkYI4rwV3MH5fiTIkBcv1rZYHiO
	EEukvk2HNL17WMLanO5zvak6nI5QkFJpytEGnR3e7JCo+Unf+2yRVXJGDZxG4qR3BaU+37nFXB8
	QWVX3/yU4qWaSR7yzI9fZGn2QR7Y=
X-Google-Smtp-Source: AGHT+IFqbNMesq/OCjTCsA5X5R9B78s0bALNeQXGiwca2lvIOVLQDgOQfJTpZTWJnaYVc8WGp678vgmB0ffwb2wprOQ=
X-Received: by 2002:a17:903:244e:b0:20b:b238:9d02 with SMTP id
 d9443c01a7336-20cbb21e84bmr225904075ad.33.1729028174053; Tue, 15 Oct 2024
 14:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-v1-1-c7291f17063e@linaro.org>
In-Reply-To: <20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-v1-1-c7291f17063e@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Oct 2024 23:36:03 +0200
Message-ID: <CAFBinCC2cfRQcQw4BoVqmJMqWMoD4TLur_ev+Bsp5NWL=hmt+w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: amlogic: meson8/8b: remove invalid pinctrl reg
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Neil!

On Tue, Oct 15, 2024 at 2:25=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The pinctrl aobus/cbus was originally here to configure the
> GPIO interrupt, but it was a bad design and was moved to a
> separate gpio_intc node because the GPIO interrupt is actually
> separate from the pinctrl/gpio registers.
>
> Drop this reg entry, and fix all the register offsets with a
> proper range property.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
as well as:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # Odroi=
d-C1

