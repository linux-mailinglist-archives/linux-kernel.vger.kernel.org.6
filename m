Return-Path: <linux-kernel+bounces-440642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C741E9EC22A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D10B1601F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EA1FCD16;
	Wed, 11 Dec 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="hXzjHuy6"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393F1FCD04
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884256; cv=none; b=TroJInoSMwiED/aZvj7FVePLtjsqm8chOsn8l2PGgxEIs1e6t1LlR2BSQNAuP5ANVu1wDoACfECw9UKpbbTtK7sYOgEmXi5qCUe4lpRsCVHsMD3KLdbcntk0AISLqPY6p0q1ptvNeLcX8vQJmNF9UiCfaHDSwKIy0MQDv2EnE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884256; c=relaxed/simple;
	bh=0eBcOQMntoGGtNObtVXuh1VdM8D0lpSbbaMaSaSIKMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSPVAqv7FTmVMr55KavQvvPCVsD9+2wIXDhQvRdyijyxwIcoxWjo+neW8TAyy19pe7LlCeDDHWLp+a4qydZaHZmsBJY+5fkLJKvrYBVDa8nROySdn4z2ZMRn2u1V4Qnys4Xq/lnnjOodr/fmO/FWzcwMWgO61jf3wCQCVNFW2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=hXzjHuy6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efea3c9e6eso32896367b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733884253; x=1734489053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJV0F2XJQexf/iFwFWzIoTF/ZK+e954Ffup46WQPkIE=;
        b=hXzjHuy6nzl/YhJnBmJVjT961f6Y4RNk9pa5VQ927SG6xBl/h4TC4BH1mBohrh7AtA
         uw1PKKGc1Aap6cXfIK7e2u52xg37ZRufr7QwisY8G8WmqJYFRxC7kAO4ED3D3GvqAeYt
         +H0bN2E1BIy1aPk7uO0/AeUWYF+OgxmLSNDz1Br0gogsoNDQuSaX+cQ+LaACaI//XNHA
         km6v6HPKvKdu7uprj2z/8pRUZn/DK4H1vWnkK49PlndoqvgUhwYSBGnAJwel9nECFDFB
         KUbLs5zOHa4jZY/U6YNKUGsBkyxn3kRNTZzliBVN1d189GKm+4H6bUjjzOHTAxyolZJ0
         Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733884253; x=1734489053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJV0F2XJQexf/iFwFWzIoTF/ZK+e954Ffup46WQPkIE=;
        b=qgNpBFGl0CdJTqgHiOUgs8rYWcEb3ZjkQ3Xu+st7etShu2ZlBKOOVtVBEOQbGXEUIY
         Zft2mQlrnDdOKK3hJBNUify4ALmlk2d3QUAKo3nJhXveHdSMFAXA69KPM4S/Yp1C7rJz
         8BjZQktNgbjmSMcMFaJluZb7OgKMG97cTqPyD3ID3fh9fu7mHJXkv1XUQF3Epq5Vz4jv
         ENExUYfEisGDLK2FEUnDUE3KDGvl5cR04FeIou+ySvGVdkb5Dm8eE2fKxaF0SWyuQ/K/
         n7WOHm5rZLNPxS+zvxMhgC1NA0SCR9VZ+byY6BgCbdAaYJmekM0jORJ7uz8YEC+c6Flg
         w+cw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Z86k9FEcy4KCpdLLqTW2oVPOgNkf+UTbgazOFtpXuIjTiS5ce03KwX1bfefNPNDAZe275KcKkH54j6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbZZK5lAeUqa4bb4icA/EcxEQzPGbdCb2pQ12VtS+T0NVIK49
	weYd8bf3PlDt/FKJgXRSvpmg81hOTyIyugggFtrPepUhLBSf50yZuLzI29TFLFHSA3lOQeA5QkE
	qgaec/BiptPu0I9GXXVxjgBQFtfUDYm1y3UlaOUikiT7g0MhOtKFCIQ==
X-Gm-Gg: ASbGncu/H/k5XlsqX1aJMbV+i7R4VOwPqYJzqRR3c+5Yqz+4p4s0QJITBsTonh0Z3RZ
	JXIjI8VxM7qJXU4NjG/wBi2jop9qYFezrSD0=
X-Google-Smtp-Source: AGHT+IHe1rcE3q+i7t7RXNajTudzSL91Yxql12zjbFBTIp+Tj0LWOsCkfl5GxZ5PDeBX7B/WDF92tuerggMiAHB+ozA=
X-Received: by 2002:a05:690c:4493:b0:6ef:5ca3:d0d9 with SMTP id
 00721157ae682-6f14800ade7mr18521217b3.20.1733884252818; Tue, 10 Dec 2024
 18:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net> <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net> <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
 <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
 <CAO7JXPjGFmfwAVcSaRhtM2Mf=V9P6oQm6H=QfHcFhtkLU8magQ@mail.gmail.com>
 <10db7c11-5578-4386-88ae-542ffcaac818@ovn.org> <0d64be76-7afe-416b-96f7-6ceb713c7ce0@ovn.org>
In-Reply-To: <0d64be76-7afe-416b-96f7-6ceb713c7ce0@ovn.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Tue, 10 Dec 2024 21:30:42 -0500
Message-ID: <CAO7JXPh40hhge6dSHj1=jERj63HSmXnNPd16_VXDbxapiTCzHA@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"

> >                 /*
> > -                * Any fair task that runs outside of fair_server should
> > -                * account against fair_server such that it can account for
> > -                * this time and possibly avoid running this period.
> > +                * If the fair_server is active, we need to account for the
> > +                * fair_server time whether or not the task is running on
> > +                * behalf of fair_server or not:
> > +                *  - If the task is running on behalf of fair_server, we need
> > +                *    to limit its time based on the assigned runtime.
> > +                *  - Fair task that runs outside of fair_server should account
> > +                *    against fair_server such that it can account for this time
> > +                *    and possibly avoid running this period.
> >                  */
> > -               if (p->dl_server != &rq->fair_server)
> > +               if (dl_server_active(&rq->fair_server))
> >                         dl_server_update(&rq->fair_server, delta_exec);
> >         }
>
> That indeed also fixes it for me.
>
Thanks for the confirmation Marcel

> >>
> >> "static inline bool dl_server_active(struct sched_dl_entity *dl_se)"
> >
> > Sure.  I can try that.
>
> Running with this for about 8 hours and so far so good.
> Will leave the test running for the night, just in case.
>
Thanks for the update Ilya

I also have been running the test for more than 24 hours now and did
not encounter warnings or crashes.

Juri, Peter, Shall I go ahead and send out a single patch folding the
2 fixes in this thread(dl_server_active and fix for the
dl_server_update call)?

Thanks,
Vineeth

