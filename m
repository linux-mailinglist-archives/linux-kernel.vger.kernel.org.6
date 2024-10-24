Return-Path: <linux-kernel+bounces-379504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A69ADF68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E131C21BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2E1B0F10;
	Thu, 24 Oct 2024 08:45:09 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA01B0F05
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759508; cv=none; b=HtMBmXkxlFpIili+F2yZSN0izHlQjB1yu/eHFAjU1w7OSYYpqdJsTQtN5kvWt0uXmeAucePwxvyBCVIk9FwNwxdu0KXF27blTHpReQ6rQ/70pbA4usW2rhCv+yYWnGO49xH0jDw8mPlCZcDn3XbKS8pCYnOoACMWSeLzSMzkzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759508; c=relaxed/simple;
	bh=RpDomQY8AcTLwZOZzDF5l2omeCsT9B67nCDuMaaiLxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgAzPVo/FTt9iHJBandAfq+uI4xKMbM0BwksfjEzBBUoal4YyRzLZwAPk4mYrwfrEIOZPPXgPG8aMlcR03cMcxV09wskO7jZ1W5R8n5r1Kv5bM142cTp8GHiKVlmlD+95oKjGqfQQSqSs83QT5DBn9tOy3DuFJiPvGiYPDS3Pxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz9t1729759397tyg969r
X-QQ-Originating-IP: F4j1YRIOQd8QQeb0FCatxM/m13zHDva7rd0KWi104eI=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Oct 2024 16:43:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12981368116427560855
Date: Thu, 24 Oct 2024 16:43:04 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	npiggin <npiggin@gmail.com>, "luming.yu" <luming.yu@gmail.com>
Subject: Re: [PATCH 1/7] powerpc/entry: convert to common and generic entry
Message-ID: <55B30F12C81A25B9+ZxoGx55aKtK7pSNx@HX09040029.powercore.com.cn>
References: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
 <e9595d8b-d1e2-4c6a-b097-6f4f08d29866@csgroup.eu>
 <tencent_381ACB160B890CC46678170E@qq.com>
 <87o73b37pw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o73b37pw.fsf@mail.lhotse>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OO87pPbfd04fXqrus5GM8rNOk7ewXC8ypwJOrvZ5Jdq9pNdqbaTG3CN1
	9HswsiDDlLiGuyA7vJP4wKR4AAtOR3on1C1zwbtUgadz/+zrsi8Kf3rxNIyTO2pdShgVeOC
	Zlx81Q7RisPOX9NbTrhGM7BtzSlg63FaT2/0eeyk01NYTZn9I/Jw+cwjKM+/tj83lJA8r6s
	fNe01e7YzwSZrRpa21r5oLf9U0YO4lD7hxYG6oMnaUrsyOM7t6xUWp9i5LS66492S6NkoFN
	22PToeLgr424RiNgZIuNg3YhjxT6WvpsmjJ+U/UxkG4/ffIjK4NPbYo/Ak/7xF/aORjgkaj
	lxeeXo0wOMARHHkLuuZJ91RUAgVhuxQmJvM19pfOt5gFwQhvtAE1rP5hU1t+DU9upoedpZA
	FcYIBFOOtfaiHwkX6tZoCbvtcAv/2BFllJ51h0FvIEN9i2PcJbm44ZMSc+ecScxNljsydcs
	GJo6Gq4EoqSWuZWosvNnzWqENY4/YDJywKVC1yvuekICfMqj0FbIsYRTfzJJPO9BkjjQCsW
	4jZj2LxE708yyZn0vBcAf8UYCmCl65rP75THvKaby4k58k+cAECV6Jwp5Oyt/0BiF/yHk9L
	1vvWILf0QDqbS53DKoJsBUdXLWIeY43Fn2ZBPWlh6b2WzFKCgYQA4T6X8+FfJ565cLtXH06
	xG7jgRlsn/+OZV+kwU1vVDgI6bJJLD1ARm9aeZCrgFGXIdIxo2j+VFpyoxN2OX5zRzOtppQ
	6kCAQbPIMk+ya/uprZEwA+9q5MImIOpgRUtnSCM0DlLfMxLZLnjEP/lzO4igQAftlf7+uDx
	vbmlA0KVKFSqRu+LNJt+JGtiqrW92Pk9A3Mw0KLn90dUM8OD9I4LTiRPM9Q8x7ptsum3B0H
	3qSS4iecW8SuJXk+uh+tR7P/Behb8ed7m+r5LXf0wzm15i8wDeVaFTICQJrwZuupNyaZdKA
	LKG41yP0AW3KvZA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Oct 23, 2024 at 12:53:47PM +1100, Michael Ellerman wrote:
