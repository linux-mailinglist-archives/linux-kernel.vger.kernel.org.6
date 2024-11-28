Return-Path: <linux-kernel+bounces-424555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7269DB5C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D8D281B82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECD1428E7;
	Thu, 28 Nov 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTcgccCs"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652515854F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790000; cv=none; b=DCS4ceYra7FijJ92z3FGyfkWPQaBp8KK3M9btHtgxvgET1LNJcRMhMhQkZ2qoaJAlPpagtbrZyNZRmr4yQQ1F5hgtHvtIyXcka/kb+LigKpIwmX92NTA65VCBkGU6K+Vk7R+HX1+dR/rBroQJzgz6rwoG68vTmkLuXpVtQKMzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790000; c=relaxed/simple;
	bh=XVI8va0sH+hlFPsTGqYXRjjRNC4wP50HEmRED/nMhCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmQgpy0M1fesMGhbqwYp0EO2IihTWSWA3iRarBXHWmtrz4s8Oy3ThtSrQHL2ZFebeB6SAYx8vOmeW6mQrwK5qbRdLlE311ZeEpC+mT97KC8r56JVpc1NXZgavRf/xcuS2i+5h1F3nRsCob2TGF660ujOgVQW5goWp9RbFiGq/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTcgccCs; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-515318b24adso213292e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789997; x=1733394797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSlH/MPJCfCK+2zO1UQk1j2YriDW0ayAfaC2LQcPB+w=;
        b=KTcgccCsLrO8jXp414ivZE/62WEeF1ow8BDDbSTzaEwXN+WlCNwqhCCvv0wemZb8jW
         MnsPQGWRHugK7ToQZl0KxgT7pJSaBDw8WsjjVDHOz3eHOB2HyarpmQcWnvQigOHGsxwm
         +EYs94b3Ym3jKLzlAW5uL7qj9YFvU0E1uiUgoFYJqhjC9z2ZwnUQL6mtIXKuaNc40hXc
         QvAkjJ1y+hjwBAuUaTCKui7RK2tbC7RW2VIrLdMScBRMNNQSbNWMz/K20DJ/ovYPlnz4
         bqvSxKiSzFzo1xfvbW6CLMa1eB+AYx9Z8P8/K/A34wfiN8gjvUPHmA62wLOZ5ij7MR2r
         E+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789997; x=1733394797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSlH/MPJCfCK+2zO1UQk1j2YriDW0ayAfaC2LQcPB+w=;
        b=Spo/Ljt387X2ntNN0SJ+kE3DBA8DlL+7BKr6RnrBZZt55iCslLwgM+8YGUwpAneyFl
         kmjcVexJR3pRe8Fvjsi9zBRtyAPTaorinN+LODGVsr4+IOtAqpUwRnanT4u+IOXSS5Eh
         ZB21YsNxeJVlq0zB8diQpjNNSzIpcxZ2tC14RCZn1zTrrHMd8C+3w1cyPnI6KLWgKKgc
         OhBrVhieBciu6CuQHCFALTzuyA5RA3YzAeRKcFPggb7a0rJKFWhIOApoUUq1LYRElRcS
         FGBmR3+eogxSx73tCTiZmVfB5QMNJkDjDDpTCJe+fniIiXOSYNm21P2fn2RKYEiM/JUQ
         jJCA==
X-Forwarded-Encrypted: i=1; AJvYcCXg53qMQ+vjwC1W6bTUIdCFtC69j/2v7G+qDDYIRbHw6t7rgl7FboNVAZ4WdkNf+ClBqyYMfzDnlGZ0k30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WS9VJ8UlCFkaXDUoW4p09EjCrSi71imPwCs0WljgbrriHE5i
	iegZiXjyAel40r3cCRmLLRkTCntI8Py7chF9U7Y3LTz+idijQsUV4FNB0ox8yOWPh8e3oYC9Ohn
	gM0DZmgh2yI9UNQzW0UA+WZs7N9Y6Nk/3rz02DQ==
X-Gm-Gg: ASbGncuWHBvqgpALG9utWeqt+L1LoBxXoU/YhEMykk3y2ZwRn1rnOC1mr0ooZgMenYP
	qW4kZ611DcMw6qwt3DsHfzVi+5NH+mhGwVw==
X-Google-Smtp-Source: AGHT+IG6Cpu92BFuaMn7+1AP7D9PHmlimrKNM8AMzFkG5MR2IUheXwXzsAppyk7NHe93TQVJIm89CKZ9kUCC0HxzAEo=
X-Received: by 2002:a05:6102:cc9:b0:4af:400e:2a9c with SMTP id
 ada2fe7eead31-4af44950ed3mr8210778137.25.1732789997497; Thu, 28 Nov 2024
 02:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
 <1732763459.0668714-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1732763459.0668714-1-xuanzhuo@linux.alibaba.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 16:03:06 +0530
Message-ID: <CA+G9fYsrhdkWZ-tfLiHU0a4unRVn1GMrTsDnW2RNxeOipU44hw@mail.gmail.com>
Subject: Re: drivers/virtio/virtio_ring.c:1162:11: error: 'struct
 vring_virtqueue' has no member named 'premapped'
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Sasha Levin <sashal@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, eperezma@redhat.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 08:42, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 27 Nov 2024 13:30:59 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > The following build errors were noticed for arm64, arm, x86_64 and riscv.
> >
> > First seen on Sasha Linus-next 441d2975754ad94f3ce2e29f672824bc2dc5120c.
> >   Good: 07e98e730a08081b6d0b5c3a173b0487c36ed27f
> >   Bad:  441d2975754ad94f3ce2e29f672824bc2dc5120c
>
> There maybe one conflict between net-next and vhost, how did you handle it?
>
> Thanks
>
>
> >
> > arm64, arm, riscv and x86_64:
> >   build:
> >     * clang-19-defconfig
> >     * gcc-13-defconfig
> >     * clang-19-lkftconfig
> >     * gcc-13-lkftconfig

The reported build regressions have been fixed on Sasha ' s Linus-next tree.

Links:
--------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig/history/
 - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/history/

- Naresh

