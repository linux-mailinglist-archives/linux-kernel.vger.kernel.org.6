Return-Path: <linux-kernel+bounces-321958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAF9721FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985AE1C2340F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA820189907;
	Mon,  9 Sep 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CJBwD3kc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09018952A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907158; cv=none; b=YMp6cnfuMhq5X12DPi0VFCEclrozDQjx/xREc+xbN+RqUbC7QF/0Wo9kWApHBU/cD0sIlsFrE58FQDNErjot06wFMUsWOQIDlxhRFBerGTFbjZszxWRNv2IOpzPPp4AZQwjxFB8Tm6gyBcGEjZdrtL3RNqJNCtLkOizjhyiJiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907158; c=relaxed/simple;
	bh=0qUNxtCzBlaQFlOv8wC73ChSYORwWKyGNipsDUBQlDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfirCbtiyRuekbjRAfwLua5OCcDvOxzuFPf3Ci3p/sEva+bHBL8XVSRzggiS+l7cndRu0EmtN0Yek7u8FCVtVH8clLzpnrxF1RgjFVe28sQhxwVdqdNDUTcKyOUSDhYP5oizYcBs/wQRm6nkTpZOfHIiOh7Q7yda2IM9Euhsn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CJBwD3kc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c5bab490so3552005f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725907155; x=1726511955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68xIa0qDpH4oP2z5JZVL9mh4D3pN/G6kx+ceoOgqquI=;
        b=CJBwD3kcK4N4TQ50eiy3KSkeWMcadAhBaAsSLR1tysUgQSVTnc4Z+uzsws9VL0j7Y0
         EYxauYA9u3qzwQjkVgqhMMSb0LMuKGap6rI35zip71ht/8qPJYXtwyFHxAi7L+1sjy9W
         su9/MbXxvqykQ6Y5BvwI2p0Fxlg9i5UIe+bJin7kQKKnyztpgm3M3OphI9Vyf32ReqLI
         Vs2WjnMnth0DG0Jq1FtQnUR2E2pHNZYt6iAPyZIWa4qP/OdKeIjj3oXLvJ9Hmm6BkVXU
         63zkVPF3KNYSMVLxssyr2UTERJ1RRS3neqtrg61RdB5XgGGbpqeovGip67eLuvg6RnSj
         JRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725907155; x=1726511955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68xIa0qDpH4oP2z5JZVL9mh4D3pN/G6kx+ceoOgqquI=;
        b=N/VJHPFBJWE8eya3aCa2HXOqUOxAnfzck7+nHquMuI14aEuTMAw2mXsl8BmVlH/4Q9
         kYYzrSItDWlg/YmuW/ov2cJVosg6lm5FClu0yj18BOUXJ7TNgIoqv8XmfPTkMI58pcbk
         Csp/NL21KCRyuIdI2qdDD7gGDhZwcmfNVYoR5cLw4PDYkJtehpk0CYSUH4FKKJGJdSgG
         e/ZW/qIRUVbld/odAKm6FvFzxHYTu3Q/ka+itdhR+Y9JZuOFlq7f8aMkeBIhNXhQTR7G
         ozXWsIy3qBubRCq4Q4or0/FNngUEWPIcyXufeCs25U2jAFlXm63IqiQ/LWnNBjuT+Fxe
         HmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxW+4sbp3w9U7T2gG7LFPBUsqL+M5tdH8fdGiFBk88/RW6D2Yen0pRJ70OVX3ovANtywkKZ9VSe0aGm4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIyWlebT+ILK62YDzVlnVUZZHqppMzubRh97tRCnWkqcSlLNy
	UXZGYMWoHfs0AUCPBtcn9Q/BCly/7LvJQH99JsIqqqlsrEV5LpcUm2CPnZVB7AE=
X-Google-Smtp-Source: AGHT+IE5jqNmt/6aHtknoFhxlFzamdBJRt3eKxTbcaC09W60hvq98OG7JbUdSuCh9TqgRh5Qq3Q+3Q==
X-Received: by 2002:adf:fb52:0:b0:367:938f:550 with SMTP id ffacd0b85a97d-378a8a83f57mr258816f8f.25.1725907154179;
        Mon, 09 Sep 2024 11:39:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c15:247b:9be3:37a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653b0sm6731721f8f.44.2024.09.09.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:39:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 09 Sep 2024 20:38:44 +0200
Subject: [PATCH 1/2] firmware: qcom: scm: fix a NULL-pointer dereference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-tzmem-null-ptr-v1-1-96526c421bac@linaro.org>
References: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
In-Reply-To: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=nqlfwh7HALHLiMEbK03I1bZApCMOX4885VESmbJrqBM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm30DQijY7xHCLYVNTEsRX3YdkjVFExUq1B803T
 jML4T6UFKiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZt9A0AAKCRARpy6gFHHX
 cpjDD/9YDlQ1lVYU2uLqRgkxsJkkNvrGIXhISuzPuSriq/JAlr4MhxGCjBVTJqGE5ji4NtM6xVq
 OdEB5JX/TIXG02EFTc0eu5scnLEW9QH1ktYU+wNCyaGMNVKHSGkTFIkMFL7t5FyXspWBSLrJlxu
 vgrdOf8wAtfoSTLbpv/0kIUr64XAxiGRLSZ8b5Ed0f0h8mytvuK8XSUm4DeHsy1FRn8I/5RwN19
 IR737PPdqFIjRi+mMYTwNgX9uW5LzV3ziLr80+U1ZIHLx1/vhROU6pBXNoDoATp3lVFuc27WRe/
 yKcYMT7IVwzOjY0xmDkBCF2qOOX1kDTJbkJSB8N/4bdSpj8JV/a2RzTPb9FjNJq2mBCQYAZ3QvB
 QSqEf1KJHFDPKInzI+MxGyPLyfTbVKYFHvJBHJ4zi9EvtnTRO10TYhTa3L6Jwx+D9qYiPIXfbhq
 Zhmjxh4dlJE6dJ6Y7WatuaKw1lVE1GemtZSMcvBlTvc6vh3pc46qhR+bkjaLKwUvaTe850dwPX0
 ZX5uixIbHp/BwRqfHGJ+tYDPOn9PQWD3lIISXSV4BEM42EBYMi00HzE612cO+C1ZLLz3+YtL78+
 dw+soHsU+agOKFogXQ+6fi8R7S1jivc1b6YYwNE1HEXXm2CczoUGGnCM9IsBmGri3CS64qCyIMb
 4sbK7EuZvkOq8Rw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some SCM calls can be invoked with __scm being NULL (the driver may not
have been and will not be probed as there's no SCM entry in device-tree).
Make sure we don't dereference a NULL pointer.

Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
Reported-by: Rudraksha Gupta <guptarud@gmail.com>
Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/
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


