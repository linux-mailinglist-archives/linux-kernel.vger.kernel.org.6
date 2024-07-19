Return-Path: <linux-kernel+bounces-257703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021E9937DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5F1F21F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8D148849;
	Fri, 19 Jul 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdgWfGJR"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843DC137E;
	Fri, 19 Jul 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427427; cv=none; b=UUebzbwi5u+g8Qvk4ISa5wTE+7wD98UlR9OhqiBI5xNhxVE3YRAgzPBwk54ek4s5A9a4faZZqK8PxlXBoh7818SYeB08CqgS3gQoHacOcMN4kw1G15n58f4MATZCTo64Duezl3soOb75e9QcaVLxldR+VfE91ReWq6TZIa6VLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427427; c=relaxed/simple;
	bh=NDpFvtCLvONa8XvXcgZdNoT4tOOXrYjLQ0OyoVKkaRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/KM0+DS2+3wUcQdx61HL3eLIQZJyAM6zLOjXxWDDwtAv+84BDgTQ6yhUWQeknabf2VoMVgbOkaKit14VxT18tpnwGYUQiXLTlTtN7yF9VnuWuXQzB8ZHxnEgRS8Jh0Zgax8jjC/dyh7EymN6f2RsT8X7JXOMuYESVWeKUb/SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdgWfGJR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb4c51fb41so1283707a91.0;
        Fri, 19 Jul 2024 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721427425; x=1722032225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsZZfi5YDEq6bo7bl7/hSegHmbEe4ON9DK9CSEhHZN0=;
        b=BdgWfGJRZt8TDG/hJBaOoYH7GlfbNhsoGtxzrQzr1ngTg/0UOLSBVDlVX4Yi539CYQ
         mk0PokOVGXxdMvBBw195aEtEYYYDGEZxtl/6VKqPcePfMx8u+wL5aXn6ermPdQG83atf
         HjKyQO1rpqi9Le7Nkl7hORT/7NK1xw+vXlpkWmWkv7pZ8EGLy2+/94Gge3UBIxQ61xSU
         H8x2sXBYS2+5Nhb1BOdYclYJcJaCxR4NFFDhz6tMqMRRW6VKQqLHmNd5w8lBwbBh3SRk
         BAtpKBYhq94Eor32tR8Ki0ZM4StzIdS5djcQ75VD2UM42tHTrUprQtDEnN0zEgtRs3gn
         HGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427425; x=1722032225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsZZfi5YDEq6bo7bl7/hSegHmbEe4ON9DK9CSEhHZN0=;
        b=e1x2BGIF2u0Xwhy8ZhQJe0bNf4BDpFnAO2FOlme95bDDhZqjH4Mo2pNtbSwP9ZAmxC
         oLcLA2sYsxSgaxtceXj9BJ0MtgOmRiRcaeOM5kj2nhNwEU7LWLvpRCIV9emP0g7bRIyQ
         RWbz8gH8QZyd8ffbESMu5f+9HaLOmUbjN/oHfg/R8SyqfP2F8gmgTjzfIbm5dIVZ2soj
         vx+IXeMYwBzjqS/pdv9aG0A0GAxrus4PXfMywXLoBUAg9PAjesTRslYGvUxLTw2t3BlH
         vXEuUenCTYBNBEJZ12I5ja6e/Vf1b0LUH+wWe6jKy7VuHU+gT6dYgH+SP3XD+EQqGied
         ffwg==
X-Forwarded-Encrypted: i=1; AJvYcCX34Q52/QZp1lHJm+BY57Pk67NPlw9TJS58VmRltaM/cKTZHt4jfYqo2zB1ql17ks2g2seTLJNZd7tGpqZlB4mHZXadvVWyJ3OHA/2sQNdID3YqYBmfRzFRpHNr4YVMmgAXDv4orM62+8I=
X-Gm-Message-State: AOJu0Yz1dYdwwbw7TtCJUHd5MTBBmUx15DS/5eMqvvBe5AnwptNqXmZy
	V7y+MpIgdDhyO3N+RmgP0FtVyvPuDFGMzJTdS4zKqGcqgqKsSvVFJ684Iw==
X-Google-Smtp-Source: AGHT+IEjzZF2tf7nDqcL3Tr9c4kXAto8yxsqMpLGV3ks09j0itDUbsvV1ZJV0NH6Qu0OXCsUX7eKzw==
X-Received: by 2002:a17:90b:238a:b0:2c9:77d7:261c with SMTP id 98e67ed59e1d1-2cb529511camr7327906a91.44.1721427424751;
        Fri, 19 Jul 2024 15:17:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b5c342sm2269714a91.19.2024.07.19.15.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 19 Jul 2024 15:17:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7320 to fan control
 whitelist
Message-ID: <8a8956e3-c07e-4104-9087-ea1521082ef5@roeck-us.net>
References: <20240719203706.19466-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240719203706.19466-1-W_Armin@gmx.de>

On Fri, Jul 19, 2024 at 10:37:06PM +0200, Armin Wolf wrote:
> Add the Dell Latitude 7320 to the fan control whitelist to allow
> for manual fan control.
> 
> Closes: https://github.com/Wer-Wolf/i8kutils/issues/8
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

