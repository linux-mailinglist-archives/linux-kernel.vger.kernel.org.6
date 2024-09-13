Return-Path: <linux-kernel+bounces-328936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90D978B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE401C2326B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBEF1714AA;
	Fri, 13 Sep 2024 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs+LpAzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563241547EB;
	Fri, 13 Sep 2024 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264811; cv=none; b=VtPjxllqURA8ZK4mvABibzpONJOQteYiGtDd4E8gb85u2jLL/nf3XrUtmSJkXtZuMnae896NPLbkzshXy+E5kfxtLCtH2XCAnfkaB4L8RSD6yyiQBp+WC1oDWAkPxtJvzzlhycTAhURcm9NwzGOXG7Qf2h3sAQrvBawzLS3W+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264811; c=relaxed/simple;
	bh=T7zJ51GhAWBjN1SnUe+fJR90Ve3aonwh5XnX5zJ4TgM=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:Subject; b=hvVw6jnPQmasICfUtn1k8ScgCNOzz1/MW3R0gTxFKqtLUicBEe+I5FLQ33SiNQHAPQ3x3BDBAGUKUehGkNfUnpmXhcS6SvmitQ/OJ7S7Kj3CwpGNsQPeGbRzGf5XSxceDJDINj5im7d6Hfys+a3+zpwB4qpKBc9YoD1LPTuI4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs+LpAzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD7EC4CEC0;
	Fri, 13 Sep 2024 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726264810;
	bh=T7zJ51GhAWBjN1SnUe+fJR90Ve3aonwh5XnX5zJ4TgM=;
	h=Date:From:To:Subject:From;
	b=gs+LpAzdC4hUOJVBla7XqjJib1FlUTEN78Q+ffPBjXJ3g/ieVJRLOV5xJE7ViW482
	 Fno5VHtGvjq+EhzfrtwIiGwQ2h3/0zf4rBRWfz+LYhrNqQDWnketepfGjyhNQzm4zT
	 VQDzEXMDGJsxS/trKsTKsswQ20fcS18fZuH5Q2xP5rJvR1tSOZ0836NbAHV+sDgnz+
	 OOMPw/k+kxeyT5dlxk/6EP8sNV5U9ikq6M3kgk7BzbqMuqwrlcTPb2Z9pr6NlFbGkI
	 VigiulyBsA9z/8S/opu6B8DOx4RrqeBHlnhiVmw117zkbZuMZXcacYJcc5Mi5+UEz3
	 n3uF+8fGph+jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B42E3806656;
	Fri, 13 Sep 2024 22:00:13 +0000 (UTC)
Date: Fri, 13 Sep 2024 22:00:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: tglx@linutronix.de, bugs@lists.linux.dev, frederic@kernel.org, 
 anna-maria@linutronix.de, linux-kernel@vger.kernel.org
Message-ID: <20240913-b217598c0-81d4abf24530@bugzilla.kernel.org>
Subject: setitimer works incorrectly
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: bugspray 0.1-dev

vladimir.mezentsev writes via Kernel.org Bugzilla:

A small test below shows the problem with the itimer setting on OL8 (x86_64 / aarch64)

% cat sig.c
#include<stdio.h>
#include <stdlib.h>
#include<signal.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>

#ifndef MY_TIMER
#define MY_TIMER 1000
#endif

static time_t start;
static int sigprof_cnt = 0;

time_t
gethrtime (void)
{
  struct timespec tp;
  time_t rc = 0;
  int r = clock_gettime (CLOCK_MONOTONIC, &tp);
  if (r == 0)
    rc = ((time_t) tp.tv_sec) * 1e9 + (time_t) tp.tv_nsec;
  return rc;
}

static void sigprof_handler(int signo, siginfo_t* info, void *context)
{
  if (++sigprof_cnt >= 3)
    exit(0);
  static struct itimerval t;
  memset(&t, 0, sizeof(t));
  if (getitimer(ITIMER_PROF, &t) != 0)
    printf("getitimer failed\n");
  printf("sigprof_handler: it_interval.tv_sec=%lld it_interval.tv_usec=%lld\n"
         "                    it_value.tv_sec=%lld it_value.tv_usec=%lld\n",
    (long long) t.it_interval.tv_sec, (long long) t.it_interval.tv_usec,
    (long long) t.it_value.tv_sec, (long long) t.it_value.tv_usec);
}

volatile long x; /* temp variable for long calculation */

int
main (int argc, char **argv)
{
  long long count = 0;
  start = gethrtime ();

  struct sigaction sa;
  memset(&sa, 0, sizeof(struct sigaction));
  sa.sa_sigaction = sigprof_handler;
  sa.sa_flags = SA_RESTART | SA_SIGINFO;
  sigemptyset(&sa.sa_mask);

  if (sigaction(SIGPROF, &sa, NULL) == -1)
    {
       perror("sigaction");
       return 1;
    }

  static struct itimerval timer;
  memset(&timer, 0, sizeof(timer));
  timer.it_interval.tv_usec = MY_TIMER;
  timer.it_value.tv_usec = MY_TIMER;
  if (setitimer(ITIMER_PROF, &timer, NULL) != 0)
    {
      printf("Timer could not be initialized \n");
      return 1;
    }

  struct itimerval t;
  memset(&t, 0, sizeof(t));
  if (getitimer(ITIMER_PROF, &t) != 0)
    {
      printf("getitimer failed\n");
      return 1;
    }
  printf("After setitimer: it_interval.tv_sec=%lld it_interval.tv_usec=%lld\n"
         "                    it_value.tv_sec=%lld it_value.tv_usec=%lld\n",
    (long long) t.it_interval.tv_sec, (long long) t.it_interval.tv_usec,
    (long long) t.it_value.tv_sec, (long long) t.it_value.tv_usec);

  do
    {
      x = 0;
      for (int j = 0; j < 1000000; j++)
        x = x + 1;
      count++;
    }
  while (start + 1e9 / 4 > gethrtime ());
  printf("count=%lld  x=%lld\n", count, x);
  return 0;
}



It is from man page:
% man setitimer
...
   setitimer()
       If either field in new_value.it_value is nonzero, then the timer is arme to initially expire at the specified time.


But this is not right on x86_64 and aarch64. I run this test on OL8.

On x86_64 / OL8:
% gcc -DMY_TIMER=1000 sig.c; ./a.out
After setitimer: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0      it_value.tv_usec=2000 <<<<<< this should be <= 1000 because I set it_value.tv_usec to 1000 in setitimer

sigprof_handler: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0      it_value.tv_usec=23
sigprof_handler: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0      it_value.tv_usec=27



On aarch64 / OL8:

% gcc -DMY_TIMER=1000 sig.c; ./a.out
After setitimer: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0 it_value.tv_usec=5000    <<<<<< Same as on x86_64

sigprof_handler: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0 it_value.tv_usec=4000 <<<<<< this must be <= 1000 because it_interval.tv_usec is 1000

sigprof_handler: it_interval.tv_sec=0   it_interval.tv_usec=1000
                    it_value.tv_sec=0      it_value.tv_usec=4000<<<<<< this must be <= 1000 because it_interval.tv_usec is 1000

View: https://bugzilla.kernel.org/show_bug.cgi?id=217598#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


