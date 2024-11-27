Return-Path: <linux-kernel+bounces-423521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E269DA8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AFBB24519
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3891FCF79;
	Wed, 27 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEABXcC1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5149463
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714983; cv=none; b=qBqrFWzrZQWbaVAFGJBCqRGSGpqaKXVM4TYb1i2RAySbI/eKEDK1qzzxzXyvJsKqP5UmaHhNCnPf9vkg1I0d2Y6HO+CDZBx0O3Yiya+8/IX6xqVGkS0vGvePai98W2xRslyHEuQKBUdtNs21Qi2oJwcL3pgsWp2YiFVZaI0JZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714983; c=relaxed/simple;
	bh=9N4eMMS/IUhn0SnwuVXyH2D1iC0hefspmnuG0LK4PNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rct6clmNTthrokttC45+4OYUQTE+hOi6MPgFEN89XRfOfGeGPaskoKDjlvw5a5fyYqlVriVtFkR6r3mCBtQpDpJijHRVU2msqhyT1kdCV7YP8stCkHkBRi0sanXVUJMLaGqmQwjxWHpBPdIfCeGjFg+odX3yE7f2pKUxNr2TXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oEABXcC1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so5192881f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714979; x=1733319779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCAuWu+V7VZ+rFKxKqyS+9DoTo/OFL0+V5wGxEuB7zI=;
        b=oEABXcC1of9fNbCuz8edV9LCNG1wOXIrE10VDAv44wgsRX17GZ0qXwXlZYKLUI5bVG
         pfS4bx9GJYo5HrP0MViBHhNboKifUw3EvBogpiVd/6X5dRaWDV7fCqF5gbYHuW2jcqVp
         /xCDqL21b9cuKt9LJ5vnkts7BUpErBtwuriJm9XF/CYIQ5wNfBU/qPjheHj6gRIOb641
         uBkZQRHqJZko89d9pPtMa9L2KYCcy1jvBukeO3aTJ4dg/bQ3A7YdQ5Ngk3YSbtDb0pME
         YiurgaGwMsLp7b+I1WEV22+q1pwDE1Y8SpZycSs2z4Sex8uUybP7CyykCQC3Y77c7bkY
         5YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714979; x=1733319779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCAuWu+V7VZ+rFKxKqyS+9DoTo/OFL0+V5wGxEuB7zI=;
        b=AwCmBOo3rWJ06h3I5wAF5Q7BQsoLR3SBjBfUXAX+Xa5aVBr68s2wRWCOBQ34qQpzsD
         bxZ4C5Gqlj5ygBkPuTwfDv5xs0P45IcEBgt/hcHYgnrLr6TpR0VOzxtY/74KrQMgZVUI
         pxgE4z4eoJDaU1A4qYleBWCMOWJVKBd6TCi7f0fiNx4nILblR3WpU35a4pADINXigKhK
         9vs2xHrb3ApPbutsGUaf54gva5G3eeNFpCCKcNChSo7rSJePn9GIxnnoAzqF+TkU9dbF
         ZhZg9qnF2sOut70YHyAGV2af8tCesHXL037R/ndkthICdt18FCtZY6YHMDa2I+/UwF44
         xD5g==
X-Forwarded-Encrypted: i=1; AJvYcCWTBw1JwvRthN21kK6o3Y8NMTapCHkBrF/RjSpuVh8v/dCX3mFUHVfabO1iJgbqgTM3xKhEc5/B/MpnEDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAL9yVP3FKdhFhMLCwfgEfFTB32CqVBWlFgA3v4NyoAJQBjA5o
	+2zfFVHXEJKcWt7UIWya/lyfyv6Z+o6sDXbBYj5YCt0UQzbpOv6i+LnenGOE7hw=
X-Gm-Gg: ASbGnct/NVWTBgwdCShK/rra7a3ay5ATyLz8Glv+bZS2YeFwq7bMmaa+mYroq3baScT
	pctpRy3h9Yi9ydtHtl/NyVdP4xriiituKeJTx/maYk3RfetXT5drwngwz39ovE2jJvnRU2k+Bqr
	xQ9jPy8cISSCqvAUKAJbLJI+EUpzKk3AMgqwIAIyyXZ4OfKkviSMnRNVVv/RJIhS2I5b0RaOVDS
	EIQHDiX9wlTlarp+Smmdx3Kvg//Melj9EXpCXjykdFsbseMLeJD
X-Google-Smtp-Source: AGHT+IE4aMEOtU8RVRCofnpurS/X9S5YYhfiVo8pfMG4zNg/q5kFoXtc3bz//V2XNK5d0rMQCMSh1g==
X-Received: by 2002:a05:6000:4708:b0:382:5010:c8da with SMTP id ffacd0b85a97d-385c6ee187bmr2868608f8f.59.1732714979608;
        Wed, 27 Nov 2024 05:42:59 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:42:58 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 0/9] coresight: syscfg: Add configuration table load
Date: Wed, 27 Nov 2024 13:42:47 +0000
Message-Id: <20241127134256.2254851-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set extends the configuration management support to allow loading and
unloading of configurations as structured tables.

