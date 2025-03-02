Return-Path: <linux-kernel+bounces-540710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12209A4B412
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A673B08C5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356671CD1E1;
	Sun,  2 Mar 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duK8tudp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503E12B93;
	Sun,  2 Mar 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940300; cv=none; b=TZqnj63yVhkEhB8YySRkWdzeAM0CNWUe04mY8XF0YZFGQd+WgW8QQe1abZ3mDGSlyKTfll0Y0syp3UdOAmnIpAWS2/SdPHs3ka91XXaoGLupskSI6u0yboE7KX7NqBD5xcIoPrtycoFEhZmOsZX02T1Oe4nMEBetsv+ESnctbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940300; c=relaxed/simple;
	bh=SzNCZySRf1eFQD0TS3/9fmObmjKeNxlo/iWLSlUhSZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcM6cu4OG0XDcW8P005fRpf+zVcy8vRDS0VetI+R7TMHuYuoImIS/IPl+dXlpL/Ax12cqFkzBLjhbiQioNxX6hRjgwGchSrt22FvGNqmGB2q0H8HIRR9tWBBaJqpGutGJ3u53zbCP7btbs8y+elMRfuORGwxH4tWXsWrkLcJhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duK8tudp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22349dc31bcso64282425ad.3;
        Sun, 02 Mar 2025 10:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740940298; x=1741545098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/oznMeBLfkCNPzk67pfdLLxHxlKq3r15UYdTEA3Gwk=;
        b=duK8tudpm7JOwDEghuUrGeQHu6HQaugmdEUfwIioYHCgdu/EGhvdIeEsFX8HY0l2X8
         LfRy98cpXc20Flk5zlMfMiddALFG6pqvhsAydlI5pGW7VxF/LpbRv6iBpKIelBXnEdy9
         r3Mv0GQT1e3lg18Xsvgb4XTxL7ttOsyOHHDfdIQV59zZGUZrnZ12qSAEaJmg25dgZRTO
         TOxhka5sRoExGya076tYXjMWhUGUtONJg1nz5Ct6NR4yBSArJWQWrDKLDrggNTp8M4vx
         IvSpufHkgoQ9vhDAiqQr9EYfKX7zYtYZYMNPmQdZPNLg7ia8X8CcLkZ94qoQXVlGSc9s
         0/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940298; x=1741545098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/oznMeBLfkCNPzk67pfdLLxHxlKq3r15UYdTEA3Gwk=;
        b=Vw3f+dsGQLkf2rXaISfxUiirsNEwSk3GvVc0C7ZpHDMtEk3lLhANtIOjjPQwnKZTeb
         ZJ6jSQkdvgW16ZAyEaRE9xSrorGZq1lBrWJoEL3gcA8IVZc9w9Do3WdHdm94+TiDUZz2
         lhNh8i2ik0Sfqr3BZae0EDwTH34hcmaWOx2mRVcj8PtVx+tUADstx276W9/6K2sGLg1z
         gJx2WrDkIp3jjLCdpmXNwgu4eMiNbWCBaK1XKCm3Xt/Mq2VOumbP0NsUhr4Y6M3+ATMM
         w0DuGItT3//5aqIVV4ky3qbnupgTq6c05QieHjMimpYF+JstDYLE7ADs7pT2hm4ajDe/
         Ki8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyv6CpueSx+K7Hduvuhdv/SW782RQuhKN/robebEyWl9TQKi/HlKUbRjihq0V+QUh06KkjF5g1uLKq82Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YQ//PK1zSIlCmrHEPRL+ZN9lW4SmuFHEFy/KQgn+aA8tPmQe
	vXQsSsOTJJnX5VLFAfc8py7p8UODhLXho0HdpDAyS4fwTVpmhudKk7cNJw==
X-Gm-Gg: ASbGncsMKEZjXrs65n8PXwLwQBlD+S2Io5Cufu7KFSDg7owQgs9iDslUECdyKqNnnLP
	So9OjTmIMui2eA4UCsaU/R2IzGDYlaHo+ilpyj+s0XzRsW14PIvps9pBa8HsgORynyRPM4SrzG6
	O8RmZpxqdAi3hCFyXlT7YW/D4y9mp5Y6v3BxVTKpDJW/1ygQ7D6i4v19+kdoOWfXaFp4dI7sOel
	dwUKLX9KbEXWlDiFGedH/eaGssQm+JK7w7LjIYefsNGJS44A/gWHAc/BFmaq/r2itTcRWz+UST7
	Th7NINQq+Wty9G/2gLiuS/+zKOx3RtRaCO/HP2aEgdKe8MUU3iDUP5r2jA==
X-Google-Smtp-Source: AGHT+IHmhW+8hPE4I3ZlDJFkfm4EIxk+N5WfbpEHcBGWmqcrJgUMyUGgVDPTfkh4r8aeK1TPxMPyLw==
X-Received: by 2002:a05:6a00:981:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-73647a5f2e5mr3628253b3a.1.1740940298251;
        Sun, 02 Mar 2025 10:31:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2adb2sm7499450b3a.19.2025.03.02.10.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:31:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 10:31:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Fix the fake power alarm
 reporting
Message-ID: <90319d28-6bf3-4439-a86b-8adb7ac71d0d@roeck-us.net>
References: <20250220030832.2976-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220030832.2976-1-lihuisong@huawei.com>

On Thu, Feb 20, 2025 at 11:08:32AM +0800, Huisong Li wrote:
> We encountered a problem that a fake power alarm is reported to
> user on the platform unsupported notifications at the second step
> below:
> 1> Query 'power1_alarm' attribute when the power capping occurs.
> 2> Query 'power1_alarm' attribute when the power capping is over
>    and the current average power is less then power cap value.
> 
> The root cause is that the resource->power_alarm is set to true
> at the first step. And power meter use this old value to show
> the power alarm state instead of the current the comparison value.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied.

Guenter

