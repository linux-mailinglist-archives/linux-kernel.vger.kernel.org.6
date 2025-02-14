Return-Path: <linux-kernel+bounces-514934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D3A35DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858DC188BF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436A22B8CF;
	Fri, 14 Feb 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="KjXgz75g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FC2153FA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536228; cv=none; b=mvZuRgfRZtg8r7QD7FODzxrGcsDLC3MT7PbM1aIaA2HnlLSu4MEgMRIQLqJfStlEOrvU4msNDwJlTs4idl2kOczUiK37dUCVWkH109cEe1JrDxKJiLD6ISPyaZR4/Vw2BJ5E3CmpufeqZofSryOZoKboaAUkpC1Vln8dMBX/c1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536228; c=relaxed/simple;
	bh=Zo5kkoJMHUcshaZGn3DkGww9825pA4WmX/wLhxJ3KVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVOJz1wvOtocHVK1sBAad8wEtegd7+KldR0sTSPJ2aG00L9qllLbvR1IDsrf+qHRMn5RnQWNFNlngjnBHC6X12DYhCgeze+J5TB6O5vw7GnhgAmSut3/ll+ubG2RJdN5gXO8quO7KnD2dLqauUEMtwbQnaYf9Ij3fru02Whhzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=KjXgz75g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948021a45so20892145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1739536225; x=1740141025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2dI+7x4cPYMDMuQzFVTVbgprvZXCQoq2S3VN/z2cAM=;
        b=KjXgz75gllUYXGom3hc2+4su8eL44BooPCwMn9ZNAglkz69omxYV0NJmTA6fWmT2H6
         XaMWKX3qd0u8ZkQ6X64IoO2wAxkX3eSKNEGaEC21jc2+q4iMld87w6D+XbSneZ4Y9rQm
         C8Yyy82xeZG7DfaTgt0N4QGXrLIEkocv//rmCsIEbN4SLVhhFDAL9U1UcQ6ZBhoCNC7V
         oERvvc48P0P020MsAuwHOIN4hn0olb8fDDwvRTPyNb5LJ6nUYzSdV/TOo3Il9fcFUPzS
         OBKA+NPJ0/6fPMeDy1S+VVtQcgh6KQs1cN7t0St6LybQshVKzfe0oSvYEv/KS7XwF7vA
         C2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536225; x=1740141025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2dI+7x4cPYMDMuQzFVTVbgprvZXCQoq2S3VN/z2cAM=;
        b=DD8Gvj8uV96qdT7JG9aZ1xdAqS0z3wS4LbrNxH6CrrYxz6Wm30kOW/aARPh0vv7cqH
         7eQZ4QO5OJclH5g2349x/ylfLFHWYJI29toSjl+vdPS/Ume4GSykDyropgTWrzy4Bn5a
         fWZSI1GsKDF+IILHh1bdwYycl6gKskVnNCeBG0ZV7e2C0iccYzF0ulQdAzBtgb0OZUg5
         FSYRVF4awbqKMetgX1nKe3X5AwV0PaEDW/4rwnjcRiGtyDmTR3KV4Bqnw2MrnQzI0equ
         LdzZV3zxNO0d5ErDpavAUQq80yFVRc6MU3V/28yQrmRDxSu/K8bA9hyfJ+AhPb794fRe
         Udbw==
X-Forwarded-Encrypted: i=1; AJvYcCUiF5YhTC3WothizefIajAlnxZU7eWZfsWfavETZ5GDL14bwrpJhIjDQK/pKenRhTk3BRRw+PL0VF2UmWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHhdUPTc3Su7Fl8ke1Q0jV2CQHXXXq37sGWmzHr7nfIhrCJNj
	m/jTS6M/jtrYii6rFmnFSyhOURjOYFq1b5g7+2oX6o5rv6mMOYLTpGx9hy8unA==
X-Gm-Gg: ASbGncuoiPOcASRyKur197fyCRp4Y4TzzIR0ifEUhbctQEYefYRy6jnERkcAC4nCGPr
	ScBcDCoo8W2zRmNvvzshun0r2rbqECiRdCU6t1nY/xk/r/bg/5AULu0ThL3HODmnhLOzaahVHRJ
	Ux/M+8LO8cdYtcvssv49WuC7nmxnS4cCi+HaqaRVgZSZJxZaBNCGXYLN0K21v0GpdCePw3PF9uf
	ydJVCeevbogSNpt454yR6Ju+4At591hiDvaY7lRVgHIszFsJ/9FtB4j1pnIlX/mcm1n1QqbKtgC
	hy7HeKE3Os/Yg30mJXNQuMfSzL0gDlc=
X-Google-Smtp-Source: AGHT+IGCQD77xku+meOzyrI1bcUCnZgHXnIz38TFV3FtoQW1Y7REKBbrlYtu4VB3khtjgBNZ2tNWgg==
X-Received: by 2002:a05:600c:5597:b0:439:59cf:8e16 with SMTP id 5b1f17b1804b1-43959cf9023mr117883055e9.23.1739536225188;
        Fri, 14 Feb 2025 04:30:25 -0800 (PST)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:8363:ff71:698c:eb67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5efdsm4445049f8f.43.2025.02.14.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:30:24 -0800 (PST)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Mike Lothian <mike@fireburn.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Wolfram Sang" <wsa@kernel.org>,
	"Arkadiusz Hiler" <ahiler@codeweavers.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Andy Lutomirski" <luto@kernel.org>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	"Boqun Feng" <boqun.feng@gmail.com>
Subject: [PATCH] ntsync: Set the permissions to be 0666
Date: Fri, 14 Feb 2025 12:28:00 +0000
Message-ID: <20250214122759.2629-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows ntsync to be usuable by non-root processes out of the box

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/misc/ntsync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 055395cde42b..586b86243e1d 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -1208,6 +1208,7 @@ static struct miscdevice ntsync_misc = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= NTSYNC_NAME,
 	.fops		= &ntsync_fops,
+	.mode		= 0666, // Setting file permissions to 0666
 };
 
 module_misc_device(ntsync_misc);
-- 
2.48.1


