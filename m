Return-Path: <linux-kernel+bounces-541808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A94A4C1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDCA16F63E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E6211710;
	Mon,  3 Mar 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvovLgDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6520D4E9;
	Mon,  3 Mar 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008538; cv=none; b=lACIjILmPK4ltEX3S075WZVSbQKTrawnSDDQ/n4YSbqiTb0dPVjFtFzNhOZhugZqpmzfjSeYqwMh7nk3B7g6+qmqimHgAhPO9n8L+XRnO3gBtxjgypaUyvVfHhM3stdKsTjbtF0fraA1H0cvOSxx7DG2KI/bu4ekEde6c20b/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008538; c=relaxed/simple;
	bh=pU75ZWR55ytSqTfFyBXoZ15CdXjjZybmf3hZAq7hNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYFbzmjhJQorDYQHPrWJQFT2i9XyqLQJq3Ebggy726LWg0c2G+gBimdUskbhQmjkwfRTxvn9CJgTmfRRCtpVonNPjFFjSzrOFYOBrpKqMluNt3JxASKhlxizfia5xQA8G81m9Asp+47yc6zlY8Kdj0hXIM/ihpz9k5Bkc8tgsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvovLgDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3CBC4CEE9;
	Mon,  3 Mar 2025 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741008536;
	bh=pU75ZWR55ytSqTfFyBXoZ15CdXjjZybmf3hZAq7hNZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fvovLgDuT8SSv3WCPvLaVtJ0pBNwyRk6mFp31yKWnf+m8GRu7OhSOpELYlOpzrLNN
	 sqdAotELtlVNYxz7k6QnZtcBAlyXprLJPPsSicGaETkDSeNYREsV4LGPuE+zQwUzJU
	 vJeo0lTRXJn33MqW9GSE1LA10t2CBcSeWWF/JJxdzVejirlmdmXYvnfYsJ3fudmtQ9
	 7K9jdg92q+5e6jsT3P3a5357wIHHlB6QY+ZKso/Q1+ndSWBnoPz83uRD/qG8ERufGH
	 tPdnoGpo5d5sWXgFI4mByp/QiN7oufWU1SvpUPzn8zcBQhD/Ssc50B2bSIWu3/5php
	 wpKCziGZrfnaw==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so1544616a91.1;
        Mon, 03 Mar 2025 05:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/eoIwD3AV0Au9x9/jvyRF2bi5goMQB1iXQYsfZmhYGX80JyTmYYMPRRjr0zUtCv8bBukEpNmpofLRjngcQw8=@vger.kernel.org, AJvYcCXfXOGJ3Dpo6WLE7ZuT95Gwrkqo3G0uYnEgofjJHM1mUgZ+wNLId4m6UiExepu1xKkXvmFX4TJHFyIUDmeX@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUty2VSDjPBpoR6zyi4mUIgUo+Ohx9MQ5Iiwa09HxxtJP85EX
	7o05HiXumopNeuYMcww8qfOxcyjTYyQKqAMmk7gGwTy+sNUbDpFGrTmK6xwfSRmZ4DQN08OnCOi
	vmdUFEEE5fcG7amDvgRZaBP1+bA==
X-Google-Smtp-Source: AGHT+IHEdNW1OchHMbLS1cCfwrEs+3MwI78VEpSMNYRCH8bFSj4YHOZdW6AmaLLo8nvW04MvVqNc2fV4NRzXAOPbwh8=
X-Received: by 2002:a17:90b:3d4e:b0:2fe:b9a2:fd3b with SMTP id
 98e67ed59e1d1-2febabf8336mr20713936a91.30.1741008536294; Mon, 03 Mar 2025
 05:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b754a408-4f39-4e37-b52d-7706c132e27f@stanley.mountain>
In-Reply-To: <b754a408-4f39-4e37-b52d-7706c132e27f@stanley.mountain>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 21:29:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY__KF=9Pp=3PAnXG5WCPX4Hxkfd391eBu0dfhO-wz9dWqw@mail.gmail.com>
X-Gm-Features: AQ5f1JoEyaQUFZqrdcQEIsbOBWMKKKZ_mrsKmQyi0xWBpqur_M_EISNLxHKjU88
Message-ID: <CAAOTY__KF=9Pp=3PAnXG5WCPX4Hxkfd391eBu0dfhO-wz9dWqw@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: fix error codes in mtk_dsi_host_transfer()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Julien STEPHAN <jstephan@baylibre.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Dan:

Dan Carpenter <dan.carpenter@linaro.org> =E6=96=BC 2025=E5=B9=B41=E6=9C=888=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> There is a type bug because the return statement:
>
>         return ret < 0 ? ret : recv_cnt;
>
> The issue is that ret is an int, recv_cnt is a u32 and the function
> returns ssize_t, which is a signed long.  The way that the type promotion
> works is that the negative error codes are first cast to u32 and then
> to signed long.  The error codes end up being positive instead of
> negative and the callers treat them as success.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 81cc7e51c4f1 ("drm/mediatek: Allow commands to be sent during vide=
o mode")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202412210801.iADw0oIH-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
> I sent this patch earlier:
> https://lore.kernel.org/all/Y%2FyBC4yxTs+Po0TG@kili/
> but it wasn't applied.  I've changed the commit message a bit and added
> new tags.
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index d871b1dba083..0acfda47f002 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1015,12 +1015,12 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_=
dsi_host *host,
>                                      const struct mipi_dsi_msg *msg)
>  {
>         struct mtk_dsi *dsi =3D host_to_dsi(host);
> -       u32 recv_cnt, i;
> +       ssize_t recv_cnt;
>         u8 read_data[16];
>         void *src_addr;
>         u8 irq_flag =3D CMD_DONE_INT_FLAG;
>         u32 dsi_mode;
> -       int ret;
> +       int ret, i;
>
>         dsi_mode =3D readl(dsi->regs + DSI_MODE_CTRL);
>         if (dsi_mode & MODE) {
> @@ -1069,7 +1069,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>         if (recv_cnt)
>                 memcpy(msg->rx_buf, src_addr, recv_cnt);
>
> -       DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
> +       DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
>                  recv_cnt, *((u8 *)(msg->tx_buf)));
>
>  restore_dsi_mode:
> --
> 2.45.2
>

