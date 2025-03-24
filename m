Return-Path: <linux-kernel+bounces-574176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8674A6E188
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2311B1894C95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A797266B5F;
	Mon, 24 Mar 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irr45Fvy"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660E264639
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837920; cv=none; b=sSF3AhBH1Kv6pimmQqUYyN6bDoyEW8L+RUIMktFmf/KdrWsDB2ORpmDZPmXvOlBGsrjJA2l5RVciY8p+1mS1DEGshh80Dzy1eNJqAoh1Xv5SgQxFGKNM85HxrJyb9TisDiRBq2VvNG6iwRQh96b8SgU6pUosvbKV78xVv0Kc870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837920; c=relaxed/simple;
	bh=v5h5hiQha3m/RqwmA3YyK/NpC9rPwVl1Kh2SFXwnC6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZfEV1R8YO+MiYGA75ODs8yo/9a7QtWMUsgA0Xs0icAFOE2s4/FCN6HukncCjxl/Cd/wnpAxCiIRmVF7kK+Wyp3aklEwSj2VKrZop/ovYdH1aFfvfoDgQCxj7jjSk0kn91o2bxl8m+2nQpzrbxWlRj7r90LwzAKmJYL/pujknrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irr45Fvy; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523d8c024dfso1888259e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742837918; x=1743442718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhHc3L6BTQyQ2VV8zBOxramxCIeT2sQL+pcCAxhBKHI=;
        b=Irr45Fvyrz7F8smkTUqloT3w+oY3b269FZJLZFUrMDsV1lmD43CNIR98NI4BgY3+hX
         Lk39DkvVtr4T/V1RXMeJN5I1FmuS+Ft0wAdH8xuIHpSIx0YdSBn0cNM5VQUoX4IaU99f
         YTqs1iKkWok8ZCslOc/WmOqP1niOuY0EuYSFQXCSlMWjVWON+qrRUAvls1Mp85RZBKIj
         OVl6Iew8BCJ/iUhQr+94XbikERZYYkJHIvw1Q0N9rshI0mE12FznlTj29qIQt48ZIkNo
         I9wo0rxiY3P4pocERCFDL8Equq6IkRvjoQCiREtwK4a3FG36RyHFLqx/VxLF/F/iG1Bu
         l9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837918; x=1743442718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhHc3L6BTQyQ2VV8zBOxramxCIeT2sQL+pcCAxhBKHI=;
        b=lfa2Y+lBbNw7t1nN2nOgHmGr8eRb9Gh5czNqa8azWENPX7eKMtdz+fjaxd+ASDjLFA
         8/lPr08pRcN+kD8q0HYpqeTNYef8T7dIfHPENYvFc/f5VOxakQyS7+8qBIO1FiM2MEbc
         dMT/7TeK7q+V35q+AphGZd2ep3KWYCKn12fF5Cv+UPNln0FWdMkv9mmxvSPryA68XxwL
         Pnx+Vq8HMbqr8XYWr8aM/8rDGqou3FK6qcEHcA//LQuKd0twSjrK1EMBPPhzs8sTUt1N
         7nzPddsQOzuMySSqc6b0u9MWDInwaehac2v7utD5VzFBq824G2n/nkuuGI1Bi5CALOMh
         8Zhw==
X-Forwarded-Encrypted: i=1; AJvYcCXL9wWiFbRRAEOcJ/nhk9zAK60Jj+tqWuZ6bVx2C0JH3BdCnDKau8rTE2WuypMvGNSMM7CRO8GWhClJ6qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJyexwVzmC35LIq3g1A2O9N+meEz8eJ1WecpfRqnoYglVNqKK
	roeIuVMvBhEe+WSe3+noRBz7ArggHug2RX2YNurjII7ehcHhmo8Dv2J2qTfLm4jtCnPxrJJpFFD
	18nYrDlU3eMqlcDLlFi2CfeYJRvM=
