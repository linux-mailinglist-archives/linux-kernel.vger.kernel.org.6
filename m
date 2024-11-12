Return-Path: <linux-kernel+bounces-406259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D469C6167
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C849BA3CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE72076B8;
	Tue, 12 Nov 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDey1Oft"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8620720E;
	Tue, 12 Nov 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427122; cv=none; b=E7NSMQQXtG2g5Mr2tXuggAyewLA/aaRQs1dBIAUJ3Flkb5GrUP1Ip0po7qRsixOHy8DlJ4F+4CZf/OLC6tdGWJTCEsAEnfqh6xfFDdsjCP9fnRMZPlpwx6P8s3zmzpQRn53qsAM3DpJzxZpAv2Y4UN6UC0ARc6NJjJDI+PiK6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427122; c=relaxed/simple;
	bh=WzQuvL1qaXh0RlfWv8D0x8WAvSbMA0OdN3Q2Ejhekms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4GZ20WD0/yHWCFvJoyhdxbvD163WnsKFcGebNP35oGAVDyOon4llPSHIM+IHXHNfRAwao7pvWnyFJVzFVNqVNtu/AAdbCaRsBh/Q4pVP/gkvsazFaGCsS7UTQhev6yvQ35iFcjgwerZ6EbXdqFZcClJfxApoaHFI2W/k/8rSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDey1Oft; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so49136885e9.0;
        Tue, 12 Nov 2024 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427119; x=1732031919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a3ScA4GKVwMKEp5bNwzhgLvy/jMX4sk0gqCJ9bcam4=;
        b=XDey1OftcG3JqSn+PdZ4QJueC5CatfC6Wk2YoifNsqrtjru9sdf7jmRsHEWBSSi+89
         fGqMl4q8PlHKwb8Ri3fV6L9fWw3OQYhecwqCx6yqGFveY/98q65vRwJIyNbcmlHz+aHh
         v7HLdVABCmh2DWDCnK5g5b0bZBRFKB8icKBAMw18r4aKRSFpmjhpoNEZoXYzEmo5GPXT
         Idd8fIkIcg2DfLANCUXrhgunPnTvxBaTJ/pGMu8l9V1J+4OjUgX6pTKWcaTCDO4NNBhy
         sUm18PknimbkSTUPmMnBhXbkfv4DDLrqADF5Tnfr4CcwhgESY5avVa5FBRFnu7mOOjKR
         v+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427119; x=1732031919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a3ScA4GKVwMKEp5bNwzhgLvy/jMX4sk0gqCJ9bcam4=;
        b=HU+Un16dzMmfD7Z4vplZt6O3QhPDge4IwLU5w0ELt/+w7rJM63b2lwzcuyTiRYoqLz
         xgu/JZE4Aje09gYTiANX4Z0a/8ZPcGkrjZHva4EcOms3fF0Rd9iQlQexkx+V6XVzeqJx
         Hd058PLx+HdeFzchiaIV8TRo7rqSCcN7NtEN1AJ84zma61GNvNQlh9eFTwJUwGNqyRmf
         0kef9mMk8GXpiF3Qvf21aBKN9mq6pSqbFl9P/fhJwQRLGkqErn7vKNgn/6CTbE5F5EOE
         zJSn2pLxi5+PZ+c70Qd0MCQoRd9gPBO4BmXBqKT5Bjl7bWAIDvgmReumMfkaABrlr+jo
         3o6A==
X-Forwarded-Encrypted: i=1; AJvYcCVoG+J+fNIBb1vuNDs2NJP+HeIN5P0XxRyQVoeDd8+6XNDv89E411D50EuWpr/yujQR4Nv8duXpQxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMg+MCf182BQuSc0wR8g+q3YvBytI27njgz1ZSi8fzMt7UNY+
	biAGc3Ups8NBahKfQhnkvF7NR8FWbHjAsR5x+tKhrH4L3FFkHbTZ
X-Google-Smtp-Source: AGHT+IGKhg0idjgcZB7nZV/8fQC70huh7z1KhT3us97vMBFd4YuUTyplBPiFYDRAuAdW3/aRHr0ETQ==
X-Received: by 2002:a05:6000:2a1:b0:381:cffc:d419 with SMTP id ffacd0b85a97d-381f183f682mr14837750f8f.36.1731427119405;
        Tue, 12 Nov 2024 07:58:39 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:39 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 5/8] drivers/usb/mon: refactor min with min_t
Date: Tue, 12 Nov 2024 20:58:14 +0500
Message-Id: <20241112155817.3512577-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t() instead of casted min().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/mon/mon_bin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index afb71c18415d..c93b43f5bc46 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -823,7 +823,7 @@ static ssize_t mon_bin_read(struct file *file, char __user *buf,
 	ep = MON_OFF2HDR(rp, rp->b_out);
 
 	if (rp->b_read < hdrbytes) {
-		step_len = min(nbytes, (size_t)(hdrbytes - rp->b_read));
+		step_len = min_t(size_t, nbytes, hdrbytes - rp->b_read);
 		ptr = ((char *)ep) + rp->b_read;
 		if (step_len && copy_to_user(buf, ptr, step_len)) {
 			mutex_unlock(&rp->fetch_lock);
-- 
2.34.1


