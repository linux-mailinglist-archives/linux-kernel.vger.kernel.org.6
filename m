Return-Path: <linux-kernel+bounces-268721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB86942850
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61A51F2261C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04618C91E;
	Wed, 31 Jul 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="weMhtW1/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211E1A76D6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411916; cv=none; b=Da1HP9aOSyyH6TZVV14K9qRCQmkOxRqJcMZU6RlEXEHQFlGUohdhCuqzhP589qnNUwZ0DSixLWqp6jKn/M4COlwlzon0vX21sTZWjy4RuR6aycPIaaWL+BoYERiC/mE5qjX+8dw5u52oEOrgjdOjOBDuTeB+KkwZN3PN8TY6lgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411916; c=relaxed/simple;
	bh=/yuGnClbBC1nyLwZVAYr+cginh8pqpSnbTlYXoo7Mig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u4SajgJO8n4mtCP6yJWFBGD67w05SeB3bWIqPfzEnGm2DTAlwN6BBttQz5yiTZr6OpIo5F3llv8Pn3jSPsaHteIP0GELHY777MBcoq67erk4pwP52TCsFmxdNXMv1i/l3SZbW/JH0U8OADrQOP02scokTNcAikqR11e0OK4oWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=weMhtW1/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso32372185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722411913; x=1723016713; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rqz+Epw25ZtWfd9xQ4ZQ2o9n8Tqu4oJntDWi/cHmjog=;
        b=weMhtW1/yDNlvEtlXGSf1UHvXOf0KUEf2q6fxl8xdoS5B8twISMQP6fYHu2Co9o54H
         8UrTG4Hf67tlthDceATB88B9eoYKJdni9GBgLU5r4EeoIX/w4wfjedW2oV3MRIZNt18v
         WDI+ZQi00H2jmT+r0NdkF/58FDJ3xis83JuzrDRaO+OZyhTItqWo4KWDfq3C6nqYQg+q
         9o+1z9bitVtiz/DMHWb4U9034SG0ZkU4xnn9v6fNAOU0WxMEj6f+4BkrAtchQIjAWO/D
         KoegsIFJLBopO02rHTVtPCF5rqmia+vlwqOortQMghnoeqJaM4Q2vfjqJ18L/f0hOM1i
         /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411913; x=1723016713;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rqz+Epw25ZtWfd9xQ4ZQ2o9n8Tqu4oJntDWi/cHmjog=;
        b=vFyJhBFJZaaznJBgXntrsZd99oR5dNOrFmC+wn8WdQwSvOFhwbReTIMuoCfEiRYvQ9
         MW6qi/LS6Rxb8CS+/H04luNQ3rxcQvjfTjsZ/ymXS6yZxOWXLnRmB0XgogZDhlS8scbw
         Sjpy+/IPbTyHL92yll9nv/iiPrmLKOPsVqQ9sRYtOvVRfLJTFF8gflVv6gYlJJ7Pt8cQ
         X8WnIdEtWtJM222LJ0MN+YlFM9O3vKKxe0mfzvh7coFfOeQQxfvssdfG8Xi4Xf6+/xvj
         FWCd3BaaJB+FL3cKA7c2PfJsTlgskYGVCww9zq7NBJK3oFYmNrDsxdJ6UEFJ9Iy8PZcB
         vZpg==
X-Forwarded-Encrypted: i=1; AJvYcCXAlAx/Q6TmWman2qdbPPzfSHU/CxzntZGiaJC8poL7Kh3TArMqJwvaZtJHxb/jfR4VPyo0jToZNcD7aKz2fnvJNu0NheXV/syZNoxd
X-Gm-Message-State: AOJu0Yx/SnnRJ9WQHFWaRbzxqMhuspsy0na3hJzvpUz9UCvoWYC0CUhB
	IGW9gNwetHgXCWdaKuv9zawD6KJsoQK9kLSRhNJn24y0CVR5w97Pw94yb/YA/uw=
