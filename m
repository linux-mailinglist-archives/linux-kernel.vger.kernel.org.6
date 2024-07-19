Return-Path: <linux-kernel+bounces-256881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F36D9371B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82381F21D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078815D1;
	Fri, 19 Jul 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJh621+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F83A59
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350910; cv=none; b=ghbQvtiaALT0WT9ZZDc+xDTz2pjJ/Ai0VNBsRI7dq/y0iiaeZ7TL2Q2pHzMmTHLOYj41deLTtJ4iA0M34TwmHVYS5KunPQtA0zOS44TK6/bYyTl7EsmhFmS7fu74aKvFqPj8UoV8v9TwOoVuiy6yBkCn8t/SFhzaXJKz3tOraFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350910; c=relaxed/simple;
	bh=8KnAlU9cYLXcno95Q36TTWbBLhvPugdWp/i7BifU7nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVSLbIj+lSB4qmsrAhHsNjlXZVKH0iuidffawZddAb0AosudQj3h3p8JsOREu5HqRUYAy+JwowVqDIOzHwfBdegv/nGdE5lWMoTaE6H9WyMsEQir2IMhRJExYMKtwBszMECBMXXc7p0QQm/zw6zfsLTtWWpqYr0C+AEHbCzp2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJh621+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPg8UfS1mNa8nZOIH+oSnc/vQVgPs0AeEqj7g3NW3eA=;
	b=dJh621+Q0PQcxHjoG5wDCs7QuBSMPey9yNsSqyBMioQ7fnLtmGFBhmvJ7oH63oAODkumeO
	bMh3mSQHTnw2MhFIXFJGp0S2/6AJED6o2ibXFoBOs7g+WvS+UcnK9FWt1ExLtNLz13xMp6
	JjLr2WWExx95gWmMrX/NkDHmcTzEdIQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-qmgghma-N6qGA8v5XSV5CQ-1; Thu, 18 Jul 2024 21:01:43 -0400
X-MC-Unique: qmgghma-N6qGA8v5XSV5CQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb6f2b965dso995429a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350902; x=1721955702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPg8UfS1mNa8nZOIH+oSnc/vQVgPs0AeEqj7g3NW3eA=;
        b=rLBrEdlP3Ly8/S6UuNoGQ7lcvAe5khyd0ara1vRfDF0pfQxClqPvjVOltgRHxd30NW
         X3/HZtO9+k2KDw1XzKvXa14gF4Z1pKIWH2d0f5tucew0y2YsTAjOdzuLQiAe/xnohoCD
         j6FUBkfSNZ5CFK1aC5s+t0yaBDtesH6UpbLmJ6wBGgnLY412aDQHwuuBQd/7+jsES0Gr
         XcYZWRiMNaBNGWT0kD2kZB8Mo4yWR6lRvhQBbiJjYsgi6fQQFDEmDcJpL4nOiWMGYakl
         qjxAyMaA9QZi7D8WY+8+ENpA4Pv3WTo07SPAydv0KugX5U25x3fy/K01NX2Wbb7ctn2F
         pK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaUzmTM9DZlYI2owCg6f1N8PG+0SAc1EltMvUj51CNtSQA9wzjNhBKJu1SzrUjV8eStpvCPthrC6CtP6hCeCsTuj7TGKgNZa1rYL7V
X-Gm-Message-State: AOJu0Yzsmiji1rHg5AvOREjylMvLR4sD9x6MtdAQW7tFlX4WQpe9HqNe
	IBttkvMIUmWXNVMAlTK7YlsljbuKD35lnlZ5GHsE6CM7+UStzH7b7XKVDKL84v94pX1R/6e7Xqs
	1F8fSQz1awr2r+4Xo5nmb/2ulAU8ba9ffzaAwXKEnE8rLDqR76ftAecdZWi5wGF7Dmf/GCTq//O
	Np/5auy0fLUWEkGsWQm5LlzO07m15jTxWDP20L
X-Received: by 2002:a17:90a:c598:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2cb51e5efe9mr5425328a91.0.1721350902000;
        Thu, 18 Jul 2024 18:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoOtmyeavURvGXMlZW9QiwWpBgy/DTMI/26rVaTyG7HUyL1xELz/5e17Got+cyMz7yEPSyXmZm+BjeeWh1l0g=
X-Received: by 2002:a17:90a:c598:b0:2c9:e0e3:e507 with SMTP id
 98e67ed59e1d1-2cb51e5efe9mr5425292a91.0.1721350901557; Thu, 18 Jul 2024
 18:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com> <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com> <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
 <20240718153724-mutt-send-email-mst@kernel.org> <53630267-d22f-45ab-8919-3103739e360c@oracle.com>
In-Reply-To: <53630267-d22f-45ab-8919-3103739e360c@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:01:30 +0800
Message-ID: <CACGkMEuUBbTADGL8dVHZ+J=-5d8Kkye2xHHNCwjzLnwAPz6dBA@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:19=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/18/2024 3:39 PM, Michael S. Tsirkin wrote:
> > On Thu, Jul 18, 2024 at 08:45:31AM +0800, Jason Wang wrote:
> >>>> For example:
> >>>>
> >>>> 1) old owner pass fd to new owner which is another process
> >>>> 2) the new owner do VHOST_NEW_OWNER
> >>>> 3) new owner doesn't do remap correctly
> >>>>
> >>>> There's no way for the old owner to remove/unpin the mappings as we
> >>>> have the owner check in IOTLB_UPDATE. Looks like a potential way for
> >>>> DOS.
> >>>
> >>> This is a bug in the second cooperating process, not a DOS.  The appl=
ication
> >>> must fix it.  Sometimes you cannot recover from an application bug at=
 run time.
> >>>
> >>> BTW, at one time vfio enforced the concept of an owner, but Alex dele=
ted it.
> >>> It adds no value, because possession of the fd is the key.
> >>>     ffed0518d871 ("vfio: remove useless judgement")
> >>
> >> This seems to be a great relaxation of the ownership check. I would
> >> like to hear from Michael first.
> >>
> >> Thanks
> >
> > It could be that the ownership model is too restrictive.
> > But again, this is changing a security assumption.
> > Looks like yes another reason to tie this to the switch to iommufd.
>
> iommufd, like vfio, does not impose an ownership requirement.  If vdpa ha=
s a
> stricter requirement, such as allowing the vhost-net sharing that Jason
> described, then we need to surface that now, and extend it to allow chang=
e
> of ownership for live update.
>
> Is the vhost-net scenario currently used, or aspirational?

This question is very hard. But for my understanding, what Michael meant is=
:

1) the current proposal changes the security assumption
2) iommufd require uAPI changes which may imply security assumption
changes or other user space noticeable behaviour changes

My understanding is:

If we want to go without iommufd, we may need to find a way to stick
to the assumption (not sure how hard it is). If we want to go with
iommufd, we probably won't worry about that, as you've pointed out,
there's no ownership requirement.

> Copying from Jason's email:
>    1) Two processes (A and B) share a part of the memory
>    2) A is the owner of the vhost-net who is in charge of building memory
>    mappings via IOTLB
>    3) A passes vhost-net fd to process B
>
> - Steve
>

Thanks


