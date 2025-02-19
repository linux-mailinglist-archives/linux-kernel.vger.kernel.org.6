Return-Path: <linux-kernel+bounces-522601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF690A3CC35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D6D7A8B60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49F255E33;
	Wed, 19 Feb 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzUFzE7P"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92158286280;
	Wed, 19 Feb 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003768; cv=none; b=keDd2gKIlqFPFHt8CbT2Vvi34uGxc/GMz6K10RUMajOfdi1ifr66JVLRBWaolWf7HWKVUllaq8om1XcxHCHNySb81BQ7ReqB45iBhdYMyt9/ssu+gFuNZgXnxWO4c70iPwSWTUOts1wZhgRbxD34j8qf1pOTZUK4g80ALFfXxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003768; c=relaxed/simple;
	bh=SHiBAOh0/DlDL8hUB3T6+LtKrV85BGIXTOwOLa6mnT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFVBiAs76nfQR99DKIll8HKovz7xyj+RsG+fUyJ0miXZzWr2bMu4ZD6yTM5rQZkLYurTqVTV0QCU6HMUsP3y+y4ox7SAgit3e4SVA+WeOTSmSrWOWvzaRGfSgBERyRNprmADb+M/LNZK0nYLxULjC7/AjvLWiKyGpEfyy9Jjrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzUFzE7P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab771575040so256219966b.1;
        Wed, 19 Feb 2025 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740003765; x=1740608565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Ut+HC9eKHgdin8LIIS2Fjeny6qwex+kr1lgIMYN8w=;
        b=IzUFzE7PQLYM68DP3mgiHA5tAAee5PS8TvEy6cys7cwZYHGw7YfkEGbN46zN8k90PS
         oKhPZDiZw4lrsfAS43qv5zXkI5eJw4iACAfcPMawZWnS17yGZVMULSl1TAv9CvN8lgF2
         xRfvi89HkG4PEIP493LL7StzHO3W5sPzgQ15WwjslMfmHdJHBZOLx7y8ZqVwTiHhPWKI
         hRo2+PJJRKs3BLryMF4m/K2tfOegypQ+qpLizTN0uOqBRSSsr7qB3zjw7liEq6PhL29l
         zyWaTppBHVaPQua52erXm6/4/wwZuqozGETfV5s0ewp9Zw+iW6GM49WpjqhEasKiSIli
         +BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003765; x=1740608565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Ut+HC9eKHgdin8LIIS2Fjeny6qwex+kr1lgIMYN8w=;
        b=GegUAY7R0gTb9V5vukA6lJWNdCu9P1wwv79b29rLfb32UM75POaopCjGIJizr97+vU
         AL0z7yGGmuBCzdXxtrXioZVvK5EjRpEZCLFc2rOPsQD0oPAokYt1l/AgcCH/Ki5YnuKz
         e4gVgsCRBVJ1hIeALCBZNc7f+OJLIEQjv1Ps9/7fv0dsJO3eQplWWBKcDh9jvUQtQ1O5
         nJ81anK6nLzOqyV/vsKMk0ydEZ4No8p40vGeDFz454KUF+TsXocciGDT/mtlI0OCyYBz
         boNZKfB4Izt2/OXy5GwaEyAVllg39rf8iO+uugcsrntEwEHLJidm5hi8rz5a5XkDl6UL
         TOdw==
X-Forwarded-Encrypted: i=1; AJvYcCUkAtSJqTmWH0eRrJy8LDkGaCiiW4cNZpu8su+Qois6cM4irwJh8pknF/lQf9LBhJxf0T3lOKC5MFe5@vger.kernel.org, AJvYcCXLmnA5N+OWbMabLEzQ0QLFgzZ5tOuNlXDv8r1V0f7JxFTmevrr3aA2jtJXXQ3B85B09NFRHNuPjv8F4n69@vger.kernel.org
X-Gm-Message-State: AOJu0YwIk0gBUe/kJyU8NxkkKrq0l5uPsLyiLb9xfhOyrPgEScavVhL+
	fifK51IsKX9Xcn5G2q0tGjGFRXRtzmOKS2RW0zOVobGf8s8j6XWY
X-Gm-Gg: ASbGncvWt0EplT9BRHF/C1DHnuOsx+meysXtXsHfH1hzLamokMiifyewE7MRgly0aq6
	jVhDGGC5jCQYTT1d/7trNvxtKh1gkMb2KTXAj1RrBienI+n/G0xccNY0k2yLMdrQMrv6zkDcyBA
	9hSdlYc8mkOb0w4srfGIBo/EDAvpT1gZzplQKoLBT2cgMWew299Bn7YhM4tUX/Tcrwh4r1xZS6p
	W4dEX0vHia8W7vyPkURb1s+MzXqQ4avQjlLaJOo2Gnw4EGnuj0iFuyIB65QMnIzrpGiqLbumtmt
	wpgy8WexWw0Jy8H7pisvj65wKgFka+bgWrgTspZdNK9Q
X-Google-Smtp-Source: AGHT+IHgZ/9o+/TaQRZkw3ZCR/vfHz3eRXJzfUy3azBJWNM0TELKM477HK5xLn7uBryQfbFCimYo+g==
X-Received: by 2002:a17:907:890a:b0:ab9:76d7:574c with SMTP id a640c23a62f3a-abbeda27f98mr82689866b.1.1740003764658;
        Wed, 19 Feb 2025 14:22:44 -0800 (PST)
Received: from [192.168.1.130] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdf076360sm165470566b.110.2025.02.19.14.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 14:22:44 -0800 (PST)
Message-ID: <c52e6c5c-f49e-4727-b669-086ae7cb0e1e@gmail.com>
Date: Thu, 20 Feb 2025 00:22:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to control
 the DSP
Content-Language: en-US
To: Daniel Baluta <daniel.baluta@nxp.com>, p.zabel@pengutronix.de,
 robh@kernel.org, shawnguo@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com,
 laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-9-daniel.baluta@nxp.com>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250219192102.423850-9-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/2025 9:21 PM, Daniel Baluta wrote:
> Use the reset controller API to control the DSP on i.MX8MP. This way
> we can have a better control of the resources and avoid using a syscon
> to access the audiomix bits.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
>  drivers/remoteproc/imx_rproc.h     |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index ea5024919c2f..631563e4f86d 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  
>  #include "imx_rproc.h"
> @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
>   */
>  struct imx_dsp_rproc {
>  	struct regmap				*regmap;
> +	struct reset_control			*reset;

Maybe rename this to "stall"? There's also the DAP stuff that's actually used
to reset the core so this might be a bit confusing?

