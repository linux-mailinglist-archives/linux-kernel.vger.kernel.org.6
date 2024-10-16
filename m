Return-Path: <linux-kernel+bounces-368100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FC9A0B30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B0D1C21A81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAF2076C7;
	Wed, 16 Oct 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu9qdpfE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729901E531;
	Wed, 16 Oct 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084637; cv=none; b=TnE9g6n4tQ3zY3i1Oi/T1e4cmlY2+Ps+zo5uVcB/R06ydOGPBFpiBPkJm/wSEVxAYvENEDZHr29D5fSmLwtC1koqhAq3AlW5dfuREhMBPHZB7CuL3CfV7avfffEeN6GXTHF43q6uybaPJnarCMTPdhGd/y5tSXo3VVgplG7MSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084637; c=relaxed/simple;
	bh=MiFNYGa03TMX/greiqrSbpJSzn/s/pXxkhHTNHM2m8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHQ+vruy0evJt6WlX978l1059JdVeiF163UmYHqpT4WAUdvrOS86owwljMQdriopb2n2bSw/GUTOdMgBeP+VWokzW+QiwkeGq8a4aj+vQzmSH46FBRLUtMIgjFgEXiym6P9FiPnlux3IWd1YhcCVSogvUyuYCqv1JrfkRnnRAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu9qdpfE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e7e73740so3563891e87.3;
        Wed, 16 Oct 2024 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084633; x=1729689433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odeLQxQfk7QzT/fVHpJdy7CnXL/SLaCfPU2fty6lRDo=;
        b=Gu9qdpfEbDCeBs+m/ryzxzaJyH3Nx125t7+3uDK7rCv51xd7dVjzSgvyQ0kY45rw3A
         XOgVYIawCGKV5ONngu53reflqP+DtQgGiCTRrbOa1/yJU50vo/hP32yY5wh1r1OUvBc+
         VyX25jUKjKGoJaWwR+N8h7bZxAHHWkNPOdIPZye7TCNwOn+oibO9UrXhP+IIXUQwnAnG
         4g5bbGtNePvraktSEIe3WzSHdS8i/IHgeJJGvPrSzmTYlNNgVmas6ZwUUTDMhTHEf6sM
         /SF+A/ifBUePzpVhkY78TRIYs5mQwiHLWHYhP4fbHdJC8FPQWPpsr2XgDcM3aE/+HtQh
         iKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084633; x=1729689433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odeLQxQfk7QzT/fVHpJdy7CnXL/SLaCfPU2fty6lRDo=;
        b=FHMexObD0Crr6CdmGZyCE004PGjXcz39WjFQ4xXa5QXT981TfzlEqxA8q0qnpjPOqJ
         qtxM+eVo4SkyVKPTdEb4kVTzc9WRdh+B8wGj08rIhje38kbwmrVB+eqhH1AzNlCFHXEZ
         QsOoTpV62CeMEQHXoAOHAhEzeHpsgysrAq7A63BDSDYFGVT22HYJYDR8tDZINnV3NV0C
         77WVs9prceUmBFB3YMv15FOe2EGYn2rqTiGjxCStQChTO+5zDePyVtD/WbTHkQCpVjLM
         cmvXwvRVGDHRkvkdvuyskAe5pK1mYRFvQdKcTIPbEjIN2usNF2Eef/31iPF20kOtl49S
         KVBA==
X-Forwarded-Encrypted: i=1; AJvYcCU8qjsyJ2XiVHd2yV5gt2+RirQgSeX9ZrsgYSiVozzMEiRdmaGhLKl7NMK5g4KaYPjJp8+tkRNbr3g=@vger.kernel.org, AJvYcCUq8pXJHEc4XgOIKwZg8iwpmHJeLbUwgsuDDCve0HXvIQ3INldNTEQkNcZRtu6vvJGMFhvJPZcfpzIRO2Y/@vger.kernel.org, AJvYcCW3pnQGZ59oDi9J4FveuFKh3IUUFH+6+u5XUG1sklKgNmkxdgiLFPwMxPoAkElfYAB5NWtlWFGOkl7B@vger.kernel.org
X-Gm-Message-State: AOJu0YwgisM0/EgEqXzNqWSAb213zqPH7Wf5XNMY95CsKnRUzuG38U9b
	wzanWFk9QT3ispmw+bfKSdt1cDKRt4/3pozuIHEXFUgJxcg9PkHw
X-Google-Smtp-Source: AGHT+IHbAwDtQQ/CePOTLFY1DTPJVEhyXlGJ0iT/Vy6GEFP6uk0rDiPXmfCHhYye2Su8f2pzIuZ2ww==
X-Received: by 2002:a05:6512:1090:b0:539:e651:5d97 with SMTP id 2adb3069b0e04-539e6515f25mr7976274e87.50.1729084633262;
        Wed, 16 Oct 2024 06:17:13 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698aesm49612825e9.11.2024.10.16.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:17:12 -0700 (PDT)
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
Subject: [PATCH v4 0/3] kasan: migrate the last module test to kunit
Date: Wed, 16 Oct 2024 18:17:59 +0500
Message-Id: <20241016131802.3115788-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
References: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
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

Changes v3 -> v4:
- moved checks from do_strncpy_from_user to strncpy_from_user
  due to "call to __check_object_size() with UACCESS enabled" warning,
  during the kernel build.

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


