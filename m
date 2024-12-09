Return-Path: <linux-kernel+bounces-437250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B799E90DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ED3163BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF8130AC8;
	Mon,  9 Dec 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUD0YyYk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B45217706
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741293; cv=none; b=c64zlSoTpo0XQwjysX/RIHG7z4ubw2stVABXQDPZg8yIXtuSiXcrpUV/dpIKxD0z5MU+Z8u0hy5LUzb4Wlas1+qMoUfqPqrOUDDAtfzNp84O5OfhYtTSdAmIbCTcRmLcNNmsKXrH1DVQPbsNdS7jZKHXUN0SkCUWkW2NNaMixK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741293; c=relaxed/simple;
	bh=LMnhlZB1RBUbEKnGh4XzmdXmwVWRf/dgo6MkQdGEKJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaEVOLvdYMp2/DfJN0GrcDyuxo8V1nwU/mTZnvKKlJdIX2d1RebNEr/z7+5cHP7Xafzb7gYqxjCeos3zYDERKIdw6L+2t5ekpHoywph4ZQejICWDAgATjGGX0bV1yFFMhEzrAbRpQsWyyyIHZm7kZQHu4MYlPD1eHJnaiwkt0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUD0YyYk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733741290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5b5P23P0yvBahRei6VwcH9KkQSSVuW0JGanNRDbAMU=;
	b=DUD0YyYki1wive96oH5OkeMz9vq5iRKB1A5IhE387A6xTH8rmg+VdX/NhGgPGoXDzlpuu+
	SdAzLpYV8ODEP5OCKhmQG0JSLJx5T9/wrS0AK2/1OQv+AXMkYo+5QdQvsvX7mwXYFALlBp
	oEzz3RGegYODI9+PT6VON+oD2Ur1Hhc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-KqttQ72SN2mhrFfnlBAcDA-1; Mon, 09 Dec 2024 05:48:08 -0500
X-MC-Unique: KqttQ72SN2mhrFfnlBAcDA-1
X-Mimecast-MFC-AGG-ID: KqttQ72SN2mhrFfnlBAcDA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6cb7f88e2so62299185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741288; x=1734346088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5b5P23P0yvBahRei6VwcH9KkQSSVuW0JGanNRDbAMU=;
        b=CpU+F90iIcduWZzJ6UxUGzZcoDWX3q5v4e/i3U9tspEXHi8PyoQw90/mEXPgvtZxB8
         t/n1Pwhbo9vsN65wSgaOi9FuDKT14bD43Y3eeZUaJV63Sm62ZjmU9+LncDqEu86/hZHZ
         09HKnYg+QUZDfgy+46Pnrv/wxTreL0rsM9l++/9TciND95hyAEVC+RpuB2RNObwtteFG
         TUMJD7lotvFXHAYywQVRZpKqYgQFsQ2O2TYeLR+zGruivMHkVDCBDwx8B+4hENlnj2TI
         rwvxZppnZbQBIvRdzxEJACBL56mXizbp75BbbYKG0mVpNQnxE/OMznLWwSAeGiqv4vh5
         OL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK7GbBZeM9dW+fjsc5gODoSo1+4f/jnOXCaIhi8YtzrAx6Iz+XkY0K+UBJcDb4TcVMDhwy0bm8cIGaun8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyytb0d4O1BD+54bhpHzUTK/DHRXZmVL4eJJGiY5ISzEA0/AFOV
	33q5H6e6onP8qeiwZQHr/Xlp00UPatIiVVoDWFDaWHBc95BkXGe51tWgZyC+C2hx0t05iz4bUZ/
	GuaCG1UGSGtmEeubqiSi0hIa+zW34BaA30GOziceXLu5eBMeA8D8ZV4IszqbcPQ==
X-Gm-Gg: ASbGncs7lHxFlrbtUJQddwAZQh/22weaDsa0TghyLT63+TNkyZrzYA0peniZAJ8aoW9
	qGUsTyBdHCUaMYCGb2fq406nUyyFS1X+CH1aVJzEapE30x1SsurpmTcIxGxNGSd7qVJ9c1N5Uco
	hu9vxyL+nimJlELEucO+55VG7WvqdCDDfPjZNAuep71+v1QF7DkBQEqrTJOmicV5qRKXngDluvO
	wsditAtyK9d79x5sXY1bKFwteQ9EWnK1+dpa9fR49v+M4xrJpIPu70sH/WOWAuQoUrIP8RGM28L
	/03G/EMCyBYVcOrx1QHRoBPgQ/UOjfsq0A==
X-Received: by 2002:a05:620a:248f:b0:7b6:dac1:cb73 with SMTP id af79cd13be357-7b6dac1d51amr101981585a.56.1733741288253;
        Mon, 09 Dec 2024 02:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR8ssRdtzIVkQQ+qZLpcglQj3WuNbdNHg/AcsARY37eE9F1zLS4+y0Qin1hSe4o7j0M+jVQA==
