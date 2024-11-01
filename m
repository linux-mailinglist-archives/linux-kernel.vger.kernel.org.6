Return-Path: <linux-kernel+bounces-392861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFD9B98FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAC11F2173B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BB1D271A;
	Fri,  1 Nov 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="An/Zg9JG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC671D172F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490677; cv=none; b=FnRKtr341rZV+2lKO6shXYbPFQ4MWOniSgbkgTKZkkKWFcEx5OXOWPL19Tkfma6j2jKbpSE/frSEIezxbH7WoO5NtvvKyz9IAOmbCpbW0jm6Ojys7iIaEDBcZqqwEpA3k1QWKfeJfltD+Esd2gH9R5IAqP58PPpXWpACnpHDKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490677; c=relaxed/simple;
	bh=MQtGnxAwsf1JT2gO1pk0zvmIp9n6WmA95Nf/ZTXOBuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDThA06ZrjLHuyjQhq5Te8m/zctCDkazDnzuyu2m2ppsxV2AXFP5fK35W8pdinVlX9miGZD3ltlUjkfr9hIX9HmwtIeXeWt55CljSvwlWijRFt6l/2Q5eqlUY2xIWWRI5hH6XiXKnp80BOzm6iJt5Z/2lshx9C9O+iraEbj+S8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=An/Zg9JG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43163667f0eso19415815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730490674; x=1731095474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubumAp7oHPfClW4j0mKbxq7mn8cLAu98dtVt51dy/BM=;
        b=An/Zg9JGSwdIV0JxGYFBR4IpBvNVjCGfFeeInSzXl1K2aMRGXzpXzirvPgVMuiZ95j
         76t3X1BuVR7O97kRJ3avB3Or4ETp88k+J1hoqGC8UFs9JLqijCWHPWH+PYKE+M0UBagF
         z848CCDjz+n7vOIp0/KWGoMPvUNQ9rLwcDKVW1BhFqIaA8xRcG3hhOWuDUM9yPkrnOY7
         tsl2mlwpMJ/HY9Zg3FFzBf/uYKnxvHcx4AcbkmozawH0QVBHHO+5IcR2Bc+UZdsBrP6/
         oZo1wl11TyRcMPh8seun6qZq1CNygLfeKgRwTZc4kj2/k8SuOHrLgxDzqyAzgwbk7an2
         W8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490674; x=1731095474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubumAp7oHPfClW4j0mKbxq7mn8cLAu98dtVt51dy/BM=;
        b=peTVqYW2AA1vZy70+seNRXFsvY+SGuY/AlFpTMlORIIXAMmfvTE4zvn5h9uSvqGw8v
         QsNWLU1gLvkR6mCtpinIFG9CbBYiZ3uzsVK/hU1avlhoRrj/eC0BKhK+h5khS6cTAlIi
         rb4GpuZLoSI2YVzBMobf6gxKLxqM3pMNWInGPnpcb1JGJlvYDJJTdhodwV/zSpCDUt49
         foOpgWG5w6wzyd48dhsch0Ql3Hw0SnEMYNSWjsjVjB09c/8eQSHMnxna3fkx24YljhXI
         mii/8O/pb8SegpltzY4lAMQwsasI1e6xcO6MHwT+ndeGp2AHZYzvKxnWJWaDA6HjHR+N
         0EQg==
X-Forwarded-Encrypted: i=1; AJvYcCWccRI3GG7h7t7V7wayYACAz3tRS6IPxvf5sE/C3h4Yj7BjKC0u0NFoBGU89nIyI1i5Zh0E21dEAj729wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLzUhK4vQfNZk0aIReLoZEEUu2M7yyMV+u6tzPyHSNof7ok5O
	qL7Xhiz6jpHI/gfvlgNTdxDRFIULq2YfZQomDWagk9cki+ioxg5Xl23ZCjyljJ8=
X-Google-Smtp-Source: AGHT+IHPioO6oD71XBGGsELVS/jdi/1jH8Hr+T/UGbOX83OThn6zU3uR85UiBVncfIeKQAY2cBYc0Q==
X-Received: by 2002:a05:6000:a08:b0:37d:39df:8658 with SMTP id ffacd0b85a97d-381c7ac8985mr4227904f8f.58.1730490674213;
        Fri, 01 Nov 2024 12:51:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7465sm6024208f8f.53.2024.11.01.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:51:13 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:51:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 7/9] Fix Kconfig
Message-ID: <4c5d1b45-a3eb-447b-8269-8828dcdd2088@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-8-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-8-dpenkler@gmail.com>

On Fri, Nov 01, 2024 at 06:47:03PM +0100, Dave Penkler wrote:
>    The NI_PCI_ISA driver also supports PCI and PCMCIA
>    Correct spelling error COMPIlE_TEST
> 
> Fixes: 2c9f5d8c6ece91ecd33350749230494d224550f1

The Fixes tag format looks like this:

Fixes: 2c9f5d8c6ece ("staging: gpib: add bus specific Kconfig dependencies")

regards,
dan carpenter



