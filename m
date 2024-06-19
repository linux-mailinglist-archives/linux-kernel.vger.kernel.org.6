Return-Path: <linux-kernel+bounces-220461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D990E211
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70B0B21D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4F2B9D9;
	Wed, 19 Jun 2024 03:49:07 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83A2139D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768947; cv=none; b=MdTo26cemKEvxp1Ffc+xRfkC3b2JvOfh7XOjqWcdclwmQWDJVR8T8yNvc5wyWP4GlZ+Qu3es18oJ59dwHOtDeUMArxnbjP7Jz0M1Sa9HINu8rTFP8DTX28w+ehBqAAo85VXMjzziqAAGYxLjZr/bhmzyR2OmyFfWb5gw3iGfnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768947; c=relaxed/simple;
	bh=hMfWCV5rPdHLI8whranjvyQPCWL5gxSb4ppvQkYyuOQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=rsZfzdvOxbhrIdfKFEnK/Lfbhjj2OxGohvrWPEaDwlgErPgCIsllgJ6MHoNYQWNVRGKarZ6AqeCBWrIY5GfKSyT+Cf4zAKfmsLhQaatSeh3YL8yeksDxlO76hKAqWCvhW6FQHyA7uZKWQW3fnmuwnuXja2QR6gYJFh5dQrABbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:56304)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmJj-005sxs-IC; Tue, 18 Jun 2024 21:49:03 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:45498 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmJi-002plo-IB; Tue, 18 Jun 2024 21:49:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240609142342.GA11165@redhat.com>
	<87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
	<20240610152902.GC20640@redhat.com>
	<20240613154541.GD18218@redhat.com>
	<87ikyamf4u.fsf@email.froward.int.ebiederm.org>
	<20240617183758.GB10753@redhat.com>
Date: Tue, 18 Jun 2024 22:48:21 -0500
In-Reply-To: <20240617183758.GB10753@redhat.com> (Oleg Nesterov's message of
	"Mon, 17 Jun 2024 20:37:58 +0200")
Message-ID: <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmJi-002plo-IB;;;mid=<87iky5k2yi.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+RVzC0SnFLqPTWAtLmORSCXqDZCIsTpXw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 386 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.16
	(0.3%), extract_message_metadata: 4.8 (1.2%), get_uri_detail_list: 2.4
	(0.6%), tests_pri_-2000: 3.2 (0.8%), tests_pri_-1000: 2.3 (0.6%),
	tests_pri_-950: 1.21 (0.3%), tests_pri_-900: 0.96 (0.2%),
	tests_pri_-90: 76 (19.6%), check_bayes: 74 (19.2%), b_tokenize: 7
	(1.8%), b_tok_get_all: 6 (1.6%), b_comp_prob: 2.7 (0.7%),
	b_tok_touch_all: 55 (14.2%), b_finish: 0.90 (0.2%), tests_pri_0: 263
	(68.2%), check_dkim_signature: 0.51 (0.1%), check_dkim_adsp: 2.5
	(0.7%), poll_dns_idle: 0.74 (0.2%), tests_pri_10: 3.0 (0.8%),
	tests_pri_500: 10 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/15, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Eric, do you agree with this patch or not?
>>
>> I really don't.
>
> OK, I won't insist.
>
> If nothing else, I failed to remove the usage of signal->live in cgroup.c
> and this patch (supposed to be a cleanup) can slightly affect the cgroup
> iterators.
>
> But. You didn't mention cgroups, so lets forget cgroups to simplify this
> discussion.
>
> So. I would like to see at least ONE _technical_ objection to this patch.
>
> Once again, I was worried about this cleanup from the very beginning, that is
> why I asked you to review. Thanks for taking a look. But could you help me to
> understand what exactly you don't like?
>
>> I think skipping some work if SIGNAL_GROUP_EXIT is already
>> set is not necessarily wrong.
>
> OK, so you seem to agree with this part after all.
>
>> I think we need the quick_threads count,
>
> And so far I fail to understand this,
>
>> and related cleanups.
>> I was hoping to be able to post a patchset with this reply
>> to explain things, but it looks like that is still a couple
>> of days off.
>
> OK. This looks as if I need to wait for your cleanups to understand
> why do we need quick_threads even if we move atomic_dec_and_test(live)
> to the very start of do_exit().
>
> Okay, I'll have to wait.

I am just about to post it.

The patchset should be be good enough to answer what I think needs to
happen with quick_threads.  I don't know if it is good enough to merge
yet, I resurrected, rebased against v6.10-rc3, reviewed and compiled it
but I haven't actually tested the code.

> And. To me the current placement of atomic_dec_and_test(signal->live)
> looks "random" no matter what. Even if we forget about cgroups.

Ah yes sorting out signal->live.

The history shows the placement was one of convenience just putting
it where it should go.

The big issue is the code does not have a piece of cleanup code that
runs once there are no more users of signal_struct.  So we get
``process'' level cleanup all over the place.

The function __exit_signal(tsk) when "thread_group_leader(tsk) == true"
which implies "thread_group_empty(tsk) == true" is about as close as we
get.

I had a patchset where I was working to remove the concept of
thread_group_leaders.  I remember by moving the code between do_exit and
__exit_signal I could make things a lot cleaner.  I would have to dig it
out to see what I was really able to accomplish.

I also remember that the cgroup iterators where somewhat hopeless when
there were zombie thread group leaders.

Eric

