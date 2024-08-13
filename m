Return-Path: <linux-kernel+bounces-285327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2795950C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A571C22A55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE11A38CB;
	Tue, 13 Aug 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1tGne9K"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07414A3D;
	Tue, 13 Aug 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573154; cv=none; b=VWdZxdlWgUY+UwapmmnAOHVwePyd2ejn3/MAX5cFoxnwH1ciclx48ufjsp1vPCbmpTzAxp/k+9stqmNoV3zfUQvvht3yeu63IPoT3lP1ZrUjNGjOghOV5sHolOdVuXMN+NjYNnDZEmQkWFo6Lk5dRek9eq99V4vrvUzIioArKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573154; c=relaxed/simple;
	bh=sFj26qQpzBYlFG1VeTF8m8dreyTi00Vu1bDP1Mdi/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyZYyjoqJAIKRRgqPHGC+NLUiwn2+ukc3gw28TKeI5zr9cnYkgojlHJZu/DiTRfQEN4freND5q46x4EjcdO9eSXRaBrMMgmIp2Ag2gYcUYLvIKlolvem2KW9sf4arye0gm5FrUMlT88peEarmiCyZM+WPD96/yRJmVcEJoOAqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1tGne9K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3709486a12.1;
        Tue, 13 Aug 2024 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723573152; x=1724177952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f2VUpdqzOXDYWoNzn9t99kD0EJs4PESbnM0xJtuO2w=;
        b=V1tGne9KTZ1xbWPD/8hrqIvHFxOtaM2QrjwzPNiAytkOO2h4nT4a9HTsaYy+FrYKYq
         IzhW3KHlxbteD4XwsB9dvr3kTVf3MbhtGL6zi40AZ0CAlacokvTtmFobxG3v0cf0HsWr
         m+mFR0E/VIhQnEUSqvnrB65E6X7nJJBOEmqJh6jSYCJ0NpA6rxiOxv+Jpdc1+jmO9T1o
         53Xpn3r6g+HtA4bGCXTd1KspCbAqNndOcLVMtTl6izxAorN27p1AHFMfSpHMDRD/JQZx
         pMgCH5YzxCV+71hswvFbLLZ14neaouv/6QH5QW4tyZI1EoQGwxlpAYZPoEyw/iKQEVc4
         ySPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573152; x=1724177952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f2VUpdqzOXDYWoNzn9t99kD0EJs4PESbnM0xJtuO2w=;
        b=nASEnlV2FJVYb2fHjGhVahpufbQRVjgSCV1cI76e6IQOktGoQKwMk0MLs5y/OsK1Ur
         zFazNZkyZyJZnRERB1Szp0UtIuI4DMAvn36PNp4TNGsrmLNGpwRtvgvhv+KCWgrnS2Vp
         v3Dh0I+gRCaGuGl3qJEjPhUVOLJem8gXOu90oLGtYm9WmrdgHoqUWynmrGWzWyxl84VW
         A1ofKR5+RuXjo7zhMxSY+AfK4LkEHF/o2gsuPj0pilQ/heKjj4QXz1Oj5TIYb9LHJYAm
         KY83nHtcNfwxutfCatta1tJQ/Oe01xuYT0ZuR8IMETp0TPiOxEZD3iUaP0hrv0EL0wwd
         M6jg==
X-Forwarded-Encrypted: i=1; AJvYcCVuqyE+9+7hm0ttrLiCzKlwv91BByDLHIMqbOX1o9PksjmzVFOW2hIDVeSaglxpPs3WCfi54MeVzz4m2hI3GWjaAuHUh+S+MoBK8dxA+g0dz7leudzz1K8wFJbtTubvUFE3LcthuRwadU8=
X-Gm-Message-State: AOJu0Yx3A91BMQkSLtaKkYETlL1zz6m89q8bop2WTXtYd9xmnE+grx+b
	2tMsc2N8J5kSFmVwiysdtJl+GEf4mNbsRzWQ64B2Ky45rL7avvgF
X-Google-Smtp-Source: AGHT+IFtXu8MMJssPzkmJhWbLZ5KP3AWeb1bOWT4RuChXMXUPP6ZmgYUUEqobOz3F9Q9cfMP4AOpTQ==
X-Received: by 2002:a17:90b:390f:b0:2c9:65f5:5f61 with SMTP id 98e67ed59e1d1-2d3aaa71897mr411235a91.9.1723573152024;
        Tue, 13 Aug 2024 11:19:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c82b6asm10966119a91.16.2024.08.13.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:19:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Aug 2024 11:19:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
Message-ID: <9c54fd98-7e59-4cfd-b005-64af558541b5@roeck-us.net>
References: <20240811001503.753728-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811001503.753728-1-luzmaximilian@gmail.com>

On Sun, Aug 11, 2024 at 02:14:41AM +0200, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> The EC can have up to 16 thermal sensors connected via a single
> sub-device, each providing temperature readings and a label string.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Applied. One comment below, though.

> ---
> +
> +	/*
> +	 * This should not fail unless the name in the returned struct is not
> +	 * null-terminated or someone changed something in the struct
> +	 * definitions above, since our buffer and struct have the same
> +	 * capacity by design. So if this fails, log an error message. Since
> +	 * the more likely cause is that the returned string isn't
> +	 * null-terminated, we might have received garbage (as opposed to just
> +	 * an incomplete string), so also fail the function.
> +	 */
> +	status = strscpy(buf, name_rsp.name, buf_len);
> +	if (status < 0) {
> +		dev_err(&sdev->dev, "received non-null-terminated sensor name string\n");
> +		return status;
> +	}

If that ever happens, it will likely be permanent and clog the kernel log.
Normally I'd ask you to make it _once, but I am kind of tired right now of
having to explain to people that clogging the kernel log isn't really a
good idea - even more so if the message doesn't provide any real value.

Guenter

