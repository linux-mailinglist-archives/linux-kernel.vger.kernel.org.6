Return-Path: <linux-kernel+bounces-518920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E50A39632
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F869175141
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303E1E25F7;
	Tue, 18 Feb 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcKf2uAz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4122D4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868731; cv=none; b=X4K/JuT6ZIUxqtJtnc06UCFBtysU3r6VJcQ4wuRi/nWmieBCoq19RrQGfAH8aJoW+vVwkOu+k8pswY0FrMk1gBt2Eb1yvs+GYRQdPNWA+xhQRs92WEXoBHPTW0Ac65KTtNJjYX2dYoiDyp/vPlrs5LK78Huc9vDa/hjyG2ui5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868731; c=relaxed/simple;
	bh=hohWpCiWYl0GtjqjZvwmp0qm84o88J+U82iLURk3iYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nqKW75yMOYNDTzL+PD7tL9AY6KSkHZsYbdG5zi1lT1LCC0DOHW6pAwClhGPwh+UM+g8mpal9qtIweu3iHV8r/FuREmJUQH4/1XcAgfNxKeo5u7tv3s3IJkc8Il82bfRASmzTry908YnGCH2cQBhjwQhB/N8OyWf6acyUrRpT348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcKf2uAz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so54088335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739868728; x=1740473528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5BxUQzEBXqVbjM46JfdgSswKF0/4bTgi+k8v6ADAZU=;
        b=IcKf2uAzJdixDAPIRJX20sttXX4Zh50YvEtuaXY/RyypRMLu8k++/tNOZpNzSpCJgg
         XFSfIO0RJaQy0y4Odxa1Ds2VFsanooUgDFqERNeC9VbosDQvZGa42i9dY89QdO0RUU+X
         zswOLsO9VPk2zZ6ELQHO6s497EJiTLuGgKq/9TgLKyHdLkNj4OZ/hbp2/9sNIlaWNMkf
         PlqJ1QH0pA+8QAZQrNseJxV+KZLYNawLehV9967xJqM4wTKJfutc1egHwFG95SyGClyl
         liq91RmRAO50rC4ChEcZ6U4FlrW82QQZivaHN8JNdCQFm1GKU7gvUCRnH2P9q36kl6Gi
         Q+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868728; x=1740473528;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5BxUQzEBXqVbjM46JfdgSswKF0/4bTgi+k8v6ADAZU=;
        b=xNd0FDb1HJSOyocuYzZEXlEnylL2CQYhtyX7XXb+3qRRrnI19ujArJOErTrf5eQgF7
         HN5r7x9JkXxF8HsWur2dFBl4F5IlRz2FknJYsuSDTvh8T7qfSotjbFimqIpBaaZC74ZQ
         b26RBnPejUphJ4l1OeL1ZRPfbdzuoqIjO07WThTQ1MnD+gDkyqheJxOQ9UHrqCBFpnby
         ni7idJPjq5XSWoKGZqNFziIKklGlL5oslA7Sd60fgrinpxWhUdqfgkGP2NKwmP64jlMB
         NdvPybNl02x396UEacCo2Gh0AMYiElOUMQKSuUYmKQVuoc8h5wFatOs4+Q/MxuZkeSlx
         YlKw==
X-Forwarded-Encrypted: i=1; AJvYcCXhhiDfWHFRNaVWCu+of92/oKXC8RiTLiM574qXKJPP9QEPnbpRwpoKcQichZaq8wBa5z1hcP/cdgC98YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA9gfLCn7CZl+44wXacwQnI5YWGWuxKm+nX1A5b2bgadrOTNe
	W65l6Kc3mQTax2skrOJKEkJNjOQLcmq2G3fUqIWvt2T0n9pg9qLgSSQjHO359Xc=
X-Gm-Gg: ASbGnctHrNrFZnFPreSb/P8j46PvZ0+y+renRPuK9fVYD5IJVETelEaszOakogFTfYQ
	ltYer0OHGo1XPGz0zivfpmtg/3fN/GW+iiWRil1jgJKqRYULIqFVhXVzVhE2HV4UqeyZofj4BCI
	Bfq3QrJvS7kLuIo1c3DpSLx52erT7rNcGWCJ/VTHfQWe+c4bSium9TCPJKc1tvU17Td/KsSw6i1
	eecQWY+zkhjcAzCQo7uMWLijGKyNDBuV7C3A/xXnx9WWGPwp//AQXH7nHcp9E7Z9E7dS3ENlwlO
	cifP+PpWtDuig1XDhxcKpYuXnge7SP1lDg==
X-Google-Smtp-Source: AGHT+IHQey7aBKjO/+bZ8evsTyt3LBHAHH8MDbvNvER7wVei0OIq3d9tcLNdJqfWdMZRdCMypqcS3Q==
X-Received: by 2002:a05:600c:3b1b:b0:439:9595:c8e7 with SMTP id 5b1f17b1804b1-4399595cbb1mr12314565e9.0.1739868728258;
        Tue, 18 Feb 2025 00:52:08 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439872b5a46sm43381535e9.32.2025.02.18.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:52:07 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
References: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
Subject: Re: [PATCH v5 0/5] nvmem: qfprom: add Qualcomm SAR2130P support
Message-Id: <173986872682.63312.17862303711697418550.b4-ty@linaro.org>
Date: Tue, 18 Feb 2025 08:52:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 17 Feb 2025 18:33:17 +0200, Dmitry Baryshkov wrote:
> Qualcomm SAR2130P is one of the platforms which require 4-byte reads
> when accessing the QFPROM data. Fix several omission in the NVMEM core,
> rework the QFPROM driver to use readl() instead of readb() and finally
> add compatible string for the QFPROM as present on the Qualcomm
> SAR2130P.
> 
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: nvmem: fixed-cell: increase bits start value to 31
      commit: f5175dd69428ab517c8d68e772c4d287b6570d8e
[2/5] nvmem: core: fix bit offsets of more than one byte
      commit: d5d9e982a0886a1a99a1a8ef5320c57e257b4fb0
[3/5] nvmem: core: verify cell's raw_len
      commit: 11ccaa3121119eeff9ab9d537e0cf6be3b10698b
[4/5] nvmem: core: update raw_len if the bit reading is required
      commit: eca73df072715efb5e880514bb8395e0a4e74a59
[5/5] nvmem: qfprom: switch to 4-byte aligned reads
      commit: 4770132f37dbf327d25455d226e54fafbef6a5c4

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


