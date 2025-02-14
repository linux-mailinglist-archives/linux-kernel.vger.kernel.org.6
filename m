Return-Path: <linux-kernel+bounces-514873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AADA35CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75370188E6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE802262816;
	Fri, 14 Feb 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpkOpnIB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE62275408
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533656; cv=none; b=bPAYxfF2bt7BeJI0eKo21gavfOLCzdmzIi2goAWIQ+hfzZouk13kZBIEtHKR/Vxx3r+7lIx/RBqUl+YjpliqEcnTXcICKxe3q6zd+E7eycTfO2LNxI9qY3+qS5pkW1YVeL/0ONiV/3MfhlNggK+A0AWGQ+VxZBjoCIoIaPDjJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533656; c=relaxed/simple;
	bh=uCxvq91fIV7zlKUB593M/og+Sy08hkHmHvkNocDjtAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBnP4tYat/MOI4Z4mXPI7OB5ej+r5Nqw5Qi9GzJCd67HstUHMEEGbMA2vXMsOzQjmAfErfd16PtQjMpSEyJqxGzA/pnrq+C5yn9ocO1AEN01UF7pDhmsT+eRX2qnuBf+L1QfzHYhaawp4f+zOclhVzMyQoatCDf4owPwkFX9x9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpkOpnIB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso21396455e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533652; x=1740138452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8g8mDwgrWpwYxCnplOse0iyDpwOW9AqnpV1941TQhgk=;
        b=hpkOpnIBbMRwe+B3TFOmA8pMb9kGb7gNNMg0mOexIVWOJz8Gy8l9cEp44Ksx/Mr9LN
         K2SfOTUFfpGuhW4TNoTchP+XV0QIPiSu5Yvb7pVB9n7FBbBqtbYEMsQLEPelY8BgRj3o
         1vn93/eHji0MRmr4Wv51mCX5FFrIF9iaNrnEgtAAlpvgFBjs4ktsi+cG7LpoDmi0KTD0
         0SK/alErn9UkMD4CIbXwZitJx3m6t98F9QPb2re9KIqbY/MluWYwvKWg2Pq3jwEbPafs
         GcQ8s5xD2dVsdkrFDiDOj7X8uW/ElGiIsZIZSL7tWyvfW+ypW/M2W4H9ezzDyCqrNQvN
         xQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533652; x=1740138452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g8mDwgrWpwYxCnplOse0iyDpwOW9AqnpV1941TQhgk=;
        b=h8Rmt5ltLSrw+njabckkEWR3lYl4lKQaYYrAsn08A3GCPbdAbocr0NGqWf8q7d3Ry4
         Dma8Xmck8JXJkWPh1uDi1doACPbNyNsDOaierci4KIfE+ZdtyIm/ugnvd0TpH9Q0JWZS
         yPPmO7NhJuW5UpvacwkWKzlAKjtdIzv9VMcsTOIOixqC570dCob58GJcaIBFYJ1XEwWy
         SICDwufRT8KUOtJlnnK1agl5r4QuXoXOmhgu6cgnf5wiG+SepungJqvvMnXcqZJ28Tnm
         w0xaIoCv/kTg57uU8gtJ9VCuXU2+m5YPT4m8TbhFrNdBc7ptuUnyEFzFXwGqY36kZjnb
         xS8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJt97dbqR9lmoS7AcDXsvX50k5eqR+8sDaJMHsDZWFNke7HndApxv8cup6Oq9S+82GUN9gx9hYeEMjsR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqZjuUwe0zCqQIZ6vaPiqaN50Vt4GZKh4AKRv34930cBvAQZP
	AvzuA7yVURw2vkdnjFUuVNMn0ECesJAEk29Hsbh5h7MSMwty5eRT
X-Gm-Gg: ASbGnctwUsSIczeVOp8Oz0Cbap8RMJtXS++RDVdNIX8GjmQc/Z3R1BsQyzTRyMPqx+V
	WS7TqvlU76m99wBuzQfxAHsdFvNKsq0wmkQCYk7MSkSVXvSNERrzvy/LsKLjZryWw9o1G5gmdzk
	VzYVkUc85HPeFHMCSYOUMDRarqdjhru2UBSUOEAbol8m8cy8gxWHz95HNQGHFpleAKhks2Hs+xW
	+oBZOz3V+SQOjp8l62hUNbJNBRRq2/LNduvdkK91STL7KVLMB0JnGQsediAp/npR4O3tJsYQhxw
	Q9tSHIONMfbT7udKkBhvnNijaI6abGhttCy2D5K468nRrgz2mFw=
