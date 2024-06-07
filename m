Return-Path: <linux-kernel+bounces-205875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8169001A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65AF1C2201C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7D187332;
	Fri,  7 Jun 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRmqhjnM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCD12FB01
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758598; cv=none; b=Z7Do1SKa+TVgorFSwYavuxb7+toGA328UaqO57iBnS3wzHOwWLxVnTSp6kd+P1NV6h9kZ5rkt4vaaMHaf+ndE9s7hrQPHla2ev+CnliqsyJrjKDW07uISOr64iMD6Bl/vQ2zAtYnhDsMz3Gi6rSVtIRjvd1shyoKbReQkx758nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758598; c=relaxed/simple;
	bh=2s+vNe+NC540niTbCBQoyezTvds9Adxb5/AvJsmRrRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkECY4jcXyGqlBJRVSavtwl/FjICxI97gH7ifgPqG9uR4iE8rsK+Jh1Sp43TVn8RCbe2iwKdXx83SO287Q9Vdp2L/l1sD56w++GUBicZqA4U3VG2vkcV4bNreXmpTqevlYHK7bV9IWQyubLLBlRp+hGqAF3W11vNFCzmx7ChZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRmqhjnM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so584452e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717758595; x=1718363395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHk9aGALaz9Q3JxQm1gAo8N0FIFK48iZOZz5oLhoQ/8=;
        b=dRmqhjnMjso55n2K0b3YtfuD7tfFmjP4Ptf3XTbGHZWgyZEo7ZJeeGQmlKkY16yoeP
         2ohAZyoNNSW20mK8mQ9zj9KQBnWLCbw+/fxNclbJ69IXyu3H/WWtAzzGvDbyNrkLUQQc
         yRt1rzgdEtIbegEO2i8AoTl1HOB4ti+pFhQl+0hzyPcwsHvZb351Om4PWXRCfuksowSQ
         q0hcjGLNGqwvOfdAa1ZSJAnUu5aIr/QHIxo03cXZtw5UAjoCBFE3XGfNdgOWbroRz+7p
         5ZZ5DOneDBrq/azZpbLZPRMGVETQxixEPDTG+/hV2A8cQppFjDomou8YIv9u2n7a+4u5
         Dmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758595; x=1718363395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHk9aGALaz9Q3JxQm1gAo8N0FIFK48iZOZz5oLhoQ/8=;
        b=M30QqJ7r55TCkFoF2TpimnvbUPmg/4HF0YncrVcswIjA5GaqK7Kt+tFG5sXMRPSdgq
         LNcxOTChYF9XYJWDY4CuKHG5GocghzmuSQzcsKG+57f/udcurELwldYhw/J0Uqt6V3y4
         lwuw7nEfRiFTeV8EwwhWzrsxxYwqn6Bh5gUuRgITSTvwbywuQEHZF5fDs9ldHuEkkHSJ
         PEP+zM2SFZ2bD7geKkCmDQMPjOfuxzeQ4WWW+pM1LAVKih/U57kVT/GaIoFt+D9gfldB
         dtzhPtyjE0OYtL/ZkwJKAptfqqSc8fU7rxWyTRuPKcl7SDnr/zIthqisc9OG2+qbUp0h
         IkFw==
X-Forwarded-Encrypted: i=1; AJvYcCWnkq5RudeTvUKOrFrag70BWnLdbMgKOWsuR3nCmP8QOaAq/23i8gkEANSfgtYo9uqx1pBYli9uYszTzfqGNVmxZHgMBZt74iTKKFxq
X-Gm-Message-State: AOJu0YylFr+J0L5P1d3s3e8NMEv5Rk4xyyhzCE48Em8kQKQqAinyDnLd
	ceNCJZ5HkalYAAh1Zt6X0DEmwsS1Fa4izrvYIU4d0eu9nqNdHIjJL4UUzHlqzMA=
X-Google-Smtp-Source: AGHT+IEV2XL4wfG2eJt3B8DwvhvpZOVo91wEFagblMI9qHFgbABj7r9Ludjl+CykmiLhNq9OWyd1vQ==
X-Received: by 2002:a05:6512:201a:b0:52b:851d:4db6 with SMTP id 2adb3069b0e04-52bb9f7ad1cmr1531577e87.26.1717758595074;
        Fri, 07 Jun 2024 04:09:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1a23sm497630e87.56.2024.06.07.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:09:54 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:09:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v4 03/11] misc: fastrpc: Copy the complete capability
 structure to user
Message-ID: <trd6fbmxdxsrbxs5t4d4zwiwf2jgws23yb23dlmq2lke3ewxw6@myclylveg2gq>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-4-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-4-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:23PM +0530, Ekansh Gupta wrote:
> User is passing capability ioctl structure(argp) to get DSP
> capabilities. This argp is copied to a local structure to get domain
> and attribute_id information. After getting the capability, only
> capability value is getting copied to user argp which will not be
> useful if the use is trying to get the capability by checking the
> capability member of fastrpc_ioctl_capability structure. Add changes
> to copy the complete capability structure so that user can get the
> capability value from the expected member of the structure.

Nit: s/Add changes to copy/Copy/


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


-- 
With best wishes
Dmitry