X-Received: by 2002:a05:620a:248f:b0:7b6:dac1:cb73 with SMTP id af79cd13be357-7b6dac1d51amr101978785a.56.1733741287831;
        Mon, 09 Dec 2024 02:48:07 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-117.as13285.net. [2.102.14.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6dbb3b67fsm11485085a.10.2024.12.09.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:48:06 -0800 (PST)
Date: Mon, 9 Dec 2024 10:48:03 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
	shraash@google.com
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
Message-ID: <Z1bK4_SOWoOiwEcl@jlelli-thinkpadt14gen4.remote.csb>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <CAEXW_YQnh9aD5yOv5HTDPk6LruEhi+2-mZ4SfXzivD1wdgpPvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQnh9aD5yOv5HTDPk6LruEhi+2-mZ4SfXzivD1wdgpPvA@mail.gmail.com>

On 06/12/24 12:24, Joel Fernandes wrote:
> On Fri, Dec 6, 2024 at 11:57 AM Vineeth Remanan Pillai
> <vineeth@bitbyteword.org> wrote:
> >
> > On Fri, Dec 6, 2024 at 10:18 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 01:47:44PM +0100, Ilya Maximets wrote:
> > > > Hi.  It seems like I'm hitting some bug in the scheduler.
> > > >
> > > > I'm running some tests with Open vSwitch on v6.12 kernel and some time
> > > > 5 to 8 hours down the line I'm getting task blocked splats and I also
> > > > have a WARNING triggered in the scheduler code right before that:
> > > >
> > > > Dec  3 22:19:55 kernel: WARNING: CPU: 27 PID: 3391271 at kernel/sched/deadline.c:1995 enqueue_dl_entity
> > > >
> > > > I have a lot of processes (kernel threads and userpsace threads) stuck
> > > > in DN, Ds, D+ and D states.  It feels like IO tasks are being scheduled,
> > > > but scheduler never picks them up or they are not being scheduled at all
> > > > for whatever reason, and threads waiting on these tasks are stuck.
> > > >
> > > > Dec  3 22:22:45 kernel: INFO: task khugepaged:330 blocked for more than 122 seconds.
> > > > Dec  3 22:22:45 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 122 seconds.
> > > > Dec  3 22:22:45 kernel: INFO: task mv:3483072 blocked for more than 122 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task khugepaged:330 blocked for more than 245 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3479822 blocked for more than 245 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3480383 blocked for more than 122 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3481787 blocked for more than 122 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3482631 blocked for more than 122 seconds.
> > > > Dec  3 22:24:48 kernel: INFO: task mv:3483072 blocked for more than 245 seconds.
> > > > Dec  3 22:26:51 kernel: INFO: task khugepaged:330 blocked for more than 368 seconds.
> > > > ...
> > > > Dec  4 06:11:45 kernel: INFO: task khugepaged:330 blocked for more than 28262 seconds.
> > > >
> > > > I have two separate instances where this behavior is reproduced.  One is mostly
> > > > around file systems, the other was more severe as multiple kernel threads got
> > > > stuck in netlink code.  The traces do not have much in common, except that most
> > > > of blocked tasks are in scheduling.  The system is also idle, nothing is really
> > > > running.  Some of these tasks are holding resources that make other tasks to
> > > > block on those resources as well.
> > > >
> > > > I seem to be able to reproduce the issue, but it takes 5-8 hours to do so.
> > > >
> > >
> > > CC'ing a few more from my team as well.
> > >
> > > We haven't seen such an issue with the DL server, but we are also testing on
> > > slightly older kernels.
> > >
> > > Its coming from:
> > >         WARN_ON_ONCE(on_dl_rq(dl_se));
> > >
> >
> > Thanks for including me Joel :-)
> >
> > I was able to reproduce this WARN_ON couple of days back with
> > syzkaller. dlserver's dl_se gets enqueued during a update_curr while
> > the dlserver is stopped. And subsequent dlserver start will cause a
> > double enqueue. On the peripheral, we don't track where dlserver is
> > active or not directly and an explicit tracking could solve this
> > issue. But the root cause is a little more deep and I think I
> > understood the real cause. I have a potential fix and doing more
> > testing to verify. Will send the fix out soon after a bit more
> > verification
> 
> Oh, so we _have_ seen this issue :-). Thanks Vineeth, looking forward
> to your fix! By the way, I do remember now some variation of this that
> happened a long time ago but I thought it was fixed.

Hey folks. We have been looking into this as well (and there are private
conversations going on on IRC also with Peter), but we don't seem to
have a fix for it yet. So, Vineeth, if you have a fix please send it out
when you feel comfortable with it. And thanks a lot for looking into
this! :)

Best,
Juri


