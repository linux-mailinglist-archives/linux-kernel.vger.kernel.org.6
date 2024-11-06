Return-Path: <linux-kernel+bounces-397610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B49BDE00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E2284EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D618FDAA;
	Wed,  6 Nov 2024 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRQTtY/y"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971176035;
	Wed,  6 Nov 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867742; cv=none; b=MF53vzU+WpBBI5lddWu0QNX7MmYgnrSR/mliW5vREwktr/GDs++W/qlGKiPdbRyGTKypOYjP/vUDuELCRYAwbNmex1s1ga0f4GJXfkLoxxAuhCMtx4PJaJQk25ZkzXmI0OmCEJ6g+MI6T+R5O/Fx87C2b3VeNkCrK8hfKMbyeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867742; c=relaxed/simple;
	bh=5dfm0SPWhXcAII+0HsvLmc+h0UO75X+r9Yx0m2YtUmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsPO7n5M1zmWQG6l7n/oaj6MhWTJWbGdFLYNiodrisgr8dZHRzKRps5gdthu7mYd/+8AMdSqCOqeOm1Li1ubPeStBLWq/S1ULF8J8fx4c8FyLU+x82nykNUL/8WHBNynqMBPRthVYkEPtaFlBwHRbZ4RKCH4eEruutWWa+YWXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRQTtY/y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso3965452f8f.3;
        Tue, 05 Nov 2024 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730867738; x=1731472538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9gICkjbSlKVfMS1+Rdi+NwVWBnNfnUrhqW6K0R9uLs=;
        b=ZRQTtY/ybZyRMn/c4HlyQIt6srvVRMILMHIpzJtYtiBTV7S/HLr4XjnWhnhSbYBpfy
         tqaNtIQjlLq+5oJb9KZThu+djTFKRxfzn/ADgCF4i03UKr1OvymJs75YWRo/GrK733hu
         g/JtPEs3jAUzU3cCx13Jkj8uImCXQarFmuaAij3W5q0VU0GPbLpn3ewMKhpusQqzS63w
         wwidwrB16HZTGuEZZC0l1tYmfPDtrEBfmnwO04ziPytPXGZL42L/U3xa8agz109KX3pQ
         EfbQESO7S1t6Llgd2iaCo4Krf1b94IKWpIc4CeRMZyJdy9C9k8Xs1JbdlMYe/MB6oB4L
         RVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730867738; x=1731472538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9gICkjbSlKVfMS1+Rdi+NwVWBnNfnUrhqW6K0R9uLs=;
        b=kNl8kLIoW8HNkHAMEDo8zyJcwWAeRRelL+GKu9iRtyk2YYGf3ucyfDvzbVEFwOF0Rs
         MS85XT3dKwmsuDmpDOMLcOCoxN+uL4PaTVhCf/t9TlxpgoVBQ9+uMYeOU8j2qcLR8qLn
         QBIhYTOfDEA+zn0UKMUrr9lzfhpK4s8MF/f5pAKF6Su1CgstQRDShkA+ftIVD4FBw7ES
         F6nDnSs7SN5Cn2DmDkybkymLQHAxvHNdPMAJljcZoifm3T/PkVok+KKvlhBgMkLWUBnL
         cuM91BKXZ4CBqqhjDAM3472LNAa27WFbY9omBpG/ao/0iQEyIm3kD/26qudgxsKcLP4X
         mvMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/nA0Zis1+GB9N5nl8RTdDjBAZ3vVXZ0/bqMu5fCR03TQo+rXLKqlhk50iV/hmafAy+Cw92x8tmcSnPWM=@vger.kernel.org, AJvYcCWpHyDEDrIHvcnLMsJprDb2PEAKUBY9iJHcLZaJcpVrqg+yDRXc15MBsyljrMAUX2X50Qq7Q4H5P1D4@vger.kernel.org
X-Gm-Message-State: AOJu0YywOv0b6m/KgRqQ8DOk7nBCwLugGISWmdyzNbDoT+Lvb7gR9gUN
	KwSLq0LLe+skoyFhgtcnmNxIELWqGdYRu3GQcxxVrQAgoEzkrEo9xW9mJda9B1cOdT2Kj1Ezsy/
	UBBcaXpY6YvTwyufIur9e3zA/P+Q=
