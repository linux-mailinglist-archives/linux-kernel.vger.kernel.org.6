Return-Path: <linux-kernel+bounces-253384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A3932054
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3790283BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68181C2A8;
	Tue, 16 Jul 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5SuqLmF"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546F17C64
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721110479; cv=none; b=spf58yUae3cn7HtqfkB0qHpO/lQ/x9LbGL5vSi+UX2TJO2Qf2K9gzchKXCDHUJCagoADJyXk/6GGN3u50cFuVJViKYJmOMcj/YOK4tRmcjCXFUjbxla4x1fJyGsQYLxbvGx+kjHrXWeM+iGsZmM2hhT0dO5RSzWSwj4uIKkpRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721110479; c=relaxed/simple;
	bh=tgvee7XWXH9U3uubhFtApzPNqWlgk4fizsyKlvVWLOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+36opKBbywA8E3CEbLQGbTYBXaq9oGwtHJezwm/kzlvAFJQwFlRPIqYtI7yQkx8V+2d4HlAFH/iAsWhFS4k+23ZABvUNO75Adm2JOKZ0nrxaF2+vcexBRSKBafjKQOWu0HxEtMA4upMEDzjz70Q2/O9vxi3Udl1bDGD0BFkxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5SuqLmF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso7123574e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721110476; x=1721715276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hp32IzbkFzstoqJXLETw7ciCeL12D+J9Ca3PwY99Xc=;
        b=K5SuqLmFvUNsrwlABNyHkGm2I9P7DiVWIqV2WSdp2et+l0BGgEiw4vG456f4hRZx6+
         QzQ8fjV0wFCREo6oCab0VB6JG1mMCkfKM1n5hz0Lt6qU0DExqdst+1xPfeW32HAm8UND
         8JVMdzjMD9hb43vYVPae6oIBxA++W8uVmeVGH2ztRK/OS5v74P9T7KGUPgYgn/kbmNMu
         qWq2vNJfnC01FYbpS81n8NoJJlt/Ryin1bpsJV1JvcueS9yq+lcwb1qR4I61D6rmcIBi
         RglNX/hq9zLtO2AyOvHH39NjDbX0ST6rErmkOQZeDALOf4o5qThts36bp5ERvza9d8iI
         Mh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721110476; x=1721715276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hp32IzbkFzstoqJXLETw7ciCeL12D+J9Ca3PwY99Xc=;
        b=QnxsgrErXNylYTMykHKMKYVmogYiwXyhE75Z90FJecArjhtdZjFHBN6h9AIm2oy2Bb
         j6M4YsgoZeJGvUg9jywXhzr/7gHdHVUfUq24CrmgZLTQxtRDBSQIQ5ZjOyraR2fn2dka
         iQCCHlD861MmO5bviE+zs4V1HBv1tZhSKgLmwJzuIaHZVzGMixsGBi2zuK3a5Y2DQSxw
         CF6ztv6mg4FPkzgXS2P8of2PsUWjrXy3p6eKaSO41bGSZhTK/npelUwqNXpIYQZwA8Bc
         bw/7cIly4UGmcjQbzkOW9JPqwzsfkR7+6OlISOeepOSCbVHp0oa2gVyi1kXzOZnZbXuL
         atLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZD92iwCdOzBSmwRUULBD1eM4Or8HEYmXGAToILlnuiJWJNhpMQQ+BGMDrJG0nEK1iIBY7l6mHY2sJu/E313zQnAth1c0jmthy4/ec
X-Gm-Message-State: AOJu0Yxu//xUq4rEiUyp/4MLgLDFRjrBlxv2WINw/yokbV6Ddi3fW9TY
	QbIyRJsqoXhNUqZkobSvDT0PZovLE07Vr0RnReUAxCNO3FAcI14TaiMC9r8HnF0HVH9yf/xn/wv
	AZ/tqZ6i199ZPlA160aMQkzcz1JgslrWO
