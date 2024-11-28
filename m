Return-Path: <linux-kernel+bounces-424570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE09DB613
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338D6163655
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEE193435;
	Thu, 28 Nov 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Agrfig/C"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9D192B79
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791295; cv=none; b=p4IMd+1fkCUA8NViikJEXl9Z+YvAYOHIuuCu8DFC4/H4NscTyA7mky/6QrV1Ev8gU7LpywXp9iHOHDcQf+uH4b0Le1QaHsbLEkA5w4s9ew6B6ar2BThjKi8syQpsSythVggBt71RWC4I7EGud7apcWQGTPjQzKP3x66EYrsxZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791295; c=relaxed/simple;
	bh=6ehekiZACHQTnSExEqnoLJzOhJU4i7ihd93wvSZd3eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMhGb7J8HGTAARWIVKfLtmKZsE7tNfrq+XkeB8LPMHPJTQmVpPHL1v5T/ga1Lrq9vwhLNEHT8gE2UsaRtFJhY5FJk1RkXSm1zX50Ir8nH4TzZAUJtKZ4A5CNdDRk95ZAhx7Jd5NPkDNtPqkOnZ6gn8uIm+4ix2in4gG5Nq+mTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Agrfig/C; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ee9dbf1b47so838153eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732791292; x=1733396092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ehekiZACHQTnSExEqnoLJzOhJU4i7ihd93wvSZd3eI=;
        b=Agrfig/COAZKwKEpAzJ8A3kEYwB7jFHnyeZmd6CZWIQt3mhJNeuuuVJSH+dmEEzK75
         VScVeGWi7SJsqWVB05WVZorGxZiAta1cz0aEllVEGSsFvXvn91tn4EbrwGdBC+y1Tydd
         MGO8kBmuU1uX+1znlbJ+t3qA7Ejpsf7WSRjMqAfAnioZFk0HhwOOZdTqTpJU7uSmW3zj
         7dPVULrS2zlcUwclPhU6Kxagn0GpRu/PhlxTMKfKxOEJftlvCflBLaocbb7V3X/pMRF2
         K2O1Xk9llIFftNqa/w/TaZzBDwhDxfBmGLgxP/rFFVYY5w7s2dxSjDFNJh7WImuL7S0L
         /qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791292; x=1733396092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ehekiZACHQTnSExEqnoLJzOhJU4i7ihd93wvSZd3eI=;
        b=dqyI5MkZHe7MTjyFTaYmq88q/H2GLf/lJb8Kw97hwWFzsUR+ribS56+FAngCg+WHdv
         SqVwGNVRHQ95VsY4a+txRNmzinqjq5oOQ8NHOOJAw0Sw724rrkeK7kwAzU+fZQmVoxpT
         WSGGBKzYbE5+VaaDg0M7l+8RsyWF4JE9+aV8F0ZtW0zGdkkqqUyJ1xr08wk5hbuUx49f
         45g0b5j4LBopJP1chWN1JigNNMiIGTdsCEWBau+1RRX9scmN+OWE4F/V2lxPE1ykAGs2
         FPNXukhd6FplG1/QLepWk+TA0tGzambR9dQ1UyVMaTq5olYNq36rCwPjQsEuT5l66yCo
         BhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRiQtxk8rXnG/dmX7i7YKBWbs17gHg+FCDFVKQv3OUqQI+IF5Tsgm0wMGX9PODX+16bnGdtjo4QbtLrgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzI2+AcJG+6XVWZkSV/sGnNRodNuuP347L/WhDYSC2e/40IK2n
	2XUX73GjwezsNHONUwLlqlaJhSH5Sz4nxttrUgzpRKSXGS+fojBI3sS71lj0iOuod9MTxBoLH2R
	yKbYrrWg9M05iHncux0Hax34PSs9z60ioHNGx+A==
X-Gm-Gg: ASbGncvCq9Fj/AI8GUC/V/81tl9J02Qs6wmEOMZsH8fbNF/Igd1igSFezMyaiWecaH7
	KaQWJau5IkmdA0pKf5omAHWcZAJuQsVmS
X-Google-Smtp-Source: AGHT+IFRspzNKnz4//d6oD1niqAfNdEx+VyAphVEPqsddVm2R+EgqYzGwfP+qAkW+vpL9icCdahFMF+IE7WYtI+pC5c=
X-Received: by 2002:a05:6820:50e:b0:5f1:dc89:fa85 with SMTP id
 006d021491bc7-5f2179fa1eemr1438491eaf.3.1732791292366; Thu, 28 Nov 2024
 02:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
 <20241127-gs101-phy-lanes-orientation-phy-v1-3-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-3-1b7fce24960b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 Nov 2024 10:54:41 +0000
Message-ID: <CADrjBPqWh6z=1+9svYw8H=DZSpo+93rhO123LwFOAMOHMraLkA@mail.gmail.com>
Subject: Re: [PATCH 3/9] dt-bindings: phy: samsung,usb3-drd-phy: gs101:
 require Type-C properties
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 10:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The USB PHY on gs101 needs to be configured based on the orientation of
> the connector. For that the DTS needs a link between the phy's port and
> a TCPCi, and we'll need to inform the phy driver that it should handle
> the orientation (register a handler).
>
> Update the schema to enforce that by requiring the orientation-switch
> and port properties (on gs101 only).
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

