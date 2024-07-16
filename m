Return-Path: <linux-kernel+bounces-253396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7261932083
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2450B1C21152
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2C1CAA2;
	Tue, 16 Jul 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt4kytF4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0C224D2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112236; cv=none; b=fpHSrPhbD8y1AqR34qfIJ70sLjbbfrjPpRrKgb2V/wlvx5KYvq2Cp2XjXfeUIbvx7scJs8h2f8PUCcC9eQDZDKjSQScRqqATeAM8bS0DroV/M2oCv+4JSNXdrrPUtR8uHgqDAdaicYj4Ulr2Jf69IJ3CihgbjBzaqx37Grrm7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112236; c=relaxed/simple;
	bh=UelMVD8ODb70ZN/1+uhuv0MkejvN5o6j2xQhL6cSBbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuFuB5C/keJsb3r3S2apyFPFtDu0PPlpDEZsU0H+xxM76DVZcTeUh/T0KLvaFWHB6OuV2Re5OG+fPrCa5UcEvOoehJTR5EqILq73kzTM5wJVH0G8/vviZ7kf/lhj/G9N2mVjPhu0pPZ/BGYyXf30u5Xu5gI2WXDZyd8aH5M3vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt4kytF4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so66118591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721112233; x=1721717033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81jG28CWsfaL3mFq2gzxdqQy1x0CRQo5VzvKgT/IDNs=;
        b=lt4kytF4Z3XYbd5RBze6Den4Nhncc3rOSbgPJD91uHPs1hky/tb49iwfXEjVaLNIZn
         XnblvyYknkQl5rq5Ah3/9yuUQhSpnEvoIBl9fU4J3YL+el/CrWO/RdEtthvLsOqbIRs9
         Tslgi+IOpNiINBH+V2PHOD27ly0XuVwP5leKyHIPIyFg6PAQblkuy7p0knhvU39SSfa3
         KUFUsefgr+kQQg8+gYP9H5DZZo4dVfbYxnNgpQVrfQ4WCcDmcl7wewDGSSC6LynGDEdG
         8eM+/PbzV6XGuBdQUEB1POzu6vIYIAFAFqyRkRIXMoClRGrnxEtTrF9M4bp5hXaRYVrf
         +Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721112233; x=1721717033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81jG28CWsfaL3mFq2gzxdqQy1x0CRQo5VzvKgT/IDNs=;
        b=Ddy/97Qm0xvoBqWFV8LeWHkMSiEVmFEE94uwykcFuwt9YeuUEHOzLv/zqv0Vox2HTe
         nyyGDUmNYpdT2+CswWzyW9vVZfeR9cCCfdhMk5N07ma3/hMX5UI+lUVXOMHUmQUnmHlf
         LA0tsAShcYdIVGdLS5tHzaw70NQCufcuZGcsE71Gsxq+fLQs977s0mnnor8y2BlK1pyj
         UDlIfKt9x8YHDneJDqZyIlnb3FtbHbfqcbQXIrjqzxtauADZEASbJlRUTj487NRVpiFL
         s1KycTDf3ryiXMjz19W+jwMf0mtO5idW8gyj6vrHfpRRhRmuI4btXeI5SPIOO0NkYISC
         FDfw==
X-Forwarded-Encrypted: i=1; AJvYcCXR+83GV7zf7DPu3MbfkgI66lJQH1ErRUy/tz4RHktrnFAEr1DIRiPIhpoHQZZqyPxBWThf/xug5YPi3f2mv2VAjMj7N18NshfnOLzU
X-Gm-Message-State: AOJu0YyUmsho+MvTzLyxN5HNHDpJqbKofWe4ZKbChTRTXCVHgZBRL5Z7
	K6x5XR+Urz0ntVpLGIp87gt2W7adf/SinEs4/Mr9ryUB8NzXWHDK1okiyFXu4XwHo0i5keJjjU/
	Xv5hsJEThtdImppUhLA+4sUEMCpkTaA==
X-Google-Smtp-Source: AGHT+IHqJrxnUJ/XrcDc9iYLmkssnZak8lHjCbqY3rHSFFMHkNoHKHHvOFHq06IO7qmwVSBlPOOOSyDaK9bjKCBpf4E=
X-Received: by 2002:a05:6512:1254:b0:52c:dfa7:53a0 with SMTP id
 2adb3069b0e04-52edf02c1d1mr678856e87.48.1721112232002; Mon, 15 Jul 2024
 23:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com> <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com>
