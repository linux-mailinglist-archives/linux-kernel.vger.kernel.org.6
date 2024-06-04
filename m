Return-Path: <linux-kernel+bounces-200500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB78FB0E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B901F23141
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27D5146598;
	Tue,  4 Jun 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfGIkt//"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9191459F0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499669; cv=none; b=PktxFUj2eKbJSTxGvMwqutCPeir7UtDkmthN7f9CJTZG6Q0gQWbzF1T+ykcDOBtC7UhXkkSt1COIgBhT/tAhtZ3u2NTlgfA1dEbiAjjB4IZXIeeiTYIoERzH157n05A8Q1xf0EZxUcxTEXaa+SYtamC0WIYlDo27saG+aJPlqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499669; c=relaxed/simple;
	bh=6qU8NUz34GV1hjJEzp3ExuQLSPwoamL8UaQbXLIdRb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY3+EMP/oQUqR8zVfODm6HD/eNkMKpYZWnWT4HIf+PXcsHfiTUhZqmYFID+TzpthHloo418j4StPlEmGCz1gOJOtfs6tKiU5QAH4N8peSsaXZovj7EnLO2DpGhu71I09Lq6dNMw8kljAA0L9oD56/xsvFv01WXzQT+5vlRb3lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfGIkt//; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfa6e0add60so4496093276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499667; x=1718104467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TmpSYFKkdHdpbLlCUq0Y2S1QK2XGt/UYBmUpe+qlZs=;
        b=EfGIkt//1b+PF9r3Rg0dqaV62A5TDsUL6K2UpJrHlN4X2w8xKizwHS7Ho2D9XM+rNQ
         f4JwuksSmruXOjYgO+K/USwaaYBGBlx7fhkH4FxIgj8YSSKEB7cKiE3vIXmY9Qys7Bj0
         rqGuxL+3zu9wAo5XClbb3KvACuxHJ0y0OCUFUyimFkaMZ5Rg+lry8klHeiKuYD5VMOMN
         XLpdmQ5KgN0sF0XQ/uxR8BUg83a7hwF3WddtqtYpMaM2uZ2wdCyMl5Ma0LUsQT9phohH
         S8jUpi+HFxAEm3c3op6qzY01f5pVf3eGzmmoUlHXWctpLhBu8nNPjaKglyQSUP2ZK0J6
         OBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499667; x=1718104467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TmpSYFKkdHdpbLlCUq0Y2S1QK2XGt/UYBmUpe+qlZs=;
        b=a3RXk6tYjOOTvqiBekrsXc34gCe0cR3GjWIetyoeXgQMbnKc3f+2VV7KWeOFJPemHz
         cCWt45vSNKmTR0ayGAICIeQ5A6mECPRA1su+XkCH1tMjXnwfnIgVCHC5VPjLnqJ9DMWI
         3OOLDnY9YNqrn7i1f7Yym1mh479pRoBD0lxPIOITpjUGlo2Y9jY0rM2K2hLHncCQipZM
         Rn5BXniJewkpvXBp/a2b3IvTROz3mlL9Sk+yUR9+4XXqfIdVpHH6J2pqfemdjje1x0Nf
         x3FIlDuVcm5ApacmteBnP8K3baQp3t7yncdFpFHv/+ntSDSr0g913sXu0kkGFCWwb4Yw
         imaw==
X-Gm-Message-State: AOJu0YxRsB7qazJDBBkNd6KH6b2QhensZTkm+4s2nDGYnEy9RvdaPDcI
	CfOAtQ+CnylaEnQWIY1VgGD9kuRP2o7kWFngV2u9zeZVru4GwZm3fKB4gFckJQZFeu6SZ7Mve+P
	jSZ+m0pbKJvu8eA62BmDFLeVwHYFkip7CvSPwQQ==