X-Google-Smtp-Source: AGHT+IHVkLaBpWdOmqmWX1MjxOwaqCwYYdP7IjrRFHWalMfn5Z88CNTYf8CrIhYyaZTfCn3vZ+LMs5gtphp11Vk8M9E=
X-Received: by 2002:a05:6512:3f06:b0:52c:cb8d:637d with SMTP id
 2adb3069b0e04-52edef0fecbmr859694e87.5.1721110475402; Mon, 15 Jul 2024
 23:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com> <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
In-Reply-To: <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 16 Jul 2024 14:14:24 +0800
Message-ID: <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:50=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/7/16 13:44, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > scheduling while atomic was reported as below where the schedule_timeou=
t
> > comes from too_many_isolated when doing direct_reclaim. Fix this by
> > masking GFP_DIRECT_RECLAIM from gfp.
> >
> > [  175.610416][  T618] BUG: scheduling while atomic: kworker/u16:6/618/=
0x00000000
> > [  175.643480][  T618] CPU: 2 PID: 618 Comm: kworker/u16:6 Tainted: G
> > [  175.645791][  T618] Workqueue: loop20 loop_workfn
> > [  175.646394][  T618] Call trace:
> > [  175.646785][  T618]  dump_backtrace+0xf4/0x140
> > [  175.647345][  T618]  show_stack+0x20/0x2c
> > [  175.647846][  T618]  dump_stack_lvl+0x60/0x84
> > [  175.648394][  T618]  dump_stack+0x18/0x24
> > [  175.648895][  T618]  __schedule_bug+0x64/0x90
> > [  175.649445][  T618]  __schedule+0x680/0x9b8
> > [  175.649970][  T618]  schedule+0x130/0x1b0
> > [  175.650470][  T618]  schedule_timeout+0xac/0x1d0
> > [  175.651050][  T618]  schedule_timeout_uninterruptible+0x24/0x34
> > [  175.651789][  T618]  __alloc_pages_slowpath+0x8dc/0x121c
> > [  175.652455][  T618]  __alloc_pages+0x294/0x2fc
> > [  175.653011][  T618]  erofs_allocpage+0x48/0x58
> > [  175.653572][  T618]  z_erofs_runqueue+0x314/0x8a4
> > [  175.654161][  T618]  z_erofs_readahead+0x258/0x318
> > [  175.654761][  T618]  read_pages+0x88/0x394
> > [  175.655275][  T618]  page_cache_ra_unbounded+0x1cc/0x23c
> > [  175.655939][  T618]  page_cache_ra_order+0x27c/0x33c
> > [  175.656559][  T618]  ondemand_readahead+0x224/0x334
> > [  175.657169][  T618]  page_cache_async_ra+0x60/0x9c
> > [  175.657767][  T618]  filemap_get_pages+0x19c/0x7cc
> > [  175.658367][  T618]  filemap_read+0xf0/0x484
> > [  175.658901][  T618]  generic_file_read_iter+0x4c/0x15c
> > [  175.659543][  T618]  do_iter_read+0x224/0x348
> > [  175.660100][  T618]  vfs_iter_read+0x24/0x38
> > [  175.660635][  T618]  loop_process_work+0x408/0xa68
> > [  175.661236][  T618]  loop_workfn+0x28/0x34
> > [  175.661751][  T618]  process_scheduled_works+0x254/0x4e8
> > [  175.662417][  T618]  worker_thread+0x24c/0x33c
> > [  175.662974][  T618]  kthread+0x110/0x1b8
> > [  175.663465][  T618]  ret_from_fork+0x10/0x20
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> I don't see why it's an atomic context,
> so this patch is incorrect.
Sorry, I should provide more details. page_cache_ra_unbounded() will
call filemap_invalidate_lock_shared(mapping) to ensure the integrity
of page cache during readahead, which will disable preempt.
>
> Thanks,
> Gao Xiang

