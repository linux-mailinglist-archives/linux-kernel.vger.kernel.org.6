Return-Path: <linux-kernel+bounces-297406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1E95B7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4F6B287D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575C11DFF8;
	Thu, 22 Aug 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8X+xC0J"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5601CB319
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335237; cv=none; b=n6u22xKws22JgHioqt3ikijt8c4j4mjMCATVRMlIJ7o2h3ZGvwLxgzeXGUpkI37uF+PtBMdCRzb2DIfzBcnKCmWuoaq4DwPtak3fod354+3bQsHXloP5DtBpDSkveHw+pIaWVgHz+j3JZ27LOIwHixzBbn7s7Keul+Q7yl8xqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335237; c=relaxed/simple;
	bh=tGxySKSTO8qcGXrB893f4C6YFSw1eP0VHVb17wjt1OE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Oq/CVS3GwWRSzySKavUgTZU1fE3i6J7ecJg38QkpMb0Z7kBLHUodmWEST6GWoSYkRvGxLRJszfVtW0KVv2SUqG1IF8FUeKuV4xfmgPG3rQdbL0auXzgOpT88Y3ocDJJkWwi52p5hiVtQXRC14C9vIYoe++OZ1tHgbU7yH8hEYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8X+xC0J; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cda0453766so212385a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724335235; x=1724940035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTLkljK79vIqNPsl6WF8G9Xx/q3y0p1QAtEGLt2aawo=;
        b=d8X+xC0JQztfKBOH4sved/dKY7m1bxi1MUnI+ylcfKC34aXpDVkEwK8Lz/27jYQM1w
         4VwWtNgXVuiNyEvsAWhGa6CC+hWaDXf3oWL7ggy/eMDgb3XI3BlqbKVP/xMfCegbQOzg
         kD4xyXkEzUB9EumZZjAA0fnHaYq7TxlplZHbauKyq0pyi9RqKYMHuuJxLPF5h/slGRHN
         RyiXMCvPSygT5eCnBr5cSnpfqlEjfQ6vDdrVMFsy6aU24P6UTfoYKqcwYKd3j21R9JgK
         tCIk4boMxjk6b04CXqUep8WOIHLGTYQ7e5/qzTKcU+0hq0X0CtMpoW9Y5ehwLzFUdJ7x
         KYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724335235; x=1724940035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTLkljK79vIqNPsl6WF8G9Xx/q3y0p1QAtEGLt2aawo=;
        b=CNbGKGI8wK+WcN3fGToGfUgMkciMhvxBW7gOz0yRMlxraRVTotafqTcg8kXLAwMt9c
         6/dq0kJudhvCXPSfVdDWOPFkjZEpBusV67DvcrcpJ/JQ6yLo5dtqP7OWV0UMbWjml+tS
         RY7kuyILjeF93xcqDX+/F1XxG9NV2Rm7Pt1WbaBEa3epmInSbCoZrwiRZoH+zf3ZP8Mu
         CvljsRYKW4+Blp1F3wi0dR+q3wyeTuxnakT806uaqzl9kbzfjW3i7IXZc2JXuxFdwfkj
         S1hwHK2R3ptCpVwnk+FS3wRwfskMJsWRGWcEEgWi/zc+p44ik8XNhRbXYU952wslH/kx
         c49A==
X-Forwarded-Encrypted: i=1; AJvYcCWLi3VzteudB9cYWcq+GaiYY/QsQ5nDaOAXDvCme4Oma8NyffA62xw6OvJPAz75hDnVd6p0sw3l4qFUHgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshF2N+PNo1KhkQc+zoBNnzo9/Ixr8ozDeYm8MrMYkG5yPbLPj
	1Pq8CO+eYeyD17ln+kOpYtumUQp3Yy73fyvLklSnQeKJW+nGJ+BxR1VF3issSyg=
X-Google-Smtp-Source: AGHT+IFs4BQn9DIBeswayw4RZGkrbX0qCsLE6XAPC6PPsd/BR0n7wRyn6MVViOGUVsk6/6TaiBBCTA==
X-Received: by 2002:a17:90b:4b10:b0:2c9:61f9:a141 with SMTP id 98e67ed59e1d1-2d5e9a74ac1mr6885074a91.16.1724335234407;
        Thu, 22 Aug 2024 07:00:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:baa2:9074::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af145dsm1830588a91.38.2024.08.22.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:00:33 -0700 (PDT)
From: Hans Buss <hansbh123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] staging: rtl8192e: Insert spaces around '|'
Date: Thu, 22 Aug 2024 11:00:22 -0300
Message-ID: <20240822140022.11197-1-hansbh123@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Buss <hans.buss@mailfence.com>

Insert spaces around '|' to adhre to Linux kernel coding style.

CHECK: spaces preferred around that '|' (ctx:VxV)

Changes in v2:
 - fixed typo in commit message

Signed-off-by: Hans Buss <hans.buss@mailfence.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 1b444529b59c..e507593b939c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -229,7 +229,7 @@ enum _RTL8192PCI_HW {
 				RATR_MCS6 | RATR_MCS7)
 #define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 |	\
 				RATR_MCS11 | RATR_MCS12 | RATR_MCS13 |	\
-				RATR_MCS14|RATR_MCS15)
+				RATR_MCS14 | RATR_MCS15)
 
 	DRIVER_RSSI		= 0x32c,
 	MCS_TXAGC		= 0x340,
-- 
2.46.0