X-Gm-Gg: ASbGnctpePMdSQ4Cryt6IBtt4hXzjT6OKAEDOIUbvaXaVq7KbTIbJvzkLMUMI5+ipOc
	o93KbekeI0yqih0uoIQ8yHu+zMjOgy9AuukOjutiBhOGQhqt/ci/9aewnO1IZxJsTivgLzbvpd1
	hq7fYBVycNgBpe6JfUuPN/vX8ecTlW+kg66GG6zLQk0u0GQsumXJsYbuzqRgkC4ZzRY59zxg==
X-Google-Smtp-Source: AGHT+IEzxJQSAwtY4T5y4jVtK83eFLd4Wpa9U8MybWVatoj3vVUzUPCTJomxtapoBqMT2APoYvOPmk+h07WOWhzl2TU=
X-Received: by 2002:a05:6122:1994:b0:523:c4df:4de3 with SMTP id
 71dfb90a1353d-525a8379e19mr9547011e0c.5.1742837917941; Mon, 24 Mar 2025
 10:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324114935.3087821-1-chao@kernel.org> <20250324114935.3087821-2-chao@kernel.org>
In-Reply-To: <20250324114935.3087821-2-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 24 Mar 2025 10:38:26 -0700
X-Gm-Features: AQ5f1JruqPU0fNSM3E1FCT6wTPSl17PyFmYvi_g6RwuDXRhVN5gDldsd8Gr8BaA
Message-ID: <CACOAw_y8o88oL5vy=YYsN0A8tTOkP0p5qBdqivo_bUWrHGODXg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: zone: fix to avoid inconsistence in
 between SIT and SSA
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:54=E2=80=AFAM Chao Yu via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> w/ below testcase, it will cause inconsistence in between SIT and SSA.
>
> create_null_blk 512 2 1024 1024
> mkfs.f2fs -m /dev/nullb0
> mount /dev/nullb0 /mnt/f2fs/
> touch /mnt/f2fs/file
> f2fs_io pinfile set /mnt/f2fs/file
> fallocate -l 4GiB /mnt/f2fs/file
>
> F2FS-fs (nullb0): Inconsistent segment (0) type [1, 0] in SSA and SIT
> CPU: 5 UID: 0 PID: 2398 Comm: fallocate Tainted: G           O       6.13=
.0-rc1 #84
> Tainted: [O]=3DOOT_MODULE
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/=
2006
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xb3/0xd0
>  dump_stack+0x14/0x20
>  f2fs_handle_critical_error+0x18c/0x220 [f2fs]
>  f2fs_stop_checkpoint+0x38/0x50 [f2fs]
>  do_garbage_collect+0x674/0x6e0 [f2fs]
>  f2fs_gc_range+0x12b/0x230 [f2fs]
>  f2fs_allocate_pinning_section+0x5c/0x150 [f2fs]
>  f2fs_expand_inode_data+0x1cc/0x3c0 [f2fs]
>  f2fs_fallocate+0x3c3/0x410 [f2fs]
>  vfs_fallocate+0x15f/0x4b0
>  __x64_sys_fallocate+0x4a/0x80
>  x64_sys_call+0x15e8/0x1b80
>  do_syscall_64+0x68/0x130
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f9dba5197ca
> F2FS-fs (nullb0): Stopped filesystem due to reason: 4
>
> The reason is f2fs_gc_range() may try to migrate block in curseg, however=
,
> its SSA block is not uptodate due to the last summary block data in still
> in cache of curseg.
>
> In this patch, we add a condition in f2fs_gc_range() to check whether
> section is opened or not, and skip block migration for opened section.
>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 2b8f9239bede..8b5a55b72264 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2066,6 +2066,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>                         .iroot =3D RADIX_TREE_INIT(gc_list.iroot, GFP_NOF=
S),
>                 };
>
> +               if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
> +                       continue;
> +
>                 do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, fal=
se);
>                 put_gc_inode(&gc_list);
>
> --
> 2.48.1
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks.

>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

