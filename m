Return-Path: <linux-kernel+bounces-531742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D6A44456
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9593B0A10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1626D5DF;
	Tue, 25 Feb 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2l4OVYo"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99F26BDA4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497223; cv=none; b=dMFwYDAi5L3vsq4fLUtYIiPz6/oyddE/BgOd0QRxy9sv/sqNmnCGJJjZSwGLAVxmJFimC1PxOSVNIwnaihHLCQPgR9lE1fsQDok7bbbIUL0c6+yezOJklUhuK8AGxpfyxgD7mkdaB94D5L2+fW0Amg0YZVF0FReA0za38CJ0Mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497223; c=relaxed/simple;
	bh=+sM8RqSivE/xijYBrIrwfNgjHaRkEy1XyNdDEacWwgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZjBSPXIHQk9FJeTlwKvlOA0QmUrF5e74XlmTZgl5ogqIY3yejdBT7cuYleZ+judsrza0CsoXk+lW7xtSAfgQY4Xa0N4+VfDTRTmHprcqntgGQXm6Wisq5ZTKgLZoiGEuXdBPdtMAIiDYIPDXr1cUAVjLDIKGJsxTeNJInmQ/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2l4OVYo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a28bf1baaso50549211fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497219; x=1741102019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sM8RqSivE/xijYBrIrwfNgjHaRkEy1XyNdDEacWwgY=;
        b=A2l4OVYoc7zusWYHJdj4ycyb0/uP+s5viX0qcm7V1rNBcfO895CX7mZHgCv76AY2LB
         Y7e1JIYrJFIgMDu23yYnKCGRqojD8e/PPeOaelDPDcfs7Xmb9WDBefcp1FMXdTXs71/v
         e7iMKQWJ9Rn7dwjGOYf0E1kBJGSx04YHdJgg4Ssslliv2/MKNT6nnJB696x8CaEAdkE6
         T1FnmYQPQrkzMMG6rQDOYFAEuKwoIZ5f3uqoYetnCXDAptuVJguVRr5xa8PJNmY4a47Q
         7X9jKUOLJblPFtbRUSuFQ9aFglJWPVCxzlNJt8VNdMmUoiWlJtjHgUTdf9ED4YT48BX/
         7TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497219; x=1741102019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sM8RqSivE/xijYBrIrwfNgjHaRkEy1XyNdDEacWwgY=;
        b=lJkpABUzSdSc82/BC79JIHnBunGj5Jizv3VoKJUlKBq1I7uAFp8tEUHdxygvxaxRyJ
         qhYURAJ57n9Db300RBSShxR24jfBesfk7yROw/QdbZTUH3ytIBCc6Y8VKtcsMFR24tsb
         HCMGf5+ZFiKf2NqeqEWAtad4DwpUAXfWguF7sRny2PfbKY01rvuEGaqVdv9PuzEML3pT
         r2PFrI8bXO9QFimjLJBaQK9W0ScyAMI3dS1zjWihEoCugTuCEYSULEnfyrU4UfBYlD5K
         53AVPqfTdHJT6uA3o2/v1LZ0CEpz44vEJBw5ij2JnNJkRonlIdoqw7liOemXmJdI9GK4
         fgiA==
X-Forwarded-Encrypted: i=1; AJvYcCWPy1FXO3PIdATTtyPQ/m9mYmpPlacuJhH5eaJghOV+g0L2RBDMavrA97m3GmebK36mWRuuJ47qSS4/yUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0peFUCLbigCmdCuvebETjO9m3POb+Y255aIyBXcZa6R1+Qsc
	/iVvS6OJEVbb57oCc8662XtAaGXM+wxBKA3TcBGsfrMDGpgdTfRsDZSbKLhdXP3iEl/gRF3KPUF
	AMvb6yWc+yTf+ZlvXMr8L3/BuOpqBHmT6a5uocg==
X-Gm-Gg: ASbGncviI6+cibx3NeNl37Dukwp8hCbi/udSJayFgvm+fJh37+xotgv2IYSrwucka0i
	GSYq4P9KwoxbgLrOusUt+EyEnQl6NS0a68E+R6UvvNeL8COfJEAH1zuLOzCPQtXQWKBWDuWqrvB
	MuhPx4Oug=
X-Google-Smtp-Source: AGHT+IHg7AciF0bOLP9nYBodRe65E+R68WKpeOCG+glocpt21vjNyZNITKVO4J/tYQr2I8UXgNxYdWfVSbUB/YTUxlo=
X-Received: by 2002:a05:6512:12c4:b0:546:3136:f03d with SMTP id
 2adb3069b0e04-5483925996emr6834200e87.35.1740497219178; Tue, 25 Feb 2025
 07:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-3-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-3-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:26:48 +0100
X-Gm-Features: AWEUYZn8W5PQymPGlQZ6IJQCW62-Rmi8JGi0gK42ubUEcFMkmTbqO5GmXG6Hy4g
Message-ID: <CACRpkdZzUpgFvuYRGUwnNxonQ_TM2DOsAh5188qJ=g81v-asiA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] dt-bindings: arm: Add Morello compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add compatibility to Arm Morello System Development Platform.
>
> Note: Morello is at the same time the name of an Architecture [1], an SoC
> [2] and a Board [2].
> To distinguish in between Architecture/SoC and Board we refer to the firs=
t
> as arm,morello and to the second as arm,morello-sdp.
>
> [1] https://developer.arm.com/Architectures/Morello
> [2] https://www.morello-project.org/
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

