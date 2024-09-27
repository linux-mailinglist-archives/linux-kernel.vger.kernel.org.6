Return-Path: <linux-kernel+bounces-341876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC398879C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D01C225FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5461C0DCD;
	Fri, 27 Sep 2024 14:55:24 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AE101F2
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448924; cv=none; b=OKHrWvsvWZgIs+ORtzSLUEH1gyfotUg2qbfHfvMolgJaM5kRMtj0x/M1Jtk6O+fnqdSSdkU7eo8r6OHXjxwPijMjuBFayXGYUznw2ytBJSOlbN6d7tjkGZh94Xrwf66fBNtd3haCvfBYkcv4jkrtAKIMqay8m7QUoidGdRVMctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448924; c=relaxed/simple;
	bh=1BcQo7dFqxjYIXWFFy38hzmWym4jsbtTJy97mIOi9AQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=K6JiSxqwzznIsMSjZ8TH0n/oHfpr6jqW+/NOG2TIArQay2GNSWd3wS2PwQlNvA9TuUBsRfZU0vEci/U/5ezbXVysE142SrDPBv2TwwFCvABrj7gbMo4S6lONAsHgVjQD30tLq5GHkF5/vOWJU14gVPgLqzoy/ykR3ZgI5V7h3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:46514)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBCl-002OJE-RA; Fri, 27 Sep 2024 07:40:19 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:53350 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBCk-009iOm-Sr; Fri, 27 Sep 2024 07:40:19 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240927083900.989915582@linutronix.de>
	<20240927084817.014903652@linutronix.de>
Date: Fri, 27 Sep 2024 08:40:00 -0500
In-Reply-To: <20240927084817.014903652@linutronix.de> (Thomas Gleixner's
	message of "Fri, 27 Sep 2024 10:48:41 +0200 (CEST)")
Message-ID: <87ldzd1ahb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suBCk-009iOm-Sr;;;mid=<87ldzd1ahb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+VVUFyuGXRsX+Usq7c0mwVzBgSMJ/zS18=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 350 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.0 (1.1%), b_tie_ro: 2.8 (0.8%), parse: 0.65
	(0.2%), extract_message_metadata: 11 (3.2%), get_uri_detail_list: 1.21
	(0.3%), tests_pri_-2000: 11 (3.1%), tests_pri_-1000: 1.97 (0.6%),
	tests_pri_-950: 0.99 (0.3%), tests_pri_-900: 0.78 (0.2%),
	tests_pri_-90: 75 (21.5%), check_bayes: 74 (21.1%), b_tokenize: 5
	(1.5%), b_tok_get_all: 10 (2.9%), b_comp_prob: 1.60 (0.5%),
	b_tok_touch_all: 54 (15.4%), b_finish: 0.64 (0.2%), tests_pri_0: 233
	(66.5%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 2.7
	(0.8%), poll_dns_idle: 1.32 (0.4%), tests_pri_10: 1.66 (0.5%),
	tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch v4 02/27] signal: Prevent user space from setting
 si_sys_private
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: oleg@redhat.com, sboyd@kernel.org, mingo@kernel.org, peterz@infradead.org, jstultz@google.com, frederic@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> The si_sys_private member of siginfo is used to handle posix-timer rearming
> from the signal delivery path. Prevent user space from setting it as that
> creates inconsistent state.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> ---
>  kernel/signal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> ---
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a83ea99f9389..7706cd304785 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3354,6 +3354,14 @@ int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from)
>  static int post_copy_siginfo_from_user(kernel_siginfo_t *info,
>  				       const siginfo_t __user *from)
>  {
> +	/*
> +	 * Clear the si_sys_private field for timer signals as that's the
> +	 * indicator for rearming a posix timer. User space submitted
> +	 * signals are not allowed to inject that.
> +	 */
> +	if (info->si_code == SI_TIMER)
> +		info->si_sys_private = 0;
> +
>  	if (unlikely(!known_siginfo_layout(info->si_signo, info->si_code))) {
>  		char __user *expansion = si_expansion(from);
>  		char buf[SI_EXPANSION_SIZE];


Can we do this differently for maintainability?  The siginfo union sucks
to deal with.

Can we place this test after the !known_siginfo_layout test.

Can you further make the case say something like:

	if ((siginfo_layout(info->si_signo, info->si_code) == SIL_TIMER) &&
            (info->si_sys_private != 0)) {
		return -EINVAL?
        }


Using siginfo_layout is slightly more expensive but it will catch any
future oddness that comes up, and I don't think signal injection is a path
where we need to optimize every last cycle.

Unless we expect userspace to be injecting signals with
info->si_sys_private set to non-zero (and we need to maintain backwards
comparability) it is probably better to simply error.

I unfortunately overlooked this corner case when I cleaned up signal
copying.

Eric




