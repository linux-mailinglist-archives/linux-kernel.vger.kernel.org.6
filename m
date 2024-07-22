Return-Path: <linux-kernel+bounces-258652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD832938B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39315B2172E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA0168483;
	Mon, 22 Jul 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTSaiOTJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38388166313
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636770; cv=none; b=cCCMxiuPPPkq2sS1p85Malu858xDS+WtTWhTQ4aRdX3ak16Mvme/KpYwYBIc8ig/rmOkmxN5orPEMTe/ggpaf9mGP8CqiEGiKk461itsyb9o9TzX1PZZJI2+pTttoLE98ognlKr4sqvcEuUnqeUpFmt6tEBFQ0YvW4mq70Ze4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636770; c=relaxed/simple;
	bh=WDQIfVnLd8fIqE9ri/4/kOqwvCB3ulDotF7mjDnGHyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4jwcu0V5pRlS1BZqfWjXAQIW7xD9745LcC5VOZQdNlaGod5fdP1CDneqTDoTyovTo4CMW5RdRn7CwN6AGIAjPdQTkrYqnrMtBKJ4RJm8d8UhbZtdIp3K2+P5ZeZyyvrfpkI+qP/AUybq1VM6x/n+CIs5TfIp/NMSIco6R1OTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTSaiOTJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c29588so680708e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721636767; x=1722241567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i59AQP++/YRGTPfGm6YkbyUGnPVvAGTVEhOYab+5TA=;
        b=lTSaiOTJt2eFjmCNu3BWx/XeomoXPUKFMjNVCCqDR7DPHxABpXO/gPSTpcYopdl3YN
         GQFnUrNpgaSF+rfDZ0r0svBXwtcqTMFmgLbh+KVFGg6Nchd1/mxs/WlEmYXuDZQIxajB
         RJfFa3Ac8ORNsuU6r4iVXZrJ/07wTyFij+BItwvQHiwJgXPko3nGdaWE79AafEifaJ1K
         ALr4SmhVcvnzs6V0MYk0ue0wDx4YmGmZdP3w6q+yIrtDhSibV/W/LyE6OuUbY8tCWl+m
         MLkrD1hx1ZK1Yzsrcrc4DhN2WWquZTLopMaKhJEWkVNW4ajD9KbHjfU3ktsJiVRAKUEy
         v8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721636767; x=1722241567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i59AQP++/YRGTPfGm6YkbyUGnPVvAGTVEhOYab+5TA=;
        b=ETEXVNaFOAwC/yCm7m+md/UlYOgP0STSPeZonOggxUrmMewUZEISbUZL5lU7grFwGy
         eiKV0Q4QUG8JnA5un1jPSw8ZrW5R47Mp+XEIyLpg9TTIJZcjMvbdnq2E6Hlhb7PKzY46
         7AmpxDCrivehBNnHUOe1vcNOnGTNYLWVd5hjeICjwzEys4voJ5W+JZL1vyVpRdGrsWq8
         9ttmQhSsOP97oMJs9oUqKP/mCY5fXSc5dBCkfQMZc+wNgpGgH1F3gBk5rh6mwSZxKEnM
         BfM+SH1Qr+HMgEAl7Jjn9qhAuW08lVWyNg36Hpo95p+9rQggeLHigMO6n+XaY07p5tqi
         Bm+A==
X-Forwarded-Encrypted: i=1; AJvYcCXILexXfwJVU6CZ5sWehKQQGZbPsaQqSClykrXcUftpeMV3iSzcDgBEc7QYaegPQnMdyh3BpWyR9fB8mGgegRxyRp6nuDFkT9X/gE7b
X-Gm-Message-State: AOJu0YyYR+hIcXnmHJPIm942e4NrH95fAB9HrkbCYq1Hd+i6amJAKLZ5
	+l4qaFpFG5p5VuCxB/97Icb67zrn25CGE7od9BOWtUVI9m0K23IhBLjqo/HY0lQ=
X-Google-Smtp-Source: AGHT+IGjp1w8oxUvbHbWkFg1OXnsIAY0YlwajfiBz5xRohJSi7smqlVbkyJAJWclepJZZfm7iVRypw==
X-Received: by 2002:a05:6512:2392:b0:52c:88d7:ae31 with SMTP id 2adb3069b0e04-52efb89cfabmr3853544e87.48.1721636767397;
        Mon, 22 Jul 2024 01:26:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f041e0bd6sm282010e87.198.2024.07.22.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:26:07 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:26:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v6 0/2] Fix user PD inimem requirements
Message-ID: <bob3pkwyu7g3qf4q546uittggzfywc6o5h7b73isx4lijsfj4j@h3uqpaevawgg>
References: <20240722080200.3530850-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722080200.3530850-1-quic_ekangupt@quicinc.com>

On Mon, Jul 22, 2024 at 01:31:58PM GMT, Ekansh Gupta wrote:
> This patch series fixes the incorrect initmem size assumptions for
> signed and unsigned user PD.
> Previous single patch[v4]: https://lore.kernel.org/all/20240719085708.1764952-1-quic_ekangupt@quicinc.com/
> 
> Changes in v2:
>   - Modified commit text.
>   - Removed size check instead of updating max file size.
> Changes in v3:
>   - Added bound check again with a higher max size definition.
>   - Modified commit text accordingly.
> Changes in v4:
>   - Defined new initmem specific MACROs.
>   - Adding extra memory for unsigned PD.
>   - Added comment suggesting the reason for this change.
>   - Modified commit text.
> Changes in v5:
>   - Splitted the change into separate patches.
> Changes in v6:
>   - Changed Unsigned extra length macro name.
>   - Add comment in proper format.

Please allow reviewers to finish with the previous iteration first. The
usual recommendation is to send new iteration once per 24h timeframe.

> 
> Ekansh Gupta (2):
>   misc: fastrpc: Define a new initmem size for user PD
>   misc: fastrpc: Increase unsigned PD initmem size
> 
>  drivers/misc/fastrpc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

