Return-Path: <linux-kernel+bounces-273037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974F9463A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C91C21428
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA961547E8;
	Fri,  2 Aug 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7f5owDH"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88586376F1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626453; cv=none; b=Zhvn3FhYHmTiV6lp8j4yBGoA+InbqrKqZDdH8y1OYayMOoumcwXuHmAWtoLkKG+V3jlaN8DBC/B6ANor4b6DN3yR2Zo2NIFCDdUjj1PkF+H1AcSEAmtIvUm5Qr/OA8NOmzf6ruAaubJtcQAU6g3U0M5whFRyvqS+HZCGaEFnEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626453; c=relaxed/simple;
	bh=jbgPxUaRpWe7IUV6OPVfKHMd2VVjNZeOVIHBRBVc2Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UziCzpJij91hobyPRNFQYmgCrl1Sjy1ppnPJxE0Y6gKijbhiEzERO/8ORC30IDQOAHHnv4dL8dY+8CU4wKw0eaupw1EdLiElrRtA0Ti4+gBv0uJsFXQrm03VJ+0sK93uqbD9OCuZB1e/ZTUqZGLOn9c3ktw/yaMYXkejTg1XVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7f5owDH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f880c56b1so70679727b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722626449; x=1723231249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZNwK4s34iYGvIbS46dI7pOTIc2gw03JA9isN6WtOpc=;
        b=h7f5owDHZCyceSJcMJflUWGrQOKrmAMf/DVuI2Y9BVtqZEYDSY42rZlJns5OQv4Jgm
         kYUdmYFVRH9jgJFVUY/lzW8fZjdQ7bpUHhAwfFrNCPL1hO7ZwVGFNxZV4GPWy5t7W7pN
         5AspOYE4RzVLoQfp8jeSCUuXwyeKvH+htIIqS4kzQxdMtr8A8hP/yHWq1GhdDTv4baZ8
         s2QNueIaZxpEq914c4C7ZD+k5x3xFP83LeCV6WOlIzF0lFCTRGw8nUyhNKTAwY9ys28A
         6IWuNese7icnurDLtGsbd/otB2W3tDN9JvK2M4pkqtE5vYCxPhp3e/8eUu7AFe9z0jDr
         sgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626449; x=1723231249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZNwK4s34iYGvIbS46dI7pOTIc2gw03JA9isN6WtOpc=;
        b=NjuAFUlzpvjvhiZaGFLW85Xns6PLp4GXWw/P9hMltu2h5dhG2Eau/KXJzOLNMEywCU
         cpEe2/5HynJe1x+Yq4qU0hns74fkXUBUy7y8ScUNZzbJR9Eh+EumhyrpLZ3T3V6SJJWS
         r2xdWnr/MQPt2Ht2yDsjsnPkIXUXLyd0cHUINfw4q7OIw5w3YI4NSXTBSJ6cf+7fPHYS
         igbybQ1obVq6w/v1O8t3wi4QLPYnoCGjmaXzoeqzFWb9uAURqcPtCQamgPdLL4uy8gfk
         9Aowga5Cne197aunNVq09c5mW1GU2Gi9OfwF6vGMN4zANIdmvpIjJ4lLSdoGmDGail5/
         XZNw==
X-Forwarded-Encrypted: i=1; AJvYcCWU6NT7aEXt74t5j9+bJ+DEETMt5LjTG4Vo9gOhnLvHfZktFt87BhPEerW+m+vGhSZClC6RoBiLR0tOr5u206DILR7cv+fP30SIz5m+
X-Gm-Message-State: AOJu0Yz2AeEeSn2PmGv+97cKlye6+fMB8viv8JNIQ9tDhjJEL8CLEFcG
	v4d+injGlwE4E/f/CcwQgtEJXGl4Qp0vnCYqNJFWl19M3BWhrrLEkDkleI/6xD4gRHXzUL8INZa
	p2JAFTgxIn6eZCmZl6hpkT+y0mUXmjPivHcFCxg==
X-Google-Smtp-Source: AGHT+IEqzG5OJVYb0N/hhSy3/aCVZpwuaC57g1J8oBIELAMwqUOkxVNDUu61cFnvy19WDb7qlbHaefm1NS450MOTFBE=
X-Received: by 2002:a81:c20e:0:b0:63c:aa2:829d with SMTP id
 00721157ae682-689637fccd4mr52822217b3.44.1722626449505; Fri, 02 Aug 2024
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com> <20240802090544.2741206-9-kevin_chen@aspeedtech.com>
In-Reply-To: <20240802090544.2741206-9-kevin_chen@aspeedtech.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 2 Aug 2024 22:20:38 +0300
Message-ID: <CAA8EJprcmQvE3PjySxBKq7Qv3JHJHhic2aQ5MDnwZaf-D=K2Rw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: defconfig: Add ASPEED AST2700 family support
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, lee@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, shawnguo@kernel.org, 
	neil.armstrong@linaro.org, m.szyprowski@samsung.com, nfraprado@collabora.com, 
	u-kumar1@ti.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 12:05, Kevin Chen <kevin_chen@aspeedtech.com> wrote:
>
> Enable CONFIG_ARCH_ASPEED in arm64 defconfig.

Why? Usually the defconfig changes have "Enable CONFIG_FOO as it is
used on the Bar Baz platform" commit message.

>
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d32fca64996..b393735a695f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -38,6 +38,7 @@ CONFIG_ARCH_AIROHA=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
>  CONFIG_ARCH_APPLE=y
> +CONFIG_ARCH_ASPEED=y
>  CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM2835=y
>  CONFIG_ARCH_BCM_IPROC=y
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

