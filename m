Return-Path: <linux-kernel+bounces-223937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6880911A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FE2834D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAE137775;
	Fri, 21 Jun 2024 05:47:13 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAE13699E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948832; cv=none; b=uCCCR2RA1qn3WEuSeXs556ONUehpm3pXQbuI0Oa4Fgxd62Z4HuDix08nkYpWuq4cq5khMqJjaZhWgg7cr80zJYiM1scc206aBUU9QGnNCG3/tvtQECS2Vvt69juJjRSeoG7xXEvfdbfKcD5okiN7HoFmhvlTz5JMtCWGNyiJWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948832; c=relaxed/simple;
	bh=ClD5XEoChg+MURjDPcYB0UiROtr4843NdmqsXRuM4v8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ZOq6cLN1krzgzBoqIqOYCkq6aVR6YimUhzIBx1uch8tAkUMuYTKL7Q0cpdsxpcx0sfNuEx64An73ehOM55QodOWriQy/iZ96Rx9BAzvfn3bLinmdTdYv9x6t/ZFM17P2qHnOX24suzIa8FPFTnrDg2xrrCSKmewKUaQAh67N/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:47652)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sKX71-000CEV-Cu; Thu, 20 Jun 2024 23:47:03 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:34496 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sKX70-008p7B-C2; Thu, 20 Jun 2024 23:47:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
	<20240610152902.GC20640@redhat.com>
	<20240613154541.GD18218@redhat.com>
	<87ikyamf4u.fsf@email.froward.int.ebiederm.org>
	<20240617183758.GB10753@redhat.com>
	<87iky5k2yi.fsf@email.froward.int.ebiederm.org>
	<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
	<87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
	<20240619155016.GC24240@redhat.com>
	<87cyocerda.fsf@email.froward.int.ebiederm.org>
	<20240619191105.GE24240@redhat.com>
Date: Fri, 21 Jun 2024 00:46:15 -0500
In-Reply-To: <20240619191105.GE24240@redhat.com> (Oleg Nesterov's message of
	"Wed, 19 Jun 2024 21:11:06 +0200")
Message-ID: <874j9mdf14.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sKX70-008p7B-C2;;;mid=<874j9mdf14.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/xha5W1X2licUXIpVEEYb0Xg5Aqdj9vRo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4994]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 428 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.3 (1.0%), b_tie_ro: 3.0 (0.7%), parse: 0.78
	(0.2%), extract_message_metadata: 3.2 (0.7%), get_uri_detail_list:
	1.69 (0.4%), tests_pri_-2000: 3.1 (0.7%), tests_pri_-1000: 1.83 (0.4%),
	 tests_pri_-950: 1.08 (0.3%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 83 (19.4%), check_bayes: 82 (19.1%), b_tokenize: 6
	(1.5%), b_tok_get_all: 8 (2.0%), b_comp_prob: 2.00 (0.5%),
	b_tok_touch_all: 62 (14.4%), b_finish: 0.81 (0.2%), tests_pri_0: 314
	(73.2%), check_dkim_signature: 0.40 (0.1%), check_dkim_adsp: 2.9
	(0.7%), poll_dns_idle: 1.49 (0.3%), tests_pri_10: 2.8 (0.7%),
	tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/19, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Hi Eric,
>> >
>> > I'll _try_ to read this (nontrivial) changes this week. To be honest,
>> > right now I don't really understand your goals after the quick glance...
>> >
>> > So far I have only looked at this simple 1/17 and it doesn't look right
>> > to me.
>>
>> It might be worth applying them all on a branch and just looking at the
>> end result.
>
> Perhaps. Say, the next 2/17 patch. I'd say it is very difficult to understand
> the purpose unless you read the next patches. OK, at least the change log
> mentions "in preparation".
>
>> > 	- complete_signal() won't be called, so signal->group_exit_code
>> > 	  won't be updated.
>> >
>> > 	  coredump_finish() won't change it too so the process will exit
>> > 	  with group_exit_code == signr /* coredumping signal */.
>> >
>> > 	  Yes, the fix is obvious and trivial...
>>
>> The signal handling from the coredump is arguably correct.  The process
>> has already exited, and gotten an exit code.
>
> And zap_process() sets roup_exit_code = signr. But,
>
>> But I really don't care about the exit_code either way.  I just want to
>> make ``killing'' a dead process while it core dumps independent of
>> complete_signal.
>>
>> That ``killing'' of a dead process is a completely special case.
>
> Sorry I fail to understand...
>
> If the coredumping process is killed by SIGKILL, it should exit with
> group_exit_code = SIGKILL, right? At least this is what we have now.

In general when a fatal signal is sent:
- It is short circuit delivered.
- If SIGNAL_GROUP_EXIT is not set
   SIGNAL_GROUP_EXIT is set
   signal->group_exit_code is set

Under those rules group_exit_code should not be updated.  Frankly no
signals should even be processed (except to be queued) after a fatal
signal comes in.

There is an issue that short circuit delivery does not work on coredump
signals (because of the way the coredump code works).  So it winds up
being zap_threads that tests if SIGNAL_GROUP_EXIT is already set and
zap_process that sets SIGNAL_GROUP_EXIT.  Essentially the logic remains
the same, and importantly no later signal is able to set
group_exit_code.  Or really have any effect because the signal sent was
fatal.

Except except except when the kernel in the context of the userspace
process is writing a coredump for that userspace process.  Then we allow
the kernel to be sent SIGKILL to stop it's coredumping activities
because sometimes it can block indefinitely otherwise.

Which is why I call handling that SIGKILL after a coredump has
begun and SIGNAL_GROUP_EXIT is already set a completely special case.

We might have to change group_exit_code to SIGKILL in that special case,
if someone in userspace cares.  However I expect no one cares.

Further if adding support for SIGKILL during a coredump were being added
from scratch.  The semantics I would choose would be for that SIGKILL
and indeed all of the coredumping activity would be invisible to
userspace except for the delay to make it happen.  Otherwise a coredump
which every occasionally gets it's return code changed could introduce
heisenbugs.

But none of this is documented in the change description and at a bare
minimum this change of behavior should be before such code is merged.

Eric


