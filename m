Return-Path: <linux-kernel+bounces-521292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADABA3BB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245463A60DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FD1BC9F0;
	Wed, 19 Feb 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7qjqDOP"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A615B971
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959667; cv=none; b=GOHpXtutf4LSE+eyuuwQLGKcahW6Hk1hxfvlXZv78chzHPVtOuYZqhPCM/RTCb3AZycPW3wD449hOHgs11LqK+5YgYeimNIRNYFobPMtgytOWhW55Hfl3EfaaxpjJSziWi+vqgdRdzkJQgL7M6vwKmJpHDnRGq6kX2TYEhzK8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959667; c=relaxed/simple;
	bh=RWBHJJL5GPqCrVfUpZDxuS1AXh1uMO9et0EpbWkevVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwNOxS8NwOanCnJSHumY7FKEuPoV5RAsHvT5gPsW4RWXdVOTM++Lfrpd77pfMGsanqJValNxlofGmtx3dAIQUqGECfBIre+8D1ej8n4Ipks3FfxbQSNZRCFUFNaXXsgnBLLsSviicWbCoAhSrTSdNqwP4D891JycCYzyROn1hVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7qjqDOP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f441791e40so9548588a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739959664; x=1740564464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKWVXPRqGth2FnMHvOzJDQx238xK7n36UmgnSZ2nAoA=;
        b=i7qjqDOPcxRIUpjtGvX0V5hghJvydWMDpEsgIu5wUHyjunpSxIbRNWWZXy98Gsg42I
         ZYSUorajYLciJ/yGQJ6FhpWy7CH/+oL2RkycV1uxNICUCOZZi0gtuYKoL947IuhuNmZX
         g575bIm3+RPdvRq+wg4358HlwxWuXt/7xtcskIPhr28ZyAnePHKjYQYPWOQrNF1jvsTz
         G1vXpuP5fCHYxIsShe+2uzyOyqtzjSjcfMU30ymtRzoQb070acPZyKug5DrMZKW1N53K
         4/QeT7aVz9XCEpi0SXF49Bj+Iq9T7inBkUriJ1LIdhjUAGEFgYjcE1hzG/wSVHEfubKl
         fzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739959664; x=1740564464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKWVXPRqGth2FnMHvOzJDQx238xK7n36UmgnSZ2nAoA=;
        b=et7dAASazyYCQopdpPF9uI/NwgkvQwHmV/zMAHcVQ+h7tUo5Q/MsGYT5BPnvZhS7zW
         4HLePlb9necp5ftwz7WCoZ/Tcr8kuYZmwZgDZRCTzOD9cTlFXfqYr6/J4OlKPE9LZVGo
         M/jG/BIf+ahAN+zyziiv4EqIkNcbh6vNKhDgOAwhZP9WBldJYQ93H6WVUrOjUSa/zz05
         ZmY6ensZa2Wh9QlK1rFCZhBFDI4WqxXuvqHLYJbC1ssy1t0WabIm4+jK2/U1+EK7fiIW
         wn9y2HLyC/sjMIcA5yZ+S6DBM8u5EfcKpJvwB2I0rHMHKNiyXxM9UkJuB9DSmUMJhYCQ
         KbMg==
X-Forwarded-Encrypted: i=1; AJvYcCUJC1e4r0f1xsp2shEDLuz8dF4JG/+lwAYbUjKjUaUdmm3poJQIbjQ05tkIBCccbLs8N1F0mGBVY9TtoUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvOvzQTVu/SG2bX8CWh/aZGu9x2StSTwjY9HFg54eGWrg3KZ3
	Qkfxe+n2GBEqVSAflreY6XQSD9RQaGLn/jt0qH8gw5Teq1gLSiTK2QAOaIZKLj/TZYIB8sG3mp2
	xZqB8Yh2M3IIdaF7cuGGvLynC+zhyeB4skc4=
X-Gm-Gg: ASbGnctP7qaILKYlIzTPhYgCA9R6SEDjxvN+NGOMpL89C8WG9mMJNfnClc8E56KloHH
	9mP+1NtoIUPAOuPTLvjVfVlHCtRYFqEVdN9LJbOOUMjXVi53E0y/fPRzdk7k9fmftagmlPeAikh
	M=
