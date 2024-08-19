Return-Path: <linux-kernel+bounces-291698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE49565AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5A82849F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429615B561;
	Mon, 19 Aug 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ROJ2HH"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138B15B14C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056434; cv=none; b=O1FGkatB0d9p+/nPOJajWa4u5sMqgpkdG89qk13f/g4H5RzRagg44suGYBqeYUdEhqgbVCIAUe7axJrCXPvEXBWRhe9hnzby8BGG5AjUkAQ4Zm2iGHM6Z3v5uyjtzaaG0jHcksIalkIH9sG6g2BZgUG5o5+0b9l4UvoeeIOQM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056434; c=relaxed/simple;
	bh=lgzL4uzXijVTsYudgXt2cfQzrEqt774RO4sWgc4oiLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtMjI3Ko5fpHJXg5OnOvjUnjqQMjtikepQxr5bola2AxvC6m+N7rplff5GHhHziqLfVBJUtHC8dIrWH9VW6ZfH/z0ysIPdWoMZyKtZoGsgsDlKd+2mZRLRM8n/wPSlHTqJPNeC/TqPRhkQn9YgzXG1eSJKd/O/iCxBHWvkSjpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6ROJ2HH; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928d2f45e2so1503128137.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724056432; x=1724661232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgzL4uzXijVTsYudgXt2cfQzrEqt774RO4sWgc4oiLw=;
        b=P6ROJ2HHf9f8zH3xbqz1g3vY/wWBZFdIHxxisgu3/3u4fA1qTG2vDcr7adqI5FxZO6
         VdIcRGYDLTUehgkt5UqWsuNhwNZ3SEDe5TmZlnzbsh/3mgDjvJZk/9Gr0ecaLBMUM70g
         d5UkMqBaQ8m55dtyDlIfKYAQMzkDHUaxSmehi0yt7Of2F44tLEzsp+mUf+q2TPHDR7W3
         2Di9k7l4dN8q3yrZmQvl62hR+g4Dy3V0nijVj28FQKbF7KlfUmUapS6x+T57m5nz4TKE
         C9wdBBPCSX0b3Xc9mgPOINaQn2FwWErDW0nErJzHEpi1KhFjEzXBjo/bPD3lcKk2upf2
         w8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056432; x=1724661232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgzL4uzXijVTsYudgXt2cfQzrEqt774RO4sWgc4oiLw=;
        b=oOdXfu3SBagu0+nPmEun5Q8xT10j1cDLlDBu9X9HDnlE4AyynjJLD4NuwoISrhxHm7
         5rbZPEwGOZdtBK8AGlcmwoBtXQ9ElR1FQgh4fhbqm1PM4AHnFtpBef+owGuPRyqPI2Ot
         538AByX0jNAemZjdzDoeTWlGx14O8L3KUkBzE+bSnEHZS3HiLcJsvH+GNY9DiH+Y4Yjg
         giD+7DKSXvFA5EoxBjtfcuR0C7F1EGrBnCX0WH7/wuSlHykGg/lqnbSiqgkjp7QZWe24
         ww/RWV55FN3YubhUBUE5kEz8O2hSq6+p3DC7KVXDO2Jf5twb3tkLkzEX1LUN9Yf8t9EI
         g1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXYTWjyW1NeJf42l5sM+ixoTOBuK+3eZjDzU7Igqn8JuUAJbVcbP1FcfuzIgMzv1X751VKuSbQit4w3LsDxfWgUvga2JG/JNkjFb8DS
X-Gm-Message-State: AOJu0Ywf7whepDbQ9iML1HsPTxTfa52x4vcboaRbhcqCklHajF0SzPQT
	LiL1YeCdM5sh/Y4sxA6lIieRt00ktzqk0YAcqPl6fK7ciNZAmXzcy3nX/vQ5yz9Y8e7Okjytj1T
	8ce48SJ7VS5WR4lCOWWB5oAfFCRc=
X-Google-Smtp-Source: AGHT+IEI88GcYXpuAKAXXoavc7nwZGFsvOC9nCPH3VZQsgA6YydWXyFZLO+NlIv3bCrheIqqSuSoocxttoieDHP8l2c=
X-Received: by 2002:a05:6102:c4f:b0:48f:4218:4d06 with SMTP id
 ada2fe7eead31-497799b0f1dmr12779926137.28.1724056431922; Mon, 19 Aug 2024
 01:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
 <c817bf05-a9fa-4fb9-b8c6-a1de5a44e59a@redhat.com>
In-Reply-To: <c817bf05-a9fa-4fb9-b8c6-a1de5a44e59a@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 20:33:40 +1200
Message-ID: <CAGsJ_4xaTSu2_F3VaR7Y3bOz2+W9XRU9kS3j7Hatojc6ocpOWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Usama Arif <usamaarif642@gmail.com>, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	hanchuanhua@oppo.com, ioworker0@gmail.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.08.24 09:58, Barry Song wrote:
> > Hi Andrew, David, Usama,
> >
> > I'm attempting to rebase this series on top of Usama's
> > [PATCH v3 0/6] mm: split underutilized THPs[1]
> >
> > However, I feel it is impossible and we might be tackling things
> > in the wrong order.
>
> Is just the ordering suboptimal (which can/will get resolved one way or
> the other), or is there something fundamental that will make this series
> here "impossible"?

i think it is just the ordering suboptimal. Ideally, mTHP counters can go
first, then the new partially_mapped feature will rebase on top of
mTHP counters.

>
> --
> Cheers,
>
> David / dhildenb
>

