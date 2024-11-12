Return-Path: <linux-kernel+bounces-406548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A329C611A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A9DB86789
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1221892A;
	Tue, 12 Nov 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFuPLdi8"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68521764C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437055; cv=none; b=AHLMQIRuZFC5gsb9SKNOQlt22/mNZgwFuz+eMfEdE8NSrDCccvp9Npq5A0stuC/0feb4wxxYNTBWYCBeFLXRssOpfGSmP8jv7I4kY27h9th3piybp/2n9Reg+YWAeUl10pQ+5HG0GIkVQ3WU5puGrHZKg5A36NugvxuDV2HLHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437055; c=relaxed/simple;
	bh=dunAvQXuwq96TSVpr/PE7OTE05OkunBMhK9YIy0LnXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnO85KG5VyBy2XE00lSWbGyvyh74RcV207bgmHVmTeZjbyJJEOPNeV3zSVL2WzGPDKf6OxTyN743sInaGnD4T6vq52Jb+4GEEL4atgKTlJzKHtJ9OlqHVGlC47/+StVNJG3HCLJOwhKkyEkc1NSFV4e7UmwganM17DCV9l56Hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFuPLdi8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e377e4aea3so48044947b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437053; x=1732041853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lm/tZXkUJOtuPwLYKAivcT7QcZteWISYFkH21DDHem4=;
        b=fFuPLdi8gCvFgEVhlIWpfVZBKFR0Wwkb/RDDU8uXkh8+ozS81qr+iEBt1+KBfBrdjM
         Uii35cRtKhO5xxQ/h0rzJl5e0kjUOdxAigv5T97WrAW2aED4DkXHJdU1l7Bb7Nss/ZDJ
         NxHSKgMQ4fHnxPoG8/qer0pfRTgox3a1gk59mMPqMwuqgBG19EW8RatgI+QZFAurgnY2
         IvdTAYHtkk+A8YSEjunIeQvAjeJ9g20eckB6WtS0ZabKgTrdcDaGJP4+r3QLWVjydS6B
         sr4l/ARDqHNi5rQzoT5kyNS2ArBS8TXcQipjLJGATa/lLX0qZRVR5Ai8lrCGWRPRkrL5
         dTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437053; x=1732041853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm/tZXkUJOtuPwLYKAivcT7QcZteWISYFkH21DDHem4=;
        b=OuC8+Qu3o66OaUzRO9ynBXCvioDSvUZplJBM5Yjg5e9K+a8pwYECW28IBkgnwtHF7c
         38N0F5hGnWxfR2QoCGNJvXoW7DzHzhf5PcHSGXtRCAiWVs/jJqD/femb7p90BkR3wK+s
         d9kuuSmJlsZFvl6f+ev1eUvihPD3i44AXo47vxQXvKPClIEB85d2MYs7toBZQKWR78TG
         LdFmyDWcTgqiipAk+fy8Vp0heq4w8ttCzysrxIOpGMgiyEe26klfHzIoIom+GK1a537+
         JxVHuSovtJbLkYaDO8/AJgQ2N4Rsxy7/K5VMrZsJiQqbu7XKu+O2lHCUhCrYq6izwKau
         KRWA==
X-Forwarded-Encrypted: i=1; AJvYcCW86W66kXirOHZEhkZ0IMntpBQ56X+wq0ENiu7WjGxtIY1QRQkfE6iHGUkx0ONzWIgZAXUr0vi6qdgl/Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/+G3WHUfnoCN+A3Nw2xcDo6KUg49WmrE+B4hiYZ4ti2DzjKU
	le/JYlR+FQrkBQCAN5Evr7caoACiRkU4Avo4DtHyfarPGwRNji6pPK+dfly/BdiO+RHmX1Yt5kG
	eV8bTIk8yE688GzCv7PWXxwf4qX5i8cLmkh06mQ==
X-Google-Smtp-Source: AGHT+IFYk3QMEC6wOmmCkeb6g44ECNm7m7K6qrk/PEfdSQ0Nkogvd4b94TIszmaJUfcIQRWr8U96lmZc8KezrGNYN5s=
X-Received: by 2002:a05:690c:388:b0:6ea:807c:bbaa with SMTP id
 00721157ae682-6eaddd79c47mr170130527b3.5.1731437052905; Tue, 12 Nov 2024
 10:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101104416.4954-1-victorshihgli@gmail.com> <20241101104416.4954-2-victorshihgli@gmail.com>
