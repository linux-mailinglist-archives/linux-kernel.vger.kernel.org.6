Return-Path: <linux-kernel+bounces-272138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9359457B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADC21F25074
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5E3399F;
	Fri,  2 Aug 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G0DHrjAy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ep/AGNQg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIj8gYV3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4+fEd71W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD62C9D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577376; cv=none; b=Sr+hzugbYbkzpJGkJIBGJhEco2HpjvChF0BKVsDCswUnrmGS5T1FZnpqukD6wA7zIcGefriCYavQtgwxxdX/Ra0c9m+HIO28pOMPIlsLKbakNoHuT3rWUJaKaspXCfxHmFynJzT8pvRLarN3ho2tk9iduyJ77gjWf1tY3xNNttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577376; c=relaxed/simple;
	bh=cJAh3G5wl/zkk/TEHXTYFUonWQqM4rQcNAqPUZQW5YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7QWA87XtEMWR1bTO59PxlCjBT0NhvOLAmgBVUN+xm7BEmPJJDCdASEnQiF3H91bZkZaqMNXzMVAKG80nmGIFTTyBspmRpdsQBYg40T9X1npeNSNqEosjER4GtCtn7qv1YC2a5FvDD1R2GyJYd7x3JqKU5vphKT9c63kDM6GPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G0DHrjAy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ep/AGNQg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIj8gYV3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4+fEd71W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2EEB1F460;
	Fri,  2 Aug 2024 05:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722577373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
	b=G0DHrjAyW30CBLn2iWSp5IRPFauuzXj/2gOprCvJ86PReSqKrGDR/eSoniJe6Cdr+E65pb
	7h/l0WELCv9b0B7s0p7QG+/fsavy8O/nADHyVplPxrVTD8/P+MThR8FNxyr3lU9oT2+al4
	vv10wJnDYwiaODIXLStlLoOQXc+nMCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722577373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
	b=Ep/AGNQgtl7/bjifSYL2tdTTHqjVaYoozGOcpr36WhtqUg789xVXQyn2HyOmnAmOKfEt3V
	Iv8leMGvlFiSzQDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722577371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
	b=xIj8gYV3BMg1qeMnluj+0wOrI3t1C3+UiazVWt8Zz2pxP2LPlI5oGaFimehtkURAWbjS+H
	tujZ6OgmTmhVNrJpaR33lJeS4FYnA3w9kmygzWoKkco4OQLGomLGgr42THOFFLDeDTOY7o
	Nd0WJLndvDo8ynxV4/HJj2D+vIgXG2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722577371;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
	b=4+fEd71Wf2Asgaw0KtiS5/rV94YdZSBmL975dQBLrHdf26kn9OkY26JOxdwrbnu8E/+90u
	xA2w25281Nnm5gBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D03A13998;
	Fri,  2 Aug 2024 05:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a1RjIdtxrGZBagAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 05:42:51 +0000
Date: Fri, 2 Aug 2024 07:42:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
	Alexey Gladkov <legion@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	=?iso-8859-2?Q?Ga=EBl?= PORTAY <gael.portay@rtone.fr>,
	linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
Message-ID: <20240802054252.GA1582980@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	REPLY(-4.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phoronix.com:url,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30

> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
> > Hi all,

> > > This is a patch-set that implements fchmodat2() syscall coverage.
> > > fchmodat2() has been added in kernel 6.6 in order to support
> > > AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> > > There's no man pages yet, so please take the following links as
> > > main documentation along with kernel source code:

> > I would hope that it'd be at least Christian's fork [1], but it's not there.
> > I suppose nobody is working on the man page.

> > > https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> > > https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

> > > ***********
> > > * WARNING *
> > > ***********

> > > fchmodat2_02 fails with EOPNOTSUPP because of missing feature.

> > For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
> > 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).

> > Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
> > LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
> > fixed.

> > Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
> > different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
> > just accepted behavior (glibc returns EOPNOTSUPP on symlink):

> > +  /* Some Linux versions with some file systems can actually
> > +     change symbolic link permissions via /proc, but this is not
> > +     intentional, and it gives inconsistent results (e.g., error
> > +     return despite mode change).  The expected behavior is that
> > +     symbolic link modes cannot be changed at all, and this check
> > +     enforces that.  */
> > +  if (S_ISLNK (st.st_mode))
> > +    {
> >        __close_nocancel (pathfd);
> > -      return ret;
> > +      __set_errno (EOPNOTSUPP);
> > +      return -1;
> > +    }

> > Also musl also behaves the same on his fallback on old kernels [3]
> > (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
> > argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
> > year SYS_fchmodat2 started to be used in d0ed307e):

> > 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
> > 	if (ret != -ENOSYS) return __syscall_ret(ret);

> > 	if (flag != AT_SYMLINK_NOFOLLOW)
> > 		return __syscall_ret(-EINVAL);

> > 	struct stat st;
> > 	int fd2;
> > 	char proc[15+3*sizeof(int)];

> > 	if (fstatat(fd, path, &st, flag))
> > 		return -1;
> > 	if (S_ISLNK(st.st_mode))
> > 		return __syscall_ret(-EOPNOTSUPP);


> > > According to documentation, the feature has been implemented in
> > > kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> > > on symbolic files. Also kselftests, which are meant to test the
> > > functionality, are not working and they are treating fchmodat2()
> > > syscall failure as SKIP. Please take a look at the following code
> > > before reviewing:

> > > https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

> > I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
> > selftest") [4], where fchmodat2 failure on symlink is simply skipped.

> > Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
> > anybody work or plan to work on fixing it? LTP has policy to not cover kernel
> > bugs, if it's not expected to be working we might just skip the test as well.

> If I understand the bug report, the issue is that fchmodat2() doesn't
> work on symlinks?

Yes.

> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
> where some filesystems would change the mode of symlinks despite
> returning an error (usually EOPNOTSUPP) and IIRC a few others would
> happily change the mode of symlinks.

Ah, I've seen this in the past. Thanks a lot for reminding me.

> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
> was chosen because that's what filesystems were already returning.
> (While this is a little confusing, VFS syscalls return EINVAL for an
> unsupported flag, not EOPNOTSUPP.)

> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
> syscall to operate on symlinks, it also allows programs to safely
> operate on path components without worrying about symlinks being
> followed (this is relevant for container runtimes, where we are
> operating on untrusted filesystem roots -- though in the case of
> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
> an error here is actually what you want as a program that uses
> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
> supported by filesystems).

Thanks a lot for explaining the background!

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956

> > I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
> > but AFAIK it's not related to this problem.

> Yeah this is unrelated, that patch is about clarifying how AT_* flags
> are allocated, not syscall behaviour.

Thanks!

> > Kind regards,
> > Petr

@Andrea, I guess we want something like this:

+++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -43,9 +43,10 @@ static void test_symbolic_link(void)
 	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
 	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
 
-	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
-	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
-	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
+	if (tst_kvercmp(6, 6, 0) >= 0) {
+		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
+					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
+	}
 }
 
 static void test_empty_folder(void)

