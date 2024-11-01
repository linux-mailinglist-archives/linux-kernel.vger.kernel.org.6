Return-Path: <linux-kernel+bounces-392893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D49B995A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB9B21174
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7671CEAD7;
	Fri,  1 Nov 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdVQB2/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1F1D12E6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492538; cv=none; b=uyCZEEXFqTBhGJZOhV2VgxnlwmpfM8rLqgFD80XOuBw/bBtzUaNxfTkDsvTxVBVnLioCd07M5czMHRswn/bto6z1l9JuzyP6jFC6GrW5waQIKNcjVEgj9hzud5/SkfaZ4lZQQ8cd6DlPmcJFGfhaz9nVc8vLp8Pdu7SsgLtnYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492538; c=relaxed/simple;
	bh=Q8qMIkvgAUV0sQEVO/D0O2loWnDp9f8oZ0Jzjg/HVo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY04FFGTMCSemhiL1JjBVN57w66eCuWMzng0QTD9y7VXTWmz5s3yi/vrfKvNzn/osUY1jhyqQzLlQEFhuCLxIyLKyCJPAbhqhdBbnJC1e5rAD/SCX5e9YQ1uf3U4ar2C2/QVBhEy4onJZ1Xt8xOMT3Dl0braYQzCSY4T8go2UW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdVQB2/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E1AC4CECD;
	Fri,  1 Nov 2024 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730492538;
	bh=Q8qMIkvgAUV0sQEVO/D0O2loWnDp9f8oZ0Jzjg/HVo8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IdVQB2/W3zePqmo/C1G5bBqw5+SAfyI0/Apr5mQFvMwW0/Olj7oKpPXW0TN9MT9wm
	 HYlm5TYLsj5d6pVtj/LRFXu0P3hwko8mmIea8r9cjgeUkrblad8mzZEYG3nFhh2nn5
	 y1JMR12QoDaFvtBVPcHR2EarKjhVZ/rruefwqpxzfAovadYViDbdqu7HiDaKnTUv2i
	 rE+zAQtxVTgoAi1TB9YsoN+H8FbSwp0gy8xYp4joHMt3W4IHNpB/GU13lI0Z9L/e7p
	 +tizU68IF+VVednK7SwgHTC4FDc11ZaXMwKvmAw+Z25/ijfnAgaAm9zLxd2AT00ef8
	 tAFuYYuDb3jGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EBF3FCE0F74; Fri,  1 Nov 2024 13:22:17 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:22:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>

On Fri, Nov 01, 2024 at 02:22:13PM +0000, Thomas Weißschuh wrote:
> (resend to add missing Cc: LKML)
> 
> 
> Hi Paul,
> 
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1
> 
> for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:
> 
>   selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)

Thank you!  I have pulled this into -rcu at signed tag nolibc.2024.11.01a,
which copies from your signed tag.

The usual "make run" and "make user" worked fine, but "make libc-test"
gave me the build errors shown below.  Is there some setup step that
I omitted?  Or is this not really a necessary test?

							Thanx, Paul

------------------------------------------------------------------------

  CC      libc-test
nolibc-test.c: In function ‘run_syscall’:
nolibc-test.c:1083:63: warning: argument 1 null where non-null expected [-Wnonnull]
 1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
      |                                                               ^~~~
nolibc-test.c:358:77: note: in definition of macro ‘EXPECT_SYSER2’
  358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
      |                                                                             ^~~~
nolibc-test.c:1083:47: note: in expansion of macro ‘EXPECT_SYSER’
 1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
      |                                               ^~~~~~~~~~~~
In file included from nolibc-test.c:26:
/usr/include/x86_64-linux-gnu/sys/stat.h:205:12: note: in a call to function ‘stat’ declared ‘nonnull’
  205 | extern int stat (const char *__restrict __file,
      |            ^~~~
nolibc-test.c: In function ‘run_stdlib’:
nolibc-test.c:1137:75: warning: implicit declaration of function ‘strlcat’; did you mean ‘strncat’? [-Wimplicit-function-declaration]
 1137 |                 CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 0), buf, 3, "test"); break;
      |                                                                           ^~~~~~~
nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
  613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
      |                                                                                ^~~~
nolibc-test.c:1143:75: warning: implicit declaration of function ‘strlcpy’; did you mean ‘strncpy’? [-Wimplicit-function-declaration]
 1143 |                 CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
      |                                                                           ^~~~~~~
nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
  613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
      |                                                                                ^~~~
nolibc-test.c: In function ‘run_syscall’:
nolibc-test.c:358:62: warning: argument 1 is null but the corresponding size argument 2 value is 1 [-Wnonnull]
  358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
      |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nolibc-test.c:361:9: note: in expansion of macro ‘EXPECT_SYSER2’
  361 |         EXPECT_SYSER2(cond, expr, expret, experr, 0)
      |         ^~~~~~~~~~~~~
nolibc-test.c:1073:47: note: in expansion of macro ‘EXPECT_SYSER’
 1073 |                 CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
      |                                               ^~~~~~~~~~~~
In file included from /usr/include/poll.h:1,
                 from nolibc-test.c:35:
/usr/include/x86_64-linux-gnu/sys/poll.h:54:12: note: in a call to function ‘poll’ declared with attribute ‘access (write_only, 1, 2)’
   54 | extern int poll (struct pollfd *__fds, nfds_t __nfds, int __timeout)
      |            ^~~~
/usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
nolibc-test.c:(.text+0x44f9): undefined reference to `strlcat'
/usr/bin/ld: nolibc-test.c:(.text+0x4580): undefined reference to `strlcat'
/usr/bin/ld: nolibc-test.c:(.text+0x4607): undefined reference to `strlcat'
/usr/bin/ld: nolibc-test.c:(.text+0x468e): undefined reference to `strlcat'
/usr/bin/ld: nolibc-test.c:(.text+0x4715): undefined reference to `strlcat'
/usr/bin/ld: /tmp/ccvUtmw4.o:nolibc-test.c:(.text+0x479c): more undefined references to `strlcat' follow
/usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
nolibc-test.c:(.text+0x4823): undefined reference to `strlcpy'
/usr/bin/ld: nolibc-test.c:(.text+0x48aa): undefined reference to `strlcpy'
/usr/bin/ld: nolibc-test.c:(.text+0x4931): undefined reference to `strlcpy'
/usr/bin/ld: nolibc-test.c:(.text+0x49b8): undefined reference to `strlcpy'
/usr/bin/ld: nolibc-test.c:(.text+0x4a3f): undefined reference to `strlcpy'
collect2: error: ld returned 1 exit status
make: *** [Makefile:230: libc-test] Error 1

