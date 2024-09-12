Return-Path: <linux-kernel+bounces-325928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272B975FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED7E2856D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378B188010;
	Thu, 12 Sep 2024 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1IP+qfa"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E228F5;
	Thu, 12 Sep 2024 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113505; cv=none; b=FrbmpcHFTJEW8GeUM48HUoiZ+U/tXREAGfe6nCtXSf291qbVHA+AMT/96C0eFIEqrbd36eRiCVzAAlMLL3lJfe2jrp0mEFNzACayU+KO1o6EUWCj6bSQ0V9J7xr7xAcrd+Qb1IXr2Eypb+4a3qkU02LbnEJPyGbZnbHPdVG9IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113505; c=relaxed/simple;
	bh=YVb5mOSgVEoh00SI3vDwZZJ5t/Ip3f/Ajj+k9DooyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HalOkfHtPW9OrdppRmaJscmP6peigwrHnNJaGASeRqGb9IavI5Wgd8v2ASSEN7gN+WjKyw8DmhA1clswX92CtXJrR70e7zDOR/CTxI9UqYP2qU+oBJORdbFkvQ9lG3CDiKa8dULQV32N07BabGFB58jly/lBdCoIIJ/pHTc5Uhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1IP+qfa; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7db19de6346so369705a12.2;
        Wed, 11 Sep 2024 20:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113503; x=1726718303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2hLQNIMSmxWhc1/C74r+p1wfn7zuzdiQIq0XCR1VZU=;
        b=Z1IP+qfaQA/tuziAHHUbbYu9ruCsGnIc4R7SEHTLFgRh30XnPmJleIHPoYkQ21gnyO
         KV5JP7jKLWRZNw/rrmwtVlOke04cVgR9UeMCOD93Hf1kmeJBWoM10n0Vo/JPNnuTgzQ3
         85hlWoZKFQSe/2pntifGtXpR59iux4PmkrKy7TTNpn7eDTtakoQmDeJzz1V50BUqtTkX
         xqsskI6VBAhp3zcFgMgPBrksljnv0A05NEuxm+eOBWrVp1wQlgxALR6JMKVooC3kHT44
         Ojl6YkBXpInPoOXRNxndY3ZvXibFdjcqFZCdYBoNJIpSHNEsIpMAdo2VmDkrZZXujR2u
         LrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113503; x=1726718303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2hLQNIMSmxWhc1/C74r+p1wfn7zuzdiQIq0XCR1VZU=;
        b=ifmsTZpceetkyPlxjlAIyclnyncGhZs8FF3Apb2GxYhzlRuV8MgkmF2jrBk1lUJA2l
         gejsYsH+QBn+EbQ+1AfW5VTC4LNKSOCT1Shrl3umG9vYq5iRZYsJ7WGiw0Jin8jPdyME
         4Slqsz5sB2yUHJpoBfz5H7uXhMsKp9h4F/9a+Wdf/iUvFNiQxWp3yZ3cwgTg+bfDTvE8
         X/nXCPgTP6X5OD3xdkPcObVwSjyafi+OnYi962IIQo03oCZmB52HP1dQtx2mR+Cqndqw
         2Q8+8Monh3IlPEeJa1pbJijN0wUXtmBfQXq81kDoRxSfZvAUGNcLsyrRlfeBVfCSPnbn
         bwgA==
X-Forwarded-Encrypted: i=1; AJvYcCUuPfYpmb6+r/GPKow9UHPrhZXaiF6NYH35XKhLi0ezcrsbSSejVjtKJ2gRx3mqPXp1rObWMJLpLcvoAxCyQGq0hPam5Q==@vger.kernel.org, AJvYcCWu2HIikKIEaaSi0d9baJvhA694+Dyt+GqphVtGwxysjWyqdNL+D5e9QmtMelhQwEjDST190bRoOn+Cg7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0JbpjR9mlt9+ck7Wt4x+tWSQExHdlmr/O8ZfjocIuTpIWyIA
	+ioesJINd/qoPL0PD/kY4onIPCX2pCvxjzrRmhtJFpdF1jZmqu6MUqpIY9vIqO0LBg==
X-Google-Smtp-Source: AGHT+IEYVR4Dk0ZvCaDyqJiI1zczDrKh9T2qArG66b7TgkwyL83pGpRRjoOEbm2uAuYdTVZmS1Ftkw==
X-Received: by 2002:a05:6a21:1796:b0:1cf:6eeb:bfea with SMTP id adf61e73a8af0-1cf76239cefmr1769180637.45.1726113503302;
        Wed, 11 Sep 2024 20:58:23 -0700 (PDT)
Received: from fedora.. ([58.246.215.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909250asm3713395b3a.133.2024.09.11.20.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 20:58:23 -0700 (PDT)
From: aln8 <aln8un@gmail.com>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aln8 <aln8un@gmail.com>
Subject: [PATCH] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
Date: Thu, 12 Sep 2024 11:57:55 +0800
Message-ID: <20240912035755.47278-1-aln8un@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14 
where it advertises SPS support but doesn't use it.

Signed-off-by: aln8 <aln8un@gmail.com>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 48870ca52..136709797 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ASUS TUF Gaming A14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FA401WV"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
-- 
2.46.0