X-Google-Smtp-Source: AGHT+IFEc6IJEQrXDVOnUX+nM5icwgPnY8PtwP4FyxA6uEvwBDjA1bgyiTf23qGF8/BavlIVa2xHJiSyQsJImhN1Qas=
X-Received: by 2002:a25:86c7:0:b0:dc6:aebb:168e with SMTP id
 3f1490d57ef6-dfa73c2063fmr11060469276.26.1717499666619; Tue, 04 Jun 2024
 04:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603220834.21989-1-kamal.dasu@broadcom.com> <20240603220834.21989-2-kamal.dasu@broadcom.com>
In-Reply-To: <20240603220834.21989-2-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:51 +0200
Message-ID: <CAPDyKFqk4uzSm_ti=66wU22GM8TqeM83aCz6=j9Gr9-sCUuR8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ludovic.barre@st.com, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 00:09, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> When erase/trim/discard completion was converted to mmc_poll_for_busy(),
> optional ->card_busy() host ops support was added as part of
> dd0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard").

I can't find the above commit hash. You probably want "0d84c3e6a5b2"?

> sdhci card->busy() could return busy for long periods to cause
> mmc_do_erase() to block during discard operation as shown below
> during mkfs.f2fs :
>
>     Info: [/dev/mmcblk1p9] Discarding device
>     [   39.597258] sysrq: Show Blocked State
>     [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
>     [   39.610609] Call trace:
>     [   39.613098]  __switch_to+0xd8/0xf4
>     [   39.616582]  __schedule+0x440/0x4f4
>     [   39.620137]  schedule+0x2c/0x48
>     [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
>     [   39.628562]  schedule_hrtimeout_range+0x10/0x18
>     [   39.633169]  usleep_range_state+0x5c/0x90
>     [   39.637253]  __mmc_poll_for_busy+0xec/0x128
>     [   39.641514]  mmc_poll_for_busy+0x48/0x70
>     [   39.645511]  mmc_do_erase+0x1ec/0x210
>     [   39.649237]  mmc_erase+0x1b4/0x1d4
>     [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
>     [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
>     [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
>     [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
>     [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
>     [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
>     [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
>     [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
>     [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
>     [   39.693539]  __submit_bio+0x1c/0x80
>     [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
>     [   39.701875]  submit_bio_noacct+0x1b0/0x22c
>     [   39.706042]  submit_bio+0xac/0xe8
>     [   39.709424]  blk_next_bio+0x4c/0x5c
>     [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
>     [   39.717835]  blkdev_common_ioctl+0x374/0x728
>     [   39.722175]  blkdev_ioctl+0x8c/0x2b0
>     [   39.725816]  vfs_ioctl+0x24/0x40
>     [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
>     [   39.733114]  invoke_syscall+0x68/0xec
>     [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
>     [   39.741609]  do_el0_svc+0x18/0x20
>     [   39.744981]  el0_svc+0x68/0x94
>     [   39.748107]  el0t_64_sync_handler+0x88/0x124
>     [   39.752455]  el0t_64_sync+0x168/0x16c
>
> This problem is obsereved with BLKSECDISCARD ioctl on brcmstb mmc
> controllers. Fix makes mmc_host_ops.card_busy NULL and forces
> MMC_SEND_STATUS and R1_STATUS check in mmc_busy_cb() function.
>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

We probably want a fixes/stable tag for this too, right?

Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for
erase/trim/discard")

I have amended the commit message and applied this for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 9053526fa212..150fb477b7cc 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -24,6 +24,7 @@
>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT           BIT(0)
>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT     BIT(1)
>  #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE     BIT(2)
> +#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY      BIT(4)
>
>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE             BIT(0)
>  #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK          BIT(1)
> @@ -384,6 +385,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> +       if (!(match_priv->flags & BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY))
> +               host->mmc_host_ops.card_busy = NULL;
> +
>         /* Change the base clock frequency if the DT property exists */
>         if (device_property_read_u32(&pdev->dev, "clock-frequency",
>                                      &priv->base_freq_hz) != 0)
> --
> 2.17.1
>

