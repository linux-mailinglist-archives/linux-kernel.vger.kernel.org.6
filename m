Return-Path: <linux-kernel+bounces-540665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E6A4B37F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD43B0891
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF31EA7ED;
	Sun,  2 Mar 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQjI4bWd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6F1E9B1D;
	Sun,  2 Mar 2025 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933695; cv=none; b=iUVQkuEBoN7xZdAmUOKEJKVSZgRWCLJU4IXm+cfK04Q74r79duZCUxqg6M5Upif+HFxtzpLVh8jV+Avi6vkHD7zN8XTiByYv+eXk0+3m2BN9+Bh0lV/EotzXWuIaPq1YYCNlTw1FbtJfR3AqRZXDabo+6ptDVKKDAcMZAjiLgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933695; c=relaxed/simple;
	bh=tEykHLpWHdGlU30tcuNXzm1YIjLCsDIELusYg/BpCjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiX/Bbv1SVZLldoM/1dZSpO+XTX6pIOgduKASPv3wqbZcQ5s2eD/lhD2LSNI6ujzgoa62L0jAGnTPoiE2PB3YOgwxbHjv7bq4UyUYtn/D4RrjWnGD8P3C3BobJ7UAVhAEzU01eZBKSnpKTBrV+YtFklKfDApAVCe20VNVMXx4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQjI4bWd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22382657540so17883275ad.2;
        Sun, 02 Mar 2025 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933693; x=1741538493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSqVId43C+d9NkwaRM37ZAAPDvqFWLEHC98L04TojJQ=;
        b=XQjI4bWdKEO42grOby0ywAdojCpAYugk9GOiFz0NPIpQOBADJfPzuZjBoiTHm94SdA
         DztAsduAWnGULXqT3PcAXJKU3ffQ/N+p5BNSOJsUXYKP8VcV7NgaBCYu7DkWewO3mpsr
         MO8qXCMlg8kSEUnWXtjc0TarwzucckTqiWnOdOnwFniytmnQEN1BlHyykRH0V6/6pjVq
         +IW6FFlhLrGBWHoGviCSdRqIzT5a3+dk/Svh5s0f62ZwkDALDW0NxM5d6qtIMk3l3VHm
         Vyb3E9Yp2ov9G+GqfzxXBIJnoYf1zAOfggCtFh2uKEzSunglhPThx0Xwl6jTNy1DRreN
         RAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933693; x=1741538493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSqVId43C+d9NkwaRM37ZAAPDvqFWLEHC98L04TojJQ=;
        b=YlREED0EGtUvl4OClmSf/P9LVvvwuR5bSDZ7fbDtad5CzZLUgAid2j216Gi+LFEEUu
         dSK1yrWx3rvCEI051kajzfi/wyQ+0SGMXy25dIfOmXPp6LvSH8MXHakiln4DbHAZjo0Z
         luWFOt9maeEbYXvG/yY2zu7iYBvNYv5rlC4jndTtN3E2ENpjqmd8SrOz2nmTUX1rk26k
         +0326Ii/FsuSe5FRa9EQgTUjMxvQjJ7Y8gpAcgYaOgxEJNXyBKA4P961t10pp9lyy8zw
         v8qv5i74tl5nNF83K2WenO4luDOVEBbPKc7i9wdzKO8sUGKJAvxhwAhT2VHwepzLO6T4
         Ph0w==
X-Forwarded-Encrypted: i=1; AJvYcCXtCzcwrIcyn9ATYhGzF0QnX12y1d+jVnQUihmDiIy0hnaYIQUR1162PuoAjpeZx4IhQmQ2vtXYNL3B/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbH0841+0mtNsc2JZ1YnLF6+RjuP18ofMW7nj3A9BBfFce2oz8
	Fdy6yjmdqccxfRsx8gBENwpAhvCjwpOTKabMe6QtGIbhB14FGpDi
X-Gm-Gg: ASbGncsrQIEfemuk1fbE96XtZz42HPicg+07KlC/Idl2rP7sUZ8vCUkO0mz/MyKM2mg
	PbmeTkOdzgJfnUuxo7lihcopqBuMhm7UWDTs9aP0oxGSFjdJ6hK7HzvyMGPRUuMJzz0OhcKde3l
	tstfPzXCEZHQHCPXvywU7DiC450YiVgHprN4ZnqP17TtLdMIbxSLs8cWXEfTExHVNz3xLygE1MU
	nVr3L3jQ2PGpNsh9ieCXCjgNQ0pslOlYNJtxVWPgr29+0TmcLfc+lr7YSIfW9YkJDKSvB2QzyUS
	BtDUqzqkEurZBt7bC/pt5bthrEmVt6nmgrV8BhoHeCpQQ6/5dBuZJUNVqg==
X-Google-Smtp-Source: AGHT+IGNojCJm9XiFhbHonpxzAZmoIpJVflYc/mmZ6BYZp7pBF+HScrO78L0oKjxUz4XZ2JWqegHNA==
X-Received: by 2002:a05:6a21:2d84:b0:1ee:cdda:b8f8 with SMTP id adf61e73a8af0-1f2f4cafd60mr18332062637.7.1740933693318;
        Sun, 02 Mar 2025 08:41:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736427c7290sm1682977b3a.177.2025.03.02.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:41:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:41:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH v2] hwmon: (ad7314) Validate leading zero bits and return
 error
Message-ID: <bfc22327-657f-4cee-914b-a2c0d19d7817@roeck-us.net>
References: <24a50c2981a318580aca8f50d23be7987b69ea00.camel@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a50c2981a318580aca8f50d23be7987b69ea00.camel@iris-sensing.com>

On Mon, Feb 24, 2025 at 09:19:04AM +0000, Erik Schumacher wrote:
> Leading zero bits are sent on the bus before the temperature value is
> transmitted. If any of these bits are high, the connection might be
> unstable or there could be no AD7314 / ADT730x (or compatible) at all.
> Return -EIO in that case.
> 
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>

Applied.

Thanks,
Guenter

