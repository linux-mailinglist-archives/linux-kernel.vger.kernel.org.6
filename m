Return-Path: <linux-kernel+bounces-308566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44744965EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBAAB27B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9493818FC78;
	Fri, 30 Aug 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZsROsnO"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D616CD1D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013096; cv=none; b=oazaswL72ileOQUDJsJYEd2VwBCcxkyYYa9oxqMyJplslG2m7Ddhf57Hvb/kLlnjf+H8wtL4p20556q6dXpJQswZ1IyM0MIbTBXhfMUSUW7XvwtWruGvDMBXaMzo8hjLT80durHhxUiQ2z/rvXg1F+OVl2o94NM98TBGKBnSW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013096; c=relaxed/simple;
	bh=PetK3Lc5AxGaeJOb4DCw0HX/+hPiWmg/Q4goL3s/Idw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r2QYhZdHlQrHr+mO42wbXCAbov3KPPpFZzhsUSZd0YmfA9phYsigmMsRHnR0MkHJIuRsuxmrSPMArj4ArLU3SwAOROScjeCqgxeTVnQcZbZpqqP9LJYKnbsk7IpmM3S8L+q3E7ChQEKb6KYnXEcmbWx1Zro+EpUC2nuOGrqdSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZsROsnO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7bb75419123so1010767a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725013094; x=1725617894; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhjXrY66aQqjBoYOxAvINjNegNxb7ZOaXewyBkVrXPY=;
        b=HZsROsnOHLWMdpuWNWkJlWEYO6lJOc1C3qkpIZhZBSdybR92540kv633cjd2wHYKN3
         L5Q0E/NJ3dOBDGp50GFiufaKLa9LTDWZ1ifJVRKeOwnLdSX756iCz9SXvouJNvX3vHj/
         +gpeBYXp4qLX2/EDBPEfrNjiVlgttq9oNg/n6RMsp+5Ksdx2Sf4rtdjD3jB84zO0gEGU
         7gnwwm8Cyg1Lplvg0s56kVJL6/KzTLoaA645U/0ePYSdFXDSEaIYzRflBGV1B9I2ItNV
         yKWjyEQqYW4J3ToWVyyrPCklwSDepP33iB5eYuCbUbdCiyXcJikfQdkeeOVJUM0xUVst
         jpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013094; x=1725617894;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhjXrY66aQqjBoYOxAvINjNegNxb7ZOaXewyBkVrXPY=;
        b=NqlkTD92w6KnAqY75lmsODauZQK9bnw9I8ejlbox9JFz9pKMY++kdJnAX47Pynnz14
         dxrXP7TSJE7Es67Spq54sTvdeSozv9EC3nxHIHdHFERqSCc83lEWlHfdDkWfYnZVxo19
         j5s40VMcQk6YmMJtsVudzeu8Ydtn+qKFxetTmFWeIylJQZoVOHb04CCrNMFCWkbRhHRW
         HwTp3czMsDOCHewV72qeo59s0rb6s8MlF6CRqKOa9z5IHmDcjEDfN0hGBFzDWLCzFCYm
         1ivJfedlYXz0NMVPtMc2ptqYEPj/AB5/9bVvgXRM3twIXwmmNh9XW3qo7ZXDQpNwm4FK
         RfwA==
X-Forwarded-Encrypted: i=1; AJvYcCVaalp+5yt5gGJQ/l5LHzz74wvQJja36siNTcX86Jk47F/zAZ4A5aKeBqiOx91TNjIBXg4i4/+N8fPh8nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSoMekXllsKG7xBuNoBuSRbl3b5WpYyXuEgqXGtCtqknLQYqAv
	Nt/RLI4MbMZfxT2kBz/aUyjkjYZBrMcoHhQQf0VBuxcmY0aEACkHpnhIptGbHQ==
