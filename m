Return-Path: <linux-kernel+bounces-576562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357BA71116
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E233D189681E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29201199230;
	Wed, 26 Mar 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh99sghZ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314061BC41
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972878; cv=none; b=ZJROAucHiB0WHISlwgjD/KgyvIYqrFpKSGwHG0LGYiUd9MoFZxCIWV/1WQtdi9d4J2OWlwvc0baTuSGrEZGbppx/RR0IomRBCXitViJUxhmv/L9HtP3eHryK+dloODTdqsdFeCsTHPH5/39UxxNfGu7rQfqNRsQovYwG001QkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972878; c=relaxed/simple;
	bh=Gd0mImLluDP6Cvk/FrTC+0noLz6pSCm35L7gw+NTMDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZXS3lJPaODpuE/QlKy9OA4VJe2kb0FC3XoG4WY51b9O8gJtnSqu2dwNMYKg07mz997GNc2MvfJ5/jV6tv5nwL15Y0YxT46o6uiTC8NJOvjYAMLyr8RFWUlm7pMGXKNTL/B1pNUGuTHfNSVGhsq+KNItaB8tv+a8rTfjo5nW8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh99sghZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2264c9d0295so146195ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742972876; x=1743577676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJisumMKd+kkKe315+7CndG23adICIh++toXRWniJ+o=;
        b=lh99sghZTnx30UUx6aEKvowkHZ182R55BEwv6axm7X4GQjvURdjyXVS8CBP/DHAJTD
         R3DzEzBgw2XxpdFw7Qj4qjRJtFX9VyCa+djNkXHH/m1F/w+kRH5rdMor9MqiBZwi4WXu
         raxJDmMQ6DlSLQu5VliwTuZeQVlBVtTjyqivq55iT4vDud5InC5sdHMuuXIAP/9au5PB
         EWaWl9JQjQ4kxnTvcUQvcYkG8jB+s1zKXzRaLNYYDjRHS0a2AhnDlwvUxeWNmehXOndn
         M8kM9t6IzV+43UnQxMsJciUuOCtd0jGaB8bjXo3SDvqtD+WpRqpI7ZvavyuefxhDq9h5
         g09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972876; x=1743577676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJisumMKd+kkKe315+7CndG23adICIh++toXRWniJ+o=;
        b=WGk8rRBhboWFhnsoCp4uufxn6EnYgbEOLaAadU6m5mv/jQCmGkag2K4EGzZQMacJCB
         hJf1xNgjr4ipXvnqYF9v7hZkozgtJNmLQSlFAca0cWOlOVOD3RI3X1vXm4nTF810OYQ5
         Jb1+zkWZuXW7OCEoVIvTO17sl27GKdktv0dv7QxTBZGSWqoknR7+6K5OEQItt4/Wc4PY
         Oi0BbHMNi1lgUmfTSyPyP4FZx5/We8QtphWRcaCvDOIBgbE5yV2OZZPzO2escjv9njLh
         cJL20e8KL6VVmukCDQalUDFcdsCPUQWUiCh0mZjyZ2kzdCH7SF2PETFWd+eYeWOKREEU
         Plhg==
X-Forwarded-Encrypted: i=1; AJvYcCWoaYXehnZ9Dt2zWEAHBdNxBOvS25Qzpat/Yty5wVp6qtl4J+b3m1v90r+fRNT2A8zfn7M+lbmWptcmQng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqA1qVScCoYTUjzmS6KPK7iYxo4gQFca+B3zvVaenYaxy103p
	8ky+CsSikIMXeAPwktmkhkkPYG72GnSBycmNfYFrDxUcFGQpbyzbT6d+v8Uv3xyz8EMXh2F1w8q
	hZ/jWEhsm6UCb2WHzqP+MZ9OaejG/Fe1J6EguLTSSuzhvKKNEnVuXSw==
X-Gm-Gg: ASbGncv3jN9IDptxNdKjgRPtLfaB9hA44KgZIx4bt2mWv/mrvazdCvEAOGNXPhVxaz1
	r29/+a5370Ug/hu2liBund7N/jF9cUWKeXkkKRA0QbOTXLuyAjCfH/AZ6OF9aTQ7I1ERgWVgL+k
	92QVnu9CQ3Qi6lcq6fOn/ilQJJe0uvh7XloKLQHYJJIREf8g092jWqFo8=
X-Google-Smtp-Source: AGHT+IHFuBdQbnSm1QY+8RaydACf/B8hSWUfGR8m1pnm1w1E620d/hVwUiqnuYBiH3d3U88jpcFUcVep41JzI4Ngvwc=
X-Received: by 2002:a17:903:2341:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-227f444238bmr1210395ad.29.1742972875832; Wed, 26 Mar 2025
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
 <Z-MlsM2Gmxdvl_1D@google.com> <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
 <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
In-Reply-To: <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
From: Richard Chang <richardycc@google.com>
Date: Wed, 26 Mar 2025 15:07:43 +0800
X-Gm-Features: AQ5f1JodS1gUsAqWkoTHUMKUb6CqHtXBCYvEl3pJo7gIT-Ni-JuVJFo-mS9ERvY
Message-ID: <CALC_0q9hRAX=46Zd+qh5Pq1myXx+=9gSTT5hu7t1s_Ko4xd_Og@mail.gmail.com>
Subject: Re: [PATCH] zram: modernize writeback interface
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Wed, Mar 26, 2025 at 12:16=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> On (25/03/26 12:03), Richard Chang wrote:
> > Hi Sergey,
> > Since the input buffer length is only PAGE_SIZE long, can we reduce
> > the duplicated "page_index_range=3D" strings?
> > Eg:
> > Turn
> > echo page_index_range=3D100-200 \
> >          page_index_range=3D500-700 > zram0/writeback
> > To:
> > echo page_index_range=3D100-200,500-700 > zram0/writeback
>
> Do you expect to ever have so many ranges that PAGE_SIZE buffer
> would be too small?  I didn't want to put a list parser into
> the kernel, I wanted to keep arguments parsing as simple as
> possible.  But if you really need to writeback that many pages
> then I guess I can implement it as a list of ranges.
>
> Alternatively:
> We don't necessarily need to use page_index_range key, which is a
> little long, but can use page_indices=3D/page_indexes=3D or just pages=3D=
?

I am just counting how many pages we could writeback per syscall.
In a worst case, page_index_range with several two-adjacent indices:
Assume PAGE_SIZE is 4k and index range is around 10000,

page_index_range allows 272 pages per syscall:
page_index_range=3D10000-10001 page_index_range=3D10003-10004...

List_range allows 678 pages per syscall:
page_index_range=3D10000-10001,10003-10004...

page_indices allows 314 pages per syscall:
page_indices=3D10000-10001 page_indices=3D10003-10004...

It's the worst case so the actual world might not be that bad.

Another alternative thought, how about page_index supporting both
single instance and ranges?
The key is shorter and the parser is relatively simpler.
Eg: page_index=3D500 page_index=3D10000-10001

