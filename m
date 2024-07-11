Return-Path: <linux-kernel+bounces-249786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E792EFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8666B20D22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35145187322;
	Thu, 11 Jul 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhr8/eB8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392917C23A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726660; cv=none; b=H182WEEQ9g7yXad7mm6PhoODBMUh3+yQiwbRVIla4Z/IOe69cUdP8W0wSKgnnYYSo09jGRkxHMmQ1ksAjeSVbEtcyjJZbrOyFtvGuqP5ZT8dfOaSkiqPkzwR3gmXBFFxyZ5UJUA2S/PryeTDRqKzxSLxzDksv3NU8JohRKU7kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726660; c=relaxed/simple;
	bh=IT6Quss8qGzn5EGUoOLEBspCO6vRpnOKFMFcjESA974=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UcwhiKO1QPcu2n8uA86alNyWTfaZ3Utu2UKIG6ZfkVWUCcodn6h5z1+bLCWI/nCE3Fai6psPUtHeWvZ0eUlklySUiUwGXZFy9xgfeQUoNF/Y4UjerRhDykrVqWFR+LbqGQQjyfP+veclW1+5vHOPVoJxZVGQGYtvZRIHQ59GirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhr8/eB8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6522c6e5ed9so24627527b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726658; x=1721331458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=STOOzVEt+vbX1CvvmSVwRNox61LAyACU/ArHQQ0k6yQ=;
        b=vhr8/eB8zHfWPsp0qoXKvgL9x9bNBQvrTlVoOXQLRkXuI2W5HvQ1bqU2dlFyNzTjeB
         1Y972nWhJoZ+szJgDtp1R31vIJZc4ZEk/D3lWyLIEIAAmTL2ltBQTSgwYTPsFa3gJqqz
         +h/mItF3E4CZdZm+SXWfIIy4ApPm6PxJc1tCkYgDCFzSylD2B2M8O9ozuSo+UCkvznxQ
         1GRWxtlLxG7r5e5ZIVsYhzmJz42y5whbYtGF8UPRQJ5kNHwzZDHgbReVBlPzPXyO1r3m
         cpgcm8naHGVFM/Zt33sulJcBPnUQsT53AeFiB6Ac276xPWB7aa6H2AXfZ8vE7cTVJIpi
         YBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726658; x=1721331458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STOOzVEt+vbX1CvvmSVwRNox61LAyACU/ArHQQ0k6yQ=;
        b=anI38b4Mt0xCBNkbQVSrWb0T/p3Q9PvRgDRZoEEDragbN0xymbMKwOMwkGlGlRfP+I
         gF5+s8JIpHXQ4G/0BYD/6cMuTEYbTj57bB1Wz7ypJcpO9VxjJTiWjXARg8FTeuQFcF0y
         6zgEu4OeHlogPI7+vQ57391ocyeQqnErmI6nDbvXVicmAeJicnvTDqkPt+LhbIbaaQ3f
         YB4lh4t92WC7Agg5pBN6DUGKohmS+rBL79AWAvLl7yxlZ0+2Vy61Z/vBrKTAiPqOOaGB
         ACofmR9Q66/3vuiPqnfB9vUsX44h8pFOT5pcdN+af8FRP8q0EoAUrwbyXEiMX9TW0Oco
         VMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXmeQvl3IBpf4xPwDAzlUFLj36u7NyRmQxzjzQapKZQJbl82AKNINr9lkuOxIwEqi34IKpXwKeWkF6cckmxxtkNfUNIF8h7EDBgpjbw
X-Gm-Message-State: AOJu0YzEt7XPaaxxVSGmeDvpLcsjl+FNq9R3kFM6RqwyHTjyvL8nl3bB
	JBQ1vg3sdgtH5JW1tDwoJbbjSvriRuRixGe87GrfeqLHW7BDxeWznNo8MVno53Qlsx38pVoNh1E
	43/0JBFhLgegofBMs7g==
X-Google-Smtp-Source: AGHT+IFO1LV5PwXv1wT/w3Qyf/9BTMINc7q1X7z8bt0HbJrgdwlCnB1nmPP2jDJViXtB7+SXZ5FteJt4IIeR+dMF
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:690c:380e:b0:62d:a29:537e with SMTP
 id 00721157ae682-658ef53b41dmr2192867b3.4.1720726658069; Thu, 11 Jul 2024
 12:37:38 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:37:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193729.108720-1-ericchancf@google.com>
Subject: [PATCH v2 0/3] kunit: Improve the readability and functionality of macro
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series let kunit macro more neat and clear.
Fix comment and rename the macro.
Also introduce new type of assertion marco for functionality.
This is a follow-up to [0](v1).

v1 -> v2: [PATCH 2/3] changed KUNIT_ASSERT to KUNIT_FAIL_AND_ABORT 
[0] https://lore.kernel.org/lkml/20240710170448.1399967-1-ericchancf@google.com/

Eric Chan (3):
  kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
  kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_FAIL_AND_ABORT for
    readability
  kunit: Introduce KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros

 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 71 ++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

-- 
2.45.2.993.g49e7a77208-goog

