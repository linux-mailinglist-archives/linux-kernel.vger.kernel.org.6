Return-Path: <linux-kernel+bounces-448055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8872C9F3A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F118890FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE1B1CEACD;
	Mon, 16 Dec 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTv7N2gp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714A61CDFDE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379919; cv=none; b=ml+zBN2Xuj42BfhLl6hw/FKOCs8/QqbfPDiv2l9DUyWyGNC47UOxbyzuR6iS3tXHixNvq42lV7HUw7rRXBn07sLe4iTGdS2q/grWTjiwCvnnAJfBSmKFClqT8KgUS+4b7epPX0hgJauUFp7/qEjr1Cglv/h574V8y9wc51OyV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379919; c=relaxed/simple;
	bh=MB50HxS4XH0AqjPhn5Rt0ZHwX9KYAvQUP7Mn+X0hDf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3PPfS2vQsFm5iQJ/9ERQxvFk6opy5OIcPLYJgUW0ENLnAmyXB7/HnEwFLvNkKXd7BY7UkuVI4gsfjbJhC9k39vQ0Jzor9bFGHzxk143PYVHB1NQVAGoRS6CMo0S4r7MoIkhUZoljNAtdvJZj3qzb4GwXICFrA3rMWlcSAX/Kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DTv7N2gp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21675fd60feso47575145ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734379918; x=1734984718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJDssvkykOLxnPgPj3hUuXjlWR0oF5mqDpbk9Gz8f6E=;
        b=DTv7N2gpMFbixsIhveL3lVdYHruIx6TKfO6Jpdybg60ZOMO8/Vk1m2/jmzLZlq98lJ
         NroZtPtjvfba9LZvM0/Iu7w3cVi7ve2TmkIIx6m4mIUeff49KQT9m1SwFq2Kp5W/dVwk
         NMA+AoAi5ipYEsat0vWlGCKIKcOGoaN/y3sCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379918; x=1734984718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJDssvkykOLxnPgPj3hUuXjlWR0oF5mqDpbk9Gz8f6E=;
        b=QPNz69E3JDn+GU0xPWbU1XupMPWAHRgusjf7+j1NPqYIAEcobvQuAFebEblmhAb7Z1
         tW3ApWgYxft9AcXsevZaCfOK9GjDk/PQmG11WkL6GhQHBieGjg3IsrBuge671FnYNdWr
         fdCR88HAu30jLYgGYoXHY3F5K0CiQ53tvz0WS/XsKkxgN6Ol+2oVden9LMfdH+QRz570
         dH5pXdyA0SUCwgrJb3qxl3Zb1p1shGV51DokCmyy2SldOLtQiTZMOAM9fjvXALxA9seA
         YIexuDxBDHdEeGdDFQvLT/qPTAaduo6SL1yDo+kBptr627OgjmUOzcU3lzopFNWsObnK
         2x2A==
X-Forwarded-Encrypted: i=1; AJvYcCWT6dvCwfUJ+BOe9G7DzLlCu7L1B+gkkiL2bzUo6OvP/zjOkuaj60K0ev28tAkqIPOnXvGuappq9LR1iy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCL0i0zAdsf0/orb37D1s0jPQN//FiTwrf59mPvL3Rcx/R7hP
	p7keA+8R7sBFcx54kgGgGOOvH5cPHOKiqHBPa5BiVtsUEBFC0Nn18TIobl4vsw==
X-Gm-Gg: ASbGncthFf5hPsbVSr285m3YQHKYuJ5u/yt+nEQN1g1FkDRS1qfLmKeiscs8lHSjbjv
	UmU52hr4pnLhlIAjnQB4FZT13HDKWa+itkx+g69JxsrQRxBe6kMxiUEDN0ScqrWcYKh7ICAsuag
	8K3cIMqUp9UlD3tw8Fnnz7ZdoHtecqdCoDG5Ntjmk0hqnlDo0Y1qQjySlCBa9/D6pOiC5LcrLur
	3MrZvlVj7ntycbHw6b63tILlIcZMTsw0W7ui9U7NFc5teczSqK81KpB5lCm/Vh1MFQtrOz7AkdE
	I/mr9FR89z0kiNxHwQ==
X-Google-Smtp-Source: AGHT+IFPt/yzYkL+WqzS7KUdkz894jceh43TbHhApgYdMJ4tZu2dlgeGJiFcBrRdgNqp8SzfUDRSiQ==
X-Received: by 2002:a17:903:1d2:b0:216:7cd8:e964 with SMTP id d9443c01a7336-218929e814cmr205215925ad.22.1734379917836;
        Mon, 16 Dec 2024 12:11:57 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e501f1sm46466775ad.145.2024.12.16.12.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:11:57 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	linux-acpi@vger.kernel.org,
	Rae Moar <rmoar@google.com>,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/3] drivers: base: Don't match device with NULL of_node/fwnode/etc + tests
Date: Mon, 16 Dec 2024 12:11:41 -0800
Message-ID: <20241216201148.535115-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series:
1. makes the behavior of_find_device_by_node(),
   bus_find_device_by_of_node(), bus_find_device_by_fwnode(), etc., more
   consistent when provided with a NULL node/handle;
2. adds kunit tests to validate the new NULL-argument behavior; and
3. makes some related improvements and refactoring for the drivers/base/
   kunit tests.

This series aims to prevent problems like the ones resolved in commit
5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if one
actually exists").

Changes in v3:
 * Fix potential leak in test error case

Changes in v2:
 * CC LKML (oops!)
 * Keep "devm" and "match" tests in separate suites

Brian Norris (3):
  drivers: base: Don't match devices with NULL of_node/fwnode/etc
  drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
  drivers: base: test: Add ...find_device_by...(... NULL) tests

 drivers/base/core.c                      |  8 ++---
 drivers/base/test/Kconfig                |  1 +
 drivers/base/test/platform-device-test.c | 41 +++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


