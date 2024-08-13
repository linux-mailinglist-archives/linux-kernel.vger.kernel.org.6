Return-Path: <linux-kernel+bounces-285393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CD950CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082D12863EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A91BF53;
	Tue, 13 Aug 2024 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5vVS4OY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DD19EEA2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576288; cv=none; b=nyAVys8no8dJZ/Trdv5r5zBv0AgmKTjisT8J1uxlT14b6bCDfUjoqx4ndTwf/inhFUg8ssgAwCvndnCK1zWv1jcdhPobEm6huzDauo2B82CDV/PoJDvviWL04l2MMrAtaOuRK0zms39QVOC8Vrfjdi3+CtfK50xUZSJ2TB9wyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576288; c=relaxed/simple;
	bh=Capz7/MVFUR8MVRPR3rC6opOLu3/h6ZEHajy++lbmZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSmrsvMOZ/K1fXDoCX8Ne0lHZ4hGl17ORUgVNVg7Yslt+mvjTZFvaHhI7kcgFEwfBHLPCROx1DZcPn0CrUiP75A91q0uiHMjGHX9WZu5FVB3yMysfMdQWAdIDiXqOzurpcpbMEwMXtJxGo534/BjQnjKHBPimVzpQst+nqxJZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5vVS4OY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so41166135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576285; x=1724181085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXRoj/CRIPkOaFbXJh9rGVv+pMj27qqwtYARVY+jZMI=;
        b=X5vVS4OYAxTiiqv2S/S1LuUN75Jp4biXgKsKRSyaGfqQQxPtZ+wNK1/smgmQqVY2Ea
         4Sk+vsfhRGMFzFA7++Z6AnwhQTK3rqJuTtX9nLa9FC6FsKXHmeGZsBEbglBc/wpIAvP8
         aJ/tS/39NgrrKoStmd6gfvfrrnnCvbIzrCqdgz2QgqqNmF1SrvLpUKTeL/Tzgfr5HHig
         KrrRccv6z0aoRVIP4mKos1GSLRIR4tW74ewZ4aEYgSBgtt56hBQLjfQW7mkoEHKb8DCp
         Y7RzEnkdQIGOAenDQCVkjQdf8dtBJ+QLvWYsTcxIUkfVwqsz2sb3MyJmDSNZs1qE12vb
         a2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576285; x=1724181085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXRoj/CRIPkOaFbXJh9rGVv+pMj27qqwtYARVY+jZMI=;
        b=JXB7KEdn+oSgBsyQcBq09Qt+m4N1Cm+HPXhqa6zaS/5RxGpct1FSV4+OKD4P6WMlip
         PnfP4Qm6Zi3Z3T42VeAeHyDcH00bMNj1Jc7jwx6RYkNGTZz1TIgmjDS9UtrtGue85nWT
         xWBkD62kxFZQcrHsS+jgqkffiKpQnLZzTdABjlOyvruHCdUaRVQW8hKu7Ytjjt2yv7zB
         n9HjQgSHLB+4P98/Z8Lf/hFOh1HrocSA1wd5zhAo9mr7ML94GcIsMnD0fOgzzDTO5ViG
         hAmHmEsZg8hD+/ub3MJHnFrPFv6InuYH9uScfMEsJyrS1Yc4mG7ALp5faGTDgwN7in4E
         zXxw==
X-Forwarded-Encrypted: i=1; AJvYcCWPbwR/85zH/0osF6S0uBWps4X9gcR/wJYBL1v/3a4YHVXdbx1o6h0b8ndDQcVYfu9BJIFiOj2TGwAVZe6GTN6HFgvM/558r5h2M1l2
X-Gm-Message-State: AOJu0YzRAPqbJ0lSZ1+czmm/XQ/PoXC8VuPVJvIn2rcH656j9uXP5UtV
	FUC8E0dThqJ55XhzZT9Rgb1HmuNijMwub33IDbjC+BX5/HBceVBkqEPQcRWRoFFouzNhphW70az
	QFhI=
X-Google-Smtp-Source: AGHT+IGLyKYAHRtlezJvxZA160Zehf75EedZmMnpGppB6IO1FcRbhXTR8SS6MJ6YkukdO3EYeKb8ww==
X-Received: by 2002:a05:600c:198e:b0:426:6f5f:9da6 with SMTP id 5b1f17b1804b1-429dd25fb22mr3451805e9.27.1723576285129;
        Tue, 13 Aug 2024 12:11:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm147511405e9.36.2024.08.13.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:11:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] PCI/pwrctl: fixes for v6.11
Date: Tue, 13 Aug 2024 21:11:16 +0200
Message-ID: <20240813191119.155103-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are two fixes addressing issues with PCI pwrctl detected in some
corner-cases.

Bartosz Golaszewski (2):
  PCI: don't rely on of_platform_depopulate() for reused OF-nodes
  PCI/pwrctl: put the bus rescan on a different thread

 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 drivers/pci/remove.c                   | 16 +++++++++++++++-
 include/linux/pci-pwrctl.h             |  3 +++
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.43.0