> "虞陆铭" <luming.yu@shingroup.cn> writes:
> >>Le 12/10/2024 à 05:56, Luming Yu a écrit :
> >>> convert powerpc entry code in syscall and fault to use syscall_work
> >>> and irqentry_state as well as common calls implemented in generic
> >>> entry infrastructure.
> >>> 
> >>> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> >>> ---
> >>>   arch/powerpc/Kconfig                   | 1 +
> >>>   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
> >>>   arch/powerpc/include/asm/processor.h   | 6 ++++++
> >>>   arch/powerpc/include/asm/syscall.h     | 5 +++++
> >>>   arch/powerpc/include/asm/thread_info.h | 1 +
> >>>   arch/powerpc/kernel/syscall.c          | 5 ++++-
> >>>   arch/powerpc/mm/fault.c                | 3 +++
> >>>   7 files changed, 25 insertions(+), 1 deletion(-)
> >>> 
> >>
> >>...
> >>
> >>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> >>> index 77fedb190c93..e0338bd8d383 100644
> >>> --- a/arch/powerpc/kernel/syscall.c
> >>> +++ b/arch/powerpc/kernel/syscall.c
> >>> @@ -3,6 +3,7 @@
> >>>   #include <linux/compat.h>
> >>>   #include <linux/context_tracking.h>
> >>>   #include <linux/randomize_kstack.h>
> >>> +#include <linux/entry-common.h>
> >>>   
> >>>   #include <asm/interrupt.h>
> >>>   #include <asm/kup.h>
> >>> @@ -131,7 +132,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >>>   		 * and the test against NR_syscalls will fail and the return
> >>>   		 * value to be used is in regs->gpr[3].
> >>>   		 */
> >>> -		r0 = do_syscall_trace_enter(regs);
> >>> +		r0 = syscall_enter_from_user_mode(regs, r0);
> >>
> >>Can you provide details on how this works ?
> > I assume the common entry would take over th details.
> > So I just made the switch from the high level call.
> >
 > As you said as the subtle ABI requirement about regs->r3 needs to
