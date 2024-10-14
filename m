Return-Path: <linux-kernel+bounces-363106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98099BDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBA0281FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69304481D1;
	Mon, 14 Oct 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZWF07uP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDA211C;
	Mon, 14 Oct 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728874564; cv=none; b=njJMVaLIvgJFSvoY+Ap/E6DCLvDvIWCcBEsPIpjJRS3PpZLEOs1jWelivWRJI/hOQKPlI2U9M6NZA6NgEBFqgXU9ABrTtKuD584lDARcKXlpaJwVPMUtalTXMV1l7quPd2vb2zoV90exf9SPgqrCcLaQA30I6ouUo1rjqbe15o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728874564; c=relaxed/simple;
	bh=+jad3wDIVxZ5ZkSppTDF0WTXDCY46VjinDCM4p5MDDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUSKxWgga8toz0t8kZ++kJyP8S1KZ6qSOu1VhI0Wtz0vulBz/b0fdZIubaU0jkf4cRleg6njsBpSgddpK9O+XCfSmubGLX045LvJKk0dfVaIEB6T5n+LhJGuZOplO/iIJRjeJf3N8RKv1U0UbpuPoAPxpBtITvRdddXODKof/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZWF07uP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9932aa108cso572082966b.2;
        Sun, 13 Oct 2024 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728874561; x=1729479361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7Dhocqjb276k2G2J0MeGRjVha2Bmm+qWInnAWrlt1Q=;
        b=DZWF07uPeWVcH2O9i6N9Duxn8buhBslBs7TwgY8rZIaLd5wNBh3rC5fd+0ym5i6Wsq
         BfGgLQAmW/Dh/ojqhhZe90MnERkQRxYEcq44f+SlRt8KnD3hKNCsyKi4/dN7ekmw0xsu
         EXudRr6Apmh2QoBVh5l4YM12cLyuM6jjWzFcoxXkazFQudWc+d3iPU/LCFO+DC8/jPhs
         OWbazubxHJFYgKQrklFaLk8CCynW6f+1OVzB7IZnWTH80XX2mmFkj5+rhNHIM2xdeuvZ
         YaigM6fPzlk+vNbaKr4w9thpQcyrY5GmTZx9Zg8XG5s7CV3bBno0vmAwkGFYwstDfZA3
         pJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728874561; x=1729479361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7Dhocqjb276k2G2J0MeGRjVha2Bmm+qWInnAWrlt1Q=;
        b=aiJU3+m0f7CDjMd13xkA7JrPjlFKVxQdB0W/SEd0q8xCtK+HEb2rWYeQRORTCAEqC8
         3IirvVOT1GsjB6Wel3Le0F6DkXxAf6jeEzcsENphEmTb7CcoYCzd4TgB+dVK8oiUSTFx
         e4vop5rFZXlkWwcEB5WsBva8eOUANvcp0yzOxTsMGjoOrov9+IWzqZb7qeI6mxdVgfJE
         yyIF8T1nJVLCblniVJUAVWdaquEeMWbeFTl3SkSu3X9p4A7j1KXB20OxQuX8sdsyiqfZ
         b67Ii5d6g9ATHKRlYJcLHt+UVrXNdTO2bXk8T4QPyaJ5isDr/stT9E0Vp2YXjgVq6Kr3
         ouHw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9AwGF+/2O67U9mlsh0uHlIC6OTf86jMLB6LDndTD54clSL76Qsk74VzU5l8kET43xzQmjOuXFDzv@vger.kernel.org, AJvYcCUVzQ+p/IybgtzUwN5aOQiv8/LoGQNeQXewIriocVow+o5gTuQUeaKTCCqpJ+ms89u3Yw/qx+MvwOqOPGqw@vger.kernel.org, AJvYcCWBMiTp2rz1XADWoTiHMeEphUEFkhaWEajjpAPxFBDUELz4TPBT9G+M7QqKGyu15csD9/fdliJ7xHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKnoIZghaqYYMtq6xLC3OnVV8Rytny9bWTE01mDg7DfdoXJ5E
	AON8oznCbLgFzO8/NhBJTi/IUMY/537OzjeL7RKyCzRwpc459bOZ
