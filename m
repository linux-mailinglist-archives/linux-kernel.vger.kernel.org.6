Return-Path: <linux-kernel+bounces-446472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE289F24C0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E87B1885B55
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989BA193060;
	Sun, 15 Dec 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iChyoXZq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03B148FE6;
	Sun, 15 Dec 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278996; cv=none; b=OdOu+apu7/LwAj/YqTwqi2mFdllEg1QwJsJkbA5bUcGQ0qD80L35KpMOU9GM3Rqk21I1IvTU5VYeykBpyD41a9XuMhg731+OIfkzKj1S8ZCY6QKj6JoGn5uVASx4JUiA3dHKVWOSAMqfQgY61Ix3uMgK0I0N+RiHWc77aFsVBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278996; c=relaxed/simple;
	bh=XpwSZVlzC82o66nV0lhIFTJTdE1OruzoHfBnFIWCmNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7IJbT7Xz0Zx+GAb774Of6TnWV1kJcpSi+lZ7MhtACMz4sl4Ed5d/a6fw+oUSbblIf8eZ3uaWNcgs6Uu3xAkrYMB3B6qG4eutyXtpmrKeJkNYOvECDxMwNpvw7rLF/c8I9gMWDIrlI/n1pFMrX73cdgFGt70IiCx7LKFAp0/fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iChyoXZq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso25394435ad.3;
        Sun, 15 Dec 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734278994; x=1734883794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbydwlmnyyUXH+HjHyTzLF4BdcAbWjwJ8fzwtaecwds=;
        b=iChyoXZqTKe+HgTgPZQ1QaFQtP8YHoDWEjbZDlcyY39vjqponibNCox/XqPr3xYPdw
         iC8BmN/yWuvG6TtONSRCArDMu9ykZT+Tsj0F23obWD+H06C6OJHOIckcD4bCI283BI1R
         xHt9er14mFR1EI+9V0MshnbUw213LsDCjg6+aQHSTujqefdahvT+x8wqXGewFf8c8bD0
         4tgKZR/XzqMVjhxE9I6zEN1mKyBfpybBPCBRVJBoTmohpg0XaA8XtovH/bl4+J7nuB1d
         m+ZWa+/wIznqSChDylsv09kD9gCDqTZGP1KX6ScSIrz9mRV2rIwUMIjXKM3yA7sSilsL
         yt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734278994; x=1734883794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbydwlmnyyUXH+HjHyTzLF4BdcAbWjwJ8fzwtaecwds=;
        b=gthmKt7IU/fCgdW0YJe9BTQ/YsZTXLK5oH4vpiNtaAKJKi/4khIAioXacqQWqDuceF
         iKFeN11leZvX7ZvJpAxepnVo/lMlol9n9iLI61bjFC0li9ImGU6b/4oJZ4hacSdpfjl4
         JjvWEv1xpWfcByxwEi5wZCUq4ZSpNd2g6DijO4dxFqNaeAXS2rzm2pcxsrl4+A2duTRk
         mEvDeHfBXB7dAs7+7Tt0s4/QQ94/k54hGIJNGRn5LtUoOhwt9kKZZwVSOQHk2dj6B+L8
         us/5REGy3PfN7/XzkMtsgrbT9jWTwf4iby9QnyeOYNFpH3KOgFvSoZx6h739UdknYHd4
         7y/A==
X-Forwarded-Encrypted: i=1; AJvYcCVwYS3/rblcDfGHLZ3i59R/jSiWwjqdaZOGWS0aLei0pWfratmTi5VBQG84MEy6O2ZzM3ec8ak3FRHnTNGC@vger.kernel.org, AJvYcCX0HFokR232hQoLjk5X16zg5riI1c0eD0ceAv9Y1GTcFaXKm8ESfU8u0srr/d8R7Rg3s+xZZbnBGp5z5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rdS6ft8+/wUccELkv+RnLHqHcTcgcM2tXa60zCSiViIEEvTK
	9ruRqlfASQSgBO+4zwFAT7M5YByMuYTkXokmP/HRqCq9Ad0V/rdb6opJ/w==
X-Gm-Gg: ASbGncvlfF0CZRtEq6Snr0D1YRR7G400+TDa3amC14+6Uj0DggDY7olEwR3vHW72xg5
	A+Bh7AtjmrXpjVG0jYfBn1ugDmmbHL86cMjgxfFmMCwvBTjuSAJ2g9uYgaCFTt6T9qiqQDa/QNE
	JD8EeQ667AgcJ6m/3bcQ9kvy65xTqSzGrd0MmJiZw/XZ3vN0W/4IK607EWuwVZJlM4EAxsGUbcJ
	KOP2QGPz3qILBp/EREgOkyADIt3ze1dK+xhU2VFAJAl4kaakA9Fze8cXfPtNypDmeeOVw==
X-Google-Smtp-Source: AGHT+IEQEaqgtFboycp6mO3qGdjV4UToKgNG57BAEjdehWd7zsIJHKOh9UX2QqOVSmcYEUXM69gghQ==
X-Received: by 2002:a17:902:cec3:b0:215:711d:d59 with SMTP id d9443c01a7336-21892980bb0mr144301635ad.2.1734278993698;
        Sun, 15 Dec 2024 08:09:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64041sm27735455ad.218.2024.12.15.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:09:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 15 Dec 2024 08:09:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (occ/p9_sbe) Constify 'struct bin_attribute'
Message-ID: <5b17a7b2-3347-401f-872d-7732b231af2d@roeck-us.net>
References: <20241215-sysfs-const-bin_attr-hwmon-v1-1-ea72a6a46c36@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215-sysfs-const-bin_attr-hwmon-v1-1-ea72a6a46c36@weissschuh.net>

On Sun, Dec 15, 2024 at 04:19:04PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Thanks,
Guenter

