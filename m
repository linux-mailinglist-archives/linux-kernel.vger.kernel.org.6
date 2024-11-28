Return-Path: <linux-kernel+bounces-424567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4B9DB60B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94274B21EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690B15B984;
	Thu, 28 Nov 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuSwNG/f"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3633152E0C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791146; cv=none; b=IRQKc1NV00MCyYDT1GU0+Fgm5lYNHwqJqhCcr8vPNh9IhTp5WbmARdGWDrZk1VmFCw01CYwbQQEjQjvIlukGIORTFwkuLYQMi/dSL6OTqVfSTNMswRGMlB7HdUrZs//u4vvbBQW66BDyTImv+1r5wUrUA1SXASmIURKpbu4L6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791146; c=relaxed/simple;
	bh=8TeU+tv7JrsndEEL0MAFURTZ0bIagtJxFoR3pCrar/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZVtOX3FErhOFzFFCwvoxu/0Lo48QbZQwMud9/9Lo0T658paxJnT6Um3p1VjCwacemBmDRVb2t31AC8LAxVlPkyWjh/vUjXJUARt4pQo9O6IHmnEtyf8xWvhkwz+d3CeKbrwBzcddnbpOEhT7r1cajXG6I1MMyURkprhIr+Aa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuSwNG/f; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71d4adc3f20so374103a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732791144; x=1733395944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TeU+tv7JrsndEEL0MAFURTZ0bIagtJxFoR3pCrar/I=;
        b=GuSwNG/fjg77WtQNCYs7QNKypAHxDadLQ8uxjTsnE8GHWBpkH3E8w//UYmfbqIF9VC
         7tWo5UbRr1faHsp4pwN4MLln3KTIV2fzFoY4fAdxzuSXUDAMWjbbNqOsRo2peXYvgb5P
         KTmXak3xxjYZTKrBKlzq2cFJaOmsizt7E3Z8nYUwyTvNGrwuf5dm6pWT+6FNZ84rak3f
         bM6lNofylCSolLjRDd1G2vgccnuIEzE4RqfU8aefs1ygMAqL4mBBpDvb2CJpN1wkTO18
         zj67Uqg84j7V5iZPitNmn8hqifYCzbnZcE3WDGPaFdDNwU851FgRPpkfra1TDfVENc9d
         l26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791144; x=1733395944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TeU+tv7JrsndEEL0MAFURTZ0bIagtJxFoR3pCrar/I=;
        b=uJZd7pa3y8c8tdzI5bnyeHBOTn+1gBM4AFq8Cy1mU5KKBXdnkPYL+H9qfV8rvB54nc
         6JbRmzsmTy3625udYmJQIuBMg3YAmN+e+VQoZIYQjH9MmaxdKjECC2n1lkY7gicJ+Tdc
         0E+ek9XGwzPshEqSXtJ0Cwy2yHCAnOccQodc9aIvUg76+zoZq82p3qGlNledRMBf33q/
         ZCE3srjO7V3BDFcTQXYddNoZEnfyd07uO4cTvUdHlgFFCDSiZ5hLaIatrE+5elvLSb4e
         njJDToZ3+EdXYXZNs6/AJOqgmWopcay9ewsSFsdanrrfFtNEr5mSWZtROrMw3lTbz3jl
         6vcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YCtxFB/I+0FnnQqcEYe99kFy7xfj7Pqc3e4kLRFTmdOEdulMVFAkTUMCibnu6f+Cmu18sqfrTdUXkcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQR0HtFmi9HV58PRYW/HFPvc2rLdDR5kF8RHz+ggF1P6UqS0tI
	Mm2a/wOG/LnQFR/9S0b4clc9SnbtormFzcJsaDmQZ9rbu1hWuG/wpIa+n3HWrqGv48IvzxHGjf5
	adoanDR9Q2bgWwWufkPBJ6jo/H/jyW9280YGQNw==
X-Gm-Gg: ASbGncul5GV/KfPUNVHOkAiJDDw4038lMjgfEF6XtlrtEwa1d6jTHNd1Pjt39Bwyp2R
	cbuCfZNH14wL3jhPAx6Nh7UKa123dn3bV
X-Google-Smtp-Source: AGHT+IEe3DTn7WUrmyIboVCIgXQ/VYxi2uKjmWccnEGTGP4Hj1gIqkfk10m1pzmDQDSsO2Kqy7TSKyl4Kujutj7mbtI=
X-Received: by 2002:a05:6830:52:b0:71d:51a4:ed48 with SMTP id
 46e09a7af769-71d70c11a6dmr1359704a34.8.1732791143800; Thu, 28 Nov 2024
 02:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-dtbinding-max77759-v1-1-733ce24c0802@linaro.org>
In-Reply-To: <20241128-dtbinding-max77759-v1-1-733ce24c0802@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 Nov 2024 10:52:13 +0000
Message-ID: <CADrjBPoa21ni02Gs_Lsv-r5GB-ufD19+Z09g=hun39w4oDYYeg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: max33359: add max77759 flavor
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagan Sridharan <badhri@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Thu, 28 Nov 2024 at 08:51, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> On the surface, Maxim's max77759 appears identical to max33359. It
> should still have a dedicated compatible, though, as it is a different
> IC. This will allow for handling differences in case they are
> discovered in the future.
>
> max77759 is used on Google Pixel 6 and Pixel 6 Pro.
>
> Add a dedicated compatible to allow for potential differences in the
> future.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

