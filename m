Return-Path: <linux-kernel+bounces-558721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB7A5E9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A96017918A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB74B33062;
	Thu, 13 Mar 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aCnipNey"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316542E3395
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741833295; cv=none; b=jw8cATVkQuG6P1my8GslQGLHxFA0ELDf2amjAbubAIDUYElFyS3wgEXNJTXjrzZDOdXA2f4MV2R1zlZl+0YSaMM6ZxcD47VDBAW7h14uzwfDrbfrwpXZkRyXM7L2Mkc1BB8WYW5SeU1XxaiTIN/yLTC8DzgYermW8AAASfENZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741833295; c=relaxed/simple;
	bh=I2lWoV8i4ySgFrJZjxYJ8GBvKJVFQLrhl9RtpcESuXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf3hXYzAtBRduC7CrbcFmf3pBQj9SOMtK/MCKCE/bbt2Ce/dNGSK6L5I0eFi7Hq1s9hL1ou9F/hvdnMCCrzpPoq+WWK6CWurqAhPcEkN2DCLE2tcSmiphAVxRom2eMPjAG7uDyEJHkaXx0hcqygVr/y4T/bLlCaOxVM8N7CbB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aCnipNey; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so539249e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741833291; x=1742438091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2lWoV8i4ySgFrJZjxYJ8GBvKJVFQLrhl9RtpcESuXQ=;
        b=aCnipNeytqWHMw6J1sJypP5bEKWbgdXEZJzVML0dqaVpJwvYDW7STizAZiXNHQtSxn
         f4JZkyfgvTdr3QAdprUPADonFLn9iWZEd7x1uBxGYU8Ca6cFyZS0+TjHSU4R0Aq/ouFU
         iuM3r6ia927YAeaoCEslK/EfBbuIWfJk47LI5aZFWhQgcCM5oSuv2WUmqcNFkjHrKroD
         /m7gcA/AC82IuNOAN6GbXxDCJ0V+MD2ZyPFxq3Qt/q0aHHIAQyL4mfIbER3IuVCWxMPW
         pP1pThyE8MnkfGx2hHTN+ubeg/O1TbSC+ApjtfNrUh7iIXDJJydb0rZiNoNmD0xbWTh6
         OAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741833291; x=1742438091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2lWoV8i4ySgFrJZjxYJ8GBvKJVFQLrhl9RtpcESuXQ=;
        b=hD9pwsqQlRxKX/bXeGgE67u6z7+AZG7tOXBJ0c3JHegYbowamJkf+PsJyyh+WM2xU+
         Dqi6VlC1yNU5V2AquYCn+X9NE0535Xa36QZ/+MrmoVB+dsYeSyN/xXHDGxOsf0vx2PiV
         L+FcBVgvbgNHDcGSz1JhgefiDkGNCkP3l1QY+hJPZkvtI56sxhFSTi3E7JfAo06ApZuD
         nQrQJHzmJaX1rEZisiMENubbqTugwhFqiyTgXZy771KJiI+uJc7c/GW7Em291sy7YQJ0
         RgN4Vuzq82/Jhn6/Mo8Ej3evbXWHyrfpCQHFm5Wc0NPTbJqmfKLsYLZJeePCsJmcZa+N
         ZvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5mcTyzjmv0VD93tMTSi1x/LyCCCbNaS2QzVJ7twk5DudLoMFGJ0BkWcbljHzVD5N8cStxkoRZeV05EBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUNrlruHp3n05mcmXWQpW7N+KENE8zgJLgq6bnG+LaxVtipQy
	Jekd7y/1XihSWpL3lbRK4aITTP3TJnn4qXRA7rucWdWNNbIDpjDuBXjqA3/+IOsCERXAfjMkzdi
	G8eWpKOoyOzKlIzd8zStNByvkTiS2UnzLXB36zA==
X-Gm-Gg: ASbGncvOLtkGMc1D0F1hFnhB/u3Dq/I9tEqL1lOQeDmDgyWL2MwFaH9IJ0cdM2Xu8wi
	GdHggBP7Cb4YZQ3W9JURW6p/pHdxNd1EDSj9kVFv3SLEClGqiSV9+HWW5g0ZVJRO+JGLblZr9iT
	vzTEWJE3vcMCunLblCEziy+Nc+OsESVorsZ5Oga8Q=
X-Google-Smtp-Source: AGHT+IGhB76RN1O+q5C6fe5CB4RZKPiYRWzRPZix7PQmmX4uczGObf9EXqG1kng/iYd/vMbcD40pL1GdJ8VeQ4iqTYM=
X-Received: by 2002:a05:6512:3988:b0:545:2e76:495c with SMTP id
 2adb3069b0e04-54990e6729dmr6403463e87.25.1741833291074; Wed, 12 Mar 2025
 19:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com> <20250312231656.GB1247787@cmpxchg.org>
In-Reply-To: <20250312231656.GB1247787@cmpxchg.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 13 Mar 2025 10:34:39 +0800
X-Gm-Features: AQ5f1JoIE96AepnT_CfSpaYDLGW-cX102Hapm8Ns6cVuOUM34YGI5cwK3TL8zcM
Message-ID: <CACSyD1M1ZGOwioXdwYeEAbJYLhZLcSAyWq3ko7yRMjU2uMZ_7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, mhocko@suse.com, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:17=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Mar 12, 2025 at 05:43:37PM +0800, Zhongkun He wrote:
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > memory.reclaim")', we can submit an additional swappiness=3D<val> argum=
ent
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file pages.
> >
> > However,we have also encountered a new issue: when swappiness is set to
> > the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> > to the knob of cache_trim_mode, which depends solely on the ratio of
> > inactive folios, regardless of whether there are a large number of cold
> > folios in anonymous folio list.
> >
> > So, we hope to add a new control logic where proactive memory reclaim o=
nly
> > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS=
.
> > For example, something like this:
> >
> > echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 200 (ma=
x
> > swappiness) regardless of the file folios. Users have a more comprehens=
ive
> > view of the application's memory distribution because there are many
> > metrics available.
>
> I'm not opposed but can you be a bit more specific on your usecase?
>
> Presumably this is with zram/zswap, where the IO tradeoff that
> cache_trim_mode is making doesn't hold - file refaults will cause IO,
> whereas anon decompression will not.

Indeed, I will add this description in the comments.

>
> > With this patch, the swappiness argument of memory.reclaim has a more
> > precise semantics: 0 means reclaiming only from file pages, while 200
> > means reclaiming just from anonymous pages.
> >
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>
> Makes sense to me. With the doc update Andrew had asked for,
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Got it, thanks.

