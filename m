Return-Path: <linux-kernel+bounces-417390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3B9D535A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A9D1F22E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D581BD9F3;
	Thu, 21 Nov 2024 19:22:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DF6F06B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216954; cv=none; b=qdWKF3Cw9lJiZNVCqqmwrvl87D8rX3W4xQvbMy2Mil9eODxyTxSYpMkAmdHzBROEZnx8EpQOHzs+4OdIzGmFS40BmLhHaWENuiqY4n4pIIT/8xag57OK+IV+c8rOlnW+Wnz557bxZrUaJwZbkriEK0SEHGcnzVfvTcx677aAGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216954; c=relaxed/simple;
	bh=ZfqsVVUaqTvCyy9buQcn7f5yL1QqneKRp5dw+MR0EVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX/ANcDEWMY1kyG4beXlkGPd8PMbcydLPwepg9TYtCJJlUnfKOcnV1sE+1isKNj37B/jmZBcVmoZr7gBGXWCOGoCp4X2B2eN/f2FM+bnY5ct5+R/m4pVkV4mQX4w0MuWRADuqUE8hD9t1zTHvLtSCD4ye4jP8sruR+Bf/GJgpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB3C4CECC;
	Thu, 21 Nov 2024 19:22:31 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	broonie@kernel.org,
	jpoimboe@kernel.org,
	kaleshsingh@google.com,
	kristina.martsenko@arm.com,
	linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com,
	maz@kernel.org,
	mbenes@suse.cz,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH] arm64: disable ARCH_CORRECT_STACKTRACE_ON_KRETPROBE tests
Date: Thu, 21 Nov 2024 19:22:29 +0000
Message-Id: <173221694242.390240.12306680698453955259.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118120204.3961548-1-mark.rutland@arm.com>
References: <20241118120204.3961548-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Nov 2024 12:02:04 +0000, Mark Rutland wrote:
> The kprobes_test suite's test_stacktrace_on_nested_kretprobe() test
> currently fails on arm64, e.g.
> 
> | KTAP version 1
> | 1..1
> |     KTAP version 1
> |     # Subtest: kprobes_test
> |     # module: test_kprobes
> |     1..7
> |     ok 1 test_kprobe
> |     ok 2 test_kprobes
> |     ok 3 test_kprobe_missed
> |     ok 4 test_kretprobe
> |     ok 5 test_kretprobes
> |     ok 6 test_stacktrace_on_kretprobe
> |     # test_stacktrace_on_nested_kretprobe: EXPECTATION FAILED at lib/test_kprobes.c:327
> |     Expected stack_buf[i + 1] == target_return_address[1], but
> |         stack_buf[i + 1] == -96519936577004 (0xffffa83733777214)
> |         target_return_address[1] == -96519936577136 (0xffffa83733777190)
> |     # test_stacktrace_on_nested_kretprobe: EXPECTATION FAILED at lib/test_kprobes.c:338
> |     Expected stack_buf[1] == target_return_address[1], but
> |         stack_buf[1] == -96519936577004 (0xffffa83733777214)
> |         target_return_address[1] == -96519936577136 (0xffffa83733777190)
> |     not ok 7 test_stacktrace_on_nested_kretprobe
> | # kprobes_test: pass:6 fail:1 skip:0 total:7
> | # Totals: pass:6 fail:1 skip:0 total:7
> | not ok 1 kprobes_test
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: disable ARCH_CORRECT_STACKTRACE_ON_KRETPROBE tests
      https://git.kernel.org/arm64/c/a63d7408afbd

-- 
Catalin


