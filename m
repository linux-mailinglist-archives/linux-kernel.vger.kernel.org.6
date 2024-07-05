Return-Path: <linux-kernel+bounces-241906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75939280FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F5D28300E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0A22089;
	Fri,  5 Jul 2024 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtlA5RSK"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587828E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150996; cv=none; b=oJ9lIkzjKrLLoI4R0bV09nnvrlnp5+xpj8rnjPpmVY2b2m2mJAg10Rsw14Mjt7usOG75B6x7kwz/kL8lx16rFLq1rybSVPgnwnmhFA3b5HDUKvu/gJMvaWsQiEeOmmJpHMksmLMu/acx1A0W4cJ3/Eay7BU/ccFHuepcA/swSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150996; c=relaxed/simple;
	bh=O6XIoG6dyrU7akb7W8dGybpPWVG1Fepw8bMBp6GWGjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5NW0GnHDn59YLGdnE+OBsUR3UV46aFDNZcmLHolOw6YrHZHfY2THMxKjtrriKRGzN/zNEhTj0yhnwpmqPPuLJO5Z0AW4nEoUQQWG+unBYg+gouKHl682ZCNIkXdB/WKkP3BBog+PetICHoASw3tQX8JZW28uXVC0Ke/WuswjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtlA5RSK; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8100ff1cec5so362397241.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720150994; x=1720755794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p22ZqaLJJpSERBkYdzymubdS4vnjA3mYUiy7vTohqHs=;
        b=dtlA5RSKG7pdLBukOsTUziEEieGuGNH+p7HpILF7DmaBs4MYWlzRCvkVrFeGZDmW8J
         ODaGsDJG94ypFVgMniwhWN9U78UB5GAXiH01NK/8sq2v1OF/B7qbos6zq65DxYV/hJKS
         WQcOk0xkHQoq4vk7jOA1wb2VgtLk2zMPF42d91zqH5/fQMMPwEzuJkjv1wd4JT9ke3t+
         lQtrw5G7jxjIUMDU9tzyLhlpTgX0x8Xfl12LD/2owyctTQxhmI1mLTprYBabHRlREbYv
         zydEyhCxV+BmYH6/VRs/pJi3QuE/LqRLoEOyfPp3h8q2ECxXcv0nKE3Y3qh3mDRLYq/K
         2Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720150994; x=1720755794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p22ZqaLJJpSERBkYdzymubdS4vnjA3mYUiy7vTohqHs=;
        b=sg+KhZYNggyfAG5Xka7eHGgRTlrqMnqMS/O+PWP6eO7IeRz/anhlobok7xttTDHFz+
         D4iqAHDo5IX5wj61SFyrWjclBey0OdyWkMWDyTTwKRUGHJL4jsYC23XeseN1DXAvISmo
         R/kEz1TF/ivi8QeUiN0IVXLrCxUye9si8FX8tV4RXq0RWKNgknlgHxF9Q9hEHVR8GfQL
         yHReSs2Ein6W4ZhUoXixPXirWL2IUCfgXo5NK688Bdo3LeFZefIl8wnwYpZ69YOV2uB8
         BHy8wKw8uFe35i5/aCIyKd/fjbzlk5UKh5lTvSVyS+sM0jNljJwGAg7HNfJiUDY1sq/1
         0SPg==
X-Forwarded-Encrypted: i=1; AJvYcCWa4BpAqpVwpCygw3hn2sccSkN0A80wfAs0Bube7UD24pZxEIz4UpylPXfT3QyOUJFzVPxyHBe0H5KG1hBycoFea9I06KKFBzXJ/Rgr
X-Gm-Message-State: AOJu0YxrhsISdE20uNi3bC/MR37I9niRovzJdcNGGfj1yfkkJEPmxGnw
	wUtyrjS+zgb9e6e8rg29knCnK2u7jvMbHyriPJx2H9yI2e10k3c/9wbU0B3cyNRBydS1dNC3vk5
	XFhObzm+116qEvoaVr/zxt1SYTug=
X-Google-Smtp-Source: AGHT+IG9n0kvLFpj1kc1RUXMhDUYn3ipmn5dTJMSWAGb3fd7LbIYsqtiyQ7y6AhCSXUyBeSOiYaeBUKk8gM9G9qXt+A=
X-Received: by 2002:a05:6102:214c:b0:48f:4320:114c with SMTP id
 ada2fe7eead31-48fee667efdmr3534894137.15.1720150994204; Thu, 04 Jul 2024
 20:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-7-roman.gushchin@linux.dev> <ug2qpeiq6jrtr4qtnblquiod7rgqdqsy6nfu5idnpxqwrzdq6o@mmbsul2g6t52>
 <20240704163534.e82b0d4108ab70319781d6a9@linux-foundation.org>
In-Reply-To: <20240704163534.e82b0d4108ab70319781d6a9@linux-foundation.org>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Thu, 4 Jul 2024 20:43:03 -0700
Message-ID: <CAGj-7pVwCrjeixvOqzx8x-3wpZ8ZnvUki5XQtRPtXMa2QjU15A@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] mm: memcg: put memcg1-specific struct mem_cgroup's
 members under CONFIG_MEMCG_V1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 4:35=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 28 Jun 2024 17:48:54 -0700 Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>
> > > -   /* For oom notifier event fd */
> > > -   struct list_head oom_notify;
> > > -
> > > -   /*
> > > -    * Should we move charges of a task when a task is moved into thi=
s
> > > -    * mem_cgroup ? And what type of charges should we move ?
> > > -    */
> > > -   unsigned long move_charge_at_immigrate;
> > > -   /* taken only while moving_account > 0 */
> > > -   spinlock_t              move_lock;
> > > -   unsigned long           move_lock_flags;
> > > -
> > >     CACHELINE_PADDING(_pad1_);
> >
> > Let's also remove these _pad1_ and also _pad2_ as well as this
> > rearrangement nullifies the reasons behind these paddings. We need to
> > run some perf benchmarks to identify the newer false cache sharing
> > ields.
>
> I guess this is going to be a followup patch (please).

Already posted [1] and has been picked.

[1] https://lore.kernel.org/linux-mm/20240701185932.704807-1-roman.gushchin=
@linux.dev/

