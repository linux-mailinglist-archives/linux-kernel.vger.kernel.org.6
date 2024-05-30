Return-Path: <linux-kernel+bounces-195968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4D8D5569
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014981C23502
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA117181B91;
	Thu, 30 May 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euV1sczQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAA84E04
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108261; cv=none; b=hMMgJqqZqBxpeOkqoqUIq4vCf3El+n25HqYZkEi0eDpyr975Mp3NPWMzPYRnYpX6AqYphoal8L9yYrQW8nY5fCxw/px6eMdajtIpBKg8Y5LgMf6e5NDyp9Mh21j6R1laIv+rLspGaNQnANEJ2CaaBfBAyQDjln1xzMo163rPhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108261; c=relaxed/simple;
	bh=Vmc9pn0t8SHEFwwZusIt/Z5iY8NxjVNNbXrLDLzxEMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pJZ1JdnVSjJmUca41gvd57znqoeq+brRXDs/JeAhGuM0nMNvt22iOGlK78kcomBeqwCcQSt2KKh9GZtqT7m1JSdwhQS6kT120kxHYXmHEy18PQa1a72w1D3JM5M0qZY68beq/+IiF7veTiEe2EUpH9Gh43dQz0C2nRPyw1JJj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euV1sczQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b86cfcbcaso447512e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717108256; x=1717713056; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMW/bINKVwWreJG5Uda77hVx5iRhNpQJXY1J+m7Ti0E=;
        b=euV1sczQpJ/Kw278PvC6hpGwp2qdscSzLXXQRIL/PsvwFAwOFCBhYa8Dx3k+/+U42Z
         pHQRHY4b0ZP+hh6lGHIHcxHYNXjHPpa8JVlPvsNG0Fjt3YX6qkV78UxwrYVAHnBXH1lH
         JjHp97pBtUvAZGVgCofEORD2vvqatgqtXFeI/5dLvNXddFQLyFUsWGz0nx69ipxJUuIp
         DGo8sLOkjpqiEH5VxXbMs5zDJmiLoNLLzfwoy8V8c+ypmZL6QHxVFVD+p/jQwwyOCARj
         f+hZOpmHpO5dDRyGXNdtecpbZbXYjuuq6LsyZsmhx5X25xtexlM9URemMrMXX6li8Tij
         f/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108256; x=1717713056;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMW/bINKVwWreJG5Uda77hVx5iRhNpQJXY1J+m7Ti0E=;
        b=CVpRjg8tPN7XFtvo1FxxQi9DDr7Db55MstYfGNRS7YBAvPSilSlaToUEf1WHlxoQ17
         edcHn4ifPxGJphpRyhq2dG3C6Y7U/9IcNncNqb+ONEJ3e7SJattA2sg/nNWYmlWtAusF
         HnAZVz/JTArmozaud7itObMssLAyGq6otx0/ghuE9OeD8cBsPMUjSqNrXriSrLGgBtM4
         U4Ird4G3i+jOqCQt5JTdvoIt52XHEYRJ3ZlPE9pJYnbztdyTepvb3whK9qs0AgbZp8nU
         EH7Y5UsMPLghdy/L/90icP5/9rhFNJckxfGHyDsuOlBnhD18gfrt0Q7ltDlvPIywW6I1
         XSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsE4rN3xqnobXFhsGBjUyAaSaFgGJOPHkIHZ71lqwg8zO43+bERSr5EUwECFAlWCF5I7feOOqNTLdsdKIHMGViD5KDAjGEoOud3kmd
X-Gm-Message-State: AOJu0YxcpysW/i0gvNTTPQQCt8Z38+Y2N0O1SixBtKCPzQn2CZ2o0o79
	MvTjsFe4njbxu9sapQLBn6UQ6vbbHyiHYkbjnvK1est75rkgjhJXYJgzA1mKWsrVARgRzzZABc/
	+
X-Google-Smtp-Source: AGHT+IEoN2o4Y46zxy4lS2UJh/JfIw1oILePCDHn/50LSD5Q9DvV6GbL0jWEDOCKY16zfYeOfeZuQw==
X-Received: by 2002:ac2:5f87:0:b0:51f:4d57:6812 with SMTP id 2adb3069b0e04-52b8954e90amr19914e87.19.1717108255905;
        Thu, 30 May 2024 15:30:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7ff1csm110917e87.209.2024.05.30.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:30:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 May 2024 01:30:54 +0300
Subject: [PATCH] MAINTAINERS: copy linux-arm-msm for sound/qcom changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-asoc-qcom-cc-lamsm-v1-1-f026ad618496@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB3+WGYC/x3MQQqEMAxA0atI1gZaHaF6FXFR0zgTsFYbEEG8u
 2WWb/H/DcpZWGGobsh8ikraCmxdAf389mWUUAyNaT6may16TYQHpYhEuPqoEWd2hm2/OAoOSrh
 nXuT6T8fpeV5KY2Q1ZAAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Vmc9pn0t8SHEFwwZusIt/Z5iY8NxjVNNbXrLDLzxEMc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWP4ez9KNp14N2H14dXAiyVl9QQoE8Qi0T5OPg
 gRwxOIB0v6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlj+HgAKCRCLPIo+Aiko
 1QR5B/9/j6tbi+R4HIX72dF5SfTYv399dMI0W+bS2+ea8GoJJ3MGdLgS40aoOfInh06qyy+lHU4
 N3y0OoAaSBhkpfDuHzrN3yAEzm83/TyK11il5FjTsNyrQyJtJjmoxqNHEndfOiXTiyNs+TLff5t
 tSg2wGb2wXsB5MakpyTfsSDt8IvoRScapqx/N7HyV3Qgl8gxVr7IZHc4oWY95t8NZAIJob1vw7h
 URGIF1+dqV0gN5z4qqQrgChhI1xPH/WGlPw0ZKS2x3G5QGcpzPFVoI/bmqY29+cmxX/RE1eGISq
 CU/yY0DG9j7gG7T+LRBVPcVFExOk+ZkJlx3LHppZ9JVwliR2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Not having linux-arm-msm@ in cc for audio-related changes for Qualcomm
platforms means that interested parties can easily miss the patches. Add
corresponding L: entry so that linux-arm-msm ML gets CC'ed for audio
patches too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 523d84b2d613..b9bdd1f08005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18227,6 +18227,7 @@ QCOM AUDIO (ASoC) DRIVERS
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-arm-msm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr*
 F:	Documentation/devicetree/bindings/sound/qcom,*

---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240531-asoc-qcom-cc-lamsm-be80e19f8cd8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


