Return-Path: <linux-kernel+bounces-328199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7015D97806F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E6D285074
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D81DB93B;
	Fri, 13 Sep 2024 12:49:40 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D171DB526
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231780; cv=none; b=vEXfD67dosuUJMG9e0y6hkIstOpnwWBDhlE0s+WVqPF9r7T/b56WwOgxT0HmRMjCweAkhYmeU2ktVrwUnnEb0uvsb4VcYM6IFS8D/1cm0+7VcvJColo1qeP4iid5HpwXWKaZKDqbVJs1JC9WKn5FSknCugHHfpaoJRJ+N9TYMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231780; c=relaxed/simple;
	bh=xMOA533ocDkrZS9dRUR1ysAfDHLSHeZdDLfPs+U8MwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my5ajs8yeEstmTlpFitxMcWHwX4vMCTNNJ7A5ubmAcnMHVBzhAmdvfpGn2fqzmTXkmFmG4ci42Kq9iQevxTtkhJJVmAAPPprtrnji3Q93hCT8MZlj7nqYMLLWs3905W0jcGY26Hzr//Ra6g9hH9t/gLJ5zA3UeWKKnKcylwhp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.185])
	by sina.com (10.185.250.22) with ESMTP
	id 66E434B500007C1E; Fri, 13 Sep 2024 20:48:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6250247602877
X-SMAIL-UIID: F022002464A54C6FAC42BFF11ADD8101-20240913-204856-1
From: Hillf Danton <hdanton@sina.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kthread: Unpark only parked kthreads (was Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2))
Date: Fri, 13 Sep 2024 20:48:44 +0800
Message-Id: <20240913124844.421-1-hdanton@sina.com>
In-Reply-To: <ZuQwuM9_vnj5sBFc@localhost.localdomain>
References: <ZuGHTBfUlB0qlgn4@localhost.localdomain> <20240913121109.289-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Sep 2024 14:31:52 +0200 Frederic Weisbecker <frederic@kernel.org>
> Le Fri, Sep 13, 2024 at 08:11:09PM +0800, Hillf Danton a écrit :
> 
> But are the following bits deliberate?
> 
It is added to kill rcu stall [1,2] and win Tested-by.

[1] https://lore.kernel.org/lkml/000000000000e6ca5d0621ece2dc@google.com/
[2] https://lore.kernel.org/lkml/0000000000008de5720617f64aae@google.com/

> > --- l/drivers/input/misc/yealink.c
> > +++ y/drivers/input/misc/yealink.c
> > @@ -438,7 +438,7 @@ static void urb_irq_callback(struct urb
> >  
> >  	yealink_do_idle_tasks(yld);
> >  
> > -	if (!yld->shutdown) {
> > +	if (!yld->shutdown && status != -EPROTO) {
> >  		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> >  		if (ret && ret != -EPERM)
> >  			dev_err(&yld->intf->dev,
> > @@ -460,13 +460,13 @@ static void urb_ctl_callback(struct urb
> >  	case CMD_KEYPRESS:
> >  	case CMD_SCANCODE:
> >  		/* ask for a response */
> > -		if (!yld->shutdown)
> > +		if (!yld->shutdown && status != -EPROTO)
> >  			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
> >  		break;
> >  	default:
> >  		/* send new command */
> >  		yealink_do_idle_tasks(yld);
> > -		if (!yld->shutdown)
> > +		if (!yld->shutdown && status != -EPROTO)
> >  			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
> >  		break;
> >  	}
> > --

