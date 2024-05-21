Return-Path: <linux-kernel+bounces-185520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826208CB637
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C177282947
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E3C149E18;
	Tue, 21 May 2024 22:59:48 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9858AC1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332387; cv=none; b=gdLzsSok5t9G7jUMB98LRQ0JNCwm9Pesi5ET/JF4F7Bv0DfRblbJvrSBV0tUX9LPbm6lC5KcFgUcAxnZtSXAnGg2ht2DO5+gZz5XV1qGwzgogkYxT40NatGJh2n+MuA9tk/3b07muqvmxbkgxn8Nilv+RjvOmWT6Sp/rdT+BfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332387; c=relaxed/simple;
	bh=I9pWAFXJ3AMw6DqR5IFHPFrnDHTvYEknL09DRYwfhrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNGlNoDk05LCmNmVkMcxXsuLHf9Yy8VaeOOm+cfRwFQwgTZUq2epe6j151jKw1ylu3edkr/Y5ICCOgpH6jA9dr3WZVDGUXx2TCs/McSpAIod768lPX/pt2K8hMPE77UmERYlTmQqIrQx4MYuQc4qD5MbDiMFzmXJgKP95gvoGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.62])
	by sina.com (10.75.12.45) with ESMTP
	id 664D275000005F68; Tue, 22 May 2024 06:59:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 86682131457761
X-SMAIL-UIID: 9AC7B9FBA6F44293AB002770D67E5E3C-20240522-065931-1
From: Hillf Danton <hdanton@sina.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Dumazet <edumazet@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
Date: Wed, 22 May 2024 06:59:18 +0800
Message-Id: <20240521225918.2147-1-hdanton@sina.com>
In-Reply-To: <CAADnVQKuPJv-GNH9SAWL-esSERMXJmSamWRe7AG3cW=NTnf51w@mail.gmail.com>
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
> >         bool strp_stop =3D false, verdict_stop =3D false;
> >         struct sk_psock_link *link, *tmp;
> >
> > +       rcu_read_lock();
> >         spin_lock_bh(&psock->link_lock);
> 
> I think this is incorrect.
> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.

Could you specify why it won't be safe in rcu cs if you are right?
What does rcu look like in RT if not nothing?
> 
> pw-bot: cr

