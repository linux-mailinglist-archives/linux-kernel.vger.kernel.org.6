Return-Path: <linux-kernel+bounces-442419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AA9EDC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0FE18898C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5325364AE;
	Thu, 12 Dec 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZQPYGCPB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37318B03
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963533; cv=none; b=NfICjszwaAL9iniIJRXelGA/P+aYWkuA7j0R88p6CA/+ovf1rF55uBbEC11CMAz94bSN515fOn4SyWfkrWqrG5KgLItGsHQaaQ3B29mWUZ+wBvLd7b4VupA5UcmSe7WJxxefks6MLUPz6z4JKgf0V37gWgWfUGFhlIV7+atxYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963533; c=relaxed/simple;
	bh=D4wKzLL6P8kjio2DoNo6T3LLiJX47WeOUYHZv/B1uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9rSjSkzGbm7IGpxQ39COCGJUeh2QpuK/XqokunIE9BgXA5eACMMxXv/DrTC9FNVjtPn4yOTw9VUFkEPUKdW3qokXvsIPelPYP97SZ/SE/B9cW5+6vYrTC6uHrwjwwks/60I/pJEZ7QNU/XsQ1gXtTturIswZ2zjpBEiDJ8al8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZQPYGCPB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216728b1836so402675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963531; x=1734568331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8D6ygKlZnTqTfL4YWEBFZxFC5MoNr1XcjZ+M09PQhc=;
        b=ZQPYGCPBoxvFCCUqXwtUATpD2ZE5Fnq9gKIsBoOlyDyuGTGijm2XYpDMgoaOlejtHX
         G1Tv3i598PxbLDaFpIQllPCCNTjQXRFUnHn8Kj9kCaIwG0UVByNeI//mj6JnlLhRwmho
         Xxno8fw2kcbHhsktG7mlsoQyRFX+Fa3RCs2iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963531; x=1734568331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8D6ygKlZnTqTfL4YWEBFZxFC5MoNr1XcjZ+M09PQhc=;
        b=WMe25svCNKkgStsO3rNh7gDdKl3/NxDKv9iWb4KT/Ti0fD2FLqoJwKOa9K2uWr/nnJ
         /uM8KjgqJVtRzreCzwwzUzPvNGH1ss13i+hhpdAmKPiOPjB/Jln7B5v3xj7ZQ3PJ+gqp
         cjqM40v3ivr1/wg9lOe5nXl300jX0PNKDKPz5ND3UgtEo3OQ9ajjS+Vcd7p3H2DAGlX9
         3BGKmRAQIr7BYRLsz884auno4VeV3JROif79TCJCy9MeavjTjxC7V6csDwS1kP9a4SY8
         Y8j6YMFsM3XlmOtd4+8vjsFeAtOURE5HqjE32/dhQYMIOvswQEqqIQTxXnx2O12s1I2Q
         qHBg==
X-Forwarded-Encrypted: i=1; AJvYcCWnKue4IO5iRe8/bYapB+VMwp7ezy+Phy4vog2Vw3+KtwE+eZLLWgTKUVGWrkdEZoejyEkHoN26l91S1Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3wzze+ktGhHcupMj0TRS/TCdoebD1hQQCynB9pmgqou/UHiX
	wVDBnsp8fxsgrUpM4f7/bOoOxxx7Nv2tl8KQwVM4xqGEb4+jR65uolkmLBnqSKVdWGSMPWjEGu8
	=
X-Gm-Gg: ASbGncsCofCnLtagnbHtExvolMsji76ooyNWk0amtCAwstg/jDdxW//IGlP3w3LEqs+
	Z8QoxBejqmMK1mllRmjDEBr5SDVea3mNPvm1r2MLvZPv0R8DSpKpPMsw1QU4T48+zABl0Ra+nVT
	pscIGPeHBCSjh0GMSGJhMUBz5UA075peOMO7uRUJnj5gcE6AwC0oYQgvACdnnLCDusIxlDyrweg
	++TkRxNcy4uxiZjUHSiBZdlbj62J6/sEj2ya3jdrn0IxMg1CPHUvMY8euCg8kTSU3CdeQ9eJmo6
	Mog0/28j3oNjRO+wxKk=
X-Google-Smtp-Source: AGHT+IHkPbKs3MqtSv9QsOis9HgYSk80Xsrurh11pKn4Z3ghlcVU8XnfyIU14vl7WdQ/uQmhi+CZqw==
X-Received: by 2002:a17:902:d48c:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2178ae4c25dmr25271915ad.5.1733963531278;
        Wed, 11 Dec 2024 16:32:11 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2163724c42bsm70938605ad.174.2024.12.11.16.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:11 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Maxime Ripard <mripard@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/3] drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
Date: Wed, 11 Dec 2024 16:31:40 -0800
Message-ID: <20241212003201.2098123-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241212003201.2098123-1-briannorris@chromium.org>
References: <20241212003201.2098123-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit bebe94b53eb7 ("drivers: base: default KUNIT_* fragments to
KUNIT_ALL_TESTS"), it seems like we should default to KUNIT_ALL_TESTS.

This enables these platform_device tests for common configurations, such
as with:
  ./tools/testing/kunit/kunit.py run

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/base/test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 5c7fac80611c..2756870615cc 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -12,6 +12,7 @@ config TEST_ASYNC_DRIVER_PROBE
 config DM_KUNIT_TEST
 	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
-- 
2.47.0.338.g60cca15819-goog


