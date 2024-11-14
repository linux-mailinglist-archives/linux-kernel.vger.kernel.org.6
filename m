Return-Path: <linux-kernel+bounces-409085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D326B9C8766
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F43D1F2243D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089761FA843;
	Thu, 14 Nov 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="AWWj5aZ3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF441FA851
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579251; cv=none; b=RhC38sj9OwL9NAgNY3hiX55SYazc2WESjaewn3GcGhjw0w7SMLao6o/BdUYtRDIr+7uvrF7HUTdWC3o7vlHAbNf/CNPIC7ssyVGgFozK1lFdw8qPjY0MePXpVPH/N+KZCF8TlvkOrkfbiWaw6O7qs62CS1qsGnq1c6BplEUQ8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579251; c=relaxed/simple;
	bh=dSbGdJiwEUXi9Xh8lFCFXoUamTfSFyRitw6uOIF/1bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqB/+VagBeIMhA2hixS57PNDieIIXtS0prF6M3SdXOpq4g2Mo+3PiZ+qxEA6HcdD5ENlPPdkFNPD8deT7QoFTjMmb6NQm7nhu//Thw/yGWmHVf/csgVmi0+PcOOq0ur/0SjD/cQUMQRwuGOjx6MaB/Ypmv+RGiSShIOJwsHYp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=AWWj5aZ3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf7b574b33so337874a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731579247; x=1732184047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qh66guiP2+W3P90czCrP0Yd6mEtiZrUEyp6TeAFrGw=;
        b=AWWj5aZ3XQ2FN1YnaZTl9bozWLTRQ+cpkU9vPcSQlWfaAobR/lHQxyWTfh4x9NvUUF
         YjxQWvo+P8NtLwtNLCH6N+ZiRJmRUicpnK9B+1Y/TUAvJdEkMN36HFQgYrXQ7xhBTcDs
         hXbgXUfOKmTREzPZJj62nuf7nuVyYCuZ0mGg5Cbk746zoV6H6WZIzJlmZP13GAKSzvF5
         lTqRMvk1Zjebs6lm9byxFdTYP1E4F4dW1cu+ZsrXeNOGO1mJKVUeZjLsJr/P9ehvMebh
         Luv0izz7Np8vhKvMNPBPRZm20XXCbOwmsBu9FIg7+UbTNeYXTam8nVrPcryXudnq/J/S
         Eqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579247; x=1732184047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qh66guiP2+W3P90czCrP0Yd6mEtiZrUEyp6TeAFrGw=;
        b=bc+dM5BR6u+mygjSlNb7Pot/yrj/1Rj2JMoxbzGP0qO1UAf2asEdNU4RFbtTZBhgtN
         JbtBBJlUMAe8EQ2zneQO2GtMViyFaLYPO/WjoYJCd6Et6s0TjMkM6Hs8204I29viBkWk
         kDQVikqcBfGTA26l3qKwTsZ6a8MiRXW9RsnxsqD2kK+GOBgnXtkrtgBv25OSUgHbytAK
         Ln8+ZGbQrxKh9ZCsvggTRX990grm1Y3579uKJX1BtMpCLrbtmT7E4nFSZlJ1Rdfe9+nv
         3nMRHlj/XeDd4E+MxBa4sxD0pMHNWl8wDR8mYP7QiURr8yo+fOmU6KOp7mSmRfi3yEd+
         RcMg==
X-Forwarded-Encrypted: i=1; AJvYcCVq55WW1PJghcqRPmvXFE1X4DU0di72dsXw7n4xBvCr6i7w3eCVgMhaVIXD3W8Y5ILT28zVKfpEDZVaYR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjBcK0bpJ5sjxNSGvFXfKBXqds8FzJokvvJDRjlkA+SaZWP5a
	TMVRjjE+z4x+uOPHHZMsWTWz7UXPncp8ZNA3msA79Iem7FrmpacUXlRDkGJ8x/Q=
X-Google-Smtp-Source: AGHT+IGZ/bENGR3clUJzDy0XRQAhCZWJWR4K6HaxgiagGJjeiHFnxDuWeBfoKGVW3yIbUgd6POVG7w==
X-Received: by 2002:a17:906:4944:b0:aa2:c98:a078 with SMTP id a640c23a62f3a-aa20c98a0e9mr122886566b.57.1731579247440;
        Thu, 14 Nov 2024 02:14:07 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm46139066b.35.2024.11.14.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:14:05 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
Date: Thu, 14 Nov 2024 11:14:02 +0100
Message-ID: <20241114101402.156397-2-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114101402.156397-1-philipp.reisner@linbit.com>
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compiler.h defines __must_be_array() and __must_be_cstr() and both
expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
So far compiler.h lacks to include build_bug.h.

Fix compiler.h by including build_bug.h. With that compiler.h and
build_bug.h depend on each other.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..2d75e4892316 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,7 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/build_bug.h>    /* for BUILD_BUG_ON_ZERO() */
 
 #ifndef __ASSEMBLY__
 
-- 
2.47.0


