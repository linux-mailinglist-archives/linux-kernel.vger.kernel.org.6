Return-Path: <linux-kernel+bounces-265109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A193ECBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D31B219C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC580623;
	Mon, 29 Jul 2024 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNIeQ6vG"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D901E49E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228586; cv=none; b=m2mqrJ2si4yHXFCCUPln18gcpig5MY/mA22Xy6AqgUdUK4JPY+RuOKDnClj/g+OzWWeZvOp5SpfOf6CYfVUh6i+7dKnB46PwYf/dEWdtMcorQjAdRvQh81A42BQRc9Moh5f+gFQWv4Hp/sP6s2rz3ipEJocYw9/deKobapVX4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228586; c=relaxed/simple;
	bh=OzmJVhN0dykLSQqjWoENWCMMI8e9RyQfJDOPMxgmVQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3VMj4rv4VgSld2Q6hVxolGpaFhTREFIdmR+a9nM4V5ftyHRVK64k041o+OLUL6VGxyuetQgkA4rtn8jCi67neT6T32B1b+WjiCO/q+qxkZz6d46SKKQjpQmVYpUfJaTwSVnVKiAtsfRUyAC3aE3XBkrOs34HkIESd1++zW94Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNIeQ6vG; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f6bc491759so881921e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722228583; x=1722833383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2KfcWX4KbJ81LM4EXKwwWqkcKVjndWUDZFzO/J9RSc=;
        b=mNIeQ6vGNWT4NKt9vM+Pu4LAlHcxUj5beT11WZRrrlEQimA5OvZXX9TYybVsai8dls
         oXv6EC2mqqmbzLjZ5mNyEpmWWvt33Zx+97sOzhG70GT6u2KhmBi+nZXGLPk39kkMsnQU
         CVnVas2vIrvIGOdLIIJi5ehYC0R/axiYY2mi0abtVi1FeV0R3Oaat4RUA9EBYRvAMDC2
         Tv+nhoRZbbpLTGJZ+YGo1IIMN6/FKSIZwEau3Xya3WSofrAfUGjpXI3DSyl0FZEvSbzt
         6fQkt0CY4SkILr3EVie9C4PXzuS/PMTnA1tPdUhkGW1hAOmLFWRx8DIeiVwdwEL7WqSx
         LQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228583; x=1722833383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2KfcWX4KbJ81LM4EXKwwWqkcKVjndWUDZFzO/J9RSc=;
        b=B4d9HGVmNocvB7zdR0sdi3d/jTnD9bAIw4gV2BlvToWj9EIuuu9xVvRsIioavro9iI
         1M5b6VpX13Q5Oo+BomguOtjgwjoxPRvv6/xBEQA2UC6D8PVONtwsso+sr3tn8pPG/TAN
         HVXFjXi7mmT5xcaR6PAyX61+4Ch5jDB9GInkwHfQIAGy31Ua581kHyJ8qbLgAmA9/ON2
         V5WZD6XCifa9Cm03k2yqeuRHTSvepq9EMCy/7uRHeG9XpS3HQRVB0gxW0A1xjiPb/8NS
         vexCPbKBcLkPRzSi3uX6tu/1TphYoAbOfI+U3lyetjlhSdhgWk0ODH/UbndXNP/QtWe0
         Yueg==
X-Forwarded-Encrypted: i=1; AJvYcCXB2ScJfec0adm0pkdPC7h1n6YSzAKgu/d54N9gHohQDEwysOcPcHaojGZXEC0m6swuiRqVOcmOhPmNzLuTD7z+NN3BcFWxb6DA7GXe
X-Gm-Message-State: AOJu0YwnVEEr3cQaFEcKYD0Xsz2pvfCqRrxib1/d7dbN3DS9PoO5mPE6
	TmgASJH6b7CJVPw7HGiZWuyRG7dY5mzfb0eyq7vFqLm9plho59IfgGrPo4F2lmLPurDMBLhigMB
	EZg5T2dUmjr1FH7XTmvz8qrbbzsk=
X-Google-Smtp-Source: AGHT+IFIXnVcPdK/uT50Iqdy1PDwCx0e3bFHORUL/8NjLqKj2HaLltLYHo9eR9U+7kClMyBEe83zDS+8BczIH8pCD+0=
X-Received: by 2002:a05:6122:3b0d:b0:4f5:1363:8445 with SMTP id
 71dfb90a1353d-4f6e68e1eb7mr1876725e0c.7.1722228583450; Sun, 28 Jul 2024
 21:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
In-Reply-To: <ZqcR_oZmVpi2TrHO@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 16:49:32 +1200
Message-ID: <CAGsJ_4zRLH_W=2fduujTt6Jh41+ZaLNkm7a_1kDorhCLjkbbAw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:52=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jul 26, 2024 at 09:46:18PM +1200, Barry Song wrote:
> > A user space interface can be implemented to select different swap-in
> > order policies, similar to the mTHP allocation order policy. We need
> > a distinct policy because the performance characteristics of memory
> > allocation differ significantly from those of swap-in. For example,
> > SSD read speeds can be much slower than memory allocation. With
> > policy selection, I believe we can implement mTHP swap-in for
> > non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understa=
nd
> > the implications of their choices. I think that it's better to start
> > with at least always never. I believe that we will add auto in the
> > future to tune automatically, which can be used as default finally.
>
> I strongly disagree.  Use the same sysctl as the other anonymous memory
> allocations.

In versions v1-v4, we used the same controls as anonymous memory allocation=
s.
Ying expressed concerns that this approach isn't always ideal, especially f=
or
non-zRAM devices, as SSD read speeds can be much slower than memory
allocation. I think his concern is reasonable to some extent.

However, this patchset only addresses scenarios involving zRAM-like devices
and will not impact SSDs. I would like to get Ying's feedback on whether
it's acceptable to drop this one in v6.

Thanks
Barry

