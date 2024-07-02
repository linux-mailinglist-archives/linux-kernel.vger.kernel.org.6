Return-Path: <linux-kernel+bounces-237368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6D91EFC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B241C2266F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503612FF9C;
	Tue,  2 Jul 2024 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzouB3Nv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9782D68
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904507; cv=none; b=YH6uJhEKIrNQUnVWL3livIsfdYzG7aVqatva5xZrA9VNbmtAVMHRyK04Lm86/7EpZnBKOaIh4HMTsyOFhTGVyg/nuOjX6bxk793hQk51LadIXrNe0yKekiJiD4wmu7etmFBZnhaU/6zVx1dgwSKdNvPOe0jg1zAgxWpIJQIHKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904507; c=relaxed/simple;
	bh=G6cbGbVFYDFTEjfy7biJrAcpFySCyzeoGF8BqZlqFTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuBfmB7hZBJUiQX/EGe7rx6gwW6PNszhQnndvlOxHRnsjEAN1uR0d4kTq+YFqJqev9cJKUyJnoXz5Rw8OCWCrQk7k533lmUptUO9a39jg6TcO6TFvXybrmQoPH1hp5/aR+oPkkTMA6gtgACabI5ziqRnHqepnhuTNDk/MOYg5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qzouB3Nv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso23720835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719904504; x=1720509304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8bz4s8gTj+3caBrCSO6rCqP5PWRyd3UCfXgK1jeKUI=;
        b=qzouB3NvMAAhpoeiYNjTgVYqV2eAM6x5mV2ln72eF3fbywn+1WkpfIFdzuaoFRtK7X
         2jTqa6DH37fOfNjYN87OsyGjI2jS48X27DoO7Xk0M/eRXbj96tA7+orWJ+/zYJGm3bZd
         m0LM0KBti8tNqp40ES7g2Jd3q+jzFfljt5vX/yZvjT3piu1fVw1qd9zjhD1Bhm2uG659
         Fbnw6visxB2Qi0ikdWCxIJnvkcfpzC2KoFcp69d2vqgYxu9P7y9vq7ikSSRb4tTp7YFu
         0+1you/dOLVxQL7zQ6RQzt18bsDFIidYnMaNCKd/fyVg+YYTDWWtVRN1+8a9EDKn/wde
         gHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719904504; x=1720509304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8bz4s8gTj+3caBrCSO6rCqP5PWRyd3UCfXgK1jeKUI=;
        b=DEsu4V654Yak33mzuw1cxDkn3wwfyNPX3iReNybGsdcgGel11YBd5S2Fn7vBmC3/1G
         CQq3jyzfM+6tKYbpmax0VttB35RYKyiDBUbZNqHOsGrEzSasauXie578qVuerweXNQaH
         avmqljerekrpX96FRAaJokL8NnJSgtXkcPWzKXp6655EK84GIFsQUCogjt/JXQ88r5N0
         2a84Lc9UqIp5auPOJ4U59yMQ+Q/lPnABus1Cg/cXuLPq4tcpRjQ16xKusetvsF5X3gnC
         K1W4P8fKggRzoy+IJnvu0C41fwolZK0B2505iM6Ep7bBS0O5j+yiGkeN6iK83Jh9ZRha
         1tsg==
X-Forwarded-Encrypted: i=1; AJvYcCWlv4mUognl8ILAVL9PxTVaNTxlxb7acqi7jxE2KCV9qu1XLBF6weksSjp0XrGiETiyIgUMSQwzWSz33mmkUEBtoRbWZ/NmKn2kZj0e
X-Gm-Message-State: AOJu0YyPLuvniVVUFlRAIazP6WEXukS3P3NkjZIdMGw8bw7ykjn62T39
	6GvBV8+dVeR7l4DFMUsCLLX6jMPrWf7IKbLo/sct8fng5qTTlenE1lYD3+bxmrML3rGrwSFyx7E
	o
X-Google-Smtp-Source: AGHT+IG+wKmRZWi9OOXX7y1MA0CAkVGA8vC7X25jueUvOLYOMg8cPQde+p8a20/MIlwGV5q0v6OPBA==
X-Received: by 2002:a7b:cc96:0:b0:424:8ef1:816a with SMTP id 5b1f17b1804b1-4257a0257c1mr49939895e9.5.1719904503910;
        Tue, 02 Jul 2024 00:15:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af552bbsm185612485e9.13.2024.07.02.00.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:15:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.11
Date: Tue,  2 Jul 2024 09:14:59 +0200
Message-ID: <20240702071459.9436-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.11

for you to fetch changes up to 26bf5fc86033162dbd2d5759094cbd724313d55b:

  w1: Drop allocation error message (2024-05-28 17:45:02 +0200)

----------------------------------------------------------------
1-Wire bus drivers for v6.11

Just two cleanups for W1 core code.

----------------------------------------------------------------
Thorsten Blum (2):
      w1: Add missing newline and fix typos in w1_bus_master comment
      w1: Drop allocation error message

 drivers/w1/w1.c     | 2 +-
 drivers/w1/w1_int.c | 6 +-----
 include/linux/w1.h  | 7 ++++---
 3 files changed, 6 insertions(+), 9 deletions(-)

