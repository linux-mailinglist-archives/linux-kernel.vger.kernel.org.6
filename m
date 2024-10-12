Return-Path: <linux-kernel+bounces-362519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98299B5E2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F741F214C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B31EA80;
	Sat, 12 Oct 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3M/Db9+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E693186A;
	Sat, 12 Oct 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747111; cv=none; b=XFhVNB9Zngh9k9AUpbKh/tpYJP3K4JKBqpodRUZGJQfV24f9MNjMzjH/fej/zzjCcj5xuEdpE9sH/upon59Vsu9B6lSh8ChBEeHf006UNLr8dVuP3HW9tfuhJ7eJ6a+xuBIlA9FX3evQ1on4SxiSACK5wc7UcOFLIQk5fsQHNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747111; c=relaxed/simple;
	bh=OPacz2RZhDCHCB9Cu8mIoyq511cTjmLcqYKVtRTjoGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=os8LsuWvzbZ4/lQzJVKmH2HWVGHo8WZpGHn4Y2mgBk++BYq5ea0bP2tW898SflCn5KhcUWu5zLbDw9dkShLjicxlu74nr+LIWErDFF+gqW0WifYZAVvYnX04G2E1+s4HnFn6RXOscny/A+4+9c8rZsAIVLD7KNwmarBvq2xZjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3M/Db9+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso1968400a12.0;
        Sat, 12 Oct 2024 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728747109; x=1729351909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqrfzHhGHBRU4qas/fWaWdVjOOvtCwlI6kja/taBS+k=;
        b=Y3M/Db9+6XVnGChfDxS5maKYh/Osp88SLPPeTn53eanBj26rof214s52aGlNfJsMPX
         1woHMfSWoRHBBMy7uS9yh022SElBq4y9Zo/pH2rn1cd/boPKnm8ybsEoMo1xrNZ8VBFD
         RuR6u55ikvcttlDJbdj8Yfo8YZ7jfYUxh4zTMZaCTgA1ZSjorQQU8BEqtmSmR+//l//t
         16czOglkFIXNGkgz4b0Zjqqcuo8GpclLgZlFeltWqaCWNmYKySfTKnLXnnwIZ/VuhjvM
         ZXcyyWRtp2/y8CQW92pYMbxNUwSmdaJeaSRVq6dA7rucgIp826IFFxjOsh0CkEupq0zB
         MTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728747109; x=1729351909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqrfzHhGHBRU4qas/fWaWdVjOOvtCwlI6kja/taBS+k=;
        b=jt/QCDg3sBsHm9GrLY/f1otY7Bc8kodFtN1912YxowDNiy6DhBJA+a0cx0j4skxVMy
         61XjSqu/yHM7DSl6VefhLwYxZkzoCTkYp+mftJ+Wt6tLrsUcHyHfblm2grzyuQgTLEvE
         q940t1ROT89ekyWGpvffDuhBonFbGyCGsskYYmSDHidZ6/614F65a5XC17K5/xqDRi49
         eRY6YANrVVqA1gi5fuioLPkbq36OfHkLzTUhNArhBfvl6ogzYRHMyY2OzJCGeLQH/rB6
         6zEld5rkzquTnInSKVTSbt1hFNXDio7MTeq7R8A7fq1Z766knm11zj2xyOGxW9Z/1gdf
         22nw==
X-Forwarded-Encrypted: i=1; AJvYcCV8y1MaMLVWP9knPk8MT/JQ7/rTHY52TLpuah/GuOCR+TLI+JXHAkpO0jE/rczEnW2e8H1HlfflvbdRZQ==@vger.kernel.org, AJvYcCVzpM8KaNxeylHY2DOr3DMJJXcyeLOhLlUdbHHP10e3HlRL/0cXmRS64b9ur5t3a74sXg9rs4+lvMJgmqjp@vger.kernel.org
X-Gm-Message-State: AOJu0YywAKvl4/GvoMp7vWTWJMFeyWBABoUisoIiSUlqrfp2cZx5/dMn
	HxwikLsa+vZ07dgn2NLkL5+MzOTV34+qgcXMMzFVTZVcF6l63qWg
X-Google-Smtp-Source: AGHT+IEU/dUWEbtDbrU84eRd2lvwXm9J8lCAtYLyaD9UZKNtofUJgajwdqj5Z3qrPndv8r8LJOmaeQ==
X-Received: by 2002:a05:6a21:e8f:b0:1d2:f124:a1cb with SMTP id adf61e73a8af0-1d8c955c8c6mr4512656637.9.1728747108873;
        Sat, 12 Oct 2024 08:31:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448e3f14sm3274528a12.17.2024.10.12.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:31:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 12 Oct 2024 08:31:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH RESEND v4] hwmon: (sht4x): add heater support
Message-ID: <c7e82b2c-d692-46ad-af49-c1eb9f7219b7@roeck-us.net>
References: <20240930205346.2147-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930205346.2147-1-apokusinski01@gmail.com>

On Mon, Sep 30, 2024 at 10:53:47PM +0200, Antoni Pokusinski wrote:
> Add support for manipulating the internal heater of sht4x devices.
> Enabling the heater removes condensed water from the sensor surface
> which disturbs the relative humidity measurements.
> 
> The heater can operate at three heating levels (20, 110 or 200
> milliwatts). Also, two heating durations may be selected (0.1 or 1s).
> Once the heating time elapses the heater is automatically switched off.
> 

Applied.

Thanks,
Guenter

