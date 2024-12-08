Return-Path: <linux-kernel+bounces-436517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801469E8703
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF22281511
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43554161321;
	Sun,  8 Dec 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab+Vwb+E"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2D145324
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678477; cv=none; b=rDnh1IQINKEkFNJ0n5+Uw8BrsTUXRPx5atqz3UeOPtp7jgNuQ7iE84WCQTZvlYHaSm68sqiLB4zMTlf19UfsxuOft/WNN6BIiVcLQaTwuF4wTsEZ4MZkub7dIfniR9JFanY+2nxiUA+nqrqHdMmXMBp0t+BzJ/tGmsacTkUajnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678477; c=relaxed/simple;
	bh=KC2J+w0iBj8OcuinmQpzfXEGOHSOWYkW34S836kDE4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrjUe51/X8VqH/zOt9wmOkD/sxnRJVcJf7bnokZ1qbUeWVenJ8E351BMiBcW7Leb8eqmPSVXRLE/f1lVdF08Fd7OVfVJ38h8U0aQZ0bsKpB/uIyBoOu8/1m/PR6BuHoXMivc6GsP5x+ADqRMzRDXSLpqGSFBCBby+bxFrz5RG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab+Vwb+E; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c4e74e2baso560713241.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733678475; x=1734283275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1KyqoBFomxOl77+ZU6CgcKwfPXNaWogS1j6njglFyc=;
        b=Ab+Vwb+EnvIMyYxdrOXiEWj9Y8pDACnTBVGnT2dy0CzYlgdzyT8so602w8O4cbltsa
         KCIOmPH01OTKHsurDFDRwVbRIbOBBgc86ZMMRmueTC9MYoOYQYY1F2Bv8ziWJoJ/mICE
         QP87tQdIULPz6dUCJ0187OoZgytG6NlV5zTWLjmiAewvCpe2blZMNADmppp3DUrPGj/l
         +p3HV60JEa7KJ2DfQDwBPN/9LIJrK22wxSt8RUnt56/PbvSkzktc0isEzxgLQtgmJTxE
         HS9Su9f7PWI7Ll0WllwPMS11ue/W7WO6OEU1Mm6jAFUSHSFjTNzKHiaMNN3EO8R6hJhW
         rJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733678475; x=1734283275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1KyqoBFomxOl77+ZU6CgcKwfPXNaWogS1j6njglFyc=;
        b=LcxU4eANpgIqCXp1g7jYVAnIL1d4BEMbxUxfSfsE5Om641vHTnsI42osnWrAhVTOQF
         0pDt713jNjFTHfR8JaGAoJ4IDBKzJIqwuNKgW6Pg/RHFPLnfZnGQ+HSaEXwqTw3/0LJy
         NGBvVDk22FkCSwLcHFPHWaLsBLmBaTonHg9UkVoXhjE5JqPDTygFV/rurvAIFYxH1Dnq
         JVm88iJcQUHuSNq7zWb0XJiR8JS6M1hhxdA1TYhZoF3kQ10Lzvb7jQ1/DzBnNwsqyeQB
         KKXwiM/sTA+DgOwDEi1/B5rne/NUzCkDyswNOm61pPnPvkD1Yry9zqW7kvWn6gCfchgY
         lbCA==
X-Forwarded-Encrypted: i=1; AJvYcCURKSs5mpN8Oxo7EUzEy8IwqyZn07wGJGRxkna9/ye78IhZ70sYG4/6ftyi64a+34XEkobCR2B7VNE9vwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNWTLsvswAuSvkTsZSh2GPS5zo4OAOiV1o315Np/vdumok3ui
	UGPtWq1KltWE06zqmmLKiA82PDXWACgkeu5uKoDWVDnqul/xmkvjSuo5E82PT9PjP+Tl7tFy36D
	V3wEduUWwgisnMOpyUsg90KbxZZQ=
X-Gm-Gg: ASbGncuZtWcp8JK5Q03jTuSe0BYwiAogb8seqGgISRoRi5zpZ4qNl3WgbDinScBjIPS
	CzZZ/qbEnKLgBg1FLUfesjqnkh1E+SGY=
X-Google-Smtp-Source: AGHT+IENR3UDThiIkJ+SdvhzuoTwx351q+c6wziFhMmU0b7Us4aOGgMoAOxhZzKj+op8m8ZuFO7bymg3EaHJn4nQtH0=
X-Received: by 2002:a05:6122:4690:b0:518:773b:39f with SMTP id
 71dfb90a1353d-518773b0536mr874128e0c.4.1733678474919; Sun, 08 Dec 2024
 09:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208085121.53415-1-dennis.lamerice@gmail.com>
In-Reply-To: <20241208085121.53415-1-dennis.lamerice@gmail.com>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Sun, 8 Dec 2024 12:21:04 -0500
Message-ID: <CAGZfcdneGPsAwUZmC6Wv7BWSaQw2rkjDby9nhZFweYOgXvNDbw@mail.gmail.com>
Subject: Re: [[PATCH] MTD: fix slab-use-after-free due to dangling pointer in
 notifier chain] MTD: fix slab-use-after-free due to dangling pointer in
 notifier chain
To: richard@nod.at, chengzhihao1@huawei.com, miquel.raynal@bootlin.com, 
	vigneshr@ti.com
Cc: syzkaller-bugs@googlegroups.com, 
	syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 3:51=E2=80=AFAM Dennis Lam <dennis.lamerice@gmail.co=
m> wrote:
>
> When attaching MTDs, a reboot notifier is added to the blocking
> notification chain. However, when detaching a MTD and freeing its
> related objects, the notifier is never unregistered from the
> notification chain. Thus, when the chain is iterated there is a
> possibility of finding the address of the reboot notifier which has
> already been freed, resulting in a slab-use-after-free error.
>
> To fix this, I added an unregister notifier function in the ubi_wl_close
> function to ensure that the notifier is removed from the chain after the
> device has been detached.
>
> Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67409091.050a0220.363a1b.013d.GAE@goo=
gle.com/T/
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  drivers/mtd/ubi/wl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 4f6f339d8fb8..31a1e5515d98 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1995,6 +1995,7 @@ static void protection_queue_destroy(struct ubi_dev=
ice *ubi)
>  void ubi_wl_close(struct ubi_device *ubi)
>  {
>         dbg_wl("close the WL sub-system");
> +       unregister_reboot_notifier(&ubi->wl_reboot_notifier);
>         ubi_fastmap_close(ubi);
>         shutdown_work(ubi);
>         protection_queue_destroy(ubi);
> --
> 2.47.0
>

My apologies everyone, please ignore this email. My mailing script
seems to have changed my email header and commit message. I will send
another better formatted email later.

