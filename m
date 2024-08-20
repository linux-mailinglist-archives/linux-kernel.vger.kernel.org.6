Return-Path: <linux-kernel+bounces-294295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58215958BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F521F2424E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0019E83F;
	Tue, 20 Aug 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FEOUrQUs"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C318E34B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169536; cv=none; b=RmjrcDwCG++LlzRG8gePdPQU/XIyJX2CiY2zjp9Uzs1Ye4ZviPESi8cxHCs+yBrcBndHsJ6npm6zwHXlQfuAOoq4Qp28KQuDihfJwXc4Gdkq+6Vqt74ZyJ9tQu/4tg457mDF4kyEDtRcviu3oWlvTwSb0OU040JshSLHOJcz6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169536; c=relaxed/simple;
	bh=k16WyKVJwiJ5IusJSEluOUOkV/j+98xYcZI1RkDLfV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IoLif0TDO3H70VvTDIDyh3P2ZbP6ClQ5TgEjpFus9DNqPVmToaR33pYeq7t/mUh/i3kwXSHEPLP4ytuC5F/63w1ETDpI30AW2MXcYCBIufWtYnNRy+Mi/foSjVAlcIPXACOhXY7SMj3jW6SeslQy1vQUOmH8B3U6MH2ifEfbCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FEOUrQUs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dd16257b7bso1959608b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169533; x=1724774333; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpTWI80ZGd5lrqQihvu/+C4wGR2VCt7kMvgeMmpPkP0=;
        b=FEOUrQUsJAN+MpsI7SRuYBDTGYjUyoQa7K7L/QjPx/XTLPVJ1ycZuw3VuDA1LiLkTU
         JgPbfJqOyMru6FNrIgy3S5CkdkxrbYgxcdcAILVnaw2RGvVrtOF8ZaZKkO6IBPhoZTSl
         uevFeecLm0AnwjQya59E1A1C8uIwkP3ffU9Fhma6nhpsghq1wwwiqKaL0AGJzYzCqTvh
         3pW7CiaeBN2D2/PDI7eCo7pzGRiV2rI6RnbqGV949nLGdKSeH25KNvFiZt0RmLTRfRZu
         tZ5BSMfqr2B1qI0/U3b5nKQkWVyJMGqIL+NO2/1qq9hCTr1WCZq6hKQDEAJcgmNcFV4t
         5UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169533; x=1724774333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpTWI80ZGd5lrqQihvu/+C4wGR2VCt7kMvgeMmpPkP0=;
        b=Gq/rWfBf09eBIf549xQQhXsl9LXxiNGxvqw3gphdtdUATrv+RjzX0SSDJaDGPpLpnd
         e3rIQa/0SsCWJ05h7mPiepKk6sHnJKkaedU6wZaM7mD5yyIVwSj/1s8xUd7Utd5n0Dq3
         Mt3B4QOxIzly3VjbWRqDGNYtRaTEmwmGiS9rxhDfXdkKg7SW3Ha6MKwZueghgnJJMWOn
         hj7TqCcVxYhYV6yMVg9DBxSDhkf4pQ5gfkqCAnHbbdBa+yVSO183gta8Pc5wV/CDjTYN
         mlsT7RS0wb8tuXHQ/phAYZvKjil4uFsQPgFVPsBc9xP+NkeYA/F9OkIRULLlzpAO1YjM
         Jwlg==
X-Forwarded-Encrypted: i=1; AJvYcCWAnP5v8b4Xs8m7zQXqs92wH0+aGXlD3krHiVm4+PUolL9TUQg/4yjrlDbaFk1qrgJwfRkVOJaFYactn9FRVyOl7H6THX/dS4Ds46JG
X-Gm-Message-State: AOJu0YwTIHI7fHxXtZi8HmM1hSk3VK8AUVQKrzh+8rEU1d6I3WxtLQYv
	hCKz7hlK6FizyTXbvAgBYgokPJRn4v6ZA99mCww4zBzULrxyIIcrMC7m4SSpHGI=
X-Google-Smtp-Source: AGHT+IGJsEYFx5sQyuqiOtJyxeaXS+OgVFwhoIs/bPKMW46eufdetxsOk8Z6wMREcfjRrwgM+rBpBg==
X-Received: by 2002:a05:6808:3008:b0:3da:ab89:a805 with SMTP id 5614622812f47-3dd3acff15dmr19713535b6e.16.1724169532583;
        Tue, 20 Aug 2024 08:58:52 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] iio: adc: ad4695: implement calibration support
Date: Tue, 20 Aug 2024 10:58:34 -0500
Message-Id: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq9xGYC/x3MQQqAIBBA0avErBswsayuEi2kGW02FhoRSHdPW
 r7F/wUyJ+EMc1Mg8S1ZjljRtQ1su4uBUagatNJGjd2Ejsww9RicRDy8z3zhZs1I1hF5baGGZ2I
 vzz9d1vf9AELzk0lkAAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

This series adds calibration support to the ad4695 driver.

This has the same "odd" gain and offset registers that are being used
for calibration as discussed recently in the ad4030 series [1]. So if
the ranges in the *_available attributes seem a bit big for calibration,
that is why. The official datasheet explanation for this feature is,
"The AD4695/AD4696 include offset and gain error correction
functionality to correct for first-order nonidealities in a full
[analog front end] signal chain."

[1]: https://lore.kernel.org/linux-iio/20240814193814.78fe45cc@jic23-huawei/

---
David Lechner (4):
      iio: adc: ad4695: add 2nd regmap for 16-bit registers
      iio: adc: ad4695: implement calibration support
      doc: iio: ad4695: update for calibration support
      iio: ABI: document ad4695 new attributes

 Documentation/ABI/testing/sysfs-bus-iio |   3 +
 Documentation/iio/ad4695.rst            |   7 +-
 drivers/iio/adc/ad4695.c                | 242 +++++++++++++++++++++++++++++---
 3 files changed, 234 insertions(+), 18 deletions(-)
---
base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
change-id: 20240819-ad4695-gain-offset-c748d7addf27

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


