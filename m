Return-Path: <linux-kernel+bounces-274556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E8947A00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E94281DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BA154BE8;
	Mon,  5 Aug 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mp1J/law"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76113AD11
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854540; cv=none; b=f6opsZzA5l//CV/8rnThh+mOUwY0DtqMPasBeoOr8pWETvFw1lXCq3y/9Y9extdFLgcRR1Plefh1v6YI5E1XBaYfenbgWQ8J6Ojw+noEU753CaMn4PXpAgyYpeyP+x/MpnJ4vUq8IE2LYtwcSPp9EADiRyTuTAMBCpLCXR6aZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854540; c=relaxed/simple;
	bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3jQGvJgN7aGvFxFf4XKb9C89jkbmQI0v0qEuWRv6Nv9QZR4dpElD9iL6FRkSwOyjroaDQop79vviv2qZZHmAABi2U/gS1Zz1uyS7z55tMyjU7VwtHSIhhjAKNJxdUdmb/wwQZeiTt/z+X5fTkeSgqTDGz8KqF4DnyE+i2VJh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Mp1J/law; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7b121be30so6545526a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722854538; x=1723459338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
        b=Mp1J/lawRj0iPYvmmkbSf7fIAIfxr2xMCq4Malb2v+82UVzjBsfiVwnOW3Cay0SCK0
         aGF8zlQwktbUpTOULwcIC93L4NPmDkH8AOw71W65EzOKn9DBHvXQsbSxD9reSB5jzBoB
         OnqOorG4Qc6W3RJukFosNmLOjDjbdL1nYD/3hWAjVKJPWdGuMPm02vrhlFk9guSQ19iT
         0ghD1YT0THLNBdM+SfNFzz62OZzd7VAESuKlRSPjInfzMmF6SSZ+G1h4J9Hw6DknzwOi
         LbqtE7xtWkOQcyT+HZTgfwBtrnKLDkgdt9MNavw8U5V6PRyaIKyUjtxDZSKH37HcQ+Q1
         8K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722854538; x=1723459338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
        b=qxOb3aeech4PpU7s5yWSFxY0vyDo5tNBwMh1OdNwawEMis9LXPGD9c7+Ejh5v1wkum
         dJPWzpogzRL1Zc1sE82cSu63dNFRFvkbEWFJLM9diI8hV8CsNs1yM/hT3Tf2VFegOXTA
         G0mAOX2mksaJi5FSStRMZLebCOTcX4MHmha961TK3GiX/jtj6r8FofLxR4xJh1tmOoEr
         H4rzu5xcLNo9E8zcD4soVpM6ob8umD4P/Uoiy7BdOiJ20vPkO1HdDr72EEr1UrZ8efLw
         vcTPsxl7NiUh+SCd16bYBwq1dBVbi65xO6q6aGk9E66V7Weg7XAslNhwnWXiFPTW83jg
         y9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWalwT1ZCZqMoiiuxWZBrZrhU84EiFa8XocHFiCWjeV18y1PmpEqHSaGQWnbSrFXpR5RrnNhGvZ0/wS2BLrkHLtduFAy+egR+nMFs6u
X-Gm-Message-State: AOJu0YxziKzBPSbJkutnxhaPShCphF7akJhlANv/yFRpneCR85H1nF8O
	eFKiybzNy48TMnMClCmb91AXhWXBIqCgMEEDaqFw3qsFuC561h18g9QQAL3lmtKHHch8i7Ex6rP
	CVZtjseEkqm8U3GNlhfW+eA6cWdaQi4PhWwQH
X-Google-Smtp-Source: AGHT+IFw4VZjzhffqjzriPK34h+9Q9/nNAVuqTGi+iy66jK9C2/MunTIueyB4IGjU77PXNHL75GZq3CubKPUdyD4hdU=
X-Received: by 2002:a05:6a20:c916:b0:1c4:8824:24cb with SMTP id
 adf61e73a8af0-1c69956aaabmr11279652637.12.1722854538144; Mon, 05 Aug 2024
 03:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
In-Reply-To: <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 5 Aug 2024 18:42:07 +0800
Message-ID: <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
> >
> > Unfortuantely, we do that under read lock. A possible way to fix that
> > is to move the pages allocation out of the lock into the caller, but
> > having to allocate a huge number of pages and auxiliary page array
> > seems to be problematic as well per Tetsuon [2]:
> >
> > """
> > You should implement proper error handling instead of using
> > __GFP_NOFAIL if count can become large.
> > """
> >

I think the problem is it's hard to do the error handling in
fops->release() currently.

So can we temporarily hold the user page refcount, and release it when
vduse_dev_open()/vduse_domain_release() is executed. The kernel page
allocation and memcpy can be done in vduse_dev_open() which allows
some error handling.

> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage but further
> > optimizations could be done on top.
> >
> > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Note for YongJi:
>
> I can only test it without usersapce bounce pages as neither DPDK nor
> libvduse users use that. Would you want to review and have a test for
> this?
>

I can do some tests for it.

Thanks,
Yongji

