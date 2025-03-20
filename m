Return-Path: <linux-kernel+bounces-569876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E1A6A8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C71816B1AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273881DE2DF;
	Thu, 20 Mar 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMr5Hqnk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837E1A5B97
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481311; cv=none; b=JewwIYekexhJHnDFMiUU2j4DkPNnerMlQwyVc0VjNmIKnrunrabNxcvg+FRXoKFilldjsaX/xBlIN53JCG8DLyvuvzxY9GohsoLCTES5flOpyLe6kvBq41apPGActWCUuzmUyAI8GFoFK3tWiwNsC13gk5r83mydOYYWzg7Nk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481311; c=relaxed/simple;
	bh=PpPxVJg/DAvNVaOGYmoguz/tugKcWXGqkXojDxKszRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e1Drl3Pb1C0Mpjnc5HkOlCKXjgtMZaWpB1rGp9OFLGvOldLmmA/VXxZPWuboJXYVW1MF2vxOLEHo4Mfmt7m8xyexrQ+89hXAoUkLOlHalMzfVjlMCLfKaArnjnBvLKc/XOYOXQiaFdDw9vF6RsGOQfQeytaB3PXSVdu5qvokM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMr5Hqnk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso6083745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481308; x=1743086108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uKjmvKFIJwQeQjhs6y043yl808flrdLcwtYSXqapk=;
        b=zMr5HqnkI/P9JNugeOugg91ImZ1vAdq4P2kxMHhqbC5apjkdR9T/3TervsguD+yF6v
         IetCFmzBElwgZif1k0RlflIUpQ9+QvLiIKSrakBO9U5ODQv7weAQzv2WYMMdPHwdAGMS
         BwslCXzq6kqA1PtgNr0zlO48VxYY4glPVMaWJGHJjAXUH1+fI0sUeuNvhsugqRDXvaMa
         DrH1OqAs96WeissKQLtGXAXjGLk9t+BL3/C0tGknjqlwKfaYEX9Er6oTPJYXMgydt29S
         S/1uEGc3I2RZzgXM6aq6plD3QtoOnnUSyoqP1Lj82zRWxUQu2nbDP4UG3sFbH2qcJ7Dq
         cNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481308; x=1743086108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3uKjmvKFIJwQeQjhs6y043yl808flrdLcwtYSXqapk=;
        b=Oj7jyVxzng4DzQkaf3iFxLRHFEvcX238s4JSljKSsnjOmVzlkFBYCeqXa5sXU9jWZB
         RFtrDQT2t8I3av8a2jhTDu6aHSGhHDWwL+wPLBcYQQ8MqdHC8st7R8iV0JwBY/Q3y1L0
         207YLPAGQICjfdF/jiahyCo+08zIFABuEyEYQ7hR1cLxD8xFSjRkB8m7SH+mgvvXNRDz
         fw+Z2oBcKFftiuX3EtBjonhkxfkN6S/RU1nVVYpMRKzFSeYkpwIzmpwDsrjrvAFi5vSs
         6NMEtHs6FGccQj3tieh79q1/I9aA/2ytsdWG5TFPdnuYyx61ME4SwfvWLm8Ruee/K3Sw
         rgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/8s1pQQv1vTMCFYJcznTLBZhdEqcfdGi3urLdOnNrLl95oWRsi4BX9L3a+EQjWBAARDG0ScqfVhCGBCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EtNVk2fTLHq9xzNAvHkRJJiLyoyA0ALQcUREO46Q7P20BTqu
	zJZP06JlDE/3SRIoAdwzNWtzcftQ732w4d9M77ore/oD08cTn+tmr07uqSxEx9Q=
X-Gm-Gg: ASbGncu+UwY1FEriU0Z3BtCN6IeZUyUQMUgyaZL5yJiakjLOSPoQIBYlm36H69UP6HM
	SyQDkc9NE/g+zC2UWElBqeVDuMpJ7fGQQCDQoU211pZg3hGUYdsz+V5ltVRIHNS5XtjYopugkmm
	czmX7Xv2DjRGd6h28r7JkY4p5W32z3BKHYVdFKs8UJgI44y1QZogu0EGq09q8VZ8tjmV5CA240S
	Y2Am9bpyRbNh88HgEGMO0uYKYawxJfpcCAajjw/puLYhqAI0Ee6rX6PEOUcIc2Vw3v04IKb5JLn
	Wd/UlyPya1YpNe0h7so1N0oCkMAdNuVtZSVDtjxn5MpZHdc=
