Return-Path: <linux-kernel+bounces-274689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26B947B76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F8B2193E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3215B143;
	Mon,  5 Aug 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GY8MehYV"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8B15F3E8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862581; cv=none; b=n+OsqIxYi1o8U9F/3/7rgStdWKo6hGtrRor8yGwfmcJzUc35EDfLO9jubJt3eED/v9cXafoITrXDgyhCGPFJZXFEU5vxwlPbKlmUB6T3+z9nh+mO03B6heE+DvV2VPWfswOVzuPwrDU6YYzGvVqFre5pdwS9Tn5nAiEzw4zS26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862581; c=relaxed/simple;
	bh=LrVsRNvxFEtcyRcqLpy6K+Q65YiOJ7LBOCCzVy0NSbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnYnDkeRjNZFK4vUotT24wKkFoTFz3v4AzfffZKfFeRyNfowLIcFdDoXsvHQPt8MEsh3LgRDbJdP8zmNKei8RHw7QRlKOmEHLer/geRY1lICWaCAQh2t0y+lAARJbTZUoExCod1WNgqVNoDrJMQq7FdE3Ln2dGqfhMU1GKsHNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GY8MehYV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2879bfb0so1012854b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862579; x=1723467379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiQJiB5+YTgWJEkf+MbrVUnf+za6HpDp7AR+2atGBrA=;
        b=GY8MehYVOTLaU+DF4hvJF7yRiGTV44TaIen0XJJxaxAQ4MrDeeSpL2rPIcVzD+qRVa
         bTcVOvMS9VAFMlLx9S428G9h0k+yXXVaaMkZqFfFfnUmxIn16wM3iR74MqKNUriVCJdc
         f4f+pw7qDhNj3HHxOauiRaSyFRGTdJA89GyE9J30KSkbsgqKlnaC1wOPLh4r80W/Xrh6
         NQLOmV9Q3bMxwaaw+6OeC7TaAcCmmH0EG4++58ysH5dbmK2m4p/Mt4OZHwPN340/ycym
         yq5Pb+zOmfSuG5lmclpge+iGhSHmSr9ZxO2ryqyIClPGftdwz/ka69hBoWo3EBFCEMgk
         C+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862579; x=1723467379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiQJiB5+YTgWJEkf+MbrVUnf+za6HpDp7AR+2atGBrA=;
        b=j+Y499KmKSWKYWE1yy2HFZFXPe4/A0i3hiaDD3Wy1+7YDPzIsnJi6BsYspfo9c7VTO
         1H5u1xyoQDG52uvHM8ZtP30zZNBXcTEenM3BnP/85hrQmbZjIG3kQ4TfgqJgDxYoHhz5
         sitPWoFtAgMcXRw1bRf569Dmc1pNviDee/dG9WAYvrYOBcF2ytlaMWFhzNi2T3mjkgVn
         Nz2xev2E6ZTGpJDYaHpwTG6irxw8tIXurLlm+KTsuEo/O7beUBB3KXZZO2VTIynQwgI0
         3oahrjDHlznX/smvI88zmsnSW1/YVVSKpfTJadArzWC0GgGBDHYF1gGR1sLfIEaiUqgV
         oXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1p5By9vMGlE3yAWn17IcrM1M3vl84RpMuRCfsEikJnb/+u8Yc4ZzOAxwe/kHKbaFiHZ8FXNhaoMXZRYCasIcA3fNLTcWMyDsKhocs
X-Gm-Message-State: AOJu0Yyd4PsZHbhKnXD2s5Kl2Fszrn8x81F7ET9yx/70/AIcFRjpGoVS
	ynLHtGXkp4Se4Q5kXEK9bi4gytj/CgD9Q67atZx6FX/kxnZkP3cN2a3M0ucQ0Wo=
X-Google-Smtp-Source: AGHT+IFVoFNV/H2C9dHSZ1PBN5mIC2cyRnjqaIeUe5zi3ii7ROXtPfC7wvdYAPcekd2YlYQGHcbP5g==
X-Received: by 2002:a05:6a20:9188:b0:1c4:c8ef:8e68 with SMTP id adf61e73a8af0-1c69966d186mr10728067637.9.1722862579692;
        Mon, 05 Aug 2024 05:56:19 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:56:19 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Mon,  5 Aug 2024 20:55:11 +0800
Message-Id: <0949a17afe11cf108b8a09a538c00c93cdc5507e.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86 has fully supported the CONFIG_PT_RECLAIM feature, and
reclaiming PTE pages is profitable only on 64-bit systems, so select
ARCH_SUPPORTS_PT_RECLAIM if X86_64.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2f611ffd0c9a4..fff6a7e6ea1de 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -316,6 +316,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1


