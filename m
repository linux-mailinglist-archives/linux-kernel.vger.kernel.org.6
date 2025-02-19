Return-Path: <linux-kernel+bounces-521394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3970A3BCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516913B6A04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652811DEFD8;
	Wed, 19 Feb 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA3SQhHi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D143151;
	Wed, 19 Feb 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964189; cv=none; b=Z3DnkiFQNY6VjJg1BPy1C2UZDex/RjrJy3ftY30BheCJt8/TunsRI9Ik16EQmWL96IEpZfuG2VdhkVBoDTFkQCglaQaXmHVT/DrQQm37OSRaV+1crVE/mT1XRxEnXkjxiU12/cNOB9jigaowjH6UgzScr9Bncc7olwZQ+fWoNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964189; c=relaxed/simple;
	bh=NrL6ZoW8DJpJUtu6w7iSlxtNi/MMqeTdi8RjmOi3iD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMQNZqWoYIMzKZktICTYHvul7Rd27Ogg6j0WtxvAPlPCrrSadfSId7ySRnzTYgUqtC7DvscT53H11cOwpRfNRFgO2DpMRudz06hFS/n2ph4we0wbbDaW3jS/vJ4qJwLzKVdrRAgSpxBUFnTTColYsJLeKmPoRw0CCRrzVIV8drI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA3SQhHi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e6028214so114278145ad.0;
        Wed, 19 Feb 2025 03:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739964188; x=1740568988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZm1dJAwKAk/F8vlE+OX9d9jmGJPVXQxsC5N5HXvT/w=;
        b=gA3SQhHi/PFZ5SKYrHoF+LQflr7M7TZ1lkpIwcDcfhyv2AUcOA6ymUmhMljugIrT7/
         xK1OfERdqop2gc3lvodVL3umNAbeqtsacAN0aODZEivQJ0Ydl+gOU28Bele9pQ7+gMPF
         LNs5KdvE/SGPJ8tmsd7s8lBDIBl7DbWbGWQztxFm3ndD36vXK1alHmkPpiOJp8r/4QuO
         RU5+4KFVQcRFbE/+KJSGj7FFTZO2d/GgZL8GGjp6SDKRdbkBTjgINX5WfTHdSH1r/i9r
         spR2cVBz5C3ksEW5fwjr64eq328K2HUwVutrRpipjzQo0a9CuvrDIn5g2DAnaiQngBGt
         2XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739964188; x=1740568988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZm1dJAwKAk/F8vlE+OX9d9jmGJPVXQxsC5N5HXvT/w=;
        b=InCdmBnJdU627Pr/TSmKRdx78Httx2xHr8liexthDdhqNRfpKh4K7alD5BG3fXx28X
         +ANAj0HTVMZKDOu0zFrMgDQCgqdVbd2QDxNdI0P/nMrx21TbfgImOfLKMHro9/aGlAX2
         ertzH01RexRENJ1I7aIq7EBxMXOnVo/stFF8tg4kwv2WTFqc0kUEXrahGxbQ7uIiMzNZ
         VQbYRDTEL366Z+Sa0IeASwuaBhWjUvmSSfYKtsVCmSpEuu2w15MyXZvXlZe0l212Qyhg
         ckD6FTsFJMtiImBaC8fJDiOBE0iGg0VJ0oFtAfoQn+qaolf/qgmKXu75mleamTrECWB7
         yGyg==
X-Forwarded-Encrypted: i=1; AJvYcCX4nTEBsGUI+KfYoQlVQnCK/VbibuUMbsVVcs2OhUk97F281pMbh59NRs5pKBdsvLn/IB/x3q7faUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dhTVuXwy/kGcHPA0ECp3R85MZ1KXpXanQlYgYfmULwCpZ1Be
	Up8GqQANbEGi9sCvAxIk1rcnYivjw9SpGmaIJWCZy91Omrafv603
X-Gm-Gg: ASbGnctps/2rRFkZjz0TcbqzIwmm2e6B/G4GUwKWTDO3J4VS96CwO50eOXuitpI7mv9
	2CS6/T50po+E4WvmPZjv/GptNO434Eqf77LaXWfGTFMPWTnSblfv1pDFb5VKz0IN/2/WDN4VYYX
	TyPbhWQMJFIFbYWZGcPHKu6XhR58Gy2UugX7UYbWMCXU1/3NT4kGZKGoPTR1XfmxrhLVFMHUWLx
	nqsrbSHdvkRRYdmCnmRlt1/399rhKIhmJkMlODbSPykgYabs5Ni94Y1UEg6r0wWy585Szl0hl8Z
	e6+Lu8YfNer168jKZzEuwe1I
X-Google-Smtp-Source: AGHT+IHOhv6/aSNiuotCAFumVgXlWpVdHc0na20KYdVn/2hnOPdXJvK9hfqyYxmMU6iW6Q+ux4gGKw==
X-Received: by 2002:a17:903:2286:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-2211c551bdcmr224224985ad.23.1739964187571;
        Wed, 19 Feb 2025 03:23:07 -0800 (PST)
Received: from archlinux.nitk.ac.in ([2400:4f20:11:c00::101:7e79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366242sm103277995ad.87.2025.02.19.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:23:07 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] docs: scheduler: fix spelling in sched-bwc documentation
Date: Wed, 19 Feb 2025 16:52:54 +0530
Message-ID: <20250219112254.28691-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling of "interference" in the CFS bandwidth control documentation. 
The word was misspelled as "interferenece".

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 41ed2ceafc92..e881a945c188 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -59,7 +59,7 @@ At the same time, we can say that the worst case deadline miss, will be
 \Sum e_i; that is, there is a bounded tardiness (under the assumption
 that x+e is indeed WCET).
 
-The interferenece when using burst is valued by the possibilities for
+The interference when using burst is valued by the possibilities for
 missing the deadline and the average WCET. Test results showed that when
 there many cgroups or CPU is under utilized, the interference is
 limited. More details are shown in:
-- 
2.48.1


