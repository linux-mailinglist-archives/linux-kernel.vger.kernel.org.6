Return-Path: <linux-kernel+bounces-347533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0C98D3F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D63E1C21BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EE1D0175;
	Wed,  2 Oct 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qivo2e/9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC61D0172
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874277; cv=none; b=drF0QAK9Y0aCKfiGFeatQQE4sr82JGY8zDESoE+RC4NEJEZwh4+uQ1vm7LLdesxcq8pwjdQbO5XWTFIY1riwlE+lDmMwgJnUXFigES3TVGC5/lmhpmq6tLz/WA4F+oMWdcRL99UYaJsemzhOpJSlxSGxdZfFNGOlPa4l8TZoZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874277; c=relaxed/simple;
	bh=/fIycOpjSLsN5BbAckoBFIWNE8YqUlYV8RAkXscfy40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBVQ1SDs08/8PgeZwrlVhm1OVNnMfizLuuAOufyjCv3LVqbg7hIXmfXejvcfrqF8DXvOuXRkGz1Q8SsElXOd4Re2v42dgBclFvgIKL0z2lEyay5xiRlgXtk16mfdebx9iSSvUsfZOjBZ9Sh8i2MuAkkKoiPN3mdgV8lB6YcW8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qivo2e/9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so1051081e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727874273; x=1728479073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fIycOpjSLsN5BbAckoBFIWNE8YqUlYV8RAkXscfy40=;
        b=qivo2e/9d+89wznBmwcZo6gPm6jQNzUVwzrF2xtSgiyAx2CBZxpkp5Tpyjh+JOWwBD
         DraaN8DKrsD/d866fSLUNWU//If+qlbJUsNMqMx9rVSFgnumSBZ9NYAXnOTkTisrAdWH
         k3cExB0dYc/ka0VYqE5IMh8wX2yqzqMQUAPf4DW5jBUC6eVc4nespzlbOON1WkhzmZnL
         AyqsAKvNAt6gOd6saWtBPxTR/NccRdSS9PFOPfMJpH8v+9zASOxudP6Tmr1sizJMDyOG
         l2sZhQ31xemVc30Gj6TRRN+uj0TfFogJ5n39ep+2YXPaYe0kquAL/Q/X4WGVgm+SrNAl
         Xv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874273; x=1728479073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fIycOpjSLsN5BbAckoBFIWNE8YqUlYV8RAkXscfy40=;
        b=Z/jj6bo2RxytLRWcEDfSjVRAMGma/dYMm1/bncSyjBF8nRRGPWNLqdfSE6E28mm3SS
         P9Yyo2OaQqndmTp0+u6OLv9KqWq4m3hqlt6ApnrckpXpz3k6LBQFJb8V2nAjwMhsHq4M
         /U6sXegaXU3xpjFV22CdUURshNbp7GQmHKA08kvMwJzX8brBDKKTHmnFfPD23sGuZ/dN
         fR3+pvLfJw89YK7nC4sZ773YHdNyodeVZq6PuxedwCJcq8H5f08nkoUxLWD/dGTFx2u8
         fCw+GzdKGJl4JyvtZV4CBwGJw2NeERGARFEXI/yL//kiJIQZtiW/zsofZ577LHR5/X3Q
         c0ag==
X-Forwarded-Encrypted: i=1; AJvYcCWc5KPnSn2x9li8mb34aZvh9T1CQyri0vE5zgPD9CMwdB7ScQFR5LqXogJXJDaVcd3UPPk5I5gtgFRkabw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl121uL1IYgsiiwPimgCKai8Z5UZWoK7Gy1oec14m7GFnTm1c
	2f76ZyGpCFB13Gg8QxdZFL0iDwEYyWPz4dk5MBhzXlzrjpMQJNgc+MKvA3IgoOjMwfjmm3znqvC
	PyrqexNFj3XJ/4ru1+Y5aX7s3NOCQxKqDgXI0iQ==
X-Google-Smtp-Source: AGHT+IG4QyEypWxp66yGczQG1KjP8WKtwfTEeOqpHMYhbQ+oat58phUwHrQdPYEaxLvZsnZ1AGx51Vzl5JVAL4d0OKQ=
X-Received: by 2002:a05:6512:e8c:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-539a065d3bbmr1732159e87.6.1727874273269; Wed, 02 Oct 2024
 06:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925173504.1906872-1-robh@kernel.org>
In-Reply-To: <20240925173504.1906872-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:04:22 +0200
Message-ID: <CACRpkdYh22c08kLWDJ3wmK+i9-C2ngXdJwhg-kAXfdy2+mcB0Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: st,nomadik-gpio: Add missing
 "#interrupt-cells" to example
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:35=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Enabling dtc interrupt_provider check reveals the example is missing the
> "#interrupt-cells" property as it is a dependency of
> "interrupt-controller".
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you please merge this into the DT git tree?

Yours,
Linus Walleij

