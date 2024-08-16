Return-Path: <linux-kernel+bounces-289825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20642954C05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7DD1F255D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1B1BC08B;
	Fri, 16 Aug 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrkw6cz8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070931BB6B7;
	Fri, 16 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817395; cv=none; b=beqhP0wrb7N/W5av/6dGkSBepK7DVyzQ4IdSGmNIjWAvY5xATX0nuRdjEYU0L8JqNrs2LCZW1ilcj6ok6C2uCmnyu3pdo4G/uyGe1ur7DkZaNXKOl85Tf3bDyhcVyQYSE9QK0yRcCvPPT4seFjJ8EEHxIkBOhUNMmXcidkfN/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817395; c=relaxed/simple;
	bh=TPglCHD6GXr7VSwk2w4UE2JB3Jt6KJwdzfObrsWUDj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaxYKR3KrD/23qubnTLMxSRsEN1vtCx5OtVyqXtEC1v0DNT5ACPVtBFBWzuV7VjwL5IElmb/aRt/B+JK7KL3ZqV1bClTDxdapPv8LnLlowMvRJJS9p+pK+j07GBz63/81UKou1dKyILsf9lQ8R9RHqrzs17K6JZ2D86UGs6z8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrkw6cz8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710ece280b6so1657310b3a.2;
        Fri, 16 Aug 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723817393; x=1724422193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW6UsTzpcNVunHocOm+NPEsNYY2zYdNm0/7cMdCJFzQ=;
        b=Zrkw6cz8K/3f6AlPprt6p2DieXGmgOJRfISWOvfRnMIgbenhh/9MJnYK82pnYi6bzY
         83/XN4vN5HA7nLEAZgRzhsmkKd8ing6Rh4NJlTHsNYKtnfixSuIDivEbWdDe/bjqzaJ9
         YmH6Oss73dNr00qRgzmuMDeycpsbQ5ej3ta5qxn1AFUmDCGmO08iSoDS0w3YmdGX13TG
         Z6Tj7XP5gW980arDSfmd/BeiZXpN+cT4eiUHpJ5gqCvBC+7sMkjZVT5YKojfAtmbS2ja
         QKrVSOD2a8N/WVy42S4wYn1Ajb3nxKIw9mH65T2LOt2+Hdqcer++cCmrr+y4JC1re/R1
         jToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817393; x=1724422193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW6UsTzpcNVunHocOm+NPEsNYY2zYdNm0/7cMdCJFzQ=;
        b=Ch1F+kAm52a23qFskU+/WTgeYlG0Bolv+lLvmjYRevCncuX/avDBMdD5YH3moLZCxC
         SIj1dG+42Uz053luUaqKzltMI1UidikenqYmcIGfHsvIjFDICRDsXzN4yf9sJflYRUEt
         RpNCjt/6rf95UptBd79Ceb468Ls1bQX8bQqCZDi89d7HmkcO1lrHai14WdUTQSP5iZBo
         gNTBN2Q/ZuQj1SXSss66OHnWMfVAd5Vb8mAlm8uDDYSjQjaUr/4RaDGWy/+jJezGtW2Z
         qwj7ZXftZFiBuAejw073Z4HcFfbvyi3axMyzybGw1hZhEJOuUtRdKB8L0ayEf7ARuD8T
         MlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu4SwdZ8h5/feS2wUVeW8sws2rUNAmPSlF5A3Ce5mlysfpi++1+YMFSD52cKwTOYfdSCYkOqlprnkG8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVz8CWEjemC+amFBJH7dfrXWpu1ga9oF0oggRaApq+4iPdWTsW
	BWYJpJbM+UpGOe2Ztu+JV/4RQRndTsHcJG//6vM6txwkZseZ6kw8
X-Google-Smtp-Source: AGHT+IGXnffljGXsKDgtAUto3MX8lDgpiSW227SgAd4sSIqfNYWjoTzG1i8kJ3GYfWdY8mu+y2OHeQ==
X-Received: by 2002:a05:6a20:9d92:b0:1c4:a49b:403 with SMTP id adf61e73a8af0-1c90505281amr3633591637.46.1723817393084;
        Fri, 16 Aug 2024 07:09:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127addde5asm2757748b3a.13.2024.08.16.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:09:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 16 Aug 2024 07:09:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	ch.naveen@samsung.com, jdelvare@suse.com
Subject: Re: [PATCH] hwmon: ntc_thermistor: fix module autoloading
Message-ID: <473681fd-17b8-4fb1-a482-1053448a89fc@roeck-us.net>
References: <20240815083021.756134-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815083021.756134-1-liuyuntao12@huawei.com>

On Thu, Aug 15, 2024 at 08:30:21AM +0000, Yuntao Liu wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Fixes: 9e8269de100dd (hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver)
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>

Applied.

In the future, please run checkpatch on your patches. Your Fixes: tag is wrong.

Thanks,
Guenter

