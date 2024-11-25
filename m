Return-Path: <linux-kernel+bounces-421370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654279D8AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F65EB3577C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183F1B4144;
	Mon, 25 Nov 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks12kMM5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C91B5EBC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552160; cv=none; b=EKkFmZCuYBRIPdzaBUUjAkFMrIzbur0VmtAzX0xUOYlmx1SA5EZU5J51m55UT2hEejzdJL70puE2GKCSbHFxWCo5UcnBgL8ubD8DKm52khaLu/e8nXYWpHXh+wzhtabKVwLGNqMDXq5cCcYjYMSmLMh4YDfO88GBA5lnwUOGW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552160; c=relaxed/simple;
	bh=1SHyNoiCPeOramfnu+Q2RZgqAviQ5KFGXgXyENYm+L8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCkl8WXibKtPyVwOnKQPxDMFgbtccNlTl6kMX9vDKW5hNWTsyrCTyh37wKoYRRumbhz1+8v3MJs9B5Ons3e/+rPQfDK8MiUazbDv3Q90rdZLmyCk43czi1pRd0y+Oy3vbQreR23c+Slg+MO2YEgfCbeRRs3A9z4FBOV6ii0BZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks12kMM5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724d23df764so3546605b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732552157; x=1733156957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xpIgW0gfP90G1ojGT9fXNt5qPS0UZtoQPhRhhtFsTs=;
        b=ks12kMM5rNJIgcQvdJ27RNFfOisXp6Guewro0Zl54kSSNRlfzjdMKpPgsPlf7Vmjgm
         5vFBsG/z98fYEnTr/cO10P9BH9I1CPGdD9d2SQaekaZw2badLBELW5AF+R2QcsE4IheP
         3fXMye+9LF/58SVxKzNvTufje2v/1E66ryviW6P5G2cAXZimrBerJa2C7rBKh2BG4Riw
         ngt14xaHqrtR+k7WAs9TcPXHp+NxnYdVUfYaDjwWq0KMX3B/82lGdg2pT2SZD5HfWU9h
         u7Bf+mRwAS534Jl0Do9oEVtaUzSxCmGLw798WjTkRU103JXJyeQSKiEpVcK3Ub4XtPeo
         IrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732552157; x=1733156957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xpIgW0gfP90G1ojGT9fXNt5qPS0UZtoQPhRhhtFsTs=;
        b=aBbLFy+P96BoYV7kGVJHEzcGPjXwRf20Zd8YY8SbGn+Vw0xtfn4MXyD9lj+U9pT4GV
         T4vXxgLOlWVew2ORDTN5wQ7BiHV3ByrPvrJYvMMgtUjI/+WXnPkYkn7zrmJN/OFrkriA
         oshJZQpCnWRdWp6+Mh+eQGhtaxofjGScO7AhsFze6jBnxFd4Uhoj0H9eKvav1rviqoAp
         zLs7PyO3jmq0qr7t2NumTZYJuoXWjK7IHZiGdc4LTXBUDlwr4lzNmdxh6mVu4DJBfRYd
         J50KBQ5PmFXrsopILy5mRc33GA6LQrRjP4hvvjrtyiwnUPhNMie5oyTN6PtOkn1h26eJ
         pq/g==
X-Gm-Message-State: AOJu0YxxjX5+0od04mKWbaI4nbEIHogy2XFkfsQQ/FX13+7vaB0Qfx14
	Xg/qmiEUSP+6kwXeieNRC7KR3v+6vRZJfLxkSXneGoBLpGhx2AxqSgmYBg==
X-Gm-Gg: ASbGnctqY0fKURlsZDDX8Viu+gNXChsD3PxX1A26tTfyHGz1XcSD9i+sA8peFMviX0i
	RwbnuLvDTICowM3Pb6k0nTbtwa9YO0xPAKoqT12vvN7bpzQCC/jh7eWrPwpdDd4AF/ymT7UVxHM
	Lqg/5dSbN7mz7jC2AjoN+7FRENVawzu9+hp/BAZKuHKDkgKTMmARIHVtwxShVBCuIpn+5xMaZsr
	lx0PnNIOzG83JkKx9mH6fgvLQMoy0SIFQzB7dtS6SOebj1fTb2v8tOgZs7h3qn/
X-Google-Smtp-Source: AGHT+IE3+IP9fQuubEk3uDoUiOlpEKKIBxWbgYgj/ZNqWEm3X6JP5NZ+VEOMLJcHOIvVkkd49CGCNw==
X-Received: by 2002:a05:6a00:1950:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-724df6a3856mr16148054b3a.22.1732552157411;
        Mon, 25 Nov 2024 08:29:17 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:5b47:d969:3b6:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de45725dsm6587476b3a.16.2024.11.25.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:29:16 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] mailbox: ti-msgmgr: Remove redundant logical check
Date: Mon, 25 Nov 2024 21:59:09 +0530
Message-Id: <20241125162909.20319-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant `WARN_ON(!inst)` check as `container_of` will 
always calculate the address of `ti_msgmgr_inst` if *mbox is valid.
The indicated dead code may have performed some action; that action 
will never occur.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/mailbox/ti-msgmgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 8eb8df8d95a4..b5fb01327d80 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -580,8 +580,6 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
 	int i, ncells;
 
 	inst = container_of(mbox, struct ti_msgmgr_inst, mbox);
-	if (WARN_ON(!inst))
-		return ERR_PTR(-EINVAL);
 
 	d = inst->desc;
 
-- 
2.34.1


