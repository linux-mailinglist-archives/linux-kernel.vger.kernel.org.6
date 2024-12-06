Return-Path: <linux-kernel+bounces-435029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51879E6E96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FAA282748
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988C206F2E;
	Fri,  6 Dec 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uB+CD3kU"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563C2066C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489557; cv=none; b=T2I9D8f6WeMMvJ68O/F5NnsO6CmDE7e/1VDmd11n4W1WdBhnJNGJkMWhik3d5zej1fU6goMkgu8RN1H6ap49QOR9kC7NaYiIB53qBcf9AG3O0spY2I2N1aITe5LUqSY55pP2ItNKb1UD3lrgFshXpYSZwDyQhb7NnPamsV8Pkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489557; c=relaxed/simple;
	bh=f+27fzhEEViDzKM3BdD9NsjlQj3nr6zdqL/DbQ0dhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gWpbTc86KikwzoWhC4KUKn29XNl6TG9pce5fgMFgMKRzUvfcRfn/HWVX9I+1QaGcnS9qIOIpgefEnh99Lk7WdDd56MAskj1e+mQnVBv+4/NWUhshOJOPcBk8wsTnwUDVB8EBiE6bc0In6ME2+KV2dHmMnnJ80k8Ilm4B2viWk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uB+CD3kU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862b364538so425117f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733489553; x=1734094353; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrDABpUIa8XNiUd2yRie5JLoWvXscChzPwT5Xcajj3I=;
        b=uB+CD3kULrEBu9yaY++G1hkEM/iCyLHs4FFa+5H7UgK7p3Oh0iYfpLu1YpJ955ezoU
         yhP+J7czsqhRrvVeQXCTWqGcIkDAwsLxlxRbO9aG78n1+3aZrpSaLwF3wcOQ40pDsgSi
         MokuefxG8BIhh40ot0xnpySjf/wcJnGX3s/CF/3RwYuPMccOsTUe5UpOSMpkRt7hIYD3
         fB5cd+zsQEo3qsUKw71QAviVZHTonFQWhLhnKnFKP1nTX9sB7hjrjFEzsJ2q1Rny/SKw
         PdXuU3LGRIasKCb8czjez4dzitkJvpdRR7Qk1DED92MwSvMvS8jK1YNcFn0nbMkLktuR
         XyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733489553; x=1734094353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrDABpUIa8XNiUd2yRie5JLoWvXscChzPwT5Xcajj3I=;
        b=RCzFlBy4ma2pc+HkBDtmqY8OAnsrqeNDVVHa+ANb8ql7pQIg6EEWWyvRsjaTtImHtb
         PdsFj09vSoZemMrgRlcK8msrKty56iGpFpagHRCIubs17rnimBDIeEv6hq1dhfjmmigX
         13/TWA9n6LAcnxVFVnT8xVLvMp3uMnqHdmeT1zCpfm3FarxBooGCmJPjo4Idss82mUDW
         RcT2DKauJ2nuoF+nG4SMoDenfv2jk8fNN0KPiamlYE/36sBO97Hl9dX/v3C334yTCVDx
         o6KtP4mfdfUZGfnh7PwuZmT35qLqONlbAq8HI6npZ+OGYfJgh+0fqmutyyyy3Bx6Uo2b
         Yk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6ikThgKyN+IKPjb+IUq0O3aZlPbEag+JUDr1LGeQPYtHICd3kK9EkX3aYEzOxzYd37aATZvbc9GRUSj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AxtSjdae4+dHURWIWVy0DXqCCQxw6rC5539Gs8niQHsXvRS7
	OTaUOblkBV+H93afziEZG/Rrw6ox8XALlFWwqa0/hl4Jn2eTgG6Rt5/Tssa++bg=
X-Gm-Gg: ASbGnct4VbErUDsNYKEVA/2n2KJbrbOp4uqVoAtXN18gMYls4BrTioTdBPBvt/GyQyR
	DWxpUWKJMZ8ysUwcP9cm096iePCBvpLpTb0qG7WWoKnNSx3CgMVq0GuIEeD/DAuim9qfuC5HGj1
	ogjrqyIev85IoC1i4pmroPnwURwHescKcVpAxWK0xLE4J7NsM4qqNbKy7kK1NNlKhXSqZGfZFso
	M8ZVyxzE+BCbPu8vl6E3d8+EftJupPJM5CqQ2cf2i+COqhRrFKqcfI=
X-Google-Smtp-Source: AGHT+IHm8JzdfN+FTAHMT8Z6wMEGsSN1pUfe5dL+iyuyKffu7U5Grq3ElPDgSbj9GKe3ItmO5v0RPw==
X-Received: by 2002:a5d:588a:0:b0:385:f9ed:1637 with SMTP id ffacd0b85a97d-3861bf98719mr4466825f8f.28.1733489553444;
        Fri, 06 Dec 2024 04:52:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da1134b9sm55104575e9.33.2024.12.06.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:52:32 -0800 (PST)
Date: Fri, 6 Dec 2024 15:52:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sriram R <quic_srirrama@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: ath12k: Off by one in
 ath12k_wmi_process_csa_switch_count_event()
Message-ID: <755becb1-819b-484d-8fac-9a2db53ced1b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ahvif->vif->link_conf[] array has IEEE80211_MLD_MAX_NUM_LINKS elements
so this should be >= instead of > to avoid an out of bounds access.

Fixes: 3952657848c0 ("wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 402ae477da61..46c5027e4f1c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6873,7 +6873,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 		}
 		ahvif = arvif->ahvif;
 
-		if (arvif->link_id > IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (arvif->link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
 			ath12k_warn(ab, "Invalid CSA switch count even link id: %d\n",
 				    arvif->link_id);
 			continue;
-- 
2.45.2


