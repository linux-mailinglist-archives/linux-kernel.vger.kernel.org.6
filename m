Return-Path: <linux-kernel+bounces-220437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C490E1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995D0B21145
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4DB45BE7;
	Wed, 19 Jun 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv36ijLb"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F9A38
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765207; cv=none; b=oV2pq+g5ovaZMq2Ul5QG0GPv9dlipY1xyWugL7y8NbKlUT8iWp6OZkTd69iooMjFATGDmXY/G4s4FEED7jgWwlhJenb7aU32cMeJxRDuh7z0cDzEyuDlxJladIiZ40tGnF8x6XiqWcCRpKifj3F5WQCS9nCL4AH4GAc01ZiOW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765207; c=relaxed/simple;
	bh=nb7SQjv8Yb+Mp78NEj5zPaCJi0vIpp9k7DYwZtKyp00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImvJ1yakwMdHuokGga/k7nyJXiik4Bh7rT9M/MpaYHoIHhg0s/IcLa0I2iOvkDY2YHxioBIL6oOnDCZW3k28eSHPA45h5x87TLwOwP2kbLCQGTq0PAz2m1Oj5ZMnJ85GgOI8zuctrk3esZblm1CbX+IPSCkzpMYm0wJZzbrKozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv36ijLb; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f95be3d4c4so2385017a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718765205; x=1719370005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb7SQjv8Yb+Mp78NEj5zPaCJi0vIpp9k7DYwZtKyp00=;
        b=lv36ijLbvdYfMnT3n3lwvR8HZwvR9t3HSqmPGHV3IS+BwUPGdcN5FcGaOrNb6VjK7Q
         ZT15VErobRCuzOdV4+b6ZFlTMBWqe/06cAsgB9T+ZFq+DZyl8XC9N88B+UDKZNiIzTaO
         gEvVj/XiU8DbW3EnI/wJUPmFyyxSvFSFQevoRb60k66sshAlEQYZaZcf77i63FkxWCvD
         ONSV9xGnXA1bxnJ3twtav4XKWmy06iBCq7F7/icFUan6g145klkHVYevb1aR4gSZgkHw
         F78Ac1eE5drRIMsFi6Vgtlao7i23/v085nvokPI6EL2dQn2TajSAq0bMilVFWLgnxeCO
         drcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765205; x=1719370005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb7SQjv8Yb+Mp78NEj5zPaCJi0vIpp9k7DYwZtKyp00=;
        b=DVpxCZLfe1qzdlP9afpy4btK5mKMHz9WwGjJV8GdfXlvh/4i69Q/ASgFvN+GBYyw0X
         Sj8opqFZR41mwpgplX97AuPt97YWxbeRds4yfxI5uUa64or2zU7dLUgVdSWKstFFybt7
         ABjIZFasquSvTZTRsZ1MPoUaoxOIdBTYT37YAVF+7sHc4kAa7j/xHzlPHf2qpKaG3mii
         rLKhTW8Rg52zISviHKrH9Xz1NhS+mw9vKnNcNxIr5FVqsQQz6+FBMaax0C3S42+/6N2o
         ULyIMXGbSHaNKfGDBipu+wnMQ931oVUniMj8B+P2ZcArbHmHC4FazsoMdbT5UbttToBo
         pjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+P53NOZb6VMBzYtXubsyznBmuDLAzKf5THF34kjjj1EVSHWNj3wFrwh8PJ3/hOkiYLeslAdgx2zaLCYzKuN2dlW+/fEPC8JN7LpaG
X-Gm-Message-State: AOJu0YxDqFZo54Gyql9VwFei0J/AfJBZenYeddi3zJEuKACayDU1vZal
	6LTL7BfUk1E7NfOsQPDQjNnwfZtgW+2RR+AEycTJj4CT1M9DcZsvdDvc5rNMcQUUM/P9HQ/fkDz
	8+oob4B0KL9yguKW6+IWzA0Lj8Y8=
X-Google-Smtp-Source: AGHT+IEjhpqzam3srDiMRxXuEDeu5n4A2Acf5zKcihTHCzfzuVVTWhxM3nAuNZQ6A97GVf1RngYgJA+2MG5ZOTEGNKQ=
X-Received: by 2002:a05:6830:1685:b0:6f9:5d33:e21d with SMTP id
 46e09a7af769-7007365c25emr1637391a34.1.1718765204709; Tue, 18 Jun 2024
 19:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu> <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
In-Reply-To: <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 19 Jun 2024 10:46:33 +0800
Message-ID: <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:58=E2=80=AFPM Qais Yousef <qyousef@layalina.io> =
wrote:
>
> On 06/17/24 12:03, Qais Yousef wrote:
>
> > > Sorry, I miss the "fits_capacity() use capacity_of()", and without
> > > uclamp_max, the rd is over-utilized,
> > > and would not use feec().
> > > But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> > > SCHED_CAPACITY_SCALE,
> > > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > > return true, and the rd is not over-utilized.
> > > Is this setting intentional?
> >
> > Hmm. To a great extent yes. We didn't want to take all types of rq pres=
sure
> > into account for uclamp_max. But this corner case could be debatable.
> >
> > Is this the source of your problem? If you change util_fits_cpu() to re=
turn
> > false here, would this fix the problem you're seeing?
>
> FWIW, if this happens due to uclamp_max, then this patch to do the cappin=
g is
> still needed.
>
> I think it's good to understand first how we end up in feec() when a CPU =
is
> supposed to be overutlized. uclamp_max is the only way to override this
> decision AFAICT..

Sorry for the late reply...
In our own tree, we removed the check for rd overutil in feec(), so
the above case often occurs.
And now it seems that on the mainline, uclamp_max is the only way to
override this.

Thanks!
BR
---
xuewen

