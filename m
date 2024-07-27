Return-Path: <linux-kernel+bounces-264288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED793E148
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 00:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0ECB21474
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0085C41C64;
	Sat, 27 Jul 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkX/ghSg"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C8374CC;
	Sat, 27 Jul 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722118146; cv=none; b=PV5GngbAKi+KcEFcWC5DtL17EaRSMD9SIxaZX6BjxySG3ukBdwU8qBtak4MYe0QFmvAnBuOeqKcL8J591n0WdlzpFbUY8yyh9o2oNK08QA6KVe3nlES+zeQm4NFqrstKDTnbgxzk7JS9MiHY5/zbbAbhatEjZW39kw3TSPuaW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722118146; c=relaxed/simple;
	bh=GzadQwjoQzzX0lmnM516VSn1xtch5w/RYIg24gk/3MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En2tm3WP6xceOksPP8mUo8gAizNq4wzZKHpR5OXRT1l6MwMrE3EkWXsCBxMW/F2QFbNK52h7wIAox+hWACHs4eNH9WSwlHcY/rQevT+taJDXWOHzbN+pv2NWCnnTHs0FXhK4bY3PU/mp4Fq/ItU14JCTBW5nJZ+XjvNETlEoJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkX/ghSg; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709465248b7so353541a34.3;
        Sat, 27 Jul 2024 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722118143; x=1722722943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaFMrKlbHFJcfn4PbrnnnsUBc8VoxxJ2+yy9JoXTL8U=;
        b=AkX/ghSgabQaidwjtBm0Bm4BN1ZativAPcEclyAthCzUnqqms48cO+nRTyqpC/DXVK
         RRDjOEAPY7QCs0tKsnPqZC78/wXsXJcWdk50jUYvCcvNWRPVBiRjZ4ZVDHkwqzChfZH1
         GVJu6SMO1t7UECm5cIS/42If7YgsdasYJB0yyvrHkKGo7wCClFP+pvxRiYefgIZOwBY2
         6rAzQlhrKh85o+7IU1WBphm9D9MJtQnTYuMYOeFe5RFlbkAiSPWJRFaEmw22oXyxJl46
         +JyNP4DudXFRrqotP+kaA9vvVvfyl5kWBIqhPoog+9r/qmEX9RT8ekQTfsjc4ef00g4M
         c/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722118143; x=1722722943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaFMrKlbHFJcfn4PbrnnnsUBc8VoxxJ2+yy9JoXTL8U=;
        b=mrB3SSRKZ1LZkZ0yr35XieoNjh3srV5pyLM4A6MFudH9NwjbhhjXjYemllo4UR9WO3
         fgreSOpWjAMr9AAggzMgPxpMU88YuFltEJKKheFL+yQDb501yX3Oxt7UKDZAEywxB9Sj
         kQxS/TTHkVN0F1HURxPoD4AuXjnriQiG5QGrihYRn4GTvYKYFZIoaGqWpdguigr0jK/Y
         6Vix9+cj92tVP289dCPc/sDO7A6iEYrpVcw/8quvy8QEPzCChzw3iMPdZ854pOKubjxR
         gHOMXeXm+CRntSB1CLZI1B6OyurelYBsndUfHGv9y5+bFKFdiDwdjXJT2xj5sFIeF3Vg
         5XQw==
X-Forwarded-Encrypted: i=1; AJvYcCV2H1Em3wywyP2kCrCzyIL1qVnSj4V9kBHng6Mp11H8g6usd3NEtSJn51wm6YvVeyIDuCLwHvB+KFz1AwceQFPkULcY+NHq/KB320VdSD86QgEDm6JPK5aiwESxExEqjAuf9Syw92JwMdI=
X-Gm-Message-State: AOJu0Yz15tc+zUGi+N/VnimELjmUrUMwbs9p7rQ8FESqhEGLO35lw5Ng
	fYgReKOc6lI48vWv3DEFRoO0MqkXKkUSiCtJ6I54JDNBDrdjUWee
X-Google-Smtp-Source: AGHT+IH9W7PFbImoTMw86FAU66Y1ZcSevxmTXjh5hVgoGTQwhBxbYh4gjC6s4ZTTib93Gwd0/DwbOA==
X-Received: by 2002:a05:6830:3881:b0:703:6845:ed89 with SMTP id 46e09a7af769-70940bfe10amr5363485a34.5.1722118143546;
        Sat, 27 Jul 2024 15:09:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738fd4csm7841629a91.3.2024.07.27.15.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 15:09:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 27 Jul 2024 15:09:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: RobotRoss <true.robot.ross@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E
 GAMING
Message-ID: <8b2949b0-63e0-4250-a313-9664f714c4b5@roeck-us.net>
References: <20240727170604.9149-1-eugene.shalygin@gmail.com>
 <20240727170604.9149-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727170604.9149-2-eugene.shalygin@gmail.com>

On Sat, Jul 27, 2024 at 07:04:52PM +0200, Eugene Shalygin wrote:
> From: RobotRoss <true.robot.ross@gmail.com>
> 
> There is no hardware support, it seems the sensor was added by mistake [1].
> 
> [1] https://github.com/zeule/asus-ec-sensors/pull/58
> 
Such a reference in an upstream git log has little if any value since it
may be deleted at some point. On top of that "it seems the sensor was
added by mistake" doesn't really add value either.

"X570-E GAMING does not support the VRM temperature sensor."

would have been good enough.

> Signed-off-by: RobotRoss <true.robot.ross@gmail.com>

Hmm, that very much looks like an alias.

Guenter

> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
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
> -- 
> 2.45.2
> 
> 

