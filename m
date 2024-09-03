Return-Path: <linux-kernel+bounces-313825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0596AA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C61E1C24221
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0991D223A;
	Tue,  3 Sep 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoPWRiNw"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294A1D2238
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399419; cv=none; b=uek0zT1uRRZ4FbrGmn1a50boiWHtUurgb4u/dSdt5/CXZm4Xb5APN819XxrNyeXjK95apaLNC8Vr8gAsD/uUvoTwl0IrwzN49kIMGBBbqrLW9ePkWmCu9JOm3kHGVKcFOBTGVthxRr7bzFKiZBLkHlFEGj7i4g5LJEGt4eAwGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399419; c=relaxed/simple;
	bh=j8XGislP9U4RtP2ur3FRRkYJU1CRFQ2RpUbKpV3GxoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDBL59Z7M+uvRdc6NggKTSZoS9xyYw2hNC6kC2muV42Wk3PMDigzyYtNlfc0sdu6W/1swgzsiQajxSPRFdUpcEHapeHYUXNLdmm3r/nBiOfdsJaEMc6zLWHqMw7M0T8AyT4fUuFqo6bPBdrgGSmFLbot0ReXF3YxTbGDH85eBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoPWRiNw; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49baa3d3855so34481137.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725399417; x=1726004217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w1vlARH9zyVfcMgOZVvOysSX5U8D2E5LJv6StNTa30=;
        b=JoPWRiNw1tzYR0O8xPDZN1ZzarcGtoszLdECseQN2omoy9M1p/UUXQYjM9a0OBuleh
         mxHdKTkum5o6B6ZstEFEfL7+MuiGNgnKoEx0/AuBsTsicVo+HfleGs10gIPY0kPd+3Pw
         FYZX2RVESaP1+hKqy3LC5VElKCDb3cGiecNFZ1a5YY9b8eu6Ci18TofHi3DXy0+R5HAd
         LXHWq6/MWcetXqM4McBpM68gB77yvooetUs5FdUSMmnWbUCb0/xOkjXgodMOcJ9ZsMMG
         M7Lbonjr4WKULXxi3L4bItoMJzB1/ywvHASH2W5JrU0kKPo+Dgn//Yw75dd5YPUD00CP
         l4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399417; x=1726004217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w1vlARH9zyVfcMgOZVvOysSX5U8D2E5LJv6StNTa30=;
        b=c6dyUMdLciqk4oYEAe6ecEGOj4JAFFS5ivi1IYJJUQ0J42kehNV62PMidDdI0+Um8A
         gHfmIh9br22O+akXT1Jy74hJcw9DW0CLSel888+/R6+B0fZNXKLDHUXnhR2SgznYFnXI
         XiBmc6STJAhcoxjjYHO0kuxJ6Vbybi8sdjkhcrsbvMwNUMLviBdYIyUMzxiZ9OZ6mWBI
         C1VWpsJQ3gCTFD/cp1dIn1yy9wLdcmmE7FpEVmR2tiyWZxPUc/tc7CBjswo64qQChu2g
         geyPXLsW4fdlS4YWMb4ANq+IdWTbfjC3g2HJHz9pvQ/teg69n4j0Ubt7Nj6g/+6pmJA9
         RXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9+Ny1P/4Gwks1/J+hX5Ipn4x/Qzxd/LIW0RbPUvltrbUbiEQtm5Uqveakv3tvve/HufT5q88auPAs/M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQi4aKcPZE8ZyHDtS7VVAl6xbnsXF5t2xhxBHFbtXSFVpGoj0
	ttk0xe7A33E4m55xSVRZV5HgqBi7Oh/6QI8Cocog4Y6dkkgoTI93opSB8dub8o+UaHVMbTLi5ar
	sR65QKUcqUWJ08XBHjV91fBUr88Q=
X-Google-Smtp-Source: AGHT+IE1VTcc+43kHJF1X7BqHxNRXquZPm4QywfmSshwZ7gDMTOu4VhzyjyjQxzUe+Y4ceY2tC2bRRg8bns6pHslWnc=
X-Received: by 2002:a05:6102:942:b0:48f:c062:75ae with SMTP id
 ada2fe7eead31-49a5ae57710mr22471813137.8.1725399417234; Tue, 03 Sep 2024
 14:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com> <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
In-Reply-To: <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Sep 2024 09:36:45 +1200
Message-ID: <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:08=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com> wro=
te:
>
> > > [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000=
00000000007
> > > [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 00000=
00000000001
> > > [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007=
ffd619d5518
> > > [   39.158998]  </TASK>
> > > [   39.159226] ---[ end trace 0000000000000000 ]---
> > >
> > > After reverting this or Usama's "mm: store zero pages to be swapped
> > > out in a bitmap", the problem is gone. I think these two patches may
> > > have some conflict that needs to be resolved.
> >
> > Yup. I saw this conflict coming and specifically asked for this
> > warning to be added in Usama's patch to catch it [1]. It served its
> > purpose.
> >
> > Usama's patch does not handle large folio swapin, because at the time
> > it was written we didn't have it. We expected Usama's series to land
> > sooner than this one, so the warning was to make sure that this series
> > handles large folio swapin in the zeromap code. Now that they are both
> > in mm-unstable, we are gonna have to figure this out.
> >
> > I suspect Usama's patches are closer to land so it's better to handle
> > this in this series, but I will leave it up to Usama and
> > Chuanhua/Barry to figure this out :)

I believe handling this in swap-in might violate layer separation.
`swap_read_folio()` should be a reliable API to call, regardless of
whether `zeromap` is present. Therefore, the fix should likely be
within `zeromap` but not this `swap-in`. I=E2=80=99ll take a look at this w=
ith
Usama :-)

> >
> > [1]https://lore.kernel.org/lkml/CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8=
y2PAh7EkTOug@mail.gmail.com/
>
> Thanks.  To unbreak -next I'll drop the two-patch series "mm: Ignite
> large folios swap-in support" for now.
>
> btw, next time can we please call it "enable large folios swap-in
> support"?  "ignite" doesn't make much sense here.

sure.
>

Thanks
Barry

