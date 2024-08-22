Return-Path: <linux-kernel+bounces-297809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824B95BDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C29BB22587
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45581CFEAF;
	Thu, 22 Aug 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjMtLYV6"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0F43165
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350061; cv=none; b=s8TIFWZo2YaJ3cX7t8jqPKxzQYn7HpL0ULhXM5Xy7kj/V/rB0GyXweVydIWuLHFJYv7kE98tM9UJlMVPYtrUDCknrkkWHPBVnxN2MLpYKFSpLhZK/3x4oT92udGYqo6mpbPzaguKRh5U/Y7LbFTeaUcGf5Ck7uLX9r1qRh7M6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350061; c=relaxed/simple;
	bh=1O9vC8Ub5ix8LyTH4b/+Hy7eOAcgoYhD/5DXIM/VygQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBR2DvIWU8jioiiNUT/x29SzqxCyQYqXMt7CQoBZP8iZ3CAX5i4DxxZo75CjfEnblpVW+gUZHOSR8MO1qbpDVD/PyLcR4nm29jrWPaxK4F/0zlz6M0Fx0/HWJTFU8TJzJpDrNv1441cTgt49LqWH4jDFrwEHc4llxphIfih/rJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZjMtLYV6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d439583573so840294a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724350058; x=1724954858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/pvOZ8QmQOJgVwLDkuJvTgRqV+BiNA2Wp1U0v/4kwo=;
        b=ZjMtLYV6A1EKgpVMpEKNfpFJZegYaMLhj3hjvNnXs5xXWUn7AkxraUWF4NTXmRazZw
         tmmBgr1nSUBufdw0tfFnUhD6Lmww7uElFKTxWYR6a1L64G15r7JVZhuNllOttS6CxTh8
         Pm/9Reh13XaKVykBdddeoTP7n0v+BGT1HwEIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350058; x=1724954858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/pvOZ8QmQOJgVwLDkuJvTgRqV+BiNA2Wp1U0v/4kwo=;
        b=nuFztPDiiqU//JUQsvhi9AVStTTxCpI5ffamKHgl1+Sh9MLjJ63kr0r0kOEWboC3AD
         Sa6G/uL3tSyepDpiZcky4a8pdIcrBJOSLe7HkUQhLCSWtVnV3q8GcZttDZ5FYxxRMgTC
         zkNEUvuWHQENMyBYl2s3qFelme7zFhV550G/SQg09LFw6lL1H9fnRBIOCsLu8bwTWs/R
         yafBv4NAi+VXnN5FMnb0h/w5+qZyxPJn3f9sGxCG1Bv3fEjajufx//p5It58yjcvg9h5
         PNw3GiHl7AhPGw8BO5oH+pBAqPzJCrSaT6jjtdjwKeJxhDXy9p63E1NxUvlPt7OXg+cb
         o32A==
X-Forwarded-Encrypted: i=1; AJvYcCVTYYZU5iqVj4oNg86ufUDhXotgG2hqwPUQPfbWIOKSPZVBJg0HvdniO9myyeAA8+acBgBV4Mfwnkg67Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Hg2Lhs2Cox7PpG+XhsrAy9R0AIdQ6zYKWnwcECrzwxhb1Eiq
	7b3DbfWhHxVyyFMm8eUifY2NfH60IorinpzYW5Jc8P5Nzr7pgOmaTse3MpRmqw==
X-Google-Smtp-Source: AGHT+IEvb1NFF7jDJJq6my2bW/vOgpn7OwDAHHPeb3en8xgSUD8A2nA+Vjnbu2muHEJGXT/ggFNSPA==
X-Received: by 2002:a17:90b:3b45:b0:2cc:ff56:5be1 with SMTP id 98e67ed59e1d1-2d5e99c52d1mr7283937a91.7.1724350057634;
        Thu, 22 Aug 2024 11:07:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d613a6123fsm2181163a91.33.2024.08.22.11.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:07:37 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:07:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Message-ID: <Zsd-ZxscUBmf0xsu@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>

Hi Sascha,

On Tue, Aug 20, 2024 at 01:55:28PM +0200, Sascha Hauer wrote:
> The command response handler copies the new MAC address over to
> priv->curr_addr. The same is done in the code issuing the call
> already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
> handling.

It took a bit to figure out what you meant here -- I guess you're
referring to mwifiex_set_mac_address()? It could help to document what
you mean.

I'm also a bit torn; this command API ostensibly has a (unused so far,
for this command) HostCmd_ACT_GEN_GET mode, in which case this *is*
important.

If anything, I might consider dropping some of the handling in
mwifiex_set_mac_address(), because it seems to presume (and then has to
undo for failure) behavior of the underlying command.

Brian

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> index 9c53825f222d1..7f81e709bd6b7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> @@ -473,25 +473,6 @@ static int mwifiex_ret_rf_antenna(struct mwifiex_private *priv,
>  	return 0;
>  }
>  
> -/*
> - * This function handles the command response of set/get MAC address.
> - *
> - * Handling includes saving the MAC address in driver.
> - */
> -static int mwifiex_ret_802_11_mac_address(struct mwifiex_private *priv,
> -					  struct host_cmd_ds_command *resp)
> -{
> -	struct host_cmd_ds_802_11_mac_address *cmd_mac_addr =
> -							&resp->params.mac_addr;
> -
> -	memcpy(priv->curr_addr, cmd_mac_addr->mac_addr, ETH_ALEN);
> -
> -	mwifiex_dbg(priv->adapter, INFO,
> -		    "info: set mac address: %pM\n", priv->curr_addr);
> -
> -	return 0;
> -}
> -
>  /*
>   * This function handles the command response of set/get MAC multicast
>   * address.
> @@ -1232,7 +1213,6 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
>  	case HostCmd_CMD_MAC_CONTROL:
>  		break;
>  	case HostCmd_CMD_802_11_MAC_ADDRESS:
> -		ret = mwifiex_ret_802_11_mac_address(priv, resp);
>  		break;
>  	case HostCmd_CMD_MAC_MULTICAST_ADR:
>  		ret = mwifiex_ret_mac_multicast_adr(priv, resp);
> 
> -- 
> 2.39.2
> 

