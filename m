Return-Path: <linux-kernel+bounces-335587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CAF97E7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95677B20A79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37F74416;
	Mon, 23 Sep 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNNxugWp"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76E19408D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080994; cv=none; b=jAh/wyAjij21QoHtvWZlEfNeP8cnssrE/EedOywl4mqVOF+QZxSVvSZwXEtldWkMWD2Y3kAnKTUBWXFJS/6yre2VMxnLVCBznTxstyaLBH3tPCR9ec5g+Tax+ZRvACAqsJZ+0wwq+lj9oRIkbo1Wl8feYNeNvpZqiN84LPf05ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080994; c=relaxed/simple;
	bh=XSzUh6ZJJ6sFM4hLu82VZxpVet5y5KagtnDBdYcnFF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REPXE135AfL2lWpafCKaDnbtps/aRcwTUri8KvnQOfDkicd4hC5VwujLQq6nM8h/XuTpCOT7jbAaue5Qp384XnsLdumHYcJi5jO1DI6ASbLpCOaxc3X/Q4aBXW9RNLzOhmpKRJtaKL/AUnYE7v+hyye4aV2OtdFK4yZCRCPY3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNNxugWp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5356bb55224so5335193e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727080991; x=1727685791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZz5ns/39I9CNLcdEHgb1bq93Bmp6tryH2rW0CAcV34=;
        b=VNNxugWp6T0f8fg1SEvBLPmORAIyl5X67B9rqHxra+5cBaITskq08SgONOHrMM4XMM
         xq2vn09c64cji3+XsveCGACoGMWqclM8zSajempw4sf73ujdfagGNJlu/O7yLIxzO8is
         qbfCIaV+506+gB17GiZAXWwI5fQ+FkLpHp7Rjp7RPxZwBT/1T6FiRXsC9kRsZygHWC5D
         jYy8rCjidApW3Ui3gqmvZA+MOckjjlLZKGWXibJ42Qw/1qp+uyGLrEmhrVojyQPWLp3X
         K7clY16foXVp1FjZK9DeLUB1vIJBJCAm6P7E/l5N+ew4nCqL9B9PCxhGDjhaQKM+rPyt
         Y4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080991; x=1727685791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZz5ns/39I9CNLcdEHgb1bq93Bmp6tryH2rW0CAcV34=;
        b=M+1b9XbsOAJZUx6CpEBd8at1Nr0o2EGKCfJECJ+7dsSRsF6+GEpOz1FY52BSRgMvZ7
         xbiYoABySLLkhQcCZuZHqX2hC6tTiHvZV4J9FULmRq4vVywskw/gaG1lUbfakdxc9w5m
         L9z78bM7ucOJ9SlNEKvSyFZiNLp66HG3dX/+ATvEPe1ngjY6/lrjrWSe5W5LafsEIjDQ
         zYDiT5CdforAJnqie8ZlTsR6fJHuUijfgUwLFmYma5iWBBstHy+vmJsThW/otxYlh7nr
         m7YS1BOsKZ4OCp46YKr3JD3Iofo7g42n9VQbGX+82Yz0V+69HgvEXt+HL7zfE7uddRwX
         UxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXktP6QD1HDNcZ+5ZX3AHzNPkg35eFF8wshNUrshOCTfYtSKYiMH0MIStGf/1X1tWh8Vwk43GP6hkeoHqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzAyLVFYJZ7WFUv/bz529L/MZ3CF7octaYMOJEOpwa6Ud2BcC
	Tt/xUhNweYNuZBrJt0fhDmw1EQuzc8l9vYZcvMrHMx2NO+O2bRKYAx+UNOWc21f67jWIx0VO7UF
	T43RDvDIqU0OrF4qDFDP5k7DfOh3Vdz4ILU/4Vg==
X-Google-Smtp-Source: AGHT+IH/lTkkxNf7gVB4Qk11bFX5oTtze9g4A3iaawv5kVYgzIVZ7trMrLr/mwDA4DTElB5MHwruJq3qAdcaDv06+ig=
X-Received: by 2002:a05:6512:398c:b0:535:6033:265f with SMTP id
 2adb3069b0e04-536ad3ed8a8mr3787007e87.58.1727080990398; Mon, 23 Sep 2024
 01:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906110113.3154327-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20240906110113.3154327-1-sai.krishna.potthuri@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 10:42:58 +0200
Message-ID: <CACRpkdY0VRAD4+P5aFiJetjxce95K1fDeeYVYwimrMMADRb9fg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pinctrl: pinctrl-zynqmp: Add Versal platform support
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>, 
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:01=E2=80=AFPM Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:

> Update the binding and pinctrl-zynqmp driver to add Versal platform
> support.
> Add Get Attribute ID in the Xilinx firmware driver to get the pin
> information from Xilinx Platform Management Firmware.
>
> Changes in v5:
> -> 1/3 - Used the pins and groups properties references available in $def=
s
>          for properties in "mux" (suggested by Rob).

Patches applied!

Yours,
Linus Walleij

