Return-Path: <linux-kernel+bounces-572935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADD3A6D089
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1879F3AD478
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4A194137;
	Sun, 23 Mar 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSvZYnbi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D51922E7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753709; cv=none; b=MJGt85qtrSXHa5sYdTUjs/DDZuvP6eNAZK09t3tv5ujHgjiRUERn6PnL4DVtHL3IUurQLYzPsFtdH9nv51GawONT6IQkRxCdRqJaXBxi6BOmpXuP6J2KR7h3VNd3q/SF7CeFoEMpphOqrqKoHhHoTU91kKNscCY9gCleH9IA4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753709; c=relaxed/simple;
	bh=6Pr1pJucG4a6OJekUXmBhDG3Cp3c3Z6L8xPwhI0o9rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOVLNiXQz9J8NMvOsaOLjPl886Nbn8UUMw85inlBI+Y04lWQxiNIOE02Oi3CgdMpXku5KiPIoMAgMMEWmgM6ZZdD4KhG25O3e5D9DOP8VOuLYzsyfXX2DZbjX2/1kR+wPJKV9dCEOcTaOtG79oVAjoszEE1dBLKRu7cO2h7JqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSvZYnbi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742753706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0w5axyZcg98z3a51P4ruVqk9dqgoLr8zEn3jjGLi8f0=;
	b=gSvZYnbiQstvEBksuupLPXGLjJHfaxNt+XspWEoshRRvtO8IhcAIOSwJHV0yXgwircc8ft
	ilDJ5n8+twMEOclPViteCHxauB6SnCXsiKiku51sse1qDj9X0smNoSz3MhG2HD+HFQ40A0
	Dmg6Pdgg3cZkNi7Hi8nqlzo3PvFJ13U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-imhGZ1CaPqSBS4hhHCfZrQ-1; Sun,
 23 Mar 2025 14:15:01 -0400
X-MC-Unique: imhGZ1CaPqSBS4hhHCfZrQ-1
X-Mimecast-MFC-AGG-ID: imhGZ1CaPqSBS4hhHCfZrQ_1742753699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD5F0196D2CD;
	Sun, 23 Mar 2025 18:14:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8A03230001A1;
	Sun, 23 Mar 2025 18:14:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 19:14:25 +0100 (CET)
Date: Sun, 23 Mar 2025 19:14:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250323181419.GA14883@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
 <20250322155538.GA16736@redhat.com>
 <20250322185007.GI2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322185007.GI2023217@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/22, Al Viro wrote:
>
> On Sat, Mar 22, 2025 at 04:55:39PM +0100, Oleg Nesterov wrote:
>
> > And this means that we just need to ensure that ->in_exec is cleared
> > before this mutex is dropped, no? Something like below?
>
> Probably should work, but I wonder if it would be cleaner to have
> ->in_exec replaced with pointer to task_struct responsible.  Not
> "somebody with that fs_struct for ->fs is trying to do execve(),
> has verified that nothing outside of their threads is using this
> and had been holding ->signal->cred_guard_mutex ever since then",
> but "this is the thread that..."

perhaps... or something else to make this "not immediately obvious"
fs->in_exec more clear.

But I guess we need something simple for -stable, so will you agree
with this fix for now? Apart from changelog/comments.

	retval = de_thread(me);
+	current->fs->in_exec = 0;
	if (retval)
		current->fs->in_exec = 0;

is correct but looks confusing. See "V2" below, it clears fs->in_exec
after the "if (retval)" check.

syzbot says:

	Unfortunately, I don't have any reproducer for this issue yet.

so I guess "#syz test: " is pointless right now...

Oleg.
---

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..02e8824fc9cd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1236,6 +1236,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	current->fs->in_exec = 0;
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1497,6 +1498,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		// for the case exec fails before de_thread()
+		current->fs->in_exec = 0;
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
@@ -1862,7 +1865,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
@@ -1881,7 +1883,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
 	return retval;


