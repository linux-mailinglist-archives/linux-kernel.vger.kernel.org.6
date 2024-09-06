Return-Path: <linux-kernel+bounces-319448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12AF96FCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61481287084
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C621D9D99;
	Fri,  6 Sep 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hGEEC8Rj"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715821D9336
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654502; cv=none; b=bInok3pl1Mava5w9bIW4RdMAMYOk5CA0LYGRYxqKiZqZU17Up/WoJYjmCVwMC5el9gLjT+ftcfKbfwN1/WKu7pmkaRoUNH6b0ymagZ+yqCCWUB+BNzJ4PDgrIkDsUAJ4COfWJcq3p9pzJruBjQEYK0lxY3WP99qFYKa8wkBqYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654502; c=relaxed/simple;
	bh=doTWawTV29YQdrFsrjDJti/GkvWFMX8WBAXCStbjNfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyXIdzpKeJoeO8LrEref8rPdn68JGT8/ITR1G4qKus1/HwWA1SYCPrvFGk/difjrTsHRuX3crlNtdlwvH8FGLo1zMEuWnzhM+smXOoW/RgmJj5Z0QHqF+yV86WihNrXwmHXLN2lzVW25Eo9xt+HjQRt0KV/FcbnO+LRbdaBE3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hGEEC8Rj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a7ff6c4fd0so156983685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654499; x=1726259299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPSSppbOUZ5X6xcZOhAwnSUnx8e+XDSxdIhfjelruu4=;
        b=hGEEC8Rjkwh8NR5fsZl6rtXYiBq7p3deI/ha5ndVkfUSijYI9IPPIwRAZwRoiCMPZa
         HhI+cZu0WFaxEH2NDyhuxemzwJAmwnd44vGvahybQMTuhC+g9NbzC1DT6NwAIWva1utE
         ZJhPhXir7K67qYS2cXYaY3RwAH0MhT99VU2ywFLULX7xrQk/HWUSAPH4EdeEh9XdehEn
         hmDVXy0QDf9Hi52J+JhYmYca9oQmxmiNBWCvVw56wZ4ra8FUtyfnXHw5//ukzDuGEW5N
         2lXGdIwkJ1aRXD5+ySb1aR8KFf8NXnKWvb6WEV0QC2hdZnbIqB1B9+35pIhO8uXe0dgp
         qFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654499; x=1726259299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPSSppbOUZ5X6xcZOhAwnSUnx8e+XDSxdIhfjelruu4=;
        b=aB85NKC8tp1ZMur0Yf/EISFeOByX4K4SUmlWfxkwGLacl4ViK7T5ObreXmLhBE+j0r
         OUzwTynBlnd9z05vDgZdO6txxa+sWTbcKDrX5OWgWe+Vof++A7Jh/D8PefqlvoecdeMA
         /YJrYQjw4eH3qs567VGud1CeHl7iasUhcZCifAPvbe/Ehz4YVj0uyHGH+EGvYa5NAM7K
         PGyilQXdslbpiqhWKsb5WzEPVB/KRQ0zl2LRJXH1QjEyVys/JQ9YGaHhGwYOeWEsOErO
         Kyhmq4aF4AaLpi2IfF08iOFJz38ho0MejBtuuylS6mY4y13VwGctga5n5/FL2YLbcg5M
         vM0A==
X-Gm-Message-State: AOJu0Yy6GPxd4u3Rq6bcE3LO9+r/CtFb2ztoiKui/5qd3yR7b15B21Q6
	KQdxdHlJL/wtDbe7T+TOnpRAHfUcUPbFhgNFU1VYP/xhamu217IevwvNYWhskY4=
X-Google-Smtp-Source: AGHT+IFSlFEFOO6635M1TLJwlIjFEPq4rQp9LTMZ6WTt7A5h+sxSAOJMaDt4EpTLVnx6LCx03ktxmw==
X-Received: by 2002:a05:620a:1a04:b0:79f:174c:4e4b with SMTP id af79cd13be357-7a99731e270mr473075185a.1.1725654499161;
        Fri, 06 Sep 2024 13:28:19 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 0/6] libstub,tpm: fix small bugs and improve error reporting
Date: Fri,  6 Sep 2024 16:27:39 -0400
Message-ID: <20240906202745.11159-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efi/tpm code has a number of small signed/unsigned bugs and
inaccuracies are prone to cause further bugs in a difficult to
debug manner.  For example, there is a signed/unsigned mismatch
in efi/tpm.c that leads to a memblock_reserve on a range with
an effectively negative length.

Additionally, there are silently ignored error conditions that are
better explicitly reported.

Finally, there exists some bad interaction between tpm and kexec
that causes the log version and the log size to become corrupted.
The log size cannot be reasonably sanity checked, as the value is
a u32 and there is no defined max-size per the spec - however the
version can at least be sanity checked. This reports the error and
avoids calling memblock_reserve with clearly corrupted arguments.

Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (6):
  tpm: fix signed/unsigned bug when checking event logs
  tpm: do not ignore memblock_reserve return value
  libstub,tpm: provide indication of failure when getting event log
  tpm: sanity check the log version before using it
  tpm: fix unsigned/signed mismatch errors related to
    __calc_tpm2_event_size
  libstub,tpm: do not ignore failure case when reading final event log

 drivers/firmware/efi/libstub/tpm.c | 14 ++++++++----
 drivers/firmware/efi/tpm.c         | 34 +++++++++++++++++++++---------
 include/linux/tpm_eventlog.h       |  2 +-
 3 files changed, 35 insertions(+), 15 deletions(-)

-- 
2.43.0


