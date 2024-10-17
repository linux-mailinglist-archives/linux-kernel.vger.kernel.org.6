Return-Path: <linux-kernel+bounces-370469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF19A2D18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C24828268C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960421D2A2;
	Thu, 17 Oct 2024 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prNlhw7K"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687421D17C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191730; cv=none; b=GxbNXenFqRnj085GYC70mYWxkYD9c18afv5faFMStWK95PQhepip1mcb3HMou4q+zJsoeSuo3xFgxvR6SIxjLAPwnihqvZNCpNd/x7EDukXD/zDe+yaFO5rZXjXVspON1fSZznkzWniwGBpplWSDxCIUGECoASeBqBm1MJzaErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191730; c=relaxed/simple;
	bh=FGcr0cwAInpg10pH93HSLy8OkgluyazJE1YUDfSja2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbNhq2JB+yluNlIGnS+Pkx0R6MYCozU5/MwhGlMMIZklffhlIpdHVI/D86CXtCfJNXWmdiicfU3BrH+/D8xvAwg7mPUPxg5WVryq36FkIwUNoTEMmRG7MJXycrT1dY/AWe23ryZTNARaGCxu7xbXDoNqHbpALG1r6sV8Q7mHHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prNlhw7K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so1728647a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729191724; x=1729796524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yX7D72bYtA7nFMel8yCm1VLTz+d+DFr1g1il/QVdnM4=;
        b=prNlhw7K/4kcnHaz4xrXPyEhXbaSbhpTcybYhp9W28bsxWgFclOCpvHktQ0Sk3YL1d
         KTU5E7S4FHgbvCFAumR5xCtFbqsr4IeXcX96nrBS/XX2myjkQroWF0f2UA5tTBB0wJXZ
         kkbSwWhmr0CR04AoWSlZWTU+zVNAOtBJB+IzBv3wU9RgyxDw3VN1H0VTXLge/6Jp+x26
         6L6jlcaC3cY6g2nr4f0eGrhJcef7avHpOfwpj3Jrt2Kn35xx8RINvM+H275YxujEcVkT
         bguVFCFCyF2xSzKQvQPtSjwTb+op5eD7RK8yiKYAPdNmR7sHALlrBcqCW/iAk60a/aeH
         F96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191724; x=1729796524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX7D72bYtA7nFMel8yCm1VLTz+d+DFr1g1il/QVdnM4=;
        b=L31JL2pM5xOiuZD743urIJ8iq6+z+M89wuQhSufpVv1cu8e9y/kimHQdXFFZV8dVib
         U2AAkTojNL8JYir2iwvb6dC94q6wryKXECoXsuEXpt5jQyRVC7kcZkmVDK5NcrLif5NF
         zCUckZ63W9g5DjWVK7yPvtucDTVf/RbhPqeQgdG8X1O+SQREzUiAdSbwi0tSFKlxrhaj
         KVNEcU2OksUx2DZ7AjIavfrSZjjKDYn892PnZiNZi+VcOOXpoZ7oC6EwtB1S+SE6gmXo
         eZedrDOpPBJhMjA6eC224lIeHL6b9EHNZa5Tpda/+5uRtV++Rl0FyKTC+ELD33l1ow7X
         apAw==
X-Forwarded-Encrypted: i=1; AJvYcCVsN+FRGeWwl1KxcBHMNoc8GVafE/0tE7CzAVBt2NPXSctJCwNVrVnxM+1MxkKQ9Iq9cZg8jZKZgA/2qq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBbQqCskNB5Unuwmaj3pQ9sEKMgwkKB1zthgi6sEEHKEF0Sjk
	Tu8sugfCyu//0SG4c7vywmNTbEDYFaJsOOQJT9cIokBYYTIWANtfbZkI07zG3Tg=
X-Google-Smtp-Source: AGHT+IEJBN0gq8BBhf6ABCGKugevTMmyCj5PVHfkHmf7ahmoy9bjp/wSlLak2Plc9KTCjs74F9EVww==
X-Received: by 2002:a05:6402:3512:b0:5c9:40e6:24e with SMTP id 4fb4d7f45d1cf-5c95ac4175emr14627651a12.28.1729191723962;
        Thu, 17 Oct 2024 12:02:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d779975sm2984259a12.67.2024.10.17.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:02:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:02:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Change return type and error code of
 fluke_get_dma_residue
Message-ID: <5bdbffc5-068b-494a-a44b-f9586bf28f6c@stanley.mountain>
References: <20241017092511.17621-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017092511.17621-1-everestkc@everestkc.com.np>

On Thu, Oct 17, 2024 at 03:25:10AM -0600, Everest K.C. wrote:
> fluke_get_dma_residue() returns unsigned int with -1 as error code.
> This error cannot be caught.
> Fix this by changing the return type of the function to int and 
> returning the error code, that was captured. Also, change the data 
> type of variable residue to int in the function fluke_dma_read().
> 
> Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
> V1 -> V2: - Fixed the caller
> 	  - Updated the changelog
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