X-Google-Smtp-Source: AGHT+IERHg31L0LLzRskNikI5TpikbIFOdMzsFXQ3EMo+io8H+Z7u5PSmL/XZMA1omH/ifPmwPFVgg==
X-Received: by 2002:a05:600c:1c93:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-42811e0b6b7mr92539285e9.33.1722411912610;
        Wed, 31 Jul 2024 00:45:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm16283104f8f.85.2024.07.31.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:45:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] firmware: qcom: fix an efivars regression in
 qseecom
Date: Wed, 31 Jul 2024 09:44:55 +0200
Message-Id: <20240731-tzmem-efivars-fix-v2-0-f0e84071ec07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfrqWYC/32NQQ6CMBBFr0Jm7ZhSQIor72FYtNDCJELJlDQo4
 e5WDuDy/Z///g7BMtkA92wHtpEC+TmBvGTQjXoeLFKfGKSQpagLgetnshNaR1FzQEcb9s2tqPq
 i6YyTkHYLp3Y7nc828Uhh9fw+L2L+S//ZYo4CjamVUqXKhakeL5o1+6vnAdrjOL7f39v2swAAA
 A==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/yuGnClbBC1nyLwZVAYr+cginh8pqpSnbTlYXoo7Mig=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqeuEN8r1CHvvf0UpTfmTk9Q29pqH/8y5BETy6
 1WpaKQhS0yJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqnrhAAKCRARpy6gFHHX
 crKAEADSUPyL2tAF2AYiOzyPKZKJ2aLGJGgEC0qFWTDW1xdUZah/lG3ovfizdk9ymqfBxoWlcKs
 Sx8OMmGpYsw5gCl2l9z94/DXVB6R0AfgrOxjDgUXHyuJzl+J6GX1nW53ATxhtoO/vdzd9HhNOic
 oJbzNUtro2hatchUFwmiyIQidQxPjUOJlM/9Ktc04tOyR7u7zAzZ6WZJ7UhxIX5sUg6PObt3YDP
 Yi44tHqtjbLL1/UvPtyHJSP7qQKZyHwN4SqmbQYrBnd2Trv9fvJh7gtrJVhEM+aKJfbdL3G9B6z
 C0iVeM7AMLY10NMJil2vseahE9WupgZiLVUVp2/Q2Ot4Tw+Cg0LT4IKRQzMnui3e14EzEGTEFOS
 GBbIuaprxW+9CGDvxVC0E94yefHoEZLKrNEiLlzgv+tCoN7ebyeH0lDPnS6TFw0PpFC0J+BmzP4
 NNc/pB63/LPmqty7yps7BEp8NyOOa1DmmqzaqeYPU62Irvop6Yzv1Oj4qlR8SIj7ZSlF9Sc2aV/
 WvhuDJaqm5TQGvIapVD53gFhxPBbSgewqUYWXMTQ6t7/ZQLx3X7njK8RMM07TSKNkabWNTb76DT
 AtuGWhO5eH5BKS+ZbpYgyvj35OPjTzx2j+NTra1oLnL9lYgAEY/ykgQf9bwyeyQi5xxFxwOiQOM
 CKmc56lnINkVsZg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The first patch address the regression with efivars using the qseecom
driver reported by Johan Hovold. The second patch removed dead code that
was left over during the conversion of the qseecom driver to using
tzmeme.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Update the kerneldoc for qcom_tzmem_to_phys()
- Link to v1: https://lore.kernel.org/r/20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org

---
Bartosz Golaszewski (2):
      firmware: qcom: tzmem: fix virtual-to-physical address conversion
      firmware: qcom: qseecom: remove unused functions

 drivers/firmware/qcom/qcom_tzmem.c         | 32 +++++++++++++--------
 include/linux/firmware/qcom/qcom_qseecom.h | 45 ------------------------------
 2 files changed, 21 insertions(+), 56 deletions(-)
---
base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
change-id: 20240730-tzmem-efivars-fix-d9635d39cbf2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


