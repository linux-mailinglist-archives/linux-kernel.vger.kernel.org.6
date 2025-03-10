Return-Path: <linux-kernel+bounces-553942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19644A590FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BFF7A4EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8EC22577E;
	Mon, 10 Mar 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vz5X2esZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646221D5A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602052; cv=none; b=C74Y5JPmwzNSKkUPNcgNTJ9ttpVxiYSl90D4DP4oRd73hmS+feDBSDL9yYXGLjjKnKUd3/doWphJBpiLldgIzQcuW7Dm5C0SeOcYtcRkG7MMQQNx5B70dewfWc3+mWiRmGZxQBS/UERh6VI2I2no/t7vMja3YbFYBoPeDZt8H1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602052; c=relaxed/simple;
	bh=JL/iJrs0I5b9N2nPbKpSW6ls+LbJc9PGy7+bMaAhX1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krVXghzp3bquQiBjkrxfAEYVYEEe8971feo2Z0znkecF/T+Q7UeW7ixXrOxm4FKudnd5w77xULxIFCOe8LVLJgPii+CdJJ2e03dWskKu66Oq27zkJPZFsojBXIbabFXqrfNQjuci4cYV8FTdBEQs/VNNMDlX6Wol+lOpLL3Qf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vz5X2esZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390cf7458f5so3815037f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741602049; x=1742206849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/apE3VuG/fufAOpi2xtHrpN+LPCwiTLqat5jnVcZLFc=;
        b=Vz5X2esZCUrYGhNvwmZms3LEf5m2fIIeP8Qo4q6XsYGl7HrRHu5lq5wZ/dYrtbeyFf
         +e3E3DU7L9sMiDZjtKg750KT2ni/jqa96gskQn3XzM54acNmqEixqTPsO7SG21OrzIU8
         l9NKsvIyvj6pOl+Q4aNwB8OndREXTmKfQXohyJU++oswyLIWsRJl/uExzw0YoY4NK5EZ
         +tV0Df8DXb3LwWicZlgj1V/2zX6uaJrDzah3yy/KYWWi5VINzGQUEL4npoFAUal9PzPq
         uaW2Vi790cQeT/KuuwUDSd8/Teq60q032FZAVNhBQlg10uMh/VshKAOLQLBNMAFOA4AL
         zOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602049; x=1742206849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/apE3VuG/fufAOpi2xtHrpN+LPCwiTLqat5jnVcZLFc=;
        b=A00QpNKnHaAef62Psp+VyJfYmNNiOhDu4vXeuY/yJ0aQi4tZUg/SPGo3lyh8ecjllo
         vzz+FB0mB3TKh3p+CO68k2n7w4fP15bJNAJ3MjhohW4Dx5YasEBvlwBqAWVkqkHmlosu
         KTadnZyk0QVNj+JPIQI41ausp7CMCpGEQoKiyoUhI7P0jMsJ+W3EPDLDjg94lVUgoVHS
         CqQtaJ5J3EXIAPPS5ZWyuBVFLl+A6XHNmyhIau8bZSJgYApMSph1U+NKXK84xn0PYTr/
         ujql+hetFljCt9HmMwPhwMmj7xsm8vH6rIeivBXlTOkDhhz6PSqo2Gpx8LOrZ0/6q4MK
         9e3g==
X-Forwarded-Encrypted: i=1; AJvYcCXwSwv5vLiQRu2++1+P3SmWf9MjzIBHItHg1U0vAXIoQ2udiij5aiTxLRTnItdyNhByv/1H5taG4yJzXX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0mupX9wr53iI4J/DH2u3+h3/7l5mxZ0S4L1bkq1waTv36F0G
	xjdI3CgfhNWhdVITqcFNaxn0bx/6dlanqEUCi74sPB93esSOMOrVUlmSwOe5TEl/9rtZXLEG2cJ
	A
X-Gm-Gg: ASbGncu/2t54uS6gEopDGXTgAAZwuk8NWreR4MVYbF3yJLF88/kddAfVhMI4CELXRdC
	+kAdNtcLy/H0GF9MW/7yO0Xan3P88pVGwJa1zraZIsTp2FP1IGFoSALWhMtQ/visNmoEpGznqvC
	35EBkZQq5eUF/ChhomxN8v3P5FID58z2qnHrnjHRLic9FIx4aJU6xlMYSnnXYeETrG02Vduq5kv
	axrBle7oNwf/ieMx9cFcU0LQPfqjgT7T60vAni54SGjUgqdhhOc1OaLkdWaXlt4zRgGHCygu3vg
	SMKLCkyVhyn3k+pw7PpbpaztGySTgo1+iW+etDOp1Cgl
X-Google-Smtp-Source: AGHT+IFfzfWd3QOlDox/vtQwZeERmiQYf6W46ID0K0ZY6jsQM3TpjDckCeiqjrDVUJkjElclE1Hehw==
X-Received: by 2002:a5d:59a8:0:b0:391:328d:65a2 with SMTP id ffacd0b85a97d-39132da24ddmr10077276f8f.38.1741602049284;
        Mon, 10 Mar 2025 03:20:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2711:39c0:fb51:b639])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfa52sm14068218f8f.21.2025.03.10.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:20:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Agner <stefan@agner.ch>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: gpio: vf610: Add i.MX94 support
Date: Mon, 10 Mar 2025 11:20:46 +0100
Message-ID: <174160204380.20418.6002822066800519604.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306170921.241690-1-Frank.Li@nxp.com>
References: <20250306170921.241690-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 06 Mar 2025 12:09:21 -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-gpio" for the i.MX94 chip, which is
> backward compatible with i.MX8ULP. Set it to fall back to
> "fsl,imx8ulp-gpio".
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: vf610: Add i.MX94 support
      commit: e93160942585832a1836381018daf9729eb9ca64

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

