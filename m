Return-Path: <linux-kernel+bounces-227115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D9914888
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE581C21C76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8EC139D16;
	Mon, 24 Jun 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0pCHklK"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3B1386B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228251; cv=none; b=i2hcOO0HDJun7IwVbSwJEZBVsDyqUEASjuY15DCADTE0aJAyNoZVmLrK/GSrKbbJUNJ/Ilhvupx66bFijERJmbxUAB/jZ3RBTGz+AFIuoBkFPvsQ5JK+jmBksWJXaWuI5MftzPKkY8IdtQ3Pitmy3LjgvhtwvDBQHdTZt2RPBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228251; c=relaxed/simple;
	bh=4dq6+oB/CSwk781PF0vUGPbURV5g6ETTeJhVeud5l/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHlXrAMo+WpcaXq+FwFZTc0/AnTghnTKq6KQyp7lipqSefb2y4yPiUGIz4v+cvwJVWTEeIRoKe+JQH3xbNtg8XfyREHbEWGKVDmrXtFWRMiMIN7QYIv50UL4l/i46d3fX7D+IHBKOSrBS4XzMmLxJ2FrIf14B5a9rrsFLPYVF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0pCHklK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5baf982f56dso2080270eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719228245; x=1719833045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/uG0pk/rOzEYyf9kgjbXb58wu9autIPkbU8eM8hrs0=;
        b=F0pCHklK7EyVlYG2nmQ4OKISElFyQ5VUGQ4FXAIQvakUZ7lzhmP3eW9eYytPAqFyaz
         wmWem7uPJFVKtYiWt/vOgWU1v4Tav2G1XFV6kh+qsbXTYja+/3HmtrQ853WHROMAlVC7
         E+8tnP1r4RNyUiNwvkcfqJWipV1NskibcOYAe+7UVqDMDqKW2nBDcsAe5Yp9bIuxjZJQ
         OifMfhjzyE4rZdb02UQaBown3/oBff0NKpYoxhUTRXF4EYoL5nSk6z+DvE7HVPhT/IFb
         YwV5I7E18+g3S+YkmBlQPF96wvORTZycXpW0YVA17flJgie+lX6+DKCjFrguCFUScrqd
         iesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228245; x=1719833045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/uG0pk/rOzEYyf9kgjbXb58wu9autIPkbU8eM8hrs0=;
        b=wLuwgfBKxDPS+vTXwrqw95S2c0a11JUDRTx8H2asuB/ZDm/qpidoxL8zovHVE4ip7O
         AQPBwSzmGZMH0hIk8BGt/EcEsf36QF3xSYO3wyIloqZTJULDsf1wxVtEoJiF9yFF3QdI
         JvrZDbqgpc+KXZ71IxdxU/k7jj7+Rv04rXyWFBqrvL09FdNRTiIaeGqMcklkorBg1Osa
         Xcok5wYS3CW+N05RbRa6XdCy5iXz+CjZDmUPo7PrYY9Pb3oP+dKQ5GtEW3FebN0W5NPC
         iq72EC5qZ8bARJAvCt/A29G6CySumv2dRtPK+ikhAdh3ODXZMyhBZB0h9felheMfpkIP
         cJfw==
X-Forwarded-Encrypted: i=1; AJvYcCU7nBVGyBcvfeWdOA3tLc01S9YggJRnZ5Ei+/xNAqpMr1RW+IPK9jiQHs9fM4XejkcQcSm2b2TeU2GBMMoEgvoxmE4FpFlipHYkCK+8
X-Gm-Message-State: AOJu0Ywe1luVc+BL2U4MosZQbH22ug8RNpbvELWna53J12/kD3qcyt92
	NPr05Sa54tnYUPAfDMiLm5n4//aiJrul81JjhftATpOdOVnrypxGNrFe71LfFJnwnq83LVaweck
	aE5g3+UEcFiUmZU65HtTRcXpzPHZk/5yKyxSXgw==
X-Google-Smtp-Source: AGHT+IHMLqDC2rTXhVuW4+7eVR8LzUhLBmZIQgM3baPjvR31e95ip2NrsiCp0QKxJlc/jUGwGVTWHwCoML9aCJwp+iA=
X-Received: by 2002:a4a:85c1:0:b0:5bb:e55:56a8 with SMTP id
 006d021491bc7-5c1eec84869mr3670014eaf.0.1719228245151; Mon, 24 Jun 2024
 04:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org> <20240617-usb-phy-gs101-v3-4-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-4-b66de9ae7424@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 24 Jun 2024 12:23:54 +0100
Message-ID: <CADrjBPoP_ZXyNrbS7vwVOqZTBqp3Brg7zigYukf-p1jX4AtHCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] phy: exynos5-usbdrd: convert (phy) register access
 clock to clk_bulk
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Mon, 17 Jun 2024 at 17:45, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> In preparation for support for additional platforms, convert the phy
> register access clock to using the clk_bulk interfaces.
>
> Newer SoCs like Google Tensor gs101 require additional clocks for
> access to additional (different) register areas (PHY, PMA, PCS), and
> converting to clk_bulk simplifies addition of those extra clocks.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>
and
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Tested using my Pixel 6 pro device. USB comes up and it is possible to
use adb from the host computer to the phone.

regards,

Peter

[..]

