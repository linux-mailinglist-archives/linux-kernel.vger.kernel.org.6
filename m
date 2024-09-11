Return-Path: <linux-kernel+bounces-324541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFC974DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E7E1C21D40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D616DEA7;
	Wed, 11 Sep 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c4UMVTIK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED7183CAB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045638; cv=none; b=s32RF8v5UYBzNAsbKaLfKWkXJWTIoVFuB9wD8NLSTHAA7WdSsKIPL18RlZUnT2XzskLivv3xb19pXXrvHGXjOWmxUnwRDFVeRnd7Bz1bySHHiPobqRTsnClX1LuD5wDuaxJaOxNDqgpBs9wqm+jT0yk1/OG353W4deDsveFXVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045638; c=relaxed/simple;
	bh=R6yW4YG4S3q4OJYcPBRVoJ8e7yojYNz0eg+ErHZJRC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=agXj86rzQFdDXWHWk/aSuHF0KcFr59t09Hhvz8mnPIbdqkUUS0XaTTaYBhdX95OQeeNVzmsK+RycjyRUPBEs7Z1BfgrDkL4MgYWx/p1NQofg7b7YQqzugXrBEHnEvejNPCHUxmMpJP0zt8jLlcnp4UMUYvr4sOJJidkASyZWQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c4UMVTIK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cba8340beso3741475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726045633; x=1726650433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuHe3oR0rUVRewpF2jcmqfhf5y3otrAzlSWC7VenP28=;
        b=c4UMVTIKHGDI7Ob3xP45NbHryFs7oE3ZzazaqVijoWizFVmapL6rY0DG03d2isX7k2
         iNpq7eMgFVpLXyeJ64kOF6kZ0dTfoTpnxt/eItERpLzopRcGTUc5uUYB+zT15zRCBABc
         x3fdrxX3f7HuNYX1mATUkjQpOwbzY42yo4OvgU2EucebV2WISXh04TQKASxGsjtS/72X
         tqHqknJu6wF/BTYYBDXa+tTUngGHYB38YjSvb2aUdEKBBKYgm8QFOTQc+mpqWFCOuwiw
         qn1l7jb2DD55t+JVaAOmmyTS3tZzB20FYC+FZWFiyYrAF/fAnTRgKtt7iUynM9pGqvxL
         UvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045633; x=1726650433;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuHe3oR0rUVRewpF2jcmqfhf5y3otrAzlSWC7VenP28=;
        b=g70dto06C/oHZ3O6Ly3nxoC0cKqpVYVAeXt9/gBXDGG3mZs8VMJODkPegkE7ci4QMU
         u9SG6z8RAZ0z8BZ0obExq0reTNZb0nyKDYor99LPMgj/HIICXa7yDrcDeQ1qdQ3s3vX7
         +h6vDggYWEHmACBXX4n1/phpYbid9580neJfHAtNo2GEYgbTNwIJpVgWxzuKH7gmlzxa
         akX6dVnet7wZMW/bLADJ6Mx75/x0m1W2MrXYk+FkMLoUpa46JJq9ULvhwHqzTEcH8y92
         qJBhhYjuBBbnhMUpzZ/DvYRnbuEq1A4vbLAuDEhLd6l+LuEIZma1SStF8BPWgnFB0B/a
         YxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWcqebwKEv3nh2tGA130nwSgNAs1sK8wk2CU9UnlrMSmMMEssRCVluYc/eobbQXmMTCEFfRyMjobjrmfco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPPWWRkPNdIWgEJRua6S6xQqwVOwp59KXOtLWqnna24C3rgir
	2Ge52fWHGr5wOXZICBXIPyncep4BiI9NaIb6P29dE0wpTNMaKSnULfisgY9Tw+U=
X-Google-Smtp-Source: AGHT+IFo3nZoyglrUhHP5B/FuNucZTRJAzUFbDxrsYwdM2YrVLpuTW6C7iC19WoncuRUHg8J8BiCVg==
X-Received: by 2002:adf:e448:0:b0:374:c878:21f7 with SMTP id ffacd0b85a97d-378a8a11f62mr3379279f8f.10.1726045632321;
        Wed, 11 Sep 2024 02:07:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5389:6cf0:60c4:3842])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649b88sm11029201f8f.6.2024.09.11.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:07:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] firmware: qcom: scm: fix SMC calls on ARM32
Date: Wed, 11 Sep 2024 11:07:02 +0200
Message-Id: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZd4WYC/3XMQQ6CMBCF4auQWTumNEioK+9BWNS2wiSlJVMkK
 undrexd/i953w7JMbkE12oHdhsliqGEPFVgJh1Gh2RLgxSyEUooXD+zmzE8vcdlZZRaWWtV1ym
 toZwWdg96HWA/lJ4orZHfh7/Vv/UvtdUoULUX2ZpG1ndtbp6C5niOPMKQc/4CwzFUM60AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=R6yW4YG4S3q4OJYcPBRVoJ8e7yojYNz0eg+ErHZJRC0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm4V25OyTpUg4qkhRCNpLn9JC7f1tabUg+CLBYp
 AJ6Jwsp3iKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZuFduQAKCRARpy6gFHHX
 cpUGD/wMK6Ye3KuuWkDSFK6GTJf+SwM1cIRBfYNBSjqfECtIQnhg17Ccc30OWpDR0qyhljpGGxH
 XeWdGQzIkkarl8rcjrW9Hokp5PxBvHTS+dmyqY5a1JuJ8dhmOgkwoaSodovlg7jsl05Ka5HQNjE
 VN0t4Df6J8hRf5gv2Kvpnjf81qpACoAvrtq+I3JZpohZFSrM4n8E2+LRaVp47Wcmmv1cKAwOyt5
 6xH/O0wcWXiaaogHRI/ouqsMD+fxmJyKn/Q91JCFbN8trNi2a+ktU3fcSVOlIA1upAb2zSmGQeU
 QpG95zRLXOtMEyjUozoPbAFCI+8xxmpgAU0OBoZxRs1EyAE4gPGkzg/JMWZMJ5Q0kshoD8HetGu
 777jIxRrvDPRWLoN7I8urtEft+9o38XjhtCXehSqPyRgaPTxYw0yxht0zHunjXOzihZcWppSIe7
 mUVyfCpeCFYBRihOnkdnPWQcu+EezI2WYKlCzVdSvijbABtMSRKyHl5EyfSYUQ+PDn+6hji9S8y
 nM9BerG7h6PoJkeJMr+oxNtVPJk7SOc2ngGZcXkNW0k1vW5RM4v6P1AAIL8YsSwrQxsjFPruFkZ
 0Tb7cCBL4Dw/Lx09fqOBDLDQzt0GjNY24DBOwEqCuMNKDAl+Go9c/Rp9IKKEr21kyObUYnzBQiJ
 vGOdGBS+gx8MRVg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The new TZ Mem allocator assumes the SCM driver is always probed which
apparently isn't the case on older platforms. Add a proper workaround.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- use likely() for the more likely branch in smc_args_free()
- Link to v1: https://lore.kernel.org/r/20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org

---
Bartosz Golaszewski (2):
      firmware: qcom: scm: fix a NULL-pointer dereference
      firmware: qcom: scm: fall back to kcalloc() for no SCM device bound

 drivers/firmware/qcom/qcom_scm-smc.c | 28 ++++++++++++++++++++++++----
 drivers/firmware/qcom/qcom_scm.c     |  2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
change-id: 20240909-tzmem-null-ptr-2a9ddd9889aa

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


