Return-Path: <linux-kernel+bounces-441009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A99EC7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ABC2883A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05261E9B34;
	Wed, 11 Dec 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JETgEpM4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686C1C5CD7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907357; cv=none; b=klYOWz4eW8f8F+nCrrnyTXKJekKe25Lgwgb1xcP8hx1pGk1TkZOWqOCmtF2TCns162iQb8f0cj7OdY46vgHbtgUhNejIldzCnNlxZHmHzSeeUY1UEmYpPfpjk2rU5egtNmZuuUxPbJNtVsWpL/KIRiMKQ8HO2eYIq9a8l8irqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907357; c=relaxed/simple;
	bh=nB6qolEkW1OV7UB5hv4ubcEoCCGO7cmTbJXTfiskK0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSHqF1jtTXMhxATKDOeJ6Y22SoM21kBKwx0lzDeSPf5ZNHkCl+hePFDYVMSxCoHiTs/BLOQA1jchmBOvrWmM5ViRPwFsogDI/5M/ICpX9fWrQqeElCzc8jVrm7qvmT7X4uIiYhzv2tbGLxtWLtULbXgCm0eFKuVUP3CWa74lIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JETgEpM4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3262115f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907354; x=1734512154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNYFBgU80onPgPmOy3VgL9Wo04wi/d0lespX6ZHjY6o=;
        b=JETgEpM4f3P+ZR3L67fy9V8BDeD7tVvRgLm4MQ8PbyElRQtMALQzQyU8ORq5NWIXd3
         Gk3DVCAQHWs/yQaU9quDOymvvsQJQoxCy6exbg9xp9eS38AbXLcIDmmYyCTbwpBz0m7n
         qA3z+DMIr6Ic/43HiiPDy4fcRr9fxgQmHjdUo4Whf/4miIZSX0DGZVWe1Z1cHWPkX+kc
         3h396vSDAtgmBU7vM1tjhb7+MXxjj7c3JDdgHWpZHKEQCusk+XJ7TVollbWPjkvJMQM+
         twDzMD75w+6TIMc8QzAobG99/83ezzDyBUUhUhLN0PIEpgKdCfPZUOQr71VTUh7rFh1j
         OixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907354; x=1734512154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNYFBgU80onPgPmOy3VgL9Wo04wi/d0lespX6ZHjY6o=;
        b=Z6mSpBrep03hSUrR5XlQeZT8IT5JZdA/EheK6C+wbsmZN0QRThs4H2IiX6e52Miazt
         p/M5kkxirImLiqN1YYmGTn9rkl7VZFlgXydlnF488ZebNroF8b3VEgzG7otbdMDEkW9h
         th2tTw8XcN/4MJqDLzbLZdk3iqGcJzRIVKotcIxyHzlEK4mBXuCtL2jws4Ispj8VKivt
         HIBEkWJjwskkyQHbB8/PP03yxJo8kNwmwslfOCeEPtMzHUeDrXokHqJKFT34USxCfy4n
         f0EzjAb727KUzRH96Vxg0MRI4pfeleJRtSYvJZ9SR71ueWhlSBdCAUuJDOPgv7ebEcPW
         N/YA==
X-Forwarded-Encrypted: i=1; AJvYcCW9zO4Tk73bjZYtRkAp8ShX/VxygiJNhVMh53R4sMordSiQDk8cSFjb2YTd6jpvntPg1Sk8hJ2NBmXMpkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRmwZ5KyLyucORFrdpxfcFKhkIcoZ+YDC8GmeJQAMEgMMD0D/
	8oRAdeGTUHCilAwoRPeFY889TYR7Gg5J8JU3sbvgpY/dMHvmnv6yn2pGTbFldHc=
X-Gm-Gg: ASbGncsRUJkaOe8s/sRny1Q8XyXs6EtkWJa6U1mfNoUHaugV9spj16TOr57OsfpFxSy
	cgqZ7DWeJXmJGN165ntwqEjQkX5NnEEE0vtXMoOohA3m6Ts9jryjLOYJHW3MVtVjjFWKVNLYuYi
	a4Soqll70nmQptMIn92cu4GNjSzrg4j6L5z5AXtNZUUuYpZ2IcG8/SXQHoHltzGr+p1TKswmPul
	ZQJG1jeWdXXKZ9bCID02n+PByB4pmmCn12pW21bvm89mVik88IhnN4=
X-Google-Smtp-Source: AGHT+IHrmu2DR2E7aQ2oR0iKyyta3/WNVHfEmAFuLJs4FzC35Y1JlcrBeBL7pt9CkfFjARUp/NL0dA==
X-Received: by 2002:a5d:598b:0:b0:385:f560:7911 with SMTP id ffacd0b85a97d-3864ce4aeeemr1437480f8f.10.1733907353849;
        Wed, 11 Dec 2024 00:55:53 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm257204185e9.44.2024.12.11.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:55:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	mhiramat@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dima Kogan <dima@secretsauce.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf probe: Fix uninitialized variable
Date: Wed, 11 Dec 2024 08:55:22 +0000
Message-Id: <20241211085525.519458-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V1:

 * Split into a fixes commit and tidyup
 * Pick up tags

James Clark (2):
  perf probe: Fix uninitialized variable
  perf probe: Rename err label

 tools/perf/util/probe-event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1


