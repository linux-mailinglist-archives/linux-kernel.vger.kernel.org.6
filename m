Return-Path: <linux-kernel+bounces-320453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6A970AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06C91C20D55
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F31178376;
	Sun,  8 Sep 2024 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLoMjLY7"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF63A1B5;
	Sun,  8 Sep 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838695; cv=none; b=FgTIGBo3/MqRl64CD9FNtJZ6erZvAWTnqaYtqphGvRy56pvrmn8WxdRkcky/6kj50O/k2a3Npk4WM3W5hSnq8dNhw8oeoRD9DZ7SsHdDjL4bkQzkfvokv2jgGielbKTqkEwmkRJJn0bi+IGTmsq1xZ8IocbwsYnpoVvbR3q3UPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838695; c=relaxed/simple;
	bh=FY/BjhsgiyH0daYlzg5bOZKtsRLtohljcQZ3TCBxMaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If+BFHF/FJHuLrOR3KxD0SJg6Givivsx1fVoVcmoqew6WQGgbYO3VI+wvqXarN6r44dpWq0FBasTtNjkbVrhlh++dvXBPA4ia907Z7QijxixV+a/sVq3m6RTo4rus0agiy+jg3gv/HIbg6+OZpWSo8P9WWHK+iw7gX9bzlFmrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLoMjLY7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso2924576a12.1;
        Sun, 08 Sep 2024 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725838693; x=1726443493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3eHjycKFrqwvUbRNtshDfNjCTOFbe1oyIgmCT0dxeE=;
        b=XLoMjLY7IsGTqBEEXhfUL5dVtTvxlCu/ZVIJkjpW9PFY+xdx/lvgSGNBua4TwoISr3
         w941jg9K5vUPQGuJCpAnsWOkZDSex9GbGDCZz3sHW+XWT7P31KUXcOZ5kYyYJAU3lSEQ
         qXHPN5JpfC6EBx5EP4ydlP/3l52j05TyNxcBn03ZZq/9KQkrBWFNft1szyST1Y+jm9V2
         JjA8Lf8OuODh8V/liGgLKkGtuuWjrinOJOPSVvyfLennwLZCq+jh/mQl4UuFptWcVc9H
         zX+XHndwUBjcoHroTRHDp5nmy5uZw1dxk8lKbDyrUIqdGtgc6fffcONMx0gc+bAa/Mao
         Bp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725838693; x=1726443493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3eHjycKFrqwvUbRNtshDfNjCTOFbe1oyIgmCT0dxeE=;
        b=sFGW25roKiaBhP+loG+5FgwZObHFzkjDD7GefB3dbaOeAIIDTkAE+FWUJOYhS1S+0W
         QQboShn9AyTB2gV2kq7Se8pC1vgwyveMiS3VHm/asEo7B+GGjgwHwVvKRe9s50Qu5Nge
         xz7J5IqLcqPYBhnXc6lyG559w7e7sDwnj644jUT45C6WABBlpGxln8MsrzunC9hGACRH
         Aqa5tJcOXfEnQQZ2s6owyvt3abl+jrMgcxiCHPLzyYCaQ1Wpbl44snRCHtXvKGL2rD5H
         VdwW5AhsF2PsuA+od++L3dZmLXmovqU7A1Hsx0uLmN6b6mkGRUHzEzzoOotBAshW/PbX
         k3ug==
X-Forwarded-Encrypted: i=1; AJvYcCUgOwDa/NPrpe7I9SvGeSP88EeX0yqK6ut58anKMp2t0h2GfebEjmmaQ97E2PwzYlFyMEVXCEVLAuoSbWJI@vger.kernel.org, AJvYcCV1TEkSuHJdj32DCBLMuDkiIumGWJ71YHRAhrVWfW8TUK6lYBL36Xqd7Ws0ZCMvyEftqeJYYPpt6e8ZcrmURKE=@vger.kernel.org, AJvYcCXnejJITNWE2ujHFsgWoaJubI/mvCM/qwzGtUDuLxYNUY1gcjAFmqedE7sH6huCiJH319wScfUFG+xMi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+RKWYRwoWzzR9tQviieZYUga8KQABdxHJbpu1XrPPn7oKA/I
	7fSi7blVaT4FH9K5jMcfPjXaEtIvSXzM2tyGsb0KvlBQrVkPvAaA
X-Google-Smtp-Source: AGHT+IGOmnvuP7qDYxfamyY7dTZnsjSbc3Swnm6V4JGaI+iN0fr4DKRu9NEUxrBwfTThDs1aZuxc/A==
X-Received: by 2002:a05:6a20:718a:b0:1cf:55e:f893 with SMTP id adf61e73a8af0-1cf2a0e58ecmr5896375637.36.1725838692810;
        Sun, 08 Sep 2024 16:38:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982ebasm2465733b3a.164.2024.09.08.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 16:38:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 8 Sep 2024 16:38:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Saravanan Sekar <sravanhome@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/mpq7932) Constify struct regulator_desc
Message-ID: <f6c39166-19bb-4e63-97ce-abf50c6f915d@roeck-us.net>
References: <c0585a07547ec58d99a5bff5e02b398114bbe312.1725784343.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0585a07547ec58d99a5bff5e02b398114bbe312.1725784343.git.christophe.jaillet@wanadoo.fr>

On Sun, Sep 08, 2024 at 10:32:38AM +0200, Christophe JAILLET wrote:
> 'struct regulator_desc' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> This also makes mpq7932_regulators_desc consistent with
> mpq7932_regulators_desc_one which is already a "static const struct
> regulator_desc".
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    3516	   2264	      0	   5780	   1694	drivers/hwmon/pmbus/mpq7932.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5396	    384	      0	   5780	   1694	drivers/hwmon/pmbus/mpq7932.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied.

Thanks,
Guenter

