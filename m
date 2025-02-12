Return-Path: <linux-kernel+bounces-511887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38CA33108
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B213AA985
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA81202F71;
	Wed, 12 Feb 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUPxZGmH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DA202C3B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393406; cv=none; b=bM+USaw4l82CVR2nZikARj3NifD1ziWJwobIvB7yp9Wmjm8SlLtUoYvlCmScidhJcIyCOt/hZkSbidrZPY9haEEy+cv97964lPuTs0QBgGhzMbUkAEoUn/uA1Ogw8ClSCwdT0zS3615DXEPCMXip48gPKbtq4aA9EoWB3yTaJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393406; c=relaxed/simple;
	bh=7QUo8lq0zOXvMRM2Kkw4Zo86apOpRGfWnw798xZKkyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gWhRO8An0V3Sv/dnizrDbPuwGW6kA2awQt6RiPujan/I4d7tpcvD23m5EeZ+e+hZGrPioHI6GwjYvp0Cqto4ILKIsJ7Pe49OZ3XPoKAWZ8/8kB6LTTyRqeJNWf8xFfZ2XAmaEflvTOJd4/TtCMe15qYGKmulHxgOFuI1XHCwdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUPxZGmH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43938828d02so205685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739393402; x=1739998202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05bFiLRqtjieBdQP28ZStS6jjJuxslhK7B+dgz1ufHY=;
        b=sUPxZGmH6+T8TfWhYjbrhXBcSBRJa4d7zR1ZCLnpgdGzzyHzSr8de3fKfCIU+FWFhw
         ptGecWGAIhHCS1THIHD/0d5YWTHTdNZqpqyM44/y7usTRj+3ehhpNJVYcqcpog6gVag5
         Bz0l9FW4lT4dq3Shg5Vb9wx8M69nKHEyBfz11wGVQLWKWPBsNPTfKlsZELBXQppjeakJ
         W6GFcd1CCazI6VTq0kDrAu/BW4NMFal2bp0jR2e/sIIbRiypuuJfJj1wpfXCkaLeaR/J
         Tlms6obbVYht8vo+dlVOBCSng3/6v6GZ0baCghapHjNdsePqLkHdFk1GRsen/3Ej9977
         AkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393402; x=1739998202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05bFiLRqtjieBdQP28ZStS6jjJuxslhK7B+dgz1ufHY=;
        b=E+TqHob3FJIIBOh+HQcXKWE/e1d1y+ox38hLmWQ+swrVMI3CkP9CmY5HTQU+K6TfqT
         DIaGGvl7oOE641IMA8sTMcx879st5R6bNwsGljRJVXN+BgDSCapPq8xcTth5npOSvYgC
         QQ3xDv3KFuZ7Y/UDEFLqwCdIzHcrDg1hew68b9XSOlzwpqwa7qUPu0c9CUzi3VMFDIvs
         MNowJvweDNMS4L8lWG4B80JHPS4UUiQYiXrVISv5tKoamExJEeZQqX/S52D3aYLwinXN
         pJVzm9Xgb0dXWS5QfZdSp3EpLyIy6o6JpJHS1/+vu01ktCD7yUV/DrV+4hSXgV9TWFLY
         W59w==
X-Gm-Message-State: AOJu0Yzc2Wune5bLR+VJ5ZCBwnt2JmuktH2wY8hVw+YcFlypdOdo4O3z
	6vTPYfxVPUjVmPtKFw7zUVLz6azAKrMxvgapaMfBkhuufMWnS8JoDphGlkAJ4Ak=
X-Gm-Gg: ASbGncuNe2bgb822n3c0mh9ub3dF0pMliK2McUMcDQQFSWJ8tO3QYAiTWxU7wkHmNie
	L26kBCa0XcGD3K5T/ieM8+OuadF/jqJvqTNLkrVcUfj/U99UsVVC/LZSHOqAC5+U8jnV84lzFC7
	yI7z+gw/JjAWOH+Zv0+isVpUh8WePZ8hlt1pshp7v+VSf8zTJwcGXLvRx/9SRzPnK/RaYx3fzxx
	Ie/yECRdnAo4dw2aG/MXsGQkLs0Rjjw430AF5raWgNzSVfqMUDObEw3JfNVOEXM5q2cT5LaGs05
	HKYgAZ6wW6sqWRv4RHePU2Tg/El4XJs=
X-Google-Smtp-Source: AGHT+IEBtbJJPvZYtnqI1EcUYSzvnE3bHzpiZAK+Kj6ubquz7Vmwq6Ph8AWnkEWgLrniziBTqXUdZw==
X-Received: by 2002:a05:600c:5103:b0:439:560f:e7cc with SMTP id 5b1f17b1804b1-439581bfdd8mr18910825e9.6.1739393402471;
        Wed, 12 Feb 2025 12:50:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a056151sm30461495e9.16.2025.02.12.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:50:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 imx@lists.linux.dev, loongarch@lists.linux.dev
In-Reply-To: <20240717-anvil-ashy-544e80a1317c@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
Subject: Re: (subset) [PATCH v1 0/4] Removal of non-existent DAC nodes
Message-Id: <173939339997.59416.11108011581545463665.b4-ty@linaro.org>
Date: Wed, 12 Feb 2025 21:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 17 Jul 2024 10:37:52 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Recently I've been getting triggered by abuse of the Rohm dh2228fv
> compatible to get the spidev driver probing in Linux on development
> kits by employees of various silicon vendors (like NXP or my own
> employer). I had a look around the kernel and all users other than the
> original Clearfontz board added by Maxime appear to be similar abuse.
> Drop the non-existent nodes from all of these devices :)
> 
> [...]

Applied, thanks!

[3/4] loongarch: dts: remove non-existent DAC from 2k1000-ref
      https://git.kernel.org/krzk/linux-dt/c/854a080f0b73ff966a813ec2dc53891831daa28d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


