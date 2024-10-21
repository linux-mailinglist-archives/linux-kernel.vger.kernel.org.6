Return-Path: <linux-kernel+bounces-374756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4A9A6F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E2E1C2173B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9101CC161;
	Mon, 21 Oct 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMvMrt/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EA191F81;
	Mon, 21 Oct 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528311; cv=none; b=FlZSjDceTrV0AI1Z8vihDelnX3ky+Ht8HwV/YU9TBBfx333vggMZTgPFAhCsqPDFlRQSHjsTLQRGc0uhHVCIQwNtScjFSIxXqP51hgs/3pSOgaFttR8Usxrf135UuJnW9UqrU3fmrS9Ms0oa5Yqu+kykE4sqEPKSeBLtFOdHQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528311; c=relaxed/simple;
	bh=sQ0x/Wz1DFne7tpBH3VPLt6J1dTHAYiRYKKRTRgEkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SLjZB/uIzd8XOoqcM3CR4hSVIW0wvU4SZ8hySEoiJFYnXvbAgT4hoDsV7K1AMplOtzPjwrerHZ7X6C+rZJ9Y4gSSUPI1mBFFDNo92mtLjRYxhY5Xj/YBQSuU2QqpMd8L4V+5GTcjo7wfppW/3WvJ+YAakHnCZiCl6rWK7SXdsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMvMrt/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B47C4CEC3;
	Mon, 21 Oct 2024 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729528310;
	bh=sQ0x/Wz1DFne7tpBH3VPLt6J1dTHAYiRYKKRTRgEkIk=;
	h=Date:From:To:Cc:Subject:From;
	b=nMvMrt/cBqrgCptZnLYecNbi9tfjjXyK3HLCoXUMOA3T6ChrcsP9tN3wTlZoC24jN
	 8kH7CFV17oR3gr3ls3fEDUTGChbnDzEpqZi7xmgE8N0li1yqpEs2faeYRIx8Zz6FPr
	 0RUR91AvP/IRItBePpePXmRrGuzByjoU8S1X8M1SF2fD//IQSGOzqdubSEV6sJnTas
	 zeeXMGODpL6u1pCtm5OFWc4DrpL6fNsiHt4Vcv8u1rOqX9ICs/DnalCmj6wBBNoKOf
	 nmxrOVErZ01W1xUnZvJE3JxoyXsSQO93Wonjmx7QGepJukscr699JUxYFIxgBYQQSM
	 WVhjKmEeO0L6A==
Date: Mon, 21 Oct 2024 12:07:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: torvalds@linux-foundation.org
Cc: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxZ8MStt4e8JXeJb@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi folks,

The linux-next tree we all know and love is widely used by the kernel
community for integration work. It offers several advantages:

	1. Early detection of conflicts between matinainer trees

	2. Catching most new build errors/warnings

However, it faces significant testing challenges:

	1. Contains a mix of "ready-to-go" code and experimental additions

	2. A single "bad" piece of code can affect testing of everything else

	3. Low barrier of entry, encouraging inclusion over exclusion

	4. While linux-next offers early conflict resolution and
	identifies build issues, it is very difficult to actually test
	due to the abundance of runtime issues it tends to have

These factors combine to make linux-next a valuable tool for integration
but problematic for comprehensive testing.

During the Maintainer's Summit, Linus Torvalds expressed concerns about
the quality of testing that code receives before he pulls it. The
subsequent discussion side-tracked to the testability of linux-next, but
we didn't directly address Linus's original concern about pre-pull
testing quality.

In an attempt to address the concerns, we're trying out a new "linus-next"
tree is being created and maintained with the following characteristics:

	1. Composed of pull requests sent directly to Linus

	2. Contains branches destined for imminent inclusion by Linus

	3. Higher code quality expectation (these are pull requests that
	maintainers expect Linus to pull)

	4. Continuous tree (not daily tags like in linux-next),
	facilitating easier bisection

The linus-next tree aims to provide a more stable and testable
integration point compared to linux-next, addressing the runtime issues
that make testing linux-next challenging and focusing on code that's
about to be pulled by Linus.

linus-next is (expected to be) particularly effective before the merge
window opens, as maintainers tend to send their pull requests early,
allowing for more thorough testing of to-be-merged changes.

We also want to avoid altering the existing workflow. In particular:

	1. No increase in latency. If anything, the expectation is that
	the cadence of merges would be improved given that Linus will
	need to do less builds and tests.

	2. Require "sign up" for the tree like linux-next does. Instead,
	pull requests are monitored and grabbed directly from the
	mailing list.

Tree location: `git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git linus-next`

Current testing:
   - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
   - KernelCI: https://t.ly/KEW7F

Feedback and suggestions for improving usability are welcome!

-- 
Thanks,
Sasha

