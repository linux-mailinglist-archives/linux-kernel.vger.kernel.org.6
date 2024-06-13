Return-Path: <linux-kernel+bounces-212770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324C906610
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052191F25311
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8A13CAB2;
	Thu, 13 Jun 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHafRWEV"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBD13CA87
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265612; cv=none; b=Di9nHKVClkzcbUvoFx2aTEQz5UPGzFXawhcaPkDFFFQ0A9XMdABc2yT0Dl4PWaC9QVtgN27B/XjhjPQefTPIwoWYZsVKmcu73TxOdNFwKnxwbI9GdBCdaHC8FcMfMQYVJVG1YVstJFbUMoXWhFOg6KsQRKlHcw09PruzRh7qcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265612; c=relaxed/simple;
	bh=aP1VI8hpnO5c/PN7JVXiD6QGSaUwXPkX1stVwfI+GHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9vROWY8Nh+OlV1we6xBouf/hRHA9y49nxVyoj4I30NHfyxAirqtzD++tTBB8ws2G0E2eApV/g6Mq6ZE+0chwIxneulwQbS3J/IOkecA7yGVqryajoCe8/f51NNDQmf7l6ENG+UE/5VWBc+ut64PC2jIOdSkZdbUHFc4Mqi2bdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHafRWEV; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48d7a81a594so298943137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718265610; x=1718870410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lM83IWwh2VbLqKmQaNYtAMo8vBQQpf/F1x4aBeU7dk=;
        b=RHafRWEVTpVa7IxhdKkF0S26sKFMjpf7QTYAS0jtrqKiUqsHIpBx7RueJt0DfXhktN
         z6Kuf34NHPd9yG1RxmmeS9yDwiO7GE4Jyes64KnaiMFlUmVSvXGN756ijffhrZ/WguEg
         +tBphioowjkJuB9oZs+wVOmaDN0w3QNJyaO8lBp6fayJdLQsE4TNi3LtTCJF/oc/+pJu
         V/IBo8lgl7xx63gK3wfiVSeGKduziY33PWk0b9VTdeJp9ZY9W/c3Pz4GBuArR+/SnALt
         +WsA/Fo3JWT0E4RDzqr364biWnB3/ReNIMkl4p2OOl0ptsP8mIJ3pfU4fBOSqEIEq3Cg
         sOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265610; x=1718870410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lM83IWwh2VbLqKmQaNYtAMo8vBQQpf/F1x4aBeU7dk=;
        b=aslLv6YDhQVOYnIsYNegs2bTTOW1S3P+I00E+P6qDcjk8RSyGYPAHjmGFKCuL+FsWK
         mC/r/KDNES/7/lmogiIVBYDhYtvlTap02L53ZPmW4wGZj7b8K/OD2XvOhulf1MQv9O3W
         u8tu3JBAzYF0PEf7FMPP7H7QV3np4ej25hoSMbP4MlPJ+jC6/S/kC5A5JjoQjk4FXf3M
         0bIFJEryX9p5bKhKEx3mMbRj/trQtVrKrTp0q/OSDWP3UwpSet+brRFUVrxaW1QLbrkT
         GFrl8iw846ECwqIUuyBz5Z2LiFAkr/CqGxXGup7gE05cmymn6v4jqp+W47BJIn+RTwHE
         ZSSg==
X-Gm-Message-State: AOJu0YzSD/U+TnByanhlhZ4LfcPtbz9axWlztruSzT2kjJuFTjAHYjfw
	LKBv4v+NogAk+/odA3QnHg2qG5dQ0BOsuALP3aZmlkDobHir6RXIBXMyDBn39Frj86shGjIRWYT
	HBS9rdd+BGBnYQERzfSKd1vbQ8+1cX2hjQUjisA==
X-Google-Smtp-Source: AGHT+IHa+yQFZDiDKFCzXo7TDWxbukykmun218hV+HF2r0JkUJXC4XsljW/zY4b5VQ/5CvvZTE6qL59TZOfDJ6sVLdA=
X-Received: by 2002:a05:6102:2cb:b0:48c:47c3:7857 with SMTP id
 ada2fe7eead31-48d91e6b719mr4159186137.29.1718265610035; Thu, 13 Jun 2024
 01:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com>
 <20240612125130.2c1d6d2d@rorschach.local.home> <20240612171748.0bc6d9cb@rorschach.local.home>
In-Reply-To: <20240612171748.0bc6d9cb@rorschach.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 13:29:58 +0530
Message-ID: <CA+G9fYu+GbYyw5J0XBy_W8VcHPdEf5Yu-gV7nhZTZioz9G6q_A@mail.gmail.com>
Subject: Re: LTP tracing crashed on arm64 rk3399-rock-pi-4 - pc : ftrace_ops_test
To: Steven Rostedt <rostedt@goodmis.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 02:47, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 12 Jun 2024 12:51:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > [  100.600222] Hardware name: Radxa ROCK Pi 4B (DT)
> > > [  100.600229] pstate: 800003c5 (Nzcv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [  100.600239] pc : ftrace_ops_test+0x34/0x138
> >
> > Hmm, could you show the exact line of the above code? Specifically we have:
> >
> >       rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
> >       rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
> >
> > Hmm, it's a NULL pointer dereference at 0x8, so ops is likely not NULL,
> > as func_hash is much farther down. But if func_hash is NULL,
> > filter_hash is at the 0x8 offset.
> >
> > So now the question is, how did func_hash become NULL. It should always
> > be pointing at something. May have to do with the subops. Will investigate.
> >
>
> >
> >
> > > [  100.600258] lr : function_graph_enter+0x144/0x208
>
> I wonder if we need the following patch:
>
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8317d1a7f43a..fc205ad167a9 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>         {
>                 for_each_set_bit(i, &fgraph_array_bitmask,
>                                          sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
> -                       struct fgraph_ops *gops = fgraph_array[i];
> +                       struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
>                         int save_curr_ret_stack;
>
>                         if (gops == &fgraph_stub)
>
>
> Because if the compiler decides to re-read gops from fgraph_array[i] after the
> above check for the following line that does:
>
>                         save_curr_ret_stack = current->curr_ret_stack;
>                         if (ftrace_ops_test(&gops->ops, func, NULL) &&
>                             gops->entryfunc(&trace, gops))
>                                 bitmap |= BIT(i);
>
>
> and gops now points to fgraph_stub, it will trigger this bug.
>
> Can you apply the above change and see if the bug goes away?

I will apply this patch and run the test in a loop.
Since it is only seen once. Not sure I could validate this and confirm.

>
> Thanks,
>
> -- Steve

- Naresh

