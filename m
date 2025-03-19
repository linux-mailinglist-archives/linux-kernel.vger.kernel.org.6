Return-Path: <linux-kernel+bounces-567901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C141CA68BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EA88A0769
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC815254AF5;
	Wed, 19 Mar 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bma8YtMb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876622139C9;
	Wed, 19 Mar 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383852; cv=none; b=ExJ7qgEicoiWvipt9u+zQ/F3wmMk9HF+8CgycI6wkqhiU8UqvwALfARpTRGvELTW95XzQJfX1J3VCMMGldeVxFK4yU/XMEHa1JT7pwwU0cRsflNlPLzpxbnPCPzgbE//wGJH9l6iE0DDs7X1lcgzsNBVV7EI52LU6Jl81iRgTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383852; c=relaxed/simple;
	bh=kV6soY466Hq5cTykIAP0+tJMSIZ4kgRgf5/TnJoV54g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1NFrAWI02djb2NSxpHBeHAFuuVfkvOpg0bbDzkD7lm3EGnKJ2dqN7LnvHcszln4vqw513KKyuPLHIJGVm9q12fs0DrS/OZwLe3oiIr1rKienS36iyDci7q9yw544JBSsxqLawimvHy50Wm7WxdAIbj3PagypgdwI38ccwFyuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bma8YtMb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso6104574f8f.2;
        Wed, 19 Mar 2025 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383849; x=1742988649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KStnGMg2Go+m3NSHkQmKCGIajR/m7piuOFNQJozw3ks=;
        b=bma8YtMb4EyBVJ0h2PC8jtJfZwuhfuajbVi4W3bAn5VE3x2EczjjIRTGoFLm4TPRLE
         JkzgZBfxQeFcHNgFPQtUlmvfglxDSw+AZUVWB2b/iaT2e/iV7T/TVu+AcxH/QEQILPZL
         Tv0U20IPUzc3/f1yDSmU1nTo/96l6cXOk6vJegs7WaFzoVbiQ95mu09LNG+HWkrXepxu
         xqm953WzGz1slcOT+u+Gc+RGq1xtGw/647poODFOaVzDrYCR4X80xB+Rva/uUL1PiUCq
         RRE7HHykga5Gg5V4EWS1WlawzUp2azxC2RxB2BHIrqBMUO2RKu0UdoL9FrHTb14GMxSj
         aldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383849; x=1742988649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KStnGMg2Go+m3NSHkQmKCGIajR/m7piuOFNQJozw3ks=;
        b=jzbPkTM59GtlKMOaNw3tsuQcyhkNZHzWe7aIhIqqz2oZJYLielv9vtnlF2PfYe6PeH
         Ea+mED0q5Xe8ZxaLWVavRzc7a7aYkDlrQC1V4w+kwjhBcC3D+hoNOccBZqftJ1GUBX+r
         CzNCbDUlwqCohBwV+qdvL4+0FY95/FnGnFKuv71iWi2fFYGE9o6lgBy68FGphl6EQv0o
         6DPTqMB6w7sWGTWkeJBwlZUJrvRT9YUi1oQ03Lm02EPxIkrOwh/xtMP5tzrL7gxoCMck
         iZQq8ptDaVfxWhQAgjdJdUn7mC1+/TwUvtT6/H76Vh7/qQDAMUZhSoRWzhmHe6n9ygUg
         msjw==
X-Forwarded-Encrypted: i=1; AJvYcCWCMUqM6Yg4lpziSrHuy7Z2vIQyijlGseRNsNqVaJF05QSwTRvD8CEIRnRaiVT08oLpAI2gAavOu3q+K1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sQE0WTRkshQK3oCE3QVvRG3vq/wCOT/pQ8B/KQtfeGIwutnL
	MVX/om+3CX9+6WH/DpWI6/eoeq3JMMO1C6jpfGJdksPtcbzgbfGN
X-Gm-Gg: ASbGncunclbO7KYtfLqw3gVWf8luiqY7wN6gzKFmNS7SD+XkeDMXhpBRVnRx+SRe/Et
	S0cE+U4XVdS2HRIJdjtbSpTChI6LD7G2Uaiy5ROV8sH7/SURYBI7Tt2++YQCqQxftWh+QNRncLQ
	GeskRnV8w180ZbIBbHGzFhwyH7PWz8RWv5RCGGzh6eBWxIcNDKMxilDA1wLMDM/qkPXD/FWvpjm
	w/iIa2ccjVNVzd+oM/HeWZuACyWQwrOTlczpGGHEgyo65Htaia8wpoBL/BRa5QDoGpgCU8E7RzP
	oVmnejY5t9a0nXvJtlxu7A/zB9l604JjU5zm4FgFCTyj6g==
X-Google-Smtp-Source: AGHT+IG14lFngV9AvZzc6XvwZHyRbIa6UyKgqajD69XgSsqas69DdBfaLeNr6zGtd461P7paU9u2mQ==
X-Received: by 2002:a05:6000:1f8e:b0:390:df83:1f5d with SMTP id ffacd0b85a97d-39973b3005amr2831957f8f.35.1742383848680;
        Wed, 19 Mar 2025 04:30:48 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440ed5e0sm15821935e9.37.2025.03.19.04.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:30:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] f2fs: remove redundant assignment to variable err
Date: Wed, 19 Mar 2025 11:30:10 +0000
Message-ID: <20250319113011.791319-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable err is being assigned a value zero and then the following
goto page_hit reassigns err a new value. The zero assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/f2fs/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5f15c224bf78..37c76bb19a8c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1497,7 +1497,6 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (err < 0) {
 		goto out_put_err;
 	} else if (err == LOCKED_PAGE) {
-		err = 0;
 		goto page_hit;
 	}
 
-- 
2.49.0


