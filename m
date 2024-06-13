Return-Path: <linux-kernel+bounces-214124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E309907FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05CB287FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B6155C92;
	Thu, 13 Jun 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYT6UgPn"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE1155A5C;
	Thu, 13 Jun 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322319; cv=none; b=mlUh5ngN5gRDSwUbvB70Mig9i2K1rCJKEf9kdInZUx2dQml0JdYMWYS7swvzYu3onp0Odlj/s91qOOpRahA6qh5GVbzNs1NbXWgtrL552qSu0dx1X3Ekbex4nR0uB5+ZAAS8fyeIVCW9k0eJoeumEH1Kc0e/yVRyY4Vy++30CYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322319; c=relaxed/simple;
	bh=CsY0CCnDSEPM59W6XG1p9zg9ix32GuyUmtg/6k5/slk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr3mbax1G4fh4lJKrLyUsLmbXvXw05WsSv4kwmGrOOGfHzuBWJSYZ6/cQBC4zWgWXTkBhDSRRcTVwzEQTdoqogvLVJxW8ac/e+jvW8PE1W1WF1iFjdOKSBQQLgIw08ZOP0Gn4c9FPNvnkVNILiRfA46nUAoVBYSnSfWIyDVezI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYT6UgPn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso1215812a12.3;
        Thu, 13 Jun 2024 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718322317; x=1718927117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mtm9eDYG2cZAmP6Ju1HVX7nfYH9H/K2+MAXdlH/+PI=;
        b=XYT6UgPndWpTcYLW5I3al59t2p2qZbJN5ohEEC9/FQ+GGgl8ky8BzgDluMBPQfguvY
         qy/QhEzDxJavG7AkYj8xb7wAF9N4Tz6JyQUD9UunPvKNMc2+5cVlZQz3QyacaxexWJNS
         T47tCaW7BKJDY9IZ2iW8sZd4IbmjuX2EApwKnf3FeM55fxraqNsHiIlOT30LiJ9ARqxl
         /kv//xEHL58QDnrSGNkhTumEYHEHEavI2mEMIUBaVNzUel1WtHicOphoIcU2JTZl9zXA
         iOlWDtZfEhuno0CH2zHfS95uhRsGOB8kGCm8fq5A8UFYFBqqpS/6fUXQxnELFnP4+N+b
         jFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718322317; x=1718927117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mtm9eDYG2cZAmP6Ju1HVX7nfYH9H/K2+MAXdlH/+PI=;
        b=nSkQxZW64t6nyABF6oH8y7S6OxXx3jWQI8exgsJRkrvL2mUgT7E15ng2BkITbPmWhx
         3GjjbulsPMB9wv58nns97ysZ+pPQPVhOCt4XE5DQnhPFioHvrTtMsFdnIJw8pJwKTENp
         XSTRq31WekqLiV1rYKApQtyiw1CUsHPlfVRwv56TNIIthBJui6jejsguWQoscvT5Ifqn
         0qgjb29ra+gRnem79VwQR2pnQ95KNontG9HEYD1oUJtg3Y5DDxVttNsD+DUE75i32cyG
         mjwDjGV5ZO29DaLUcMBBXAbB+anl8Qcgp993Av8uqPQ+yiCKJK8/sAkZr3jRVFUjVnTx
         gJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnjkJ9xK6qrQtZADqp/IKJ0DaOGpwHo7MHazLJRfSfBS6miBC1B1bMv+zCWJ3QyBurZh5e6ZaCr4CMD10mrSxpcenn83i9inHbP+iJFDNQyq1JwVTJ9YSKpMZXCLluCfdeo+ILhkAEtNc=
X-Gm-Message-State: AOJu0YxgMcpOz9ugU1NP3YxCmCnDGKLSqtuMI85/vXqr3YYZvmDnGN4a
	Bjb0QUEhCYiPoPDHDK7p546QR+NHRPfGFIxuFepBr2OdnsrgzJfx
X-Google-Smtp-Source: AGHT+IHK9n7bd54p6UPI0S7aGHF+8jh2ZeLELs+jkQGeXdDy7F+SCOzceR5WIEisrcKhQYULXM0Nzw==
X-Received: by 2002:a17:902:e549:b0:1f6:87c:6f with SMTP id d9443c01a7336-1f862a0d057mr14278975ad.62.1718322316518;
        Thu, 13 Jun 2024 16:45:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm19877575ad.106.2024.06.13.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:45:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Jun 2024 16:45:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Make hwmon_class const
Message-ID: <447f8544-43e7-4907-bb76-0a805d3e7a20@roeck-us.net>
References: <20240614-class-const-hwmon-v1-1-27b910d06a90@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614-class-const-hwmon-v1-1-27b910d06a90@weissschuh.net>

On Fri, Jun 14, 2024 at 01:01:42AM +0200, Thomas Weiﬂschuh wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, mark hwmon_class as const.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ---
> base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
> change-id: 20240614-class-const-hwmon-556014c02b70
> 
> Best regards,
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 3b259c425ab7..1d1451dd239d 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -136,7 +136,7 @@ static void hwmon_dev_release(struct device *dev)
>  	kfree(hwdev);
>  }
>  
> -static struct class hwmon_class = {
> +static const struct class hwmon_class = {
>  	.name = "hwmon",
>  	.dev_groups = hwmon_dev_attr_groups,
>  	.dev_release = hwmon_dev_release,

