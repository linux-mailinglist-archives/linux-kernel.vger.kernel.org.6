Return-Path: <linux-kernel+bounces-515600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B68A36692
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9921692BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CA1C84B7;
	Fri, 14 Feb 2025 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfJF7g6D"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E501C84C6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562986; cv=none; b=FRSe8Tc0rYCm0mF2TtLpWAWpKCesTK2/Xk/g3yTiNUSGj+sjiPKwa6GYPf2l8zPJ9ysuAOiiAQUb9BHAwb2xu3mmCxTNF0ZRhhmoYzPBYwOLAIgzHxn57+IZiY2EC9/+QTXFmXmhLDvPOQLCMaeuotrdxmy/isLCHiL6tqJ0t+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562986; c=relaxed/simple;
	bh=9hUHviB8Tx9k55ubfDviMQfJ+a+JJ2cdWX2BuAb8QO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUYONLmxJxwDv5XWfcZqli2nRvWNOaXzZXA9w6hKqOi6tsZZRCChBQ2gHweCZZWVCVMbtNKSWc8Z6/PptdM66MwgkV4CqJG9KBo36YxVSLV65B2MW+9I1xw4o+Sk5kSsEpiqdhBY8zBnE0wk3Aka3Pgxle9rW/LW7OOrCWQ2Tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfJF7g6D; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so538433a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562984; x=1740167784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoVqtrul78ZmQYxag5zWjsZlqRvCUyfe2dogin21crY=;
        b=GfJF7g6DstCjr5uzTuVrOQBv7IsBB12bC+MYCqmh+ZUUSCqGlUFWgwyaz5TaJs4pic
         cjMqInOBZyw8i3x0O/lCe8RtIrjofE1U5j56IaUuQrwJPop9r0M7X379GoH4i04hZOdb
         31Jag4xb+QY6x7ZfmJIJWPx6o5oPYH9OCTt0MSI8cUfb9DYaNO5XLv9TcxUb/zZ1A/Hx
         2NEr4HlczOSitASXnnj/Itj5d77cTDp9swYPBWMiNkjwj+U+gv8hK2dqc71Avv8puELx
         alKfe2i9eX7NHHoDpYRE2NJ7T6V/PZVV6No25ne4VHUSHSDnTxffPcsIzYSC1wI1go/x
         Hsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562984; x=1740167784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoVqtrul78ZmQYxag5zWjsZlqRvCUyfe2dogin21crY=;
        b=jHq1EC3BevWXjtaUrTfHFg3I13fLfHPrfYq40zNRdQ/odOSjN+bD2Ird5hXwFXr91l
         sDjEqGZ6sUifYr0XG4/CN/i3GSrb3ELY0n43GXJP/sEeK9evXncUrEThR6hmP25orPuF
         vRp2ohKBGrk689iPxHODwwlHCdVLOlXWXuxnYeW/jA5UqmtJ3xffNVh0WCejxMlXNCSE
         qRLDLVGeD0Q+g7nKb3hgmbO9bFIZr7eQqURG6IZVeoyJbSDbtBQWUy4nRis2DVeZMKR8
         eW/7y0EdZN2TVcQgIU8Z+HyihiUalR7CDu9CwXqpDmJfdM0mQh8GXd2nB+mTpYZ4zg+q
         s4HA==
X-Forwarded-Encrypted: i=1; AJvYcCV17j5YgYyoGjQJrjyzNoycVoPiGmaPbZ8vnhyge7aiOWew1i0vl7mA3l2M5/9PnsaX+wehpxTaDMqXuLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdeXCCkNhcYhrajX0lzZ4/VsHIPPHICBOCr/9b/lw8J8pzN+E
	3TqoNYB/6FnrY1HCBxYutORK7GkLtNDUKqW9L5V/lZ7c2GPj3t9Z
X-Gm-Gg: ASbGncsxpDyQ9GqlZ/jl4skELUpXAhUAGWIN5oA6z00MYnMzxMk5c6JT+FWt4iLhugj
	bzifhQFGkUR1NLILm5cGETnAiNS/36ss0XEBAxToEz7zHmHE7j7BaMknh76lkw+fpuWJnlMTIga
	a/NL6Prba2871We0GswUJEj2Y+MQiZ1ZYW9zVLtKWYtvQ+6UTmNV36u5UihBoHEwiVXIhMvwRUH
	1QDUixPHgRsmt83ftLu5t5EotXcF3o+ipDqGDCdM71qRsWUR3nOw1TQh/YIvPzC8CKUOJ87zWZU
	L6udGqLVVVB6Ci6vxO+Qo2zDK3Mgv2I=
X-Google-Smtp-Source: AGHT+IEh5vY6/1BBhZnY57v96vl0eVB/BJ6qr+oXL0vB6dOIqbGJ7ooNykzBiLgy4xhWAyC8zyTTRQ==
X-Received: by 2002:a05:6a00:1256:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-73261914657mr366739b3a.5.1739562983856;
        Fri, 14 Feb 2025 11:56:23 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:56:23 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 3/5] staging: gpib: ni_usb: remove unused variable
Date: Fri, 14 Feb 2025 16:54:44 -0300
Message-ID: <20250214195456.104075-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove unused variable 'adr1_bits' in function 'parse_board_ibrd_readback'

Since the value of the variable 'i' is increased when 'adr1_bits' is set, the
'i++' post-increment was added in order to keep the value of 'i' right.

This change removes the following warning:

warning: variable ‘adr1_bits’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v2: added post-increment 'i++'.

 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index d0656dc520f5..41d9cccdaf10 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -427,7 +427,6 @@ static int parse_board_ibrd_readback(const u8 *raw_data, struct ni_usb_status_bl
 	int i = 0;
 	int j = 0;
 	int k;
-	unsigned int adr1_bits;
 	int num_data_blocks = 0;
 	struct ni_usb_status_block register_write_status;
 	int unexpected = 0;
@@ -460,7 +459,7 @@ static int parse_board_ibrd_readback(const u8 *raw_data, struct ni_usb_status_bl
 		pr_err("%s: bug: status->id=%i, != ibrd_status_id\n", __func__, status->id);
 		return -EIO;
 	}
-	adr1_bits = raw_data[i++];
+	i++;
 	if (num_data_blocks) {
 		*actual_bytes_read = (num_data_blocks - 1) * data_block_length + raw_data[i++];
 	} else {
-- 
2.48.1


