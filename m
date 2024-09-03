Return-Path: <linux-kernel+bounces-312038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3647A96911C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7081C2155D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684D51CCEE8;
	Tue,  3 Sep 2024 01:53:36 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FC17E46E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328416; cv=none; b=DndLWy8X6/avO1i0HFZuZS7CQckhGAJkwAi7B3mEmyE3uAKiRvRYIf5v80ljFk3nO+47bjdAdZcr0H7ZPabM5AMQyuYMUDdUjO1OSnc5NsQLXn6erHeEfLqFnLz/2IZpB30jZw+TgJnlLu+2Kd9qnrBG3a24mAviWYvzSgy97uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328416; c=relaxed/simple;
	bh=poYTvClN2Qsjc8Mb5ZqhqUYUigb3GcTo6OUdYKyFjus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMMcYwZE20HdjcYSRyPVRwRQhCOiq0WKjHQ69iCU9XxPpwECa3FLolWf/tshw1onqxSjNd3BDhvh3dBqj64QEzTkWx9mN0PyaF6x06R7ztyQxxgD8qZgXzMHD8vmCS+ZamwAhD196vRZ+BboeqPrVTeKx0pRdk2JKQ2zbrhJlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fd01340753so1331383e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725328413; x=1725933213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea+bFyqFSX+YxQSwCO+mp9wllj7zkTS/6Y/bdTrmbnE=;
        b=WhOIjmM0FOndG2NJWxDV5gN2lRuWxIqFhh+4BNv6dR3haWyvLbaR4cdIlNP4juaC6r
         WRgZeHsLYCzw70RI531q7jMVg1bZYxo/L7C78u5xoexwq54L4XtFsGhFYVvJvyLW21uA
         1SczMS/zZUuxB6881GjGLIvRxVQTg7UmIKwc1X+j5FEHGYSBYDLi+9kVqASZGv8Hst6p
         t0r8Cv9Q1PXTZPWZaWclyr4B8RnoSfdUGjwcsAnyfJ3hFpKcOppAPG2red0tXNs2lw7l
         jErO7QWEQ9emhCEo7Nro6FFw7+o69C0RM+DtcANcCAMKcGGsRss3BECDumgexJOHDKHu
         W/pg==
X-Forwarded-Encrypted: i=1; AJvYcCVmZcMolOto0JvSwgBlaSo8TfVAlWRBlrPUxtOODCCLshTT1puu4USeg8+onN1n7qZm5By4R2CLAX2HBi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CXtUTx5StnaB0+eJg8FCIhqtTBi/egSlvsPIcliJG9zoKVuk
	RL95/7oBXUGw423/H4KsHJaBeHLv9I2OCtQ/d3ePxbTtFRS+1iJeuNUMsPi2YqINIQ1rgZKfCbB
	6/yHkHae/9Qr8nfaY6j9/weruIbQ=
X-Google-Smtp-Source: AGHT+IEgKdUnhNq1npQpz3q2eThJQZa2L0vd6jhGuNeLVLkRSpCbCraK+pLcXhqC1+Ah1Ay9wP0CS0ob0E+kovlrdbc=
X-Received: by 2002:a05:6122:20a1:b0:4f5:2276:1366 with SMTP id
 71dfb90a1353d-4ffe4a58f0dmr14431497e0c.3.1725328413013; Mon, 02 Sep 2024
 18:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808111849.651867-1-ryan.roberts@arm.com> <20240808111849.651867-3-ryan.roberts@arm.com>
 <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com> <14823123-79e3-4c7d-8501-8c46c6ec13c7@arm.com>
 <b8ba33c7-3fe7-4b0d-a43d-8a796818bc34@linux.alibaba.com>
