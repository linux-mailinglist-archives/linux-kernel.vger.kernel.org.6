Return-Path: <linux-kernel+bounces-561579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C982A613AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F95882E55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D2201261;
	Fri, 14 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+CyNF3q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEE200BB5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962807; cv=none; b=UFjYz8Si9mgrIS/ao1isKhlSUc5pmqKtkQmg0Kldfp1WWN04BR4BFwl767GdMTicz6zeK46bp/AbrmNFMv5+XHpZrHlUQKxswb+GeHlG/4IRXi0HGruMKVOwdqVWhwP4BzucTfovvbGHe30mRpHcZXNV8asR2VEnZi9cGHMA7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962807; c=relaxed/simple;
	bh=fV6t0EBtW1B2j37NCyDxPKTtjpES7eWc33aab4NlE1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rm61m1qROUNgnIyA4UOuXRlcHBpGtX49VPqxUQ6mx/Nh+EoIpECZHJmtu2VciaUKllz75v7yZ7MDygulzUhrebAEERy14OWv2cvGdauT7O7NUsReJIu/qTSlJKK+z0sXs1l15VOZJSN3DUcO40D64XLVHMlF9qlBFc5BLpA1DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+CyNF3q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2f391864so1272936f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741962802; x=1742567602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gqYv2Yv6I6A8Xg36oF3GXiMSJjKsROFpNr6KE/A4Xs=;
        b=X+CyNF3qP27Q158oafvSnmQ0W2xP9ONV6CZtSSzbZafSESo1PKPWa4jS+P7lR8Fbe1
         /3JPTJzjcItdw6sTKO4Et5U/MADrZ0yBJtZWiA7olrX9Zxa0jd79qArHSJFqHS/6YVvT
         KAdFqz/5XwbH9rXCeZIHf/DyIt9YV2cDK/qUgkZ3y4OlF0WIzFWpiACPadmjhub3H8pG
         l3sxq3BQbMc3IUwF28lbzuNvUmZs2BGEwcgH8V4H0HNp7MwbYAlbw4SHQ72Og26dzDU3
         7Se07p7KFE9ltQpqIhijO4VvtKHfSKOGnmjKqnVm2N4wCBd5xRGoePw0sQe/N3ywBl11
         A9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962802; x=1742567602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gqYv2Yv6I6A8Xg36oF3GXiMSJjKsROFpNr6KE/A4Xs=;
        b=Q5f5qPQw3yFHzibA98QcANBKgjWaT4sKhbkYbAYBms9kw5Rl8TQs6sNqZ0AhM4Prxy
         pBajM/q145g6wL4g9UT98DA9etWfBnwkoBHwNow9Ym3GEul/cJXe+8vSPeBea5mYEAw1
         wlGrBMGhnLz3v6AuYrR95ZCEC3q/sJdu5cn6cD+OymD7bsIHr4ofpqB/MS/2OnG3pqRW
         D9BczIvof5e/JPRXwfXM5/ReUD36GhUfrK1b+9hDrVz1vyu/hdax6Vce+RPxMEQ26otU
         mEoMFIVLz7HPMHvmRgaCwTHxt1zAvi3g7U1sOMgDO+ioxKbpZQDAgvhoM+7lcoOOq7/0
         0TiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1RJnB/9FRb7qZqq8yMLr4bctK/0K2ZYBjOBtEBUaUD8em2CZ+Ris/5ZqQiRtzgmuiBcR59Q48uhH4+B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPevceIznWQvJTTAS40X/nCRKHG20rDd79GIfuuQyBZIIuXOoa
	ZZcMqRVkncqmBH2ILFYajtx4O6HapeYNrbUki6VinrUWSu6sTFXpDAbb8ejwWmw=
X-Gm-Gg: ASbGnctr1WI4bhhVU8oRT/7O+MyZrv6+Sr2vrXduCA+zwK6AAJWpfRhvclIzrnT4Hz/
	81jsXcxjnylNWaCofoN1UYpdopruexR9VGVzjb+ouy1hebijv3frGTchr8HS4KWGXNl/g8+n0Uw
	UQv4torwJsjaqpKb5JF2JbqMcOqg7+UpXxqvNxZxU1S7Xz6K57J2I+ZxCC7o/5IsRfNSM5qxo8S
	nKZ6+oGfSa+BXFmI0AkMLcJg0tGm+XyqTwcouBnNm1xSTpKNxzUFBQVedFqc3fKc111R3BlycgA
	ep/tXXQ4LWY1VChsn4AyK9vbqgfwR+frDFk6jFC7idlpadCtYgF/tH9CUWD+InkbUMDdUg==
X-Google-Smtp-Source: AGHT+IFo3GTKnNz6sDnWrSOXevuP49Y8TVcCWPh2ADI6rNCwCYfYVfD/saldxqETFwjSljt8qsUnFQ==
X-Received: by 2002:a5d:6da7:0:b0:391:487f:27e4 with SMTP id ffacd0b85a97d-3971ded0dd2mr3465432f8f.27.1741962802213;
        Fri, 14 Mar 2025 07:33:22 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm5699168f8f.25.2025.03.14.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:33:21 -0700 (PDT)
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
Subject: [PATCH v4 0/5] ASoC: q6apm: fix under runs and fragment sizes
Date: Fri, 14 Mar 2025 14:32:15 +0000
Message-Id: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
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

 sound/soc/qcom/qdsp6/q6apm-dai.c | 61 +++++++++++++++++---------------
 sound/soc/qcom/qdsp6/q6apm.c     | 18 +++++++++-
 sound/soc/qcom/qdsp6/q6apm.h     |  3 ++
 3 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.39.2


