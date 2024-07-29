Return-Path: <linux-kernel+bounces-266465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B694003D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47DF2832F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505B18C347;
	Mon, 29 Jul 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mmKYxI8H"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF054186E29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287954; cv=none; b=rrUcC0Wt4sClxKKI0XA/WMDPDKPe4MGMO+X5G5PQVyiWKcIm+z3jmvRQOcB6S39oTNd3PscicLIWgiS77f6zRyYVxiZf6N50fbM/tR4G0iwOA1YrhXEbH7ugjtfzNBhpyfgEQz/31Xvx4JLV1kljeUiwVZsNYhLFI/ytyylNpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287954; c=relaxed/simple;
	bh=nV4bAiDLKPc4uuszI9vxnjWE03scqeGUW3bPLG3TuFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtVUyyit84OfpvZzuINRsmxKgUDNrabdQCgshLovi7vNJ8qRCd2JfO+Aew2uaf5VVkgeQ70MQdsST3BuMVHtyLryc1cPY+bCwbvaz49/q5Wo6haDwdEmdj1Tj3SUeEkL5LzxoT4ZQbjlGPAyWmkdpYjyMmFAK0DX68va/IZzdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mmKYxI8H; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2260441a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722287952; x=1722892752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyUSF892NOJ6MG7nxjwpZ8iI06oHGrDHdAVAwIjTwbU=;
        b=mmKYxI8HWw40bh1bKb42AjpQ4jTrHf6/qZ5Quj7Hiwi/W/3m1h7CA3QQprIxW4imK4
         OHns7ShM3ReP1GBz5yNSPB9v2W+wSJBgBCuktnE/X0W2P2QK/Y5Bz0jkG3UxtHOg38kx
         CjAlsLSyskVeMR+J3Hrt8d6oODyVOto8iG9MH6Aj/wDrKuLv7+ENulVYZXPHpLr3Jt2/
         ZCftwgkt+C/4NyVBrYsdzfFiqa3X2erhs0nKNRmGsDai2uYkGHkFqtY0LDDo754xY+Ed
         +KowJflm+QlRCe6Z8jBpJs21lL3YnTzOlFUCX84SRKAVVoBxvaT85BS74CFvIwfa0lMj
         LohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287952; x=1722892752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyUSF892NOJ6MG7nxjwpZ8iI06oHGrDHdAVAwIjTwbU=;
        b=ekRDSthYuFcCBzTqAooZ8umONAbaeHK0H9CEaf2KNHBVRHZsgozgbX53bkWs+RIyDp
         WfBvTSNUb/WHR0uaI2s8iGeNa5lPBW+yhqMUe/CrpTkrLKnWTG+vHgg2nq6Wl1oexEnh
         LuQ0zCD+Wd6w7CvXSxn9NgpDwUN0LJ+P5SlyzDJ7URyP5Ih4sxzivIqgrDP9np/B0cxX
         pZ0BTq5Qu8n3cw/Na8KPIA9L4hygq7zvMZNUMqblNObsiw1BVAGZgI8DRrsLS1HftaRe
         ban0yTpDI+GUStvbA9LkgUIWcWttBImYDbhSW9Yqc/yzO1NNoCYZjutB66g3ZX9CVxH+
         pw8w==
X-Forwarded-Encrypted: i=1; AJvYcCVY4XXuQZBRsoY1LUjzao/JlunIl/KrXQCJ2WxwpN8m9nnPZBmSpvaOSTEN8QTZwMCIX+9TUusNcVey3HyMQyzMzLhtz/audaWDO/3d
X-Gm-Message-State: AOJu0YyuavW3OdFOwlkvZ1H6s9CUXnM1Oyhc2Ii5zlOsnMkCR4juNf9O
	vIqZtKFq9qz+jmvbOzyLMcNiezzyOWDmc9a7kVoyT53AH0chnrAyotUdmxKbUtQ=
X-Google-Smtp-Source: AGHT+IF/z7vFXBpkbwGo2dSfp9zS8nlsuYnPbiW2owk7Cruz6E3WWpBR1VfWd18COcQr9qnSdjwN8g==
X-Received: by 2002:a05:6a21:32aa:b0:1c4:98f8:9ccb with SMTP id adf61e73a8af0-1c4a13a33e2mr7666570637.34.1722287951956;
        Mon, 29 Jul 2024 14:19:11 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e12f4sm7248364b3a.32.2024.07.29.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:19:10 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:19:08 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Atish Patra <atishp@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf: Add PERF_EVENT_IOC_SET_EVENT_LIMIT
Message-ID: <ZqgHTKOciVShT8IN@ghost>
References: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>

On Wed, Jul 24, 2024 at 03:54:10PM -0700, Charlie Jenkins wrote:
> My motivation here is to have a program that is able to detect when an
> arbitrary other program has reviewed some number of PMU overflows.
> PERF_EVENT_IOC_REFRESH is not useful in the scenario since that ioctl
> enables the event immediately. This new ioctl flag
> PERF_EVENT_IOC_SET_EVENT_LIMIT allows a program to setup a event_limit
> and then enable the event when ready at some later time.
> 
> This solves the first problem. The second problem that I am debating a
> solution for is that the refresh SIGIO signals are marked as duplicate
> signals and not always delivered to userspace. I will attach a simple
> program below that can be ran a handful of times to catch this behavior.
> REFRESH is supposed to send a SIGIO for every overflow, with an si_code
> of POLL_IN for each signal except the last one which has a si_code of
> POLL_HUP. However, __send_signal_locked() in kernel/signal.c will
> occasionally catch this POLL_HUP signal before all POLL_IN signals have
> been processed, thus treating this signal as a duplicate and dropping
> with this logic:
> 
> 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
> 	/*
> 	 * Short-circuit ignored signals and support queuing
> 	 * exactly one non-rt signal, so that we can get more
> 	 * detailed information about the cause of the signal.
> 	 */
> 	result = TRACE_SIGNAL_ALREADY_PENDING;
> 	if (legacy_queue(pending, sig))
> 		goto ret;
> 