X-Google-Smtp-Source: AGHT+IGE2RbCl116shOFEFRChGbBgS2YV7zDKqpNZIfMEb70LXwFCrg+DOxy37i0KpwC0h1ZeLHRgw==
X-Received: by 2002:a17:907:6d02:b0:a99:422a:dee5 with SMTP id a640c23a62f3a-a99b970d0a7mr852403666b.57.1728874561232;
        Sun, 13 Oct 2024 19:56:01 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ebdfbff1sm270501366b.39.2024.10.13.19.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 19:56:00 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: 2023002089@link.tyut.edu.cn,
	akpm@linux-foundation.org,
	alexs@kernel.org,
	corbet@lwn.net,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	siyanteng@loongson.cn,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	workflows@vger.kernel.org
Subject: [PATCH RESEND v3 0/3] kasan: migrate the last module test to kunit
Date: Mon, 14 Oct 2024 07:56:58 +0500
Message-Id: <20241014025701.3096253-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_user_test() is the last KUnit-incompatible test with
CONFIG_KASAN_MODULE_TEST requirement, which we are going to migrate to KUnit
framework and delete the former test and Kconfig as well.

In this patch series:

	- [1/3] move kasan_check_write() and check_object_size() to
		do_strncpy_from_user() to cover with KASAN checks with
		multiple conditions	in strncpy_from_user().

	- [2/3] migrated copy_user_test() to KUnit, where we can also test
		strncpy_from_user() due to [1/4].

		KUnits have been tested on:
		- x86_64 with CONFIG_KASAN_GENERIC. Passed
		- arm64 with CONFIG_KASAN_SW_TAGS. 1 fail. See [1]
		- arm64 with CONFIG_KASAN_HW_TAGS. 1 fail. See [1]
		[1] https://lore.kernel.org/linux-mm/CACzwLxj21h7nCcS2-KA_q7ybe+5pxH0uCDwu64q_9pPsydneWQ@mail.gmail.com/

	- [3/3] delete CONFIG_KASAN_MODULE_TEST and documentation occurrences.

Changes v2 -> v3:
- added in [1/3] Reviewed-by: Andrey Konovalov.
- added a long string in usermem for strncpy_from_user. Suggested by Andrey.
- applied Andrey's patch to modify further kasan.rst.

Changes v1 -> v2:
- moved the sanitization to do_strncpy_from_user and as the separate commit
per Andrey's review.
- deleted corresponding entries of kasan_test_module.o in Makefile
- deleted CONFIG_KASAN_MODULE_TEST at all with the documentation in separate
  commit.
- added Documentation maintainers in CC.

Sabyrzhan Tasbolatov (3):
  kasan: move checks to do_strncpy_from_user
  kasan: migrate copy_user_test to kunit
  kasan: delete CONFIG_KASAN_MODULE_TEST

 Documentation/dev-tools/kasan.rst             |  9 +--
 .../translations/zh_CN/dev-tools/kasan.rst    |  6 +-
 .../translations/zh_TW/dev-tools/kasan.rst    |  6 +-
 lib/Kconfig.kasan                             |  7 --
 lib/strncpy_from_user.c                       |  5 +-
 mm/kasan/Makefile                             |  2 -
 mm/kasan/kasan.h                              |  2 +-
 mm/kasan/kasan_test_c.c                       | 39 +++++++++
 mm/kasan/kasan_test_module.c                  | 81 -------------------
 mm/kasan/report.c                             |  2 +-
 10 files changed, 48 insertions(+), 111 deletions(-)
 delete mode 100644 mm/kasan/kasan_test_module.c

-- 
2.34.1


