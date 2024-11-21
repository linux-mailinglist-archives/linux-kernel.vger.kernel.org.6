Return-Path: <linux-kernel+bounces-416487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF09D45C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52181B221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C123099A;
	Thu, 21 Nov 2024 02:37:18 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05070832
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156637; cv=none; b=ini+x0TmX4yPEU2bqDo5CrxDtc4eaJEKUeuPeYUFcHUJ9Ik5wscFYZNtHnN9/XBllVxJIrxcWaRgzQ6RkVTKU1TGDtZ4+EHJHPoNGYlnLXdSansW21TFxlRQacjhW+4RZsqRUPXWB4nNiL2Yu/6OZxXqkcV432HWHMuLLxIInXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156637; c=relaxed/simple;
	bh=3T4nm8JcUeuS3yNKxSDKI0/FG6ijAeevQwsdmuautpc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=GeNW9EEK/7xdHPOa/jEy9ZhSrKx+He3s+ppjzIFiVaiV7FcoDwLIgAFlN/7YAMJRf8FyWrVUraqufKIEOEaTfGMtQyxj71FrIGXCNQGGyvJNfk3ubx7HQqKjRYQ9d98UfuYUBezkJ1O/2tnV32xpfTr7JhB5H5FNBdn/4v/GEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:36826)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tDvTT-003ZV2-E3; Wed, 20 Nov 2024 17:55:11 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57370 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tDvTS-00C0uV-Cm; Wed, 20 Nov 2024 17:55:11 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,  linux-kernel@vger.kernel.org,  Alexander
 Viro <viro@zeniv.linux.org.uk>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Dan Carpenter
 <dan.carpenter@linaro.org>,  Nir Lichtman <nir@lichtman.org>,
  syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,  Tycho Andersen
 <tandersen@netflix.com>,  Vegard Nossum <vegard.nossum@oracle.com>,
  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
References: <202411190900.FE40FA5@keescook>
	<CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
Date: Wed, 20 Nov 2024 18:54:40 -0600
In-Reply-To: <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 20 Nov 2024 14:32:44 -0800")
Message-ID: <87jzcxv227.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tDvTS-00C0uV-Cm;;;mid=<87jzcxv227.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18xqtstsJUx61B9m5BjgPgOf2rN86il+7o=
X-Spam-Level: ****
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3125]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
	*  1.0 XMSexyCombo_01 Sexy words in both body/subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 460 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.5 (1.0%), b_tie_ro: 3.2 (0.7%), parse: 1.26
	(0.3%), extract_message_metadata: 11 (2.5%), get_uri_detail_list: 2.2
	(0.5%), tests_pri_-2000: 4.2 (0.9%), tests_pri_-1000: 2.0 (0.4%),
	tests_pri_-950: 0.97 (0.2%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 107 (23.2%), check_bayes: 105 (22.7%), b_tokenize: 7
	(1.5%), b_tok_get_all: 10 (2.2%), b_comp_prob: 2.6 (0.6%),
	b_tok_touch_all: 82 (17.8%), b_finish: 0.76 (0.2%), tests_pri_0: 312
	(67.7%), check_dkim_signature: 0.40 (0.1%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 1.59 (0.3%), tests_pri_10: 2.8 (0.6%),
	tests_pri_500: 11 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: zbyszek@in.waw.pl, vegard.nossum@oracle.com, tandersen@netflix.com, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, nir@lichtman.org, dan.carpenter@linaro.org, christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, kees@kernel.org, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 19 Nov 2024 at 09:00, Kees Cook <kees@kernel.org> wrote:
>>
>> - exec: Use argv[0] for "comm" with AT_EMPTY_PATH (Tycho Andersen,
>>   Dan Carpenter, Nir Lichtman)
>
> Ugh. I *really* despise this one.
>
> People: we *have* a filename. It's right there in the dentry. Which is
> right there as bprm->file->f_dentry.dentry.

__set_task_comm cannot be called with bprm->file->f_dentry
unconditionally.  That will break userspace.  On at least debian using
/etc/alternatives there are a lot of symlinks to executables.

For example if I run "vi", two symlinks are followed:
/usr/bin/vi -> /etc/alternatives/vi
/etc/alternatives/vi -> usr/bin/vim.nox

Seeing "vim.nox" in ps instead "vi" would be weird and break tooks like
psgrep.

https://lore.kernel.org/all/Zv1OayMEmLP2kjhj@kawka3.in.waw.pl/

The reason bprm->file->f_dentry.dentry was abandoned were concerns
about breaking userspace.


Limited to just the binaries that systemd wants to call.  I don't know
if symlinks to binaries matters.  At a quick skim I couldn't see
anything but *shrug*.


> And that's actually going to match the actual execcutable, unlike, for
> example, argv[0], which can be filled in with random data.
>
>
> *AND* we don't need any silly and expensive get_user_arg_ptr() and
> strndup_user() copy for it, which does that user access twice.
>
> And no, we shouldn't fall back to the horrid thing that bprm->fdpath
> does either. That's the thing that you apparently thought was too ugly
> to use, and literally the *only* use of it was for this case.

bprm->fdpath is for passing the pathname of the script to an interpreter
like /bin/sh.  That task->comm wind up being filled from it, is a bit
of a surprise.

> The reason that code existed at all was to generate a filename, and
> because we didn't use to have access to the 'bprm->file' back in the
> days.
>
> But that was changed by commit 978ffcbf00d8 ("execve: open the
> executable file before doing anything else").

That should work for binfmt_script.  I don't know which solution
is less racy, and less prone to problems in the binfmt_script case.
No one has complained so I have been assuming that case works just
fine.

> So I really really think that what this code *should* have done is
>
>  - get rid of fdpath that you made pointless by not using it for 'comm[]'

Again binfmt_script still uses it.

I can assure you there was no thought at all given to task->comm when
the contents of bprm->fdpath were chosen.  Which is why there is
a problem now.

task->comm is for people.  bprm->fdpath is for programs.

>  - teach the code to use the dentry name instead

Which is fine for task->comm, when the pathname is NULL. Assuming it
actually makes things usable for userspace.

That doesn't work for bprm->fdpath with becomes bprm->interp.  That
would require using d_path.

Eric

