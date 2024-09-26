Return-Path: <linux-kernel+bounces-340960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8E987987
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64061C23C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1279716630E;
	Thu, 26 Sep 2024 19:10:09 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553761D5AC5;
	Thu, 26 Sep 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377808; cv=none; b=FU0RgyNAMO0JPWFCpIUd//qgJIrBhmqA8cI+ksqlG+rsumluuv0OQgxCnQcjrpc+Tr5EbWW1lFolch9Ndiu/M+HgC7F35MLIkMseizpBEEGx0L0BAEC5PCeTX05aL/MDS4U9nvZRovJ7piq4tZXMibA+xOgfsm8FNHKNufiXkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377808; c=relaxed/simple;
	bh=ZtuoSr9+AcXFNWqNVKenoqBbJvNgqAXYmZYFVmzCG0E=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=YMr228E1F6WP+mVD77akJX6d2bD9K7KTUTAO0mFy2xtIN19NoEq57ZglVMdx3/V+3SMb61zm2F7eJHRr1PPPjBtg2JRIjiiY8xL/hsuZvh1AW8FKHMwD9HVdqxWR4rR8jH0CiQDVOLU3LfV6w/SSGZuCVwx9/f54Tnq4X3e4rDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:58936)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sttsL-0037Ht-DA; Thu, 26 Sep 2024 13:10:05 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:44600 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sttsK-00AixJ-HD; Thu, 26 Sep 2024 13:10:05 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,  Kees Cook <kees@kernel.org>,
  linux-kernel@vger.kernel.org,  Allen Pais <apais@linux.microsoft.com>,
  Brian Mak <makb@juniper.net>,  Jeff Xu <jeffxu@chromium.org>,  Roman
 Kisel <romank@linux.microsoft.com>,  regressions@lists.linux.dev
References: <202409160138.7E27F1A55@keescook>
	<d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
	<CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com>
Date: Thu, 26 Sep 2024 14:09:21 -0500
In-Reply-To: <CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 26 Sep 2024 11:43:22 -0700")
Message-ID: <874j625j1a.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sttsK-00AixJ-HD;;;mid=<874j625j1a.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+6Y7As3H8gP8wwbRtjmJCtv27Hx7/LaTY=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4983]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 307 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 8 (2.7%), b_tie_ro: 7 (2.3%), parse: 0.82 (0.3%),
	extract_message_metadata: 11 (3.5%), get_uri_detail_list: 0.93 (0.3%),
	tests_pri_-2000: 14 (4.4%), tests_pri_-1000: 2.5 (0.8%),
	tests_pri_-950: 1.19 (0.4%), tests_pri_-900: 0.95 (0.3%),
	tests_pri_-90: 95 (31.0%), check_bayes: 94 (30.5%), b_tokenize: 5
	(1.8%), b_tok_get_all: 4.8 (1.6%), b_comp_prob: 2.0 (0.7%),
	b_tok_touch_all: 78 (25.5%), b_finish: 0.82 (0.3%), tests_pri_0: 161
	(52.4%), check_dkim_signature: 0.71 (0.2%), check_dkim_adsp: 2.8
	(0.9%), poll_dns_idle: 0.90 (0.3%), tests_pri_10: 2.1 (0.7%),
	tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: regressions@lists.linux.dev, romank@linux.microsoft.com, jeffxu@chromium.org, makb@juniper.net, apais@linux.microsoft.com, linux-kernel@vger.kernel.org, kees@kernel.org, vegard.nossum@oracle.com, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 26 Sept 2024 at 11:29, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>> # first bad commit: [fb97d2eb542faf19a8725afbd75cbc2518903210]
>> binfmt_elf, coredump: Log the reason of the failed core dumps
>>
>> I have to admit I don't immediately see what's wrong with the patch.
>
> That commit looks entirely broken.
>
> I *suspect* that the problem is the crazy "get_task_comm()" in that
> takes the task lock inside coredump_report_failure().
>
> But honestly, I'm not going to bother even trying to debug this. The
> whole notion was broken. People who have problems with truncated
> core-files should be looking at their debuggers, not asking the kernel
> for help.

One of the common causes for coredump truncation is weird interactions
between io_uring and the coredump code.  (AKA kernel bugs).

That is something you can't ask your debugger to tell you.

So from 10,000 feet I think the idea is sane.

Eric