X-Google-Smtp-Source: AGHT+IESiNr+ViFs8CZa9rAsO5YWji9DJdOcgxH36+ht1foL3djmeL/yUo6l5fw66rlGTYuFv4zHzQ==
X-Received: by 2002:a17:90b:17c7:b0:2d3:c089:84b with SMTP id 98e67ed59e1d1-2d8564cf3c0mr5704198a91.29.1725013094189;
        Fri, 30 Aug 2024 03:18:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39d03asm3372089a91.43.2024.08.30.03.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:18:13 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:18:11 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com, 
    chrisl@kernel.org, ying.huang@intel.com, 21cnbao@gmail.com, 
    ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
    ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
In-Reply-To: <3c7e4800-ec9c-4288-85bf-89f3fef18827@linux.alibaba.com>
Message-ID: <e88b1850-ca36-aec5-ad27-0b2753c836f5@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com> <d3dc75e2-40a7-8439-734c-19d83707164c@google.com> <3c020874-4cf3-418c-b89b-4e6ed158e5b9@linux.alibaba.com>
 <c336e6e4-da7f-b714-c0f1-12df715f2611@google.com> <3c7e4800-ec9c-4288-85bf-89f3fef18827@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1789196680-1725013093=:16809"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1789196680-1725013093=:16809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Aug 2024, Baolin Wang wrote:
> On 2024/8/29 16:07, Hugh Dickins wrote:
=2E..
> >=20
> > Fix below.  Successful testing on mm-everything-2024-08-24-07-21 (well,
> > that minus the commit which spewed warnings from bootup) confirmed it.
> > But testing on mm-everything-2024-08-28-21-38 very quickly failed:
> > unrelated to this series, presumably caused by patch or patches added
> > since 08-24, one kind of crash on one machine (some memcg thing called
> > from isolate_migratepages_block), another kind of crash on another (som=
e
> > memcg thing called from __read_swap_cache_async), I'm exhausted by now
> > but will investigate later in the day (or hope someone else has).
>=20
> I saw the isolate_migratepages_block crash issue on
> mm-everything-2024-08-28-09-32, and I reverted Kefeng's series "[PATCH 0/=
4]
> mm: convert to folio_isolate_movable()", the isolate_migratepages_block i=
ssue
> seems to be resolved (at least I can not reproduce it).
>=20
> And I have already pointed out some potential issues in Kefeng=E2=80=99s =
series[1].
> Andrew has dropped this series from mm-everything-2024-08-28-21-38. Howev=
er,
> you can still encounter the isolate_migratepages_block issue on
> mm-everything-2024-08-28-21-38, while I cannot, weird.

It was not that issue: isolate_migratepages_block() turned out to be an
innocent bystander in my case: and I didn't see it crash there again,
but in a variety of other memcg places, many of them stat updates.

The error came from a different series, fix now posted:
https://lore.kernel.org/linux-mm/56d42242-37fe-b94f-d3cb-00673f1e5efb@googl=
e.com/T/#u

>=20
> > [PATCH] mm: filemap: use xa_get_order() to get the swap entry order: fi=
x
> >=20
> > find_lock_entries(), used in the first pass of shmem_undo_range() and
> > truncate_inode_pages_range() before partial folios are dealt with, has
> > to be careful to avoid those partial folios: as its doc helpfully says,
> > "Folios which are partially outside the range are not returned".  Of
> > course, the same must be true of any value entries returned, otherwise
> > truncation and hole-punch risk erasing swapped areas - as has been seen=
=2E
> >=20
> > Rewrite find_lock_entries() to emphasize that, following the same patte=
rn
> > for folios and for value entries.
> >=20
> > Adjust find_get_entries() slightly, to get order while still holding
> > rcu_read_lock(), and to round down the updated start: good changes, lik=
e
> > find_lock_entries() now does, but it's unclear if either is ever import=
ant.
> >=20
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
> Thanks Hugh. The changes make sense to me.

Thanks!
Hugh
---1463770367-1789196680-1725013093=:16809--