X-Google-Smtp-Source: AGHT+IEi+3lvXUBBl0Xfy6+/zMNSE6JUBwO9nHsVgmXy4u5Zz77pany2bxefRYqYSeHLwQMSeBXSLA==
X-Received: by 2002:a5d:64c4:0:b0:391:2d97:7d0e with SMTP id ffacd0b85a97d-39973af6beamr6757865f8f.42.1742481307687;
        Thu, 20 Mar 2025 07:35:07 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 0/7] coresight: Clear self hosted claim tag on probe
Date: Thu, 20 Mar 2025 14:34:09 +0000
Message-Id: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEn3GcC/33Oyw6CMBCF4VcxXTukLde68j0Mi6YMMF6omRKiI
 by7BWN05fIkk2/+WQRkwiAOu1kwThTID3Gk+51wvR06BGriFlrqXKaqhLO9YQDnGQN1/Qjuauk
 Go+0CWFRZoVrV5ihFBO6MLT02/FTH3bKPlz2j/ZJaKSVTk+WJKcrM5KDeH5Lo8uV4pcGyTzx3K
 9hTGD0/t9hJr+ynq/rXNWmQgMZV1rgGqwx/2XpZlheviR+aBgEAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

I've gotten stuck a few times with unusable Coresight after a warm boot
due to lingering claim tags, especially when testing the Coresight
panic patchsets.

This change does some tidy ups, adds some debug messages and clears the
self hosted claim tag on probe. The last two commits are unrelated
tidyups but they touch some of the same functions so to avoid extra
conflicts I'm including them here.

This gets as far as fixing the claim tag issue, but there is some other
state not being cleared on probe that results in the following error.
This can be fixed up as a later change:

  coresight tmc_etf0: timeout while waiting for TMC to be Ready
  coresight tmc_etf0: Failed to enable : TMC is not ready

Changes in v3:
- Collapse rename and locked/unlocked addition commits of
  coresight_clear_self_claim_tag() so we don't change the name twice.
- Make coresight_clear_self_claim_tag() a bit more generic by only
  doing UNLOCK for MMIO devices (although there is no use of this right
  now)
- Link to v2: https://lore.kernel.org/r/20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org

Changes in v2:
 * Revert most of the interface changes, just call
   coresight_clear_self_claim_tag() directly. This is possible because
   we're not doing the read first, so it has fewer knock on effects.
 * Split out the change to add struct cs_access to etm3x
 * Add another warning for racing with external debugger

--
2.34.1

---
James Clark (7):
      coresight: Convert tag clear function to take a struct cs_access
      coresight: Only check bottom two claim bits
      coresight: Add claim tag warnings and debug messages
      coresight: etm3x: Convert raw base pointer to struct coresight access
      coresight: Clear self hosted claim tag on probe
      coresight: Remove inlines from static function definitions
      coresight: Remove extern from function declarations

 drivers/hwtracing/coresight/coresight-catu.c       | 12 +--
 drivers/hwtracing/coresight/coresight-core.c       | 87 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-cti-core.c   |  2 +
 drivers/hwtracing/coresight/coresight-etb10.c      |  4 +-
 drivers/hwtracing/coresight/coresight-etm.h        |  6 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 28 +++----
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  8 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  1 +
 drivers/hwtracing/coresight/coresight-platform.c   | 26 +++----
 drivers/hwtracing/coresight/coresight-priv.h       | 20 ++---
 drivers/hwtracing/coresight/coresight-replicator.c |  3 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  6 +-
 .../coresight/coresight-syscfg-configfs.c          |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  9 ++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 16 ++--
 drivers/hwtracing/coresight/coresight-trbe.c       | 18 ++---
 include/linux/coresight.h                          | 40 +++++-----
 19 files changed, 168 insertions(+), 134 deletions(-)
---
base-commit: 5442d22da7dbff3ba8c6720fc6f23ea4934d402d
change-id: 20250317-james-coresight-claim-tags-ae1461f1f5e0

Best regards,
-- 
James Clark <james.clark@linaro.org>


