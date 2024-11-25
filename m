Return-Path: <linux-kernel+bounces-421041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E79D85FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063371698C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D31A9B43;
	Mon, 25 Nov 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqcbqpLw"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF09567D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540149; cv=none; b=YGwfoklaBDUVBRQKuNiWTxKV9Ugz7Fz+zn/k4Lrk9ilM5C5d3S2tjvkuK53t3W3CWiB4rp2rbiWzYKat7/01wevuAC22vmUeHJpjvYW3zoRZ/EWTXJlYYrPSqgMJSO+95cZkBDfxBxwWJMoOvIyUF3rPMqX8FhHA4ZxnRK79Yus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540149; c=relaxed/simple;
	bh=VlPn8ENRAtequbTvdk1TY+7P5PTASYER46wU/7kPzKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyGjUrOV6Cuf8QUSELQA2SdYhfHMsPeOhRwWsCFBn7/j3cb2Q3XZjGlOTQle11eyTalAhfU1Qj3fDLu8qmu75Gr0NB4KRT1YJqSSHCpjo20LdfdJMyDEqI1uw46RFVbVCBIkCXigEcab8HEC09f6er3Al/ctbHO2GLehv6sZg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EqcbqpLw; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3892396200so3693157276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732540146; x=1733144946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwW5X2yVuOQxgzZYA2AkwTQIodjDxTG3chKlKalzE/A=;
        b=EqcbqpLwoxKMdg9dCgMUc8if2wpoRREZwezWgSX424dpyTAuifXFOGCqFUpWkPYMMv
         2SzCj2LVED/AKyCa2xAoN4XTgCdAUdTmN2LvS3H2GuOKFJ4dso4adwFlBCbPRuWXQFM1
         R5/cToYuDcJwP0LwBwrGAQY6xcCZXuTlTsGl6xI3ObcxT8lO3tHZOepMBpCbr4DXeIzo
         AgeTB28b3iHHd07u3X87VCsbD7WUosOxlxH8cTgjTpy89xxlq0GJkr3JcvX4B36DIaTx
         /qobglp7mi7HQgm2uoRef+o87vQK+9SFREGC8CavF6HWhwz/fWOjf/+wTQ69LDKziLLw
         /M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540146; x=1733144946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwW5X2yVuOQxgzZYA2AkwTQIodjDxTG3chKlKalzE/A=;
        b=PPfN4S220GoMxMIYA3QFhmAuxMRdBTci/Uw0ZhPC0SWPZMHe5qYFrM1Wa24ZYNZzh6
         eMTfvPtzEFmn/qLe8Wu2W/Mt3oiZKxPpJ25xPv2ClhKug58iHkyG5EvHmbSD8qdUg0HK
         V1yQubGQV6E0W2Zs4vDfQztnFbr3gB0qRflIqzcp41Skh8kzCW31Q7siHa3XadwARRY5
         ppqJ1FsOxhc1qPegK8S8aO2+3RyESI/4bZSAUBQLmxRJ6DYLLLN9dO0aT+UMbDTHwVnp
         xMWdVU3APJ1hrjlssm0+ZCZdhqgBKESV33c4JJw7iVWewNF+Mw217GSvxy+lxTQPME3P
         6iPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAOa4BYToes9RxQ9ZQD82pq45v6K7JuswFZl8EG46FE9eFwO3/EhOGD7GTR34T4kasjt2pDcaiTo7f4VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aPyw3YaD4LKwLG9UelzaUyisdxs3/dKrI2QSjlpagyikVWHu
	lEDpXz2COVKi+C8SuUFPCTiHQ4wKiRVOrG+MY+gQ4IhW8XZh7eG6zdHdJ+qh1W3lNeCsc01h7gl
	mwXAVlwIk7s/OhQIwqZXsbAqgPhAxPm8azEIIOA==
X-Gm-Gg: ASbGncvKhoCJswZ30ovUllUiZA7TY4V+qR+8lSG2nYDEsnio3d1orLyx3HcufAqyVJe
	h8VUkhTwBBoyORjeYuCJ14ZJUQI41MoH0
