Return-Path: <linux-kernel+bounces-224920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908289128B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E02F287D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA915914C;
	Fri, 21 Jun 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrVjJTiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254E57C9A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981970; cv=none; b=qYgICPnLvwB/f7n2tDYxKFkyg+6pOuFtjArxbaTVD2sM6ts7KH2dMAlhAyfP5aqLy9OvE/UWTjnYc2eyfiLfOoiHuAszJNPrljYsgrBugQhEhyU7Kr6tEJm4btMYf8ylX4HU83HMZCP1bWNXbKXJ2vUDEQIs5CGIfqrTXji3G/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981970; c=relaxed/simple;
	bh=HloTSIjxkBdacLL54h/1qwXkr6iCmcyHJkOWNrJztnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruC1GqHEnH5KrWruCyS4R8Eic+icrttjSJTUKDYLVHTp7SDP+FPVeCrRggXJmgd5dDHBqoyjQA6epa1o+A0/tDggFnYvjbb4AMBzNVPfFxxBC9KLJ5+/VKLKe1RnWHu6t6kZOcNix9gcJ+Mqeo1EQO4x65FVTVEYb3h2HOMKVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrVjJTiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE3FC4AF0B;
	Fri, 21 Jun 2024 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981970;
	bh=HloTSIjxkBdacLL54h/1qwXkr6iCmcyHJkOWNrJztnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YrVjJTiKrJoqS4pbAq5txoArql1Sbew4BxZvPpHTsk2PDetz0hui/vXWhDFcqxiwV
	 hTlLbD9hdD9wgYtATDbM8ZGpOAqZU85UsmSbA8eKPqgPsypTaVi26x2woBtYvPM6jr
	 eAuvwN5Z1koETlN9FmrLPVtCthhJ1i2ZFub3gumapzKWuVb9xJ/3C6CKlXud49cdeT
	 ao1CJYg4izBgK3j+bDxNU0igvnLPKGNiAnnOapxpAc3gvvw7r+jKRMp2XXX5jTRfq/
	 gkXIixAKmutDLndKcIVA4MQH9X2PoVU2jKCpmCeSLm87QanEx59zCrt805Uvnz2rQc
	 NtA52MqrfKkpQ==
Message-ID: <ea45abdd-c301-4cf9-abb7-6983b73b2824@kernel.org>
Date: Fri, 21 Jun 2024 16:59:22 +0200
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
Content-Language: en-US
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 16:41, Vineeth Remanan Pillai wrote:
> Sorry that I could not get to reviewing and testing this revision. In
> v6 we had experienced a minor bug where suspend/resume had issues with
> dlserver. Since suspend does not do dequeue, dlserver is not stopped
> and this causes the premature wakeups.

Ouch! I will have a look next week on this. Do you guys know any other bug?

an earlier report without necessarily a fix/work around is a good thing
for us to try to reproduce it/think about it as earlier as we can...

-- Daniel

