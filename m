Return-Path: <linux-kernel+bounces-224965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5A912979
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756DDB26FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF894F8BB;
	Fri, 21 Jun 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO5vruJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACF17554
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982999; cv=none; b=FsyXKWdbutjPXjDI0y7VyQFnKG2PGQB+MzfJ2J0Ss4aILpdouwCiDJMbQAO8LuQK5OuAbDvvVeFh081OvNEn1oeGNUj9YPwQ1FKSNRQU+IKXgTlp1TAQ04Yfnkas18rykQdKWpNrmzg0NDDDOfAVC0x2VRPHm/C+FgXyV2k28XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982999; c=relaxed/simple;
	bh=BEgcMrpXviXEcUyWNPzFdkOjUBbxUKOkaq+MN2IQJSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVrp1Hy389H+xvnNmQILz+X7Nn1JB/3caVySO1QtyiL8KJQNmYWthik1VIwk8lwZDuwCdWH4orLgAETvbL54bNQ9P0s21IIGycRPjAzX74Rx9elyAzXTcxp+OPkYGSuGIuQ7govjkf7jK0YKovCZQps3uqNUgQ+NN/X8ES1JI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO5vruJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A16CC2BBFC;
	Fri, 21 Jun 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718982999;
	bh=BEgcMrpXviXEcUyWNPzFdkOjUBbxUKOkaq+MN2IQJSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eO5vruJYjJIuveG4KIRMBCt7oSBEhof924nUfFhiYiUJXsP+Zn+jhKYLKNMEL+/4d
	 Km0eDymAaAsHNCe8DB07c6+yZBChkfU4BUkXMlE/0EFVj6LZeLG/eD5XpH8Pp0OjXL
	 7FgYHrNRQA0T7Rj1fo9cZstG2NzXcAKvMnx/IENJtDVQdKU6Z3mguyueSKTLx8oLLS
	 61KQdwSFmFC/Tu127AzmDqMjILVUgcYtGrWG6z4QsXenFhCQzWnlODBDOVU+v6s0zZ
	 SFXNTv6Dzl90yMpAXCkqNK1EqJ7ukXFJvdkamFvtrgia18FDOCWU1iZtXcyERmKCdP
	 ab325iluRQ3vw==
Message-ID: <466f9ee9-74c5-4e2a-8874-dba549fca2f2@kernel.org>
Date: Fri, 21 Jun 2024 17:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1716811043.git.bristot@kernel.org>
 <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
 <ea45abdd-c301-4cf9-abb7-6983b73b2824@kernel.org>
 <CAO7JXPgmwnn=njmpMVGLNYQ=9hmmRPFeJ5d=o9VW81Vt2k-UwA@mail.gmail.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAO7JXPgmwnn=njmpMVGLNYQ=9hmmRPFeJ5d=o9VW81Vt2k-UwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/21/24 17:09, Vineeth Remanan Pillai wrote:
> On Fri, Jun 21, 2024 at 10:59 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
>>
>> On 6/21/24 16:41, Vineeth Remanan Pillai wrote:
>>> Sorry that I could not get to reviewing and testing this revision. In
>>> v6 we had experienced a minor bug where suspend/resume had issues with
>>> dlserver. Since suspend does not do dequeue, dlserver is not stopped
>>> and this causes the premature wakeups.
>>
>> Ouch! I will have a look next week on this. Do you guys know any other bug?
>>
>> an earlier report without necessarily a fix/work around is a good thing
>> for us to try to reproduce it/think about it as earlier as we can...
>>
> Sorry my mistake, I was buried in other things and missed reporting
> this earlier.

no worries.

> 
> There was another minor regression seen lately after we fixed the
> above issue- idle cpu was spending more time in C7 than C10 with the
> dlserver changes. This was reported very recently and we haven't
> investigated this much yet. Just a heads up and will keep you posted
> as we know more.

Maybe that is an expected side effect because of the timer for the server, AFAIR you
guys are using a short period large runtime (25ms/50ms)?

> Thanks,
> Vineeth