X-Google-Smtp-Source: AGHT+IEF6uaB71EPxvIZeVbVSPO+NaBbT0xZwtt8FC3so2FjgVG6CW+VGCBir21UFRKHNtvL6RUoiWhliSlp9tWY5cM=
X-Received: by 2002:a05:6902:1106:b0:e2b:cf75:2840 with SMTP id
 3f1490d57ef6-e38f8b0aad8mr10473196276.5.1732540144455; Mon, 25 Nov 2024
 05:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Nov 2024 14:08:28 +0100
Message-ID: <CAPDyKFpr9KZxx4_-jW8ovqcr4BCfDcm4teHEVOgZ69GrUddJ2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 08:10, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> The current process flow does not handle MMC requests that are indicated
> to ignore the command response CRC. For instance, cmd12 and cmd48 from
> mmc_cqe_recovery() are marked to ignore CRC, but they are not matched to
> the appropriate response type in msdc_cmd_find_resp(). As a result, they
> are defaulted to 'MMC_RSP_NONE', which means no response is expected.
>
> This commit adds a new flag 'MMC_RSP_R1B_NO_CRC' to work alongside the
> existing 'MMC_RSP_R1_NO_CRC' for the following process flow. It fixes the
> response type setting in msdc_cmd_find_resp() and adds the logic to ignore
> CRC in msdc_cmd_done().

In fact, MMC_RSP_R1_NO_CRC is not being used by the MMC core. So, host
drivers that check this flag shouldn't need to. In other words, we
should remove that flag entirely.

That said, introducing MMC_RSP_R1B_NO_CRC as the $subject patch
suggests, makes sense to me. However, I prefer if we can make it used
by the mmc core, so please change mmc_cqe_recovery() to use it too.

Kind regards
Uffe

>
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 11 +++++++++--
>  include/linux/mmc/core.h  |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index efb0d2d5716b..5d669f985a82 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1097,11 +1097,13 @@ static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
>         u32 resp;
>
>         switch (mmc_resp_type(cmd)) {
> -               /* Actually, R1, R5, R6, R7 are the same */
> +       /* Actually, R1, R5, R6, R7 are the same */
>         case MMC_RSP_R1:
> +       case MMC_RSP_R1_NO_CRC:
>                 resp = 0x1;
>                 break;
>         case MMC_RSP_R1B:
> +       case MMC_RSP_R1B_NO_CRC:
>                 resp = 0x7;
>                 break;
>         case MMC_RSP_R2:
> @@ -1305,6 +1307,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>  {
>         bool done = false;
>         bool sbc_error;
> +       bool ignore_crc = false;
>         unsigned long flags;
>         u32 *rsp;
>
> @@ -1329,6 +1332,10 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                 return true;
>         rsp = cmd->resp;
>
> +       if (mmc_resp_type(cmd) == MMC_RSP_R1_NO_CRC ||
> +           mmc_resp_type(cmd) == MMC_RSP_R1B_NO_CRC)
> +               ignore_crc = true;
> +
>         sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -1351,7 +1358,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                          * CRC error.
>                          */
>                         msdc_reset_hw(host);
> -               if (events & MSDC_INT_RSPCRCERR) {
> +               if (events & MSDC_INT_RSPCRCERR && !ignore_crc) {
>                         cmd->error = -EILSEQ;
>                         host->error |= REQ_CMD_EIO;
>                 } else if (events & MSDC_INT_CMDTMO) {
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 56972bd78462..076e1c71a07e 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -66,6 +66,7 @@ struct mmc_command {
>
>  /* Can be used by core to poll after switch to MMC HS mode */
>  #define MMC_RSP_R1_NO_CRC      (MMC_RSP_PRESENT|MMC_RSP_OPCODE)
> +#define MMC_RSP_R1B_NO_CRC     (MMC_RSP_PRESENT|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>
>  #define mmc_resp_type(cmd)     ((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>
> --
> 2.34.1
>

