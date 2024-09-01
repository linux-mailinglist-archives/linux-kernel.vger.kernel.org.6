Return-Path: <linux-kernel+bounces-310240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F69676C5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45121F21532
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987D17E00E;
	Sun,  1 Sep 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ0Qf9/0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3483A29F;
	Sun,  1 Sep 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198022; cv=none; b=GFve+/ST5wEZBsJtMxzgQH55Gr9Osgo6hLhZiRNAD0XzZm0Bju2kuUPYMZZ6sjdKk4P4ZMtyRuWiv7cFVAN6x7fssnPfpOMxzWV41JH+vWqyE7abp+N24bZhYfS+H6LHO2qqtruqQ4lu3b8lpYUH6QdtP0Fldyk6y8YXO33NZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198022; c=relaxed/simple;
	bh=lCud1v0rR2bB8PLBJk5AMKOvsdtpMp2LewJwYiRB7QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI5KyAXv1O6W8tU/2vnmGSvOOGUtFFYk8fwPWHuX9zqtQXF3HH5YxEgPIMkfgP5OscsckPg3my00l55EBeCLJqB/B2Nbsshq1lEDOhOmA1zzriPka8nVYZu60O6D2jM3YEq6gXblXIKl5XQ3nRak7X90ZQVVpCIMvUURfwFJJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ0Qf9/0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2289828a12.3;
        Sun, 01 Sep 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725198020; x=1725802820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTHaMZtqkTyeTZH7IQINuXTpnisNGkcdp5XTWldTU/E=;
        b=fJ0Qf9/0VGjbduBWMCVRxLANLDlIEAx7kOrojaMmLIjAiNZI7u8POawBhh8z8TQGXk
         atCy1t6yoDLgKqyIJOhJUCixos27cwRtgGvn8ikYagRJCLSvRaBhQmIRsz1JK0H3+Pds
         Q1/yPuj/JsEJR6h9/eOCX+Ps1p26BLQcnJagvIqZ+11ZHkMzAibBARpHM2l35L9uClz7
         OishMZaP3X4gvrzwBT17m+dy5eYlMw59SStxH7VDAKSj0rpchhkoK0XAK1RCq8TsoOUf
         ctBorLgjMWdVKPL+ds3A8cUBXmEPhAsppBp8xw1531apH6H4sPp116Fli1ro1SR8I5tE
         8P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725198020; x=1725802820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTHaMZtqkTyeTZH7IQINuXTpnisNGkcdp5XTWldTU/E=;
        b=SB8MBMt1p9O3qZC8BKn/fx3Bxv+EKQ22+f6bDrnJ9Ql2wgtesXBeknA4huj6rkgbEU
         bjG3b1t66vByb0AkraotLW7FLCEFb5FBgd6+eybwCnyluzPjlWqhreYqyqbYGvJDWxCZ
         +i/9ybmXkRScAVj9c/Knis84l+twcTl5vck4MTX8M8pW3KnNXF3k/CybZD2OB5PRVjiw
         KCH75hnat4WhP+72xLcx0ADIgYnVyMbhOiKEZB4Ddkq4zC6PNItW2+Q8TJc6OMB5edop
         Bdn1L76ckZPKO2CqFhJzbGP6EbziKBMqg+jFIxnroshwalCLm7Tm+V7pyarrHhKwnac7
         VfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZU+sPmGNTfpV3kOIbo+SAwjAyjN8aquDvWvHxYV85fRcsmZNESPLaFUz6YFlDpNXpFt81xtYt1mg9cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3wyYMuA99JbussRcJr1IMr+lr0NfiLLG65luKAxj5EnzRUPv
	MWqBqSq/SgWQ5vCgFi8I98PbN0VZFaQFDgL1eo4W8T51DYcQ4QMO
X-Google-Smtp-Source: AGHT+IEiVH8ogskEW1BM525GsXwdJCwMsLZeo16JFZ/p3zEYokdgH3C0Jp5ob70yHVZZ48hsgQ29ZA==
X-Received: by 2002:a05:6a21:a247:b0:1cc:eb5c:cfae with SMTP id adf61e73a8af0-1cceb5cd08dmr9724060637.52.1725198020429;
        Sun, 01 Sep 2024 06:40:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575cd8bsm5396935b3a.199.2024.09.01.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 06:40:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Sep 2024 06:40:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: ltc2991: fix register bits defines
Message-ID: <02cf392d-57cb-48fe-930d-597f415520a4@roeck-us.net>
References: <20240830111349.30531-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830111349.30531-1-paweldembicki@gmail.com>

On Fri, Aug 30, 2024 at 01:13:50PM +0200, Pawel Dembicki wrote:
> In the LTC2991, V5 and V6 channels use the low nibble of the
> "V5, V6, V7, and V8 Control Register" for configuration, but currently,
> the high nibble is defined.
> 
> This patch changes the defines to use the low nibble.
> 
> Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc2991.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
> index 573cd8f5721b..7ca139e4b6af 100644
> --- a/drivers/hwmon/ltc2991.c
> +++ b/drivers/hwmon/ltc2991.c
> @@ -42,9 +42,9 @@
>  #define LTC2991_V7_V8_FILT_EN		BIT(7)
>  #define LTC2991_V7_V8_TEMP_EN		BIT(5)
>  #define LTC2991_V7_V8_DIFF_EN		BIT(4)
> -#define LTC2991_V5_V6_FILT_EN		BIT(7)
> -#define LTC2991_V5_V6_TEMP_EN		BIT(5)
> -#define LTC2991_V5_V6_DIFF_EN		BIT(4)
> +#define LTC2991_V5_V6_FILT_EN		BIT(3)
> +#define LTC2991_V5_V6_TEMP_EN		BIT(1)
> +#define LTC2991_V5_V6_DIFF_EN		BIT(0)
>  
>  #define LTC2991_REPEAT_ACQ_EN		BIT(4)
>  #define LTC2991_T_INT_FILT_EN		BIT(3)

