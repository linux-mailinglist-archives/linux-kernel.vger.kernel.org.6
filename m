Return-Path: <linux-kernel+bounces-444980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25C89F0F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CD418822DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024631E105B;
	Fri, 13 Dec 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqBOu3VI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99D8F5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101367; cv=none; b=Np5pIL89cSW34gu1ohKmBtb9cEVq+Wl/6LCfNK4dIV7m4kiwSJK3inUwK/GgnOlrP/+GFgkXRroOLS1sVnSkX+lWC28oicqDIQk2KHn3guQXj7FPrj5qwhH2V/LiybIFlTcRihP/X6ppzRA/QfNWmUK6TSEzRrE7wyVkqqmMI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101367; c=relaxed/simple;
	bh=75t03ladYEpJNk/lo5VPfvNoe5j+bZgltvvQYOZ0yV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOapAWMcU6IZzSNWLNXScfTpu+dAmqc348/kN+8syOAsJsitE0bygyVFIZlj5HJt7ugXndzzfKVikxD98GlrczeDrOCeyHwkuna+ZVwZbpjbsNH/UoKPV4i/0Tk2/CCpkEhHR6+TW5W9kCsxDjfiMO7kAltrrD7rPAJToIW1aV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqBOu3VI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso19287405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101364; x=1734706164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8GoCBmwykt6c3qkAuns3te+tR7WufYhRllGnYRB9TU=;
        b=iqBOu3VIDRofZgSKmlba3xQLe4KPs+YTpL7Qdwtx1RJZ7kXJMXPOOGI7u4tGCR9VIM
         Uap81M/ebmBUcdfGSGuo8JbE9RLtuzxETX6ffpF2xPsZRl6He2xU5SyMOF5nt6WBKkJh
         jmCgf00rbRBvK+Bz6pXrA13R9herzysTAAp/WMWvOG1iUosGiVTjYR+xqir0HyRRqKuD
         3pwRFn2NPLp6Ihdp7EvzQdsGaRDM96+JDERqqercOHKE08V488YofqqK34rqFDljZodK
         y/CBdSOAZeaYXVAQVETx3iO3MxY4p65y9PVP6ctkF3ZBDuzjBqCeL8UDUe6U1gq77h1W
         jKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101364; x=1734706164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8GoCBmwykt6c3qkAuns3te+tR7WufYhRllGnYRB9TU=;
        b=U5tvYoUra7t3o48oBoZ4X9KbaMSxj0DplkzERaxtJAPJxe7wC9BuMMbyAu+7SvHqSP
         LUNeHxb0lgEvlKmBuKNBLO15ERJEQYnkxe7zMxECw8bzURg8KMdV2u/rERlIsF8Aw+Wu
         OncSFvf70tK0/RRRM/21PTD7z9iJbGpPrERb79w6M9JyPYS/J182tJFx+p+Nyf4SZXy8
         aFewul8Rc2B5/7AE8tglNWAlpQTxvSf3JuzdZkWpEVGZQQJvcXtlhQ9S9Qm4WMVfkkwk
         mhCKxhiJZh41JZJmahLQkvT39JECGMrqWqwX8wvzoYJXce5WjDsMqMOCh6+gq6ei+Rq3
         3EcQ==
X-Gm-Message-State: AOJu0YxQFmD/aV92cP4khjllcHTq2xE1oDoloFRQS/fCbgdqb2DE/rq9
	95xb27KvvTzIekA/Io8/PCATs1NGRIn2wV5ATXnmjIgNnm0GCMrwU2NLs9QEiDqFIJV8uExVsx1
	i
X-Gm-Gg: ASbGncvQD9H5l/omGk33FSAIfJmMwtcy9SvwjPwc7boen8CBH941Sfy7rThKH7hYcJu
	yzY7vAEdATyKaAD9cUvPK7cVrGVuNNI4X4Ew8EdVx1cbqqKMK1ESwgVJkjVYwrun2fw3nnX/Wg3
	n6DK8vlliaVGZ+1oD4/M30dEscauNGAIcxcJSuGvwk0Usg9h8bLGw7wxxgYCXJH6b6cLniPBcs1
	NgCRv6GpAGudzd7v37hBRTDdYa1O/ENmMcYhlYyQPLPLBNjpnWz0vVKZQ==
X-Google-Smtp-Source: AGHT+IHuKTAtkAStuGvLvPcrpQeQQpsEVf2xFpYQ2v2zKJ5P0Iz/QfOrm/aJ+WBkyPYCOtebr28gcw==
X-Received: by 2002:a5d:64a7:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-38880ac23d0mr2122716f8f.1.1734101363889;
        Fri, 13 Dec 2024 06:49:23 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:dd7a:c2d:2b46:b1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c50b7sm7196295f8f.57.2024.12.13.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:49:22 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: james.clark@linaro.org,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH v2 0/3] Extend logging on TMC start / stop errors
Date: Fri, 13 Dec 2024 14:49:16 +0000
Message-Id: <20241213144919.110642-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend logging on TMC start / stop errors

Recent issues with trying to debug TMC timeouts and flush issues shows
a general lack of logging and context around the possible errors

Add logging to general wait for stop coresight routines and return values of
watched registers.

Update TMC to use this logging.

Changes since v1:
Rebase to coresight/next (kernel 6.13-rc2)

Mike Leach (3):
  coresight: Update timeout functions to allow return of test register
    value
  coresight: tmc: Update error logging in tmc common functions
  coresight: etf: etr: Update logging around flush_and_stop() errors

 drivers/hwtracing/coresight/coresight-core.c  | 50 +++++++++++++++----
 .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 12 +++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  8 ++-
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 include/linux/coresight.h                     |  2 +
 6 files changed, 86 insertions(+), 25 deletions(-)

-- 
2.25.1


