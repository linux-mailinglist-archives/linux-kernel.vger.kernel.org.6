Return-Path: <linux-kernel+bounces-550602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E3A561DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92C61891A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A651A5B96;
	Fri,  7 Mar 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLN3tCrX"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364F192B7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332899; cv=none; b=nOU2Xc3RRCXjaLgFDXcMn7Vpn26/kpZ7fWPqeEukePmhOi8Qbe84xglqOn5pzn9J18m5ioHWhuUyUPAy3I3Hw/Vr1TYmRNhvcjcMddBdA06coHWJbBeKU8kZJz7gSFMyJsn4AfnLX6w1XCiJbw7V0gi13m4BaApIJ4zZCHQ9dWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332899; c=relaxed/simple;
	bh=ctPVAtWaXaKCuE5LuTAIwOQM11ywFK6RGE21gBeVs4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgxcEXge2Jy1pbaDnLcWq3qpIqxGRivw0OgsRZFfH+mrGSfsU0U9P48HiOCAVdiBJLtIlfaxaqT/EmK0Ta37PVy5LkmSInpm1a0SsGMxR0ufgQIlilMGyootq0vA/wS7iF+lWDzbpyxChTHAkvq6J7uEfIPb1qrCoXiHxGkVVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLN3tCrX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb91a2492so2806557a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741332897; x=1741937697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjt9C8VUJdpZK8WtjI+8HyAWHpGHvW/BGncHWkhwnb4=;
        b=SLN3tCrX+JSr1ChAm2tuvZPUzcO0iOExvt0Hmt29/L1cmSuRJgjtIuqMrbqrGDD5tV
         CI9LFd2PkOnql8R+T+6u0IiUCn6cd0DHDskdk0q0HHQlaYIpU9yrZYLOOpilJfx+mEJs
         f1B+h0i8gfCqvy3IXqZxA2BMZ20w5DZW3WZwB91YQozzS9ElSjEwDv8nLhoBTdvGQ2Oo
         bGp7iJnkHE7EqJ5l1yRxLA9kg71gJgYeph4joNlwhWB+2C86XO2DaXUeizOIbmmL/SJO
         ExSi7PWqT8OhaqMRzDHT6T34OfExtmUO1I7PFksjLzEyY16BAeGD4hvFbBQHysYcvGiW
         xBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332897; x=1741937697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sjt9C8VUJdpZK8WtjI+8HyAWHpGHvW/BGncHWkhwnb4=;
        b=apZ+RMfjVGOfkrvOM9GR9Z2MY+tcEGCFAXW2MwWcfgTHJMALBZxfuqVnTWnJmo3uqk
         Ej/gdEDnd7bf/i8Whg6tNldx7yVuKhjEntwW+7+BGIqVwcE48VrzKphXCrAigSpijggM
         3Er1KbIfeB17AzTsPkV91TuOh6gzMTG68axv/AD6hydyu8lCmfUgaMUv1K3PWoGDMn6S
         DscXzeU9ljjCf7qRF8vvjJAVEBB7/nFtwx4o+sPbi5LtfInvp9IFcyYII2rvDye+xfOE
         OwIa0d3Z7T+Po+HY3cUTTJsZY3cUsCzTpgSsKSi+end6eySvluDCgG/dS6OIeXmelu/U
         0DVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrmdDvbKivS8ehWS6xcbfZh9ZIU/E5bfruMNHSvUZz4Q0TcJ1A1mz/GgmezKm1rFR9GIb6YR1x+4jiHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpGKTBjBIb9zCm2ILbYu0c8sxt4l5EBFfSUdg32e2YWcUgaOF
	He7z8TZLRoCNNJCOxEzUjHbMfupQUf0mpBw1S3sYgkiB0vN0QLpjNUyCFZcKbE0=
X-Gm-Gg: ASbGncv9En/QJ3v4BRn79adHNXSmbCkRz3frx8QqHR8JVPPGujswNf0FESqrGNeKpoT
	2rLf1/+V/d6HWlmvIbbN+wzM60hKuUS7MTrYUwBzNHDspI4XBVkwaf2tB9gSn50lD8JTorRRjMS
	db1wVGh2WGjf1fSZzdaOG4E+tNrgKncOetETrPftGLtyv8xKVc3mLwvyLYGgbjuTsxlAtkLl8mL
	Bgap0hB4hltglbBeCQqlzHFrBzHy4QrHY83b+MwzCKLmxz7kjciO4/j+l9OHFjR981XOzBqagrO
	Y/UgF6TLHPKr3E178+jwi+5ZB7NZICo5ScD1cr+NTV/ecw==
X-Google-Smtp-Source: AGHT+IHPPYSmazDZOD2fKozTzdVGJsqxTd/WpRg3ZyN7X/9jbeje9ZktEhzBuMmRrqA89MatMiIFrQ==
X-Received: by 2002:a05:6a21:104:b0:1f3:42c3:89ae with SMTP id adf61e73a8af0-1f544c7ff60mr4958963637.42.1741332897220;
        Thu, 06 Mar 2025 23:34:57 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369824593csm2568640b3a.71.2025.03.06.23.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:34:56 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] docs: core-api: Update kernel-api.rst to include cpumask.h
Date: Fri,  7 Mar 2025 13:04:50 +0530
Message-Id: <cover.1741332579.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This includes cpumask.h in kernel-api.rst and fixes some kernel-doc formatting
warnings/errors.

V2:
- Don't escape *, use @ instead before argument name.
- Don't escape %, use space before "[".
- Use "::" instead of fancy code-blocks.

Viresh Kumar (2):
  cpumask: Fix kernel-doc formatting errors in cpumask.h
  docs: core-api: Update kernel-api.rst to include cpumask.h

 Documentation/core-api/kernel-api.rst |  6 +++
 include/linux/cpumask.h               | 65 ++++++++++++++-------------
 2 files changed, 40 insertions(+), 31 deletions(-)

-- 
2.31.1.272.g89b43f80a514


