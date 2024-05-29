Return-Path: <linux-kernel+bounces-194751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD368D416E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FEF1F23137
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9A176FD6;
	Wed, 29 May 2024 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEbRhrOy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E6175551;
	Wed, 29 May 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022014; cv=none; b=Sme9gWqNsADo0LwACbp0CsvOKMgN+uwJxTNXEbfr3R4cRwbQoZRHhQIHZauO2L6lzaNEdFlzPOCGkzZyIIW9ThWmURV8aWEmx0Z62CBGXceEgJeZN2lqNymLf0kPBHAgqSFunG7fD+CugrLRexRP4ywzuYk719wTV7RiFNWQ9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022014; c=relaxed/simple;
	bh=CjKowp14yVX6G+cZapxyYVlO0uopznt7PEhMgALSaeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDyAes+NQ1mQUocG2Plonu5jQwZYYGDNSVohsAQqOmvzaA3s1cQpf47hJr2p1k2rH8Ztwwv2pWo8c50eO69CU+9/VYX9AoXdyLsG/lHU7y1UDi/Xr1sH8NEMgYTb54+fYD7kLtffr7GTVBebye/YmMtzuNVIG7OIcgR5/En02CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEbRhrOy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b5b9de6so2281105ad.3;
        Wed, 29 May 2024 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022012; x=1717626812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH2WadoiNH5239FlTWFDCdHvj7sCxH4Skwal7mzyy6E=;
        b=LEbRhrOy+ps1IPU6Ms9KqcAxRHMPn7qXPb7lAqjqXFJSRX4Vs/oCreoPM0PrfqPJZ7
         kd4LiImsz67wEbv9T8Kc7Pko53WFiHnIcoYHHgw1+WtGv7jSzpcMye1aN91cVsXjwUtr
         VpogawgP5Mwx/xKpodKg9+X2Un8L0AxXwwZNdhKLWzkGRvedz0hpkMtO6j3Jo1xCE1dM
         81sq8hgiur1gH3aY3tz86o5c2BPLdljErhho7oXlgkxTu1WREtGneGz/T1ZawP0vaVDu
         V4DHH+dqAYUEU9daBFsLHn5nTnq5UqR7mbEetuBp0EZgKumYaJG6Z4C2hcw5WOx0MVg0
         AkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022012; x=1717626812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xH2WadoiNH5239FlTWFDCdHvj7sCxH4Skwal7mzyy6E=;
        b=TTxcDrwiRCIe4HDoPFr5e59REpqOt+FzVBptLkUhoeu/Ucxccwpfy/qKQyTJ8c4Gvp
         XHn2qrWq8MdBdGuce+gG1IjlqpyZ5Oh/3xBITktcxHERWdMpqKOdXZzr5BVH5gU0M0wM
         S2O+Xo6Ieapy4qbvxCyVnP54vT/GNPsGgo27z6RHH1b+wmZ57eF8m1Fy6pI4bP++Gl/M
         djcYqOoTE+Y0fNd0IdC8Xmgh4TSRlauq/C6TW/5ZB3T0gZss3oJHwKdSWIOMPgRdbssz
         NiyOC2fbQPJoLiRa88/SPvT2lmNB4ALGH9VIjoVYoxXVUo8ohPGLldHoxOZDOAtFMZWh
         ZKAg==
X-Forwarded-Encrypted: i=1; AJvYcCUDTrS94cSYdPB4vUhP62fjqNvP8NMDNXRX4xJCIRFE2XGUOtsVKhHmFP98r1bOUjrDrKpdAFwU7ukuzLePoNBHy3h2C81nxsOQb28=
X-Gm-Message-State: AOJu0Yy1OF7g7EkTKbWqtJrJQ4tTRu+c9ATY4gzOE3+fu7qv3mBVBmhS
	shH4SOCrXNzIFL3I177nnYlxHhKvzh1jMV99hSC/kNTwdTeqU5OR
X-Google-Smtp-Source: AGHT+IEPkt7VZDFgzRCAbaSskEDjv46isEnmYCWjnBBfHZJxfNhox+/FarnwTzphoS4o40Z/R2X+TA==
X-Received: by 2002:a17:902:c70c:b0:1f4:6f3a:a13c with SMTP id d9443c01a7336-1f6198307demr2900235ad.47.1717022012162;
        Wed, 29 May 2024 15:33:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm65658925ad.164.2024.05.29.15.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:33:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:33:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu
Message-ID: <239f3b5c-8d88-4da9-a758-9fdb34ff7b20@roeck-us.net>
References: <ZlAZs4u0dU7JxtDf@monster.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlAZs4u0dU7JxtDf@monster.localdomain>

On Fri, May 24, 2024 at 04:38:11AM +0000, Wilken Gottwalt wrote:
> Add the usb id of the HX1200i Series 2023. Update the documentation
> accordingly. Also fix the version comments, there are no Series 2022
> products. That are legacy or first version products going back many
> many years.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

