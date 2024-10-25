Return-Path: <linux-kernel+bounces-381122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A39AFAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3581C223B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B61B21B0;
	Fri, 25 Oct 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIBuuPv5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765E18F2F9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840121; cv=none; b=Je7xYIQmCdnxsTDIGUuL7neNFNNF6eL4PLzpa2Eznr/LN/Iv9e0TZI82/AZncCeFGierWnVf9+HYHSAai904v24/7+lFe10+xUW2PfLUOoKuhfY+u3gCrrQbnEbyucZdnLLP8d9EwE24bLniMzP6XVMqfpbros/pySb3j4lPmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840121; c=relaxed/simple;
	bh=JRmgeIfgxiaJglBf348zcoInp8TPx5Pje2Z/1h2y5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bNXGCFOOzoZOh8QjdNN8e0+aecuFbF+Qrvj+SZouEzxoEzkkmjb4x7keMrodfksp6W6kQCDXNsNFDYXzCV95T/TtkTDG46RC/9HBSEQ4QYm9x68rO4OxudzPBvznKVuUDosZ3wnLqjJ5JvMnhbaKR5d3A8MsZlHlsnI6qorcIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YIBuuPv5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so16069385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729840118; x=1730444918; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8QIRJXZ0+XZEDeR8/B5YrJvK8bXfy8avEI3faauU9o=;
        b=YIBuuPv5kvU/W49WWx3Jv5KLLBMZbO971zhLCr2blTNj/xxTj/82YkFLY4zaAkztB2
         ShkXwbJdXEi2W6SwZNtVOpNF3kKQs8BitfmP1iR4IJnjtPyo5a8ApG/FWa5m+/jFnE3r
         1w1Xq6B2PDsr4UXB6pyFzIRavm3Cm0ID5X6gM+yvTZrMPwEBhsEwwYjsxOaSL5dCp7hb
         LnAJwb8gkFtodXX/cc2SzpUEfXZnvHJEFGqehTSalFmlZ1rryyZDkX4SyJWaztfbYxuV
         HAZR2IzPuo/lI0oumldKLkG0cQLaR0zXVXaRFMnS21ezHpzMuhheoX4TXmwMNx3MKjul
         ihQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840118; x=1730444918;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8QIRJXZ0+XZEDeR8/B5YrJvK8bXfy8avEI3faauU9o=;
        b=AHi5RKtDb8xBJy5tLx4RVTPh5NJ81B/3+YKJbKcXbaV5v2lZfxBOLFLGF7Cddi4eoa
         KVVjDobSYZDBh7ScsnWsWQ3DZPA5pnwxKCP81EzbfWLWTbByXQ+x5swDLZKFeWy3m8SH
         8dvT1WPbWXkTh2BWwNLNA8b4EPa8Mn82DSoRJ2unoXpj9vp3yYVkjnM8hQCc3QzKnG05
         vuF8OvWZSTNykUnwceyjcX3KUFZX+xOcG0X3OHkLDd6vXY0G/DY8a2P/YHd3zBJF23hO
         FmsVb/oAo67atTpVOsFWoM10gPz3utrHyrGbxmQ4Yh4RLEhzPVMKi6V2e2a+aCnmNuHO
         mdhg==
X-Forwarded-Encrypted: i=1; AJvYcCUs7jWhopa6+pktCxuEtSVnxNT1+Mjl314a7NPMUxaUUfQy2S1aqWyAbgF+sTIepcxmepJbJ4Qg+XSJkC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHmr3spatC5Ybn7nE/9hejE3pJe6pHJgQSI9wQABDfiuWoy4z
	VupcD4IHh2BLu9s0HWgwTpBcPuzuzWBWTOnpO+yoqxCVRGX33bdCzLoZ6iH0x7w=
X-Google-Smtp-Source: AGHT+IEp2xGh5PqBWDM9Wkg+jeApGvA2cMBwWIOZECFXOmPjkiTnjE1h24IkOrL/WyXpO+gZkhUe8w==
X-Received: by 2002:a05:600c:3544:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-431841a3434mr70696715e9.30.1729840118259;
        Fri, 25 Oct 2024 00:08:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56fbd1sm39546115e9.32.2024.10.25.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:08:37 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:08:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] RAS/AMD/FMPM: Remove some dead code
Message-ID: <6b914abf-b3ce-4baa-b4d7-f8da9a840a3f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Debugfs functions don't return NULL, they return error pointers.  Debugfs
functions are slightly unusual because they're not supposed to be checked
for errors in the normal case.  Delete these checks.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ras/amd/fmpm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..3cde1fe17a7a 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -956,12 +956,7 @@ static void setup_debugfs(void)
 		return;
 
 	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
-	if (!fmpm_dfs_dir)
-		return;
-
 	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
-	if (!fmpm_dfs_entries)
-		debugfs_remove(fmpm_dfs_dir);
 }
 
 static const struct x86_cpu_id fmpm_cpuids[] = {
-- 
2.45.2


