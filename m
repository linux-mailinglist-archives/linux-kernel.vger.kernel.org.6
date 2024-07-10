Return-Path: <linux-kernel+bounces-247988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599C92D719
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338321F23E18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52312194C75;
	Wed, 10 Jul 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4JQkaJI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1181946DE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631112; cv=none; b=JNv5ldIBVCFCpkyEYHby3DW4zmr33GS+7oWLW3sbSks6hZJ/dVxyNTBFcXUgjhvhA+pTFz1aedAO5aTNq0UcsYK5l4o+DPvw5zKV8FraeMbacHGm8lA9cNVKA9bYeSCT0GhzgQj5l+gy/2Vm9M/zZjrr+xWgmsl/t7I1Gge5S7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631112; c=relaxed/simple;
	bh=IfcJkSc/LNwp9LlB29Us6vaIZxKEnh2p+SCln+tmuyI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DeT795pRUfMPm90G7MzVDmZRm22sQRrZP85hf+Ix2p1MCg+Ox2rwQXzieQySJF+d/4J+scrMnAHI7vtAwwyNm5sgdOPx/yWPzpDe0OEPRErhhuhy9xN1UWHtrOCyfe7akbJezEfeDxwqz5wC1exLBAyMCjYq9fwcvV+nk9DOszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4JQkaJI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a544b9c8so10484797276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631110; x=1721235910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cY/lfgDlHnS08Kow/zkoxri6JCWNBRfckkCZV0YNXKM=;
        b=f4JQkaJI1QFykHYnMu4RSuWXFH0ZKrwRm5cqvM84MzIIvDU/y95O2KwyCddGpuZdi7
         V61JUuMRXYgvfuXaQu+TNbfmW6XleovcKo95xlRVEbo/LGVW/NqTCcE+FeVfsVCTryeG
         H+BYIwgXOI+uDL8rYt6y79gDdVo/lOJPEb4cTda0DMtndZ91Zk+muUGD4hlgKABrdACE
         jCRavVfTmjzkJk6xuaPvEr0jdpPalI6e3bb4LWXutHdiee2XXmBtBO1+cznKo8Z4y+gE
         +yh9jDa1nnHJ1cBhc6R6oAj+ewNwGhYHqkbE9VDn+RLkqraJauKzo3v2VjKzgoIXrVSM
         fnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631110; x=1721235910;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cY/lfgDlHnS08Kow/zkoxri6JCWNBRfckkCZV0YNXKM=;
        b=SnBcTHWgxb9e//CmsICoiap7c0oIBKZpH7Czsu6yQz+t8E8h9F7ILcr9H4tFbDJ70I
         mTrY3h1WGbC2XoFBmo5S0h7cFe24HcIJLtJb51BhSwEqnnhbR9QmuDG52s6KwYzSvdNM
         KFeJKZOpy5xRW9T1EixU4YWwduNvex3DynoB57B3EUqSl/KgJsFsBbDVXMVTpRNZsPHf
         LA66YyKm4qlsXNpZMqRZBHJtYUFF+a3m2O+wFV0ORgOWmcl0baTHny+Cd42QEVDP6Gyj
         9zyJwx/3hPdXoAhHhSnwzyzGv4ni0xc9xq9vW16MnaN99B8LpyeHpKjmcrtXjEjWPddJ
         NoBw==
X-Forwarded-Encrypted: i=1; AJvYcCWmA3FpP+URmCG/gUI5W9SyAit0CCOSW7iPjAhd7vvdqgTog9EmPSXtFHaUnQCkzCjR6vEP6X1JcA8hCe+3lqdLv+//1OGbi/pM94Y6
X-Gm-Message-State: AOJu0YxoFneqCzcklDC916zrHb705wcji6LIz3r5phwvi47TEoAhoHmR
	U/DGE3A8+W3FQk5ti4remtM37EGbQBfUQZnD8s2fVqNlO4YNyb5kR9PbIMrBrUQSFLIjympIZmi
	TqXKmqbRc9xxhMSCcwA==
X-Google-Smtp-Source: AGHT+IGj8HtzaJx1AJHVLeKKYwrMAwK8N6nm3v4IK7iTRBO5uLo7bkOz+HhmrwwwdqMrcdtrCJ2Toe+er6l63gMY
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3c8c:e806 with
 SMTP id 3f1490d57ef6-e041b07159cmr15222276.7.1720631110325; Wed, 10 Jul 2024
 10:05:10 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:04:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710170448.1399967-1-ericchancf@google.com>
Subject: [PATCH 0/3] kunit: Improve the readability and functionality of macro.
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series let kunit macro more neat and clear.
Fix comment and rename the macro.
Also introduce new type of assertion marco for functionality.

Eric Chan (3):
  kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
  kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_ASSERT for readability
  kunit: Introduce KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros

 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 71 ++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