The existing coresight configuration configfs API is additionally extended
to use this table functionality to load and unload configuration tables
as binary files.

This allows coresight configurations to be loaded at runtime, and independently
of kernel version, without the requirement to re-compile as built in kernel
modules.

Loading configurations in this way provides a method for atomically programming
the trace control elements (e.g. filters and triggers) of multiple connected
CoreSight components as a single system for a trace session when selected on
the command line both when running trace via perf or running trace via  sysfs.

All configuration are validated at load time as being compatible with the
CoreSight system in use.

Additional load and unload attributes are provided in the
/config/cs-syscfg subsytem base group to implement the load functionality.

Routines to generate configuration tables are supplied in
./tools/coresight.

Example generator and reader applications are provided.

Tools may be cross compiled or built for use on host system.

Documentation is updated to describe feature usage.

Changes since v6:
1) Rebased to coresight/next - 6.12-rc4
2) Adjusted patches to split the load/unload API from the configfs attribute
   declarations
3) As unload order is strictly enforced to ensure dependencies are not broken,
   unload is now a simple write to attribute to automatically unload the last
   loaded configuration without need for name of configuration.

Changes since v5:
1) Possible memory leak removed.
Reported-by: kernel test robot.
Reported-by: Dan Carpenter
2) Reuse mechanism for reader code revised. (Christoph)
3) Unload mechnism now by name in standard attribute, rather than
entire file
4) Mechanism to check last loaded configuration can be unloaded.
5) Documentation updates.

Changes since v4:
1) Update coresight/next - 6.1-rc3
2) Update to lockdep fixes to avoid read lock race in configfs.

Changes since v3:
1) Rebase & tested on coresight/next - 5.19-rc3 - which includes the
fix patch for earlier configfs works.
2) Lockdep investigations resulted in re-design of some of the code
accessing configfs.
3) moved load and unload attributes to root of cs-syscfg. (Mathieu)
4) Additional minor fixes suggested by Mathieu.
5) Memory for configfs loaded and unloaded configurations is now
explicitly freed.
6) LOCKDEP nesting fix for configfs base code (fs/configfs/dir.c)

Changes since v2:
1) Rebased & tested on coresight/next - 5.18-rc2
2) Moved coresight config generator and reader programs from samples to
tools/coresight. Docs updated to match. (suggested by Mathieu)
3) userspace builds now use userspace headers from tools/...
4) Other minor fixes from Mathieu's review.

Changes since v1:
1) Rebased to coresight/next - 5.16-rc1 with previous coresight config
set applied.
2) Makefile.host fixed to default to all target.

Mike Leach (9):
  coresight: config: Add configuration table processing funtionality
  coresight: configfs: Update memory allocation / free for configfs
    elements
  coresight: config: API to dynamically load / unload config tables
  coresight: configfs: Add static type for config attributes
  coresight: configfs: Add attributes for unload operations
  coresight: configfs: Add attribute to load a configuration table
  coresight: config: extract shared structures to common header file
  coresight: tools: Add configuration table test tools
  Documentation: coresight: Docs for configuration table load

 .../trace/coresight/coresight-config.rst      | 287 ++++++++-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../coresight/coresight-config-desc.h         | 105 ++++
 .../coresight/coresight-config-table.c        | 431 +++++++++++++
 .../coresight/coresight-config-table.h        | 151 +++++
 .../hwtracing/coresight/coresight-config.h    |  98 +--
 .../coresight/coresight-syscfg-configfs.c     | 577 ++++++++++++++++--
 .../hwtracing/coresight/coresight-syscfg.c    | 103 +++-
 .../hwtracing/coresight/coresight-syscfg.h    |  19 +-
 tools/coresight/Makefile                      |  56 ++
 tools/coresight/coresight-cfg-bufw.c          | 328 ++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 +
 tools/coresight/coresight-cfg-example1.c      |  62 ++
 tools/coresight/coresight-cfg-example2.c      |  95 +++
 tools/coresight/coresight-cfg-examples.h      |  25 +
 tools/coresight/coresight-cfg-file-gen.c      |  58 ++
 tools/coresight/coresight-cfg-file-gen.h      |  17 +
 tools/coresight/coresight-cfg-file-read.c     | 239 ++++++++
 tools/coresight/coresight-config-uapi.h       | 105 ++++
 20 files changed, 2644 insertions(+), 142 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-desc.h
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.h
 create mode 100644 tools/coresight/Makefile
 create mode 100644 tools/coresight/coresight-cfg-bufw.c
 create mode 100644 tools/coresight/coresight-cfg-bufw.h
 create mode 100644 tools/coresight/coresight-cfg-example1.c
 create mode 100644 tools/coresight/coresight-cfg-example2.c
 create mode 100644 tools/coresight/coresight-cfg-examples.h
 create mode 100644 tools/coresight/coresight-cfg-file-gen.c
 create mode 100644 tools/coresight/coresight-cfg-file-gen.h
 create mode 100644 tools/coresight/coresight-cfg-file-read.c
 create mode 100644 tools/coresight/coresight-config-uapi.h

-- 
2.25.1


