Return-Path: <linux-kernel+bounces-192218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1558D1A25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD961C21D00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501B16C856;
	Tue, 28 May 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xhqrxbks"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9116B742
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896866; cv=none; b=P0CaYIcuwtOAyieVpGymCJsblbL9vJS+uCE87LH01FIJ2QqzbeI1fy9IAp2qEL6XCwisacvNnCiLnZdZPYmdkGc5io16jb43G4r/h4UNDnzjgY1/w4mdiiFEJZCD/eW8LBzntDppaAJ2EP26cGsuwbSlHEU630aF0ZjnHHay1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896866; c=relaxed/simple;
	bh=Hg7XuKM5CPqLOOgjMF8VZsLSmj+nwkGGKqG8RuNz4Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUj3mUrt6B2sDGI89S/J9R8VJMK5CA7Vv9DMHdtMJe0PXd/iXvUyBjwa35vHlzdiRI6t3WTlDFp7W+2+OAqUYNgMGi/KV4f2ZNVLh5Xz6Ijk8ni3+ndxJBeAk8A1cNg/8FNL9mLGEpIJVNUcFqIf37IHNuBi9X60nSqOV4Da7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xhqrxbks; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a0849f8e5so6595177b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896864; x=1717501664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npSwzRz8pfexOBovLMsj/PfPK/ra6eBIg7wa+wfzOdY=;
        b=Xhqrxbks9yTc+KQFH85TxhLwwhlvfzJ4IT1Pjc4vqfr2eqiRBzoU+k5xjcsHWN0fX1
         FBo1Mq1NQ0AYLedVpLTnaF3pIz2VRtZr84J8r0FEtL51IrHbQvFw/RcCNbnM4s837RjO
         f1j5t7ed+VM4BCtoYXaITafkmqWUBkGzui5zyLScc2TleW80mNNWYywajNntUjfJbKbZ
         GTw0FY9uBKIKiQPG0/4azJkab6fiS3pVCQmSINfefdzEvLVnK+muWfDgl1FCmaWm+X7Y
         +MyRl7fZupU0WR+0mJpksnSTy+cx3zap/ETLjL+xR2xCpTk8KYuZYBUV/Hw+umWX8fVX
         2cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896864; x=1717501664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npSwzRz8pfexOBovLMsj/PfPK/ra6eBIg7wa+wfzOdY=;
        b=i16GMDzSp+BO2+lLVd6fpEAVovNb2xehjP/wB7z964Q5ydnJJdLW8QTbYDpLL9Y+vg
         NX637XwO2d5FFZNdE9JGmYURkaYjyw6VdoZnyt6ZzEsW4E3oQg3ye5nCwve3xo+NDP2J
         dMKsTJ/LHeyrx57k6ZPS3nx6EAVMMvnBlK0cmynq/jCAeMLaQGmnEDB7v6KPNgd5Z87g
         k86UOEud10xzTlVv0mZQU+vnrwx/509/6pDRzbN81yTwqCzYliVs9EZIE06qdXyu4dlJ
         mykczNjRqACgmJxaExYBa80dDhqI2LBfIodO5hoMiTMNzNBI1cUxQe59czxeoAboLFrk
         fAIg==
X-Forwarded-Encrypted: i=1; AJvYcCUflb9Jh/nskWb7GtuOdFB1yuU3wmHyd1q/2St/+0PFtkQ6VThH9AhEDkA6sSY9GDPod1Q8H5wRtLxZqqJaTAHvHmS6tll+MQiX2x03
X-Gm-Message-State: AOJu0YzjFVbdVlhLtWvP5vLauqQ5eIJblcS8jGPK5tk9nBAnea1Boc3V
	kDgYoMmhp+QGz0HOQM14/kDPKTKru2A+lF2xEIq1hWVl61jVnn1AvhbG5sjqe9fgMEoOEjVKgRm
	HeNpJTmOIucihSxZTyCpPXejoTm/JUUURiNUk1w==
X-Google-Smtp-Source: AGHT+IFlm5HKQNbmVfg40Fu1+sUgYzW8K3sofsoQZ1Xm7rk7JC7o1LVIaBKaLQ1HwfX1q9s5SBhxIbJzcyxQTI2dmhU=
X-Received: by 2002:a81:838a:0:b0:61b:3487:df12 with SMTP id
 00721157ae682-62a08eb4a9cmr117543197b3.35.1716896863954; Tue, 28 May 2024
 04:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:47:33 +0200
Message-ID: <CACRpkdayDnBw0wCWffSwOX1EfPkq5TbkBH_wBJAwiZKaRbgdWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document
 FPGA syscon
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:39=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
> to fully document the block and also fix dtbs_check warning:
>
>   juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too sh=
ort
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
(...)
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>

This feels more like a Sudeep area of responsibility than
mine, so please use:
Sudeep Holla <sudeep.holla@arm.com>

Yours,
Linus Walleij