X-Google-Smtp-Source: AGHT+IE62dvCnVIu96tU8ej81r1rPurvJp40jfvtzAAQcuVDLOv/ozFUJIrtVbP61YS/zwF5ZxGzdQ==
X-Received: by 2002:a05:600c:1e25:b0:439:43b1:e60 with SMTP id 5b1f17b1804b1-43960192a13mr100687845e9.17.1739533652258;
        Fri, 14 Feb 2025 03:47:32 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:30 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 00/17] staging: gpib: Console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:51 +0100
Message-ID: <20250214114708.28947-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIB drivers printed a lot of spurious console messages. This
was linked to the level of code maturity, often using console
messages for debug.

This patch set cleans up the console messaging in the spirit of Greg's
recommendation: "When drivers are successful, they should be quiet"

All pr_info's have been removed except for one which is in the module
init of the common core driver indicating that the GPIB subsystem is
initialized.

All dev_info's have been removed or changed to dev_dbg except for the
attach and probe messages in the agilent and ni usb drivers. This is
to facilitate the creation of config and udev scripts to ensure that a
particular usb device is systematically attached to the same gpib
device file.

All custom debug and tty logging has been removed or replaced with
dev_dbg.

Error messages where the user can figure out what went wrong with
errno have also been removed, particularly timeouts and interrupts
during reads and writes which can occur quite frequently uneccessarily
cluttering up the console log.

The patches are 1 per driver.

Patch  1: agilent_82350b
Patch  2: agilent_82357a
Patch  3: cb7210
Patch  4: cec_gpib
Patch  5: common core
Patch  6: fluke
Patch  7: fmh fgpa
Patch  8: gpio bitbang
Patch  9: hp82335
Patch 10: hp82341
Patch 11: ines
Patch 12: lpvo
Patch 13: nec7210
Patch 14: ni_usb
Patch 15: pc2
Patch 16  tms9914
Patch 17: tnt4882

Dave Penkler (17):
  staging: gpib: agilent pci console messaging cleanup
  staging: gpib: agilent usb console messaging cleanup
  staging: gpib: cb7210 console messaging cleanup
  staging: gpib: cec_gpib console messaging cleanup
  staging: gpib: common core console messaging cleanup
  staging: gpib: fluke console messaging cleanup
  staging: gpib: fmh console messaging cleanup
  staging: gpib: gpio bitbang console messaging cleanup
  staging: gpib: hp82335 console messaging cleanup
  staging: gpib: hp82341 console messaging cleanup
  staging: gpib: ines console messaging cleanup
  staging: gpib: lpvo console messaging cleanup
  staging: gpib: nec7210 console messaging cleanup
  staging: gpib: ni_usb console messaging cleanup
  staging: gpib: pc2 console messaging cleanup
  staging: gpib: tms9914 console messaging cleanup
  staging: gpib: tnt4882 console messaging cleanup

 .../gpib/agilent_82350b/agilent_82350b.c      | 118 ++---
 .../gpib/agilent_82350b/agilent_82350b.h      |   3 -
 .../gpib/agilent_82357a/agilent_82357a.c      | 359 ++++++---------
 drivers/staging/gpib/cb7210/cb7210.c          | 133 +++---
 drivers/staging/gpib/cec/cec_gpib.c           |  32 +-
 drivers/staging/gpib/common/gpib_os.c         | 127 ++----
 drivers/staging/gpib/common/iblib.c           | 109 ++---
 drivers/staging/gpib/eastwood/fluke_gpib.c    |  90 ++--
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 140 +++---
 drivers/staging/gpib/gpio/gpib_bitbang.c      |  56 +--
 drivers/staging/gpib/hp_82335/hp82335.c       |  19 +-
 drivers/staging/gpib/hp_82341/hp_82341.c      |  70 ++-
 drivers/staging/gpib/ines/ines_gpib.c         | 101 ++---
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 255 ++++-------
 drivers/staging/gpib/nec7210/nec7210.c        |  69 +--
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 425 ++++++++----------
 drivers/staging/gpib/pc2/pc2_gpib.c           |  51 ++-
 drivers/staging/gpib/tms9914/tms9914.c        |  33 +-
 drivers/staging/gpib/tnt4882/mite.c           |  17 -
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 186 +++-----
 20 files changed, 912 insertions(+), 1481 deletions(-)

-- 
2.48.1


