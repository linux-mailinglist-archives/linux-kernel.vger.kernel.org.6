Return-Path: <linux-kernel+bounces-544696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6693A4E425
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136542427A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280820A5F3;
	Tue,  4 Mar 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MdNMkUkU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879A28D061
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102056; cv=none; b=Twj6U/1GqRxpv83sZ71oI3Lio+Gfpph6x8EWsmHnRhch592LMhsTA+N35rd7FSIj5vevFeP7K2LLJej+b9/EYQ7nxIyeFeZt7NATDbaYttmKjJ9kjYwvjQ2b1XhaUCsm1VLwH/MT9+rDdo7xICdWLR9F7oS9WnctZR9x2K1P9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102056; c=relaxed/simple;
	bh=QzL/6Jwrk5+OEZqUr5nej/Vdup/WUPqimuxioOMsDnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6se+X6rj8vh8S/kjFw37QOHB5LKp1RMjNBgx7fPCuYfF5B79+qCYm9a+YHM8Eoh5VwDp2QMFWpU0i1Tg8qqW+KOzlDK201jRijGUHqD5vYOG2hYtK1YQx5P5N3UWXexzqfeoKeqJ5Prwb8B0oo/n1dDSZ4HoefKNqyaQFmv258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MdNMkUkU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so24036395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741102051; x=1741706851; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLge0yQ5Ly7QiVOr8wvQ/f7AlfV4bu5713ouH8WzHU=;
        b=MdNMkUkUEt/CwfLUwMJNIKqKddQ/68vhhcSh6COrPzb8CbFHpLtlDhrd1MZZuc8NTj
         pRoY/J5d/1Y3X9G/jHzJFFz2Eoivjk3NecXbn3JvlKotLYslwrReEd9jgtv8CmpcPg4W
         5i0GfLDwxkThMngsi91P+FWKUaLGPbVjqyrmife9sRUE+U01EuufS5kO/krE80caF2wl
         g+Y5JeIrznFBQ+dLL5nBRDrHc+lqhgShVyFlcb9fNrA/SvB7+JbbQF09FmvL3P/PKkQ7
         hXlnyAvOK55Y7Ymy5QQJgl+2FHziXeLYfY4+MpVKhJt/pGoEpixcmuOtvDRGxkHGQvY7
         NFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102051; x=1741706851;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BLge0yQ5Ly7QiVOr8wvQ/f7AlfV4bu5713ouH8WzHU=;
        b=ZB3vUdeHj9XxuT5qukTk4mLBJsCcOsoerMmapPMX0GTJ1X5JfrM0mLNCktB+Rauxyb
         pkaOi2YylCC18YksLKM3Y65UIuGBsANZ0RXCQ39nZnMVwjYujItzVox9eDZBZxmYVx5d
         y825rVhtIPG4V1CjCA+NSUHQIp/Aoat+Yz20EZ1jRZLb6aSLyAYRPUcCb5x7KQxom8vt
         cf+T5STeLr4J7K6c+PRfIr1S8To9ODfLj5mKZTLl7bromNYy1JZxCoG9wCqZEcyJn6bR
         gwM7QUIb6s0OF/HwU4fd4k9lyrvSkw0/ST/DuC+Cw4Il4Bs2zyYHBHbX351dQQoHwyvE
         TjQw==
X-Forwarded-Encrypted: i=1; AJvYcCXicmmWCHtv2VI5yuvYz5vHsxW08TOdKU/klr1mNpZm9KGhOcBAUz5ZA0wQhq0oDyUWmGynk55HkIRx75w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP4O8pjZOLPNktMkfOobwNneeeN/1NHmD7Q/LuFC75SA+53VM
	Y9vfchK3lWMiRU66WOxbfKe3oU+U7sHUtMywT4ENads8SFSWiRfzzbZwSvLXe8o=
X-Gm-Gg: ASbGncti3yYcY/J7SR2DE21oFHoNnqy5+bynbRPcnqqGSvHd/nzJwFv+esEZaDETtPF
	IrAynYxPmRCmkJMCWjldo2yffzPzntRJhHFN/kiO1ie8RCslfUWaveLIPpvwv+TD3le9fzWrgLE
	iw5AlooKoch8EkF6b/uyuLXEdIZZX33rCiL+q1Oa4pcxaoNq/gXlW5HZ/56Ocv1fz/kssTJH9b1
	r0b7POxhejPJjy/2GA3TL+xPb8HwBRG1kY8accSudImNojNMJn+/XMo+GIQ30iol/IDqIk4Xrtz
	tj6CeOWBWRb0JoWSq+6jOjIjpBIzCRck5hHN9ED/c/o6tTuqjthM32mbKk4LQvtuun7lmBLgTgU
	BBuy7WYTGEiHQA+qzsMi1fTe+KqbPz5HjSA==
X-Google-Smtp-Source: AGHT+IHXqIP8MbjkxEqvoAMHolj2v2rUB0Dn2DUpOMoOaxKJaJO9yJDenmATL1r7UA1nkYXV308fzw==
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr14176368f8f.12.1741102051464;
        Tue, 04 Mar 2025 07:27:31 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm18245580f8f.55.2025.03.04.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:27:31 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v3 0/2] iio: ad7380: add SPI offload support
Date: Tue, 04 Mar 2025 16:25:43 +0100
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcbx2cC/42NQQ6CMBBFr0Jm7ZhxsGBceQ/DooWOTIKUtAYlh
 LtbOYGrn/eT//4KyUf1Ca7FCtHPmjSMGcpDAW1vx4dH7TIDExsq6YxvndANmCbFIDIE26Ht6vJ
 COaraCFsW00LeT9GLfnb3vcnca3qFuOxXM//af6wzIyGJl+okXBmyN2eXQV30xzY8odm27Qt1g
 yMVxQAAAA==
X-Change-ID: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add SPI offload support for the ad7380 ADC. 

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix return value on offload probe,
- add documentation patch 2/2.

Changes in v3:
- fix tabs erroneously added,
- fix documentation syntax error,
- add a note for the 4 channels ADC variants.
- Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com

---
Angelo Dureghello (2):
      iio: ad7380: add support for SPI offload
      docs: iio: ad7380: add SPI offload support

 Documentation/iio/ad7380.rst |  36 +++
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7380.c     | 509 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 511 insertions(+), 36 deletions(-)
---
base-commit: b7508a5a672275694c2a1b09a5f491ca2a56bbcf
change-id: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


