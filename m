Return-Path: <linux-kernel+bounces-302474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7F95FF23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669DF28449A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FE171AF;
	Tue, 27 Aug 2024 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZUuVJ6T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E98F9FE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725855; cv=none; b=bMBZwiHtjjruKC4/hhdwYLqEC6d70bmLO0C4/Pmm2M3GlSa9epEPv9/ryKGhNhiHbhQ3/6wT68DfFhp7/w6JRor3GhUX7oQZFm5sMCQumUDFI05W0AA/OKV1SSBQqIzCB0KpUgkM6spzIPaCytoZOXhPQQ+elAg5O0rZGdfLAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725855; c=relaxed/simple;
	bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWHmQ5eWN6Gzbi9c+kz4npIJljNb8d0daCNXoy2mTY4cTFkVVMFE/oCr1U+j+RqmJJKtbItZnoj5pixkyItsLHTMMMNVa02hnleoTUwqm+czRsJ0x/Vvr/ShK4e/Wh/ZmfKvbbU2hJFaA+wgGtCEHqBEo67F+7dKhs8fsZKAdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZUuVJ6T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724725852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
	b=hZUuVJ6TXmcnbfaZ7fjhi5BTUOXy5eZpEwbdVH06KhWRq8ARCk3vjyuYXZkLfh8VvykRHi
	XScqQzIxzbYAt5akPA2jj2J1laAKWJ0UnX30scy7rc3fHhegvx+oUjPctibA56G3a9eNwE
	uyRvxYctTHM2h5kI8i97uZCBNE6awaM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-dr8DcfcmNPigE7CAuIpiwg-1; Mon, 26 Aug 2024 22:30:48 -0400
X-MC-Unique: dr8DcfcmNPigE7CAuIpiwg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3e42ef85eso6566640a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725848; x=1725330648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
        b=DyqJu0lCBDmzV59H87Aek5KqN4dZKdbNB22Lsp91XrgwjK8pSObNK0eGQb4uALAniZ
         eISJNcaH5qjEEZU3ZrwkikiA4Us83bXwN7FUfHt3YN+OYamwMFbyuCbaDlHACsGF/gW6
         I81gs23vNiTRv9hNbvLy3d0NVcayPAZVdHSX+n1CCYOR2OyyY/ASe/+JNb+h8ustaBtx
         2LGgW2SyXjbi4HXEEerds/svE8IQ849lnZoo97LUf/x/Wy6yq92AdNpc75lsxLDD6NN/
         2E2W5Y2R3dMZL8n7Ur5o6rg/ov9IxRwppyqr9C+2al67VlggxKAdv8yTosQr/T2TkILR
         Ax1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdIl/yqE4Tgsr3UxcJMLHm0sHLirViLkodww7q++3cO/89ZcyD0Fjjoym0bkmGxUBigsN9/SxiePMxQqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiaE6fnG3L2iq3yDO2fXRB2iZtYTaBFlEpV6htai1eegbiZ7a
	kCsDzXc5nOw91nSLjFNGDQva7lzZkf7HbcQMF7HnZJflpdgdD4IBHjzYKHmRCkqc4Hvq9f3OIiw
	hpPkMAQeXOKr0xEQU72EHDD9jUJdEGmWRt9EnuA8RAUUnI8TUiq5bnCAPynUziLWllazcK6NBFf
	BO95MA1AGAFqpyridSc1YF7pSq5VjECSM2Ryhc
X-Received: by 2002:a17:90a:c002:b0:2cb:e429:f525 with SMTP id 98e67ed59e1d1-2d646d2bbdfmr12924730a91.33.1724725847753;
        Mon, 26 Aug 2024 19:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtxjf7rF0BSgn0bd8C2s21zAHrc0Jh8ekHAzvE0rQf+abJDfKpKe36cKWfv9uNPfnnnYGc4iC+SQa2VVTIMrA=
X-Received: by 2002:a17:90a:c002:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2d646d2bbdfmr12924704a91.33.1724725847255; Mon, 26 Aug 2024
 19:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org> <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
 <ZswgHTRUR-wstAHf@infradead.org> <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
In-Reply-To: <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:30:34 +0800
Message-ID: <CACGkMEsxzwuUiXYKjnACAa0faBE31BfTJq-OeUvdmRELvYJY6Q@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Aug 26, 2024 at 2:31=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > > > What is the application visible behavior that the API use is the pr=
oxy
> > > > for?
> > >
> > > Vhost used to be created by kthreadd but some recent patches change i=
t
> > > to behave like being froked by the owner. So the various attributes
> > > that interhit from the parent has been changed (scheduling and
> > > namespace etc).
> >
> > Well, if that breaks userspace it needs to be changed to opt into the
> > new behavior rather than requiring a flag to not break the existing
> > applications.
>
> Yes, if I was not wrong, this is something this series tries to reach.
>
> No flag means old behaviour, new flag means new behaviour.

Ok, I see. The series is trying to do the reverse.

We need to fix that.

Thanks

>
> > Assuming the change is intentional to start with.
> >
> >
>
> Thanks


