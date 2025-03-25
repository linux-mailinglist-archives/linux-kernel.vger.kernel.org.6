Return-Path: <linux-kernel+bounces-575082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E600AA6ED54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AA18921B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6579253F38;
	Tue, 25 Mar 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuxrneUn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D81A23AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897424; cv=none; b=agFKTksSToSAIyzhdeEycPfJuf/j0yFk7i8/EMhe7uJKF3uCA5Ea9UyM1srmPmECqxLFD8jVMTrIQkStMrpmyz7FK2ibFbezJZjUR4efuS2E2cNdcXJTLbIhqQtnLyd46nrGgc/OJkcJYBSBnlJwLzf76AcQVmRJeDVHPgNxoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897424; c=relaxed/simple;
	bh=+yHwlyVryiDRjhu9Lrq1vGrFAuzbF6NTK9Kgojwnnyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQYTW97jmlZcTbyMaG22AV2DtPfR6KZ/KrHg9i3+Dt2CvlbubtVFBixgYl3YWjtfx4nVdgTIbpAAaAlSbb3PxJRDOfLuxSVKFBA8709PghLvF1VkgGdZukSI9ONMAcJqhn3JjmwYPQXJkM71mQNVX+4uVoeM75xlcwMlu+xwPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuxrneUn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742897421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yHwlyVryiDRjhu9Lrq1vGrFAuzbF6NTK9Kgojwnnyo=;
	b=LuxrneUnrdU7wymIvZXO20eSq+85eGGJaPErWjF+/paQCZpU6VQr0JHOxb0tEksmI8Q8uM
	57Rdfo+UMrsSaOO6jBLe1qIxyAw5yN+bPAVMFcAakIoRvWwouepVy8ffCK4GD4ztwtWOnk
	G2ziakadQEjmKhkZ802zI+uw66DkPwo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-liIXkxccNoKKRN5ZT6cOSw-1; Tue,
 25 Mar 2025 06:10:17 -0400
X-MC-Unique: liIXkxccNoKKRN5ZT6cOSw-1
X-Mimecast-MFC-AGG-ID: liIXkxccNoKKRN5ZT6cOSw_1742897415
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C8D61801A06;
	Tue, 25 Mar 2025 10:10:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4080D1956095;
	Tue, 25 Mar 2025 10:10:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 11:09:42 +0100 (CET)
Date: Tue, 25 Mar 2025 11:09:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250325100936.GC29185@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
 <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 03/24, Mateusz Guzik wrote:
>
> On Mon, Mar 24, 2025 at 7:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > So to me it would be better to have the trivial fix for stable,
> > exactly because it is trivially backportable. Then cleanup/simplify
> > this logic on top of it.
>
> So I got myself a crap testcase with a CLONE_FS'ed task which can
> execve and sanity-checked that suid is indeed not honored as expected.

So you mean my patch can't fix the problem?

> Anyhow, the plan would be to serialize on the bit, synchronized with
> the current spin lock. copy_fs would call a helper to wait for it to
> clear, would still bump ->users under the spin lock.
>
> This would decouple the handling from cred_mutex and avoid weirdness
> like clearing the ->in_exec flag when we never set it.

I don't really understand the idea, but as I said I won't argue with
another solution.

Oleg.


