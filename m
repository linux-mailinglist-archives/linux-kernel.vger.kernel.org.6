Return-Path: <linux-kernel+bounces-198527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBBD8D79C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501E9B20DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC823209;
	Mon,  3 Jun 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqmzNKke"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769A15C9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378093; cv=none; b=hm4fRSwMSITJf2OfYZIiA6DEl1uCEO66j0d4nFRKfE/2OG+PbS17cA7IzGi/xLS92MqZM6KcXaCy/ax75OwwkTZcEJkumkX5RYkkHYp335TNbjMupGbkmMaD00Nr+yYp3fJJf5Y44Z4DiLZdogHMpTNWtYphFVOmWC+hLc3Ho8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378093; c=relaxed/simple;
	bh=ABNibF/jy35x5qufZvG/CN8NbHqxNsF8zjiL53ElLjY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PpszSB6sMQh5oZIEVqSv6tEOUSWbrI4ptWekfBwXNQ4YNBI5tN55OMIQ0jXtB/fcSxJ3PzYqIYU2Ifs670hcZAEcFhTp/1xEn+ZLF9RnIubtCYZaHG7a9XCrPVl8mvAAsVBm9+xzgpquHcfI+n//VH6845OkqeKMIviLGA3jqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqmzNKke; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c210a8d4f8so827123a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717378091; x=1717982891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABNibF/jy35x5qufZvG/CN8NbHqxNsF8zjiL53ElLjY=;
        b=IqmzNKkefoPaLTvPEhy40/Ts4Ev64GgdG6JtRC/9avKx8QZ9mwJMyQqTepiSCFRg42
         sWYpfsz81E8zluRYw9NMe/CC0maNGIR5SnQHhu/aMET5Tgod2/O8gkdtXEo+BSSB1gLe
         hx92GmHjpPPhQcemzU9iV+JBed/gkQt027Nq7jkjFqaWNRXn6sQcjidftGc5AMf0xqtQ
         RIUrO37YG66aHxnxetRYwwg4CTkHQA2GyNLHC/tXSzPPrN4cQ1RiBGvo4wsTMf/adJbK
         wvAl5XQ0ynXIKKJntLJvlUTmU3yfIhH88Al2uIRfQtPb22Vg5RqQUIkvNPuklKxrFVcw
         4p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717378091; x=1717982891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABNibF/jy35x5qufZvG/CN8NbHqxNsF8zjiL53ElLjY=;
        b=NilxE+bobfBek6VuHbnsADeV0HwQs+1AHsn/eNzdf6Ns13cOBMM4XxdlS564txtOPY
         haKNcGO1ptK/3lV4TKwy0mXTgmmdvIcx1QnpD76tBC+zaXJzfwaHGaCXz3xm4dUJKnbX
         dJICNuGIsndVQojtYqze9BtlpnwUD08H3g3iBQ8wf7ztd3SJ3GqUHnm/QIvM/G+2Me0/
         NipoyEdWIagMXlyzpU+TRuMnf+SZ2awhUPKmUE+Vf0YYm1UApY3jG8kMKSEN1HHhRkQp
         9CheBCftYWoiwYj4QZcwfTT/hx3GCS0oqwin1SJ10/3XvzJQdbLg94YKw9j6VMmc7sPe
         nfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKXSTlPgX6DI/Bc004D616CadolumFazwLOML7NlJOpXpLvChdxn62yOkZ31O6bt7/iCqACrIC33+5xE2dNGSQBoxZ4a6rzyT1LEtf
X-Gm-Message-State: AOJu0YyCBmOOLI1PIw/k0vpKEeXF67KE6u7JbmrYca5f6A0rFGIsEL56
	WhotTkAxDTnlKHZ1Vr0tb+oUKbO8LgfjhKVH8frReu4x4GtOJVGw
X-Google-Smtp-Source: AGHT+IHGeCYX92ClMfFrJLS+4UWb8SolcJZOuWfBr8j+JQ43m69uhAdI1fMni61JJuulHTm+zgEZaA==
X-Received: by 2002:a17:90a:d304:b0:2bd:6552:6474 with SMTP id 98e67ed59e1d1-2c1dc5cd763mr6548807a91.41.1717378091176;
        Sun, 02 Jun 2024 18:28:11 -0700 (PDT)
Received: from desky.home.arpa ([2605:59c8:790:a500:5d50:7307:99f3:76c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bb855sm6725047a91.52.2024.06.02.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 18:28:10 -0700 (PDT)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Date: Sun,  2 Jun 2024 18:26:37 -0700
Message-ID: <20240603012804.122215-1-ben@bens.haus>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, I've been running two Marvell A3720 devices with CPU frequency scaling
enabled and 1.2Ghz enabled for several months without issues. In order to do
this I had to patch the DDR initialization code in Marvell's repos
(https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44).

Without that patch, the device would indeed crash with frequency scaling
enabled at any clock speed. This indicates that at least some of the stability
issues experienced by users in the past are a result of improperly configured
bootloaders rather than an issue with the kernel. As a result, it seems
reasonable to re-enable the 1.2Ghz clock speed for users.

Ben


