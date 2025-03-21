Return-Path: <linux-kernel+bounces-571440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4974A6BD28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC618189E053
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2831D79A0;
	Fri, 21 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzU+Lroi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CD21E0BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567766; cv=none; b=etEdZt7Q6y60D1sG3WDFea3OqPko+0SRzrpA6O0kPYK7gcrn8V5c44qBWJ3D1RQ51nzhBPA85gpzUB4ezCgCs6O7o2UaLTs9kx4vk/glEIRagTwyn/bn7kWLTyZktbtMA1CcVMxW02V9B/zgcspVfuKms/55l6p4Td4i2KPoyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567766; c=relaxed/simple;
	bh=3Jt22z68KyWgHvqCCZSGvvKTcyUcRvUGovF1IdxZ7xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F5oj0tzHAtdqwJnWvewF8qFgNEoNmLJfA2hIvkDMjQl4RoBHjLiu+c3q0dHPs/zXcxkapvoxXfnmMJ8MUq1OQJ55U3HfgesrgUBqAic0fNwTuQ89sJ4zkvVCuKsMQJyMuq2aJ9za3acXIWRPZYQt4b4fS5WflVUBb+D0w1/lucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzU+Lroi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1507567f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567763; x=1743172563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3TRMcYPovdCcpxNpOwTnOH/MV3MA+4jBX9Ey4iK5so=;
        b=jzU+LroivtyPIYTpsTInSmhx5KVKMRWTGfqT57ULYQI7kUHv51iwhpoFMLMoL+0NJp
         ZtXtrYSlPO4lbDG7V6aw1nLJA9RHZ4KrHyvZd2j57S9ySAMrZfLjYitp8th8x8vNZC3y
         2CjzEGPwe2e5F7EklPNSYsENQjhNEWJ1W8mhZ4vJw1a/2ZTf1/jifEC/o+IhdrGUvULX
         ViH02x35qqocIPT4O954ln0J90RmtXr7GaJ1kRVbi7lKz7WdOdMiMHT3qwYoY+IpR/RQ
         OKxgQn9ftLIRG7K4u2oyCT6jr2ciOKK7sWvpHq8t83P/uTScAwX1CdSQjscinwl5A2EF
         N1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567763; x=1743172563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3TRMcYPovdCcpxNpOwTnOH/MV3MA+4jBX9Ey4iK5so=;
        b=t6WSa2erLUq0cTXTShYOid8QLyRv3/XWKvLJFbDXXU9oyzO7UnbnySaAE66yLmH2gW
         ul7/hD+0pazcSmDlBoBuNCYxarF73fFXYq7EhnYoYv16Yf2ojO3nXbjHYpE+k2PoEQnn
         8aNHwO3wP6uwxtwzNowXWFSUhDwPTHtxS0OwxldrnV7EtNOTwveE7OhZd5jQdWGhkVRD
         V/gdpcKQIAo18CjAT49RY+yWE/uZce9C8f4qKy52JpVdnkkofyjLEN46y2LOgouWIfBE
         oukUSrR13Dz9nVdECgtvRZDXmLdnzAlyoqBnXfhSo2EUlBloxHXLiv03Jq9RXErSZn97
         cE1g==
X-Forwarded-Encrypted: i=1; AJvYcCXcJqj2xVA4gT7NY5Ec2jqWk0sMJ3PE76SLxHKAVwxL4b36vDqu60wbb0f4VxvDvXE59J9FWsFKibTh6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq017/0uQgyGjtiMrgu4A7YM3P5lKSrY6BGIYBT/WH0v/BCli
	zF13VzAdWw2zDXh9nISiy7SGObYvGzvxN7BgQ9KBTbL+MHZzk7ddnpEIRIz4rdU=
X-Gm-Gg: ASbGncuuB8KYAYECKsV1AOh0nigmjJcwJrnUJKWbknxx1jKluQcu+Sn9otKtqFb/38Q
	jqCobUbNjjCRnFKBNWDt5onumm/lQYMKIT9tNVJXtWlAyB/55i5a9O7NgkKOpjC0BQvG1hCZyA1
	ImN0M1kNa5yEAWHOXlkyxvNvrD8yXkGjzJdxBbbgK55eOxNHu45jiM6qsuXJ7j7zh1mDIPu1aUM
	FUxNZfMjb+j4pYfZ2lgmRbpcCLYNm91eIJoaRKlhYTz2tJKtqjUyd6OTsabDzHXxpoGpJYk+/9U
	+RX06E0TYgLvXYU97gxw/Dw0u07bypK57NnOfLF1TvZYxDymUw==
X-Google-Smtp-Source: AGHT+IHhiGmfwux5UkjuIUqxq9oi+dkK+mUOCpGIZ4do/XrfF2IaNbNhOgkz66lIuN/uqIj/iyqgng==
X-Received: by 2002:a05:6000:1cc9:b0:391:32d5:157b with SMTP id ffacd0b85a97d-3997955cc0amr5526052f8f.12.1742567762989;
        Fri, 21 Mar 2025 07:36:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f55721sm79742765e9.20.2025.03.21.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:02 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:36:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: iwlwifi: mld: silence uninitialized variable
 warning
Message-ID: <add9c9e2-3b44-4e0a-a4aa-7326f6425baf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "resp_len" isn't initliazed if iwl_dhc_resp_data() fails.

Fixes: b611cf6b57a8 ("wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS command")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 453ce2ba39d1..89d95e9b4f30 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -396,8 +396,8 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct iwl_mld *mld, char *buf,
 		.data[0] = &cmd,
 	};
 	struct iwl_dhc_tas_status_resp *resp = NULL;
+	u32 resp_len = 0;
 	ssize_t pos = 0;
-	u32 resp_len;
 	u32 status;
 	int ret;
 
-- 
2.47.2


