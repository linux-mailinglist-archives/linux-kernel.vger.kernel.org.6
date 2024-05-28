Return-Path: <linux-kernel+bounces-192373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8118D1C40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F9DB2376D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2AC16DEA5;
	Tue, 28 May 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByLurFYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5617E8F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901978; cv=none; b=AT79RCfvdVVgSY2ka5vlmpBkeAdPB2OA2Jk0Sg6hp4Dgo0xnKfjwFAdIBPAWH7nBa035ZeAgyqF8fRUst7r99DUQMT07cRjOB5hIRx9aEVfq1PCKHms2ivPI670tSXYlBI04N7X3mWrMU7THHw5TdKJH1wjX7B3aA/89Wt8PcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901978; c=relaxed/simple;
	bh=c7qvZMLtwcaBCcqzNvXG3u8PoV1VWFgL+mpS5uwe6VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAA5Xt+DOHsm5n8L656OkyuBbZpWdDp17GkvwnIs36pbL+YN8/mArPoh1ER0TKFuq8J1BrY6NqmRX+Fap6aboC9CQD0rPPgLGK1mTIoM6VGpBGpk7Ny71OjBY2n8vEFyrmsv1BaPpSKY1ncGEMOSsBW3wS0LKjxmWDtrD1Hijs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByLurFYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDFAC3277B;
	Tue, 28 May 2024 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901978;
	bh=c7qvZMLtwcaBCcqzNvXG3u8PoV1VWFgL+mpS5uwe6VA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ByLurFYwP+ca5LoGa/117lIxYv5SaK26oDYHUm5UoctecYjvjmD/rdCD3WFCIvX7y
	 TePuldWxXz2hUqcq95anZQaAOMNhvF5wGSkhcHWJhnd/0c1gCcsXblflw+4LzZurJD
	 WcomV0EK0M5ppPvSPLsTae0VFf/t+nhGcRU6XlQseGqrB6y1iHegI7yYuerBMjtykk
	 cuADQAGgrfAQx73p+l1JzgglZBXmDDTpbrZBAL5GQaFZ+TpEGBcDDQo06sVytcjEYk
	 dtubJdJ7+wjd3IHCUHEwxTnz7QYzlSVHRY112NHgt8gmlmbS51JBiK8ufrcHlNxwV7
	 JPKe/Sq5770nQ==
Message-ID: <cfaabce3-752b-4f38-9e32-06326e646b5e@kernel.org>
Date: Tue, 28 May 2024 15:12:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/35] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
 juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
 sshegde@linux.ibm.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-34-ankur.a.arora@oracle.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240528003521.979836-34-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 02:35, Ankur Arora wrote:
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. And, for PREEMPT_RCU=y configurations does this
> by directly calling rcu_momentary_dyntick_idle().
> 
> With PREEMPT_AUTO=y, however, we can have configurations with
> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above can
> help.
> 
> Handle that by fallback to the explicit quiescent states via
> rcu_momentary_dyntick_idle().
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks
-- Daniel

