Return-Path: <linux-kernel+bounces-310858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681C968214
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D890AB22A53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149AD185E64;
	Mon,  2 Sep 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DX2Btwpt"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4824154C0B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266139; cv=none; b=gmqYVbw/4V2AK2KMDANJIJ/Hx4efE+LbNzakWU9rW9y6x9I0OYXqIfOjmXx6mr/tQzTYKbTUFHLcu3G+Q4IAJxlbeRoU3Id4dgo50C19C6mtCS8074F2xAJoX8sviDOoD/UqqZUcUlrwUPlnOkgQfuqWflTes0kM6pRjFa4oBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266139; c=relaxed/simple;
	bh=1yKUWgG168kIrumQ4E/lNDOE3dBsj4G/DSSmNyd+u94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9xQactJIUVvtBMTdXBKF1rTyF2/7tim62b4hvCtix2dtzftTH/o04FpFlwBjbWw8SpgrBpAhY3Lp6GpR4EdcvA0Liql6shalvnl3j5pjXK6OuhnWdpB4mgySdR8p4XJMs/3wdeXGxEDu5Z58qAlZS+1GdQ+pE58XIAF+Ca3E8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DX2Btwpt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8b68bddeaso834715a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725266137; x=1725870937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx+Ngpcz5KS+uT4ExH5gnibO/Q2OSWyZ6WFtEESiF1s=;
        b=DX2BtwptwtS4S4LBkTC5TJtMYYPfTtxYEzIl6ZwsNPN42edbg1+oW35RQKCxFMV1zd
         XMToc86V+mqsYsBiCq6dAc01qN+xl13lufgCZBS+g9Wau+9Cb42CD/MMuSuvPgieTI1V
         wuoxWYJy1SP58CHZi8WnaGxhsLahSEEXhVZ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266137; x=1725870937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx+Ngpcz5KS+uT4ExH5gnibO/Q2OSWyZ6WFtEESiF1s=;
        b=TkJ1pOYtlNGbnBzDoRjrfTzBhrxqUz/mLxCZRZ0cjehMP4DswMOsP9d+NKl1ft4Ydn
         iPU8txMNayvVVDMLKSa4AOKR8K3vdvGwGEINbbzgPtnxXSHB8jpGrQXpMQheZWtW7z4E
         a+TTGHQHDlNP0Ivh3n2vciuUgtPDh2V+YSJI0t0ePXfd8sZSAhxG63rYVsUmfa3TAKxL
         UcmZjYh0b7qcYQ9VNqBGvkq0MO2BR7GkGoTUuzmbcvFVy6jn4Sw9kN2skx8I9/xcrGmF
         I2R1IpcleI1/wfLFN4tmSb6y5apAhNm7mTcn0I/FH98FGjCTzPxGi8qumEpW3u/KGfT/
         B6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSAPLFLDjFW/Ekl8thNV4orxPddkl+yXJ1BChwCx0ft8pI/0nZHIbFFdmmEOtZ0I7SgmQ4JLgI+2fLcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaGhDUX7UZ0zZX4ddWIgYdQP9+wuU99m5tdVof1Fzxd0LOdAY
	SW4+XaLnVKm4mjthW8nT/d/ItlLL7bjqfd/onbB3N7C4n7ky4H8J2ZBI9UVgaQ==
X-Google-Smtp-Source: AGHT+IF4/GEqSbXqoxRakIqILSzbtpCjeIMTeUiOM4xZC1PMAowJYIU5DaWRW0ooWvdCC6o+o1UIWQ==
X-Received: by 2002:a17:90a:558f:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2d88d6a0b9fmr7246707a91.14.1725266136913;
        Mon, 02 Sep 2024 01:35:36 -0700 (PDT)
Received: from fedora.. ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b95e8sm8511509a91.54.2024.09.02.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:35:36 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	Sasha Levin <sashal@kernel.org>,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v5.10-v5.15] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Mon,  2 Sep 2024 03:33:55 -0500
Message-ID: <20240902083422.1095022-2-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit cc5645fddb0ce28492b15520306d092730dffa48 ]

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 105fdc2bb004..bede3a4f108e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1240,7 +1240,7 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	snprintf(buf, sizeof(buf), "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
-- 
2.45.2


