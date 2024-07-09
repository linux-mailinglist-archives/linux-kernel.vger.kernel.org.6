Return-Path: <linux-kernel+bounces-245093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98292AE24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C5C2832FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294F13D966;
	Tue,  9 Jul 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1AsZW9L"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAB2C1AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491711; cv=none; b=qiGeY8jGFebJdpAyi7S0edE3fZN5W3OrAWNo3ynqqe3bANJoGllZ6aTbcOGHnVc29rqu4QtcalColEO+CxAlVNJu2guORvZvGhTE1KJRGFnqbCGpQezPcmI8VDLoJSj3YRcTs8/7Ljwk2v88PBjtU178w0a7Ncz3vLWHyGn0HCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491711; c=relaxed/simple;
	bh=mb2SlGBuqH1DdHlykK+ZYm353mpVy9r5d1XRqy7aBHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbnhKMLnAMBdKMtdepdLim7qe9awZ4QBmlxZd2rMMOWiznP6Wm1JhFVlmS72lmdswxXOWLh5ALlSGwYY+Twn2KYFj2XWWsZ1IYbXl2W0YXreX1IzrqDOdDDamYSHPbMLruEwzQHQOb+rAC4bA8qhRdRSzyqEj07pHTe1p1PUIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1AsZW9L; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70365f905b6so1239295a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720491709; x=1721096509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0SZHheiIh3CaiK0vmOhEvuBvuABlqSEKkJyZwRobjk=;
        b=n1AsZW9LFCLKqtyqTez+r085trf7ZsVyLjQx1hVAZHX0o3Ilrt+o80wnsPXCh3gQIG
         2gGbC4OM4UbUb7ceerECMkaECM6IA8Kd37Uw4Dq50RmruRmNvSqwtFxZuTbGC8enNUG4
         g4hQyLalF+I8jz99uP5i6Gt724+B3wgZmI3K2WIVdVDTCFXUGT77z2KPcuBp3SZL5Kax
         rQFowAH6SnC1MoGf4dWivOh3OxMrQ2gLWcxk1rHDjEYfebPS794RojlVZvgQukdUZLAJ
         P4FXmPtlEqQ59xaRMtMzvlWMmDfZLPFlZA87I4hreKkFyx2tIyNCQ6UXDDU431TuXD0e
         8a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720491709; x=1721096509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0SZHheiIh3CaiK0vmOhEvuBvuABlqSEKkJyZwRobjk=;
        b=mY3wcMhjUeKcYKGAI0jVpzAyHQeBa30AtesyF1uETZS1EQ2ndyXW2xguCWwkAA0Xfy
         LcjEB/Ok6/tA3ju2b6FG16U1TW6DtAcER1+sRUYo8/9D7ufYR7ShanyeXLcm57FEyeU6
         BK3BSzCJ9uj8jUmnYwtA1My2ErQfEEQiccYwnK/cP4x2wHJlrafYdtM6USAsiC+3g0oH
         Z1759muWnr2LBmZbGAVnUlqm91o1xs4LwG45qIrNNZMVBpbA3EB946mBW5X5AphQke/B
         isUX7YHQ5aqBMIUOJFHqKwiRI5mlMWWQdzFlKRx0cdr0dUES74lYq56VtQDBWV0FJDmo
         9SAg==
X-Gm-Message-State: AOJu0Ywq4Qnyr2ml0gi6KBpFtS7KLQy5vA4BLXEDvY3CoNYA4oGsEXi3
	2CvCWMaXLlKDyEqFdv5gp9soWOBms6H/W1SNe/tblEdRLmKknYmi8+V0vXzI8dc=
X-Google-Smtp-Source: AGHT+IHvYAtQB08P6g/Oh3FOe0r2RmDoDiah97BAImqRrExYxVY6UJ5Y/508gac0uZpn8tf1lwY+jw==
X-Received: by 2002:a05:6830:12ce:b0:701:b765:ad75 with SMTP id 46e09a7af769-70375b3e5cemr1364388a34.33.1720491708906;
        Mon, 08 Jul 2024 19:21:48 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:fba2:d517:40c4:5a42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fcd0b4sm252746a34.66.2024.07.08.19.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 19:21:48 -0700 (PDT)
Date: Tue, 9 Jul 2024 04:21:46 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH 6/8] firmware: arm_scmi: Make OPTEE transport a
 standalone driver
Message-ID: <e27dc456-33bc-450e-8e54-1cd5b7ae11ef@suswa.mountain>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-7-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707002055.1835121-7-cristian.marussi@arm.com>

On Sun, Jul 07, 2024 at 01:20:53AM +0100, Cristian Marussi wrote:
>  static int scmi_optee_service_probe(struct device *dev)
>  {
>  	struct scmi_optee_agent *agent;
> @@ -555,7 +553,7 @@ static int scmi_optee_service_probe(struct device *dev)
>  	smp_mb();
>  	scmi_optee_private = agent;
>  
> -	return 0;
> +	return platform_driver_register(&scmi_optee_driver);

There needs to be some cleanup if platform_driver_register() fails.

>  
>  err:
>  	tee_client_close_context(tee_ctx);

regards,
dan carpenter

