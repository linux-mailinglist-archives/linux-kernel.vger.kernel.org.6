Return-Path: <linux-kernel+bounces-171721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFA8BE7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A51C1F2829A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95396165FB9;
	Tue,  7 May 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYdhTx2V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84988200D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096898; cv=none; b=LydnvdF3NaVslVFd1MIpTVoQIDQ6jCyo9khZ5cyfAFS4GbAJ9xSEB46dNa91f17iOoSoUKc07tPeSfSJzqvOWXkuMtT3jHjGT9xyNxOLURYu1Wupo9gi3fd+f2+ZhpMLPZ+MDoJ/hwZ7N0a6oXUOpT9nW1YHvlEnp1v2ho1Y3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096898; c=relaxed/simple;
	bh=oOOu1XAuP25uHdnqlJpmq5lHywIVMEijNpL5Bb4elI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pqNSvV9CBiHHYrCoI3jOztx8gUqRcjHJ2yCJFt+K0YZjT2WiFEgAJrTkVYIss9Qsv3TcTKno7ZCGp0ZCNwsoaOTrnvUeevoDl3uCFwXQkPFxaUHzpu8MbKQTAYN3PKOrUqjmk6MhJM6Ukx9/U477zEjaw+vc2D5vIgGlk9s1Nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYdhTx2V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715096896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUzbS9jvqHEpZZhO44tGoG58QukIdXWBZebz/HINvlI=;
	b=hYdhTx2V1X6/WqTOpGF67L1iRzJh2JTWRV1LnYbwYVwwVX90uGXOJN9vBHqvWDjfqk+FG7
	FXGGzG9F1sGjdRNtMYjCtrlQxiqsWKIxMCI2NEYIt15/UNBLL1q+l7g7Quo4iV5OdufmtQ
	HBRODBt30xNFLKa5wKkFDuZpNScY3YI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-LBIypbcAM6GK18CQKO8GWQ-1; Tue, 07 May 2024 11:48:15 -0400
X-MC-Unique: LBIypbcAM6GK18CQKO8GWQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34f7618a1f2so762255f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096894; x=1715701694;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUzbS9jvqHEpZZhO44tGoG58QukIdXWBZebz/HINvlI=;
        b=D/WkTDUp6A1zzDNJl0FGL8XryrfaHS9HRIb7PqtJvn+vwp6thdYCq+DZrTIXGY1uL9
         Dh0/axH5LXYsjw2Md0DH/RLQstRyWwSbWDZUHdgolfz5hlYrtXBtmM0nl8mcmFGfw6Ky
         5hCpGvY7X1KD5NrknGtz6w4UFCvAKdNVg4IxXmRj5qeobYXS09m9ir5kBIpIC67uPktk
         eQXjF+zevPWXMRI4/nJMilNrg5WGkcJ5B5urXcxfmyz9GkxXTt3RDgRgDkuK13SC1MMH
         Pd2+lMtt3Ok8szIe18pZnJccmgqnzSkPkhWDViVrCJZ6aZ8VdbfgOfBgp5KQ7n1LWakz
         mdJw==
X-Forwarded-Encrypted: i=1; AJvYcCVy2jjn/szYabRLFLtr/npUQ7WQEjhyf89igBCse3/nKe9zH6aj0lJgvzEiVaHlx6cL2Y2zkrx/btVwaxdexePiJvZ/W+RS83u2vzZn
X-Gm-Message-State: AOJu0Yyzs+zfUSwRjN0aQnOd6rp2f02/r5cuL3E/z+EoLbh8OXeDBRFc
	G3jRgBtId/UaqjnCSiovgeh68mYZVwm7+T1Lv3BpxTr7A9KgRvP8WUP4UEaIKsu4Wv0RnUkXvyd
	AK+qFxPFbd+2V4tPxWVFRX8NeIfhi9xXG1Wni5gcXDBpiNpkB4Bd9yfLf6D6Z0w==
X-Received: by 2002:a5d:4145:0:b0:34d:ce05:29ef with SMTP id ffacd0b85a97d-34f81a551bamr2673959f8f.17.1715096894246;
        Tue, 07 May 2024 08:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsJkYVdzE27qN7T4Du3UQ6hbz02FVZWi3pzAmMmwPsZNqOXYDxIUbX8l1lhu7fnfUQfIKn4A==
X-Received: by 2002:a5d:4145:0:b0:34d:ce05:29ef with SMTP id ffacd0b85a97d-34f81a551bamr2673925f8f.17.1715096893855;
        Tue, 07 May 2024 08:48:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d4ad1000000b0034cfa17d74dsm13166305wrs.104.2024.05.07.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:48:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 17/27] rcu: Rename rcu_dynticks_in_eqs() into
 rcu_watching_in_eqs()
In-Reply-To: <ZjotdJwp3RXkrA7S@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-18-vschneid@redhat.com>
 <ZjotdJwp3RXkrA7S@localhost.localdomain>
Date: Tue, 07 May 2024 17:48:12 +0200
Message-ID: <xhsmh34qtipxf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/24 15:32, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:21AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, reflect that change in the related helpers.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/rcu/tree.c       | 8 ++++----
>>  kernel/rcu/tree_exp.h   | 2 +-
>>  kernel/rcu/tree_stall.h | 2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 857c2565efeac..d772755ccd564 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -308,9 +308,9 @@ static int rcu_watching_snap(int cpu)
>>
>>  /*
>>   * Return true if the snapshot returned from rcu_watching_snap()
>> - * indicates that RCU is in an extended quiescent state.
>> + * indicates that RCU in an extended quiescent state (not watching).
>
> *is in
>

Oh, thanks!

>>   */
>> -static bool rcu_dynticks_in_eqs(int snap)
>> +static bool rcu_watching_in_eqs(int snap)
>
> I would be tempted to propose rcu_watching_snap_in_eqs() but the
> purpose is not to dissuade people from intoning RCU code after all.
>

I've struggled with finding something sensible for the snapshot helpers; I
think I prefer your suggestion, that way we can have a common prefix for
all snapshot-related helpers. Also I keep reading rcu_watching_in_eqs() as
"is RCU watching while being in EQS?" which is nonsense.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


