Return-Path: <linux-kernel+bounces-517835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B235A38662
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D371883440
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF421D009;
	Mon, 17 Feb 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Sv+KEAgX"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9AB21CA00
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802520; cv=none; b=c7CVRPYZ+1qE+nthOa8QPi3JfNO/xPd6vZIbKYbJtUPlG+xqsV147/fxvKDhf1TL9m3hBtluDyvtqKSfctvAnYxqV1hPytIYFVx5IqQZJl9A9lLSxH4LyzLpCBeWVMxF+WYXrqLJw4ILjw+QXE6G5GRjokiWwNmHrZbpR1BRTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802520; c=relaxed/simple;
	bh=DWZ8KnJCurFakHrvDiy9CIv4ENhdR2uzRHV5srnqlZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ythog0hD7C03p80LCIID5u7MPhekjRxEZDICB6mk9J6XeDzhW8D33poTvIP1jPvDilpw31cdlhd7W28ADaPUy+RvsgwHCfPiNSb/tTA1e4/rdfLSDj56SFc+M1Oz+DU28cIsYF27KhpQrOqYpNENDiBTsgUjk6OC9XYPZyBoLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Sv+KEAgX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D0E43F31E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802510;
	bh=EX+6q7+pfOVM4resmVZfWrWDLjg05cnGSRz3sXr+Pe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Sv+KEAgXOdtWJxYrbnzQOvf7PIA20DAIUdL5WQvSDxtDGx+xpCAhMU511/cYhYDLi
	 fgRvCEFuXVl6lGeFL7taNRIzkJkEqaBE0QWtUuciorN1S3EBk6dLAT7M6galjhAUej
	 F8tbHOFk26jJTT69yOk/F2YKLYwoqnG8nsPEQUo6PYjf1CuYKyUOtgE1HJ1mB2M/6s
	 tZPBpWHmY0cESGXmMds6oD87LedTLeZ/2lGTvT0o2XgeQAMIRFN4Jyy8mVVozi3rrR
	 Axtgr5/El+PragnymNOY8eLNmRwbglqEedQihOchG8qLEwHTSoWSWRUs4k+OEJfFsl
	 A+2X9juO+0dHQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220ff7d7b67so52236335ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802508; x=1740407308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX+6q7+pfOVM4resmVZfWrWDLjg05cnGSRz3sXr+Pe0=;
        b=GQJ7phoQdA0RJLvC5pzUwm3xzk3V0xUybvxy1gZzKKdUNi5SZaiZ4XLy0ClWajR+m5
         nfSc8weuWqxMVpM2ojBJdAn00hrqcQShZhAXAncxWTrBhh0IXoujym4v9zhjses2mO/A
         hc/MSEVf6Kp/MltozdMjoWowxnnpzgKjANF9yVuRwwNsip/dljfNOguaNIejwa9zkCoN
         HTuRTtvjHPs0/6ak8HhSVSIK23PSSrjx4MUHVT2Dlm0MMwtwnexRQpGJaICjRqBrOkdi
         tj9cQUtAuE+7Hf9TWhDIy66sR/TqSmHMWxu+e4uK6x1xVHTgfeTKnKHQCbqNb0WRo2Ym
         DA1A==
X-Forwarded-Encrypted: i=1; AJvYcCXvyuTZoqzJbWB4wyT3DgIll6kheYyo5U+cGHgLAWoTQRL9ErE5Y0lBO/RJxohfsga0sYN9NF9MwyTvaY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgc17pOxBPVgGdxndHf83g1cyxY2lNcWMeJT7Afz8zD7Mu3kl
	5D3MiOd/sPqVRMSi0xwghGSb4vyhgpHb0nWvg4ufK34l7u2mkQkUkTtEMnZDwGSjW3w+iKqFnzj
	1sugvNoxt9Q11JWbyUFzEL8AmZSlqGv40xO4PYdwFFWafQBiKgid6T/LTaigpBRfGwfEevo2hHp
	49/ZLyTLyLnQ==
X-Gm-Gg: ASbGncvkhf18CpJ3pB1dDiz3YdLHBmNAwQanEtU5dYg/OQk2AB81lZEzmxACLFF63XH
	D6ZzPD3w0/lYdHYDdqobVe6ZasVuFodjw9AUvQrYYMpmGU3eSfULigYvvKJa+5SW+9q4RPPHRXj
	KcWeGEupgvaWXmei2oQ/00Mi91HGToQhcR5hqmvdrynNoQ7KKnzAgRPD3LCnc1vdHm+gS4zgE7+
	cbHwfrjDoLehq/gaWZ3Wr47BZkH/AOe8zYU4DcvS7yZSo/DlTO1COFxymXG+lXg8v5MXbkLymGL
	I1XjVHVS7fcTzydIBVfVkik=
X-Received: by 2002:a17:902:ec85:b0:220:c911:3f60 with SMTP id d9443c01a7336-221040bd357mr152416015ad.47.1739802508644;
        Mon, 17 Feb 2025 06:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqgEcYNrfelD3fE8sBtXnshCMF9huu3yV3EuLf6GVqAs2TeJlz1zjbotXpXbvkTZf0hJYWLw==
X-Received: by 2002:a17:902:ec85:b0:220:c911:3f60 with SMTP id d9443c01a7336-221040bd357mr152415695ad.47.1739802508368;
        Mon, 17 Feb 2025 06:28:28 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm72237735ad.243.2025.02.17.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:28:27 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Introduce gpio-pseudo, common utilities for pseudo GPIO devices
Date: Mon, 17 Feb 2025 23:27:55 +0900
Message-ID: <20250217142758.540601-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a utility for pseudo GPIO devices to reduce
code duplication. There are no functional changes.

In this series, only gpio-sim and gpio-virtuser are updated to use
gpio-pseudo, as the current gpio-aggregator does not benefit from it at
all. A follow-up patch series that introduces a configfs interface for
gpio-aggregator will convert it to use gpio-pseudo as well.

This work originated from a suggestion by Bartosz:
https://lore.kernel.org/all/CAMRc=MfcooZXBqVpbQ0ak+8LGsPDzwKSN3Zfb0eZDx1Bx4duzQ@mail.gmail.com/

N.B. this submission is based on the latest gpio/for-next as of writing:
f04867a5d0d3 ("gpio: loongson-64bit: Remove unneeded ngpio assignment").


Koichiro Den (3):
  gpio: pseudo: common helper functions for pseudo gpio devices
  gpio: sim: convert to use gpio-pseudo utilities
  gpio: virtuser: convert to use gpio-pseudo utilities

 drivers/gpio/Kconfig         |  6 +++
 drivers/gpio/Makefile        |  1 +
 drivers/gpio/gpio-pseudo.c   | 86 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-pseudo.h   | 24 ++++++++++
 drivers/gpio/gpio-sim.c      | 84 +++++------------------------------
 drivers/gpio/gpio-virtuser.c | 73 +++++-------------------------
 6 files changed, 139 insertions(+), 135 deletions(-)
 create mode 100644 drivers/gpio/gpio-pseudo.c
 create mode 100644 drivers/gpio/gpio-pseudo.h

-- 
2.45.2


