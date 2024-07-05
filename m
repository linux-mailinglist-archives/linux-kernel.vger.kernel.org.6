Return-Path: <linux-kernel+bounces-241783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FC927F96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BC3B221C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5930101F2;
	Fri,  5 Jul 2024 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX0LSpee"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F51FDA;
	Fri,  5 Jul 2024 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142110; cv=none; b=N4Zv2cgiHpsGL+oVm7NNKfcTl2GToCFffSOb4swAAJKlfsZSbrElog1F867yC5ccwauTUVB7WUGVCWRJ2rS1gz4XI6nPta6ElBnk4q704JVMQPiuR/Ni5fnP/blEQ2K3Z+d1+2ytZuGkbtAgLmwbLPnV9YNng4M614TX9faIrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142110; c=relaxed/simple;
	bh=x4nEAQ7b6/TWXyXgB9wGBJ+8zigiSwfnUL6grPIcrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EznH/7paLNmVo6o7ZdwJUqosQm5cLAi0yh2fsVP+z2+yqMJFXN0Fd0gctSzzBDXYfo+WT7RMGiXgURx3DMUTA61Ap10zl9NxJ3iiqvJwKWiIwCOXvxBoLARoGLkiYFOHAVRMHIFqIyFQuYPX30pBLG81Xltv9U3yusSa4NBG43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX0LSpee; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6a837e9a3so6118995ad.1;
        Thu, 04 Jul 2024 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720142107; x=1720746907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wvXbEhzCKn5OcOH7K7UNIRxOnmz2N20qR1Phd4d5b0=;
        b=fX0LSpeewT2JPgQRwve0S1FHoOTbZ9OYFjrLAf9FzDXpYw8+tgKB/nRL3ukAWksBeQ
         cJniW0Rs+zR8vWs/CgNnoBOsPZCshlwgSO+ZL6oQ6mJrXTvIMTuNXsMOS7NR/M78RETJ
         PBQWhdtAZYcHT5N4S8GMJtcYSRMzPLbgICt9yYeNgQURDTattA9QqYCb3wpuJP9CdlsL
         KyXR3K85bNb3Dhiw0T9nUBRCDBA2vyO+FjobKDnikKKfMF4MtXjjxS8d88bZ8zXPijUD
         5I/Mt6z8HmP0rSX/oQM3O7pD/cKyYHD8lLP8ufA2jvonAhFTKDlXI3CBX0KioXy7guV+
         3eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142107; x=1720746907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wvXbEhzCKn5OcOH7K7UNIRxOnmz2N20qR1Phd4d5b0=;
        b=BQ4mydY787v5F2mBNQeJhlL8ClIMWpR59guze7uBrEFnbPwIoVfxy3CAXa7jQZTCOq
         6tKwgM9MTZPRnFYwEXHuA6Q7exqyTOF/C/hrbLIs5gW4YzwldQVwM40YDsKF2eXafdX+
         ug78Q1R8XBa43RlgWdxSQ1SRX0/L1Uu7HbzufZhP/fVi1Tdd71ABdGPNvt7VCXY+jZK0
         5s/sUgFgxgDdVn2/stf5OIWEh7b0q2N+Dk4/FAa+cKwr08WChGOBj9+pbkeKbIKiyPIH
         OXm3V1hIFik8o4uPam4QkYp5LLYwVWIO+Lh/emoxuu+4VPedpzm9TCoNfTnT1kwcnazr
         PBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWVHmJGivNShoUBC0zdWOaVMEJeW8DrntYlCSBh691Y54EDy2EReOs3Rr0aebeX4wmbNXPtcpknR4SahNQmL5rWnc3IcLwHgs+6wf1ZW+jKJZDSdWvzCrFc4GOshJ9dEs4VrhRijGB+ihmbkJ0RK1odnWgLVFZPMd2FYWBP9Nh7BIPFkRKAwBhRTK4=
X-Gm-Message-State: AOJu0YzzhGfnYDS3QTenLn04ybLx8xGVh4kfmZJ5v0geGJ9JffBE2kqf
	pM76OTKQ/IoVtoCTsJ8kI/u5eV3k4LI/95PvcWfFSZFzcLzidvM9LJmNIA==
X-Google-Smtp-Source: AGHT+IGN2hOzzJNvDE3eZIK5E2GMzoNH/XyxROd+JLpuvF+R8xOkV9bvFNV4mhcdrAASVj1yWj3pcw==
X-Received: by 2002:a17:902:e744:b0:1f9:e3e8:456b with SMTP id d9443c01a7336-1fb33e12804mr27126685ad.4.1720142107399;
        Thu, 04 Jul 2024 18:15:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3b83e89csm15623335ad.56.2024.07.04.18.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:15:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Jul 2024 18:15:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ltc2991) re-order conditions to fix off by one
 bug
Message-ID: <275932cb-9549-4cbe-9f7a-acb19378905e@roeck-us.net>
References: <Zoa9Y_UMY4_ROfhF@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoa9Y_UMY4_ROfhF@stanley.mountain>

On Thu, Jul 04, 2024 at 10:18:59AM -0500, Dan Carpenter wrote:
> LTC2991_T_INT_CH_NR is 4.  The st->temp_en[] array has LTC2991_MAX_CHANNEL
> (4) elements.  Thus if "channel" is equal to LTC2991_T_INT_CH_NR then we
> have read one element beyond the end of the array.  Flip the conditions
> around so that we check if "channel" is valid before using it as an array
> index.
> 
> Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied.

Thanks,
Guenter

