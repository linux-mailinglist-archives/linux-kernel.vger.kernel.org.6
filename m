Return-Path: <linux-kernel+bounces-353366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ECF992CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D0B1C22AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB971D358D;
	Mon,  7 Oct 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsYWyrPL"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395E1D2796
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307006; cv=none; b=SxTMd16SdZlR/WMTbiO6XA1VflzLfs3gVJshxOwNp6UUa511QH+nX4Ko+HmI9CXkI5YS2vREskzT5NATKt1pNXU5BYTlDg7y7mmemti2inEyyGIkYaQwkravn4x++93U/cRxq4Vhue3tF20WaAcssmYDZsV2Yszs/Badp7Ck0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307006; c=relaxed/simple;
	bh=c5zDZczpwoMhRCZTtD9TIprKTL2qFUSJSp44forXD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlJl518w4GkFz1ev07itibWpaVKNRnvWnA6A8dNzu9CwhOJrg5c969IPAJgOfWbio34gAoPgceBu7E3dyBXkUlz89cZjZcvE/9KiC6OfoOHMmBE4UU94YYJVHGey7zfEid91XZSnLEg70twtbwm6sZnTWusJwnf+EdRbbEnysmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsYWyrPL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso47227651fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728307003; x=1728911803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCkBQA8INoWSpGqbgwA5jt6QuY5LVXtR8ZQ0xgygGF0=;
        b=XsYWyrPLB/p0aPFooLUEtc502zzKNuzHHLlWwRFYySERoH9B4VacYJFPm2CPi11PYz
         RAowKOf7d+pQ76NorSvFjMj1qt0BCLntyFWfJWHJKPrEzxax9vSFkFTNlRiCbX9RoXKn
         emTPYtd6bYsFNb+XpBv7koqh+Y0sa4aqmZrVkT+4zggJJ2YHXXsgf7vUHHoYnRphh5A6
         rLzgASx0PEBsLk8JRdSCFxNfGKirBp+CObYCMQWSwPYddvGMpmEdgEi+kQoNDyZqwXca
         5fg7iKCJW9lkY5F3SJr2au21W7HtVU+kUAnzcgUbC+u3EcbA3zHwLn0mBUHZAHugAsXe
         XG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307003; x=1728911803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCkBQA8INoWSpGqbgwA5jt6QuY5LVXtR8ZQ0xgygGF0=;
        b=Su0F1+cPshneLlgz8dNx3aKxlpC33SFJtjcRoovZG8UcYv8wXamFZzyVRSvUOXO2wv
         RPg4laArxPoPhaBpWEWtsHr3FyTDORZJ5ZCnuw8rwNNFA3dESARo1oqE/swoJdgb3SOu
         A8fwuW/jC+0F6hmErtXcIxGD4j3oDj7MJWJUE3Swq+O/WO3OTDzxtZPMpFQurg8cTrwk
         XLxQqXSRbu03adH5MrH8SpaSQcatTxak8LuO4EIDT8ZX/+5yk9Lyp3W+VyWINIM3OVcR
         VEN1q/QILnIjaN7MxBTtsWUM45Yfxi8zRlnQ9PopQjSJ027zA/sKGXeHN2AyWG6iYir8
         h2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6f9GQFmybvrFI1GmGMezRBlHWj44vWogmL/AatHeiM8cUgWSNbNtYaWHx9DczkKo1dlANXcto0Hk+X1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRCGZNMrpt0gjerKaN03RpvCtDyylLR2SVj7ZkbaYks3wdVzQ
	iEDT1uWhTdxaxwIkSlFZYht8GJeJzsA4YiJ+p+VAwRlmKYddG8ycuhihCnfoJEg=
X-Google-Smtp-Source: AGHT+IGZ1mDDEjhcmG+T6pvJMY5EAIlF8UJwKfOkVTjp4MAKBG18DAhtjPcfQoU7T5moxF77LIIMQQ==
X-Received: by 2002:a05:651c:556:b0:2fa:d58d:dcf3 with SMTP id 38308e7fff4ca-2faf3d9d58emr49272581fa.33.1728307002704;
        Mon, 07 Oct 2024 06:16:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b24867sm8453081fa.73.2024.10.07.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:16:41 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:16:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
	Arun Kumar Neelakantam <quic_aneela@quicinc.com>, 
	"open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: use only lower 16-bits of param2 for
 CMD_OPEN name length
Message-ID: <rmybaobbmhmynz3or4uwvhdgqjrkahmkwz5ncct6rssnfpq4jh@ulqeqesixyhz>
References: <20241007044723.25347-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044723.25347-1-jonathan@marek.ca>

On Mon, Oct 07, 2024 at 12:47:22AM GMT, Jonathan Marek wrote:
> The name len field of the CMD_OPEN packet is only 16-bits and the upper
> 16-bits of "param2" are a different field, which can be nonzero in certain
> situations, and CMD_OPEN packets can be unexpectedly dropped because of
> this.

Any idea about the upper 16 bits? Should we care about that data too?

> 
> Fix this by masking out the upper 16 bits of param2.
> 
> (the commit in this Fixes tag is not where the original code was introduced
> but it should be far back enough not to matter)

Let's be more precise:

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")

> 
> Fixes: 835764ddd9af ("rpmsg: glink: Move the common glink protocol implementation to glink_native.c")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 0b2f290069080..e4933b823238c 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1204,7 +1204,7 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
>  			ret = qcom_glink_rx_open_ack(glink, param1);
>  			break;
>  		case GLINK_CMD_OPEN:
> -			ret = qcom_glink_rx_defer(glink, param2);
> +			ret = qcom_glink_rx_defer(glink, param2 & 0xffff);
>  			break;
>  		case GLINK_CMD_TX_DATA:
>  		case GLINK_CMD_TX_DATA_CONT:
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

