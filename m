Return-Path: <linux-kernel+bounces-423974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACAC9DAEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79864166A90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4512036E7;
	Wed, 27 Nov 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3t9bZ8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA213D518;
	Wed, 27 Nov 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742761; cv=none; b=KAWw1x1bzSmcBth5yXGwtogXE0FDvvILpkpW/U8b4cBhz5KP1v/4AzWt+FjJ/QjBYcy981OyFbDhKwKIyN+4/Hrni89at7VMu6n1+cQaZPqpIES6wVya/2tsKDZ7wS1pQUGSnJ7Hw9tYym/l2yy9felnCE4FwMtUVGzQ5DxirV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742761; c=relaxed/simple;
	bh=RrHDVweNwvoqrOMwYtZp9qluVuL3gDi+cBfsfnkg6Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etWq8W4CHZ5FyxqlmQIer/oWpWTOhyn+a+Yesozwo1JQa6LHKIEXe2k34Tk+VZni5Us+862ptuptUkDY7NHbUttXqYumuYfVLc/CPDpip1RoNmYhth43OZoOeJ58uLW318bX/oIG1Bl/D9dD6IAsjqTDRsiJSRiGLHhRis8I2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3t9bZ8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAFC4CED2;
	Wed, 27 Nov 2024 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732742761;
	bh=RrHDVweNwvoqrOMwYtZp9qluVuL3gDi+cBfsfnkg6Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A3t9bZ8EmXIioTHMce62anSQn+jiH5uF/rZyxanOkDQJTerumAdx6BvH5CUUsYVJY
	 /FqFUQGppa67XuiFZ9AkIgMmjCuGgQXl5XFZY3t741JUj5LIJ3SXK4EwbXSvP2aneT
	 3ua+zeVZDXd4LWpXvuq2wTnL/7UQSVPj6fIN+cjiFwVUCDEhgf0efVqY9rmFbmxxn8
	 I0j+DJGmy1npu6wud1U7fF129t/G923zKnTTXC+by5V/0dI0GrL4d0DaWYwWEk+pME
	 ryFsL/TTc2wFoSYXhUjuX+A7WRBWaOg6wHYeaqQILgET258ezYH79S2JJhRkP0hIwf
	 yzFaJNvlNoEsQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt
 improvements
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Date: Wed, 27 Nov 2024 22:25:57 +0100
Message-ID: <87frncmkre.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adding Steven.

Andy Chiu <andybnac@gmail.com> writes:

> This series makes atmoic code patching possible in riscv ftrace. A
> direct benefit of this is that we can get rid of stop_machine() when
> patching function entries. This also makes it possible to run ftrace
> with full kernel preemption. Before this series, the kernel initializes
> patchable function entries to NOP4 + NOP4. To start tracing, it updates
> entries to AUIPC + JALR while holding other cores in stop_machine.
> stop_machine() is required because it is impossible to update 2
> instructions, and be seen atomically. And preemption must have to be
> prevented, as kernel preemption allows process to be scheduled out while
> executing on one of these instruction pairs.
>
> This series addresses the problem by initializing the first NOP4 to
> AUIPC. So, atmoic patching is possible because the kernel only has to
> update one instruction. As long as the instruction is naturally aligned,
> then it is expected to be updated atomically.
>
> However, the address range of the ftrace trampoline is limited to +-2K
> from ftrace_caller after appplying this series. This issue is expected
> to be solved by Puranjay's CALL_OPS, where it adds 8B naturally align
> data in front of pacthable functions and can  use it to direct execution
> out to any custom trampolines.
>
> The series is composed by three parts. The first part cleans up the
> existing issues when the kernel is compiled with clang.The second part
> modifies the ftrace code patching mechanism (2-4) as mentioned above.
> Then prepare ftrace to be able to run with kernel preemption (5,6)
>
> An ongoing fix:
>
> Since there is no room for marking *kernel_text_address as notrace[1] at
> source code level, there is a significant performance regression when
> using function_graph with TRACE_IRQFLAGS enabled. There can be as much as
> 8 graph handler being called in each function-entry. The current
> workaround requires us echo "*kernel_text_address" into
> set_ftrace_notrace before starting the trace. However, we observed that
> the kernel still enables the patch site in some cases even with
> *kernel_text_address properly added in the file While the root cause is
> still under investagtion, we consider that it should not be the reason
> for holding back the code patching, in order to unblock the call_ops
> part.

Maybe Steven knows this from the top of his head!

As Andy points out, "*kernel_text_address" is used in the stack
unwinding on RISC-V. So, if you do a tracing without filtering *and*
TRACE_IRQFLAGS, one will drown in traces.

E.g. the ftrace selftest:
  | $ ./ftracetest -vvv test.d/ftrace/fgraph-multi.tc

will generate a lot of traces.

Now, if we add:
--8<--
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc b=
/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
index ff88f97e41fb..4f30a4d81d99 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
@@ -84,6 +84,7 @@ cd $INSTANCE2
 do_test '*rcu*' 'rcu'
 cd $WD
 cd $INSTANCE3
+echo '*kernel_text_address' > set_ftrace_notrace
 echo function_graph > current_tracer
=20
 sleep 1
-->8--

The graph tracer will not honor the "set_ftrace_notrace" in $INSTANCE3,
but still enable the *kernel_text_address traces. (Note that there are
no filters in the test, so *all* ftrace recs will be enabled.)

Are we holding the graph tracer wrong?


Happy thanksgiving!
Bj=C3=B6rn

