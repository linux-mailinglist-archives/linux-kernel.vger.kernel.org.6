Return-Path: <linux-kernel+bounces-576255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A35A70CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B323B6A05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134E26A08C;
	Tue, 25 Mar 2025 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6MF6CC2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D978269CF1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941531; cv=none; b=Z7d7cy42Sc/Ajcv0HLvyE2M80lv7dcUxGDMRMNuIp8lg1T0QgLdxRfcFqBtebUGSSbg4eAUwbpy0wDM/zFwH/CgqczO37xBEaycaODOjbg+ZIoBjrMa2B7WCtLmtb130CJ7pF3sl3MBQwnAM1XRh8ivLTP96jDCfKWXNur3rUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941531; c=relaxed/simple;
	bh=DxbUnuBK5ISJePyX2IHCaXKQFXjrwR0Adn2978Bbh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bggsJAqJkYfGvNZ+jFtrjJOqoo8jmIKrvTBT4McKTlBTs0LvdLSTHUZy2G0y8B6nGi9RfMbmc0eNR1HlMpXvxGvxhMAF3P8xZ5etGAz8mUINechbAqhLUkmkVOC6ukpeKdcSUhn3JsaLSnLDv5AVCVv71To1t1DhT7ykHlwWjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a6MF6CC2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22580c9ee0aso126962955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742941529; x=1743546329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e872gGg4Gz2lxgWQ8PrbHnFp07xu+/jOZUr0j6fpLIg=;
        b=a6MF6CC2oWz49InrEUZIAMfKaoSJktAMJO2sQt+JYyjKmXBOR2l95H4ffjGaTlWJzJ
         y5TcWnEkUn1MliKJYNo15G98GN/9kLlcc4+AC3gZyqWE6p+T+WeirQ8WO5M4EOihxFUO
         p8vJdh0ABQMCboa3q8JMjEfY4IjHPJhNvRSZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941529; x=1743546329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e872gGg4Gz2lxgWQ8PrbHnFp07xu+/jOZUr0j6fpLIg=;
        b=afHtpVRFYS097AqAT622zltIx4rXhiwYaWv5ktcoGaGuuXkWS+/FN6hYyXctgsyc1W
         REP4fLsh/0HJ/qk7Qw0FR3T3iE5fAQiGfDL9UiIjzC3VSou1I++Gq/uZQmSaEkcGbvfM
         x0Hb4dPEF9HQOBEBp+mJ83Ku77BOiBMfYWtY77KvtnOyKHsfwSsWdwijAZTxgOeMt9xH
         GPEXaxI1pbjNBSkOtItFlHSGfYFGAJlRVorSfI4i+fPzzc4TR9P9RRLN9lUq/TQ3QLDL
         vBLGKGyuTXL/Z7nyZDa2D/8drAYps/Q2eILC4L6spvaQNcv1bXbPL/CrhZBAc8GJwYO5
         6wEA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ17xKc0XaEOoWcybvpUbjTxdDxc3peqGh/WiIjg833SoykByf6tb/FNbjj9xgHRYEw4DqzZ66pL6LYZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6bp8Dk18pW9e3kHpBs280opiNOCb0pJIJb4I8vAavy0Xyuz+
	eg6kLybTPESF/S4VDnvJ5W9NSiawHpNoguOAS6LvVBPlyJsEINU+QE5xYWbgCQ==
X-Gm-Gg: ASbGncvP8MR7orXn9+SUYZoO/ZuqKWu8GBuU+AN343RM9Oj6FuAwAAkhGdeVWnmZZEH
	0cWeQPpug6RYTyNhwT3OG2ric0BJPEUKND2Ls8M1QvimXST/FTVCZFbbnSotAKHFtu7e+hP6CwL
	5PYDfD+mFDHDfPog8CQ3y0chIuiTGmpv+bpzO1UN/BQlOEkDjihMiQ3CoZFLuVC8Oq2ldTPHQi6
	ndJQeannABW/teT5yef3FRnQiePY0/w+nd0q8Qb0wmXfNvy1OTJx60s4Cjb7jm9YzVEOFftuOWL
	PyH0K5bO0WaRY1bJ6cSnmOflG+U8ppNC8lT7PwJaGYbqVEPz6uFlETEVp9OiDeOaqpBEKKo4Vy5
	4K3NsZUM=
