Return-Path: <linux-kernel+bounces-251557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0104F930655
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0AA282AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671127442;
	Sat, 13 Jul 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6WoE+Wk"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5481BC40
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720887476; cv=none; b=EY/3MNAwJ4FvI2PPV3pvtbEu9e6pjTpCZdfLPkMtXBb7ZSjXL2zTcNEPlocHxp37S7Wc0XnkgZLmaXfdLToYoevwBt0YzgQwkYFMWigIJguz8a3qI4nYdrL3T9Kq2ahK2jBSkHx3OT7RbN8B1vvTCbvAMJwieSTiXO7gNMOXlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720887476; c=relaxed/simple;
	bh=AVeC6JbOmzV+YDIjEWna8+HTWY6QK+XKaF1NUnwPQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBrh8hwkqkyHFWWBps18TGgVVFS5MRVevNZi8+hFbP2GDEz4rAXUzCK6nfKqNgD6oHf+GY8iqImvfxUljN6lYTqucMJ2rmX4fuS0tQj30ALlj+qcEOcP32Vz3ePEwe5v7pR6iJjR0EYCoAUUovyAEdfin9FGc0q1Hgxmti/nwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6WoE+Wk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so37137071fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720887473; x=1721492273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QzoCCe+bx4WVn8kqtzz55rOaqPsJz+25YrGQnujgus=;
        b=y6WoE+WkO205b36tcQMpLkYZ6Jm4JzojxOVHii5eNtKqhZbsKEsbOcIA61bymwXGuZ
         95OZfzdEG+tZzdyQWniDL2DCCxmKsyqAnQijZEJ116ug1wSXKFZTbIfLexSmgRqsa2sh
         NWM+qvMfXnqHLylS6hdZrDs1N3d9EOheilgwjIVpX4EnOInrUk+VgMVy2oqQXr/CWYYg
         D6wd1cyCrFChbyC3NDqmCD3jZQLlj9o+IxdC7oq4a7oIAE051VFOnh21JUAW91++lMue
         02FdXoE2SSTKG5ABInR5kqKmpORsUf4ixcBnMy9xmzr5F4Npg82o53tBRH9j/IV7orOd
         foCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720887473; x=1721492273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QzoCCe+bx4WVn8kqtzz55rOaqPsJz+25YrGQnujgus=;
        b=N6C5ZrhPmpTseWLeJl8g8aoOBG0u4d3D9uomgD/1PperG6H6TZkRM+AMPyuntdf15a
         QRTvCFyeQGgXAuAeB44/hpoLnx2IrKxXumZRbEnHJ2wVDlZSLcacQpWecaw49JUmjHKv
         xIi2S/rBiMNyUOOFLQbuEmL3+rWbybglFcoGp7cgylEk9DqhSUF6qpPmaXxs/rhKQh9y
         kbDyktIZ7rsAUZnt08LcjGtGLDlvfEGCWQNhuXcqcbgRKt57400w7e2rYM3J5nXHwLiv
         PkAo99dikm+t8kSA1rM/VotRxaSltVO9HZ8vAt62QeojQ67YDWhSETH8XPtm5erLblDx
         mGLA==
X-Forwarded-Encrypted: i=1; AJvYcCXtCJG0y7n3HNJ7PV5HRH1RFQs/BX9mpCrfpet5a8l3Ea56n+pQWJlMYDBnBmKIqa+KNuhTgUvsSG1K9FgLVe6n1TWc2YKo1SA34xh9
X-Gm-Message-State: AOJu0YxHe353NcGCoy4JQ586bAfHFnoSmVJ+5dKMtGo1gArTBWj4/aH5
	PJkN6sqU16leS6vyjMac4frzCmHHkonXPvJb1ntKeOdqNhTa/ghP/6d7KcXZCYM=
X-Google-Smtp-Source: AGHT+IE3TXvkIvufpoqfHUfMHmEf6FFMuThXBRYKg/jFDPHZUd0BIcfLpvL++WIKvIcx1cqmRDNWqQ==
X-Received: by 2002:a2e:9799:0:b0:2ee:dde7:899c with SMTP id 38308e7fff4ca-2eedde78a7emr19466181fa.17.1720887473242;
        Sat, 13 Jul 2024 09:17:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee18bebc5sm2401961fa.66.2024.07.13.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 09:17:52 -0700 (PDT)
Date: Sat, 13 Jul 2024 19:17:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Ignore extra __le32 in info
 payload
Message-ID: <mz6h625ecs4ozmjxoozjdnunfmr3vsdw5yyo6il5vyzknyzqsz@pun3t27zhiv4>
References: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>

On Fri, Jul 12, 2024 at 12:00:03PM GMT, Stephan Gerhold wrote:
> Some newer ADSP firmware versions on X1E80100 report an extra __le32 at the
> end of the battery information request payload, causing qcom_battmgr to
> fail to initialize. Adjust the check to ignore the extra field in the info
> payload so we can support both old and newer firmware versions.
> 
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 46f36dcb185c..a5b5f1251af1 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1007,7 +1007,9 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
>  		battmgr->error = 0;
>  		break;
>  	case BATTMGR_BAT_INFO:
> -		if (payload_len != sizeof(resp->info)) {
> +		/* some firmware versions report an extra __le32 at the end of the payload */

Any useful information in that extra?

> +		if (payload_len != sizeof(resp->info) &&
> +		    payload_len != (sizeof(resp->info) + sizeof(__le32))) {
>  			dev_warn(battmgr->dev,
>  				 "invalid payload length for battery information request: %zd\n",
>  				 payload_len);
> 
> ---
> base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
> change-id: 20240711-x1e80100-battmgr-1eaab3b8f024
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 

-- 
With best wishes
Dmitry

