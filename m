Return-Path: <linux-kernel+bounces-169942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DB8BCFA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB31C24097
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF482497;
	Mon,  6 May 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XONi0HQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB881721
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004246; cv=none; b=hxQVcsv3ppOxzS+yE5r919dop42pIg/2bedA0FufxxQnjbS8ZdU2owJYOgE5GkpJo2LRCJejBXe8z2Vm9oHb0mjfrfa1fXnP5MVV+495l73RJ6ZpjxFCDleqPggnM9/RizDbTohEJKiauZX/Hko3PtgXCTl/NJtsQ49+e0SqaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004246; c=relaxed/simple;
	bh=0UjED61Jh9Jzm1bpuRCl2fNikOVYlkHF8HPiOiEvdWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vb4jznpjdVIcBZo+3LBvuBeoWmweqWmWV7OTKxexmHywV1Cp/h3MQ/5Zul7pESvYNJ6DmgHWdvEYzM2im7N3KUvpLPr/CPMLNgkVC3ohkms5RU03prKDBTWav1ijP8ogwECG5fXZUPluncgRFE/lg6quC+fpBS65zLnb1fTxkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XONi0HQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB19C116B1;
	Mon,  6 May 2024 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715004245;
	bh=0UjED61Jh9Jzm1bpuRCl2fNikOVYlkHF8HPiOiEvdWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XONi0HQdeIQmXfSfKA/QgR6eTkmp6g2oJIuNXqWYbA7zAQFdC0DD3hMcSvd8ScxlT
	 FQBwoRSdwIUH9e/bqqlWAov7b0GeSlq4ZWGIzHfC81mbeIHB8zxvuNQM7d5n5Nacr5
	 eJRVzfgTwDlXF0e9MopOX3sCj37Gj9wTMe9e5N2KahrQxEaGbNrTnPnYjYw38Lf7A0
	 2MjZ/RJ2z00vJEfK1Zh0HgdY9TB5AIBDAmPwIcyudMJJDCB9eNXMr9N9s7Y8j/YGYq
	 VTtnpsftx1ezrgJKsTOYKTqnB+PoHH9cPT5ZSO0dZCMzBN0/LkVHnRVPwgaIlmCXG7
	 NowbiHQa/27tw==
Date: Mon, 6 May 2024 07:04:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: fuyuanli <fuyuanli@didiglobal.com>
Cc: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <bristot@redhat.com>, <vschneid@redhat.com>, <kolyshkin@gmail.com>,
 <akpm@linux-foundation.org>, <kent.overstreet@linux.dev>,
 <frederic@kernel.org>, <oleg@redhat.com>, <hca@linux.ibm.com>,
 <paulmck@kernel.org>, <tj@kernel.org>, <bigeasy@linutronix.de>,
 <CruzZhao@linux.alibaba.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Introduce task_struct::latency_sensi_flag.
Message-ID: <20240506070403.181b574d@kernel.org>
In-Reply-To: <20240505030615.GA5131@didi-ThinkCentre-M920t-N000>
References: <20240505030615.GA5131@didi-ThinkCentre-M920t-N000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 May 2024 11:06:15 +0800 fuyuanli wrote:
> A test has been made in two hosts named A and B. In A, several clients
> sent udp packets to a single server in B concurrently as fast as
> possible. In B, the IRQs of these flows were bound to CPU 0 by flow
> director, so there was always a triggered net_rx softirq on CPU 0. Then
> a test program was started in B, which was also bound to CPU 0, and
> keeped calling sendto() in a loop. Sampling with perf, results showed
> that about 25% of running time of test program was spent executing
> local_bh_enable() contained in syscall sendto(), but after setting
> latency_sensi_flag to 1, this proportion had been reduced to 0.5%.

Enable threaded NAPI, it will have the same effect.