In-Reply-To: <b8ba33c7-3fe7-4b0d-a43d-8a796818bc34@linux.alibaba.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Sep 2024 13:53:21 +1200
Message-ID: <CAGsJ_4z+yERPLwzm-8Mkx8MsNZAz0zZWycZfuGRjOc4kxS=HwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:15=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/9/2 17:58, Ryan Roberts wrote:
> > Hi Baolin,
> >
> > Thanks for the review - I've been out on Paternity leave so only gettin=
g around
> > to replying now...
>
> No worries :)
>
> > On 09/08/2024 09:31, Baolin Wang wrote:
> >>
> >>
> >> On 2024/8/8 19:18, Ryan Roberts wrote:
> >>> Previously we had a situation where shmem mTHP controls and stats wer=
e
> >>> not exposed for some supported sizes and were exposed for some
> >>> unsupported sizes. So let's clean that up.
> >>>
> >>> Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
> >>> support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
> >>> shmem controls and stats were previously being exposed for all the an=
on
> >>> mTHP orders, meaning order-1 was not present, and for arm64 64K base
> >>> pages, orders 12 and 13 were exposed but were not supported internall=
y.
> >>>
> >>> Tidy this all up by defining ctrl and stats attribute groups for anon
> >>> and file separately. Anon ctrl and stats groups are populated for all
> >>> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
> >>> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
> >>>
> >>> Additionally, create "any" ctrl and stats attribute groups which are
> >>> populated for all orders in (THP_ORDERS_ALL_ANON |
> >>> THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply =
to
> >>> anon and shmem.
> >>>
> >>> The side-effect of all this is that different hugepage-*kB directorie=
s
> >>> contain different sets of controls and stats, depending on which memo=
ry
> >>> types support that size. This approach is preferred over the
> >>> alternative, which is to populate dummy controls and stats for memory
> >>> types that do not support a given size.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>    mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++------=
----
> >>>    1 file changed, 114 insertions(+), 30 deletions(-)
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 0c3075ee00012..082d86b7c6c2f 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj)=
;
> >>>    static DEFINE_SPINLOCK(huge_anon_orders_lock);
> >>>    static LIST_HEAD(thpsize_list);
> >>>    -static ssize_t thpsize_enabled_show(struct kobject *kobj,
> >>> -                    struct kobj_attribute *attr, char *buf)
> >>> +static ssize_t anon_enabled_show(struct kobject *kobj,
> >>> +                 struct kobj_attribute *attr, char *buf)
> >>>    {
> >>>        int order =3D to_thpsize(kobj)->order;
> >>>        const char *output;
> >>> @@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobjec=
t *kobj,
> >>>        return sysfs_emit(buf, "%s\n", output);
> >>>    }
> >>>    -static ssize_t thpsize_enabled_store(struct kobject *kobj,
> >>> -                     struct kobj_attribute *attr,
> >>> -                     const char *buf, size_t count)
> >>> +static ssize_t anon_enabled_store(struct kobject *kobj,
> >>> +                  struct kobj_attribute *attr,
> >>> +                  const char *buf, size_t count)
> >>>    {
> >>>        int order =3D to_thpsize(kobj)->order;
> >>>        ssize_t ret =3D count;
> >>> @@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kob=
ject *kobj,
> >>>        return ret;
> >>>    }
> >>>    -static struct kobj_attribute thpsize_enabled_attr =3D
> >>> -    __ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_stor=
e);
> >>> +static struct kobj_attribute anon_enabled_attr =3D
> >>> +    __ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
> >>>    -static struct attribute *thpsize_attrs[] =3D {
> >>> -    &thpsize_enabled_attr.attr,
> >>> +static struct attribute *anon_ctrl_attrs[] =3D {
> >>> +    &anon_enabled_attr.attr,
> >>> +    NULL,
> >>> +};
> >>> +
> >>> +static const struct attribute_group anon_ctrl_attr_grp =3D {
> >>> +    .attrs =3D anon_ctrl_attrs,
> >>> +};
> >>> +
> >>> +static struct attribute *file_ctrl_attrs[] =3D {
> >>>    #ifdef CONFIG_SHMEM
> >>>        &thpsize_shmem_enabled_attr.attr,
> >>>    #endif
> >>>        NULL,
> >>>    };
> >>>    -static const struct attribute_group thpsize_attr_group =3D {
> >>> -    .attrs =3D thpsize_attrs,
> >>> +static const struct attribute_group file_ctrl_attr_grp =3D {
> >>> +    .attrs =3D file_ctrl_attrs,
> >>> +};
> >>> +
> >>> +static struct attribute *any_ctrl_attrs[] =3D {
> >>> +    NULL,
> >>> +};
> >>> +
> >>> +static const struct attribute_group any_ctrl_attr_grp =3D {
> >>> +    .attrs =3D any_ctrl_attrs,
> >>>    };
> >>
> >> I wonder why adding a NULL group?
> >
> > It made everything a bit more generic and therefore extensible. Its my
> > preference to leave it as is, but will remove it if you insist.
>
> My preference is we should add it when necessary, but but I don't have a
> strong opinion. Let's see what other guys prefer, David, Barry?

I'm fine with either option. Adding a NULL control group makes it
easier for lazy
people like me to understand the current status, as it clearly
indicates that there
isn't a shared control group for file, shmem, and anon at the moment. :-)

Thanks
Barry

