Return-Path: <linux-kernel+bounces-239310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F19259D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB73F1C22A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889F17B51E;
	Wed,  3 Jul 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5eobs/7"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE017B512
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003344; cv=none; b=mB+cOCtfne4lIt2zib2tsKRMV6Fh5yv4hQ0r8AwNv2iv9wFL6rxwiNtGd2YlWzVQZY961p76ZZ0NduQF0vFVgCODVzBmpZZFxRokV0Av3MGkWuP9NysAhRoNQ0PLaGQWpfplqYbbNk67RXc8PQ9GtLBVgPkkaAdPSLIJG62vMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003344; c=relaxed/simple;
	bh=+qeav1XYsLy6VqdTKX2WYfgYp1f8/s8aYqZZTA7+cn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzdEHKheZjObDrjPibGIn2nXJbJpxzE4CBuxcu/ZJ91jmA1NYYWn1I1dpwhhSKEO+1pWUXnSdgs7KOYRIjfbXItCeJ7KmzwDsiZ+lgjV6bMtw4QW3m//i2SWzgrt05sCsWD0bSOnuvVeNTtALUxG6MjOMlLS6Hg+0kW1ObYjQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5eobs/7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so71531701fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720003341; x=1720608141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+8jSn1E/yhCSIPYZqegveZ9nuMdvW8tlwjJzbxZ4/s=;
        b=d5eobs/7f8CXThQnfnvM7v2EaEIvWO9yhMfrCjj9Ag1dOGGUbJtP+PQzKKIQcJa37o
         A0niD0G5WwABeQoyvqKH9KYs5RsvDWkmHtIEuRWuZTJNZh3FoclSyHEGE30BkYNG4oaa
         7R8LnBpboTDx9NpqdT00HDyIschPfn38rhWNov9au7d5WS6k1BebgHiQ1/bcpI6skj20
         DXbFjuH93nP/CXisztWNNGIc6CshSEqmugHz483CO+5OOWnepgzEK46D7iWiQWkIeKz/
         rqBsk36lu8ZOjKmlp8EEJWV1hIfR79EY7HuxRF7v+W6FgEL9Tn+cr7+SqVXTOR6e/Zw3
         YULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003341; x=1720608141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+8jSn1E/yhCSIPYZqegveZ9nuMdvW8tlwjJzbxZ4/s=;
        b=Fvb5ell7Mqminee5/DQcUCxlhr0cYO84xe0HZgZ19zsC1LKE9yT+3KLZqzuMNi/jvX
         IChj/Ajw1hPO3eT/hyv6w2GVwqHgqhf0Y1cwNzDaYGF2Cbp5R7XioJjoMXLxcmM/LGW6
         Au/QpaTt5vjJDONwO6gJPyZDJFOYDNsaxaPCphVEUhLZgo/g0d5bucxXZpTtXZ2tJl9s
         q0HS7xn365mfrGg/4kxkkhIN1QbCUHlCbtk00Gb2QBreUnU6hTH/f8XOw7P83u0Fu032
         llFSU/F0uzc1xeyMhn2cTPOLUndgIqSrgWy2bDSiuPv+h0J+F+6o+saVObtwiHieIhvi
         7cCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTweEoh/wqXyKw7jQduw6A+SPR2W/i3oxLbkrjxXY9d+2wwQYIUhNr+PZonUWM5QJCU90o/zZ0PwTMu1ocO802a+pMuFNI2K/xprfI
X-Gm-Message-State: AOJu0YyHgGC2pggSACZ93SSN0qJbHggQkrIUyKuPA2QXqEmQso05J7q8
	18ZxcA8ifhe/2Yekj0BRRexwSESotMLONm2OS4/ZvCnT/TOcYVC4izQjs1hbWXs=
X-Google-Smtp-Source: AGHT+IH6JJtUSo7ojZ35ce20s/r55s3BW08cZO2StT7odZK8FedamUA06n8XsyRQp8517JigUqPkhw==
X-Received: by 2002:a05:6512:1089:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52e8270ade1mr9509495e87.50.1720003338920;
        Wed, 03 Jul 2024 03:42:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bae1sm2081496e87.44.2024.07.03.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:42:18 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:42:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add PM6350 PMIC
Message-ID: <fcqzyi5vtox7fvs2nu67nm6y7bcjoabzosfvbqkj6n4yxaebpw@rneg5o5drkc2>
References: <20240703-socinfo-pm6350-v1-1-e12369af3ed6@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-socinfo-pm6350-v1-1-e12369af3ed6@fairphone.com>

On Wed, Jul 03, 2024 at 09:01:03AM GMT, Luca Weiss wrote:
> Add the ID for the PM6350 PMIC found on e.g. SM7225 Fairphone 4.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/soc/qcom/socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

