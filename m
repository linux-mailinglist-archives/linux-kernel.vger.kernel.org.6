Return-Path: <linux-kernel+bounces-284238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3194FEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA061C22960
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043258222;
	Tue, 13 Aug 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="SdCQJnYd"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949762582
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534223; cv=none; b=XhqFicpXqC2/a6DzRE3F0tuYcs5aRlZCa07VF7J1oswMdOQSg2zZFiJdCo99BXCS98RXea94CSavQM2bapHd60PR+hexzzEJzJ8TDXWQQVaa6Qt+Zk3JnvPvOgaStiQiwFuGA8SRhr7cMctzjCnRCj1RdmsRdG1HQQ2l7LZDlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534223; c=relaxed/simple;
	bh=vUNnqPi6sICGd5Z4JMjpKIK/OJQzkAELdDNXsnqe50w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJDVw/PYi6Olw0NxKienuL26Nx5HQCWU2VN4jsMm+GRDCc/tEz6mQ3jrNcnKO3wE3ZxcSE+IrfTJpK8FKWWxUZTQl+jXhZ8v9K0nFequsrwFrje1QP0gGU3jwWXP8T4Rkn8iUSqaqlHRFcy+SavPhIOaSOFrGGGyQLH2SRhxTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=SdCQJnYd; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408130730144ec67ccb65a34451f6
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 09:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xn8gVTQKJ/dEZfK7oU0zcuKpSteM/hD34b9b3hxtYfQ=;
 b=SdCQJnYd043vM6+h1tKxGrfYWi1090vsyc/9eT5ZOYVlVCOJNw8vvSaoewR/mfVscQlGEO
 7Fyj9hNcNoO1sE5/bO0BI2R97uV9Al8eaopj6EsEcA/goQkKh+1O3G59HjH5OizmjAFv8NM4
 Ug3JYR+1t14GKbWfK4fEnP5GaK1nGMzm0NLhCYkygmVXGzK6MmJHgQl6RnxiSbA4i7HotvCY
 q9kNsShVKGY/jlIgb++IQ83BQap3LXSRCYsr/zM7b+zl9DMrLzvRxSS+ySE08hZOBT2waRpO
 R2ZrJFSuBrTXVONLGclJ76ZUGmMDvjzw95k1IljyYPsC3rx1JEyfoHkA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	qyousef@layalina.io,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 0/1] hrtimer: More fixes for handling of timer slack of rt tasks
Date: Tue, 13 Aug 2024 09:29:52 +0200
Message-Id: <20240813072953.209119-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

This series fixes the (hopefully) last location of an incorrectly
handled timer slack on rt tasks in hrtimer_start_range_ns(), which was
uncovered by a userland change in glibc 2.33. It does so by removing all special
handling of timerslack on RT tasks by instead setting the timerslack to 0 when
switching to an RT scheduling policy.

Changes since v2:

- complete re-design of approach (as proposed by Thomas Gleixner): Instead of
  overwriting the timerslack in the hrtimer setup path, we now set the timerslack
  to 0 when switching to an RT scheduling policy.

Changes since v1:

- drop patch "hrtimer: Document, that PI boosted tasks have no timer slack", as
  this behavior is incorrect and is already adressed in 20240610192018.1567075-1-qyousef@layalina.io
- use task_is_realtime() instead of rt_task()
- fix style of commit message

v1 discussion: https://lore.kernel.org/lkml/20240805124116.21394-1-felix.moessbauer@siemens.com
v2 discussion: https://lore.kernel.org/lkml/20240805140930.29462-1-felix.moessbauer@siemens.com

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (1):
  hrtimer: use and report correct timerslack values for realtime tasks

 fs/proc/base.c          |  9 +++++----
 fs/select.c             | 12 +++---------
 kernel/sched/syscalls.c |  8 ++++++++
 kernel/sys.c            |  2 ++
 kernel/time/hrtimer.c   | 18 +++---------------
 5 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.39.2


