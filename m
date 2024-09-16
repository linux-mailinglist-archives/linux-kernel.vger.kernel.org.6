Return-Path: <linux-kernel+bounces-330849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8397A530
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DAF28C0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C115956C;
	Mon, 16 Sep 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBfObwEv"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C9149C4D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500072; cv=none; b=PDjoNEW2j5GB0svxBatPqbiOaDaIinnBkO9mkSwGReU3vF0DFgKis5N8VHXSztZnZ6D3GiQuJseYwhsG4BWkbO7toIAdg5B9IZdNupjkWWyeNl7OW2EGpSX25eZt7/QHrZzZ87AAnB1M2rn64JSE0ilvjNt5h6MwsGYWQDMr1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500072; c=relaxed/simple;
	bh=JOpqFyDUOwRzJEm/VhivgKeKpZ15SU0zttR1cvemd5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coZOx5NSo5A8L1smLXlISBiSmS+4ac9O4uq0md9NaPOmJlsFBMHBk9pQFnX/069mw5gWDUTF0BlSjVd/zKHY6p59jl4v7OF32I8RgRJIMPZeYBDowZuV0c6yLu3cloYo3T9HopsayGoH12f32CDvuynRs0SRXfYKgBp7i3Tz3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBfObwEv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so51040401fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726500069; x=1727104869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ElgGpY18GVWl4X9bZv5vQ8vhxO0emOcWoSyqE0DpLTo=;
        b=UBfObwEvnnjWgN//U/uxRAJYoliiIGkHvrHq5HBBx008w64EaxCZO6Sm/KikgflTit
         Nfzbn+di5+qROyxCJ+wYeultnCrGIWzyr0lK17cmz3t8jgK1HarvC06KdAcDsJWhEhJn
         v3ejmhPCGgjPjCkZJNUZGV1aFFhBVsNLfws4t/npAOQtQpuomuWr941GWWD3/IJqEM3k
         7n2ViKtEVtJ/yHndwhISgjPb67Jb+xPhOq06PPmBOoAaQi7iPN+JewFormsTxv7S5Ysz
         jPC+jkFsfnE8KW11/Rkh7nj8/F+I2oV9I7DAQktw+5te/o9HW8SFTaME5+aiAX23lSSh
         bS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726500069; x=1727104869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElgGpY18GVWl4X9bZv5vQ8vhxO0emOcWoSyqE0DpLTo=;
        b=WXMvy5OgcjrS1MOF6z16JEbIDCU9oP59+mwZ1+Mq1zmrVpxFTrvSXCbFESzWb9FhAe
         Bbgql7405359ygyOTbIilqRx9mSXpITeVAs/z2AWyuFLTXuIAovufBpXwy0o4eqaJsD3
         TZPCuKG9pf6vzLJ1KrUd7ey5R8sSSDpvL1fMraT0nZCYXiaN8gQqs6rwPDkVIIpB9AkR
         w2ar5SBybW/C1KMkClNMYax9HiyKp56Dc6y+3r/KqgjFLTOv5yFPmO4j3ZrodQ7meMJu
         w8HtUGOhqn/4NKDYqE7BkPx3S5pA5WNtE768KTu1ieOmT7csA/Sjz/9hE3g6PqvweIah
         jURQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3bcP+RKhQ/RzZFKN9cA1hGqcHQmQDUwoA/RZLWDM0BH4rPB7QLneQnxqBVHM7oW+h4yMamv0YVjVjV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ElwMk6zfvPgdLt8xXg5TEjmG2qZVyuqnL0G/+gV4gqlkQBUy
	lbqa0pzBBkDbS1tdHUyPdq5YMkBOSV/U/A1o3GJYW/JvpKf4c6GBwmfypEbNUSsLsfRdWdm6TNO
	h15/KA5Kem7HhPewh+m6kuNs3mbgL4dxCBqbq9L7mADCkvPMK6l0=
X-Google-Smtp-Source: AGHT+IEtOxse+EgdzvNc2cYaGG0QYGiBpd6nnUpsFGiA3gL+7q0SMkU8KPbjGr8uf7BJjGUM0QILYzAI6Jm57+ZGYeY=
X-Received: by 2002:a2e:4601:0:b0:2f7:acf5:7ddc with SMTP id
 38308e7fff4ca-2f7acf57e25mr13132151fa.26.1726500068301; Mon, 16 Sep 2024
 08:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916083131.2801755-1-s-vadapalli@ti.com>
In-Reply-To: <20240916083131.2801755-1-s-vadapalli@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 16 Sep 2024 09:20:57 -0600
Message-ID: <CANLsYkwTYqfAi+OFg3khMs7VD_PnL=CH-k8HXE71QSdqpR1fvA@mail.gmail.com>
Subject: Re: [RFC PATCH] remoteproc: k3-r5: Fix check performed in k3_r5_rproc_{mbox_callback/kick}
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andersson@kernel.org, b-padhi@ti.com, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	u-kumar1@ti.com, srk@ti.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 02:31, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> Commit f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during
> probe routine") introduced a check in the "k3_r5_rproc_mbox_callback()" and
> "k3_r5_rproc_kick()" callbacks, causing them to exit if the remote core's
> state is "RPROC_DETACHED". However, the "__rproc_attach()" function that is
> responsible for attaching to a remote core, updates the state of the remote
> core to "RPROC_ATTACHED" only after invoking "rproc_start_subdevices()".
>
> The "rproc_start_subdevices()" function triggers the probe of the Virtio
> RPMsg devices associated with the remote core, which require that the
> "k3_r5_rproc_kick()" and "k3_r5_rproc_mbox_callback()" callbacks are
> functional. Hence, drop the check in the callbacks.

Honestly, I am very tempted to just revert f3f11cfe8907 and ea1d6fb5b571.

>
> Fixes: f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during probe routine")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> Hello,
>
> Since the commit being fixed is not yet a part of Mainline Linux, this
> patch is based on linux-next tagged next-20240913.
>
> An alternative to this patch will be a change to the "__rproc_attach()"
> function in the "remoteproc_core.c" driver with
> rproc->state = RPROC_ATTACHED;
> being set after "rproc_attach_device()" is invoked, but __before__
> invoking "rproc_start_subdevices()". Since this change will be performed
> in the common Remoteproc Core, it appeared to me that fixing it in the
> TI remoteproc driver is the correct approach.
>
> The equivalent of this patch for ti_k3_dsp_remoteproc.c might also be
> required, which I shall post if the current patch is acceptable.
>
> Kindly review and share your feedback on this patch.
>
> Regards,
> Siddharth.
>
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 747ee467da88..4894461aa65f 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -194,10 +194,6 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
>         const char *name = kproc->rproc->name;
>         u32 msg = omap_mbox_message(data);
>
> -       /* Do not forward message from a detached core */
> -       if (kproc->rproc->state == RPROC_DETACHED)
> -               return;
> -
>         dev_dbg(dev, "mbox msg: 0x%x\n", msg);
>
>         switch (msg) {
> @@ -233,10 +229,6 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
>         mbox_msg_t msg = (mbox_msg_t)vqid;
>         int ret;
>
> -       /* Do not forward message to a detached core */
> -       if (kproc->rproc->state == RPROC_DETACHED)
> -               return;
> -
>         /* send the index of the triggered virtqueue in the mailbox payload */
>         ret = mbox_send_message(kproc->mbox, (void *)msg);
>         if (ret < 0)
> --
> 2.40.1
>

