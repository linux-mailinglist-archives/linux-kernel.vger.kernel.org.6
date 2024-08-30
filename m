Return-Path: <linux-kernel+bounces-308886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EC96631E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5E6284D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1EF1AD417;
	Fri, 30 Aug 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0U7zzY3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23D172BD0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025265; cv=none; b=mxfVkwoZ/0c33Aga5bFAy/fN4RXSbC6Zy8tMMqsiYZ1hKSBWxIubCDeADAQpDdgHF3j6yRwGAL6ey9Ve3uBBLj4uRl4wH9fcOkLqC4E0WUFg7sQxZKFkO/OPaJDU2Mvm9E+o9SW/zK1kSr650A7ttr9TGOSVHfurOVP/bzd83mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025265; c=relaxed/simple;
	bh=ZrGqq5NfvEBmrRBELLAjlw3uy983U3Pun+m402wQfto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRzeXWoDX+FpkT92FlVksEm4FG9NIhs8IcUtyiKefU6sh3xgX0z9ot7Ys5X+ueLURZwZ2CB/vFKkTwm/x29SPOY25RhDscCYhFwOAHuHXeADUa5246JGKwSmXlMiUJWSxXPSDTE03FUPwyVJSpvOklCI5C1cOTSEHg+2oHGLnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0U7zzY3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso2545103e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725025261; x=1725630061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2RKP/1W4x57jftVobOdW3IcvUoM7v9SY5fZR0Qwto=;
        b=d0U7zzY3HOiglpzcRtTNapSysUjuckQh2xZ+OzkGJDACYSVY9xGk7V4Ddc5jvHuT/C
         zH4yMlx9plQ+P+h6TSvAOEWP2FAXo/LzBuoSDPlOJ5f57X1hC/bScRKSOgKAn/W/Vgjs
         Mrm0FunKnrP75MPzupOU5Pw2wBXzgivRPWEbuMnTUO37G0yCNMGc42ANtEXBjI9Pnrjw
         GO8TOIlLQpjS/7oYdVTkSnXDA3U6N3hf5QXyg46ScqkTLX31bgVxD7heVjHZ7mhGHisZ
         zpJSi1u0EfKGGCgvb/wzdD1NYT7+1i9Oqgm6zTIL36ZHtD3JWcuWLKhbiW9MXW7cu2Wg
         q1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025261; x=1725630061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg2RKP/1W4x57jftVobOdW3IcvUoM7v9SY5fZR0Qwto=;
        b=UUfPdfEum2BgCr9aQQ41Jd5Fg2X480xp+69g6xaXhEY4zVdnhpKfNbrc5vJzGem5do
         FiEOPohKBiBtU1Wv81441IHkHtIM10PXy+YHcanubQ1uGjgUjMUp5ZTilkYnZoGUnW3t
         mmsoIlnleSTA8zbAeLQAmasNzOa4g9w7uo4IbY/MaWEyNIHlquug48a1BLGlZBEQqRXG
         f4B7ZgBEtYFFOEj34ZflyIFCEMUjYB2GeMelhLtYKlUj0qmYzaLS9F99vbhd/mhxMwY5
         W+lT0pfSEW9HPMjJD5TlJDSqXa42krHZvfyqd7sB1lRX/YVHRyYUb7UyVjOA1rCPj4gV
         hiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhG7eMSIl4el/cg1yGlgzFIiz+VkW7hZJ2r8ElorURCXUU0yvsjsb1/JUbzaghVw5ZoXkmsXb7dVK8k2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72P01e/FUx9gaiCKMTNWjO1aTaJCQwYQTc9g2+JKi4Xs1c4By
	C69y5ztohmeyBdmAMAM6YhsjxlI5Ya9P7YsBYfOqwRUnZnIIp/rxM7zvzzMCSmJZRTF5bfBG1Q3
	nkNL9WoVQT8VxHbTWcYyV2jp2ugTai9fMz2p9Qw==
X-Google-Smtp-Source: AGHT+IGdCAzoS2BJDw9RqgCg53rSN1MLjuzEtnLwEUapdSxGqCfZbZhxVGO0zoFyiX5x9z5GidRuT19nvaqE/jLG5lU=
X-Received: by 2002:a05:6512:398d:b0:52c:adc4:137c with SMTP id
 2adb3069b0e04-53546b25a52mr1356585e87.20.1725025260167; Fri, 30 Aug 2024
 06:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 15:40:49 +0200
Message-ID: <CACRpkdY65=biEaDuKxV168rYTh-ZN-Hi34UjvMorGLfidfuerQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] soc: versatile: fixes and compile test
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 8:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Three fixes for unbinding and error paths.  Enable also compile testing
> as cherry on top.

Nice, patches applied. I try to send a PR for them as soon
as possible as well.

Yours,
Linus Walleij

