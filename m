Return-Path: <linux-kernel+bounces-196046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D18D5676
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACBD1C21998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA8E17B418;
	Thu, 30 May 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8RAdDzQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4C155340
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112811; cv=none; b=YoB3suyOH0fTNWpkLi1KRwUbDkCHXbuLaRvWhBKkQ6Txxn/yDmzCNaLCKsVeapZrvwXarjEn6AaiOb0IIB7W6WJ/vDFY2DFX1loeJdbKpEWfFqilIhENl20iwqAkiQkBV59T60taWQq3jj0qbw6FhE83/b7lc+gMbZB1dTZny+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112811; c=relaxed/simple;
	bh=OiDFUSZKxT6Rif882GoUplx7qTXswfn4VKAvqojFb1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7R7nzg+zx1vevYE7SwSPm9fMiEtkYr6fOrfxVD0hYUMw9y66i4tB+3lsgLPBw1KZPmkYRmS+k78CuLkAUB6/pZg5qcjMDwLrkDHBeXLPER2tW9DybT32gAZcDCbyK1a7eWFznAmgvJw+tPOKIBydjHiJdlISButKQkIvAxnask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z8RAdDzQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52aea6067c8so1751192e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717112807; x=1717717607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqYhTWdc3i8Fdgb0yK5b8TAAsu46Db3dQq9MJYvwFsU=;
        b=z8RAdDzQYjTKOW1yiOfpgLfPzkPuAY+6WcIL1UI4eR1zjE3GjlGMN8gEZCThb36aXl
         gwc9llnW8J/ebI3Ji8IwrgVP1HEeR46FIyrtuguF54x7U6k9Ejs+8Hv6KvNnX4qjC7Zn
         /SxWHEzUFuYppi+YGhCB+mPOFHPACSWqpPwZkgNNYY6pLDtneB0g54Le96JAbW5xzSLL
         lMiScW83EjA57lxATLbWNziuKT/t5TfVhAebILjqmcGoU6GvhW2zxa0f10XoYwKV7wcU
         waoETErsMUlrI4iUtVYKUieY0ZHU7RHxPB3lvnlcFFMMc0rB1IPxt2w8u92DeRJSj+3r
         82SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112807; x=1717717607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqYhTWdc3i8Fdgb0yK5b8TAAsu46Db3dQq9MJYvwFsU=;
        b=ehXhPXYa5I1vruM9bzIKfmpcS46BUy2LQnpv8KQ8/+ohD74Ier7iC63ARosabqWAzj
         EmidXMBaDJ51ZjBd1IBJ0d7sJYfSNURIyheGjRx6HsRYGVe5TUDN6Dilbno4d5UnY299
         JEOg6viOQRKwxLPm7lDQyU226ok6pmpPujggrb8LK5C94HkduXKXv1vqbwh/Yau0qZHP
         UAi9JTv+v5apJ9pZswLndi9jW0//s2pLtC9q4W92Vrx+VUDqUzEQHEbSqE2YDTuWQhCP
         JvN37xaNfXL8NVh6Qkesmet/uKstC/8ugzI3gPVgjSXc5SHfIu46kmEQO7wtqo3DVRkY
         FiOg==
X-Forwarded-Encrypted: i=1; AJvYcCUWr3WkkYABLljHc8+XMD7+UjCfaCZIA58OYz/UALalFa6pypFcfY1SSk8HAlAdkmLfCpV2nJYkq4/qSs+blvbmCKwZmUuXIn/Ru2E1
X-Gm-Message-State: AOJu0YweVUWePQGOq6FndVUjtJuDhzCt3M3GCVY+UqBVqgQhsA/DsF9v
	eQcUzjIyuGvX26XS235dvx/2OOHBrB2x4FLrLMOLZ0KBrVPVp8vwhUtMfbRZoWM=
X-Google-Smtp-Source: AGHT+IEG2iIZJLnA0cuElEgPD3AlHlvdKnp3M8PivTQOeWaa45z4wPM8eL5Ju+bWjaTJPQS6xJnDdg==
X-Received: by 2002:a19:a416:0:b0:52b:87e6:ec9 with SMTP id 2adb3069b0e04-52b8970bf3emr51110e87.53.1717112807437;
        Thu, 30 May 2024 16:46:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d894c3sm127070e87.249.2024.05.30.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:46:47 -0700 (PDT)
Date: Fri, 31 May 2024 02:46:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v3 7/9] misc: fastrpc: Restrict untrusted app to attach
 to privileged PD
Message-ID: <m6wt2nvxjdyll3wg2hlfyixwtcjag4nucsgriygytpisathlsw@ba4avjyceqo6>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-8-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-8-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:25PM +0530, Ekansh Gupta wrote:
> Untrusted application with access to only non-secure fastrpc device
> node can attach to root_pd or static PDs if it can make the respective
> init request. This can cause problems as the untrusted application
> can send bad requests to root_pd or static PDs. Add changes to reject
> attach to privileged PDs if the request is being made using non-secure
> fastrpc device node.
> 
> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