> > be restored, I'm wondering which test can capture the lost
> > ABI feature. As simple Boot test is insufficient, what is the test set
> > that can capture it?
> 
> The seccomp selftest did exercise it back when I originally wrote that
> code. I don't know for sure that it still does, but that would be a good
> start.
> 
> It's in tools/testing/selftests/seccomp/
Thanks for the hint.
It seems to be running into some not ok cases the way hits the bpf test that doesn't return. 
I will re-run with the same kernel w/o the patch-set to sort out the cases that could be
caused by the patch Then I will try to debug out the root cause.
[root@10 seccomp]# make -C tools/testing/selftests TARGETS=seccomp run_tests
make: Entering directory '/root/linux-ci/tools/testing/selftests/seccomp'
make: *** tools/testing/selftests: No such file or directory.  Stop.
make: Leaving directory '/root/linux-ci/tools/testing/selftests/seccomp'
[root@10 seccomp]# pwd
/root/linux-ci/tools/testing/selftests/seccomp
[root@10 seccomp]# cd /root/linux-ci/
[root@10 linux-ci]# make -C tools/testing/selftests TARGETS=seccomp run_tests
make: Entering directory '/root/linux-ci/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..2
# timeout set to 180
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..98
# # Starting 98 tests from 8 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# # seccomp_bpf.c:359:mode_strict_cannot_call_prctl:Expected 0 (0) == true (1)
# # seccomp_bpf.c:360:mode_strict_cannot_call_prctl:Unreachable!
# # mode_strict_cannot_call_prctl: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.mode_strict_cannot_call_prctl
# not ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# # seccomp_bpf.c:621:unknown_ret_is_kill_inside:Expected 0 (0) == syscall(__NR_getpid) (1406)
# # seccomp_bpf.c:622:unknown_ret_is_kill_inside:getpid() shouldn't ever return
# # unknown_ret_is_kill_inside: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.unknown_ret_is_kill_inside
# not ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# # seccomp_bpf.c:643:unknown_ret_is_kill_above_allow:Expected 0 (0) == syscall(__NR_getpid) (1407)
# # seccomp_bpf.c:644:unknown_ret_is_kill_above_allow:getpid() shouldn't ever return
# # unknown_ret_is_kill_above_allow: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.unknown_ret_is_kill_above_allow
# not ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# # KILL_all: Test exited normally instead of by signal (code: 0)
# #          FAIL  global.KILL_all
# not ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# # seccomp_bpf.c:690:KILL_one:Expected 0 (0) == syscall(__NR_getpid) (1409)
# # KILL_one: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.KILL_one
# not ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# # seccomp_bpf.c:726:KILL_one_arg_one:Expected 0 (0) == syscall(__NR_times, &fatal_address) (4295224651)
# # KILL_one_arg_one: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.KILL_one_arg_one
# not ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# # KILL_one_arg_six: Test exited normally instead of by signal (code: 0)
# #          FAIL  global.KILL_one_arg_six
# not ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# # seccomp_bpf.c:856:KILL_thread:Expected SIBLING_EXIT_FAILURE (195951310) != (unsigned long)status (195951310)
# # seccomp_bpf.c:881:KILL_thread:Expected 0 (0) != WIFEXITED(status) (0)
# # KILL_thread: Test terminated by assertion
# #          FAIL  global.KILL_thread
# not ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# # seccomp_bpf.c:856:KILL_process:Expected SIBLING_EXIT_FAILURE (195951310) != (unsigned long)status (195951310)
# # seccomp_bpf.c:901:KILL_process:Expected SIGSYS (31) == WTERMSIG(status) (6)
# # KILL_process: Test terminated by assertion
# #          FAIL  global.KILL_process
# not ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# # seccomp_bpf.c:856:KILL_unknown:Expected SIBLING_EXIT_FAILURE (195951310) != (unsigned long)status (195951310)
# # seccomp_bpf.c:922:KILL_unknown:Expected SIGSYS (31) == WTERMSIG(status) (6)
# # KILL_unknown: Test terminated by assertion
# #          FAIL  global.KILL_unknown
# not ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# # seccomp_bpf.c:974:ERRNO_valid:Expected E2BIG (7) == errno (9)
# # ERRNO_valid: Test failed
# #          FAIL  global.ERRNO_valid
# not ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# # seccomp_bpf.c:992:ERRNO_zero:Expected 0 (0) == read(-1, NULL, 0) (-1)
# # ERRNO_zero: Test failed
# #          FAIL  global.ERRNO_zero
# not ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# # seccomp_bpf.c:1014:ERRNO_capped:Expected 4095 (4095) == errno (9)
# # ERRNO_capped: Test failed
# #          FAIL  global.ERRNO_capped
# not ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# # seccomp_bpf.c:1045:ERRNO_order:Expected 12 (12) == errno (9)
# # ERRNO_order: Test failed
# #          FAIL  global.ERRNO_order
# not ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# # syscall_restart: Test terminated by timeout
# #          FAIL  global.syscall_restart
# not ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# # seccomp_bpf.c:3239:filter_flag_log:Expected 0 (0) == syscall(__NR_getpid) (1482)
# # filter_flag_log: Test exited normally instead of by signal (code: 1)
# #          FAIL  global.filter_flag_log
# not ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# # seccomp_bpf.c:3397:user_notification_basic:Expected 0 (0) == WEXITSTATUS(status) (1)
# # user_notification_basic: Test terminated by timeout
# #          FAIL  global.user_notification_basic
# not ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# # user_notification_kill_in_middle: Test terminated by timeout
# #          FAIL  global.user_notification_kill_in_middle
# not ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# # user_notification_signal: Test terminated by timeout
# #          FAIL  global.user_notification_signal
# not ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# # seccomp_bpf.c:3647:user_notification_closed_listener:Expected 0 (0) == WEXITSTATUS(status) (1)
# # user_notification_closed_listener: Test failed
# #          FAIL  global.user_notification_closed_listener
# not ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# # user_notification_child_pid_ns: Test terminated by timeout
# #          FAIL  global.user_notification_child_pid_ns
# not ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# # seccomp_bpf.c:3728:user_notification_sibling_pid_ns:Expected 0 (0) == WEXITSTATUS(status) (1)
# # seccomp_bpf.c:3764:user_notification_sibling_pid_ns:Expected 0 (0) == WEXITSTATUS(status) (1)


> 
> cheers
> 


