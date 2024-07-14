Return-Path: <linux-kernel+bounces-251686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448B930834
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A324A1F218E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB66525D;
	Sun, 14 Jul 2024 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1SU4IkP"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24A7F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720919935; cv=none; b=uiEDTfVbmiijrakZAg/gq3WwND/JmQXchshSdcThVJHEro8KLpUc7zFF+ask86TD4G3PLrl0CS0CkxQGBHNusSn9m9DWltKvZhteu+n3VsXY3/9AReaFntOCcXt5j7jbsvtHg+qL+J3flyFxIoXLo4eA/HVXA2NJmuh+r7GcI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720919935; c=relaxed/simple;
	bh=XNl4SIRsyUzlAgwEKX8UHtR391X6Ugl11Xr4ci7cOG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGS94myCuV8xyVV4RYh7CZuZY7CVO0xkL9lwzN2p+Pf7435Md8InQu5Efzn0KT23EBzqf4BAjIIWDe2tCfp/nY/chXXC+nYfWv644h/cljmXipVzH7+SD6rm5mW/ppj88s2BVlC+X/rrgkApknQm7Cx1llBPHdk2I99VO4uuMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1SU4IkP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e2cc76becso1467314fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720919933; x=1721524733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPJWV+XXbidTWRNRU70s/IEwIJH02vBiz+D5u5cJT6g=;
        b=U1SU4IkPCMvIRa4/9uCq7U2I0yXzOAiv910FePbfR4hLAM+yy+7h86ZTBWJgp1bHiR
         lITntbX2rM5UvXr5/FKdyNsTsPA0YseXk0HBAkV+/jGwNMlSjWqwoDGU6Q4S3VMjaSH/
         u4kzo8u4qjJDK7PlNBYSDGJRQ9/PeG9mbe/91TPj9/p9WIPrlXh5N+rfO7hOqdAucAYv
         6AMvVaJOb1uZIHXVxaK1dlqFms9d4ve9/VW31KBdudM+ax5fsc37sfBZ4aE0vO2TKE6W
         RmhmBPelbN/jCXsCeUHEQI/Xd0J2wDrxfP2/rZdku/lpGJkdq6cwf5xJSx0MZdsUWDhM
         d8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720919933; x=1721524733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPJWV+XXbidTWRNRU70s/IEwIJH02vBiz+D5u5cJT6g=;
        b=WrzqHhFTloKIrsYUfFyRz79yYmC4TfryqzIl88Ezymgfxy9V41a00MpErvd35sruAJ
         lTXC9LrUrxbp6ci/e5CquOI09lvGSC2+rIJEKACoC0jdkCCYFBPnovCij94FMuRaVVgq
         2uLpYzd5NF0lCtQzNY5Ht9xDqfDV3GX5cAY/rjR/m2visEuI5aBMuzGHu6B/lnw0DmE6
         TyG67IPc1SqDBBg3gmUYFbzG1rC8fsd18FhRTJXruIpKMzIcQkx8PrPmQJzlM8yija25
         SeHXlC+GeQ6NMhsZTF5OVd94cCR7Qj/mxJYKF/0M2abn59rSmv4JhrFRRyrK12DWB6iT
         1MOg==
X-Forwarded-Encrypted: i=1; AJvYcCXM865a5f+AKA8lUe38uaD4r0OkrmQHYa//Xy8ssNmL7xBE52az8lP//+zV2uJ3e0AYMD8MpjujtYcgpMWh8fyAsxV1NmI0qozo+hpR
X-Gm-Message-State: AOJu0Yypt063nIXcLVXWX0nA0i49kbp9NlpEslZakx2//gWFN2tixQbu
	oi9gZok10DPqy8TcdUnwm164Q4LIE2Rvv0OUugjsPGw5ptj9dz6BHUoaWlz4JW0=
X-Google-Smtp-Source: AGHT+IEhXK7JJdtVcSXS0unCz6UTyQGtaX/ZzHlDJNGAIFYSAg/Rj9679ty3v0d4eWraFv/K/1qqHQ==
X-Received: by 2002:a05:6871:591:b0:254:d05e:4cd5 with SMTP id 586e51a60fabf-25eaec1f34emr11755860fac.38.1720919932883;
        Sat, 13 Jul 2024 18:18:52 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3dbfb74sm362358b6e.12.2024.07.13.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 18:18:52 -0700 (PDT)
Date: Sat, 13 Jul 2024 20:18:50 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, ukleinek@kernel.org
Subject: Re: [PATCH] eeprom: ee1004: Fix locking issues in ee1004_probe()
Message-ID: <5eda1109-5656-4a0d-9444-6a18bb1b382c@suswa.mountain>
References: <20240713234813.21746-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234813.21746-1-W_Armin@gmx.de>

On Sun, Jul 14, 2024 at 01:48:13AM +0200, Armin Wolf wrote:
> Currently, the devres-based management of ee1004_bus_data has
> several issues when it comes to locking:
> 
> 1. It does not call mutex_unlock() before returning an error.
> 
> 2. When encountering an error, it deadlocks when trying to recursively
>    lock a mutex.
> 
> Fix this by moving the mutex-protected bus data initialization into
> a separate function so that devm_add_action_or_reset() is called
> without the mutex being held.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 55d57ef6fa97 ("eeprom: ee1004: Use devres for bus data cleanup")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

Looks good.  :)

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


