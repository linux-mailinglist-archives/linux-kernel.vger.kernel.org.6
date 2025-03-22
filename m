Return-Path: <linux-kernel+bounces-572613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6AA6CC2F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00A9189A54B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04306230BE4;
	Sat, 22 Mar 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6X6gFQp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B8142E86
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675217; cv=none; b=AvBvC1LCBPIAuPycrcXpljwQliSP7CoDu2nNyFsPh+GYeQYIcs8Y0CcoF0ejXHOsAj3Dlpa0v0g5qjlZCTsVUUTmGomRmm/6ZbKqx2HifNkfxrgjV/Av3DkFUp5QOMxUt3gX366yFgAXrgGT3adRBbTr4oOQ+PadKss9nyRVEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675217; c=relaxed/simple;
	bh=ljbAa5s6Z2FI9zB1H91oADDkd6fPz4zPC9SJhrGQ/k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWTMQ7XUHKp3HL7jECJV/R2LDXSy6vbykyF8D7cVY2cBV1MkRFcRamI3a+g0AbQsg2wifqUc7wh28VboRfmDoY5XeSq+lNIObkJYs21sOQ9Gt2Zjj7ywyPwXdIsCZux4GLtrkJbnSIn0/ZyoLEKb1roofBTS/qzHmQt3DDb0N3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6X6gFQp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549967c72bcso3691178e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742675213; x=1743280013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljbAa5s6Z2FI9zB1H91oADDkd6fPz4zPC9SJhrGQ/k4=;
        b=h6X6gFQphsjHXrIAScyylueD3QYeX4DmsbaPTBoRmHHMvsjelk9FDZnU/Krm7nd/Us
         84j1fqrtUj4bHS5YKlXq8r6T7Z0ga4KeRYzR7c8H+ajb55mXDphO2LhQF8WhjZ4aBDh2
         4toVH0+GTbsu3s9pmhnwAjep+//PKgE8lqp8LEZ0i1Xybl2RSEWiLalIktnAONLDm0zj
         JkD/FbDfdytqqS5l0/GFnUDfijuZwDAEV6AuxMCHiZeV5CeXlhF0omwBJwZ9BVrHGDxm
         tAq6Dg5/Fu1pqCYtYr5bCul4EOP/l9jGaIKeWz6oK4883x3f6Bno3Ujg61LWlaHK/f4V
         02fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675213; x=1743280013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljbAa5s6Z2FI9zB1H91oADDkd6fPz4zPC9SJhrGQ/k4=;
        b=xIMg9p+rwteNQnpVNADxnpW57vkkBeJhIx/ESUjt6LHXC5lOi7eV1OrEjRQX2a1IhX
         g8Cv/aHHCVPWGZP7Q5cVVMSMd75WPAI8iFiMiKhrVjt6OAoox7GCoeMb3C9/C53W7zKN
         R9AGsi7JcPQOgitDUmPu82XfLv8pQvPy8eY7lkxRfq0gRa7JK1EFprcPXEiBRnkBFjZt
         2WWIYqAiT/77IdvJHyb2EY4+JCZYubTgVKqpBQ+G3I51sruv1u20JmePhLOxS0y2ddSi
         zx3IYjWY3EEz5OoIGYmD+kG2HL5HppMwJHCtuQ1iV2hZ7IGhNcPDslQGNhZ3ybB+BZhI
         uMlg==
X-Forwarded-Encrypted: i=1; AJvYcCW9PhDYKktyXF/bhd234+KnoYOqVIGeWirmdIlz2uvh7cIzEAgiYtSJh8g9+rN81C0cMwdss5AeNQBMCs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmvC5YrVbxK+FBXEtMiENJ+LpE/IeLv/Q/NTkPJI6S3n/9NQG
	8JN8xW/4ryW/CaGlZYrqhyEOoyELvd3Rsc/Abl6b+tAIJZP46GRBZ7wiIZ1sfOQEIDt7kWMW1yn
	bb1QD8hTduE/k6iOl+NzdXEXbBbQq12jia2hriiiLtNNxJFai
X-Gm-Gg: ASbGncuaiUBb/9pFf0Bu1XvCP/lVOSkrdnrdMpC2naAot4tsqU1XsVpMxArOS6mNtcP
	SX6XyT56LZBQo5Rd9PjeUujp9X4N/l60jhZa11ToRiQwG7mcZd73oWkcf2E/nBSvhJzNIRu9xPq
	gkP+VVa1xiy8zzfdAmL6J7VL8=
X-Google-Smtp-Source: AGHT+IHZM76jRtU6TXNoAtDN/VnB6qXNW6ovpjvvY0THEAovFKfynZjEWlA0H/2vsGwjjVf8rWLa92VxHvcRwumRTCw=
X-Received: by 2002:a05:6512:3da8:b0:545:f69:1d10 with SMTP id
 2adb3069b0e04-54ad6470acamr2373527e87.8.1742675213442; Sat, 22 Mar 2025
 13:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org> <20250321-gpio-todo-updates-v1-1-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-1-7b38f07110ee@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Mar 2025 21:26:42 +0100
X-Gm-Features: AQ5f1Jq0ivH31Pe07AD2K58EV6v1_l7EhkpQ6zjOojoKiaGM64uFvLaROZbRihE
Message-ID: <CACRpkdY=bT7BFDOSd2BGiwu3aAHYqBxaTM1Sew=2t5MD_WCXbg@mail.gmail.com>
Subject: Re: [PATCH 1/6] gpio: TODO: remove the item about the new debugfs interface
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The consensus among core GPIO stakeholders seems to be that a new
> debugfs interface will only increase maintenance burden and will fail
> to attract users that care about long-term stability of the ABI[1].
> Let's not go this way and not add a fourth user-facing interface to the
> GPIO subsystem.
>
> [1] https://lore.kernel.org/all/9d3f1ca4-d865-45af-9032-c38cacc7fe93@peng=
utronix.de/
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Okay then,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