X-Google-Smtp-Source: AGHT+IGfR3dYvOb5O7Gtf+Lz8lxv5DNfeDk0VRui04c4b/0fsh/5+kLMqM9QCS8L5AH9kKzdEgIq5Q==
X-Received: by 2002:a17:90b:35c4:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-3030fe7f0fcmr28488510a91.9.1742941529313;
        Tue, 25 Mar 2025 15:25:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3037c8ec9fdsm36517a91.1.2025.03.25.15.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:25:28 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:25:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH wireless-next v5 10/10] wifi: mwifiex: drop asynchronous
 init waiting code
Message-ID: <Z-MtVj4NpcLuZxJv@google.com>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
 <20250324-mwifiex-cleanup-1-v5-10-1128a2be02af@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-10-1128a2be02af@pengutronix.de>

Hi Sascha,

On Mon, Mar 24, 2025 at 02:24:11PM +0100, Sascha Hauer wrote:
> Historically all commands sent to the mwifiex driver have been
> asynchronous. The different commands sent during driver initialization
> have been queued at once and only the final command has been waited
> for being ready before finally starting the driver.
> 
> This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> initialization commands synchronously"). With this the initialization
> is finished once the last mwifiex_send_cmd_sync() (now
> mwifiex_send_cmd()) has returned. This makes all the code used to
> wait for the last initialization command to be finished unnecessary,
> so it's removed in this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

There are a few things that confuse me in here. See below.

> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
>  drivers/net/wireless/marvell/mwifiex/init.c    | 18 +++++-------------
>  drivers/net/wireless/marvell/mwifiex/main.c    | 25 +++----------------------
>  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  6 ------
>  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
>  6 files changed, 8 insertions(+), 81 deletions(-)
> 
...
> diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
> index 8b61e45cd6678..fc58ca1a60ca8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/init.c
> +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> @@ -487,7 +487,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  	int ret;
>  	struct mwifiex_private *priv;
>  	u8 i, first_sta = true;
> -	int is_cmd_pend_q_empty;
>  
>  	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
>  
> @@ -509,7 +508,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  	}
>  	if (adapter->mfg_mode) {
>  		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
> -		ret = -EINPROGRESS;

Why are you dropping this line? To be fair, I'm not sure I understand
all the manufacturing-mode support anyway, but I equally don't
understand why you're dropping this.

>  	} else {
>  		for (i = 0; i < adapter->priv_num; i++) {
>  			ret = mwifiex_sta_init_cmd(adapter->priv[i],
> @@ -521,18 +519,12 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  		}
>  	}
>  
> -	spin_lock_bh(&adapter->cmd_pending_q_lock);
> -	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);

I believe your reasoning around the synchronous command logic, but would
it help to include any sort of fail-safe here for the future? Something
like:

	WARN_ON(!list_empty(&adapter->cmd_pending_q));

? Or am I being overly cautious?

> -	spin_unlock_bh(&adapter->cmd_pending_q_lock);
> -	if (!is_cmd_pend_q_empty) {
> -		/* Send the first command in queue and return */
> -		if (mwifiex_main_process(adapter) != -1)
> -			ret = -EINPROGRESS;

You need to update the function comments now that you're dropping this.

Brian

> -	} else {
> -		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
> -	}
> +	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
>  
> -	return ret;
> +	if (adapter->if_ops.init_fw_port)
> +		adapter->if_ops.init_fw_port(adapter);
> +
> +	return 0;
>  }
>  
>  /*
...
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> index f2e9f582ae818..199a8e52e5b16 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> @@ -2418,11 +2418,5 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
>  	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
>  			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
>  
> -	if (init) {

The 'init' function parameter is no longer used. Can you drop it from
the function signature?

Brian

> -		/* set last_init_cmd before sending the command */
> -		priv->adapter->last_init_cmd = HostCmd_CMD_11N_CFG;
> -		ret = -EINPROGRESS;
> -	}
> -
>  	return ret;
>  }
... 

