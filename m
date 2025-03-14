Return-Path: <linux-kernel+bounces-561703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4ADA61509
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE31B60306
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5420012B;
	Fri, 14 Mar 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKuWq4zf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A51FFC46
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966344; cv=none; b=CWjT5dn+qttHfce06DNYhPyClYviVYKp+Xu+6mIgkxTLk7MSvlZT6KrHwi6rE6dgHe8pKvH7m5Tqat0Y0QqedMo+9z38fpJSmDs9U1XQvVVp95tToS9hGvin+5kO5pQiVLsoHWwUCUohg/FRgkS4sqaEvFhnt0Zh2cZY7gB4pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966344; c=relaxed/simple;
	bh=mjckCbx8V8lajM1SPpyowxlZbZf9qWy1YA+QL/9g9as=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WpSJtw9p9r11mkLJMLqCS5WlPhWpt6e2TqtUedSysFBZAgmFnGn8wBE4zjcrvLcBW/HkOQwBQdG8RyirjFF6lJEwcBaO5ec/Epofh+sOsftOu3gzSGPM34swsOzPXshse+kaqsZcj+ufsbY+vgB894MKVLk9lzuJSznxCkpRpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LKuWq4zf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1473521f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741966338; x=1742571138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N6fTM6SFDsTbt/1MZG+/5cRZlKHEghdhbe8yHn1vL0=;
        b=LKuWq4zfvLXjklAYuCVcDYSRCCtj0W1Lq243Y2AXP/K0ajgBCCih1ZcLbayOmCDDi0
         RgMyt6l+g+no7qwnj2g1SHkr9TxGrecAYppJlGgQrr+PH8K1rbBouWqNvxfPHQTUqON9
         opv35RrZu2x+DUXCXRh6fs5EDXD7KxAZJVFkNPDBCIzUIDr7FvzCc6EsO5jI5OM7k+6u
         mkdaXvqRyHd+x6LxDIyM6/lhDmm7lzF19+RfuADhzaXdDZzOJ62K3mKpuXq4/FLc9sxz
         yzyEC2DKHBYdZF0js6f1AnjssmfbZ1REoUj1R/SHtREW1KLoWITpDQSm/KR2FtMSt2G+
         JH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966338; x=1742571138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N6fTM6SFDsTbt/1MZG+/5cRZlKHEghdhbe8yHn1vL0=;
        b=TbvgV0lsziNukeo05nwdYC0HmfLiHx+K7vXil+pV8g4VjbjD7xuSzFjBmBo+NRnPYQ
         C4P2fX0DKAM8r/AS6s6FvIX6Py85Sd/iH1JmBoG18z9L4tnxUkCWu7A5YPtdeTncyTBl
         wFEyMrmzyMtl8MBrqXE73k0DD5eoo21J/urIDPMnXH89PVA39n3LOEGB9Fut8/3SIg5J
         r6gl6VdJrIsMwIxDpQhoCGcMYsgRqXwImHulwA/aQhfazAegulfmbgPZntuHOdgxVL3M
         toorjFWjjshUgJ1qzVVTSVatHrn/saP/e29OCNjjaS3OTBE0M3TbYBpMhOGzdiDdvTap
         nEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVO9XZ+9lfGo8dnaU/k35deBijU9yzBderLbHU2M4m3eicmOivGfKKwPauRTOK+ehFDdDHodgcwnINdQRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaK3XMwd+8pJ30sK9uPy0QHnXEqvJcZVhbgGssHSXjWeIs3BJT
	m2TWNZ14wH1z0Fjo6+j+BKI2nppR+8tNvLMvFebfM6+/yP7ODSd494+5S8e5ySh+H+TXv+iHOf1
	9
X-Gm-Gg: ASbGnct1yRUUGiTr3eMy2XAb6/b4iJXcm5C//eI3H4Sd5kb6w3gLHbnvsEeAhRCOZRI
	Q9tvjHSQ/C5OAOSqTu5g7JkFsZrekVxio86LmkkC5xF3F8zA/FbcplEtxqnOM+TsD7AdI1Fuk+d
	Es+hhqKf9BDi4t2N1EnsTDxZmsnKB5EtVSicujVdANiBfeVocJViqo8mmnTDwvWhqk4X1soEiqd
	969QPIG136AX6CQXiks1pMIWSZbvPMWL5HbRP8eVK7f8ZqQ2t+P1fbe3zoJsYGjx5QnC3zEcSqQ
	2SjOIYnTp2iBvcPYp4hSVAllC6ham6B/TjxPmK0poLds15hgFsGIChpz5yoTB+yeVRYxZg==
X-Google-Smtp-Source: AGHT+IElbbi8SqUshMCl/+GUOzbAuMlg/4w/X9x5Rezrz6ar2Vdo2Qvg6tqIZ2ip3uemwQDmNf/X3g==
X-Received: by 2002:a5d:64e3:0:b0:391:2f2f:836 with SMTP id ffacd0b85a97d-3971d336b00mr3512774f8f.17.1741966338308;
        Fri, 14 Mar 2025 08:32:18 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:6eea:2dc0:eafb:9b35])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm6036005f8f.70.2025.03.14.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:32:17 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Jian Hu <jian.hu@amlogic.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, 
 linux-amlogic <linux-amlogic@lists.infradead.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20241231062552.2982266-1-jian.hu@amlogic.com>
References: <20241231062552.2982266-1-jian.hu@amlogic.com>
Subject: Re: [PATCH] clk: amlogic: a1: fix a typo
Message-Id: <174196633722.1526311.3272915728848116488.b4-ty@baylibre.com>
Date: Fri, 14 Mar 2025 16:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: amlogic: a1: fix a typo
      https://github.com/BayLibre/clk-meson/commit/b3c221e752c4

Best regards,
--
Jerome


