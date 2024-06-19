Return-Path: <linux-kernel+bounces-221588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A62F90F5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B1A1C2145C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7352156F3C;
	Wed, 19 Jun 2024 18:11:05 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3D1DA24
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820665; cv=none; b=I6jZ5NFc2hbL/4vceHF24ac72JvDJ2gTusxmpc71vBu8R9PKNIJ1U7UDq1Qja2VEILLlvseUVYi28cWygVhSXwXRrOgpaPECexSCpPFkHhbSxYz7t93seWl1la2GO3MVf7pS3J70oiITATQDH7DOoMU9Z92IcxkQYcfgyVmnXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820665; c=relaxed/simple;
	bh=SynMCTfBv6VlGUBeai3Xy/eaUmYy4Ir+gdHcHvn2W/c=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=STPZmzKBe2MGVS38xPcmpVEgscn9XriNH/STRD3LFuCYCC6p1kW/1JosBXowu/TCv0+vzAHmpM5GqJ+C3q8cquJ9eXCDhb+OQ7m2E/MXU+sgtdxzCvvj8s/9CtR8Z0VUEct7ULMJLGHbs8nWAevJdpLEkYxo5zsBTgc3pc/Q+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:57908)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJzlu-005Tcr-4E; Wed, 19 Jun 2024 12:11:02 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54508 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJzlt-004g6z-5x; Wed, 19 Jun 2024 12:11:01 -0600
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
	<87iky5k2yi.fsf@email.froward.int.ebiederm.org>
	<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
	<87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
	<20240619155016.GC24240@redhat.com>
Date: Wed, 19 Jun 2024 13:09:53 -0500
In-Reply-To: <20240619155016.GC24240@redhat.com> (Oleg Nesterov's message of
	"Wed, 19 Jun 2024 17:50:17 +0200")
Message-ID: <87cyocerda.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJzlt-004g6z-5x;;;mid=<87cyocerda.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/1v+kZn7QX/+iStCn1hhkUqssXFvUuDOM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 386 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.35
	(0.3%), extract_message_metadata: 4.8 (1.2%), get_uri_detail_list: 2.1
	(0.5%), tests_pri_-2000: 4.5 (1.2%), tests_pri_-1000: 3.4 (0.9%),
	tests_pri_-950: 1.67 (0.4%), tests_pri_-900: 1.31 (0.3%),
	tests_pri_-90: 87 (22.5%), check_bayes: 85 (21.9%), b_tokenize: 6
	(1.6%), b_tok_get_all: 7 (1.7%), b_comp_prob: 2.0 (0.5%),
	b_tok_touch_all: 66 (17.2%), b_finish: 0.93 (0.2%), tests_pri_0: 248
	(64.1%), check_dkim_signature: 0.76 (0.2%), check_dkim_adsp: 3.3
	(0.9%), poll_dns_idle: 0.78 (0.2%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> Hi Eric,
>
> I'll _try_ to read this (nontrivial) changes this week. To be honest,
> right now I don't really understand your goals after the quick glance...
>
> So far I have only looked at this simple 1/17 and it doesn't look right
> to me.

It might be worth applying them all on a branch and just looking at the
end result.

The interactions between all of the ways a process can exit wind up
being different, but being clean.

> On 06/18, Eric W. Biederman wrote:
>>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -907,8 +907,12 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>>  	sigset_t flush;
>>  
>>  	if (signal->flags & SIGNAL_GROUP_EXIT) {
>> -		if (signal->core_state)
>> -			return sig == SIGKILL;
>> +		if (signal->core_state && (sig == SIGKILL)) {
>> +			struct task_struct *dumper =
>> +				signal->core_state->dumper.task;
>> +			sigaddset(&dumper->pending.signal, SIGKILL);
>> +			signal_wake_up(dumper, 1);
>> +		}
>
> and after that it returns false so __send_signal_locked/send_sigqueue simply
> return. This means:
>
> 	- the caller will wrongly report TRACE_SIGNAL_IGNORED

Fair.

>
> 	- complete_signal() won't be called, so signal->group_exit_code
> 	  won't be updated.
>
> 	  coredump_finish() won't change it too so the process will exit
> 	  with group_exit_code == signr /* coredumping signal */.
>
> 	  Yes, the fix is obvious and trivial...

The signal handling from the coredump is arguably correct.  The process
has already exited, and gotten an exit code.

But I really don't care about the exit_code either way.  I just want to
make ``killing'' a dead process while it core dumps independent of
complete_signal.

That ``killing'' of a dead process is a completely special case.

Eric

