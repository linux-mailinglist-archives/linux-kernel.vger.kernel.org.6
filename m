Return-Path: <linux-kernel+bounces-352978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DF9926C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00CE1F22C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B288189910;
	Mon,  7 Oct 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og/70Yoa"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB4EEBA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288967; cv=none; b=Aj0oS8J6+x9olspTWSubmMtWj9RVipfZiexgg/HqoL9mRQa2nRJzgy26n29nAVIyxMeYS0ouBjo9zhshrkbAezROYO88Yn0QvgwPKsuVWfsgEn3f3fPD89xUAooWxA4bdyBYgjglb3JZSNQTc8e105qRsN0QfziyvzTN/XhriOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288967; c=relaxed/simple;
	bh=RLBbUfYZwTDLmhkDu2VGWVBZxOClNJNvjSaK4IZx/TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQmgmiHD8UqHCQSq1qk44IPcfpiatXh18QfkFvrmemTTOTRpdawzJX9d7nbgjAEzHEbU/wCi7TGQhjGqoYAX/wqnnqOUbkhyKo17HZ5WbUzFyBkCpFMxzlRvhaYDNmRM297UX5i/cTA3wkCpZxWcNXYs/cJdcMvLAUhVyJOStdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=og/70Yoa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso2984911a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728288965; x=1728893765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLBbUfYZwTDLmhkDu2VGWVBZxOClNJNvjSaK4IZx/TI=;
        b=og/70YoaG5RxIkh9Ou1qyCFdowm+SCnbV8hlrn0uZnQ6CJjpSJG9YNCNGr9Tvzr+r7
         exSq326pLMjK+uNVa/hi4LMgDBUYEBFbLGTTGq4zhGAKAqBAHVYcNP+OSUtupswJ4rgS
         BNMWx6dnAYuC5esIylIpCtIcznfPQ8tyuOz9U4zrwLad/WACyAfxTcAnUNKHTPaUga7l
         8dg0l7sdkqzVW1uT3dk/Q3C1r618ohavZgmU9dD6cZNKlzt7bMRUjrLlkawR72jjpFFu
         fFJBsyEZB0Mc6EXIm966BH0ohpZX5wC2i91gIwGmP5IsXfBLZ+iMoXM7CVcTvWQaGvG7
         2KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728288965; x=1728893765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLBbUfYZwTDLmhkDu2VGWVBZxOClNJNvjSaK4IZx/TI=;
        b=A4iVCp7YDfaz4jzCRTSZ/9szSV462WfFjaR5FF3NvE1MR4d3c32boKhmuNhcpitmGm
         I52jO3hIwn+9BgtW8JLqgXJHejbd63duiF4d6aNgLWYR4lRzUTF2WEMvo1bB3yaj8/H8
         tigbGQh7kU5tRkYPh27z4iT2cal/2WhVRnWNo4XKWIJHKZXNxm9Zb+ovEY7Z81RZwUhp
         tOVvGGJEq4Mrv9GgJ5ZYiTBMJ1LMWv6/qiZT5SLkMLLhrbdyLb4Yeqd9FQL8zJzXClQg
         wcAUXIqKTv5XACsjprSc3lElvj+k9vJsBaQHZ/CNOIOfsAt4YMhRO/2HNmsV++7+Bpc6
         w/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVOmYwMzujDdD6EsXuRKxPKXk64TTmL3JoSYWBL1PJ4Y0jnJO2OvOnMRhD4S2HGoVdSjsdDCJg1HtwLrio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJcrMQDTCuAz5Vfr/2oWRM2GpyS4Cu4ynmqkGOiZIwnMy6PmQ
	qIjnsAU01tClUzH35lQwzu6cEKtfrhcM2S8wWAb7L90LzMrNp8w4UeklI6cQff/v7PAi4FnYA5c
	/XokDbSkWNKXxY9GYneypoTTG8EzBQWrxE0iu6w==
X-Google-Smtp-Source: AGHT+IH/dkEVQUhcQKXlKEcwsqELauhpOoz/dMeVnv/UCc6LvyZQsR1vl/kuPBJWMXS9N8RGB78rITzqN0M4KBVkTd4=
X-Received: by 2002:a17:90a:43a7:b0:2de:ec70:84d with SMTP id
 98e67ed59e1d1-2e1e62a7d37mr12921080a91.24.1728288965431; Mon, 07 Oct 2024
 01:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005005245.829133-1-zhouzhouyi@gmail.com> <CAKfTPtD7TPYcPcwHxC_n8PObZMgqxU+9=U-F6yJbP0=cLAB8hQ@mail.gmail.com>
 <20241007081015.GF18071@noisy.programming.kicks-ass.net>
In-Reply-To: <20241007081015.GF18071@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 7 Oct 2024 10:15:54 +0200
Message-ID: <CAKfTPtCKEi6-nW5sQ1y2B9zwgmqtEyesooZ62cm=+37AoEPFHw@mail.gmail.com>
Subject: Re: [PATCH] sched: Fix typo of head comment of ___update_load_avg
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 10:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 07, 2024 at 08:42:14AM +0200, Vincent Guittot wrote:
> > On Sat, 5 Oct 2024 at 02:53, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > > The head comment of ___update_load_avg illustrates the principle of
> > > PELT divider. "unwanted oscillation in the range [1002..1024[" should
> > > be "unwanted oscillation in the range [1002..1024]".
> > >
> > > Fix above typo.
> >
> > This is not a typo as 1024 is an excluded endpoint of the interval.
> > Some may use [1002..1024) but both [1002..1024[ and [1002..1024) can
> > be used
>
> Because I'm weird, I googled this, and the [a,b[ notation is from
> Bourbaki and hence popular in the French speaking world :-)

Yeah, I firstly thought reversed square bracket was only french and
parenthesis was the international one but the International standard
ISO 31-11 describes both in fact

>
> We don't have many intervals specified in comments and hence we can't
> make the inconsistent style argument either.
>
> So yeah, let it be.. at best its a trigger to get people to better look
> at the code. At worst its one of those triggers that people keep trying
> to mindlessly 'fix', like my use of borken :-)

