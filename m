Return-Path: <linux-kernel+bounces-208220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AE90227E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21AF1F21BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25472823CB;
	Mon, 10 Jun 2024 13:15:49 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BA4501B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025348; cv=none; b=NbsgWiFwb2ZyKqz9hkbeM41OBlVTuTzP4UAeMdro+OSv9NfxE4Ojb1IGLPu68dMhrQ/tByLWnAeMvzLP3EDPwxu0se+eD4byJcIxhU9FNi3ObvPUByiW5EdfE5v0QGTXqy+JYHE97NrmLcIVhodGDeVxWDUWO1LtX/oNLj58RyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025348; c=relaxed/simple;
	bh=9bEWqJnLSb5dIy8d++RUCBQVhWWIm218oHNDiRmcECo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=gadRfjhFuPQOdF5z8O4siYDhStTSM4Gq6Hj//i9ZlsD4SJfaWnSpvPcL83mg0TmVR1SsYCk++FMFNopB2g6+qiIogXJJSbZ3Xv6EpdNjjfcWHxyd8j3cPeDOP30vkdwBvtUODSZC/Vu1J17zMCvSvc2UxL+C5QcwiaYq43XwR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:34336)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sGdwM-0068VY-IK; Mon, 10 Jun 2024 06:15:58 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49164 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sGdwL-00AkLa-Aa; Mon, 10 Jun 2024 06:15:58 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240609142342.GA11165@redhat.com>
Date: Mon, 10 Jun 2024 07:15:02 -0500
In-Reply-To: <20240609142342.GA11165@redhat.com> (Oleg Nesterov's message of
	"Sun, 9 Jun 2024 16:23:42 +0200")
Message-ID: <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sGdwL-00AkLa-Aa;;;mid=<87r0d5t2nt.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/90GW62Ma1o8FMMT4UgLYPDrWPv3uutuI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4978]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 355 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.4 (1.2%), b_tie_ro: 3.1 (0.9%), parse: 1.02
	(0.3%), extract_message_metadata: 4.0 (1.1%), get_uri_detail_list:
	1.78 (0.5%), tests_pri_-2000: 3.0 (0.9%), tests_pri_-1000: 1.94 (0.5%),
	 tests_pri_-950: 1.09 (0.3%), tests_pri_-900: 0.82 (0.2%),
	tests_pri_-90: 119 (33.4%), check_bayes: 117 (33.0%), b_tokenize: 4.4
	(1.2%), b_tok_get_all: 56 (15.8%), b_comp_prob: 2.5 (0.7%),
	b_tok_touch_all: 51 (14.4%), b_finish: 0.66 (0.2%), tests_pri_0: 205
	(57.7%), check_dkim_signature: 0.37 (0.1%), check_dkim_adsp: 2.4
	(0.7%), poll_dns_idle: 1.00 (0.3%), tests_pri_10: 1.75 (0.5%),
	tests_pri_500: 6 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> Hello,
>
> Eric, I can't understand why the commit ("signal: Guarantee that
> SIGNAL_GROUP_EXIT is set on process exit") added the new
> quick_threads counter. And why, if we forget about --quick_threads,
> synchronize_group_exit() has to take siglock unconditionally.
> Did I miss something obvious?

At a minimum it is the exact same locking as everywhere else that sets
signal->flags, signal->group_exit_code, and signal->group_stop_count
uses.

So it would probably require some significant reason to not use
the same locking and complicate reasoning about the code.  I suspect
setting those values without siglock held is likely to lead to
interesting races.

May I ask which direction you are coming at this from?  Are you trying
to reduce the cost of do_exit?  Are you interested in untangling the
mess that is exiting threads in a process?

I have a branch around that I was slowly working through to detangle
the entire mess.  And if you are interested I can dig it back up.
My memory is I had all of the known issues worked through but I still
needed to feed the code through code review and merge it in small steps
to ensure I don't introduce regressions.

That is where signal->quick_threads comes from.  In the work it is a
part of I wind up moving the decrement up much sooner to the point where
individual threads decide to exit.  The decrement of signal->live comes
much too late to be useful in that context.

It is also part of me wanting to be able to uniformly use
SIGNAL_GROUP_EXIT and signal->group_exit_code when talking about the
process state, and p->exit_code when talking about the per task state.

At the moment I am staring at wait_task_zombie and trying to understand
how:

	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
		? p->signal->group_exit_code : p->exit_code;

works without any locks or barriers.

Eric







