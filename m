Return-Path: <linux-kernel+bounces-429145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0E9E17E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C42160EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BF1E008D;
	Tue,  3 Dec 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6xBdlZJ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A2364AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218750; cv=none; b=shpFpWZaLvJfLJT89LdnatV1ZA40GMXEYgIt0rAPOmYwTfCHHFd7alHGeq/TEoeUI90OP/htBSpoxyaiM4SA/D51hSd0FaEPdwz1ArltRHRuVQ/NY90zE+EsGRM78W2iPX7xw0qXn/QNFLYSr5zkRVWB1+APPurJpemNO3LunZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218750; c=relaxed/simple;
	bh=f4yo24MCyvcNw5BjdCp4RT4JHWYru/YdElzMFQMZDkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XszsBSwM+X3bL7N+ODTR/XreJIEjGBw1VRXpbToPLQz5z748GRZuQjWtcUE5/1aAufz3xRk0k8dx+/Wjkk4g4u4ASgJ48NDXKqNzArsq6RHfDKyWkCC4IGRwANyRW7MvkaYRmJmyhOiSHOojOPgQkrePOhkPZaQkqv8bmxyFOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6xBdlZJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so48727155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733218747; x=1733823547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=y6xBdlZJDIxUvbRYDMQ3a0rvI04pw8wKHjWx+Sn+fwkgPJn9t5rClPcmRiln8vUCev
         BDTlovrblcX/vAZpPXlOi9ca72C8bCYZDILRjYPZ+OYi1XFOF5UhBnjjxo19D3iIvsyc
         k8rpKomDLIq1Tt8RqsQ9LF4lNtBfOod5E/M1yfLs+V+jdPZRHiEE7AHSSq8eL4a65RDu
         oKExQJk5pZRLpNpdp+/Jyl1T4zemAJpHCWFZ+/G9xXL9kl9Ul9vimkviYkZipVlgQVS+
         ZNN6+YSNsB/S8n8IML5GL9zWM0i0mLHGwjP3+jTjct1gG94M5EAsWfYYlmmHca649/9V
         JrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218747; x=1733823547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=mzg1BkEfGqc4Mfo31Z13ji7+ws6SGEuzjRcz9ZWeLclPFYH1c+4WHYmcVugIoQDrLg
         TqdRftU81PfTBIhdZx0AHcJWLzoJIp2Kwp0TRpzr1mN7QBoqvsOBCNjksoHOP64DhbbK
         LY7ppokRMdEV10Wo8oWXOnd8TrOEyoyQCvdGy4n96+YqTBSFPuy8g7CIhKOrElQSgC9E
         v6Ee0MRTqMTaHw0FIo7YsJcURArWOq3u9WL5zw380WGXIkFhLWt+26wy6SYfBnSYkPX1
         B1S1yGGMvqlHmmFW9y7LCBj2JZR0yiwcUbcPGnlgzQje6JseLak65O8KgqWDX51NGIqj
         I5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUxi98n6kZ/+ELhnv/a9xt1o5Ta9scaTpoJjfLo8H6L3+Xkrba0zXx1Hp3M9zYdG038y+zbNF5sNkvCb2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBwp9mtBquFenZdrtMIPQRgEo+WHNE05ukn5ls3B1K+jcn8US
	QRXus/ahnIihDoc14/dkOmuWGZvi8RqRPVja/PLAPNdBmEapf4v0PZMLFahUgJI=
X-Gm-Gg: ASbGncv0+S0DsQHJVPnm1hAodnImjNs0t4kbwwOv8vDi+JBCYWP8QCsKIqz/INR6W0q
	UOcFMZ24vyc5oVygaN1d33uqwVz/qalBlFUiYDRbIexXo0ZuMwujZpcGfF1B3s6OLub8F/t/AoU
	qgB9ljLtz+CUlQ0JfuB2lMwKhuBm1CBC+XbzFoUpA154wdgWfgqY87hRC6G0v6OTQHDsYf7cuyD
	lOY00AUzrlrgoHGJf5TnZHGoPmkHySHN15IYokBEygeZnFT6W0fnaA=
X-Google-Smtp-Source: AGHT+IFuW8hsbnPhok9NFkBE4GSNLWnfGNwEuWOJe5NvY0AGJzwDm00YwQeKFz6uXex+mAAN6s/h6g==
X-Received: by 2002:a05:600c:138a:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-434d09b1831mr16625405e9.3.1733218747389;
        Tue, 03 Dec 2024 01:39:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32589sm186562195e9.28.2024.12.03.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:39:06 -0800 (PST)
Date: Tue, 3 Dec 2024 12:39:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>

On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > The dr_domain_add_vport_cap() function genereally returns NULL on error
> 
> Typo. Should be "generally"
> 

Sure.

> > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> 
> Please remove unnecessary space.
> 

What are you talking about?

regards,
dan carpenter



