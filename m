Return-Path: <linux-kernel+bounces-293827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F995856C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED46283781
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446B18E023;
	Tue, 20 Aug 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfFIkFw3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C918A6BC;
	Tue, 20 Aug 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152076; cv=none; b=exU3ujDQl70hQ1f/LQvHfsaapvGK1OOYcGn/b+WmG7d66kx+KAQegph05vGGy0NBGVdlju7jSNwRqur/3xNMvIUNrmiksQoYaR4k/4OtO8vwt3f7wIYptN5cBB3e1yeIEKatLXi+t+KOglgMqEl3uDSMZ2HlfBnCdkGxo2dB3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152076; c=relaxed/simple;
	bh=tSlNbFiHVoyLktTOeBOCH3IHmgQ/H08nKa5cqmfjHR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cleuRTYF1xg2oWvrTN17mePqcLgLbWAJzQekXX0Z4UABq0LfSb5+5CGZSAJ7hb89ZtuJSJ8FuknHIJE9l1y32yx4JZxW7YoCdETi9YYWEYJteyENvDCLP17pgKTFx3icNcO79XKNOstTaJzVzc+hcBq8SMWb/MUst6qPSaxWtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfFIkFw3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso43965605e9.1;
        Tue, 20 Aug 2024 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152073; x=1724756873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6tttD5i3mX/vVV2V+WZ9jYSThIeGsCvt0KATob2R5o=;
        b=ZfFIkFw3ehdt67SeJZ8weG8QaIDzpIyEo23SGYm/mch3aVaQPq7bSDjjVyP0EkEFow
         xoYAuVahk3z2pvtKy0izGZ2kmdY88Ufw2uumJH+EAFwIWfXFYnMkhHpsdrfDBYtNz9UT
         5980GUOm4wa7kKOohGFo7hQaQyO0hOIbDKlWVeOu3UJA0NnMtqU/8jM3oAIZMplyzy53
         JmLEXM1PUyg0/kv3ceDFrEKuRk3gq6Ajt9YE7qwWKc4zpvJQVLY1XfYnsvA989ox9awB
         VQqTBFXgW6TnLc2tBquWqhIQt4jW4Vl/sqrSD/sboNnlV0uTkkIP3X+BT/p9tP/EGoIh
         nIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152073; x=1724756873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6tttD5i3mX/vVV2V+WZ9jYSThIeGsCvt0KATob2R5o=;
        b=rSaY7O1PD9Ybim/U6y90AzGkBA6fH11Awoz1tptIZRBjppI+CtLuz90Er6H5hPYRl5
         aDJhDQUDoHgf9J7FVQZIQBOol15dge55Um5wR2HpLqUmLli46idIv/cc8QmP1sO8e2+6
         sOqbRysAkAVcCxdmwNlf1Gq3QVHk4npYgNTXPehqiq1gH+J/huAA6Td+kDYT+61HBrXV
         iGsKOcgRU/Ru9sSq9aqa8ipLSDWwkohqAYcSHgWwqU+oskrvomkadyKVTSKe13506WEz
         9iw4w2Si0+nMtyQbR1gqxpM+J0sMl6zrh3bZnBds+ot1yp/ieoE4bnVVTwwhrprcjY9e
         0b8w==
X-Forwarded-Encrypted: i=1; AJvYcCXZIk4ijtFtBD6n8C7Im0ARIB3Fm4xYZkywZ9f90VSDE2YvFUY0V21K8lgMHbRNHIciMrLnWsw+x8wIdRTchJkm0Lhx5v7bJVULG5qkPFWGcehzDOtKwKZ1raZg6Y3od7wJ2xgKjiImnspsldUU/XnWbuiKY4LeNqvc+VQ6QyDavyRYug==
X-Gm-Message-State: AOJu0YwPRl4nTcqyPMP3/Gq5R/ysm/nOQeJTgdAR9US+RK2aUG/+CIzt
	fJdq+54vS4eXc4H18yWI5yt4vZ36hUTjWL/jOO1ZtJ7wUiYyMAbm
X-Google-Smtp-Source: AGHT+IG6Us/1PmM2Zg5hGVloN45QypghzSk6mi6hblPNl8RyZ3u/26GzIKWTN2QyqExQ6Zx+mqKe+g==
X-Received: by 2002:a05:600c:45d3:b0:426:67dd:e9e9 with SMTP id 5b1f17b1804b1-429ed7a5ec1mr87674615e9.3.1724152072440;
        Tue, 20 Aug 2024 04:07:52 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a6c4sm12816968f8f.52.2024.08.20.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:07:51 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
X-Google-Original-From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 20 Aug 2024 13:07:48 +0200
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chuan Liu <chuan.liu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: fix C3 PLL input parameter
Message-ID: <ypvsbxdlnao6i7i427ucjzosaurxccmc6xsyd4vmmn4wdzaclt@2wilfxi5z4sn>
References: <20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com>
 <20240820-c3_add_node-v2-1-8fd3f06b7bce@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820-c3_add_node-v2-1-8fd3f06b7bce@amlogic.com>

On Tue, Aug 20, 2024 at 05:41:56PM +0800, Xianwei Zhao wrote:
> Add C3 PLL controller input clock parameters "fix".
> 
> The clock named "fix" was initially implemented in PLL clock controller driver.
> However, some registers required secure zone access, so we moved it to
> the secure zone (BL31) and accessed it through SCMI. Since the PLL clock
> driver needs to use this clock, the "fix" clock is used as an input source.
> We updated the driver but forgot to modify the binding accordingly,
> so we are adding it here.
> 
> It is an ABI break but on a new and immature platform.
> Noboby could really use that platform at this stage, so nothing is going
> to break on anyone really.
> 
> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


