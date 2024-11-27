Return-Path: <linux-kernel+bounces-423790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135269DACB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA77F2821B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925001EF09B;
	Wed, 27 Nov 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWfIWleJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9601F9EDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729663; cv=none; b=cX9NUO/4wRYI7+1H71qlcY1chsZI1uHsgb2wGKW37bmbY1iy9SBVkKsoUhOaPGMy693iE392Cr3r8Kbs7EtT6BcUTbgPmnoNRf6EuT+QIC1CnyliKvO2zB9a6YUsSo7Koizhw5/xmj+Kj6qTLm48ZlWWP5vLZmF6dgzxN++1Bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729663; c=relaxed/simple;
	bh=3cPCxD7H2a8Lh6owvh2XlsPsMo9YKelKbnsLwpIFa20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhqKCvda0vZaFqa9K+QWkWXxR04GObQxNHaP1OltDD6OV3SNFs1ZESoOKx8htdyt5CzEwxptJxuqLq+dTwCgGUeOhr5/WNkF3BnXywnFctfolEofYev0OMm72L3kt1AzdaDr6fYgjSMUTf5WjybKUL5ORMn+2t4ozzstqAbRvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWfIWleJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-211eb2be4a8so196455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732729659; x=1733334459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=DWfIWleJP2zsc7O3IabOlmZGs+0jZZ7zMVyHjK+VHNa2BB5GXORRo/zoKnP8HMu08E
         WMYTjzPAeuqPQzuElMlhdYmKeokHcnA0X/hsTjqLK+N5cV3WB+BlCPdkA07w7ARBjLjM
         IoaXUiLI1b4Kj10leMzrbHYBFBXst/5FM1u/cWAesu49qCZKp4ko4sj+/8gMpmaz+NIi
         ZPfgpTZioMmUZFSxNMcZsCr7EegXDZnqt/Kib2ApMIlTd3FwNugl3lvnLCwu2a7Ea5vI
         Mf1YLtl6Tn30wuV5NTn1U78+hjDE4xze/9d7OmUFM+jx7/EUntqxwNYpFTycePkLnu5A
         gbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729659; x=1733334459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=JcszZa+E3QVhkMevLAVJ5v6204L4l75yo47Yz1otC03RYy0le8lmzgY44KGCUsaFgY
         p4Xth/wdN/SWD2GFrDAohFPBJzjP81djqM9NaxFJPE7sHe0tIAX0gSTKCKdfYh05qqm1
         uS6/Tgd6Td2+lFimlahuVfthhZ42ap6Wk8XVZNV7Q/3RT/rqMbBpf/8EwITXyIy7V8i4
         89yea/gjAGINKgq+c+3Vz0Qt1KAImO2JV/h+imZ8R0tKLlGNYVoiazMRl+EHo+/i9Uz0
         9Xwj9yqlj10hyOOXy0xlRH9plQ3cvRVrISaICz+s+tZChzc5KZUCI2yGFiJw4QQmiCLX
         4XHA==
X-Forwarded-Encrypted: i=1; AJvYcCU8e6PZSuOF6wUEKdzONRvvTrsbOr3mu+jdzsZi54BvROOL1zxeAFp2EauoOs8Hyt4sDUU04fsrvTLB8LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfo/RpDmsGS0TuIsz6qN/9Kv2ouQbLB9NtXusCx+qyCqdPLa0
	URZkZjEixlEwIUw4YanxT13bQI5GoMepWnPykbzcaNWeQP7nCQ/viEUjEfG1L8YTmCYIvK9g8ya
	L8yL9HMTa2srDo2J1D0MFhu8Rncy5rKHmlDeH
X-Gm-Gg: ASbGnctATq2Q0QQa1KEOrskd17otBnavvlGNLPPJLmTaQMKQIMx2oTANOqYEBncyWK9
	Y1XfGmrMq5SISd8f3jgv121URZGMWb86LJPETTuX0pSxrAXUJE7PBMuICM3OCnbtw3Q==
X-Google-Smtp-Source: AGHT+IEWj4m7+heIVmeyDopSriS2JGtzJfSKycg033XDM9P61gMKjT+xPWPfu26TGwPqoI2Oh8nkmAXZluulyXqzu48=
X-Received: by 2002:a17:903:440d:b0:20c:8a97:1fd with SMTP id
 d9443c01a7336-2150640abb9mr2258805ad.19.1732729659360; Wed, 27 Nov 2024
 09:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-2-yuanchu@google.com>
 <Z0aeXrpY-deSfO8v@casper.infradead.org>
In-Reply-To: <Z0aeXrpY-deSfO8v@casper.infradead.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 09:47:22 -0800
Message-ID: <CAJj2-QEq5xj7JHNS_QaxWXq0e2KDMX2OSw5rGfYeGC4+X9gx8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm: aggregate workingset information into histograms
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 26, 2024 at 06:57:20PM -0800, Yuanchu Xie wrote:
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 64c2eb0b160e..bbd3c1501bac 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
> >  /*
> >   * in mm/vmscan.c:
> >   */
> > +struct scan_control;
> > +bool isolate_lru_page(struct page *page);
>
> Is this a mismerge?  It doesn't exist any more.
Yes this is a mismerge. I'll fix it in the next version.

