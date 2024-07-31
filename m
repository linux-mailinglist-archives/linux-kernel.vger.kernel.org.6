Return-Path: <linux-kernel+bounces-269449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EB9432EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493AAB2AE79
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3717991;
	Wed, 31 Jul 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/mfiNwC"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4301758B;
	Wed, 31 Jul 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438624; cv=none; b=dqpQaE1/bGNlk3UV/4OYGv82LLkzp9Iz5HqUPMt4YTbVHcBA5elosCa/nVPj7p64u/HFv4+1Vt/sCNcoyIcX0sbtvJPpydNDB+RMuSMI2YDpcYuzqKDUzlWpiXpNjmKj8oGCBmWBYPhchfgjC/LiCGx+IZ3jAWWyfiQI8F2Oxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438624; c=relaxed/simple;
	bh=mg3rwHUBRj5NFcD84jPC4GZQa5CLuMZgrhGUzasiLEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMHmPu7h25Kx44eQEj/Ir63WnbtP6WgPDZ2UWTZUfWR2qrn82SfxL7gY2CQVSyMmsvsIQ4vM5qPuOlZeozJaU0n1d6Yranxk4TWvUsuOwRbkGDkwU5uAUBkgtAb+zVRBHfh03bTpaC/y2Vc0KWuBhZHXfpJcg+0XNFMAYIYxQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/mfiNwC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39865a15900so20983375ab.1;
        Wed, 31 Jul 2024 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722438622; x=1723043422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI4Uz7WpMjZ/bG9q7ybNvSKLCB8PS92F5Vl2OFTuldo=;
        b=N/mfiNwCyRU60V2X4RqYqHalUxxCMs9B3r1jYKNx2A9R0TMQXCQnTA31b+QStgUedl
         /0AmtHn3UVF5QmgMsK2Nk9ycy9RCdaTttiUrG8g4eyckEC9B6yc83HdzK/73+GbkYNKY
         yFsJbpWgrpTphVJqpJIE+e258NDhXIxbCa4ACR7gIM6kGeLxPw/KtgOb7YMut4iCF2tk
         VnzNYYc1SWOXq7OseJdXPtPfwGgaEFA7VbiCJF33DRmCki7LTJJzv4xix2u378/Rakgx
         fHk2/pf7NxdhbcDrfaIwrfie2JIli42fjwv/xv1AXFWAsdqUxfiTFgnuQ2hCNIUh/5Ok
         OW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438622; x=1723043422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NI4Uz7WpMjZ/bG9q7ybNvSKLCB8PS92F5Vl2OFTuldo=;
        b=V2yBowhxL8ftZWRZ/OdsNYLo3kRawHGXbXIhXIp74N6MRfmCDmHLE4FuhzJHVCAROa
         56m7rlKFZGm7l7R64NTSjleV9/yuv5Xy8vTlEVZme83v519mR7RJnIGgx/vROZ5y5Vuy
         P3qUsN98MP+0mCxV81dzHkX0DE2VcsG3aqrKH/2p6ZZipqjDzZ8aoMBxmjJpPVTiqBG9
         t7K1pZiwxkxZO8oMhTdzLzNGdEkk7ArjYDtvdLtE4vRoW93Cvu1xDkzuEK4fESu4HKso
         DFCF1n+NYHPWlNJpSvjR+hynt5h68cC1mU87cEYUYKVJksxpy+NPN/Bgdc54etCGseXM
         Sxtg==
X-Forwarded-Encrypted: i=1; AJvYcCX5pE91fznsu4Wl8J+XdSuA1HnIEnwIr7vHY7qFEkucVkd2AEABpSPqI92SVen2PbgDGJ651v7Pn81DUOPdLjkdGoX1Xs9S7j8VJvQtHgX/srZd74a7FkL2Cb0VJhQP7AyRcO+GxU2HPtY=
X-Gm-Message-State: AOJu0Yw9tjxbHIC/F/AEfcTRjZPX0mrr7DDJ3pDpWcv4j/h66vo2y7ii
	xglNwZ1xONgWedWOmvsZPQDPbS4tZPGn/gRzYC16SBPxk3oqWy7kvYE02g==
X-Google-Smtp-Source: AGHT+IEY7/ewQuyHW6YInhVwwomKxOmW1tQUBn36xyssBY/9z2RHF7Z8NIZ6MGWs0qQ3WJPBNGfCkA==
X-Received: by 2002:a05:6e02:13a1:b0:39a:e9c4:6baf with SMTP id e9e14a558f8ab-39aec2c9e0emr164218925ab.26.1722438621801;
        Wed, 31 Jul 2024 08:10:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm9043938a12.24.2024.07.31.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:10:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jul 2024 08:10:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Ross Brown <true.robot.ross@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E
 GAMING
Message-ID: <1a473986-f174-492a-a779-0c79c8692498@roeck-us.net>
References: <20240730062320.5188-1-eugene.shalygin@gmail.com>
 <20240730062320.5188-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730062320.5188-2-eugene.shalygin@gmail.com>

On Tue, Jul 30, 2024 at 08:21:42AM +0200, Eugene Shalygin wrote:
> From: Ross Brown <true.robot.ross@gmail.com>
> 
> X570-E GAMING does not have VRM temperature sensor.
> 
> Signed-off-by: Ross Brown <true.robot.ross@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 6bb8d7b1d219..ee396f21fac5 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -420,7 +420,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
>  
>  static const struct ec_board_info board_info_strix_x570_e_gaming = {
>  	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> +		SENSOR_TEMP_T_SENSOR |
>  		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
>  		SENSOR_IN_CPU_CORE,
>  	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,

