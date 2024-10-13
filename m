Return-Path: <linux-kernel+bounces-362803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA699B974
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947C4B211E0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24321EB44;
	Sun, 13 Oct 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNkPFXxT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733A33DF;
	Sun, 13 Oct 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824482; cv=none; b=RmN7Io0aStc9c5k5jA6My6cFiHybSt5LmdNOz/YYZx0LaMZvDS4RSvLGv6zFQ1Sau/M3mPGqqOuoj6McbiF4f5T1vmuyi6GYzgVvMO/vaB9spHaMSlbaRMam1imxCIYvZN3tn+zEwkKVzlbNzLS2zbN3pizexWw/Hcm9QFAet5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824482; c=relaxed/simple;
	bh=w0SCvYmH0gix/VuAGbAzwqfCt4xQjLOxkiWD+XeYSjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAyYPTc4OzVMenP7J/uOkVN9Xsq2SHMcpG3gGua9Z6bz/MmnSNBruGSts+bavsr4hAWR+3M7pm2BpePa6UGbRkctRGgbNZULpl1e+mXhtDdPAzKyABTt+0r5EF/PWgtoVbkM0uaUPE2SAM2J5vDREL3leSqINy06H03ju5K5J+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNkPFXxT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9952ea05c5so533376366b.2;
        Sun, 13 Oct 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728824478; x=1729429278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnmJ9PN1MwOJi0VN46gDmOuqLJjC2HT4OQkYN0N47z8=;
        b=CNkPFXxTq21WgNEkZbZslrG2OoUGdCn+P3ffphD6q/yGFRRIbw/q5iU4/DyFc1qQBe
         Kw6dOjomawTxZ/hlAUNselpSgO6Uu8SQnmyPwmaAMeHQuYR4vgHdW1OGZxnD6TCU8KI1
         PVA16JAO3q5rQ/Amh9ilZsL/kv0z38jsejX+2FzOm9ksPZ843rc9MBiFQyoYtGsKs4Kt
         WtlxIJgWfvAPl6vLp5zPK9xDsAhWbbN84tR1d3zTRiA1hqaF3bhGKflBl2DjcTDU9oOe
         1dorgAmCIMRl/UsLe3P4ZD3OBx1EBZHNNIUJHdLoKk0kPUGVOU9Ii18n+Uv+aK83s/dw
         yrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824478; x=1729429278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnmJ9PN1MwOJi0VN46gDmOuqLJjC2HT4OQkYN0N47z8=;
        b=FBTFdaJoCI7zfPFM/9zeLz7yRDy354yWn82c7NgkEfgB3mpcXrCP42SPYPFiijwZ1T
         tdNPsDh3vYbobbHCFsWkW0u5ckm7DP3qVFx4DnPYnZCErB8F8IsRzzLGdHULood9+hQK
         hJlaqSm2WuhHBQW0Ru6IOxUoJ9gNcObAVqhfvf+iRd1hwbiHHfEhzvYqW5cwywgX30j4
         YU2NHfgXo3Ffl0ixNH0HEguQk1RjK/7Z38YFpqsesdW2kuosCOoMxycjVHBGY+4s7cQf
         qDVa+s+vFeYaCpWQnZCRTL3XGzAqrMtY3GSXtYRj4Vidg/oGjqf8VfS7kX0IvBfdX/CH
         VLrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDaz81VmhwGMDFbU6PAXqjorCoY3F/SU8n7sHTnu0CHRbKNMfCvgpihV+2tbDPgQx3ya3WwOZQigQfV+so@vger.kernel.org, AJvYcCUdYfkGJPULYNDmH4UhijxbRDXQ2VaLk7Et6f4kdHAeYKXXn/1ZzzIYIndbiyOesK9ZgxECczBevlg=@vger.kernel.org, AJvYcCWgB+D2aSlASnmHPwYpJ4y4mbgAtwd9tzXbH0LTTN/J3MjgTUiAUtVvAIyc8kyhHeKLGm1ujBq/GH9S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+m/aQjJ+VnjcR/vxU4pa8NRaGkpGbVBYAbBEB+MmC4jeB6EE
	8GCLPKVrW0tNgPGfUBPtJ0JgT3+s9eiUm0dYGzOOTr73Zd7JSHjR
X-Google-Smtp-Source: AGHT+IHXdVRsJajrbxhYVhpri5+mS+Hg+hbAd/CFrQh2ABK8/018Uy8GEmA0GGHi1h4YJtX3MXXJvQ==
X-Received: by 2002:a17:907:1c08:b0:a9a:b4e:b9eb with SMTP id a640c23a62f3a-a9a0b4ecbbamr74879866b.46.1728824477537;
        Sun, 13 Oct 2024 06:01:17 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0d9de967sm19209666b.139.2024.10.13.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:01:16 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	corbet@lwn.net,
	alexs@kernel.org,
	siyanteng@loongson.cn,
	2023002089@link.tyut.edu.cn,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] kasan: migrate the last module test to kunit
Date: Sun, 13 Oct 2024 18:02:08 +0500
Message-Id: <20241013130211.3067196-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
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


