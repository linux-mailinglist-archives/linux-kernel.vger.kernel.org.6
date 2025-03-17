Return-Path: <linux-kernel+bounces-564013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB326A64C03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ED81882963
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27D62356AF;
	Mon, 17 Mar 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IadPcq2s"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A81459F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210028; cv=none; b=cP4VbVXswZ4fmcPEIZugEWGBy0jUJYoLU/ZwDByFgxWND/Yg2nXU0VI6ZmDNNOjXtf3Wok0/+3umX7C+iwNpW7scbcenI+zSLoND6ZfqgjkssRME+bvszaxHgM//ElGERkM6yO+atk+4NILl8HiYLpGF1ylHDIVvipmCsCeODwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210028; c=relaxed/simple;
	bh=xw5h74oVLVylYI5bZeBkKiOS0IU0zUQTdKe9On/NycQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gs7D0R/65qFCpm85ibIeVvxJoZMk4euUSDRW8MD89C/BI3616OOcHEf+TkcYW5qv2+SPVagZWCcku8rTT+DClqihxbRP0PCXSfkJBnY9SnN81DtI4HsSBwRGgKDKJxNvbbExtc6Dh4nfAklKGQSaMObnHT95hc15RDJjXJgxYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IadPcq2s; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1742210024;
	bh=QmYJK6DbOMSaneqCEueu5eJ3peh4bmGZrCrSWkmUiLA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=IadPcq2s0qAUW2pyCB3wc5wE4JkOC1NlqDkMJTAWwDYTyLpFgdkbzR6RxlymHxYP3
	 840MBpY0FB5Y5/gXmCwDbOiLo92gysYBsV9nb1OxKkNMfw7+W8I+poWzLQLzDADV10
	 zRVzeH0n2OfUtYKPlap4d3jDwqQXrFgxvPhb7BdxhQG7wKMILt0wij5ru/KgxW8XBj
	 Pd5ALvUbfAMzfMv7Tr7w84DLC2ncaHd7UkgmhAGgekOriJeKzMAhick6APckwzn6aW
	 RJNggJ1nnTh1/v4QI+PxuDd8ShNpvGkVbANNr6BlVEpYtmQWpVPBMwCU6xslrwi0PV
	 z6rcO5tyNqqQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZGXQw0MgHz4x8W;
	Mon, 17 Mar 2025 22:13:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [main-line][PowerPC]selftests/powerpc/signal: sigfuz fails
In-Reply-To: <5f88a95b-1c8d-4a74-9753-9cdb2e64daf4@linux.ibm.com>
References: <5f88a95b-1c8d-4a74-9753-9cdb2e64daf4@linux.ibm.com>
Date: Mon, 17 Mar 2025 22:13:41 +1100
Message-ID: <87v7s7di56.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:
> Greetings!!
>
> I am observing selftests/powerpc/signal:sigfuz test fails on linux 
> mainline repo on IBM Power10 systems.
>
> The test passes on the kernel with commit head: 
> 619f0b6fad524f08d493a98d55bac9ab8895e3a6 and fails on the kernel with 
> commit head: ce69b4019001407f9cd738dd2ba217b3a8ab831b on the main line.
>
>
> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> I tried to do git bisect and the bisect tool pointed first bad commit 
> to: 16ebb6f5b6295c9688749862a39a4889c56227f8.
>
> But upon reverting the first bad commit issue is still seen. So please 
> ignore, if the bisection dosent help.
>
>
> Error:
>
> # selftests: powerpc/signal: sigfuz
> # test: signal_fuzzer
> # tags: git_version:v6.14-rc7-1-g49c747976afa
> # !! killing signal_fuzzer
> # !! child died by signal 15
> # failure: signal_fuzzer
> not ok 3 selftests: powerpc/signal: sigfuz # exit=1

That error means the test is timing out and being killed by the test
harness.

That could be due to a bug, but it could just be that your system is
overloaded or something. You can increase the timeout in the code by
adding a call to test_harness_timeout().

The test also includes lots of randomisation, so if you actually need to
bisect it you'd want to change the code to use a consistent random seed
in the calls to srand().

cheers