In-Reply-To: <20241101104416.4954-2-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:37 +0100
Message-ID: <CAPDyKFr5vyTx+vDf9OqV=hW3Fvk+cSBAp=T5VduAu_EvQjGnmA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sd_uhs2: correction of incorrect type in assignment
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> There is a type issue in assignment in the sd_uhs2_dev_init(),
> sd_uhs2_enum() and sd_uhs2_config_write() that will generate
> a warnin when building the kernel.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410260423.15jvE6qc-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202410261827.7h8YK8u2-lkp@intel.com/
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd_uhs2.c | 56 ++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index ddd2291ad7c4..0611db848c23 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -144,6 +144,7 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>         struct uhs2_command uhs2_cmd = {};
>         u32 cnt;
>         u32 dap, gap, resp_gap;
> +       u32 payload0;
>         u8 gd = 0;
>         int err;
>
> @@ -180,10 +181,11 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>          * Let's retry the DEVICE_INIT command no more than 30 times.
>          */
>         for (cnt = 0; cnt < 30; cnt++) {
> -               uhs2_cmd.payload[0] = ((dap & 0xF) << 12) |
> -                                      UHS2_DEV_INIT_COMPLETE_FLAG |
> -                                      ((gd & 0xF) << 4) |
> -                                      (gap & 0xF);
> +               payload0 = ((dap & 0xF) << 12) |
> +                           UHS2_DEV_INIT_COMPLETE_FLAG |
> +                           ((gd & 0xF) << 4) |
> +                           (gap & 0xF);
> +               uhs2_cmd.payload[0] = payload0;
>
>                 sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
>                                      UHS2_DEV_INIT_RESP_LEN);
> @@ -229,6 +231,7 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>  {
>         struct mmc_command cmd = {0};
>         struct uhs2_command uhs2_cmd = {};
> +       u32 payload0;
>         u8 id_f = 0xF, id_l = 0x0;
>         int err;
>
> @@ -247,8 +250,8 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>                         UHS2_NATIVE_CMD_PLEN_4B |
>                         (UHS2_DEV_CMD_ENUMERATE >> 8);
>
> -       uhs2_cmd.payload[0] = (id_f << 4) | id_l;
> -       uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> +       payload0 = (id_f << 4) | id_l;
> +       uhs2_cmd.payload[0] = cpu_to_be32(payload0);
>
>         sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_ENUM_PAYLOAD_LEN, UHS2_DEV_ENUM_RESP_LEN);
>
> @@ -469,6 +472,7 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>  {
>         struct mmc_command cmd = {0};
>         struct uhs2_command uhs2_cmd = {};
> +       u32 payload0, payload1;
>         u8 nMinDataGap;
>         int err;
>
> @@ -491,10 +495,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>         host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
>         card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
>
> -       uhs2_cmd.payload[0] = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
> -       uhs2_cmd.payload[1] = 0;
> -       uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> -       uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +       payload0 = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
> +       payload1 = 0;
> +       uhs2_cmd.payload[0] = cpu_to_be32(payload0);
> +       uhs2_cmd.payload[1] = cpu_to_be32(payload1);
>
>         /*
>          * There is no payload because per spec, there should be
> @@ -549,8 +553,7 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>                 card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
>         }
>
> -       uhs2_cmd.payload[0] =
> -                       card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
> +       payload0 = card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
>
>         card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
>                                                 host->uhs2_caps.n_lss_sync) >> 2) &
> @@ -562,10 +565,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>                                           UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
>         host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
>
> -       uhs2_cmd.payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> -                             card->uhs2_config.n_lss_sync_set;
> -       uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> -       uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +       payload1 = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> +                  card->uhs2_config.n_lss_sync_set;
> +       uhs2_cmd.payload[0] = cpu_to_be32(payload0);
> +       uhs2_cmd.payload[1] = cpu_to_be32(payload1);
>
>         memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
>
> @@ -612,13 +615,12 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>         host->uhs2_caps.max_retry_set = 3;
>         card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
>
> -       uhs2_cmd.payload[0] =
> -                       (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
> -                       (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
> -                       (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
> -       uhs2_cmd.payload[1] = card->uhs2_config.n_data_gap_set;
> -       uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> -       uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +       payload0 = (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
> +                  (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
> +                  (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
> +       payload1 = card->uhs2_config.n_data_gap_set;
> +       uhs2_cmd.payload[0] = cpu_to_be32(payload0);
> +       uhs2_cmd.payload[1] = cpu_to_be32(payload1);
>
>         sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN, 0);
>
> @@ -645,10 +647,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>                         UHS2_NATIVE_CMD_PLEN_8B |
>                         (UHS2_DEV_CONFIG_GEN_SET >> 8);
>
> -       uhs2_cmd.payload[0] = 0;
> -       uhs2_cmd.payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> -       uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
> -       uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
> +       payload0 = 0;
> +       payload1 = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> +       uhs2_cmd.payload[0] = cpu_to_be32(payload0);
> +       uhs2_cmd.payload[1] = cpu_to_be32(payload1);
>
>         memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
>         sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN,
> --
> 2.25.1
>

