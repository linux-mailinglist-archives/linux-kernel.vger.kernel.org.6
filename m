Return-Path: <linux-kernel+bounces-517338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E022A37F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C8E3A796D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDA21773D;
	Mon, 17 Feb 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY+eVpKm"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC1217F28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786772; cv=none; b=sdj8wQtTINGYaNfJfJKUXi+wZ18BV+0n9ejymfIrzOL/wiYxkIl/RLKx5jegZRl6iMxuLToUWj8wK8YZlYX03Hf3u2imAGGCItXf1HFrHQU7Pfj5+RQN1gclDHpXUUtorfBgfYH4zyeT4kaTxnLnEOxa8NEAR1QgbLC0GXMsViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786772; c=relaxed/simple;
	bh=eIbUoOIO/oPlM/ArywSv2GC++LTTbctguFEEFD+IOC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV7uGciJll2Eaplt/K5/zUegUE0EBUyJBSPEFUgkuluZs1lKVuSvJCvradRR+MaSEcg2tZMVwiXtVFUMyWRHheRjpQLIO52jTXGBtnhuXVhrSbpIQYaRh8t9MI+mGj10HPSd8iaCbJH3bSt5pkZbb1/Prjfz/fmv5wpnCanUd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY+eVpKm; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2210d92292eso41309985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786771; x=1740391571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMj86FWLmYH9fJq/mESep7lKDCa0pYdVlxGvc/mylb8=;
        b=eY+eVpKmx966ZDRXNUKH4Qfh1pj37U6Fw2m25w9Dwg4n3KxuuCBwpdhO9q5Ny8AFXZ
         T8Cgar3fkGinZeHYTxes6TYcOHECZ14/ZqLqGMYtMtTC4XaZYkGXqm2F4L0D2r54+PrO
         L6u5h3Xo7m/99NLEzmE6Qnj2KYNch0/xrdyo6Mpx4Y7VDa2OADzCWJK92GdO+HpBCwkp
         RXYnj+M6oHR8buFe0DP705HBYuNU70Ar1l56XVlIPgqH+v3vduv2WKcsF6qt2w38u6eV
         krvY6VJN56fIvVl+87afQBv+OGR4nIvY/zZ6a1c0nH5Xf9RhCOQozQj4ZUBQ9eiJmeHe
         2s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786771; x=1740391571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMj86FWLmYH9fJq/mESep7lKDCa0pYdVlxGvc/mylb8=;
        b=rg/k8RuRFqCR2oUGjU8wjSICZRKXBlmwEAKj81DWciX2evXazYROzOCbDlB3WjJrAz
         WpeF607LMIebaZ+yVxtZHsihHynGU4uJOQoZJ7RdrBVsLYCPwq01sW76SEwq+i/IDlm9
         Ns+G0oIQQOnqcFJ+CSw1tnA47zBdVlGl+J39BhMEH0zWOYkPH2AtjAC4CPEB/2nSXsZl
         HHyr0jAcmDhrmDcAFn4HNG8XtZk2FT3U6m+46rXu0NzWOl54zeoYwN6szI7pTdLAwL80
         EHEMu4QDlFVW4WIOWYwZ07l++J5FgZKRSXTdTXdXXqsnSD7Rw7Ddm84pDI07JcoikB3J
         WyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGXQcsmZ6ps8xZCuypeKOSX769ns1wj90zaF/DaT4QM0gqxSWCrrwdn8uYSI1YTVwIZLI16trb/ILc1TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgzIZhucErn7Mg5xUROg6973dn+pLl26zQbl9MkK8xKasI5z9
	6R28WQ20oKzHTXuTcBoiAs4J7jh5h5XimIyiQirdFT7lrnnHrTtE
X-Gm-Gg: ASbGnctFNE6D2JGMmyyV3Ki3t201gKIu8J8Hy73vPJbTYGTHgVm4QnbU5kBrBqfOwaP
	KkxsOcoltDJ0huf5vObyDaK4guNj+lzKC5vk0vanSmTMOajL0xWgRPOvoKkdl1FC37n0d3z4jH8
	lNtPGKHd3hWA92Sgw3x/BUcf3vKNo9nCGMLrJeOg3NFZV8EXHYsaTsetPmp724UGtMAsti2zHCd
	nwgrdERCYq8QlQbOzAveEqZiHwu72AOYEROHE4Zahg+r9RJOJRdDYSlXO7je71ba/mZNomCb487
	zOyMOqC0BYBHs3IM/81S
X-Google-Smtp-Source: AGHT+IF+ylNk9uCKSZLwrSfkw6u4sUmwGOb28XeEZo9e3pF6VjDegZ0FEdoAi+rGVSX7y7WSjOcrIw==
X-Received: by 2002:a05:6a21:33a9:b0:1ee:7c01:d16 with SMTP id adf61e73a8af0-1ee8cbbccf0mr18603271637.30.1739786770578;
        Mon, 17 Feb 2025 02:06:10 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add286bc8e8sm4768102a12.39.2025.02.17.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:06:10 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 4/4] [PATCH V2 4/4] staging:gpib:agilent_82350b: Fix Indent issue with block
Date: Mon, 17 Feb 2025 15:35:15 +0530
Message-ID: <20250217100526.49495-5-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739783909.git.kumarkairiravi@gmail.com>
References: <cover.1739783909.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

There was a empty line, which was causing the checkpatch script to think
it's a single line statment, after removing the empty line it's no
longer asking to check that line.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index b6871eb3c8..1d644d000a 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -228,7 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 
 	if (send_eoi) {
-
 		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
 					      &num_bytes);
 		*bytes_written += num_bytes;
-- 
2.48.1