X-Google-Smtp-Source: AGHT+IGEB5TgtntGjx7fkT8L3NfMQoCdaYwnQ2Bf3+itdlKTY6triKdp5VkSVKwoKojYxfVkd7+rETB6Mqrly4BovPE=
X-Received: by 2002:a5d:448c:0:b0:37d:51f8:46fd with SMTP id
 ffacd0b85a97d-380611279c0mr25344806f8f.22.1730867738565; Tue, 05 Nov 2024
 20:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zyrsg3bvNu1rswqb@gmail.com>
In-Reply-To: <Zyrsg3bvNu1rswqb@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 6 Nov 2024 13:35:27 +0900
Message-ID: <CA+fCnZeThG-J7kCraPbr4NCpys=jne3dD4sOLT_0h6iPw2YZEw@mail.gmail.com>
Subject: Re: [PATCH] usb: raw_gadget: Add debug logs to a troubleshoot a
 double-free bug in raw_release.
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stern@rowland.harvard.edu, skhan@linuxfoundation.org, 
	syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:11=E2=80=AFPM Chang Yu <marcus.yu.56@gmail.com> wr=
ote:
>
> syzkaller reported a double free bug
> (https://syzkaller.appspot.com/bug?extid=3D3e563d99e70973c0755c) in
> raw_release.
>
> From the stack traces it looks like either raw_release was invoked
> twice or there were some between kref_get in raw_ioctl_run and
> kref_put raw_release. But these should not be possible. We need
> more logs to understand the cause.
>
> Make raw_release and raw_ioctl_run report the ref count before
> and after get/put to help debug this.
>
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D3e563d99e70973c0755c
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 112fd18d8c99..ac4e319c743f 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -194,6 +194,8 @@ static struct raw_dev *dev_new(void)
>                 return NULL;
>         /* Matches kref_put() in raw_release(). */
>         kref_init(&dev->count);
> +       dev_dbg(dev->dev, "%s kref count initialized: %d\n",
> +               __func__, kref_read(&dev->count));
>         spin_lock_init(&dev->lock);
>         init_completion(&dev->ep0_done);
>         raw_event_queue_init(&dev->queue);
> @@ -464,13 +466,21 @@ static int raw_release(struct inode *inode, struct =
file *fd)
>                         dev_err(dev->dev,
>                                 "usb_gadget_unregister_driver() failed wi=
th %d\n",
>                                 ret);
> +               dev_dbg(dev->dev, "%s kref count before unregister driver=
 put: %d\n",
> +                               __func__, kref_read(&dev->count));
>                 /* Matches kref_get() in raw_ioctl_run(). */
>                 kref_put(&dev->count, dev_free);
> +               dev_dbg(dev->dev, "%s kref count after unregister driver =
put: %d\n",
> +                               __func__, kref_read(&dev->count));
>         }
>
>  out_put:
> +       dev_dbg(dev->dev, "%s kref count before final put: %d\n",
> +                       __func__, kref_read(&dev->count));
>         /* Matches dev_new() in raw_open(). */
>         kref_put(&dev->count, dev_free);
> +       dev_dbg(dev->dev, "%s kref count after final put: %d\n",
> +                       __func__, kref_read(&dev->count));
>         return ret;
>  }
>
> @@ -603,8 +613,12 @@ static int raw_ioctl_run(struct raw_dev *dev, unsign=
ed long value)
>         }
>         dev->gadget_registered =3D true;
>         dev->state =3D STATE_DEV_RUNNING;
> +       dev_dbg(dev->dev, "%s kref count before get: %d\n",
> +                       __func__, kref_read(&dev->count));
>         /* Matches kref_put() in raw_release(). */
>         kref_get(&dev->count);
> +       dev_dbg(dev->dev, "%s kref count after get: %d\n",
> +                       __func__, kref_read(&dev->count));
>
>  out_unlock:
>         spin_unlock_irqrestore(&dev->lock, flags);
> --
> 2.47.0
>

Hi Chang,

This patch looks very specific to the bug we're trying to debug - I
don't think it makes sense to apply it to the mainline.

What you can do instead is ask syzbot to run the reproducer it has
with this patch applied via the #syz test command.

Thank you!

