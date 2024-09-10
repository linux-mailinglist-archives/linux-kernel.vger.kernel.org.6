Return-Path: <linux-kernel+bounces-322430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D250C9728E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E812F1C23C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1516B38E;
	Tue, 10 Sep 2024 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2KWtZxV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D35219F3;
	Tue, 10 Sep 2024 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946066; cv=none; b=OJYF2fX4+CsQ0i22jBiOgW2/VwcIkC8gLGlxFMYqrzFj5/FXWnvmvgTsKclKxj+f7jiJjFwPDDYoOgiwvj92HNxyiubbFCNnlSMBHSjVSsxUvKoDzOuEhpZdnch+w/ZfEun7dvJZmMdqtIox6d/eMJoUbHM7fcNPx7bxnIRl1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946066; c=relaxed/simple;
	bh=K+L3YKQtKJPMhXItz+Fyuiy6bYYwpvmXXEepUtmyerk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQyYDGMAChKNsWtWtsELSffvQaysL56SCGuTz8xEsGrBG0oct8XdefhRZF/DlZ+gBJRxKPRNeEb/JXy+2NBVgOO5OqoTZv+BjAp2SgtcK3fSe4ZoiHsa4DrqflyDF+KtxgGKrQ3jj+p3Q5zkuVQBnEfFV4Io1zbBAYPC4+ZqAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2KWtZxV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3249515b3a.0;
        Mon, 09 Sep 2024 22:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946064; x=1726550864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEtfoMqDRx+yDDIa9tn7IxDCt4FsjnmGHJMKKhjALz4=;
        b=B2KWtZxViCeCXnLAXOuh51tv9xGfyufe3DD61zpy0DmaLRW8UP2INSyLYD8pnNdpFy
         2XgtDODpEeI6YFnVJG6PpTPcgu0TtgJQEtGA68Ts2FXyBomrq1s0Rvoh7qFK0g4byJSQ
         ele37/tuqb7tjp8h0RY/Kn9YT10DpHxNeNXmNSZP1AWKYPiMwCk2hZOWFD56e2ZT036i
         TeeEkJgbLEmam3KTMNNbDmyCkmsBZLM2KqMZFTeyrADpvYKPJMdLiIzZLOGHqzu1oS5W
         B+C+C0SkPcBvXtiO6Tl9Ri8ExcLn/7iHyHqsIbCL7g3FlB7BmEOZlwhUUY/72/c4ev//
         jQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946064; x=1726550864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEtfoMqDRx+yDDIa9tn7IxDCt4FsjnmGHJMKKhjALz4=;
        b=cZwUk4aIr5/KgpSTCxjhTOeYjBE+T1Ne2cn2tkPT2zMnGAVi8GrAIlKOIgctqZpNGn
         5ciSY1o3Dw+xiyZVMYdFznRjQCzQZAAn1ZVwzntqKALDt2NtJz0cINq/uXna6FZ8fS9S
         EwX7MxDYDg1KNLSV+d2l/yTlrhP8oZWEuQg27jh20K21FIU2T2fVFpQeEhGcp/lOVMIR
         VR58Kap+T9M+7y/Ps5Wk9eaKjrMpB99IdGQ4LyQUdroXtaFHLm5W9g2G01QrdD0tQ35p
         gp3clTb8xn0zadoD9IJnmTlKhaNjV+3kKdth3el9osKOkjbELTXNkb5IbzgvFkmzb44n
         XV8g==
X-Forwarded-Encrypted: i=1; AJvYcCU2bOXa+g2k3uE876Smk6cJW4OI9CnaqghvZ7LHzuyJfkB25Z9R3V+K9EHRjxLK8ev563RRUi1cMQQ=@vger.kernel.org, AJvYcCVt42aLvjG4gfAVv4PscDXLojFPTlCVgXBCYqXZveD5kT4GuEfl8cbeUXllZrH3PEYCmRxHDmvf10YLhVT5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22VqqHsO6+NH76O08iLetC5lWjhfiGdLLFRNoKyJzrbtLaXom
	/bbecj0eLPX0K4CDx7IWuQzqu56fPMzCHPbk51982kediNuFuZhk
X-Google-Smtp-Source: AGHT+IHnOgN8l4AA2DGC3JHppwEd1vudzhyzl9cORSWuEhDk9LrdIjuJa7Dgan1uo3vrshJ1GaJafA==
X-Received: by 2002:a05:6a21:385:b0:1cf:38cf:dfb6 with SMTP id adf61e73a8af0-1cf500c188bmr2675343637.20.1725946064047;
        Mon, 09 Sep 2024 22:27:44 -0700 (PDT)
Received: from Kuchus.. ([27.7.2.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe244esm590594b3a.55.2024.09.09.22.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:27:43 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	corbet@lwn.net,
	linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cvam <cvam0000@gmail.com>
Subject: [PATCH v2] Remove duplicate "and" in 'Linux NVMe docs.
Date: Tue, 10 Sep 2024 10:57:37 +0530
Message-Id: <20240910052737.30579-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>
References: <8734m8h9ce.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: cvam <cvam0000@gmail.com>

Remove duplicate occurrence of 'and' in
'Linux NVMe Feature and Quirk Policy' title heading.

tested: Not breaking anything.

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 Documentation/nvme/feature-and-quirk-policy.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
index c01d836d8e41..e21966bf20a8 100644
--- a/Documentation/nvme/feature-and-quirk-policy.rst
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================================
-Linux NVMe feature and and quirk policy
-=======================================
+===================================
+Linux NVMe feature and quirk policy
+===================================
 
 This file explains the policy used to decide what is supported by the
 Linux NVMe driver and what is not.
-- 
2.34.1


