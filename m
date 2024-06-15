Return-Path: <linux-kernel+bounces-215912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91F9098BA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DF3B21A77
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768649632;
	Sat, 15 Jun 2024 14:54:19 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2591DDF5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463259; cv=none; b=sVcUcjkPCX8vkbhN+Ya/fb2g4DwBuIzmHspFNOoX1Rx1kdvAZevOKkokAyJgmojlVwhUL5pOvIzCAKw2W5wUKddVOmrM1xeOecVU5OQj6hDdiT17RWEhdiLkrhC434b/LJC4cvbdN7Z+kpZ896aBmLFuE2FBAuqw7KbgFtAuOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463259; c=relaxed/simple;
	bh=GiTLolI8/+VouHpYOaQjCwZfZHeuLNqH8afStKeCyMw=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=rP9o8QFMwx0OLG1WAjYXULv51kvCFK/tEM730BmUtlSKwzOTt/vHiOKH3TLFnm6xjJLIlwFwjd0wlw5JHmQSrq+TNLMsxVBi8GXSn4C+GE0tYFgXHPmyBIg9Ooa0CIOdA6N9mRvG95JjPAWwnoMWkoxiZ90iS9t3YLZLZLGqVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:43078)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sIUnD-007mrm-4l; Sat, 15 Jun 2024 08:54:11 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56192 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sIUnC-00FDhC-CC; Sat, 15 Jun 2024 08:54:10 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240609142342.GA11165@redhat.com>
	<87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
	<20240610152902.GC20640@redhat.com>
	<20240613154541.GD18218@redhat.com>
Date: Sat, 15 Jun 2024 09:53:21 -0500
In-Reply-To: <20240613154541.GD18218@redhat.com> (Oleg Nesterov's message of
	"Thu, 13 Jun 2024 17:45:42 +0200")
Message-ID: <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sIUnC-00FDhC-CC;;;mid=<87ikyamf4u.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX194SSDtlIahBGSmT2L+QMDJNQJJ8cJuGnc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4991]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 229 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.1 (1.8%), b_tie_ro: 2.8 (1.2%), parse: 0.96
	(0.4%), extract_message_metadata: 2.9 (1.3%), get_uri_detail_list:
	0.86 (0.4%), tests_pri_-2000: 3.1 (1.4%), tests_pri_-1000: 1.96 (0.9%),
	 tests_pri_-950: 1.15 (0.5%), tests_pri_-900: 0.83 (0.4%),
	tests_pri_-90: 76 (33.2%), check_bayes: 75 (32.7%), b_tokenize: 3.4
	(1.5%), b_tok_get_all: 4.5 (1.9%), b_comp_prob: 1.24 (0.5%),
	b_tok_touch_all: 63 (27.4%), b_finish: 0.81 (0.4%), tests_pri_0: 121
	(53.1%), check_dkim_signature: 0.36 (0.2%), check_dkim_adsp: 2.3
	(1.0%), poll_dns_idle: 0.84 (0.4%), tests_pri_10: 1.73 (0.8%),
	tests_pri_500: 7 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> So...
>
> Eric, do you agree with this patch or not?

I really don't.

I think skipping some work if SIGNAL_GROUP_EXIT is already
set is not necessarily wrong.

I think we need the quick_threads count, and related cleanups.
I was hoping to be able to post a patchset with this reply
to explain things, but it looks like that is still a couple
of days off.

Where I was going, and where I think we should go with quick_threads is
an exit path that is much easier to reason about and maintain.  But the
decrement needs to move into the same code that sets SIGNAL_GROUP_EXIT.
Which makes it something very different from signal->live.

Eric

