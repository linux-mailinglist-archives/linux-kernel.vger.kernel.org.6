Return-Path: <linux-kernel+bounces-313882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E896ABC0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F832B25DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD111D86ED;
	Tue,  3 Sep 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgyh5sP5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2721D5888
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401168; cv=none; b=ojpp4Yma4da0buGxGWkbt5H3rbTcNtkeifp7sAO6xpnM6+eIOqOITKevt1ulmL736iNNj63xm+NTGaAP+o46eUl+ebuQT9lD8urDhwnowjKQO+OQcW8xqOzXLh1KhAnqNS94XA3x1MN/k4RaQyBQX1A34quxhcjDk80/HrGAFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401168; c=relaxed/simple;
	bh=l1sPP+1uywfPIa/46vY8rFtYzS4627eTBEQAv2ZgEsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl9NEdEgfeaMOu1H08lqwSMyIDFtbx9V9ikEneSRNPShFswV+5UHrIW8wN95GNI/eCl9u4Bge3qn80USJOQGxEqevWqpz9HxJmK4cO3UHYNLf6Tk9vjfCdDl+Yy7FRafA4qfuPPcGOm+vaGGyTT8XTturNgR28XB31l0eHNKd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgyh5sP5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86859e2fc0so668817766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725401163; x=1726005963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuoNYko0/HpQLTPUOitl3tKBNtOkoTO1QwU3Z9zqUKY=;
        b=lgyh5sP5HWIAOi9mvZz+CM9exPmLM84ToiLsuU/IuajaOqtIaTysfAFLzk7z0ycsc4
         mjS6f+hQ3CS+NRLi9Rcy0Xu/cnmTb6yL+/dhHqUJDPCQ2BHlMpO+LC3N5MMYx6d5Dc0c
         VboyIApfZOWpeIPGbvN9Da91QclZMgJmTcv4EaUO3gnY3c44NX+CU8a0Klc07w6abu1o
         M72vQHpghhb6G44EuUtW+cVb0/AMQ16+83aceSka3Des/EHswOc47VBqjpIQ7cAK9IDE
         RXx2g04ND2/s/6/QCWJOTeOYGRsUzjhPFCYV7KrwLkb0CjsyTI3P2MeFZdLptu92bz+6
         Fztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401163; x=1726005963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuoNYko0/HpQLTPUOitl3tKBNtOkoTO1QwU3Z9zqUKY=;
        b=lskV5qQ2HaXtcWYVdfbU6mD/JWXiPVGkBJ5SCFLrq9HNLu05q9HeAcSl1GqyRV2yI1
         H7X2cQE+eTsBAb+DMG9JIFJDpZ2zRjnydWe50VBQvaU6yvd5TtaCr1HlgkruKiTejeIf
         PHUfgVfhLUe092u29FGVBi78oH5zUg+s1Snw2uTrpdZ33vzJ49asjhUqBwFouHayvbAt
         IbtJ5qF1TB+QAktlj24IIbsUbFclJpOZeHBZX0T3b7z7KJUA6FY+jYyrO6if4v0Y69DZ
         kGfeZBnuDYq6bq8iuOTx+S4EJ8OwCbedVS4b9WGqe+jIU51jpsJiVwfBSrpfeefcUt6w
         m6ig==
X-Forwarded-Encrypted: i=1; AJvYcCVS5k3X7c3hw27gPWbPA/e01NQoNXjzSpErpCkkiXMNSRq+q8JVo1HMeevrWwVyq6L70Xp8ExcExIF9Bp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBM4+sxInijVeZx6MJ9ukKSVBFt9OTmGXuBMgwqz+HjNeLHCG
	oYBYRIc0NHczWXUGAUbg3E4A6Ef8luDR/t8SvghSsi9lCavDPtGKHYb60t6qkgLoHZ3cufcZyjH
	F6H0/IaX6MNqeL8vDR1kOZxnqO0DaYJrHx4o7
X-Google-Smtp-Source: AGHT+IGT4lMxuEfw6OhI29VcR2MtQGxqfjPJ5fVa43iaBxkyQ6R4dEvkM0CtH83BD8AvXCi4rt/VjeUqqk0zJfJ92Tc=
X-Received: by 2002:a17:907:3f09:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a8a32df30c3mr186623966b.11.1725401162448; Tue, 03 Sep 2024
 15:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org> <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 15:05:25 -0700
Message-ID: <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Sep 4, 2024 at 8:08=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com> w=
rote:
> >
> > > > [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000007
> > > > [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000001
> > > > [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 000=
07ffd619d5518
> > > > [   39.158998]  </TASK>
> > > > [   39.159226] ---[ end trace 0000000000000000 ]---
> > > >
> > > > After reverting this or Usama's "mm: store zero pages to be swapped
> > > > out in a bitmap", the problem is gone. I think these two patches ma=
y
> > > > have some conflict that needs to be resolved.
> > >
> > > Yup. I saw this conflict coming and specifically asked for this
> > > warning to be added in Usama's patch to catch it [1]. It served its
> > > purpose.
> > >
> > > Usama's patch does not handle large folio swapin, because at the time
> > > it was written we didn't have it. We expected Usama's series to land
> > > sooner than this one, so the warning was to make sure that this serie=
s
> > > handles large folio swapin in the zeromap code. Now that they are bot=
h
> > > in mm-unstable, we are gonna have to figure this out.
> > >
> > > I suspect Usama's patches are closer to land so it's better to handle
> > > this in this series, but I will leave it up to Usama and
> > > Chuanhua/Barry to figure this out :)
>
> I believe handling this in swap-in might violate layer separation.
> `swap_read_folio()` should be a reliable API to call, regardless of
> whether `zeromap` is present. Therefore, the fix should likely be
> within `zeromap` but not this `swap-in`. I=E2=80=99ll take a look at this=
 with
> Usama :-)

I meant handling it within this series to avoid blocking Usama
patches, not within this code. Thanks for taking a look, I am sure you
and Usama will figure out the best way forward :)

