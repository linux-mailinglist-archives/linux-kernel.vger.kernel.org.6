Return-Path: <linux-kernel+bounces-543890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7BFA4DB25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223E176672
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5E202C2F;
	Tue,  4 Mar 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lXUofKZw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460C202C3A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084801; cv=none; b=HHgv0N2b+KRUctRJsBH8XdoOtPRItUrBmLcdCnJSChUPEYx8zBctkQhxFIJFtP844DSJhb+rNCwjKIZpVl4hjZQE2uZkzVVrJC4vzr6MREWwq0I9NISJT5KxaxFKrhTq9dTPnbT6ceWej3MgPuZvamuGOi6Ue0WjbpOAojkbYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084801; c=relaxed/simple;
	bh=nzgcasT8XlfuMCUiPfV4W/V1AJ9l8OcLLCDvCjZ+wh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxfqnxAs/l81bHfN6FeTP3qYb26qkcmSg73YwDWaEw++Yq8ul0ks7WLN12F16G7V0Z1ALFifAEuMAwdGZ3VRDoAYZbxINXVACkip5QT18AIkTnxAMuWX0JBr2HRBNQkDsasWbeiUZZXhc/1fEzIQPgubKRiIdkp2eQ7MAcVdvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lXUofKZw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3297517f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741084798; x=1741689598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4NRBkDX3tmF4bL4mAlAFQOe0WTBDnxQ2hATnqOky0M=;
        b=lXUofKZwkeg5fvE/WuQp2lxCVJSFmUWajPm+wtvu+oMFDi0Y15yee0mX3AZNSTBkRD
         Djr8pva31HiMPD7CHIP4r2gRjj7t8UY+/Q6gHZab5NjFZm9WWkdlJLDRgQlWo+EwgoSh
         NrKNVeB3ifTsGZ32kv3wWJPfWQO1seOwiD4+E7y5nYGRqZ/IkCccg0y7Bq36LTwj9x/K
         3ayaxs8JJXRmqaceCRa3K8aS7EljOB2kVef+RHXsxB4wHzQtgHznZGCiQosVetVhHw3p
         dpIbKcN7Efob2ZtLvwLmfx5G++/OozelcfHcLLSB3KsqhGVhRyTdzSngyJ9tH3tZLkpI
         eQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084798; x=1741689598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4NRBkDX3tmF4bL4mAlAFQOe0WTBDnxQ2hATnqOky0M=;
        b=ijbu1VePU/XWLW7UCTCty0p6mA2k4Ozc4BR5kOVKqK4ogrg8A3N+nTMoL1ltcl8pP1
         dQ9spXDQbR/8ihO0yHJHwSXK9CuiWMkuQJ5AKd7OhePoqP5NVyADJNAEXICEAIT6RG1z
         fQhykaR33RN2T+cEJHn/AR5Yygzfyp5CgotBCAKlkQhTzDEybVtNgElGw+8VfvDC7Ei4
         MX84hzNlxAvzHhEQKZDwuTSGFoQ2I7icUOspK9OpNARxp8BLf0mgz0+beUoQ95suGL+a
         IevVmuJYo5S/VxDf40BH3lET/6G0lx9CDB33Ny0R0TCcYkSz0Jyp9fi2wGCxlBgsVcAZ
         ZLyw==
X-Forwarded-Encrypted: i=1; AJvYcCV/6cKGAacOlJ5jkcRqV+Z2+jdhkk4uUlnJlfQOl8Yu1hbgAlCh8j9/Q5zCuAu7MM779dTIXatq+e76pqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+PxU/+/bONkDLI0/e20WeZAh93H9YTA05Qxd3jBredtqP2w96
	+gNUHY8L6YTMH/VZD1sbuULfn5iDX1bQvsUKTQDk2qwZH2105GBI7vmxLYoWUaM=
X-Gm-Gg: ASbGncvGoCJxfRWGCNOkONdK7+q0VdFiGSqlrGb2ZqdxXMEabxOiVOw9mKGtqVJZmqI
	VGt2b6dFY0suZ1d8ho4TO3+/XgrZNffRSDIF2a4kPtaa5XEhrQDr+4p8bxWAMn8oHt23Dv9v7Gi
	YQK6hDtlVFk1z4+JN6VsGpjnYyZxwq+OolRP9GEGnQ6IrQddYFYdEmnXLaYbrEPhdlt6gTNIJx2
	rqtKenNVR/8xXuMQHc3dyWcef/sTn9V9QJa8ggXLw8fQYA9K57Xh7DwKFp9rzFodMcU684fp9vA
	DhjRi2G/pFY19OFOMYcwSOjfy+MiEG6hyuZZsZvHCnzV
X-Google-Smtp-Source: AGHT+IGI5YinM0Fmil/KbrQRp+7dyNZtKk6Cw3iHPUYwQZ6EfkAXgPjAmvyLHMyqzvMus9tjQNoGAw==
X-Received: by 2002:a05:6000:2805:b0:390:fb37:1ca with SMTP id ffacd0b85a97d-390fb3705aamr7047086f8f.53.1741084798504;
        Tue, 04 Mar 2025 02:39:58 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6018:7257:350d:e85e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm17602859f8f.63.2025.03.04.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:39:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges' property and hog nodes
Date: Tue,  4 Mar 2025 11:39:56 +0100
Message-ID: <174108479375.31979.16946190179335788449.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227175132.3734524-1-robh@kernel.org>
References: <20250227175132.3734524-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 27 Feb 2025 11:51:32 -0600, Rob Herring (Arm) wrote:
> The Marvell mvebu binding users already use 'gpio-ranges' and have hog
> nodes, so add them to the binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges' property and hog nodes
      commit: f2f3d5d62f6fbdaef46d1991086265a497b3e24f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

