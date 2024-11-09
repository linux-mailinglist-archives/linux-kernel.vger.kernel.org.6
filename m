Return-Path: <linux-kernel+bounces-402540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7A9C28E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F8FB22FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F16770FD;
	Sat,  9 Nov 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7tVz3ya"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E745F4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112459; cv=none; b=hAPh7zj+Xi48oCR4gBN+P832p7RoLkyIoLAyKgFH5JY4gD9FMg+TI+I064jR/u+LzRjpR/El5ZqOGcphNdn9WNsSr6o6xyofBfuP4EO+BdvpaZGEQQRNQ2vEomfpISWkfoFjhspt6UPSLqQtLumMgMK0YTR+LLYJ01uLjZsBgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112459; c=relaxed/simple;
	bh=rmktKWgkJHRVy/ZdsAA0Vc65puJoSfAalv+s0diLDGY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OZobQqOAuS5RrM3k4wby6WBXDE0gOLBhG2GzICnftAqOQx5MRc2Nl/iwn4ncJ6KXdfsBxPraZsTYHbzRYV6yoEHoTzobmLLhzjElngabM39AimfKPpJlOSRQ2x+dvSkJ/SB4yuqrKaTNRM9Mg1ezV6NU//FN61xeR92Qf/fEMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7tVz3ya; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea9618de40so1048117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112456; x=1731717256; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=f7tVz3yare1UoZaHoZBUgaD1sK1DSYsitmHawjYBmR9TA9WRztxdWari9gJpNq6ayo
         swQM/7KJngsn+4j0g0n57OOSpgxZbE3Q0arof9dMc2yVNVOIMxE+0Chrnl07ne6O67tu
         TQcPooOiz47LFajlsPcSmXIQ+RAIwiBCljoJ3+2n6iz+GyZy7g6zddlWFCRxFu4pebxI
         ilmBWAN4uAgeRbsi3YJmH5kJ/xYtVE8yDdn7G1+a5liznZxiinRcG+QwgwQWxtC4MkyH
         U1H5b2NBstbJk4cb56XGak5u7/Sp9DxgYX7aQFlSaHBsO/0cxW/EezGHpkFO/hJ0mZoJ
         qgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112456; x=1731717256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyKZnJ2eVHPv4loZARCzHZhQlUS4zb1Fka2wyOZYXs=;
        b=DHCr26Vxz9dfU8gOcSINBqQlKtOTSxBY461yoQYfKEwSi6mWj0TPw6+hVRJMUjVC+o
         yHyxG28PTXlruBxYYYWPvXALFiZf4T4X04AcWYOb6DGTmyMd4friIfgXNDS0E/BIlbtx
         kbKeoCam+MUQD0/7jqgDdkm0OUpgjEU//clYVbaedZz/V/0LMKzd5WyHcA6SbAB4fEHE
         57ogAqrw3jaTlO37I7Z0xJFM2LXIymjOF4I94xaSzoT1BZCb0fdVEUoIK5zJDhLjRJio
         vvUIsBoDs28JsIkY3Zx6m7fmJfp92c7b+7zC0Bs70MMisQ+MT1zT0QJxjQLeBnbaL2ZL
         cwNw==
X-Forwarded-Encrypted: i=1; AJvYcCVLLG3f1YcIF0b3UMbIxyukRuNP9X5/2MPpV5N4Twbxgo5sEKoYBTn/NwpSpMqj+K6RHENL4F5nP4+oHxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63P1UWt5T1fntQKPT85GwLUQjkXtuKKfikdwVdBlPU0Rqh8+J
	oQk82cUUS/4bzKKWwEVKeYsWK1YGwGxAyzkZ4XsM006SSvmz9A1JXULS3MCji00KlLaV53gdBI6
	foscjwQ==
X-Google-Smtp-Source: AGHT+IEAozEkum9vfb7cCfMy5i2k3+qV284laW+Ph1hIOrUoIrhhbk39KCwWH20rVje+aP2dq/6XwEnknlkA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:bfc5:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e337f8c911dmr10786276.5.1731112456718; Fri, 08 Nov 2024 16:34:16
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:58 -0800
In-Reply-To: <20241109003358.461437-1-irogers@google.com>
Message-Id: <20241109003358.461437-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003358.461437-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 7/7] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.47.0.277.g8800431eea-goog


