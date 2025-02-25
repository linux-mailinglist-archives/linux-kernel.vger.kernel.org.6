Return-Path: <linux-kernel+bounces-531745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D215A44462
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E163B48B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6626BDB7;
	Tue, 25 Feb 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6ldRKld"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B449268692
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497288; cv=none; b=el92RUNqRKvRrtddzpLlWWTc0LsPx3A0ZjMO0Yh5Rca4JDK1wmSMeKJUqi4JyZKoBWhASOW8qW8SORvj/xZcQDcPSxEX9DpcPhjFvLOHLtVv2lwQC3qRc7hap/9IU9t5yzEo+muOAeH54j7ahVLrajvta3y+hLdHerbc4A4MUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497288; c=relaxed/simple;
	bh=hGCiGjD3rT8WeMapv2F6JsVOidAV9/I18pkLa1aTeys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+P5/f3thCNQm3HFIo3iHpgU11ZMpTSnwIxoHm8J7VD65YnoaLArM9mwPHN7O9DltV0iGQFD7nfwB/x9N2tgf0ml09+MK7mE+7OUCNZyX4nD54I38VqvSt/XkU+qRUr3dKnrgecCzhgBWTucMdjxmspAezRWtreCaokKifZgYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6ldRKld; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307c13298eeso66400341fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497283; x=1741102083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGCiGjD3rT8WeMapv2F6JsVOidAV9/I18pkLa1aTeys=;
        b=n6ldRKldJeb4JM6Jhqi+EorQ8Cov5fjfKXfnxoPy+3DjaBoCw2DkCSohapBCnwG9PS
         fbvZodAEenviHsb0vR5i4xBPqBsIR76pbEBDdUV6ZglfHORvPv0Ubwbetg0Izf7q99Pe
         C0U6DD4Wu2A39S06e4ZUX0babUuLz5G+vXV/QdJX4FmwBE30A7Ot/D724VbFXx2HMs2B
         kxEYbL76pvXkfifeoPcEg+zOK981sdB4oyufjRUTutp9reN4YolAKYJUU0qX/Zo28VEI
         I9vNYUn3lbV3CMCBi0l3ErbUlSmE7ZF1l7Q96CYoK8a3raOt2uvkHiSumGAFbWG6PksF
         G3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497283; x=1741102083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGCiGjD3rT8WeMapv2F6JsVOidAV9/I18pkLa1aTeys=;
        b=ga5gQOtxQ2MNRHFG9DEVqh+sSGUxv3E4lhPLm+JPFHG9an09Ga/3u8Ff7QA9NlVpfp
         trMs0aor4YUV8yCs2Fk30EAvDu1a4l0xobinJ1lCVeMNvGbUwLdvGJzvLWh1I0kGQ/Rj
         /+fE28S13+4GIRC4v5AsgcOSMkCVM0yixWRr7CLI6OiVCAp/Qh6BSfOY4BnJ9h1io42A
         NUoVVVRAiRY472X9n5y/epUQaS5AY+hduni39r5uyhViIraKaJMKdzlxEuQq+GfkRneT
         iMlMYXIdRgo7qpeIq5Fauy5rXC6WsrQfUhPtlAoI9XP/K66jtiggt4CPmIBZEekgXfrU
         fHmw==
X-Forwarded-Encrypted: i=1; AJvYcCVczW7nG/Y6cfUI3EJvJ7hFqEEqwe+FL3FbKvbwjaOTJMDm2i9xpkP4cU6Yz0xsTHFyMnsOMsyb27UCMXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDCjeTyJySVBkvP+VICasUkO88WyV6Q27ufp7Nzxq7X+lDE11
	7PUU9OkndpN3TGKcLC7bB0D+rRMrp/QGGUtTq2V7ij7BztfouYDESpGyCZdZR8dHcys42F/zzgo
	sSqIu+Sq9ZbIojF2czNPtb9BGZQjEqN5z/NgTYQ==
X-Gm-Gg: ASbGncvd5nOxRKb1S8jtrMTTbfSZp9B+PkjEeyVUJMgYy9CHg8suBm5npHeaZGJtDH4
	veYNjDPkpkDifKqhq0a6pN2s222T74nxHc5423ORh11LcQl2waOnyRftPqNWZTpeCu2pIYHGnaf
	N685nWkCo=
X-Google-Smtp-Source: AGHT+IFIC691aWiQ6fX2Kh346loDQMF7svt4x3kP5BbJgZi/TCTQ5bjaKhl56TTJAVegI/rJyBI4FUJAROWzfxVZ1R0=
X-Received: by 2002:a2e:98ce:0:b0:30a:2b40:af0a with SMTP id
 38308e7fff4ca-30a505bbbb3mr72437221fa.2.1740497283523; Tue, 25 Feb 2025
 07:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-5-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-5-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:27:52 +0100
X-Gm-Features: AWEUYZmXC8d0HT56SyUltkg7iyFAN4LOhovsbEmG_24mIAewVxMQQtWLIB3aLtU
Message-ID: <CACRpkdbCZr9ZWirwfrL4MFDXzYmHLWQYzw9bTtGFu31QTKo5DQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] dt-bindings: arm: Add Rainier compatibility
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

> The Arm Morello System Development Platform uses Rainier CPUs.
>
> Add compatibility to Rainier.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

