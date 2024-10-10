Return-Path: <linux-kernel+bounces-359301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78476998AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E8B35E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446421CFEA1;
	Thu, 10 Oct 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KPJbcT5L"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D01CF7B5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570624; cv=none; b=Fa4tS81JuUScWxS0zMg1M7ubCrJZ7zhX0g+tUzqL+sohCCRAyHN7VOr71LLVcTIkTdjh8GPIlmA5c3yn796jmv5pBcOTdhTgbN612HkgnCAeNv3KxfqlPkutEevfxFmev1I5lcJhTKhOo6eOgtWTTQ6eIK5LvKYjFM1WV5VUo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570624; c=relaxed/simple;
	bh=oXJ7lfwXtpBlrtO/QantpAikpLoh0DXMMyP3+aSMWJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4Xi6IYWRXy10M1VRCR2jKO5DXQd7w8KwnrJZjP2HYPVLkjAzZ3aJRE6if3qk7iKaELCNjP90RYscTNFrzfFAjRWoc6hPdjSWFhSHVLVfCYmMTnuVB2vVQAX/ESDKT+EHRuMg54W7big1sMYxhCPugxgwTsVK3TUaUp3Kz5+W9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=KPJbcT5L; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2e3e4f65dso10616527b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728570621; x=1729175421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUNoplpJmE21x17Kjz2iHi1JFbJLmtq1EI5dZK24xkQ=;
        b=KPJbcT5L8IWrKoicSlJFET5MfLvys4gEPZgIRBxqnFK7iryYrAOSe5CbzhvfoHp5Tg
         L3yXTTlr6s4h2Uah0q3qKlZ2DY0UZn3A2UtEMMipptYAfy/BBce3is79Csh/m6xZrB6m
         OuW5UNkhr8tMQFBmLslA2GRSdzn185IyNASLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570621; x=1729175421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUNoplpJmE21x17Kjz2iHi1JFbJLmtq1EI5dZK24xkQ=;
        b=XAVTIg7qUkJjFbirOy6cPSwsw1dRT7dQFzU0tbjy3XkiYn2JDPga9Zbz7FWlA+Qa1k
         Nl9flm/Ytyejo9X9VGiAakIhOQl7h2p1WoWFCzD2ckTr8IoNq+IDtpSh6N2I8iykTre9
         nqcbGVx9ZlUPWe6F5r/4o4xaLj8x/F2cY5bWZwiBo5Xyz2A/gquUJP3MK15YXg8QdOGK
         J/Ebmg24xtjmIs+jGU9ffUwFGqBy0inNzGzDj2+KcS0GAUrEIrImyCxpoAK0bsOkkman
         T2DSTSnqIyefaSFrvkhvZaqcZpa8N8MA15IEgQZIqIXZdujUfyHZWluzblGtXWwPUoeK
         xscg==
X-Forwarded-Encrypted: i=1; AJvYcCUzocGGKQ1/Si/lBA3jty9nl3nhnvVcMTJoXEOBRRbS4KOlkZXg199XFXhYItfICZvvymYPZZwfKBZkrgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcZVJYHS9DjcCDlHXyHsgCh7fzv7M0ZRjRfjRY5kPNJlHZQgF
	8zc6wAGBnsqJxkK6YyV/JrykhLWtne6JrvpU+RrSKEZWP809DlJNUibbwUpCdbZO6GDq03FWeAq
	Rl5GUkPhYVxjOVNj/MConMBQ8EtVnTzeIzKZMUg==
X-Google-Smtp-Source: AGHT+IF+kZ8U6MyPvBmBydf1kiqfRxQ5Z/fJhPUYZtma/5AjJ/fbFFe/Fp1Xot+64Qib49vxaP7+7vEZ2lVXpAWq0ro=
X-Received: by 2002:a05:690c:f15:b0:6de:1e2:d65b with SMTP id
 00721157ae682-6e32219968bmr66408287b3.8.1728570621362; Thu, 10 Oct 2024
 07:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002145738.38226-1-frederic@kernel.org> <20241002145738.38226-4-frederic@kernel.org>
 <Zv1f8-1tLd-r1cyu@localhost.localdomain> <4e81816e-3a4d-4642-a86c-fd9bd49ca163@paulmck-laptop>
 <084a9230-c272-49c8-9c67-6c51b595f6e2@paulmck-laptop>
In-Reply-To: <084a9230-c272-49c8-9c67-6c51b595f6e2@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 10 Oct 2024 10:30:09 -0400
Message-ID: <CAEXW_YQwVCDR++=5SCEjQjsD_kfPbZsCAN15j3EDCoC4=KDTSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind spot
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:13=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Oct 08, 2024 at 07:03:50PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 02, 2024 at 05:00:03PM +0200, Frederic Weisbecker wrote:
> > > Le Wed, Oct 02, 2024 at 04:57:38PM +0200, Frederic Weisbecker a =C3=
=A9crit :
> > > > Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU ba=
rrier
> > > > blind spot. Report any potential misuse.
> > > >
> > > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index a60616e69b66..36070b6bf4a1 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu=
_callback_t func, bool lazy_in)
> > > >   head->func =3D func;
> > > >   head->next =3D NULL;
> > > >   kasan_record_aux_stack_noalloc(head);
> > > > +
> > > >   local_irq_save(flags);
> > > >   rdp =3D this_cpu_ptr(&rcu_data);
> > > > + RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on o=
ffline
> > > > CPU!");
> > >
> > > This should be !rcu_rdp_cpu_online(rdp)
> > >
> > > Sigh...
> >
> > I am pulling this in for testing with this change, thank you!
>
> And:
>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

With the correction,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

