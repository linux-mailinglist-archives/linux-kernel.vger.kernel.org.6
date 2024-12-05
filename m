Return-Path: <linux-kernel+bounces-433011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234E09E52E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7C01661AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4C1D90A2;
	Thu,  5 Dec 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/BD3i9g"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E723918F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395725; cv=none; b=p1Pp0HLb1v9OqXcEe5UMFET3fJ9oqIISf0dhOpDAzmF6BcvJr2REsiKHeHg0Yemn6SaetAvmrvFkpKto9Ov+3viq398kSUMo1+6GGMwOhQ8U+aA4Zis+dEiJT4CYc+j+0M47sBria23R7if6Z/A6QbgclDt0i4P6YYvaUMeiVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395725; c=relaxed/simple;
	bh=EeduxSC3p2WPRVniwtpk/GgThtx5SbP6VMRHMxe1Zb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXw8kUW4uez5/7npekMlF5exVWtV3V+DecNMbnZNdfSsf54h55yUXW8yJfqJ6ouEUXAQFVAplBxmCRTqMKSLMiIHByN5iA58ufy0v+sPzzJ7HUnE5v5V9MtGub6gZw++cD4zTvE9Kgjrk8Nl6iTuTsWDUu67UfMvQRsI8s2/YE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/BD3i9g; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e40aa2e6so20835f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733395721; x=1734000521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwGN4mLWP7rXlc3slo/VflI3K7kQURVq4K38ALW1H3E=;
        b=O/BD3i9g6Dc3fMNZ7RWE0oGlM3/VeT0c+MYzVXanZjlC8hW8KvT0Gx0HVD/UrK7Xux
         bVofc6FTYC9uA5/8qcy/fCklThDICTLfvxBI7awxXZnAe7EeNZCuFf6+hXggEdliDoIR
         7MxALDltHo6dvagt8wnPDcmBLBA9jWx2e3q2tRiyJC6oBm5izNQ4kk8+O29YT5o1Db2D
         VTxqLV/mqixslz8Bd2gMp7uyM7QH+YMbDlDfOtw7aKJRa2NzKD0qeLyVKB7Gv4v8Ofzm
         gnRwcq7PrURRh+aZuVVr7ICHTSKa2uC/0YLnoow63Lv7VTgfjcjMPRGF398PkF4rKZ0s
         Wj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395721; x=1734000521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwGN4mLWP7rXlc3slo/VflI3K7kQURVq4K38ALW1H3E=;
        b=kK5RpuT4DHayhPF8oFPHMchvOUuScksXPHBawg5RucbYIrlo9/p9zbpIE0hFdS/F6T
         AeHllOkynw1+JnuWu8wamzGBf5UgLipwr/eDGsb4ZBDaDz6s1Nl64hrM2ezg9it6QkEo
         fG3aunWpKSR2p1nqOpn+P0MgT9nmGhvhxpUhrRS2orXbYo7YAT8RCkkdF3PfZyjvK1s6
         gjHitT1THSOwGG1oNhBa8vtoiTgoAd8cpnhcavQl6KeVMFqitfoKFehno3qUuCQFe1ub
         lFnyFfCh+DfyCovwKr/mKBL2oZrg6S7vBHCWFJLSc7jJx8Z6WhrXz57o9RwlDfm56dIG
         RTEA==
X-Forwarded-Encrypted: i=1; AJvYcCXDHWEMNizhcsxdYsd4OMqVIYyo36dqKKa+mNlcDu4xse0jBEkX75xB1PPG+q07jfrxAz4cXzwVS6ZPAOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykGJrxjjQbD/iu+06nOYpGTTfDCgATBzi3hx7NGwSoEVjnU9Lz
	Fes5h9S5IIMOHIbJnhYQuAEKyXUmBITu6v6HkVh8dqRdUhH+CZ/Ez4ftR3n6dPNRiAInkg3nXXy
	1+Vc=
X-Gm-Gg: ASbGncsaPAU57Xg4aY7qgn0HSLJLSnzvhamUQGHSyZMTfQ2mEbQ/4/Ltd1ytzSNx4CR
	76L3XthvSTeoG3sWsV/hMUHBXTpC3hYavUZMFYs+9nKht/lzPzwkXntlogiylVUevNm/fqAFCtT
	HW0HOU6F4QShZyBuxUlAQ7FPCjZfr0QmmnUvBUh619UEUJOOaZ35/irkUpCPZx9/JwjVuXz+zxh
	fwcT8UCyd3r2t6JsUfJYoJujarhZv4Fa8rNpHCIq8uxeqn7YzcC09/MfH1ey9dR
X-Google-Smtp-Source: AGHT+IHjqgkJp7AQ470kPy21BVG4bwS2VTM8RP2jGp8BDGX3K9R+8RFbhvLubHU0utP1L0Hl1oZhyw==
X-Received: by 2002:a05:6000:4008:b0:385:f72a:a3b1 with SMTP id ffacd0b85a97d-385fd3ce97emr3064092f8f.4.1733395721483;
        Thu, 05 Dec 2024 02:48:41 -0800 (PST)
Received: from localhost.localdomain ([114.254.73.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm1081629a91.45.2024.12.05.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:48:40 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Revert ocfs2 commit dfe6c5692fb5 and provide a new fix
Date: Thu,  5 Dec 2024 18:48:31 +0800
Message-ID: <20241205104835.18223-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SUSE QA team detected a mistake in my commit dfe6c5692fb5 ("ocfs2: fix
the la space leak when unmounting an ocfs2 volume"). I am very sorry for
my error. (If my eyes are correct) From the mailling list mails, this
patch shouldn't be applied to 4.19 5.4 5.10 5.15 6.1 6.6, and these
branches should perform a revert operation.

Reason for revert:
In commit dfe6c5692fb5, I mistakenly wrote: "This bug has existed since
the initial OCFS2 code.". The statement is wrong. The correct
introduction commit is 30dd3478c3cd. IOW, if the branch doesn't include
30dd3478c3cd, dfe6c5692fb5 should also not be included.

Changes in v2:
- revise the both commit logs
- following Joseph Qi's suggestion, apply patch [2/2] using more concise code.

Heming Zhao (2):
  ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2
    volume"
  ocfs2: fix the space leak in LA when releasing LA

 fs/ocfs2/localalloc.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

-- 
2.43.0


