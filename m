Return-Path: <linux-kernel+bounces-384074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DC9B23EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6487E282088
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0A18A92D;
	Mon, 28 Oct 2024 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arqpY7Em"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9EA47
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730090788; cv=none; b=HU/9FDRTA4Zw4BBii+7D+4PlJdFflTvj6eWC2MPMAwdRaUi5kBf0xCVHa8lwGVupCgM7nEOaweDpsV6izPWcDrgbAsLRRijTCvkgsOyIlE/WR0aNm//tW8/SkVlRpvs19Pz9H5m8orTyYFWY1Vf7njsSXHNSE5wVPlwxXUYAteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730090788; c=relaxed/simple;
	bh=2EbHWBfLhGkuOGHGIk7T56Pwh0KL7XKK8so6hCxKmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PI8Q8boTdezNlhrO0yIAww7+ZdZ6GtVdEzCuVV4L8IziNz56zG4LTcfSNjJG35p9Akv05b46aw4Vkf/GBMd1xKv+HZzaBChd6VidaI/BlyAfWMNlkvSpUgrQhO2D0bkAPNZgJJLTR8i1fDDBamDTXuikcyhOFNnoIVE4clPSMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arqpY7Em; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c70abba48so28908675ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730090786; x=1730695586; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru6TZnJsC9elzyNrY/cvzQ4CwnpZ6FeXob1OQjHoMmg=;
        b=arqpY7EmgtRpliEc5oseVdMl5rD5Wad0juTh689491S9BLB2t1oCVCwHZ9YlJ9yinr
         KUmHUfKPjQPPShW0n6mSvb9stwypPLLL8OBtT84EUOlHoJYX9ikqB0Yb5AVf/NMSMhG2
         62+noveLxjRANAdNV5iOAyQAp0XuXjEPMY6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730090786; x=1730695586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru6TZnJsC9elzyNrY/cvzQ4CwnpZ6FeXob1OQjHoMmg=;
        b=WYhvwyJzjIFhALZWb67ILIDAiq5CNdlRjgtOtYq36RmZOUS0Un542NPUJAOtYvMj17
         0hjvfHIqz+USrA0udxE46qJMQlXOxnQP8GSliobfjEWuijyq6LGenHABKa2Dius/LAtm
         B+Efrg+9L4BKg8tN7mjwApYkg7ZL5PNbrMQi8He9ESQKroknvEzfmvSzzHg7PN/xbQoJ
         mtUyqz+GTNFCPorRqu7PII9RemM6kGQEI3HnQJ6OtcFcru0JhVbGoJCnl79adSuEKH6A
         8jAYbyBDfEaW+GyS1tADbRXByZMcbUoAdoAIESjZi4mzIMYi324uN8nBSFHF3unlvVmi
         /xGg==
X-Gm-Message-State: AOJu0YwZvVpAIdboTAkCrxIzFHLhZh42IyfI3tNNYJoHtnAkZG1UpZtE
	jidjA7PaL44xpHqDXPEIRVy8wXXjO3P48V3an1NZYJplyqQBy8JGQLFjnrtyig==
X-Google-Smtp-Source: AGHT+IG4o8SyC/xd2sK4623mdcAb/BEs5cFjcwjBL9FvVlKtFVsTbOeeecs/bZqY7tko4MXRQ5EkAA==
X-Received: by 2002:a17:902:e883:b0:20c:7d75:bd5b with SMTP id d9443c01a7336-210c6c75ae4mr88521365ad.42.1730090785735;
        Sun, 27 Oct 2024 21:46:25 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:33df:d367:fdc8:47a0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf464ecsm43014535ad.28.2024.10.27.21.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 21:46:25 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:46:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: i915: intel_gt_reset() deadlock
Message-ID: <20241028044621.GS1279924@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm currently looking at i915 deadlock report, the report
is for 5.15, but I don't see any significant difference in
linux-next code, so it looks relevant to current upstream
code.

Basically, intel_gt_reset() grabs gt->reset.mutex and then sleeps
in flush_work().  Worker, meanwhile, cannot make progress because
it sleeps on gt->reset.mutex in intel_gt_set_wedged().

INFO: task kworker/2:1:68 blocked for more than 122 seconds.
Tainted: G U W 5.15.135-lockdep-20721-gd26c0f5bff55 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:1 state:D stack:26184 pid: 68 ppid: 2 flags:0x00004000
Workqueue: events intel_wedge_me
Call Trace:
<TASK>
__schedule+0xe1b/0x3bae
schedule+0xc8/0x247
schedule_preempt_disabled+0x18/0x28
__mutex_lock_common+0x99f/0x1532
mutex_lock_nested+0x20/0x2a
intel_gt_set_wedged+0xbf/0x122
process_one_work+0x8f0/0x157c
worker_thread+0x4c2/0xa4a
kthread+0x32b/0x442
ret_from_fork+0x1f/0x30
</TASK>

INFO: task kworker/2:1H:156 blocked for more than 122 seconds.
Tainted: G U W 5.15.135-lockdep-20721-gd26c0f5bff55 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:1H state:D stack:27112 pid: 156 ppid: 2 flags:0x00004000
Workqueue: events_highpri heartbeat
Call Trace:
<TASK>
__schedule+0xe1b/0x3bae
schedule+0xc8/0x247
schedule_timeout+0x15e/0x215
do_wait_for_common+0x2d3/0x3f9
wait_for_completion+0x51/0x5d
__flush_work+0xd9/0x131
__cancel_work_timer+0x247/0x544
intel_guc_submission_reset_prepare+0xbf/0xb01
intel_uc_reset_prepare+0x11c/0x1e0
reset_prepare+0x35/0x20d
intel_gt_reset+0x3c3/0xa3d
intel_gt_handle_error+0xb4b/0xf24
heartbeat+0xaa7/0xce5
process_one_work+0x8f0/0x157c
worker_thread+0x4c2/0xa4a
kthread+0x32b/0x442
ret_from_fork+0x1f/0x30
</TASK>

