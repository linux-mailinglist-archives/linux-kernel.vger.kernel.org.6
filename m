Return-Path: <linux-kernel+bounces-229915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7019175F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC6D1F22F87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F441B806;
	Wed, 26 Jun 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO2Z5TNH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41928947E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367327; cv=none; b=QaNZth/vuOeEZmp0Jfw3Fnu9e6vGTYevS11XPR4fcqPc+pplf+VWKFFbdSOYPpOd0ziU//m26BgDh8yAK7B6ysXaEuI1rAEQFAANpwchfXKbSJd0GcL5RTEbZZ1/ki9Njqs9GIwQmg5QvW+jSGL8zvAl96X2PpksURPpU4KoZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367327; c=relaxed/simple;
	bh=D6dRbojHwOB90aNJgUPTQWtYJDx5XfGJu58jRfCR0kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJZx+yXXRPwryXExe8pesUgEHYQkklHKYkUQszyNMu6jVu0IcF6J0Jo7I/+raX8ZjerH/l2WwNMDI+3LQnv7sFAYxSZdhTvj6qfjrjhN4b07/0he5WOsM+Yjq7kts+gBtnKX5f/vxQhti28+vMBRhW5MUGFh1zJpMJdNzGq0LfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO2Z5TNH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-361785bfa71so4744835f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719367324; x=1719972124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j827eyPfovm1pttAYGkAs9K2vKAWkyr0R4XxYEpN49k=;
        b=SO2Z5TNHrAOjw3tFzjv7rIwV0tP5Y/M/Rr3M57O+WVtY2QKZsdP4uHolF5Voab8Nef
         8E7W5MigYO0y1TDBfJcs043SjKtymrQutdkk+fgD/kk8uDqxwQteQTkFk/fYzvuqU6l8
         jdz1OZ6oHq+fxvmWMeNGaiRGjYpTnKcC8WAL0vZitBxscdRfYM/QSg0tUNPD5ysC6/lB
         MwH5v+EC9DBwLkfwhKcgm46MEGs8ikADfihfkGwL5OaCusZuUL/9SN9aPFsGh+m2J1wv
         Pbh+olYdBvl55rgLX7mJPq1XwN2NAQzNMtY8Tg4UjvGY9toC48RVOhv5zFKSs5c6o2Tt
         TDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367324; x=1719972124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j827eyPfovm1pttAYGkAs9K2vKAWkyr0R4XxYEpN49k=;
        b=G5kO6/hBrNjEVtOmouRu/QDjPqqo1kglq1y/DfGKOdJKhCLu0Dmng+5S/uQKVjF4KV
         CApcy/AhFrYiUcAyq/U2N29w0iZdLrb74Dyvk4LmEk7SMQMD8GCDTUTlKpeITmKPlDXf
         f1Js4syOtl8n7THloofwnCuuDoYCi9jyi4dqHLjIgtR/QpsX/C2DbbbcBZHkpdd21TPq
         fVlRjjLyyBjrMyx6hLsyYziAG4vgA6LO+nXzsb9FvAcCisTRBzPd1RIEf4nUzees/t7k
         1cmb6t0B3aoPPVNkLH/8nTL04c7/DMlZUkgYUAXOzHMcowJ0OsGwoXdqA2ohJJV7mo8B
         prYA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TD6BF8+tAIzr2BsOnUrBc6QCcIVz9mLgDWM4S/0rZ1i+MLJXJ6PVPWS9MELhVBwfkK8v1R/Hk/Q1coBOXmk5Rkdmn5BLYR87j0PE
X-Gm-Message-State: AOJu0YwdThHj29QRLme+oWrAX1NR2zawyRwdzyHREw65QrD/tZnWLS3m
	PF3MBx8feHhvgFriBE4mt1KUfySldWkXdByN5xHIHasLqMWNyEwu8v/A7YLjH9/DK7L595cUqkx
	TH7mMyTX2Cm6GoWXH3BfNB63UiEc=
X-Google-Smtp-Source: AGHT+IGwrr2Re6QtzgDShGiOpHkoGQZgADb65PV0KxFMYpZIY4JGPzwGSV50AioRPApDEtm5jaEVBV1HipBAgflUfmg=
X-Received: by 2002:a05:6000:a83:b0:365:e76b:e908 with SMTP id
 ffacd0b85a97d-366e79fe983mr6147040f8f.24.1719367324358; Tue, 25 Jun 2024
 19:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625142512.3916063-1-chao@kernel.org>
In-Reply-To: <20240625142512.3916063-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 26 Jun 2024 10:01:53 +0800
Message-ID: <CAHJ8P3+VUozoMVHvMxqDrDRVttRWDJ5a4A2ysJv2_O4ytfq8OA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid racing in between read
 and OPU dio write
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=
=A8=E4=BA=8C 22:29=E5=86=99=E9=81=93=EF=BC=9A
>
> If lfs mode is on, buffered read may race w/ OPU dio write as below,
> it may cause buffered read hits unwritten data unexpectly, and for
> dio read, the race condition exists as well.
>
> Thread A                        Thread B
> - f2fs_file_write_iter
>  - f2fs_dio_write_iter
>   - __iomap_dio_rw
>    - f2fs_iomap_begin
>     - f2fs_map_blocks
>      - __allocate_data_block
>       - allocated blkaddr #x
>        - iomap_dio_submit_bio
>                                 - f2fs_file_read_iter
>                                  - filemap_read
>                                   - f2fs_read_data_folio
>                                    - f2fs_mpage_readpages
>                                     - f2fs_map_blocks
>                                      : get blkaddr #x
>                                     - f2fs_submit_read_bio
>                                 IRQ
>                                 - f2fs_read_end_io
>                                  : read IO on blkaddr #x complete
> IRQ
> - iomap_dio_bio_end_io
>  : direct write IO on blkaddr #x complete
>
> In LFS mode, if there is inflight dio, let's force read to buffered
> IO, this policy won't cover all race cases, however it is a tradeoff
> which avoids abusing lock around IO paths.
>
> Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS m=
ode")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 278573974db4..866f1a34e92b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -882,6 +882,10 @@ static bool f2fs_force_buffered_io(struct inode *ino=
de, int rw)
>                 return true;
>         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
>                 return true;
> +       /* In LFS mode, if there is inflight dio, force read to buffered =
IO */
> +       if (rw =3D=3D READ && f2fs_lfs_mode(sbi) &&
> +                       atomic_read(&inode->i_dio_count))
> +               return false;
Hi Chao,
A little doubt:)=EF=BC=8Cforce =E2=80=9Cbuffered IO=E2=80=9D should return =
"true"?
another want to confirm is, "thread B" in commit msg just doing buffer
read, so this modification just cover direct read case=EF=BC=9F
thanks=EF=BC=81
>
>         return false;
>  }
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

