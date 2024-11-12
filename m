Return-Path: <linux-kernel+bounces-406539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5C9C608A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D60C2829A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2500217910;
	Tue, 12 Nov 2024 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LLMLWPG9"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA72076A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436601; cv=none; b=RUWPSUJFFonSNH/6AAWd2u+l3YTH4i2YW9bfINzRZVQ/lAUU0qAEn81Jv9YE/Oc0QGFGnyxnTzV6IqFN8IWrcBW0R8DoA/Z+ghChuvWB73c/qLyChwSxkiTJPI+fYVhSSgXKrk62dpMG0j2g2bXxTMekI3vFB+MtWujgD1PcMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436601; c=relaxed/simple;
	bh=azghq7xbd5HjGFxISImNbKjXih69XGVh33v7PA7eBEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRZkxOqFzkzVY/lb7CScKRN7r4ZkyJf+WpYsAhFeqEyFr2F7WpatZo2QxCWfqwmsr8/vCF1GpHcpDfSN8J77eBt9NIdc8UuVIQTKDLPt/sBn7SlA2KBKyaV1lLm0YvkOPoEgjYiRCHx2KYpxhY6RgVPQPoZaIPMVeMmEODpFFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=LLMLWPG9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6ababa9f7so23558845ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731436598; x=1732041398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUhkJ9T1JdCDSEr0F9PO92yz7yHijqbqEqub4Hd7CK4=;
        b=LLMLWPG9ZO0tuWVmZ+68iSmE+0GdvzaLnjL1AjfqwUgZVvwSSmhNOzwWw4zgxNbBXc
         3HETOVwEAq0Nv0M7Tx//5jcXCGn7jsJvKHGyELJOIwfTz6dNMcEXF75jT+5lwRxAdXK2
         llGTbCmOoBKiA0YVrKtCvrgx47Xgi0WKgqj08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436598; x=1732041398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUhkJ9T1JdCDSEr0F9PO92yz7yHijqbqEqub4Hd7CK4=;
        b=EDnadRri0GwvPWYvoclaTf77cc2JHAXsxyZapq5RvCvutpWwGVbigIcH+o/xD/ZL9g
         c3pa5zm7ckSy9Xr/MNgrAitWRWEcWIGVuQdTilGKeBRbVyIPIex06BCHH70wpL4ZUqYM
         y5YILL5PwwnlxsFgaunN239dVU5+LcdcY5I928wxrnPm7pJmTvDsQDG2uT9aixrNG2uB
         pS91a01aUCAOrTCQXX0OMFmTtvQ8eCvztD986rsdOvV6IHEEroP8o+pqfI/Ve/2j2cVx
         3McrWb5lNoRTz3PWqV/jtbixfsANSKz6pw4pPi8iFUkJtu2zl3m51ES8HbLSDZsPZtPw
         cPEQ==
X-Gm-Message-State: AOJu0Ywqytv7tVHSXxuAy01yz26U/iOecyJGDnKQx2i/yIr5IAxymRYP
	2BmhlZSFOrWL7GtCSKB1qtKGrM+D0H9YL0ijepS1Vl+c6lfd8cESyEfUnT4/urg=
X-Google-Smtp-Source: AGHT+IEaXM85sMxzs2AFEHW2JI6ps/Y3PiUs0Q1LmO9k7EIraEAbZHW+vFXf5skFGJihk5fhVzNCtA==
X-Received: by 2002:a05:6e02:17cb:b0:3a6:c493:7396 with SMTP id e9e14a558f8ab-3a6f19a00bbmr184012385ab.3.1731436597851;
        Tue, 12 Nov 2024 10:36:37 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f9820fa2sm22893285ab.13.2024.11.12.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:36:37 -0800 (PST)
Date: Tue, 12 Nov 2024 18:36:36 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aashish Sharma <shraash@google.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] sched/deadline: Do not start hrtick if its disabled for
 DL
Message-ID: <20241112183636.GB2061573@google.com>
References: <20241112012240.1887813-1-joel@joelfernandes.org>
 <ZzMI9dYjWKqNtQzv@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzMI9dYjWKqNtQzv@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Nov 12, 2024 at 07:51:17AM +0000, Juri Lelli wrote:
> Hi Joel,
> 
> On 12/11/24 01:22, Joel Fernandes (Google) wrote:
> > Fix an issue where high-resolution timers causes aggressive preemptions,
> > leading to increased idle times in CFS tasks (which are inside the DL
> > server). The problem was traced to improper usage of hrtick_enabled(),
> > which could start high-resolution ticks unexpectedly causing repeated
> > preemptions.
> > 
> > The fix replaces this call with hrtick_enabled_dl(), aligning it with
> > scheduler feature checks.
> > 
> > Reported-by: Aashish Sharma <shraash@google.com>
> > Reported-by: Vineeth Pillai <vineeth@bitbyteword.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/deadline.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index b216e6deeac4..d46502b9ce58 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2121,7 +2121,7 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
> >  	if (!p->dl_server)
> >  		set_next_task_dl(rq, p, true);
> >  
> > -	if (hrtick_enabled(rq))
> > +	if (hrtick_enabled_dl(rq))
> >  		start_hrtick_dl(rq, &p->dl);
> >  
> >  	return p;
> > -- 
> 
> I'm not sure I'm seeing this in current code. We have two users in
> deadline.c and they both use hrtick_enabled_dl (after a recent fix by
> Phil).

Ah you're right. The latest kernel we are on is on 6.6 so this got missed.

Thanks Juri for your quick reply and pointing out the missing patches!

 - Joel