+ Al Viro

Do you have any input into why signals with the same signal number but
different si_code are marked as duplicates of each other? Does it need
to work this way?

- Charlie

> I am sending this patch to begin a conversation on this issue with
> REFRESH. One solution could be to only treat a signal as a duplicate in
> __send_signal_locked() if the si_code is the same. Another solution is
> to only use event_limits with a value of one, as any other number will
> run into this race condition. If consistent signals are desired, sigtrap
> can be used, but that also doesn't support enable_on_exec.
> 
> Here is a minimal test program for dropped signals. Can be ran on a loop until
> program halts waiting for signal that will never arrive.
> 
> while ./signal 1 1; do sleep .01; done
> 
> // signal.c
> 
> int fd;
> pid_t pid;
> 
> struct read_format {
> 	unsigned long long value;
> 	unsigned long long time_enabled;
> 	unsigned long long time_running;
> };
> 
> int counter;
> 
> static inline int sys_perf_event_open(struct perf_event_attr *attr, int pid, int cpu, int group_fd,
> 		        	      unsigned long flags)
> {
> 	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
> }
> 
> static void sig_handler(int signum, siginfo_t *siginfo, void *user_context)
> {
> 	struct read_format rd;
> 	counter++;
> 	read(fd, &rd, sizeof(rd));
> 	printf("fd: %d, signum: %d, si_code: %d, counter: %llu, time to overflow: %llu. time enabled: %llu\n", signum, siginfo->si_fd, siginfo->si_code, rd.value, rd.time_running, rd.time_enabled);
> 	if (counter == REFRESH_COUNT) {
> 		printf("Hit refresh count\n");
> 		close(fd);
> 		kill(pid, SIGKILL);
> 		if (siginfo->si_code == POLL_HUP) {
> 			exit(EXIT_SUCCESS); 
> 		} else {
> 			printf("INCORRECT COUNT! Expected POLL_HUP on second signal.\n");
> 			exit(EXIT_FAILURE); 
> 		}
> 	}
> }
> 
> int main(int argc, char *argv[])
> {
> 	char sbuf[128];
> 
> 	if (argc < 3)
> 		goto invalid_args;
> 
> 	unsigned long long num_instructions = atoll(argv[1]);
> 	unsigned int num_samples = atoi(argv[2]);
> 	unsigned long long sample_periods = num_instructions / num_samples;
> 
> 	pid = fork();
> 
> 	if (pid) {
> 		struct sigaction sa = {
> 			.sa_sigaction = (void *) sig_handler,
> 			.sa_flags = SA_SIGINFO
> 		};
> 		struct perf_event_attr pe = {
> 			.type = PERF_TYPE_HARDWARE,
> 			.size = sizeof(pe),
> 			.config = PERF_COUNT_HW_INSTRUCTIONS,
> 			.sample_period = sample_periods,
> 			.wakeup_events = 1,
> 			.disabled = 1,
> 			.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD,
> 			.read_format = PERF_FORMAT_TOTAL_TIME_RUNNING | PERF_FORMAT_TOTAL_TIME_ENABLED,
> 			.exclude_kernel = 1,
> 			.exclude_idle = 1,
> 			.exclude_hv = 1
> 		};
> 
> 		if (sigaction(SIGIO, &sa, NULL) < 0) {
> 			fprintf(stderr, "FAILED setting up signal handler\n");
> 			exit(EXIT_FAILURE);
> 		}
> 
> 		fd = sys_perf_event_open(&pe, pid, -1, -1, PERF_FLAG_FD_CLOEXEC);
> 
> 		if (fd == -1) {
> 			fprintf(stderr, "FAILED opening perf: %s\n", strerror_r(errno, sbuf, sizeof(sbuf)));
> 			exit(EXIT_FAILURE);
> 		}
> 
> 		ioctl(fd, PERF_EVENT_IOC_RESET, 0);
> 		ioctl(fd, PERF_EVENT_IOC_REFRESH, REFRESH_COUNT);
> 
> 		fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
> 		fcntl(fd, F_SETSIG, SIGIO);
> 		fcntl(fd, F_SETOWN, getpid());
> 
> 		while (1);
> 	} else {
> 		while (1);
> 	}
> 
> invalid_args:
> 	printf("FAILED: Please provide at least 2 args: number of instructions, number of samples. eg: %s 10000 5\n", argv[0]);
> 	exit(EXIT_FAILURE);
> }
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Charlie Jenkins (2):
>       perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
>       perf: Document PERF_EVENT_IOC_SET_EVENT_LIMIT
> 
>  include/linux/perf_event.h            |  4 ++--
>  include/uapi/linux/perf_event.h       |  1 +
>  kernel/events/core.c                  | 17 +++++++++++------
>  tools/include/uapi/linux/perf_event.h |  1 +
>  tools/perf/design.txt                 |  5 +++++
>  5 files changed, 20 insertions(+), 8 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240724-perf_set_event_limit-079f1b996376
> -- 
> - Charlie
> 

