Return-Path: <linux-kernel+bounces-225083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1F912B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0251F2727F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FA1607AF;
	Fri, 21 Jun 2024 16:42:35 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636D128812
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988155; cv=none; b=gjTWnO6rlenCub8b5OZmA8Oy7lI/AkdqzK1cQk7ydyxrhZF5yickg6nHPCz8LT01PzF+SyFEcrd3Uk1pNmYxzdmc6XXJIYveSKkGW5vgGG+jZwhvl+u51K0PGIwy9goDnuvg2CWUSahxzedtCnk4Tcz11p/sKuf+IqiUfTd2Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988155; c=relaxed/simple;
	bh=qHat51Srve/G3HpQgAsKGy0Go7E4L920HbWq8JbeVE4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=cUl0gbJDRJVD59vK5CXjWrAiSTu5+hNogSpcSHaRGeegvRRfhho4P2Is9d5Pt8xyz9vzJHl3G0Wn5EERR34Rqevfw1qxCatOxq8Rx22ucpIOgxsDVHMzA9juU5GYdRJ9QuG3/b6g+uX+0m7kTnQF01xcK1H90oPJ5pCRuyDonM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:55426)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sKhLG-009GmF-62; Fri, 21 Jun 2024 10:42:26 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41954 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sKhLE-00HICf-Tn; Fri, 21 Jun 2024 10:42:25 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240613154541.GD18218@redhat.com>
	<87ikyamf4u.fsf@email.froward.int.ebiederm.org>
	<20240617183758.GB10753@redhat.com>
	<87iky5k2yi.fsf@email.froward.int.ebiederm.org>
	<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
	<87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
	<20240619155016.GC24240@redhat.com>
	<87cyocerda.fsf@email.froward.int.ebiederm.org>
	<20240619191105.GE24240@redhat.com>
	<874j9mdf14.fsf@email.froward.int.ebiederm.org>
	<20240621104031.GA12521@redhat.com>
Date: Fri, 21 Jun 2024 11:30:32 -0500
In-Reply-To: <20240621104031.GA12521@redhat.com> (Oleg Nesterov's message of
	"Fri, 21 Jun 2024 12:40:32 +0200")
Message-ID: <87ed8qb6mv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sKhLE-00HICf-Tn;;;mid=<87ed8qb6mv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/KpdLaB19z7TGarVpCtNzqFwOpexImbBw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4869]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 10 (2.8%), b_tie_ro: 9 (2.4%), parse: 1.31 (0.4%),
	 extract_message_metadata: 4.1 (1.1%), get_uri_detail_list: 1.65
	(0.5%), tests_pri_-2000: 3.3 (0.9%), tests_pri_-1000: 2.4 (0.7%),
	tests_pri_-950: 1.30 (0.4%), tests_pri_-900: 1.03 (0.3%),
	tests_pri_-90: 99 (27.0%), check_bayes: 97 (26.5%), b_tokenize: 6
	(1.6%), b_tok_get_all: 6 (1.5%), b_comp_prob: 2.3 (0.6%),
	b_tok_touch_all: 80 (21.9%), b_finish: 0.89 (0.2%), tests_pri_0: 223
	(61.0%), check_dkim_signature: 0.62 (0.2%), check_dkim_adsp: 3.1
	(0.9%), poll_dns_idle: 1.29 (0.4%), tests_pri_10: 3.0 (0.8%),
	tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> Another case when I can hardly understand your reply...
>
> This patch adds a minor user visible change, that was my point.
>
> If you say that the new behaviour is better / more consistent -
> I won't really argue, "I expect no one cares" below is probably
> true. In my opinion group_exit_code = SIGKILL makes more sense
> in this special case, but again, I won't insist.
>
> But then this change should be mentioned and explained in the
> changelog, agree?

I very much agree.  It was an oversight and bug not to have included
that in the change description.

> As for "zap_threads that tests if SIGNAL_GROUP_EXIT is already set",
> this is another thing but probably I misundertood you. It is not that
> zap_threads/zap_process do not set ->group_exit_code in this case,
> in this case do_coredump() will be aborted.
>
> And to remind, zap_threads() used to set SIGNAL_GROUP_COREDUMP, not
> SIGNAL_GROUP_EXIT. Because to me the coredumping process is not exiting
> yet, it tries to handle the coredumping signal. That is why I prefer
> group_exit_code = SIGKILL if it is killed during the dump. But this is
> slightly offtopic today.

Slightly.

A major goal of this set of changes is to unify all of the process
teardown in complete_signal, do_group_exit, and zap_process into a
single subroutine for consistency.

When a coredump is not generated the code for dumpable signals and
other fatal signals should be the same.  Including short circuit
delivery.  It isn't today.

My rougher in progress patchset that follows this one makes, teaches
get_signal to dequeue signals that have been processed with short
circuit delivery and makes it so that do_coredump is just a little
bit of extra code that runs.  With the net result that all of the code
is simpler and easier to reason about.

Messing with the coredump code today is a real pain because of io_uring
and those funny interactions.

Eric


