Return-Path: <linux-kernel+bounces-434133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C19E6211
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033C6188133B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D411C83;
	Fri,  6 Dec 2024 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0y2TAyq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEF7464;
	Fri,  6 Dec 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444153; cv=none; b=bUmlsK6yWjDFa3+vW/hQ6/ZfvAZpyX5d5EXBRYNUsFt9pArxrDtSyoTiLN7tiirDnwpzrVqxDJwOd8TCW10js1GE+Bvmq7fegdzd/rQ7o7RnjXkJI4yBMtVx5PyFFR83ZEbtjFJIgusWDwK7O2spFxU/lcuQSOKcljM7Ru/O1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444153; c=relaxed/simple;
	bh=asUNDkcijp3U+7fxw/p4+0+/xLSjHkZ0HqaVhow09Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU0dLGDKD+AG08ef/qitRTsfbhQMGIN7qhc5FloKjhbyKlZlc1Zhi0p+kAc2zL6mv0XJhqT4z0ESr9ZMp7kvuDF6UlGl+W52RQuS0tg/gbYaX8VmJ90zDUOE0fEIszyfLBmWY3Yl9oXvRPwvzI54YffH45FzY/Qnm5KLa985UUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0y2TAyq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ad59ad72so812621b3a.2;
        Thu, 05 Dec 2024 16:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733444151; x=1734048951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUoTZbFvvzJufe6Ikwk0n1WmgUHmEpV1FCvkXH9qPWo=;
        b=W0y2TAyqwHSVypYQ0s7EnLPdoA35+2rfVPcI35hgpLxJrhGuPogHfPvV11MUaAM27S
         EeFlXwi7WEcSF34BnbpQUSEk44diUDB1G6gvQ6stvSjhJf3bVoQ7QzT/WV/kylrO51Jw
         nY8Oi+a+QylUnGduCZ862cUxYFzj/vypMWSxobH7lN3FnX7oi84ayRbDUQCNMozcZbYv
         Dc2+J8/Z2MRhbEdZCdjGBKY7loGYcpmgxKnL8yxqBoipLm6NeSc5MD2A1sjiDf7A8/Ym
         cXyJkxqtbKzXEbIW7MJwHZC8sCQiIIICwM766HCDEr70JQeFIUk0BRVjLXBaVObpO9Ne
         uXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444151; x=1734048951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUoTZbFvvzJufe6Ikwk0n1WmgUHmEpV1FCvkXH9qPWo=;
        b=EBQd2yEi1wTP4f2EAbWHHIdwuciaxmD40KbnsePJNftJ7goQXVe/+wzp6g9zin9FzK
         FCURXJvwXDnY/EO9emrD/BVLRZzYriKWbnGz5/B37RYrzuhpCn/Z0gkl4KM/eJbJiDKx
         kMZj0KtQPzAVRvv5uXwzj7HhfSiIh2bPyJYWYzScfmLkOsGbsXnMqb+g3H+lsNYzaJkr
         rJ9rqv50z5YjE7p1w1p2Q7atvpjoOVzM3aYf6ugZUB56yjHOS5UreGcceWmShlzcBN4O
         ATkDM31xBK6qQJDmh5mFw08s9NskTiAx+4ByBfuREQe/cuSzlGSL1yS8iLtgpr9+S4iS
         WQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHLeZouwLJ8RVshndOkXcEAU0wzG+mxxYFybpHcnRAag1VPQvuAbcZUC18Y+Tbcddslay8ITc17N8/eOBU@vger.kernel.org, AJvYcCXrz0VGvBouPkwN1LomNZJcaiK1LROdVaxjin+3wmT11EFGvx68BmhRaJx8RUErlFPR4fccKM+d3cXlCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfdDr/6ZJ6Tp0w73Pt0MMej13JEPZHl867pFW9UCqHEBhlw+H
	TAQSpZFySyaEIhzbd/sffvn/Kiw8FOfcFMxKKYuS58FGXpFjwO0GlwrshA==
X-Gm-Gg: ASbGncvZkFRfEz+yX0ey4FjiGBjRTlZW+GY6hg6MJcRj+1s8zfCcBRTQVE9AvyF7n0m
	SPbbK0xjBdFj09Qkz95KqL7nG10W+pSKNM92xHDniP8kfQDQEab36xytGrLaoLDDTIXy3FKGzDa
	oyXBnpMzAnNBvr40VSPvR0GvDOLlewHscRcKEJvo1HTaxmJFRCgQkLewzc1H3TzeoIuGwKQJaE+
	pgWj9ps8LlNIDQfFH0hZJPUxGxuK8ms/ieXtDQZWeJHpkNLE6Lr8OjybyRn+8g=
X-Google-Smtp-Source: AGHT+IGFysXISviEnPrP+igegefzLQRo8Zaot9DQVeBNJpxWdeJ+Jp/723Yb2ksHuTavKQX60Iod/Q==
X-Received: by 2002:a05:6a00:18a5:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-725b7ee94dcmr1978936b3a.0.1733444151196;
        Thu, 05 Dec 2024 16:15:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a9050asm1876308b3a.123.2024.12.05.16.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:15:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Dec 2024 16:15:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: skhan@linuxfoundation.org, jbrunet@baylibre.com, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: tps25990: Fix unreachable code in
 tps25990_read_word_data
Message-ID: <0fa164c7-5562-40bf-b2d9-92ed1efaff8a@roeck-us.net>
References: <20241205213315.3073207-1-karprzy7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205213315.3073207-1-karprzy7@gmail.com>

On Thu, Dec 05, 2024 at 10:33:15PM +0100, Karol Przybylski wrote:
> The tps25990_read_word_data function contains a block of unreachable code caused by the syntactic structure in the PMBUS_VIRT_READ_IIN_MAX case.
> 
> Specifically, the return TPS25990_READ_IIN_PEAK; statement immediately exits the function, making the next lines unreachable.
> 
> This patch removes the return statement, leaving the expected handling.
> 
> Discovered in coverity: CID 1602227
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>

Thanks a log for the patch. I squashed it into the patch introducing the
problem. Please note that the above commit message is missing line breaks.

Thanks,
Guenter

