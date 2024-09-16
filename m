Return-Path: <linux-kernel+bounces-331060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E897A7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF92B20E44
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD64D15B572;
	Mon, 16 Sep 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1KJXYap"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EF2A1B2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515729; cv=none; b=SHLbGuQtKPmdJs9aqKzq82dLrZ83hiEvnpy8K7RtxfoVBez05FZQLj0Ws2jdVoiDvlyuEiRdDn/jpecdw9AdvquJXjS2bacds2YJ+yx9XLIiVeWPxJmYYm+O7TvncvHSS+cqlsxFSqNXYU6CeZMPtV2TgPb4cpb7b342460T4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515729; c=relaxed/simple;
	bh=ftpSgXqNwT/frdUCcuwgQ56Y1+7AabT4qL95AEKZbYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzdfW5GLI+Z1hvKvgsgB5JRWN1ZbwaJ1L5xMj86KMARLU7IRNGxGLap1UYHWzvOiU2jFhFOgULqBVayX3ppz1nNRhyEQpyOuiAJ2UpWOFQ5f5WfTekp6IrR0b53sTru0QVvI9o1hy3f812Am/6IR8pPGfJQTiKk/mTbZJEu6g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1KJXYap; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5012813249cso1135697e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726515727; x=1727120527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Dwuywvpu+376I64Njgm4MhfpcWjXwvY7We0S1xdxA=;
        b=L1KJXYaphI9JUbaOfSUMyNRUkf61H9+etoRheVpRjERObVfmN7pVlYWsN7PxKv6lzp
         k2ZiS94hY6w8opqebaa8h1Gwy5NKMEjdyW/cTk5ydju9UX7HoVyAXl2s14P3a2ruMDEv
         1n/rbFz/BT78t5Ess1rhHKZjand4fBoF0iXVkxKxR1xyPFm/SxejdYA+WDPw3TuFJ/jB
         paSe3CH6uMiNTd8eadfk3LqtoiE08ufw8MjgMBQPyX1czfYk3eHt2eB8bVcbBYhK/rZ2
         K/Aw7R6Ti0x8J3VmsomM62Xh2qHyOJsqRZJf3+QHXNXUXCoVZvxNAslJhGTEbRF5oBw4
         aTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515727; x=1727120527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Dwuywvpu+376I64Njgm4MhfpcWjXwvY7We0S1xdxA=;
        b=FErl/1czozr4ZairWn64OMqTwMtlQ9pNyvdd3x0f85Dx3MUvur6lfIjX8hKTHyePP4
         UDdUmK3b94v6AUPLHDX7zY9IdtKkRpCgB4rf5VxHIsueW64VeF+hOgpgbQjJ5w2kFwBk
         N72LOrJ7ewnoYn43y3sz2rncToseYE8ib/INg+wcQa/SoXyY4kT9zQvcLjdFZhesu5c9
         VuZFt+CBbTJGMVf1G28GNGYgFF6Uf7F5CdHkb0O2kaIN03Hk9gx3UvuVgS0TE8RLcHs8
         jQiFFznexzCEClaK40D6cVon5fvLFEQzKKElBdYXKXvo9FAnQU5OFrMcoFZL1cmrhx0m
         W5VQ==
X-Gm-Message-State: AOJu0YxonNG1aAcc4g1EBbd13fykM60Qx9QfgDTXFPCZCsfFKLvLu5qK
	a0jyhggEGYPNAFkKpjy5yKzPKwf/gCzE1T1IcKqG5tBwR84H8XVs8ixi70RY5BO9SL8RStGsWRZ
	oL4Xogi6TC17Tw5PbSr+xgOgTlm4=
X-Google-Smtp-Source: AGHT+IFbRRZGxTNbY/i7l1nnR/42puJIS9fpYBehSpAyUW8Agf+I7MI6GRpdyiE0Ln84sgKD2fifqTGiuWSJNo7GLXM=
X-Received: by 2002:a05:6122:1306:b0:4f5:254e:e111 with SMTP id
 71dfb90a1353d-5032d40e6a1mr11439114e0c.7.1726515726603; Mon, 16 Sep 2024
 12:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915032251.2300459-1-jaegeuk@kernel.org>
In-Reply-To: <20240915032251.2300459-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 16 Sep 2024 12:41:55 -0700
Message-ID: <CACOAw_zeAYOc9wgD6O5cOLR+Q54aA6=9+-zefTEe71RSaqGoYQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 8:24=E2=80=AFPM Jaegeuk Kim via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> This patch allows f2fs to submit bios of in-place writes on pinned file.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index d18931b7b094..c56e8c873935 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -792,7 +792,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>         if (!strcmp(a->attr.name, "ipu_policy")) {
>                 if (t >=3D BIT(F2FS_IPU_MAX))
>                         return -EINVAL;
> -               if (t && f2fs_lfs_mode(sbi))
> +               /* allow F2FS_IPU_NOCACHE only for IPU in the pinned file=
 */
> +               if (f2fs_lfs_mode(sbi) && (t & ~BIT(F2FS_IPU_NOCACHE)))
>                         return -EINVAL;
>                 SM_I(sbi)->ipu_policy =3D (unsigned int)t;
>                 return count;
> --
> 2.46.0.662.g92d0881bb0-goog
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,


>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

