Return-Path: <linux-kernel+bounces-395560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512689BBFE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E51C2198D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825821FCC63;
	Mon,  4 Nov 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R7Ijie7k"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680941F7553
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755166; cv=none; b=fCNy0e+CQCytN8egogaFGQ4Z4QFpe7Siea6erCz9QISknH6Pzt5InetCbBFK4yMucEIkc5fh5KyN8f17pGpq6MXRDbmILDU74EVX2sx8OCsD169o08lhRxaGc408LJdgnknpeAChGdn49vaNcYnwEufLoeU4kXcBLZJK+VsuSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755166; c=relaxed/simple;
	bh=ckz2b09PADmewB6PWKzCnnP2d1FGRyLX6Oab2Bw7LRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XGjd51gbygqasko5tuKN/juyLOpYJTaHjnB9qrKJdSGLaIJhNMZLRVlATGvgsVZhBpU1E10ymms3DecqTk8tu8Ra2tB/536dHuIQfwMQOGE70iOuryVw7cmNwVbDDhxnfee1mbHLDfJIOxTtYSK9zVM5itpi54cgFylavv1crLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R7Ijie7k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so4236330b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730755164; x=1731359964; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7VFZJDeshaBgjeWIFYPhisTVO49atYEdsiOoKJAJfU=;
        b=R7Ijie7kXJ8wsjT/1pYW8Ej/7SP9EUPXbJmPf55xHJjY24BK5/aBwywefTSSryZgix
         uQb0v/Szql9jyAhFGv3Oh+IkheILL6qV4UJSyyqnbp78lTSCtrAEuNljUH+r3ExlnaVa
         1qSkS2sObX7KyXnVzd6EaSAb8AUnGNwtPNuLjaUXih0m+APvnQX5bYjRD+cLa6sftzx3
         Ot/nVU1zZxwo7ou3NWzVez16nHssRn3iXeqdBhYTwum5CZBowe2v8DxbWaHYx7DIAK1S
         tPG6ixLxKQYCgPziSKl4WOQem45JsWga1Nv509CGl1aZun5iyeUJZS5j4vjA//PZ/IDl
         66RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755164; x=1731359964;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7VFZJDeshaBgjeWIFYPhisTVO49atYEdsiOoKJAJfU=;
        b=o74N/U69muk7fo6ciT5aHnNAKN5UxOnjoy4XxMi83iCja51ui0bGtpyirqMGwFaxRH
         BMh5+B9YWdm3IPgzkO7NfzRrbBMfqE+H4tp5jp9j3I7w3MQEGvCotQYBrK22xVx6UtBd
         l1oHaTAxfaGACqCsh8XdHu6ExTvOl2M0ImoIaVTpH+gu3VnejO113gmOyYIz/KsfPoal
         J0ILPxrvbW/p8wn6NHauRZ103UuhdX+13SZji7Xsk1e7M48n5ZnP4NI2ivCHDZyFXG0X
         0JhN65l6BdNW/gO6kiYgkArod+VAC8+hdkvMT1nTsv+Jw25K4G2SeEZpo/YJagJbtN6A
         F1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0nyq8tkCvauYoEnUm8aoYrRFCR3ucxWWoy5g1nsznY/wT9qVHduEYiji92asFQmNpPXHzBoiIlQaH2S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxkGJOuH+jkz4qrF0eou7aSu4a82CcckK2SPGPMbpBLpZzteC
	aFqGBS5g3edf1/M3i/Gkam31ozCpe+mwBtGo2vEgCONV+H2Xi0CNidueUTTuy14=
X-Google-Smtp-Source: AGHT+IGxdnQJocTNFzEN9oyHKVuXZJvNTwlFkn8XBlUG6umm69XvTTuY4E2zmsa/aNVVZeehrny4Vw==
X-Received: by 2002:a05:6a20:7f93:b0:1db:f0af:2277 with SMTP id adf61e73a8af0-1dbf0af227fmr639531637.38.1730755163757;
        Mon, 04 Nov 2024 13:19:23 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f3e0efa90csm1270988a12.2.2024.11.04.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:19:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:19:15 -0800
Subject: [PATCH] perf: Add all shellcheck_log to gitignore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-shellcheck_gitignore-v1-1-ffc179f57dc9@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFI6KWcC/x3MQQqAIBBA0avIrBMcE4KuEhFpkw6FhkYE0d2Tl
 m/x/wOFMlOBXjyQ6eLCKVZgI8CFOXqSvFSDVtogKiNLoH13gdw2eT7Zx5RJalQOW7Rtpy3U9Mi
 08v1vh/F9P3EJMlFmAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ckz2b09PADmewB6PWKzCnnP2d1FGRyLX6Oab2Bw7LRc=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmVQivWdGPzzMWVzaeetaT0DZ94/mJvy+d+/BFJyPhj
 4qpTtGnjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACZiuIvhf/kymWdLeYv3BR6+
 tiPwrIaL3ZT2N4uXn4xJa9ySJqG9egojw8f/lw6Hl0Y/TPJeft5go35n3kW1QMalr6fnLZzp8EB
 wMy8A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Instead of adding specific shellcheck_log files to the gitignore, add
all of them to prevent these files from cluttering the git status.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/.gitignore | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..19ce1cd56f8c 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,9 +39,7 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
-tests/shell/*.shellcheck_log
-tests/shell/coresight/*.shellcheck_log
-tests/shell/lib/*.shellcheck_log
+*.shellcheck_log
 feature/
 libapi/
 libbpf/

---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241104-shellcheck_gitignore-210c131b372b
-- 
- Charlie


