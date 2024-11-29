Return-Path: <linux-kernel+bounces-425858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A59DEBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5BB21B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090281A0739;
	Fri, 29 Nov 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjteZ2H7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264EF1EF1D;
	Fri, 29 Nov 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903953; cv=none; b=hXi8IqUaHmpaQqIpw6tw3SEWsUlZ7OjNYk5PmupzjbdX9PqSUs11HSgJjLJtPbBGwX3DkbJgJfH3ehxSPdg3Roh4a6ylSg1AywWGS/Q7pA8sazJkeE4ujQpHlQOkwdGHt9bXW01nft/x9996Lz/E3r1Xx2aT75jRpv1j/d3R1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903953; c=relaxed/simple;
	bh=CBh7WT10YDLEJkfL8bq21SxwACIm+uBV24rsE7qy6VU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTLBtczPMoypI4AASXdwpoe/GMF0IrqU4OSB2p14//2+B8jilMCnSTRSUK1Yxdr85e64POCAU1fxQ6DerCm1FRA2Tc+6ZmghVj9pfg7yesOpecnCmrJsxtWlBg1L/fjoUgYy0S1yKxARR0Z8AYpy9xwVMitSA6kKl0IHXW5Viik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjteZ2H7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212776d6449so21317565ad.1;
        Fri, 29 Nov 2024 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732903951; x=1733508751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RDCvP/N02qfEOdgSsm5/0Qv9xDeDKiVs9uaElGgbPw=;
        b=CjteZ2H7WyP8c4mlqYRxTdTtqcKU95t78YeqbtUV+YRWkqKKPzuIVSW1W9yoNrWI4U
         m29yTLDz9X0Ei/AOMlxrfYayk4L3gnfy9euv13+DDP2GTi1Hw6bDd03EXm02BQpnx5z1
         sQiMKnVNhEiQccsk6o67pQZUVE+Qi0t646Yk9XXd/i5NfVPid+LPPes0gtTki+Sj52UT
         pXZulwpqr7b4w6Tw54QLT75f/ze20I+6Ilx0rGKNSvHYiwg0PP8O+5tzop/3Qc8nowPd
         XAohSNB6eFapfvXy68qzUHMgLsz6PSjIs5/q1DN2pPtpXaWth7oePA2/4XQEdaPZytKJ
         ezBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903951; x=1733508751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RDCvP/N02qfEOdgSsm5/0Qv9xDeDKiVs9uaElGgbPw=;
        b=i5Ae2Yl1asnRbONQ1+yJCQ8dD5HSKFXhKp+R7eeXKWfceqT7CxCNBdJSG2VAW6lTyS
         1Y4MKn9Ye0uNTOxuEniJVi6P3dqFN2FLtymCD5gDG73pK257hmpxOqP7SqLIIhfqwDlr
         6vPb9n6RIcTgmtJpkBQg7IEG9P6WOJmGM7+PNAeHNt4oF7QxsLHWmS+K94A89zbSR6rN
         odzUiHuZ13rZS+NamdUsTOlZ43dHPSCqZt+BAiwiaHWB8J1dKKlcs32sNQGCqZgtoOm1
         ZtQ/yIhlEBxU4bBPumxDFrSjUG8zCAGWdwdVjw2dvU9m1CoCk40U8Bb9mgE3df8Usupm
         KHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUpx1k5HegeoQaQvcvcRejAexWqPO2Apk2Mu+yU1cePltnJCqvWCkTVd9KBbzwE/UEp1YxFTrehtIk=@vger.kernel.org, AJvYcCXcEj/q+nDrMrd3uwToNFk+a4yn9N+TznxGKOTd20Py13iRdiYMFu9o2aGyqDp/w/LsvK1X6/sXc4+wgWwM@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuKjd/1gi34RTKzvSwyhZkYqDoyC5Z6cf1m1Hhp4L83f1f7Y2
	W/DFA7A4OhgW7lfCDxUqGSX7ppR8wBh7+pLCU62uCulHIQxQqkJE
X-Gm-Gg: ASbGncsWIhAzn3ZCO/qQVmdB7rZMWPzbT3uGTlrvx8NxyvPWHoCE/QeHT9i6ognCP4a
	vj6VjTwTYLzmOGLEDCMA8RcDdpzH6NqLSQZtL41D3BBUQY7pUHlP33hVJI+IhG6TC8X8ObVKTLC
	iupMaJ7X82fkT5lmc7AAk95o+84zHFRXVtQGKtwfeU/AZrPppwizyZDqIfCOEwt6PWq8JQS0sYE
	uyVxtcdWnYibAwmFdUpv3W3z0zQXs9Ofc2nhoNLkwy0CTA5w2M6hwhDEGzgshEv0bDBNUveqpSd
	4uVY
X-Google-Smtp-Source: AGHT+IE1zYI8PuupR4sKDtjUO4E3cXcIKM7pnT4a0a1zB8Xmv/SgO4Gfm24R5g3P5hi27Ujovik4+A==
X-Received: by 2002:a17:902:ccc8:b0:212:65b1:9415 with SMTP id d9443c01a7336-21501d58b1cmr178617315ad.52.1732903951330;
        Fri, 29 Nov 2024 10:12:31 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm3760595b3a.32.2024.11.29.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:12:30 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	corbet@lwn.net
Cc: geert@linux-m68k.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/4] lib min_heap: Improve min_heap safety, testing, and documentation
Date: Sat, 30 Nov 2024 02:12:18 +0800
Message-Id: <20241129181222.646855-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the min heap implementation by enhancing type safety with
container_of, reducing the attack vector by replacing test function
calls with inline variants, and adding a brief API introduction in
min_heap.h. It also includes author information in
Documentation/core-api/min_heap.rst.

Kuan-Wei Chiu (4):
  lib min_heap: Improve type safety in min_heap macros by using
    container_of
  lib/test_min_heap: Use inline min heap variants to reduce attack
    vector
  lib min_heap: Add brief introduction to Min Heap API
  Documentation/core-api: min_heap: Add author information

 Documentation/core-api/min_heap.rst |  2 +
 include/linux/min_heap.h            | 72 ++++++++++++++++++-----------
 lib/Kconfig.debug                   |  1 -
 lib/test_min_heap.c                 | 30 ++++++------
 4 files changed, 63 insertions(+), 42 deletions(-)

-- 
2.34.1


