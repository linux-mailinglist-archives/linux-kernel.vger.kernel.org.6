Return-Path: <linux-kernel+bounces-341009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BB987A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0473E1F22E03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78917C985;
	Thu, 26 Sep 2024 20:38:14 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1213B2A5;
	Thu, 26 Sep 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727383094; cv=none; b=DWfK7ZdHG1qgL9gSuWIal6P28BS2I3uWn+VJx11KIeIduQQtQGOAt0BLCBCwjXvqi9If4d6eci4Lvs3hrOisH35+PJI0L1F34Ov8OjnJGVZ+oHz7rIfPTk7UZJRqH61PH1eh8YKhIebWVGEsd3nstiWhb1gyfBrr7j2Y4ljjnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727383094; c=relaxed/simple;
	bh=ZmO9mvtQiOwOBdBfEIKsnB6Lc6J9K0yLRi5zWeoS+Lg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=JNK0MoF/ghD7gm61VNCE8aiY3j+rziBwtEBz6dIS1m6KVmg4pEnK6WDE14+n1Ry+v3LSNtkMUIhtP1KA5QbdeSOO9X6BoRBt6a0SCr5M8VZfqpyBtYObQHNjx7MyhrYk332IW8mlNpgmWn3LAjxPqyI2NVijfCCEt6z7IqG9awY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:53332)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stvFV-009Mja-7V; Thu, 26 Sep 2024 14:38:05 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:50320 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stvFU-0088nz-8s; Thu, 26 Sep 2024 14:38:04 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,  Kees Cook <kees@kernel.org>,
  linux-kernel@vger.kernel.org,  Allen Pais <apais@linux.microsoft.com>,
  Brian Mak <makb@juniper.net>,  Jeff Xu <jeffxu@chromium.org>,  Roman
 Kisel <romank@linux.microsoft.com>,  regressions@lists.linux.dev
References: <202409160138.7E27F1A55@keescook>
	<d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
	<CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com>
	<874j625j1a.fsf@email.froward.int.ebiederm.org>
	<CAHk-=wg==rBvM9G4kkT3q5GQN2Pq3M7Vyu1VG+QS7XWmpshGYw@mail.gmail.com>
Date: Thu, 26 Sep 2024 15:37:57 -0500
In-Reply-To: <CAHk-=wg==rBvM9G4kkT3q5GQN2Pq3M7Vyu1VG+QS7XWmpshGYw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 26 Sep 2024 12:17:58 -0700")
Message-ID: <87ldze2lsq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1stvFU-0088nz-8s;;;mid=<87ldze2lsq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX197w9cMvDMmM/mW2YfRpnWpDiFiY5OEfpE=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 390 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 15 (3.9%), b_tie_ro: 13 (3.3%), parse: 1.17
	(0.3%), extract_message_metadata: 19 (4.8%), get_uri_detail_list: 2.7
	(0.7%), tests_pri_-2000: 14 (3.6%), tests_pri_-1000: 2.4 (0.6%),
	tests_pri_-950: 1.51 (0.4%), tests_pri_-900: 1.17 (0.3%),
	tests_pri_-90: 78 (20.1%), check_bayes: 76 (19.6%), b_tokenize: 7
	(1.8%), b_tok_get_all: 10 (2.5%), b_comp_prob: 3.2 (0.8%),
	b_tok_touch_all: 51 (13.0%), b_finish: 1.27 (0.3%), tests_pri_0: 240
	(61.7%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 3.6
	(0.9%), poll_dns_idle: 1.93 (0.5%), tests_pri_10: 3.5 (0.9%),
	tests_pri_500: 10 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: regressions@lists.linux.dev, romank@linux.microsoft.com, jeffxu@chromium.org, makb@juniper.net, apais@linux.microsoft.com, linux-kernel@vger.kernel.org, kees@kernel.org, vegard.nossum@oracle.com, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 26 Sept 2024 at 12:10, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> One of the common causes for coredump truncation is weird interactions
>> between io_uring and the coredump code.  (AKA kernel bugs).
>>
>> That is something you can't ask your debugger to tell you.
>>
>> So from 10,000 feet I think the idea is sane.
>
> What? No. Adding printk's to chase kernel bugs is certainly a
> time-honored tradition. But we don't leave them in the kernel sources
> for posterity.

No argument from me there.  We certainly don't leave them enabled by
default.  Although in truth most of the failures the coredump code
can experience are cases that should never happen in normal operation.

> And none of the coredumpo failure reports had anything to do with
> io_uring bugs anyway. They were literally "print out when disk filled
> up or core dumps weren't enabled".

dump_interrupted was instrumented.  That is what io_uring was
triggering.  In fact dump_interrupted still has problems with I think
dumping to a pipe.

> If you didn't get a core dump because the kernel didn't have core
> dumps configured, we shouldn't print out some babying kernel message
> about that.

Some of them are certainly silly, or excessive.

> None of this has anything to do with io_uring or kernel bugs.

I respectfully disagree.

A huge part of the problem is that when io_uring triggers
dump_interrupted it is so subtle people don't have a clue what is going
on.  Not that I am saying it is necessarily io_uring that is just the
one I have debugged and tried to sort out.  Other kernel subsystems
could have similar weird interactions, but io_uring where it plays with
TIF_NOTIFY_SIGNAL has caused problems in the past.

I don't vouch for this implementation or think it is necessarily
the right way to get better information out, but the coredump code
is very much a black box that is quite difficult for people to work
with.

What I know is that recently truncated core dumps have been on peoples
radar enough that we received two separate patches from two different
organizations to do something about them.  That says to me that this an
actual problem that people are experiencing, not some theoretical thing.

I am all for reverting code that doesn't work, and for looking for
better solutions, but simply saying to people their pain is not a real
problem.  That seems terribly wrong.

Eric

