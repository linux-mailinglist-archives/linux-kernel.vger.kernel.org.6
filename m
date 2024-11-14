Return-Path: <linux-kernel+bounces-409606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1C9C8F31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF6E28307E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC62150997;
	Thu, 14 Nov 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlECpmlo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1341C65
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600473; cv=none; b=j4YKDV8E61bDQnVEbYBsdgQj9RnHwd5TFh6EhFMC1dkfvGgj7cIu9XnqPO5W/Q+ypenGaPuv26TLgQwlLx6Fgy7x9J2gSrOrCJibMsk1bysLbWUkOITz+/L3ZaQXLxVVIzzXq4a7673+DZGld5du2yfSknoL2akn0Tg98X+rkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600473; c=relaxed/simple;
	bh=LaIas9FSnGgWYVjxyQw6wf0CKP1JRSq0bfjicuu8DW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdgED3sfk37dyniFxSNWdKFY0+SydwvWYxXLrYjmG/j5YhFMZAXeO3vZiJ4h4hqBt4lGWW1GQvWBCra1AKI07Vqgg2GSiiHeJoYGoisWh+BAniYDI507Pb7gALksyuPykaclBWzPOl47w6hUuX3fjboX09nULUKrt8GA0bPiUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlECpmlo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so1233466e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731600469; x=1732205269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcWPxoJGK5ekQBUtJfy6k9Gqm5y5BvssQlwASAQE/eI=;
        b=SlECpmlosLan42iy8OJJecMC5uhNoBE8MdCkIjwWkheU1gypXox/EFJfSzuq2v1Jx0
         dZ0iZpWU5Q/pV4F/6ci6m5xmH3mhP53jSo3ljEYRdNz661pk+sbjzJbTIbG1fMwOAFBv
         KP84k/WqILX9CcJqVen/56mn9xgDOdSmhw29mzV1FrDzMUrqNsJ0LBKYJ5RoZv9dC1lS
         pl+9Aal8Pg6WhrfCS9uxZkI5y9fexoCjuGe5A+tWWJjRP2dcNvPhHbFKMskM4KPrKazL
         VpWJ7L1IOc5x/apAmuAUF2gW7iZORVcAMtttVVCCLBv/UFdDiDtYD6wGjvKRtjPeKUNK
         YOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600469; x=1732205269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcWPxoJGK5ekQBUtJfy6k9Gqm5y5BvssQlwASAQE/eI=;
        b=OC6+B1IbXeBPtYOV8KJr8y7PhueUIg0Zxv3U0qpaB5klnMOMlXZ95sPrAq6m7RRfRy
         5QG8vsOAmtKf5zqHO+eWxLRXVP+zzyeyUCmK/FXv9/iMy6yHcpqTCeiUxo5S8egxgnuW
         9EdJzrd43KuaTsdpkymbXZHb3P61lWO1HUkGoI54hLIVF7+7+RjDBEMVUXTGmkxXInBP
         xZFWjhBb0uVDge34+uexqgsFWDWezSIGVT4J/Npln6G7IA5+2JxowWhZqJOpfG28LsB5
         eMzR2pSZZ2PRgkC1ASN55T5A1aLyYS+QMyjX3lXqiYByyjRL76SfztUd7y5blU81VXQj
         YlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWas/dqK13G4rkSmvytfkSb0Z+Tppwfcr/Xf2uhyosvP3BV4nsOLufN/Gdid7tRLzzNrH8uwS5pbJv1yRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznY7YlSTDeVqSlxZlhAma9cWgBmo82LEOgpvOKCk/DRA4Y4L7O
	l/AWWO3lvutJKmyPhBiBPR/J2AWZZPzukP586xSKdMr/xKmdWPpYtgpRlRtDMHU=
X-Google-Smtp-Source: AGHT+IHfVg9qbrSi/omD8dytmJcpkiNEK4jvQJsDZhyhdppyBpWQDWz4ozBdP6AaTQUxqgZSxkmUhg==
X-Received: by 2002:a05:6512:3d0f:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53da5c863ecmr2468698e87.52.1731600469476;
        Thu, 14 Nov 2024 08:07:49 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046d76sm77456366b.165.2024.11.14.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:07:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	thomas.falcon@intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Thu, 14 Nov 2024 16:04:47 +0000
Message-Id: <20241114160450.295844-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [1] this isn't strictly required anymore, because the failures
due to opening extended type events on 'any' CPU are now skipped.

However, it does reduce quite a few spurious warnings from all the skips
so I think we should still include it.

Separated into two parts so that the first is backportable and the
second is a cleanup. Also if the first one is backported then it will
fix stable Perfs that might not get [1].

Applies on [1].

[1]: https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#t

James Clark (2):
  libperf: evlist: Fix --cpu argument on hybrid platform
  libperf: evlist: Keep evsel idx contiguous on removal

 tools/lib/perf/evlist.c            | 19 ++++++++++++--
 tools/lib/perf/tests/test-evlist.c | 41 ++++++++++++++++++++++++++++++
 tools/perf/builtin-record.c        | 18 +++----------
 3 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.34.1


