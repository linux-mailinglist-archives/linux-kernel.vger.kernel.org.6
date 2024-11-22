Return-Path: <linux-kernel+bounces-418624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB099D638F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C23F282B55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC281DEFF5;
	Fri, 22 Nov 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNaR18gK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576A154BFB;
	Fri, 22 Nov 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297720; cv=none; b=fRuQzL6ogCtP30Dt8YC0NutUBm3XGu4LxTgQ6A+kzgQ6nbw4AVVKeCUjHUGluJv+vzesdZJ+Dopddb4vMCX7OCoaZ6LYbYYKyg59nUeCWvjoLe+jGbRM4kUSEcyOycVulUrK2NVurZz5zwK3p57bM+STzBIGdm/oUSd0Zwy7O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297720; c=relaxed/simple;
	bh=w6keSoU5f6dIGLIgExzzYkq+02aqWSurghBh7l2zrh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf2aiMGnWCnwHu6Ec/f8k/I/j1Flac8dtY8Oio774calkJlUgo0rLNLOtGgY9l9YHVLEmX+LFLLazLmoFfPKTOHaUhfluB9dp1RaaidPHs1fpTs5sxlqHjG/L1ajIfBf09HaEdBixhFUVLbL655fxt7FBJzMHKD+vjdPftIIaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNaR18gK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so1770140a12.0;
        Fri, 22 Nov 2024 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732297718; x=1732902518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZ/AGQwdlOzKawCgYUzfsSSmQhPKgvRWM4tfx6r1xQ0=;
        b=jNaR18gKVX35OayMS/Ld3pnPXFCDmlgE3VD+ZIowIe5BTZ1yB83222K5VAd/R4I2oq
         miyt2oHdsX5nPg1TeJJhRDVCkfjLZBK/gYotRBfzAN4vpgq8+vX24mS7gwA+X7L4UvOQ
         WurnwySdRrjgSoiG8Y6yHX4P6yVZ+FV5cQr04DXJ5cMya2CyGEDdiqvzEr76EqQLOdna
         cEu3/+yKQ4nna2MDPqddalValJRpCc8IDFgxCkcQaiDIL2hhGHy2nPcbk8f+Eu2u0C+n
         GZD9x0y/U9bzWKwL+6EXeNIDdR0dK693ufGZBms6Ep6PToqTW0BgzTqq3xRKcJs6j32u
         /aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297718; x=1732902518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ/AGQwdlOzKawCgYUzfsSSmQhPKgvRWM4tfx6r1xQ0=;
        b=nUm0Nz8BFU8usZXprhgsvXNSoBoBeQg2yK3Ev49lSmr4XS01ZuLCK5k/HerrrFBC8p
         OBaLuHfZ5C7fiHjh6cfhUSjSqdw3Y41+bXP+L3zl689apqMLpO3BkQie53q+UbD5aj/v
         dyG7dsWCEl0cwhxvwBykbn9R85WG835WaqdyQXAvLWEgrGUbV3O48Fp2cTAD5DKSyQFp
         +YpFW7w4e6BIF89a5bETPfh+Wz4dl+mQg+nYLnfDtFInFBrsYqGPBkqVIMpVcqOA4B86
         03lA6Kl77xePGJuoQNXJ0enwfyMc9ivXenE7+o7et4ER0pGYRGicCLQnTRqfDsZup48+
         PQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUwe6lvLmPAAd3IHxTrb1J32ZdN8dsNYJ0UKAqxfrdK4ChAYtPRLzYTLk/H5K8iKbGae+CES1NEQna/TsB9@vger.kernel.org, AJvYcCWjFexbsJtuQrj5FHQVilKGPsZKMp/g5X2mENbedkHhEXYNFphf4kxHwzesI7tBcpqjqBFXoxk68m7XhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTPk9kaVh/YE57e+h99SEfoW+CGAWQJ9+CpCm9UqWEPS1f3fr
	7Qv67EMCY8BygjeqeYUuIggyRs22uDQh5znum/WBr4CWfLnPlf9RTZ2gnw==
X-Gm-Gg: ASbGncvP53nwv3SOMFFtsFwkIEmBu6G6IT4hM0qZ89W+J6RJBDvou2YtAj0Vj8Bv4gM
	O4A8o2KHKwYxjs5jvIjXY3xjcTHWa7Vf59Cy2YUp7yc2OVevBCzPBfW0yDUGKNIJFO7OH45WZwS
	Q5P8X5YJKAl/JOZ5g5UZAElNPiIEYc7d4jejf7nozrCpUkNZZPTZqj/W8HyWZf0CVFgoa8rV6I/
	WW4+4qOz6gNnaRyCuKYPCTX5iX7nja7EpL5iX6QvPB1ZTY+7bJNwBxHKjc3qMM=
X-Google-Smtp-Source: AGHT+IFmUpOiFC9+sESmNJhNr1f62pSqA0oJF0WLQcL5MeSzxO5BRcUCjUyzEa9cqaMYRZWYPryarA==
X-Received: by 2002:a05:6a20:6f8a:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1e09e458d10mr5368128637.13.1732297718008;
        Fri, 22 Nov 2024 09:48:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de478f71sm1897223b3a.58.2024.11.22.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:48:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Nov 2024 09:48:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (chipcap2) Switch to guard() for mutext
 handling
Message-ID: <f025e679-cc05-478e-8acd-7649bd94fa25@roeck-us.net>
References: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
 <20241121-chipcap_no_iio-v1-2-6c157848a36f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-chipcap_no_iio-v1-2-6c157848a36f@gmail.com>

On Thu, Nov 21, 2024 at 10:44:56PM +0100, Javier Carrasco wrote:
> Switch to guard() for mutex handling to simplify the code, getting rid
> of the 'ret = x, break; return ret;' construct and returning the result
> of the operation instead.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Guenter

