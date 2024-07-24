Return-Path: <linux-kernel+bounces-261480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129493B7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24841C23E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CE16F826;
	Wed, 24 Jul 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLXHRLuW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0D16CD36
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851948; cv=none; b=ilzb6huBRw1uM2SNI2YFDpG0dKx9+/sayD4g3TgtoTjRYz/LnF7LIjzxnb3xXCjsQgsDbyTtWLnAELiMhaVvOraEk2VjqEsfuB8MUMeU6gv0+6Kww9rdRlimV3RVRXD1ixHqyh3SaaBPPrD6k/4ql5YZCJlq7LVwd5HQ4Tjw0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851948; c=relaxed/simple;
	bh=ftKGBViUOgmYn6lD6rKdnKxeD3XcFNArhW8Gz6/ov7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UO+UfituS9Z/gP/LoOBw9oIzfWrDftlN8h3MR7xiyMSbH1sEEuQ//ldde4WtP06qWWxu6i1v+GKI6RE7Ppx3XJsTS6olw3e849VB2yWtOjkjf+irJsY+P7PWhoElxtcH5ut9LyhY7760AGgir4deAXfUCEuv2mnOCkSR/anqGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLXHRLuW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6506bfeaf64so4318447b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721851946; x=1722456746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9PT/6cjnR+Gnm6WIJzoVk3JaTZqlTM7UT6q82pMzX8=;
        b=YLXHRLuWDD0xy6ohmfotgN+90XuBk1tBb7fWP+wEPbP0/LwralxlcJxd62hBFFaSWX
         svuXaKhfVQogTbbKxk6YCLbAtEUKwXQSwnSfgsMUW0XJtR7hhbW1BnVIjMP7rErNd25J
         LCVq19pdRyrkXqNPE73bTiGPnutJ0+XJGp4fyLmKk3eaYs4ZDz5gA9WcHhLSdBydJmOR
         7ESiJx/OM6ePVqu36PO6rtWw+EV3/ZLReBsb09yWpet+98jqyKWrkn2oguTOntV97Yhe
         Zw96oJ9Ev2tVzpt/JLJTUE2eC+1DF1W5e2IslWtdWnXAirckIwPe6BDIJiEUhPoueOGT
         z9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851946; x=1722456746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9PT/6cjnR+Gnm6WIJzoVk3JaTZqlTM7UT6q82pMzX8=;
        b=O2iKC6AQWjY6oJ/7rwtiYxpnORsCcCsIKe+eoc4MsIY20aVo9sh0snMVEeMRxeEYb7
         R7Pf+05G4/VuM5VP9JrjO/bf4oLRnV3j+UAAO10Q2/Q2ZBWODatOXoH+IPVCWOt1VLO5
         nRdnWlwGMxZDScGmdt5oEGnYFqU/e8MF4sM0pitkawcsZlbJ5Ze1u9iypU/BTxsrMfLG
         OL2y78AeeV1IRiWMw6WoaMVfyOgEcJzUcgu6AL+cDhenrfc8KSLz1CGDJKJyvgZFusSO
         e0+QLYV4yJ2/lnUvdLwXuL81AZAx5qYo8QTQ42edWxSnCViURKPpXNaO4hNk8PPzws56
         BiQA==
X-Forwarded-Encrypted: i=1; AJvYcCVIR7qGcGQNsNeyeDTfhFU+IXQVIgMxYfP/gGNVLMsrGLOnN3srF5ml7TFLLADV5oU4UMcjRxVdl8qeIbgTeLTYnUKnWSEX55VWLTCz
X-Gm-Message-State: AOJu0YyXU0dNgLF2lHxdsq95gCX4dU20wPgG6cHMgPNyPJ0MU84wItOJ
	2klmtWrCmC1Z69fkXg2V1s+a0aOlgCTAxclgNw1lpEaHOZQmDHZdY5WCyhwHTjyD7cGwkp4YvUg
	tqg==
X-Google-Smtp-Source: AGHT+IEZtWnLjP/SYhqErAI4vD+nBsv+e3S+tTON9apiX87M2tONY2ATm4vpw94egaaQQU8IqgOAGcYzxBE=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:110e:b0:e05:b006:9e12 with SMTP id
 3f1490d57ef6-e0b23239497mr30065276.11.1721851946331; Wed, 24 Jul 2024
 13:12:26 -0700 (PDT)
Date: Wed, 24 Jul 2024 20:11:16 +0000
In-Reply-To: <20240724201116.2094059-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724201116.2094059-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724201116.2094059-5-jthies@google.com>
Subject: [PATCH v2 4/4] usb: typec: ucsi: Fix SET_PDR typo in UCSI header file
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix SET_PDR typo in UCSI header file.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 6a958eac5703..a0e91335da80 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -153,7 +153,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_SET_UOR_ROLE(_r_)		(((_r_) == TYPEC_HOST ? 1 : 2) << 23)
 #define UCSI_SET_UOR_ACCEPT_ROLE_SWAPS		BIT(25)
 
-/* SET_PDF command bits */
+/* SET_PDR command bits */
 #define UCSI_SET_PDR_ROLE(_r_)		(((_r_) == TYPEC_SOURCE ? 1 : 2) << 23)
 #define UCSI_SET_PDR_ACCEPT_ROLE_SWAPS		BIT(25)
 
-- 
2.45.2.1089.g2a221341d9-goog


