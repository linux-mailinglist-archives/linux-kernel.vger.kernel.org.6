Return-Path: <linux-kernel+bounces-364027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340499CA15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577E1283549
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2671A0701;
	Mon, 14 Oct 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O18EBEro"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951A8F64
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908938; cv=none; b=bo2vK0/pmNAh8mJArh5oJVf05ciRmyl2HYpg6zLT4vxJD0ZD/QXz0x6p7NPmdr0FK9UuV+m1XoAEySoZKgh0a9VgRp5BM1MA5DN0PFF3ecCmuYKX7psNQIDHb+OD/trQPnC2StN8QhZ6kYdQ2lnoWStzcNEXBGT5M0EEuWz2Kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908938; c=relaxed/simple;
	bh=BrYSQl0ZLYvbQAmDcGnc5LG7BHe+vhf/hldSMnJJFxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyGxtIZU1hnGwttNk64imnD9XBTsWJwIFy8kqj/cFT1y6GJbbo8yz6fuRUIT2HpNqEE6vyMj3kjigZqoCViMBq2MIVrq5id3+TnHdD28Uz0NFfD3dy4OprKQF1l/eTbqymh33sKxQl5dRW5Tdl55o+aawDiJAhabxMlQlHOw7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O18EBEro; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so47494615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728908936; x=1729513736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvR0lu9QOEiDhbztW3BgvcC1mYRKpQv7bJS1XmkZnE0=;
        b=O18EBErot56MqXhuM/d4p32SjCEWGD1xnyAqSKHgeQOZGtLq5IPpdrzLtnHDKMB5d3
         +Vu/W5xrueZxVsfteuh+X2REhVzjuPrd/NOwn57+K+ZyCoET/DL6QZ0Se6ZXuefOWnlx
         NSU+eA0j/PURZ0nt7/TYck032wDxD17PZnPu9Emnyp3ae2yLOtn8hcyF+CMWjqZhE3Oi
         V6blcY/8k/WEV0oMofW1n5KikoNhJctvg+YivCguVaogZM/aPGzn9+FPFXIEUw1tzves
         v7lyGKOGXi8gg4WY+DZQXFyprSoFJxJrkIUo3zIB8Buh2/7nYvdw8J0XY79hAqRw+yaW
         gF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908936; x=1729513736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvR0lu9QOEiDhbztW3BgvcC1mYRKpQv7bJS1XmkZnE0=;
        b=KF2ZFCyugs9mmtGo1KbI/gtnXxYOQSl8LqVxItG7NeUCYLSwvNwElBJYUB4KvFfRxk
         NNFTzMQYTlDAtY7xOWXsVApPXtOsat/cvJ8fpC2na5oI9X5ax4NslmfDlH2WZvsK+uI2
         I56sULTUL5AzKEOv3R21DpWdFw6gPtBntXrKGdaWDG/TPoiPSyMksjo/oTEL+XF8Afqk
         6LJGZtSN6SikkGDHFzwmxGJW+qSB9sBBqogrUwCaZoavBlbYGnMboe5fNE2YXu0vymJG
         lwXTn74L1jwGg3h1KTnR0TiYqv9HLKtrLEbZSngoaYbJVoxp2WcPhurphVKElf1lk5k0
         sfHw==
X-Gm-Message-State: AOJu0YzmNBHSV9ZfzU5yOY4R3oXN6gAkao7ztnMiGTZOo0/f+fVsza6o
	muk8vEYCG3l/oH0KEo9z7y2Mq+CCb0YybbhGyUl3O0F1gW9ELhnDtXgAab1AnAc=
X-Google-Smtp-Source: AGHT+IHKqVPpy+WCo6MDj0JB9eI/p+F2Q9SzzXqrjOE5wRvYvmXya1pR2Ksq4yYBDzjl4NfZZeAD0A==
X-Received: by 2002:a05:600c:3ba1:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-431255e052amr100118205e9.16.1728908935790;
        Mon, 14 Oct 2024 05:28:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b2780c1sm11324606f8f.0.2024.10.14.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:28:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] driver core: constify devlink class
Date: Mon, 14 Oct 2024 14:28:49 +0200
Message-ID: <20241014122849.118766-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The devlink class object is never modified and can be made constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a84a7b952cfd..0e618d675792 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -553,7 +553,7 @@ void device_link_wait_removal(void)
 }
 EXPORT_SYMBOL_GPL(device_link_wait_removal);
 
-static struct class devlink_class = {
+static const struct class devlink_class = {
 	.name = "devlink",
 	.dev_groups = devlink_groups,
 	.dev_release = devlink_dev_release,
-- 
2.43.0


