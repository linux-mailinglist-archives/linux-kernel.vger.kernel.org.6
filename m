Return-Path: <linux-kernel+bounces-512646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07DA33C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F95188CD29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED122139DF;
	Thu, 13 Feb 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RNxX7nqo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADF2135D8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441186; cv=none; b=HHmynF7ehFSahCHw6Bu8ZkMmhIbqIqI+N5wFlruhPd/6K9fobUkCJSWLEJ65X+i1fv6nhTxUT6LBFJNOFzi59iCFUNHWuwaketRcNinO2kodPV3koKVTd5ccjPbtfJQMXQoXG/EKFuIpmH1NgRwdJ22tItl4UhXpiMnos0EulAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441186; c=relaxed/simple;
	bh=Ozsz8BPgoQN4B3zUUqM964eDIDqr49StEvbvIkkoggw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQ0wp7WZNq3sXKIxwh6WPizywuqEJg5xwVLk9uSocm/FW2qXY0MOIKKh5wtUCw/8vzbnFxNs8P5TyrLUEXwjHDmjQRfqiFcxVSja2vokGFADmWXYkRTHSPMYmIv9f3OkerZRwc1L50+TWZFs6TVhYeAbPfGLzOSF33HtiSwwFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RNxX7nqo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f6a47d617so10615245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441184; x=1740045984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA+PAF0czZRgWnRE67BxncOcnNW40JhC9/ZsrRpE7vo=;
        b=RNxX7nqo/QV0eic+o41hW13hbz7hbJBEgQL9KZpLd4XmSrGUnDRgau5A4Vipmr53r6
         LyzNWneeXZWC7xe+wplb/3urdmJmNkjQeGmKbG9YOgx2XAaCoec6xe9t189oM/gfOL4e
         68bzcx5IqMdNObXhReixvb/9EDtoG2tyb9dBU9YbTIP96CM1CmAf0uMCquFgVPnl4B0N
         VJRZly26tjECro8Mp8WJiz0gd6ix+3aBwLRoDdsgQmpdhsHGTEByKwk/ZsE32Fl2l49p
         CfhdX/c8uF2aPw6g2XULHWuOnPmQNP6+MjPaBg+MctDtI52cE0ZlNghPUTGGcuqrwoBX
         8NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441184; x=1740045984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA+PAF0czZRgWnRE67BxncOcnNW40JhC9/ZsrRpE7vo=;
        b=q2k9Sw4BrGqV4tGDWvhrfv4g3zrhMbkuSrMKlxybyMazs28Y4srKPLaK0xiuE0p7Vj
         9QU6uJwVS4mbfOXKZ/itZw4HrFArtgRuIbLJPeSv4i9gGx2fkJImCW82Ge2ocjx0BFjz
         +xAKf9ZY9RAiin1Lkfc5qEmoqrP5Ay3aYSP72KlnVVXHAJPrs/fwWDBCDrXVhf9ov5Pr
         6/DGOMNzf1ac0/zMzv1ZGD3Z8uTkMT96JG/okEXhHuJZbBVY2UcBKwyu9qZcIP0xK7sV
         X6ECggGJhdsLWN+EKOaahePRPHSUoAMf/PHcx33j4ZgzzDYHOrR4W1BFDbH0bU8Ej+tT
         KmRA==
X-Forwarded-Encrypted: i=1; AJvYcCUO3tk1OZWkH0jOrWhfs2qnYY8562lNirVSuuBz7B/+xDqgXB4ziRh32JI24ziUqyX0GZoOa4R2LxOdRGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmx4j/iGIROw1GcJhDiIqVzVT8QZrTMr99wLH562vAvUO9tRL1
	Hj2zuXp3q22bqBhgC5JSZX9n9cu1iL4Iqdckzz18cQrTp5ZSMx9LimHb4Bo/Egt6QCKL/2zUCtA
	S
X-Gm-Gg: ASbGncvOWPLTH3wlhKzUIMsy9WJiHDqxwQYLkWX/pg+ugdMklq/KF8oUieR+istQkmY
	xwE03fMw/9+PeR26F2QvUla7b7RxnnoxoqtyiYi7hh1jHwLihMtjhVqs28r3WwhTo62e3FEcmGl
	Rnz0TMGfeB/snYIMXyv6QRszFHWM2vwfTruQf+NahVNS1oIY5ljkyWjF/1Xx4fxK27IGbEXciRA
	A4x4uorc6MluohilK9YGZosHCk1L2BWEB97eUGkBBmPEwQxFVOSuJWHLUMAheqPRWkn4Xw5/lHu
X-Google-Smtp-Source: AGHT+IH6BO48+mvk8WAXI15mKey3CU3lO6dOiK5HN7kUT1OgIzkML5rU7vjzyJAMTQ255bPk7+t6Vg==
X-Received: by 2002:a05:6a21:6d85:b0:1ee:66f6:87ea with SMTP id adf61e73a8af0-1ee66f68ab4mr8632880637.36.1739441183980;
        Thu, 13 Feb 2025 02:06:23 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:22 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/2] blk-wbt: Cleanup a comment in wb_timer_fn
Date: Thu, 13 Feb 2025 18:06:11 +0800
Message-Id: <20250213100611.209997-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The original comment contains a grammatical error. Rewrite it into a more
easily understandable sentence.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8b73c0c11aec..f1754d07f7e0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -447,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 		break;
 	case LAT_UNKNOWN_WRITES:
 		/*
-		 * We started a the center step, but don't have a valid
-		 * read/write sample, but we do have writes going on.
-		 * Allow step to go negative, to increase write perf.
+		 * We don't have a valid read/write sample, but we do have
+		 * writes going on. Allow step to go negative, to increase
+		 * write performance.
 		 */
 		scale_up(rwb);
 		break;
-- 
2.25.1


