Return-Path: <linux-kernel+bounces-519800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D4A3A20D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE83B3B99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149926E175;
	Tue, 18 Feb 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ETghGnHi"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6626B2CC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894658; cv=none; b=OkcgohdEB2VoH733VZZ6LcKZ4oPXosEFJGgMrCrUTVKeyD8uKvfgq2bcvIgDW2hX7PFXl+uN632rpLq9U3dWhz/4pArJzWBqcfzp4R14buv63oreJIHb+/JfWJIhJpAxN8IdVyK/4jkPnTDLU3W6wHACreU/hA4uIsDrURCwhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894658; c=relaxed/simple;
	bh=fUVMWAX7REWpjhyyCWYiuH8xcu9kalXszllLwFkX3qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwZh9zAdONVNfFsEaoDS+Us0xP4A8qwxHztCGQ7VzvEN8cHqthBV/hAOjFsEy6lsZrYao1BbHYSiEJzTKnPx4D2HhWJYP3TgkZtnJ/f04emZeigY2eYHDZayDfgC6Df9haByC7E2mvoJFZuKlv56X4Mt2oVEIKQHp1ZXzhcCCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ETghGnHi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C75963F87A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739894645;
	bh=DuryKK1JU9DVfHEPC89kUMPr/MHTu6J3voQMTK8lVb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ETghGnHiUulXMKLwq9KwBtZb313FzW5DoXdBXVCXO8mfsiTZRn0Aex7pYwD6cUHpM
	 Xf3ydulb5jkNoZ9Dzb10lrOljSMB71ecJYFVihub3G0Y65or5QAlggmw30Xvylob1y
	 i1BkKBsFcTFm2kNqQB/YpyEyc7f/0494XqW/PHmJG9iMtlr2Ocn86UEzgvnUdioYJh
	 +UYu+TMnVBKCB/lWw0L/U/nvol1arXnrr3xOkBKKBAjO4xLJMfWmC0kRNJHKL1pbw4
	 PuRtjPO0f+jo/OePHyVlpSiqsIkZQa/IOCpi71BewdKQSAUy8hXZ5tbYVQlTBZDe8A
	 gZb6dM+5vWO9w==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so8343113a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894644; x=1740499444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuryKK1JU9DVfHEPC89kUMPr/MHTu6J3voQMTK8lVb0=;
        b=V7raFxuo4mNh73toqAGk7RKdjn1jcxGhP8m16nqRdgMAnzovMAR9/KDWVLna8WqB0D
         6c46q5PyoiD5JmzTIA5Rqml2Z/YJ9I3kEp0N+HoCjrYsZTqYYz+G2gjbDRM1tnxzTsgE
         G6ihRVbrPQOxpaFH+/cCx27bGpXw/aYK8GxU/Ikq8Xt9ub0WvSNWDM9I43Pi9+YVuaNr
         m4Yjy3wVPM8FYABNWyFe6YRurnRghAOF1YVf5B58ACjANHsCvMzoOSBXnYGec86VRcif
         0VQ96UQPaQ/ZHx4/ZavrrDtRsQtb/fMHPRKQV0ys5wBMrsd67AeBd4P7KRpLLfGBdxJU
         N0lA==
X-Forwarded-Encrypted: i=1; AJvYcCV6kmWCvY2ua04JsMoKYDpCT64EeIdy0iaz3ZKs2vTQ2gaPdFKt9rBYIbxUcoDg4XQKQAwqytI8yJdiVbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznB1UkwviCZXD3CUggOSTpe6oNBbM/9ICYKWIX40pkB2wmXJN0
	Fj7DYaKWmS4j2Kl2+QYvqtDxgtE7lNIwEHO3xg6VClzlzUEjh5+7PFo6Xcdgwmc3u/qyfbOqxJ1
	h4MHL1+ZdOEEHodP9xcVIL0Zi+jVnR/7nHKHu4+R7aSj1Y2Xjz/2g/KihEwfQVusMd9k6z8lzZz
	VTDw==
X-Gm-Gg: ASbGncu4eXVLjNByF4FTeClSQu+ZWQVriqJZdD+C8fFTeUOO/6RxwcPMFP8Ipiq8q+1
	rLn5JnUTBJU8GpuBx0sGy3wfCX88bJVhcliDu2CuxETvzxEVrS9YqIL8lib5wAhTzz1hI/ALKJ8
	9UQmE80/aOkF5mXPxKhL/qMtGdnJKi78GOIbQPmzHic6Q2StzryE4V5v3Fj49ogXMDr+/Oa4gTr
	0r4dOa9q+fs/egttNGO4WpERmxX6Cy60GaqeSOm7BK1UrpOKFDY+WzergQNlk9lbpvnq32ex+b/
	bBGIaXMc8cfaStRa9nr7oAg=
X-Received: by 2002:a05:6a00:4f95:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-732618e4f11mr20970158b3a.15.1739894644408;
        Tue, 18 Feb 2025 08:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu7WnSNLPN3pPeNyV6sGFRmm5VDz/p7f6++WWf5z64nfaasD8G3rgud6fEdZqaPcfLWrlI7A==
X-Received: by 2002:a05:6a00:4f95:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-732618e4f11mr20970121b3a.15.1739894644068;
        Tue, 18 Feb 2025 08:04:04 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:ad3a:e902:d78b:b8fa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae01c768020sm3662177a12.73.2025.02.18.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:04:03 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add synchronous fake device creation utility for GPIO drivers
Date: Wed, 19 Feb 2025 01:03:30 +0900
Message-ID: <20250218160333.605829-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a utility for some GPIO devices to reduce
code duplication. There are no functional changes.

In this series, only gpio-sim and gpio-virtuser are updated to use
dev-sync-probe, as the current gpio-aggregator does not benefit from it at
all. A follow-up patch series that introduces a configfs interface for
gpio-aggregator will convert it to use dev-sync-probe as well.

This work originated from a suggestion by Bartosz:
https://lore.kernel.org/all/CAMRc=MfcooZXBqVpbQ0ak+8LGsPDzwKSN3Zfb0eZDx1Bx4duzQ@mail.gmail.com/

N.B. this submission is based on the latest gpio/for-next as of writing:
f04867a5d0d3 ("gpio: loongson-64bit: Remove unneeded ngpio assignment").


v1->v2 changes:
  - Renamed the files (gpio-pseudo.[ch] -> dev-sync-probe.[ch]).
  - Renamed the helper functions and a struct.
  - Fixed Kconfig (correcting bool to tristate, etc.).
  - Fixed Copyright.
  - Added some missing #include.

v1: https://lore.kernel.org/all/20250217142758.540601-1-koichiro.den@canonical.com/


Koichiro Den (3):
  gpio: introduce utilities for synchronous fake device creation
  gpio: sim: convert to use dev-sync-probe utilities
  gpio: virtuser: convert to use dev-sync-probe utilities

 drivers/gpio/Kconfig          | 10 ++++
 drivers/gpio/Makefile         |  3 ++
 drivers/gpio/dev-sync-probe.c | 96 +++++++++++++++++++++++++++++++++++
 drivers/gpio/dev-sync-probe.h | 25 +++++++++
 drivers/gpio/gpio-sim.c       | 84 +++++-------------------------
 drivers/gpio/gpio-virtuser.c  | 73 ++++----------------------
 6 files changed, 156 insertions(+), 135 deletions(-)
 create mode 100644 drivers/gpio/dev-sync-probe.c
 create mode 100644 drivers/gpio/dev-sync-probe.h

-- 
2.45.2


