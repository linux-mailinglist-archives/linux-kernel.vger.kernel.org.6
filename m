Return-Path: <linux-kernel+bounces-401183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C59C1702
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89C71F23039
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756D1D1727;
	Fri,  8 Nov 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yn22KY2T"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BA1F5FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050928; cv=none; b=XGzAA9CzbmH3cQFNl/XYgD/uN+KeX5DI2DpcLM1SGPQXr/Iq1mPhIFan09ZVCsX//T2ljUVdS/2Wo2sUgfCv6LogXkacfXIo0fBMB97zjNHvrvoyPwSa6pmy+aEweftFXJN5g9bltw69MEtNj0Ntf5TqWuJCw3PgBjFXIHIt3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050928; c=relaxed/simple;
	bh=nJ0e8l7PpPaAC/wsHNRJ9XOIc/WDgk3++V/G17W67vE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iLcGCGqoo+KkJKIyRjZA6hMfMOcW9P+H5OcV6p0t9KcG1XmTUapvurtMWecX00vYKGvjUdSJA/0aYzObrEhswrfLlKqYF+wutS9pUItF53GlLsAGUQF+Rvr8iAy8KCkr9/t0pGFRjOHNIInD7LlFtEHyPql1p+KkGYeT60f704c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yn22KY2T; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1604608a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731050926; x=1731655726; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJ0e8l7PpPaAC/wsHNRJ9XOIc/WDgk3++V/G17W67vE=;
        b=yn22KY2Tmq/yi59GcM/aCXA5N+aqN0n4Fms7dFUNYy3ct9W+h0Oc0kEQOTfgBMYhBZ
         A3g5ZG8FMjUyI8oX6a//sgrLrUfP/0X6LYiFhBw8jSd/x8DzTYiV17tWzkwfbHY54nHd
         3iiohnqUsqZfHcUspHme0m37EtQrk9OI/w8mQ/5kJEf0ASFapDKg3dDMe/7zPOFdlqYR
         gCX2LLnaScTFZ95AJQLrTtC/4XRrjJ62c+0T6MntTbN1vDMMSwo4tw02Is7LyhN+yzVt
         jPF2A8RTgj9YJMST8IhGmQrWaIQFkAEpVcQJtYFtrW8Po0xZq0PmL8RlQjhF6QITaoVG
         BHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731050926; x=1731655726;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ0e8l7PpPaAC/wsHNRJ9XOIc/WDgk3++V/G17W67vE=;
        b=xSKtvgNdIaYeNXvKKtrOqplpefTskOmbDrXzTN/vFO5S3bU/87b5HxsTSUyJzMJrzV
         Tghl1betiyaUt0i8WULIXlkajV/YCpEw2GMYyuKRXCFm70btssrTX9XxuwUVh+4OYk4G
         N9/qN9Gmn+4zjmSRCyBVBH5JQVXGS+anjZz5o0A4uoXSa+nDhBootuJ9yMJyvzlzjCb5
         pkhYfyT9NMecZVeY6POVjtMdNMkiB+yQCkujY3XeNbYVBn7e2kejYPqezvOZ1j5jly79
         1UXP/g5YJIMuNljHi2lXI9L2xF5xAraT4nN3pcM10/HEzwTPjwYzuuoj/Ei9jkP3ydjB
         tzAw==
X-Forwarded-Encrypted: i=1; AJvYcCWw+7etsnHuystTMKcgnR7sjIJ7O0feQbWxMkWJT7ks0TkG2yFix8Z9k327mwRvcLkMOKbpEmvuEciQO7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02iWluX6/wSYFkZ3e6zItg+r4Tfo4r1lPglXwLB1/GYToLYrk
	A6QW1qh9AsIN2ZmqFN4+XGhLCwDauFAyZAE1dEb5fezd6kNWWIoEInNOpf9b78nmzMzZqgtLDw5
	r97fyTQhaVqoDDrLx31FTfAkwzdHhQmPIvLOj
X-Google-Smtp-Source: AGHT+IEpOI9/D+qYTZ5WBMh32hLhni57XRHXWjGGRxSQlc8l0JpHesOg+5CFwI8cwrikcNagJdPQkJqDVW/0dvrFfaM=
X-Received: by 2002:a05:6a20:1590:b0:1db:ee29:4f4c with SMTP id
 adf61e73a8af0-1dc22a1b545mr2183401637.23.1731050925895; Thu, 07 Nov 2024
 23:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Nov 2024 23:28:07 -0800
Message-ID: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
Subject: Very high scheduling delay with plenty of idle CPUs
To: Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, 
	K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi scheduler folks,

I'm running into some weird scheduling issues when testing non-sched
changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
this is an issue in earlier kernel versions or not.

The async suspend/resume code calls async_schedule_dev_nocall() to
queue up a bunch of work. These queued up work seem to be running in
kworker threads.

However, there have been many times where I see scheduling latency
(runnable, but not running) of 4.5 ms or higher for a kworker thread
when there are plenty of idle CPUs.

Does async_schedule_dev_nocall() have some weird limitations on where
they can be run? I know it has some NUMA related stuff, but the Pixel
6 doesn't have NUMA. This oddity unnecessarily increases
suspend/resume latency as it adds up across kworker threads. So, I'd
appreciate any insights on what might be happening?

If you know how to use perfetto (it's really pretty simple, all you
need to know is WASD and clicking), here's an example:
https://ui.perfetto.dev/#!/?s=e20045736e7dfa1e897db6489710061d2495be92

Thanks,
Saravana

