Return-Path: <linux-kernel+bounces-568398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DACA694D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51F57ADDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39D1DF73E;
	Wed, 19 Mar 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIaJ3u5m"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3161361
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401580; cv=none; b=YpvsgEw9SdAIc9j9s1WvRH6rfcW0x2LS0rXJfj+RFMvT8wEyBuKsPjCJaGHJnyYewami0jGx7npo9XhxZyatLJ7OwyQVOu6AXJuG51yT55OBX4WzTsIxdG113uGQ/ZGVijSGdwQSZYblMXwUQlRXzgDE0HC35SOYBtumJXwZmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401580; c=relaxed/simple;
	bh=OCRQp5fr35CFrlhuhI4lN2VNPjl3NAmAnOq3UyC7mHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSihoZ27QUhIELIOwR6nIEKEItrFot3jmJmTAVBXcuxr1eBHCqkDTqhBvmCtvX1vJ7u/hOw2yZGPNjJ/S4id04jeciSokNf41EPY0DWVwzRdA81SOulc++mIBJLsxFBGBYHfKC5w9VVWc2JKKZ7FzQQK+TMDsKylnwxTIS4LPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SIaJ3u5m; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so6305894f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742401574; x=1743006374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JH33TulQ7AeLBSliw6W1zrkQlKT21gkjpSn+Pjq8u+M=;
        b=SIaJ3u5mbLCMwdSPc3ktMvzsO6SEWHYlG4D6zBwFR7XRm5jd49XdKkGLizJ47IWeq+
         OjOJ8Vi32Ex/CRCIQCF+JBkuyS9qzxr3ka34w2AhkCvFUme2yRGNXau+h9CTMtaticzv
         rSkv1kGoT/SmXT/5GMSpfWdAEwKdotV8mDwLMwqjZ6/afN04VmxEECHYKM/9h0HoGukm
         KG5oqCYfemKF/HSfdaZ1j6yoLwmCiNI13t62iDRHH9QFZNeyt85+WbZ+9L06Kj7NfxBG
         rVzn1dQYP+AlZ+ocofeE6lt5VIlaytd5faOO5Zjof9LnHBI/9zLtrkojioGdqGMgfoOo
         5Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401574; x=1743006374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH33TulQ7AeLBSliw6W1zrkQlKT21gkjpSn+Pjq8u+M=;
        b=LY2aHvxCvTaC5EGHoA9NlnEdbtHbouLjekIFmf96T/FaPb/pDjufT5dtRV7nzwPtMe
         h+TspEegvMh/WAs4DT55+vC1iFzrD4DE99kAHd/hpL9e6C5P5Fnett3tQ4gUTMf/YN0Q
         Au318pyPmNPzbw0SMeRh3XacIOWSs/gOTJI/yIbVxKzFK+TEwXC57zulLXIT28XyBrgK
         lEButEuDfR3sw+9Sq39enmTfcYhc3MapXT1RqD+nioLRI6PRIWdzrxGKMQL3CvNGnU4Q
         UJ9IFpEWiabpM3lCU87Zx+n8Dun+sFaL1r2A2jRLDctvhAaGli3On/bBC8x2tkLfGzsf
         QXBg==
X-Forwarded-Encrypted: i=1; AJvYcCWC7QgCyQewMx7N/vF3fBm6c/xyrDgJklWK6qbUUtDltKd7wvFCeFfRott3E3OPJ3Q0hfNWlqCB4nxl74U=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWV5jGZAGJvomTj+8D/gO4Ft4yiFdBFdXA3UfAH78seXw5DFX
	gKnBoT3lyzKPhtJZU/ksrAxQD8GyPEazzmUhRGfaQFfuttSVyR9LuhefEwgrI0w=
X-Gm-Gg: ASbGncvRMXDEQWuFe6xYJM1GCll/AI/eA3JNMi8nyF6v70ea9Nh2B7k75S7tErAQwjM
	dWGGNyxjCHrJuUgqYCqR5ID8yX+uD2yJJizg4DyEL812g980x9V4Fj6G2msqPc5KgSDLISG5PJs
	/f5EeGymOmjFvPNhXm51YTR7yUsqkF7NGD2Lhbcy+iXrqixOGmOip2YUX77SZgJYum99sRYTWMs
	VZnPE67G/u250s40Z02KQVyYmUIGEJCrQKztEHQ1PhujdCKpE1IcyH5EHeP0U4pRxhorkRjFF7t
	lVIM4F7FhQTozi5kbsqMCE1sSLsvilVI5ceAF858s1KNQEO6wg==
X-Google-Smtp-Source: AGHT+IGP+Hvtg5qVl/vhr+M/j+W1mAMAMQUY9wQh9XWtXxPXI2OEgW0J0m0Nwh+n2rhGuKNS2CTXAw==
X-Received: by 2002:a5d:59ae:0:b0:398:9e96:e798 with SMTP id ffacd0b85a97d-399795a8cb5mr149770f8f.13.1742401574434;
        Wed, 19 Mar 2025 09:26:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f32fcdsm23697435e9.7.2025.03.19.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:26:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 19:26:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] pds_fwctl: Fix a NULL vs IS_ERR() check in
 pdsfc_validate_rpc()
Message-ID: <f391dc76-946f-45c2-af81-a5cb107ec783@stanley.mountain>
References: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
 <b9f49f34-1a69-41bc-8324-2e969e53f9eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f49f34-1a69-41bc-8324-2e969e53f9eb@amd.com>

On Wed, Mar 19, 2025 at 09:18:31AM -0700, Nelson, Shannon wrote:
> On 3/19/2025 12:06 AM, Dan Carpenter wrote:
> > 
> > The pdsfc_get_operations() function returns error pointers, it doesn't
> > return NULL.  However, the "ep_info->operations" pointer should be set
> > to either a valid pointer or NULL because the rest of the driver checks
> > for that.
> > 
> > Fixes: 804294d75ac5 ("pds_fwctl: add rpc and query support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Hi Dan, thanks for this patch.  We also have this same fix in the patchset
> update that I was expecting to push out today, but you beat me to it.
> 
> Shall I continue with our v4 patchset, or should I now be sending smaller
> patches to update from earlier review comments?
> 

I don't track how these things are merged.  If you were going to fix
it in a v4 patchset then just ignore this patch.  Typically in that
case you would fold the fix into the patchset anyway.

regards,
dan carpenter