X-Google-Smtp-Source: AGHT+IGXMc4q3VIbp+qjtaPH3cRMoHPoFXnuUPiHfNq+FrWvOuc1qSQfbf/PKdEcFuZUKgRQBo5+boBwZM6T1EXd7Bw=
X-Received: by 2002:a17:90b:3949:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2fc4104516dmr25791309a91.28.1739959663797; Wed, 19 Feb 2025
 02:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214180157.10288-1-aha310510@gmail.com> <20250214152128.61a1054b90d1a53eff9cf16b@linux-foundation.org>
 <CAO9qdTHkk-4C59sv=B6ZPkcu4AmSNtuvFsdSWQNmwHoTXTCLmw@mail.gmail.com> <Z7DRXSbE8IDxXZeK@casper.infradead.org>
In-Reply-To: <Z7DRXSbE8IDxXZeK@casper.infradead.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 19 Feb 2025 19:07:37 +0900
X-Gm-Features: AWEUYZmulGJlt1wTUs6OsbAUUER92dA3artSB5kbcokBYDSGdIvEfISEnkQPgcU
Message-ID: <CAO9qdTEUvMg-z9XUnLU35hpXHc_CVWK_7koCHHzw7wVqN68ufw@mail.gmail.com>
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of semaphore
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Liam.Howlett@oracle.com, brauner@kernel.org, 
	lorenzo.stoakes@oracle.com, Davidlohr Bueso <dave@stgolabs.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Matthew Wilcox <willy@infradead.org> wrote:
>
> [Fixing Davidlohr's email address -- David could you pop an entry into
> .mailmap?]
>
> On Sat, Feb 15, 2025 at 02:00:23PM +0900, Jeongjun Park wrote:
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Sat, 15 Feb 2025 03:01:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
> > >
> > > > In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> > > > only calling idr_for_each(), which can be protected by the RCU read-critical
> > > > section.
> > > >
> > > > And if idr_for_each() is not protected by the RCU read-critical section,
> > > > then when radix_tree_node_free() is called to free the struct radix_tree_node
> > > > through call_rcu(), the node will be freed immediately, and when reading the
> > > > next node in radix_tree_for_each_slot(), the memory that has already been
> > > > freed may be read.
> > >
> > > A use-after-free?
> > >
> > > Is there any report of this occurring, or was this change a result of
> > > code inspection?  If the former, please share details (Link:,
> > > Reported-by:, Closes:, etc).
> >
> > Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
>
> For anyone else trying to understand what the hell this is about,
> the report is at:
>
> https://lore.kernel.org/linux-kernel/67af13f8.050a0220.21dd3.0038.GAE@google.com/
>
> > Sorry I forgot the Reported-by tag. I think the vulnerability is caused by
> > misusing RCU. In addition, since it is a function that does not perform
> > an update operation, it is possible to protect it through RCU, so we can
> > safely get some performance small benefits by using RCU instead of
> > semaphore.
>
> shm uses RCU in a very weird way.  You're absolutely right that we need
> to hold the RCU read lock here to prevent the tree nodes from being
> freed below us.
>
> But I'm not convinced that removing the rwsem is safe.  Look at what
> else is in the call chain:
>
>        if (shm_ids(ns).in_use)
>                 idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
>
> shm_try_destroy_orphaned:
>                 shm_destroy(ns, shp);
> shm_destroy:
>         shm_rmid(shp);
> shm_rmid:
>         ipc_rmid(&shm_ids(s->ns), &s->shm_perm);
> ipc_rmid:
>         WARN_ON_ONCE(idr_remove(&ids->ipcs_idr, idx) != ipcp);
>
> So what's protecting that idr_remove() if not the rwsem?

After looking into it again, I guess removing the semaphore
won't work. Thanks for letting me know!

I'll fix it and send you a patch right away.

Regards,

Jeongjun Park

>
> (the shortcut for this is that shm_destroy() actually documents that it
> needs shm_ids.rwsem held.  But it doesn't have a lockdep assertion.
> Perhaps you could add one?)

