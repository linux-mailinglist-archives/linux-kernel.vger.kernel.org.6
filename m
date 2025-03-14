Return-Path: <linux-kernel+bounces-561912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72DA61881
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FF71894684
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A92046AC;
	Fri, 14 Mar 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xx9xDPw7"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F02629F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974516; cv=none; b=k/2riqChJhDKv2FvDB/KwtEEs+/DAnpw2NdPmmxPgKpW8pOf5NcNHIlua+6A86MWrLbL09v9qxFEOAkawckOvhsgfkkthkG2jeh1OmI1m/cYcG46SZi0Ro8T+KXWLB2cojOnIGNFmdfJczFxtBmans+kQx2qilmovtHgP2d4TLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974516; c=relaxed/simple;
	bh=IzDAV+gYsb3R0IxhRne4fUzRoURlhC9ZqkgzyiKPOxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJJDjkUNpS3ZaDNge17z6N8wwbOuLNDZBItdu/N7SKkHiMqBWC5bzQtJr5Lc530yEndKXVxheFOlZ6KQU/ulSsC3gMcA3hfHxNXp9ZOzeg7F1T5nnWMLodOBTpFFaGXQ4ZkXiINqcUetEAhJ3evFeMR6+DjeQ304S46w4AF/nKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xx9xDPw7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1874725f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974512; x=1742579312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVmcC1q9onxkQ8qIPslGo0PmndpeWfhIGHdL4vH7f4Q=;
        b=Xx9xDPw7WDyjbUVQC3nLmAlFTw7+sfEfXixX+CnjGl1SuJHfK6zhSHJrbkQRiz2j7j
         kUFL+n9K0RXdVsRNys3ziRPE1r3Kcy5AXlP/Z+PYWZ0TD/za/SWTmoCfsxpEMgQmkgjm
         eFpCWWqRbdX1MkIfz1cqB/iDm6CyLC39LiSBaI3R1CWzptrHqgHymdIF0Fw4bq/w5ZrQ
         vXw4lW8QLZFtasGqeLPrSWrkJafvjIx+VQCjBaSg2Gvl8NqiymlhB/kJP2ZRSWytNSBx
         /CLZMf8cEQ2J03ej8xNsagcFm+DhXH3AEEY5WpEwQHMzrpu1NJrYuovUbRp1bxASiYeF
         lxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974512; x=1742579312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVmcC1q9onxkQ8qIPslGo0PmndpeWfhIGHdL4vH7f4Q=;
        b=NUL94xGJDa7//wcq7XteToSuMztgD9xo4MZofcRZGSyFve46+RRrMOHJfAlXt1Pt82
         1WgIpwAv9wRvRl0m5fsQVUQ4cALYYSmOXQNi3weMIm8PihrqigQfchdxuV2CrueXogxI
         eUnsZjyd4tg9qeWi+cyfM9ExqqvA4XCDexPVE2yJIZPu8T7GH+rGZrZmkjAE9okfUXkA
         ij08qrG1IEuxuwI+bJVGhi4N9mKCpOe82hyF/UmaG+SE8hdPTlmToTDWIqOsemloYqbc
         kWTp1bp788EnDJ0NeJ8g6HVn8r0wHQ0+nmyDAhLoao8mKaL25XX4nuuqoEfBztGE7oNp
         pcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7w8p8jW4HYQ8ThD9gaAOE7pxaoZQQiC84Cl33mE7x5zDGv64vngfQ2MBdqZ8u1oVPL6zCx6ciQyA9bBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKY4PP3DIEHxgBSiGx78SmvCnhTAUUqhlYUo8FrRFkFNXPq9M
	4v0q30+VGuyfITjLxPEEU/00I38pDIxgD7fUApEqINY3M+a5VGBsUYIdq3IGBQA=
X-Gm-Gg: ASbGncsZgVFZy1PjAjn12AAYGHZ+pvmTigtosjHEMt0Reu3YLqZzYn4gYUIupWXaipq
	DLG/Gbf2cdAMrKDXWXyviy99rnlSoU76Yl30RBAsqZ6+kGzK9GnWZEqIvseH2SQW/NP7h0/uL5D
	dpgmsY+Lg2yA/nGdQ9hvKQ86qJLUWNWcl97mqxFBlbVUNp2oMdRGPrYKreyf+N2WpB2TC2dLZaK
	C/7lmw6t/kKmzecQdFfGIGNK1UuYU2qYwbhgiW/rM+4QIpU7rALzXB97G6Vk22ds4L/Ht381LWS
	Mm9Hh44gQrWLsqV3WeS8xq0/1+WjitWO+Z4ixLr5ibTtF7yRq8L4dkkG8fD8ZmCeDZgYQg==
X-Google-Smtp-Source: AGHT+IGtBBkrjkuMMQ03zRppDLDBvMmrjEbEft6rrg1dNIsffYzTsNabU1xGBiuZXms8ctgtipDYpg==
X-Received: by 2002:a05:6000:4022:b0:391:30b9:556c with SMTP id ffacd0b85a97d-3971d237e13mr5115917f8f.21.1741974511674;
        Fri, 14 Mar 2025 10:48:31 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:30 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/5] ASoC: q6apm: fix under runs and fragment sizes
Date: Fri, 14 Mar 2025 17:47:55 +0000
Message-Id: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm Audioreach setup, some of the audio artifacts are seen in
both recording and playback. These patches fix issues by
1. Adjusting the fragment size that dsp can service.
2. schedule available playback buffers in time for dsp to not hit under runs 
3. remove some of the manual calculations done to get hardware pointer.

With these patches, am able to see significant Audio quality improvements.
I have few more patches to optimize the dsp drivers, but for now am
keeping this series simple to address the underruns and overruns issues
noticed in pipewire setup.

Any testing would be appreciated.

Please note that on pipewire min-latency has to be set to 512 which
reflects the DSP latency requirements of 10ms. You might see audio
artifacts like glitches if you try to play audio below 256 latency.

thanks,
Srini

Change since v4:
	- added tested-by tags, including cc: stable
	- removed a line delete.

Changes since v3:
	- updated period size aligment patch with 10ms period size
	  contstriants.

Changes since v2:
	- dropped patch which is causing regression with pluseaudio.
	- setup period sizes only for capture path
	- fix underruns/overruns in dsp pipelines.
	- add fixes tag
	- add patch to fix buffer alignment

Changes since v1:
	- added new patches to fix the fragment size, pointer
	  calculations
	- updated to schedule only available buffers.


Srinivas Kandagatla (5):
  ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
  ASoC: q6apm: add q6apm_get_hw_pointer helper
  ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
  ASoC: qdsp6: q6apm-dai: set 10 ms period and buffer alignment.
  ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.

 sound/soc/qcom/qdsp6/q6apm-dai.c | 60 +++++++++++++++++---------------
 sound/soc/qcom/qdsp6/q6apm.c     | 18 +++++++++-
 sound/soc/qcom/qdsp6/q6apm.h     |  3 ++
 3 files changed, 52 insertions(+), 29 deletions(-)

-- 
2.39.5


