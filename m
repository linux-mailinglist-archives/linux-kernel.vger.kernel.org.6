Return-Path: <linux-kernel+bounces-271133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20D9449F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15A3B20CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B7188007;
	Thu,  1 Aug 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guHNDVh2"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CE170A29
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510109; cv=none; b=PhMszmfVuFVm2MkQEiuixE3BVIBaK1XW6Xm7QBA3UM08BD2syS3yFEF4fSAlm2y25hLVMPLW+2NVicPx9dfv9q/V6qMorebJ1MzyAd2DXhW6BSJk0x+0biT2JajVZ2dIhm5ZSI+EODGexblmNnpQt6EwlrGYzhJrfJzvK/QnVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510109; c=relaxed/simple;
	bh=o3DMQQxGo3x39I7djsSUQeIpjlb4LUUbCkAOfJFGf1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7mmdqkUVJwivL3FmmwWj9icr64t8Tfl6ftOSOQXbr2fk9JxjGRxhlRds7rQbtk/xaxQEMRmEgS5uspajJphvYGpnpQYZriISmE1iIGIXkB/KB7OUqCU3T888VdPnG4FPpBLbQ7560qukCu58RzSJNRbzTv/8H7vSbtKPJums7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guHNDVh2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5336793276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510107; x=1723114907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/lBUEuHtZhYH9hMMltxd6FYM94een14SRBxxIIu5uM=;
        b=guHNDVh2d+8xwoK5wKYC/qmSDhV47aQFbaYcr5OE+wD0dEbADgpfGTWClpKyIChpMY
         ct6LU4Ib6SnPWw8niFnl6AYLwwjM3n0yG+uuGgIcHnWv0FQsG8fdOafq0qnNGygHoxjS
         SYMjNoMI1NLjqDFZ87ED5Uhb5c/65OXRBuG061P7Aj7Z16PRISing8OyzyBxRf6gbcR+
         wVbwpgAnEuTCBD3GBV+36kySo9+J0vptSFL3r1ZXTpgrswEQVdf9clANi5S0eK9b9vFF
         mniW3kz38ZDs6Bt8OCsGNC8K00JmSuCTu7V8dPAZEWei36/wjKhL5cTBkH4dCAtr9U3v
         vnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510107; x=1723114907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/lBUEuHtZhYH9hMMltxd6FYM94een14SRBxxIIu5uM=;
        b=a0/+cTMsuL8G8YD1rSfFtcSNDEbjauamlq9BzJ997rT4UVvQ7w8uIb901ZNmtojtJl
         3gmlWv97QULvnBR2why+jAy5R+tTNsr13cvAXYfcZR+GxDSnsNjPB5yPyeZoxjVhde7t
         5ZNqOc1Upv8D8D47Qs/iVrbJrY3twDJJoo2p1cvz8BcOtDVGYLFyY/4um8QqrfS77I2b
         slKS3qAKMJ222bjVNHUcmoAgqSo5qaKkUa1jHO/yJgSqFhn4f6mFn78qpepigkrG8SAq
         8ZI1UnZZpUuy9//NsXn7mmmlRywH67Lgr4gcLeEGqhw1UG+oY9DDBtQszc/h2BStoX1b
         BZJA==
X-Forwarded-Encrypted: i=1; AJvYcCUB3056r9m1AlyzNttuwpBdzxuacNR8djBxuHG5eEjR3eZ10YzFOsMBTHI/iK2KG3fg7jgi+V7bCqEkoFf6vOdQgqJgfNWRZtc76kb0
X-Gm-Message-State: AOJu0YzuXR+r4ki4vQmklMdJhenKQfQxftnRn7zOsa5xZHD5byCabF99
	Hc96/eoQHcPEoalrZBxP4UdBJAtps7u3yrmBzy9OcfofGvc1JLYmkY5ghy6HZF7ucGuTTpQRwVr
	jtDc5Eo8nXBcZqb3FMLS60zqaML2Uo8PGBZnMTg==
X-Google-Smtp-Source: AGHT+IFNMTUyuraUOe17RSwLCsQl2Heh5eaqrtk7oyS7ocUH1DnCdcUeW8y+TayZq1Ii/rIMs7hczcO3KQE8rJP/Pyk=
X-Received: by 2002:a05:6902:1209:b0:e08:6055:9f3c with SMTP id
 3f1490d57ef6-e0bcd2b587amr2051515276.31.1722510107179; Thu, 01 Aug 2024
 04:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716013704.10578-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20240716013704.10578-1-mengqi.zhang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:11 +0200
Message-ID: <CAPDyKFqK7CwGF2CitFtHUE_8hRxMr92KmWQzdO4kWRa7kYqHuQ@mail.gmail.com>
Subject: Re: [v1, 1/1] mmc: mtk-sd: receive cmd8 data when hs400 tuning fail
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.stable.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 03:37, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> When we use cmd8 as the tuning command in hs400 mode, the command
> response sent back by some eMMC devices cannot be correctly sampled
> by MTK eMMC controller at some weak sample timing. In this case,
> command timeout error may occur. So we must receive the following
> data to make sure the next cmd8 send correctly.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
> Cc: stable@vger.stable.com

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a94835b8ab93..e386f78e3267 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1230,7 +1230,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>         }
>
>         if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
> -               if (events & MSDC_INT_CMDTMO ||
> +               if ((events & MSDC_INT_CMDTMO && !host->hs400_tuning) ||
>                     (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
>                         /*
>                          * should not clear fifo/interrupt as the tune data
> @@ -1323,9 +1323,9 @@ static void msdc_start_command(struct msdc_host *host,
>  static void msdc_cmd_next(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
> -       if ((cmd->error &&
> -           !(cmd->error == -EILSEQ &&
> -             (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
> +       if ((cmd->error && !host->hs400_tuning &&
> +            !(cmd->error == -EILSEQ &&
> +            mmc_op_tuning(cmd->opcode))) ||
>             (mrq->sbc && mrq->sbc->error))
>                 msdc_request_done(host, mrq);
>         else if (cmd == mrq->sbc)
> --
> 2.25.1
>

