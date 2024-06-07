Return-Path: <linux-kernel+bounces-206750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F9900D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F6B23553
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B014F9E9;
	Fri,  7 Jun 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfQcR8D3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838044C8C;
	Fri,  7 Jun 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794026; cv=none; b=eczJwMaP7OGThkknEpZznpA9bOLGsuRqJcZitSH2znGsruwIY8jGQ70IECNqqyY5SscjosUVBGvSiXhjZgDCIxEDZb0Hj173WC6p0121iWgyE6dGH8f4xjEgkF1rUQ9lUA9UjraPrlsGObzjiHpDTL7xgUDZ9zYpWbH+6lh1V98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794026; c=relaxed/simple;
	bh=ef3MWoAXTfNUCcOtFjro99oNO2Ai0BPF9p5sAINVR/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFScaetZjGdB00Cw6+aA8edg5nJK+1Giv2HaHk+bzdmgI2M5kdaZaz6uSJRHL9r/xUVlnIOaOAGdGBY4k6TvFeugGyLlfIhIiZbs6Q7MGzq/5HtGMI+7xQ7Si2oI4r1CBIWx5DAERccQ8YMDs2UBy5m0EM+yIIMbhkpVewacNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfQcR8D3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c525257feso259251e87.1;
        Fri, 07 Jun 2024 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717794022; x=1718398822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QslBPCPaaB+ZOzzWf1yvlb/8i+T4YYI9EZK5xnRWDPQ=;
        b=bfQcR8D3ZUB38fk1MSkNbmf8dmDofk0eqd9xo37sTKZ9+XbVQwP0I/BnmtoLaO7aZH
         +dSRvDZWgFvtbHUrJ8NRWxvdTBIZXvcrbaioBa68lemUAdf0qefiXoWhd4suthujAruX
         VGnrvi/ie4S0gEl+Om3iD8Duu0eGc8DeFhT6WJcuHyQ152jS8eGz1PYyREqFioltKU87
         4dVSJaPzTdsGiT3hoTFZV4qBQixkrDtMu8Ot0nUrElCP5fse1u6tKIkJbhDSW1WNYqUS
         VhYNU4mzBZaewNDKcsSsnfhALvfze40oespa+kfEI50siwowPJtulI9DUg8c+W18iA8k
         /9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794022; x=1718398822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QslBPCPaaB+ZOzzWf1yvlb/8i+T4YYI9EZK5xnRWDPQ=;
        b=ffAY+pAcuOO3rpr8oeLS1EUWOD9LRmZXQkQx+oQ3z7oRMni20mn8xeXsjBFSmA7+EK
         H6dbvIUy4R1r+PF8gR8g5om9UAaLVKObNJdZo4SLcGFunN+JExUGQzcTYxFlmQZuDkar
         nQyDpE/aFrgjRZtWzRnZbWHdicoWn6HlcEzm7SRNfSGtirH9CQM8ukkZqeel3YaNvGqn
         IHgpCR4eJQhLCMYdMX0jOMfqQLg83x6+1aJGTnXdiyVA83P0wqjOe1UiTPOmNOmREPLf
         h5RK2NxJjPNqi6/+NKknf5n8lxxX8HF8MRTKIZqBPdTmiyvzUy778xjtLGC4/efK5XWp
         Uorg==
X-Forwarded-Encrypted: i=1; AJvYcCVx6o7SSANxu3KbyecR8mD6KUMlwRf56KoyqeJJ4hP7BeCguOyNHUmAGImTv+aG5TTmcWfDmvrqZcEljuSfJADcR0jtmEwRRGrQv6KJ
X-Gm-Message-State: AOJu0YyS2mDwXEEhqWAz14XWwkf6U/Sx0otluRaLdX6uJt4b4sym77iB
	l9YGJ5nB5krP8igjPGl1D0Wc063ZdNGmUi3P0vwOqt9RSlRei357
X-Google-Smtp-Source: AGHT+IEA4DbtGpy9qbGCiOpXknY8wt7xumZrRAf4VNqcZpLR8VWXTEmY/hS7flSaqdMT4zUtrg5RPQ==
X-Received: by 2002:ac2:48a2:0:b0:52b:ce2f:5d11 with SMTP id 2adb3069b0e04-52bce2f5df1mr617884e87.25.1717794022092;
        Fri, 07 Jun 2024 14:00:22 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c9717b6e3sm198436766b.13.2024.06.07.14.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 14:00:21 -0700 (PDT)
Message-ID: <0e0d9d44-d7f2-4dc0-9851-06b1f7290976@gmail.com>
Date: Fri, 7 Jun 2024 23:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hwmon: use device_for_each_child_node_scoped()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Tim Harvey <tharvey@gateworks.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 13:13, Javier Carrasco wrote:
> Switch to the _scoped() version introduced in commit 365130fd47af
> ("device property: Introduce device_for_each_child_node_scoped()")
> to remove the need for manual calling of fwnode_handle_put() in the
> paths where the code exits the loop early.
> 
> There are only two users of the non scoped version in the hwmon
> subsystem:
> 
> - ltc2991
> - gsc-hwmon
> 
> All calls of fwnode_handle_put() were in error paths.
> 
> This series is based on the master branch of linux-next (next-20240404)
> to profif from the scoped version of device_for_each_child_node().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       hwmon: (ltc2991) use device_for_each_child_node_scoped()
>       hwmon: (gsc-hwmon) use device_for_each_child_node_scoped()
> 
>  drivers/hwmon/gsc-hwmon.c |  7 +------
>  drivers/hwmon/ltc2991.c   | 11 +++--------
>  2 files changed, 4 insertions(+), 14 deletions(-)
> ---
> base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
> change-id: 20240404-hwmon_device_for_each_child_node_scoped-6e581c1d8a31
> 
> Best regards,


Hi, this patch appears as "superseded" in the patchwork, but I could not
find what series actually superseded it.

I just noticed that the cleanup in ltc2991.c turns out to be a bug fix
as well because there is an error path if "shunt-resistor-micro-ohms" is
zero that misses the required fwnode_handle_put().

This is something similar like the recently applied fix for the ltc2992
[1], but in this case the _scoped() macro already exists and is in use
in the mainline kernel, and no explicit call to fwnode_handle_put() is
required unless the fix is to be ported to old kernels that don't have
the device_for_each_child_node_scoped() macro.

Link:
https://lore.kernel.org/linux-hwmon/20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com/
[1]

Best regards,
Javier Carrasco

