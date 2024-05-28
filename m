Return-Path: <linux-kernel+bounces-191877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B78D1575
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439D3B223C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9B73537;
	Tue, 28 May 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="koTBL2vk"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45A15AC4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882315; cv=none; b=GV13BT/c04jMSksaHhFhVxZQ/vZxcu2eLW9qEDyvamox1c7lRHEe0FmRWvNfgZZUpQ7qZ+aPPh3W1w5xDaJ4e2WJQVhwdhCl1r6iDw+PPfPYs/OyccK2xSoMIqDFD3fZHUO++ueIhuEp9UeMwwwN+urXydtkkHnRMHRfB1teMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882315; c=relaxed/simple;
	bh=s4AFXr6m9coBBvMRw4NwmMAzWfc+AaAO9stgcQr/ywo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF9B7W5ahSzyB0OCdVSQY33R04MbaB62k+ocebGHfwxU/8TACDhA9J/XivjUuRTx98V1i35j7AniSdZXWJxuvC7KB5y48LJRX/QSdo8fc6iJFEs83ejgd1/up7SLnrI4UXVLZNIJVXpJXGWnTEO7z5Vsvd+Z9s88nLkQg8nSwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=koTBL2vk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so515387a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716882312; x=1717487112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJZQOx7zTUcF2zXADbetDAFVrZmcB1mlQ8M5pp4q2Fc=;
        b=koTBL2vkQ3nFS8BCdXkF5HDv+sL/PeuMbRafLXnSvVbw2bju3x/T5rBCzU4LVXqjRg
         qIcn4dpbGQrRVkuOVUKPXEQYPiFeXHI7e3KYKuSwJBp0RKmXDadpzjxMnDgXIFE1BzmK
         BBbxe+H/p4BU1o4wjh/BoPUiH4oV745Z2gk9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716882312; x=1717487112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJZQOx7zTUcF2zXADbetDAFVrZmcB1mlQ8M5pp4q2Fc=;
        b=w7EeBUh81gTWNIbun/g21ciL74AdyBJxHt2+7SCB9xetPk9wuh55DYXItLULvj1AxH
         tk9wRlEfk2//QMNDywISvy74dOv8I+hqvQ4IpzAh1C0eIWtJaummDzFS6nDgGBtc9yhn
         PM0dNYiJKgjBZhNB8zP2rUaRkBjjtJutu2eAuJORyvFOlncC9S42M5e8chaMMnsoUIXN
         ThLhxMX0vyDzDi8eceIzIkcARI9zSOejN1CP9RA6koSHOSVUoSdy5JOu63vqK5MY66Ka
         k8DabjWQ2h9+b69Aesxlq8M2zi7RQj3h+7De2Omk4HJlW2Lp1oZSKqK51hdUyT/jDc8/
         eDVA==
X-Forwarded-Encrypted: i=1; AJvYcCU0u3zCYDPkj1eRDmOjYzBEY4OhchCTXFNko+oW6kumYopAC3gqfJBBnoSRLZ1VlbuWGW4U6elerpdHRxBZDPYxhp3X7Gs7JYxpGpYx
X-Gm-Message-State: AOJu0YwgGhNpWOBtw3IP+Cd8S/vNZUIWYjJec6KqexhiDj8a5dq4Cogx
	r8NEFPcrdKfrxhYm9TRmcmOK3ZI8hyuOWWCYs1n72PECNxxTf42kV/Q5NIPnXWmfTGYZRHKyslH
	6x0jJmu1i/SLzjJAE+kJ8eFwGfVjHqF4srsg2xDS7+A4EBhVu
X-Google-Smtp-Source: AGHT+IFJPIYHUs6LwME8kXfa3gU6qPJ1bQAgQIPu17zC9f1lE6na7kF+nMquELBaMF+aMeltHP3/Ih+Q4eQl77eoKmU=
X-Received: by 2002:a17:906:d8da:b0:a59:d133:87db with SMTP id
 a640c23a62f3a-a62642e0799mr786093666b.42.1716882311557; Tue, 28 May 2024
 00:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com> <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
In-Reply-To: <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 09:45:00 +0200
Message-ID: <CAJfpegsyyFPUDmoi3T8vkS7+jpgfOqeUZBdKW8=Y7R8-b7ch2w@mail.gmail.com>
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 04:45, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Yeah I indeed had considered this, but I'm afraid VFS guys would be
> concerned about why we do this on kernel side rather than in user space.
>
> I'm not sure what the VFS guys think about this and if the kernel side
> shall care about this.

Yes, that is indeed something that needs to be discussed.

I often find, that when discussing something like this a lot of good
ideas can come from different directions, so it can help move things
forward.

Try something really simple first, and post a patch.  Don't overthink
the first version.

Thanks,
Miklos

