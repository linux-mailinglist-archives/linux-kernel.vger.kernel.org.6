Return-Path: <linux-kernel+bounces-351598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46145991376
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D8285022
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5013A95E;
	Sat,  5 Oct 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TC6WDc+6"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76034A1C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087601; cv=none; b=OvXYjTBGMMN887rgSqB25eRwS3n0gZ/yqtaFy0JkDxGimVGTGUI73Q8CK1YObIAtzk6m6ErBxvjul34wX7zOycpFH8OWepqEenXp8h/PTqAJyaRMAqI95owD6kLkg5zLbqsbGCSPNlDl+uzSbZ8W0oUn9D0sV8ONa8zQvpSryhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087601; c=relaxed/simple;
	bh=BKDxVsu+ZmAVWh7Fqh9ChrgXOlYs0/03PrzvyhFJ1t0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=LbaryeBW16/aFhdPSwU+I1kxdcdznBdv4Rt2McRf6xMd2JUL3Xf73RrGyH3CQULks3NZClFp/fqkSkuceQT8eafnn1RHvi06ERY1Dc61uzCZlLWMgRcxq3k+m/ohPY3HB0KmS50Ct7gTm3BEhnUl/AFlsjhng5yZlxIXwbozHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TC6WDc+6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb82317809so20546886d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728087597; x=1728692397; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0XxW4Wz7XvQX/zBmo795S9UVuzWB3EpZahyhVolIYmk=;
        b=TC6WDc+6qkPll3M8iOuc1CVu9i7I17e7IOvJUt0fol8CbVcPJIcF5Q5eWSuTL1Hi5R
         MtEtWosRovV3vgG1Oj+dAlqZK3+dapyKKzirUMsQ5MReLiN2AcEr2+ng14ogzv4Av6eN
         X0RdMV5r+M7zqCtJJYNtqM2b//CaPOK5cFHQIK9TGTBGN8KmiQDPSvJXxai9pgJsbr/e
         ubXtooX6W8iGx+LAngeN0NskJ4xQVj77TX9Ox9AxGUtWHaUQlZMJJ/ei3X7HPR30lkro
         +iRbZiOEnF8u1XDuI0nvz1jxRLxzKOlvjt0scrNkKJmpUtnw/k4odm51g2wTeHrpIzUq
         0qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728087597; x=1728692397;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XxW4Wz7XvQX/zBmo795S9UVuzWB3EpZahyhVolIYmk=;
        b=m1/V3JdcLxNE8PLJIQpTBPjFU1GHoborFd6VlgBCq05cYFGzpfTREjrg2P9+NOEqOs
         AhmPh/fOhkoiF3zvIZblB+PUWwst0C2sQ2pXXoNKS3hMNoyYYJg/E9hCwNSVfeX7jZZc
         mCptnINOzxJyiIhR9aqrEJXGS4mzcTAsT+8J++xVjlMXOF4SUA6y2+P/jf+d4u96Y6si
         i855hQ8IRM/KnIVh4AJtebBH2FVzkp/lBivWOyUxSoArEv/LyWAJf4tsHYswaY0PBYd8
         j24etW7uETz8G9YCj5T4rOWMGmmsR9hNh+wvxl1OxPQUCtm1qj+4bpt9uQFhipU/nAsf
         XC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8jRTxQWlKefRIzYBD56Gs4el+Yvdl0e2JT+9o8Cy8xY/qwQ2TURYl8AneGRnuJ5WGyouvTyPqBqij4XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkN0EbfDxBLpWJoqmsL0aX6OYOPzhOBBejCGroFjRtoTG3G8vy
	wc10ssEz08G42larri+n797r2W3ruk6fAADApK3N7uIMj36yz88Wiful40SIGbo=
X-Google-Smtp-Source: AGHT+IEWr4ycYJSpR2UBHXMtEvIlHqrS+31RTxTyfRNBpQv2z3hUfzSZqKerh+tRk75AH+UB3FNTUg==
X-Received: by 2002:a05:6214:5d8c:b0:6cb:a3cc:53f1 with SMTP id 6a1803df08f44-6cba3cc5471mr27177526d6.39.1728087596790;
        Fri, 04 Oct 2024 17:19:56 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46dfb1bsm3756966d6.50.2024.10.04.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 17:19:56 -0700 (PDT)
Date: Fri, 4 Oct 2024 20:19:54 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Zheng Zucheng <zhengzucheng@huawei.com>
cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "sched/cputime: Fix mul_u64_u64_div_u64() precision
 for cputime"
Message-ID: <n81qp943-q364-3143-7q84-05sp790on692@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This reverts commit 77baa5bafcbe1b2a15ef9c37232c21279c95481c.

After commit b29a62d87cc0 ("mul_u64_u64_div_u64: make it precise always")
it is no longer necessary to have this workaround.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 kernel/sched/cputime.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1ac..a5e00293ae 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,12 +582,6 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
-	/*
-	 * Because mul_u64_u64_div_u64() can approximate on some
-	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
-	 */
-	if (unlikely(stime > rtime))
-		stime = rtime;
 
 update:
 	/*
-- 
2.46.1


