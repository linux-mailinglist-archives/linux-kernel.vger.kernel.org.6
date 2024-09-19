Return-Path: <linux-kernel+bounces-333034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5D97C275
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C81C215B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B312E48;
	Thu, 19 Sep 2024 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FX06LFe5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225EB673
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709736; cv=none; b=EiaaBWVGmUdR+SFythmCbIfS5iq235A15Z9dBWRHGnU+A9Z5zmsRkfXMXOUQAEzICx6xI0jjV3FaFfODbZutW7zOsmLV3KXitzpCFXjGxJMbmGamr3qEmJTVVTXm18f+VHxnHj07ji+JUE/mUJK/b9FDluMQ8a5AgwbuFPbQJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709736; c=relaxed/simple;
	bh=+BfpS3KEqyEFGD4EVRK0cm8e+bH48T32ouVTTydTMQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eK3wKFxXGVZQldfEuWntk3BVl1AvPNS/Gfdxrb8WI+MW/rtfQtgmSc1uwT3BxaFYfXA8i/ODFNxrcXR4tYs6+yjRKPvHoIY31Y4Q4rkrAyr17Vn2wjxeknTYpVL5pxBODOnn6bm4zI/p/soWpG/5nnkxHqheD7kUP4lm7P4Bilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FX06LFe5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso222274a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726709734; x=1727314534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r1e3S9pWTm/lEVJSPmr9Y58STRzRcLqR0sL+KSgVD4Q=;
        b=FX06LFe57QP1po872zLLPVt84oVA1axhqFaN0ukg53GnVvdDGZMLhZSt0CseIZKnMR
         4sq2QjClBqXGadJl4l7tcrWCZg7iLByQxlEcY4bI73lhPukOzl7+SQQBzQLZdin77Q9K
         1hm53XDsj+qrxVpRTaBXYbqQvvIJQKR0FORuUjyubaB1O3gGJ3nP4qgdoC3AHEGsB+Et
         Bz4R6Or+PLshab2aNvuXchRw6Ecsug1aDhFk9Mkq4DUZ5+Zrm4c8tKr5kJsi+gcC4THZ
         WkV1YEyK9RXXlnhBPSqNebWog/g8Hq6AE9TtXviW692zg+c1ZUoCSkWbITe0CRsnXVDY
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709734; x=1727314534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1e3S9pWTm/lEVJSPmr9Y58STRzRcLqR0sL+KSgVD4Q=;
        b=eC9757CJ46xtGDtDknMnGzAI9Mb8FrBUGfATKmFYQ1VqiwuArj1p+/52ySLrd4o8We
         y4R4H/MuOj3njq5UdU/2IFkzrkhWiEhPdveqCxCE5WxDvjR9VfuvQnlWKc8GjRaDZffQ
         sseVhO228qBZhcwiXNzWK+9nXDOXh1ZJYYl9dGueJKOO/GKwTtWQFL+MFGM5RKQprhhC
         VLObKvYiHvqPo2i2tOUjrA4kKag0ra+kZmOjtoqpPHbCGvIV4NRejvL6KDtaZjnG7AFT
         Iduj2GOun2hUCtnPGs7emgSFUpcssyv6uVZhyC8vbo7Qr6Yvk7NMiEBeCg1SYwZaGGlQ
         rIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc7Zt7t9id1gNfkLwTIONUjgLWrjajrQxYN7Ni1x5mEGfTTugYhERek0ws9umXFGSPOhXUuKf/MgViaBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpO6+vH+M9M0hoUnjZtEfvhd/nx03c/MMvmAZRcWTu9tOv5EJC
	3AiDNu88WHcZQZTmZtocWa9Q+il290FVJKMvgmO8btAoxgEjbWcY3MoqszIWx7YBd9Uq6aD/A9h
	4
X-Google-Smtp-Source: AGHT+IHQSQLaTaoG8epxHCgtggUQaJH8zELCvKB6tmSjd6xX6jo/pz1O8xhjQg3WkdHnuLbwgbf0Eg==
X-Received: by 2002:a05:6a21:164a:b0:1cf:3461:2970 with SMTP id adf61e73a8af0-1d112eaaf50mr32036486637.41.1726709734103;
        Wed, 18 Sep 2024 18:35:34 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc9ed9sm7282482b3a.209.2024.09.18.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:35:33 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Cc: yangjihong@bytedance.com
Subject: [PATCH RESEND v3 0/3] perf: build: Minor fixes for build failures
Date: Thu, 19 Sep 2024 09:35:10 +0800
Message-Id: <20240919013513.118527-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 - Add reviewed-by tag from Leo. (see Link[1])
 - Resend the patchset with no code changes.

Link[1]: https://lore.kernel.org/all/b5688d4a-9389-4998-8031-3f002302311e@arm.com/

Changes since v2:
 - patch1: change LIBDW_VERSION to follow up the style of
   LIBTRACEEVENT_VERSION. (by Leo's suggestion)
 - patch2: Use a new line for the -ldl dependency and with comment,
   synchronize tools/perf/Makefile.config. (by Leo's suggestion)
 - patch3: include header files in alphabetical order,
   add reviewed-by tag from Leo. (by Leo's suggestion)

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 5 ++++-
 tools/perf/Makefile.config   | 7 +++++--
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1


