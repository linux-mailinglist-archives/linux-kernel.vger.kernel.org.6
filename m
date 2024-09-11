Return-Path: <linux-kernel+bounces-324539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E849974DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABCE287086
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA15184523;
	Wed, 11 Sep 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fEnJWyf8"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3F183CA6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045636; cv=none; b=fhJkYhNK8Ps8nHd9iMMJDemn6SKd/aUpbWwsPn4CsTfGWyc8ga9hTyvJNooyYSeEZTGxIR446ZkXbc1JdbHruCgVsXqY51DoIFCqP/enwPVJSdTj8jQr6pBxucxvS4Uz+3/D4hz4OxJyTgB3L4chGHCTb3KXg1OCqZJoGDcAIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045636; c=relaxed/simple;
	bh=esOhHdSW3GYG4bDgOTaZ8aIxvJkfujR+IQ+ftKEU+as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPmACfyZ4VXtQoiCB2JN6bbHbucAV9gsXSMvP7XqPxRLWWy3f412/zikjmJUMGgkNIpNNY+rDsFFNk++dBImL5JEGlTOYfYSY3vVjhSeS1Wtqu5umq9E027VwSklhnNyihkalMXcK2H3uVUTH7I7jUi8NdVVDgxvzy5He3dt5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fEnJWyf8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374ca65cafdso4100027f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726045633; x=1726650433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05zG+KaVF69ctZg0Bv54vLcj+DDRJ4oFWnu1GNWBi1k=;
        b=fEnJWyf8y1zc96DGnM0UomUa7rAHfrmGWiUUpRjmjc4mpHWb3Q6XTM7twSORpnyZ7N
         KS3nBIECE39z7du6wqpUrgrdypkT7qaFMNLrS36gnrYNtfwhWPeUS6Mll+31gTCx/ZoI
         t6zSFq9eycb/Wm/kfTK8reterixPy3Htvj5RbwurcievshFnM6YMro8rYewWMoCwghHv
         VzLjxBBlOW2dFqeEP5Z2teS2ybbi/sFWubXEXfZr2hWY+419eNZ6K4Ej9lxoOrGbzlg5
         oXpQYIIQDWjTpeq1FL/plhRFwmJ3LmAnWLwb6uCjwqOBkducSkC2lTrvEhjFzTZTZ8rj
         osoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045633; x=1726650433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05zG+KaVF69ctZg0Bv54vLcj+DDRJ4oFWnu1GNWBi1k=;
        b=P+KW3qrq8K8G8ctgXRBaTg8Kh1T1fKOaVp77h6jZvTEbJurw2fHPFbjIKqgYVC3qGF
         nrAV03ScIp1rsBPP8szNWEWNrBO2ycWkOsmCAPBuVunNKOlNyrcoaSZEF+92YLh+VVYK
         w5dZ8pJaJ9r9EPAiIjvWQw25enSX2xLNJwAAZKMTLASs0iKYhvoCp+JimK1BpKoAbj51
         Rgii6/0xWB8GCc1X3rQ5OZsR25yDdZ7FQiOB8Qx4mwYKjelhfZ6Pnt0lr4abSDXGMXHo
         eSV1nZM3JDSO5Ya1Oj6CxyRq4+RFpdadxjcafP1hRQjjubAG6gqxqmD65HP1G0FZga6X
         gpGA==
X-Forwarded-Encrypted: i=1; AJvYcCUXZFQ4DUIk06ZoY0ai8hZAr22Y0TCNPtUi8gkYRQslaOERDeH7K+l+VSwWDhSrorETuiZWm3F4HfYgeT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmbWC3x2KuQ60x0fMUOavKWutWHuuJVO0QHal6xuCw4IHWaCE
	pxTUMLYK7mscPUb4f+ypACoMWcua/2hn8B4fDZYoCMMNo/wBgELuOllgmtmDN3s=
X-Google-Smtp-Source: AGHT+IF+Y80/Fy9Xw33GsPPPORhNGEe/YCmSlFhWcJOkn1iXNoQasv82Gka4D9L4IpozUSlX+6lRCA==
X-Received: by 2002:a5d:4584:0:b0:374:c95e:1636 with SMTP id ffacd0b85a97d-378949f7c06mr8453359f8f.21.1726045633317;
        Wed, 11 Sep 2024 02:07:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5389:6cf0:60c4:3842])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649b88sm11029201f8f.6.2024.09.11.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:07:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Sep 2024 11:07:03 +0200
Subject: [PATCH v2 1/2] firmware: qcom: scm: fix a NULL-pointer dereference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-tzmem-null-ptr-v2-1-7c61b1a1b463@linaro.org>
References: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org>
In-Reply-To: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=mGZy4q/oW8UzoOdspQ2PE/4+hSe74fQuun548/q4F44=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm4V28JZ/VEfTnaD7nNBoB3frcKuGLB9ARP4bWY
 bWaYUI16HGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZuFdvAAKCRARpy6gFHHX
 cpWmD/4mJG0x9Wtf91kBXu54OS8ukIUVtB3Olonnh6WlFUS6GbattKh4M/Zgmi0rn2SiTCLHUPu
 /hijbeXzEVURratLEVqcPpCEOIvVr4g8oR0LYpbvIURqHhPrpBt8de9PQ6y2WoD6NpeN0eED/vP
 L3RK3UH2yddZJA7yikXmiT7lovvM0/N7TZppP8bBXqq+oxV23yaB9QyKFfYmctDa7FZQkI8CGpt
 IMitrLQz4TFn00+pmx2/07vIkQu0wL2+6026OxHDTAriQx+SLkKSDjaEA6G+SADjQrwjNylUrez
 LowDn4rV3FAPfqAzAw2Rwgfpu8tHGPkHRjw6+TWIuaA/qFNMdEuIg8aIntBqz7VDFouw3NN+7l+
 1sdY9T5ajf6sgUTPm8mm9sFDyKFjMT9s/MgtijCj0+5D4KxaBSsT/kFN/wXKaflvT9Itb++Jz1W
 nO710wrpUQknR8xNg9fjpz/RhBc5cjgcK0w1TNxlMGLFT8oQHySz7H5OUyMzkCQR1TLY1IiCD+o
 m4U5b7aQSE4Gqr8httoq9f7zit3nit/xVS8Znvq+6YgCr0bTLkd9Ze8qGsEYj0+HG0+2obs8JBb
 MkGME+1TTmQirZSG3DsjLUyCxAfOLbHbOE0Oficm1h9sDeZ6zx/sBO+y1ElwJtprqYWZ6RAFdLZ
 wVAxtssmyqJmj5Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some SCM calls can be invoked with __scm being NULL (the driver may not
have been and will not be probed as there's no SCM entry in device-tree).
Make sure we don't dereference a NULL pointer.

Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
Reported-by: Rudraksha Gupta <guptarud@gmail.com>
Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Tested-by: Rudraksha Gupta <guptarud@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 10986cb11ec0..8bac4915c211 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -216,7 +216,7 @@ static DEFINE_SPINLOCK(scm_query_lock);
 
 struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void)
 {
-	return __scm->mempool;
+	return __scm ? __scm->mempool : NULL;
 }
 
 static enum qcom_scm_convention __get_convention(void)

-- 
2.43.0