In-Reply-To: <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 16 Jul 2024 14:43:40 +0800
Message-ID: <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:20=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/7/16 14:14, Zhaoyang Huang wrote:
> > On Tue, Jul 16, 2024 at 1:50=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >>
> >>
> >> On 2024/7/16 13:44, zhaoyang.huang wrote:
> >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>
> >>> scheduling while atomic was reported as below where the schedule_time=
out
> >>> comes from too_many_isolated when doing direct_reclaim. Fix this by
> >>> masking GFP_DIRECT_RECLAIM from gfp.
> >>>
> >>> [  175.610416][  T618] BUG: scheduling while atomic: kworker/u16:6/61=
8/0x00000000
> >>> [  175.643480][  T618] CPU: 2 PID: 618 Comm: kworker/u16:6 Tainted: G
> >>> [  175.645791][  T618] Workqueue: loop20 loop_workfn
> >>> [  175.646394][  T618] Call trace:
> >>> [  175.646785][  T618]  dump_backtrace+0xf4/0x140
> >>> [  175.647345][  T618]  show_stack+0x20/0x2c
> >>> [  175.647846][  T618]  dump_stack_lvl+0x60/0x84
> >>> [  175.648394][  T618]  dump_stack+0x18/0x24
> >>> [  175.648895][  T618]  __schedule_bug+0x64/0x90
> >>> [  175.649445][  T618]  __schedule+0x680/0x9b8
> >>> [  175.649970][  T618]  schedule+0x130/0x1b0
> >>> [  175.650470][  T618]  schedule_timeout+0xac/0x1d0
> >>> [  175.651050][  T618]  schedule_timeout_uninterruptible+0x24/0x34
> >>> [  175.651789][  T618]  __alloc_pages_slowpath+0x8dc/0x121c
> >>> [  175.652455][  T618]  __alloc_pages+0x294/0x2fc
> >>> [  175.653011][  T618]  erofs_allocpage+0x48/0x58
> >>> [  175.653572][  T618]  z_erofs_runqueue+0x314/0x8a4
> >>> [  175.654161][  T618]  z_erofs_readahead+0x258/0x318
> >>> [  175.654761][  T618]  read_pages+0x88/0x394
> >>> [  175.655275][  T618]  page_cache_ra_unbounded+0x1cc/0x23c
> >>> [  175.655939][  T618]  page_cache_ra_order+0x27c/0x33c
> >>> [  175.656559][  T618]  ondemand_readahead+0x224/0x334
> >>> [  175.657169][  T618]  page_cache_async_ra+0x60/0x9c
> >>> [  175.657767][  T618]  filemap_get_pages+0x19c/0x7cc
> >>> [  175.658367][  T618]  filemap_read+0xf0/0x484
> >>> [  175.658901][  T618]  generic_file_read_iter+0x4c/0x15c
> >>> [  175.659543][  T618]  do_iter_read+0x224/0x348
> >>> [  175.660100][  T618]  vfs_iter_read+0x24/0x38
> >>> [  175.660635][  T618]  loop_process_work+0x408/0xa68
> >>> [  175.661236][  T618]  loop_workfn+0x28/0x34
> >>> [  175.661751][  T618]  process_scheduled_works+0x254/0x4e8
> >>> [  175.662417][  T618]  worker_thread+0x24c/0x33c
> >>> [  175.662974][  T618]  kthread+0x110/0x1b8
> >>> [  175.663465][  T618]  ret_from_fork+0x10/0x20
> >>>
> >>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>
> >> I don't see why it's an atomic context,
> >> so this patch is incorrect.
> > Sorry, I should provide more details. page_cache_ra_unbounded() will
> > call filemap_invalidate_lock_shared(mapping) to ensure the integrity
> > of page cache during readahead, which will disable preempt.
>
> Why a rwsem sleepable lock disable preemption?
emm, that's the original design of down_read()

> context should be always non-atomic context, which is applied
> to all kernel filesystems.
 AFAICT, filemap_fault/read have added the folios of readahead to page
cache which means the aops->readahead basically just need to map the
block to this folios and then launch the bio. The erofs is a little
bit different to others as it has to alloc_pages for decompression
when doing this.
>
> Thanks,
> Gao Xiang
>
> >>
> >> Thanks,
> >> Gao Xiang

