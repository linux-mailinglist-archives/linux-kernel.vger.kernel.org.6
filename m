Return-Path: <linux-kernel+bounces-226719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316979142B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C689280B93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF424B2F;
	Mon, 24 Jun 2024 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="B+PIOJeL"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7875219E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210286; cv=none; b=qecqp2IhEGY0X4SyZiSre/f8uAyygOD0eJlcazesvuG0mzl2I9wvfx2/ePjdvrS0B9eCKglV1FEw9MsCG4qKJ9EJeK7+pvz2Ni39q8zgWpn8UPCLLt2yoO45wRiNSQ/rRYSG7nLT3HseYmceoN/9lQUpQ1EIMWz3YgFS4EJEZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210286; c=relaxed/simple;
	bh=vEuBW39i2ESfpxS5IkfIe5obDGQX0p9Z1+KkJNWA1mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvVX0CUBUAbR66Up11SSCqk+/idua5QVjGvFbOM5Be1qzXQeSEgC5zA2vWiVwN65jT6NRa+knEGBgqJ13F2MVyodTsVa7GHSRjnEhEBbwQwIsZOTtHvr3UjhxzwD7foh+BCPnKLW2buJz8yhA2Qrr6/7E+wVrz/HRGRP/mxsnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=B+PIOJeL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706524adf91so1892542b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719210284; x=1719815084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Re2jmzBZzaiHeY0HiK6tmrvBhlVt4JnJIfW51t2WWYg=;
        b=B+PIOJeLF+zgKH5dUV8HnHSQ18FgqKYfVOrhyiv+VUewAQx5btyhjl2LI95cM0xmQ6
         XHrgezgUPlIfWaV8xWyOdM49hopRuZfo0d6OMVMgRYh91osqAVajyWLUkbssC5w09SkO
         TJaXq3y2KexCI88wUTWZvd7D+EjL+/iezdiPFW7EaCP0phF60JPlysnDDyE+CUDdzD3c
         bZ5yiCxf+U8V6HVdDKEOJ51g/k6558gzmQW7NOcjZMArRlZFc4MipGjH0tJo4URa48q9
         xbZg4Z4VERmQpqtX8kjRE8fm6FN5Ol1T+CbTi3bz9p4ltyJlQZzkh6Y0y30B25qMSYW/
         zHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719210284; x=1719815084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Re2jmzBZzaiHeY0HiK6tmrvBhlVt4JnJIfW51t2WWYg=;
        b=emjrFJZqHZi985Yp0L8TboHZLsryyYMdGRWGSyeTPiCaw2Z9M9rxcNN1SHz+ISJDO6
         /Mr1r1zWx+4wQDy+VP1u3vjPrcohZpfPEwWzbf8rNq25ibOpNPYqKWyEw1UxO1+aA6zR
         vVh1jR6b+CNuYnMLT+5qoRW6mFDEFp3hK3muY3V0RkvwAm23D4UMckmtChglhAdmaZYi
         K7/eh/3nd6fa5ch/+brofzsOLGrYiu7zlYpKHMb05hX/JSNUbKeDNv5orSsXNSsYDaws
         gMks93/7XKryd1qT6P/CpwCzQQmAmq0uK9adp30JkgLRW3nmwJzjRUGgyM9Xed4uIyE3
         enOA==
X-Forwarded-Encrypted: i=1; AJvYcCV1VBpSpVnVrRs3UDAFOTwtOzKvPHz1I12Z4bNFK6hKOkf3CQbn0mDL5MuGVVSJNRDTHxwlreDzrZv55sOF3jNlumNPbg0QXYLzEO1k
X-Gm-Message-State: AOJu0YzU5cC5xUnCy93gutrPfT8CDW1HpOCsOvqvjjy+QVs7zAtCv8ss
	N2P2Zd1/7g4rOmPmCsvOb+IfIEpLkZQm8785rktQ4GScWIhUBL4ldMw7T8ymSWQ=
X-Google-Smtp-Source: AGHT+IGaCZkWeiHY1wWMLYMwLgHsSl99HxEXFfdyqdp+JjnUCXX1cbVt+4kzvW9e7WOResB0H4Nx0w==
X-Received: by 2002:a05:6a20:6723:b0:1bc:ba80:3438 with SMTP id adf61e73a8af0-1bcf46515a8mr4441324637.60.1719210284013;
        Sun, 23 Jun 2024 23:24:44 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107b6a4sm5434743b3a.1.2024.06.23.23.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 23:24:39 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] timekeeping: Use min() to fix Coccinelle warning
Date: Mon, 24 Jun 2024 08:24:12 +0200
Message-ID: <20240624062411.321995-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e18db1819f8..f1a9c52b7c66 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -799,7 +799,7 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 
 	while (delta > 0) {
 		u64 max = tk->tkr_mono.clock->max_cycles;
-		u64 incr = delta < max ? delta : max;
+		u64 incr = min(delta, max);
 
 		tk->tkr_mono.xtime_nsec += incr * tk->tkr_mono.mult;
 		tk->tkr_raw.xtime_nsec += incr * tk->tkr_raw.mult;
-- 
2.45.2


