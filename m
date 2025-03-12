Return-Path: <linux-kernel+bounces-557386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD3A5D839
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD681716BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89523535C;
	Wed, 12 Mar 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbWrMUD6"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4220C472
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768307; cv=none; b=n58fb9stJj0bl1hsRSvWiG+cd7LO1SPmyGSILxxPJD355pzJFiTRqRfFHlcaxGWzp7gx2wp+AQEWyStRq78n3eadpmkTn1Ozbeo55ru0s2SS8AGRscNqmvTify6zr5s790p5B5cr+lshs01PxWlmMkdW9ulvNuHuf4m23Uv2CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768307; c=relaxed/simple;
	bh=FT1oxj0Qgt13l0mXa+EPVobcY1J9Jerp6oe4CFShQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZKpWQKYCR2mZ0WksyuNbyzb5uYWZTIPVMmjtvLowZrx+X5maXBSiDfEyMJ721pm11d2T8Q4EO3a1kXvBJ6nCXdY/cMxG2vAWQpa/9rYglUfT1JNI4oNGeP3ixXnLOKFNzHLawUU7O+lj7+Cxt4i+q5lI6vr6CqNFpv8Ewo72nzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbWrMUD6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1648273f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768304; x=1742373104; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJss9g7O/dMXFJMt3GukmQPPAokmf3Hhu32HSuWCJ2w=;
        b=tbWrMUD6ZoqMKKOfJoldMDr7uzKzfGE9XlHAePg5Vn2uLXXztXqM18I6NsspXiZp7S
         W59oWEzgwvSveEethtWfFCFuYsdQ1K7uCyQPEA/QxfEZke7IosMW8TVbjADg4/MccFyF
         ih16ClDgljIjn/y7+rrpzOjdMkSDRUIuwIjViBon2RbMfRXZ2eliDB4pGjNUDkdayOkz
         k70Hf1ubIEI9XuTO2ijLYtJwzFVjJS0eIcDIXzgzHMMYZvT0M5X0o++VLYREi1q4rHH+
         GLFIQnrkaYeucerXZT6saquM1iGgQzuaIZyJsGE+ujUctgZUkjXHueHAdy/IT1NY1EWq
         5xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768304; x=1742373104;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJss9g7O/dMXFJMt3GukmQPPAokmf3Hhu32HSuWCJ2w=;
        b=MlEYghyTQ7H7JSun6fv7OtOAaEXYT14fQQg7ahIuvtFC0nvNeH2W1e7ShiS+W+ioWx
         tGk5STpYLZR4vMiGW93oznC6w8eHkzn0PzOUiBhy+U9/dDyC7wyG0np/jwJv5XwEeK2V
         uGDmqSjvCa9jEK/jpbI4RFBeTs9s5qqdxJVONb04twivp5CqQTU4avfWr6dRB5Ay7eVc
         cG0KoEVpgCCY9EByHlwcsQeGKw7zadABAEmS1MiKSUB22T5kqMIGyYaR+zSDH0HswZZ6
         BwQPvoHQrRuRo33Vr0d50SGCQgUFDgjuhQZHS90iD15oqeHyAlUtq5vpxxRZb5Cm/sXD
         tQpg==
X-Forwarded-Encrypted: i=1; AJvYcCWbie7LSjthdnQaZiq1VSxvnD1kki9pjjeVvra+QawNwDeq4LeAG2Zxvzpw/vdWlIxniqcxZJjgebIflTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0OrhRwSaHpF2qdh3yyAichTEnmdsvLfqaKwHU2JfJcM8yfmm
	KXdjWmVadR8ZufLdIl1/NA65D+OYQZTrllcjumxdhw2F7iftLUOUaiBdQGGcrks=
X-Gm-Gg: ASbGncsjVobc6RHcZd0YrwYT+wU+sIMb3yptVTDfwoeN+UxuJXo8jVct5dLYXMTcBrw
	bGhLFeEL25ZIBE2U4U/S0f+3HROqORu6P6YGXePNyA3KJtsDO5idMyiFtXtJFc9+qkzRULpSrhq
	nZ6GVyKTOIdrUlG5lj9YdpwyI7kYFZ8SAiPWDFDHQ0a/0dptzJLp54ZxAXgCOFM1gPaxYVanaXc
	sU2KHQuKCaNF70Db3JpxXydG4h9b63NIB8Xoup50DqhDsDsMH6NHHinBEQyibQX+fPlig8arkWH
	mUNzgsnNmulYf1iAcSOVzGRbDomyDOckOeWGwPEA5BJ0B1zI6g==
X-Google-Smtp-Source: AGHT+IGSSv9SOYrAJaJbwR1yeaga3JE6OR0syE92NYaNxFFvCniZMBgOzqpRGm8809U1/xszfdAp1g==
X-Received: by 2002:a5d:6d04:0:b0:390:f0ff:2bf8 with SMTP id ffacd0b85a97d-39132d05f78mr16351423f8f.10.1741768304183;
        Wed, 12 Mar 2025 01:31:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba8b6sm20754870f8f.11.2025.03.12.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:31:43 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with __free()
Message-ID: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Pointers declared with the __free(kfree) attribute need to be initialized
because they will be passed to kfree() on every return path.  There are
two return statement before the "cmd" pointer is initialized so this
leads to an uninitialized variable bug.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index c759c5c68dc0..1d4b2ad5d388 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -556,8 +556,8 @@ iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, char *buf, size_t count,
 	};
 	struct ieee80211_vif *vif = data;
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_dhc_cmd *cmd __free(kfree) = NULL;
 	struct iwl_dhc_twt_operation *dhc_twt_cmd;
-	struct iwl_dhc_cmd *cmd __free(kfree);
 	u64 target_wake_time;
 	u32 twt_operation, interval_exp, interval_mantissa, min_wake_duration;
 	u8 trigger, flow_type, flow_id, protection, tenth_param;
-- 
2.47.2


