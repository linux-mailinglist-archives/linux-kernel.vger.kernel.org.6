Return-Path: <linux-kernel+bounces-512644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797EA33C05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26830162CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AFA212D84;
	Thu, 13 Feb 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MHcRMTDr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407A1B21AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441181; cv=none; b=lP64ZIOXABSciA3zf+TMp+VoyNfR2kpUuzxEkq3ZHztYqdPD1AMTs096fR5nTdS75JT79toHpn+AJ1UfDZL83FN2Ve72ixXyF//b8qnqF6PaMyxpRReATrwdSMLZSIxKV2OlcWOfVP49qtf/TklUyV2tjUO8eC8Ri1JQ5K13AMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441181; c=relaxed/simple;
	bh=IrFbBbfqEiJa0zHa0999cM4RYYVv3FsmmGN25izoDuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vs747MF1oDYGH++zD2GOMNtZCdU+HV9uVbk/xdjzpnwDKX9TuwowMBJLJInEu/Uo83fnhHMGBth8XsuD+FxRtEUqtF5C52dqVDR6CEJpN06h+M3nI9BpmQv94O2oy8q1c7TVU4HrSVWdqd/VEJXbeLSiZtBsn9ouLtIwlF6y3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MHcRMTDr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c8cf98bbso13216095ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441178; x=1740045978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULrQM8jS/N8rKIapgYLPr6eiDKMqeLmtTdffubtbGqg=;
        b=MHcRMTDrg+lsu0sUpHRMJjp+JMFX2lLQ2nFLlnE+AMbugCryu6Gn6YdQwcp9ao9YgN
         y4t4svLPL3ri2aWYvIiEsgHo3ALVbQa+FElys5QvqCDxQG33438t5/okWNVF7uDtK+Mq
         0BPlkYNCzOv/f+r9m6n4rd5zxOcoIdqA3kO7UkFb6a7VpoFJN58b5hBrsWXL/6laiDAZ
         ExxPt6PVspAuZwzvMrIyINXuaObh+rFIuGi+vJiUCy38PFYm15A4sXkZ5sIP6xLNmjBm
         VJl8RL46cVh+rIjDCoZhssuj3v4wBH8iN0nlnrIkAXJlXWH/EC7vwA0jzF3aE3TS/wqR
         1XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441178; x=1740045978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULrQM8jS/N8rKIapgYLPr6eiDKMqeLmtTdffubtbGqg=;
        b=mqS7uystAGS6G+DOSvMx27h4KU9A8P15vy6hDIs+Ezcyr7MAVwc1Yd8OycdiWOBIZQ
         Lrphn6Au4FMmsUymjEoBnA35qkT46J9HFaPeWYaG6Au7rSnLlnXdYWhNEQkpkKs4z5U6
         6bJ/DzoxnlK+c5rosoa4lndaJGuf/0PBp1E67M0B263UR0U6Skbc6PKR29DATG3t5cZE
         zY14G4wOXU7dumJImgNU3Rzpv2IvcHGY4Ng9MALK0OfEp7zaGl6nqlOjfxlwO5lo5Uvq
         defBY5rFxlnvP/0a8Bsyi+qYnTB7FQlYruz/pxmQ3SYmSQpjPBjzgnnIc/dt2Y8DwcQi
         PXBA==
X-Forwarded-Encrypted: i=1; AJvYcCXhWLxe9OOTejloQevIaa9A5a/3KuO/aBewJejnc2zLe0fbuKWB1qPeapmvM+D42s3UQEpq5CjCCEnDNAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTibWmQmG53Gc+WTUH06fF/YozJANlIufgTnKwYeVFr4ANmzl
	t20ql7GzfiydSQBuuzpwh9O0YllRBauyKc8J6ZdrCJFA0FCUAZ96JH1Tk7Sazz2XeFUnIVajdOy
	3
X-Gm-Gg: ASbGnctCxIpwBGvEY1Q6EeXqc9wL2wDvJxyLUxGMo2/lPCzPahhVA+CG04qpzUpgo3y
	RISfL9OZhQdb3a5B3pGaOGiSfZq+8tZK2aKvQ8PmLpdrE3yCJ6znDzuLzbG8NkNzQUddiH7sI/Z
	QS3KmFunNcvDMcNoyxpQ1Ak3mPpJ2wmCtD9D8wEk48yF9BReXWqyQDZgXVGQ/mSFemNW21yg5q4
	r/eOP85hYGIA7d6+UmP0M9UWCwrH/TiinE4KEKMSJeRfiQyaApo7JHpgUEi+ZIaQPiTgn8U7Z/n
X-Google-Smtp-Source: AGHT+IFZcuS+n+mUKTvU8TcdE7azW/glC+u+MrACA5Bttms/YcqUyP54Tik2TARGAWcwEBYeIi+8Qw==
X-Received: by 2002:a05:6a00:1d99:b0:732:2170:b6aa with SMTP id d2e1a72fcca58-7322c3f4df1mr9438701b3a.16.1739441178506;
        Thu, 13 Feb 2025 02:06:18 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:17 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/2] Fix and cleanup some comments in blk-wbt
Date: Thu, 13 Feb 2025 18:06:09 +0800
Message-Id: <20250213100611.209997-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v2: Take Yuai's advice. Modify the subject of patch #1. Move the
modifications to the comments for wb_timer_fn to patch #2.

Tang Yizhou (2):
  blk-wbt: Fix some comments
  blk-wbt: Cleanup a comment in wb_timer_fn

 block/blk-wbt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.25.1


