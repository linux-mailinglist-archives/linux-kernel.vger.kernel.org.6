Return-Path: <linux-kernel+bounces-345409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD198B5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A64F1C21CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBA1BD51A;
	Tue,  1 Oct 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMLpjOZo"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5A199381
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768783; cv=none; b=p3gijub77dlUJ6dssHU/aUx23anlz2Vl7ez0w07wCkgn+6Er+0nIOqme0fLiG4nEbnTugJhN2pgygAuMSCWE3PIzDoPEzvosJwJ2MTH+gXT7/bH1e46tB7SLpP5/nfJNedAE/MaO7vGPboEKTBtRaDfMNSgQZLcoGHDXQsYeg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768783; c=relaxed/simple;
	bh=75GbCvsDPfTfWT52QVH4Vr8BxS8wf8WVGn2GuLMi+gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/WO8q+UaQ8+srwsVqr6N2MR+8dV8IcVP373sl4NHtc02hC51t9vnEL2CZ8sXdXqqBzlvFpcVLtW6314UhjPReQB1CHu6Nd4+G/pC8bL4jAhZlSX8nKIOlxFi1xB75EcO/er/X5kpXfSu5rbVqURMlQ9KQl9bOGf6Erasj/u3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMLpjOZo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso35355961fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727768779; x=1728373579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynnBOQu5jKcdwW9PqPnVpG86Xh9a0SR19wYZwjvIMCc=;
        b=SMLpjOZoEVPijk96Sz3d9Xn5QqPXowDrHx7SwUEPJQlf36FHVT2brPX1aMJlLLD7SN
         4Bgres+UbUqbWCLsTKmEMHZ31oGLqdjgYudaHcZ0R+OYxsmk2ybjIhwJ0sOTmVTqGIPg
         qwniviVe13sE0VI+YBIvKrxdNpwW11V3kxpSSvZwZKgJiMw+OpVYNKC4Agv/COtiFI2Q
         4a9RpqoHSma0sG6IfhWOgJ5QlOz/IGNJWeMrzuKBTepMT5Tu5zN58yxeRt3vzlI/6ycE
         5jLrFhwRLg0HffnntafwM8nw2uiADJjnkjQhuicvz0oYKJhpiMwn7W+LZreO4fdpfdHD
         t/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768779; x=1728373579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnBOQu5jKcdwW9PqPnVpG86Xh9a0SR19wYZwjvIMCc=;
        b=r6TbZkeZ+YLKCohWItveD9qYvIAv3cl7botNqdiP58Yi1kfJxpuW9nma8eYj1trXHJ
         kPO8DvQ27gHMVLK0vaAym7agee0Y4mfu6rm6A7Qz8JvYBlghMfBg33xcnh5558IOLWiz
         BnqLnjuPcQmC1Vy3aNvkzqGUbRqjvW8rFbhDRHvQYi/2PCjnyKjowgKsrmUtDOeq6yJR
         WUYwrQfzCm4jEdea9RDqfrAc2RFB5CPNe1NntTzcU3hgFkpSIJTQxJnGIlRvbInEk1ze
         gBYj1Ada6xqXDXp/nXLHX+PQThq2UjD82dEf2QkM4FF/yODGCewXa6FcgbGoGxcv2J4+
         G0nw==
X-Forwarded-Encrypted: i=1; AJvYcCUCVsLPrCT2jJlalWxZzYKh6WtWrsG37zk3agx35hY0s+98C2a1mjqpPW9e80i9h/R00688803Iqtkz4DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/B88+WGI02nYCkniCJEolDEOgfS/TK5jqXNStZc+tkbxoOkPo
	9Bzfwf7evrG1ZE3BOwOpDwJvP2vO46kNJRcn8KXo9q5z+LvWnBm1G4n6QWOznxTELIpo1IF6TZC
	mTySjYLgAcyd5kxJml11uNXuJbHQAkhO5RxTt
X-Google-Smtp-Source: AGHT+IG717hKYQkWLEUJ9n/QVTFoCBkUqv7RsNeb0V8VYrRgY9IO85RxZxs/Ul3475IlMynefAxO1iDD/72W/ERXM1M=
X-Received: by 2002:a05:651c:221b:b0:2fa:cb44:7bde with SMTP id
 38308e7fff4ca-2facb448132mr36476601fa.4.1727768779014; Tue, 01 Oct 2024
 00:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001015555.144669-1-danielyangkang@gmail.com>
 <20241001030349.97635-1-kuniyu@amazon.com> <CAGiJo8Rmr2JJ0cCuGDGUeM-fNXdF1L1==bBqJdcCxBkJUTHzuw@mail.gmail.com>
In-Reply-To: <CAGiJo8Rmr2JJ0cCuGDGUeM-fNXdF1L1==bBqJdcCxBkJUTHzuw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 09:46:04 +0200
Message-ID: <CANn89iLcxMi=AnhyFTgAoiCznFPCoKdjKVZbHMZMQ9dgK6xXnw@mail.gmail.com>
Subject: Re: [PATCH] fixed rtnl deadlock from gtp
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	guwen@linux.alibaba.com, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:54=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> Ok I see the issue. Yes it does seem to be a false positive. Then do we a=
lready have lockdep classes and subclasses set up for lock_sock() to preven=
t other false positives like this one? If not, should I add one then to res=
olve this?
>

Please  do not top post on linux mailing lists

About your question :
https://lore.kernel.org/netdev/CANn89iKcWmufo83xy-SwSrXYt6UpL2Pb+5pWuzyYjMv=
a5F8bBQ@mail.gmail.com/


> On Mon, Sep 30, 2024 at 8:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
>>
>> From: Daniel Yang <danielyangkang@gmail.com>
>> Date: Mon, 30 Sep 2024 18:55:54 -0700
>> > Fixes deadlock described in this bug:
>> > https://syzkaller.appspot.com/bug?extid=3De953a8f3071f5c0a28fd.
>> > Specific crash report here:
>> > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14670e0798000=
0.
>> >
>> > DESCRIPTION OF ISSUE
>> > Deadlock: sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mute=
x
>> >
>> > rtnl_mutex->sk_lock-AF_INET
>> > rtnetlink_rcv_msg() acquires rtnl_lock() and calls rtnl_newlink(), whi=
ch
>> > eventually calls gtp_newlink() which calls lock_sock() to attempt to
>> > acquire sk_lock.
>>
>> Is the deadlock real ?
>>
>> From the lockdep splat, the gtp's sk_protocol is verified to be
>> IPPROTO_UDP before holding lock_sock(), so it seems just a labeling
>> issue.
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree=
/drivers/net/gtp.c?id=3D9410645520e9b820069761f3450ef6661418e279#n1674
>>
>>
>> >
>> > sk_lock-AF_INET->&smc->clcsock_release_lock
>> > smc_sendmsg() calls lock_sock() to acquire sk_lock, then calls
>> > smc_switch_to_fallback() which attempts to acquire mutex_lock(&smc->..=
.).
>> >
>> > &smc->clcsock_release_lock->rtnl_mutex
>> > smc_setsockopt() calls mutex_lock(&smc->...). smc->...->setsockopt() i=
s
>> > called, which calls nf_setsockopt() which attempts to acquire
>> > rtnl_lock() in some nested call in start_sync_thread() in ip_vs_sync.c=
.
>> >
>> > FIX:
>> > In smc_switch_to_fallback(), separate the logic into inline function
>> > __smc_switch_to_fallback(). In smc_sendmsg(), lock ordering can be
>> > modified and the functionality of smc_switch_to_fallback() is
>> > encapsulated in the __smc_switch_to_fallback() function.

