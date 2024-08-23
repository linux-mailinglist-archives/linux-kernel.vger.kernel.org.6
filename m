Return-Path: <linux-kernel+bounces-298371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85495C659
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B455AB24A10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8CC131BDF;
	Fri, 23 Aug 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sml99jDV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E246E2AE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397358; cv=none; b=XIzthSU1nBcMRLhlCHejdjAEok6OlFW+nz1I14WMFZeN+MNS+HUOqbjk44t8tArLRzqCbudMyxDOvFHHRDvzt2ye+7YJmu8wyKlwUGdp1c9QNvzzbqkWxxBRaYrIzy8ktquYwSBtXI39QNrDkyqKn8UFbVONcA8YPIf0VuExJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397358; c=relaxed/simple;
	bh=sHMIyFDLleA1iF2uzPc0fvhE4UKVJ5w9s3rfa7PjCqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKSKsrZgP6FY6S9Cx3iKEVAJ7I22nW8K6HEOLeu6ZL3eWTHMYdcq02lS/SrSQe9RmVMXSKMcTp9oRjWK3Y3vdZbBSLtP5c8e0J0VuyTzo8WvNbPVQlD+C4WgEAtVPWdS7U5coBp8WGI7JV4t8oWFAqxnhWJJwTIGJn1uy8WcJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sml99jDV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42816ca797fso12560685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724397355; x=1725002155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o9LnBsuiNCMHQ/tKzmi9+vKQXelSwNCK78V6qPKaPw=;
        b=Sml99jDVO9YOuURwT66x1hRywFIgeXm9InF+Vuj2MaNe7vsgYSFqvhMIRjyzm6YWKp
         tC1DleG3SjsUj+R0s8ZFigtIAJ4HlZCpBnH0rTj+6KV+hfj8tGipMqHdePPUgCPANVmP
         c7uNKIh7AlXvF11Sa8h/YscPFIY2iAX4lhtnlLhJZXbVzL+lVRF/He0kqff50F/w02he
         XdngrdROGfhEXWo2ZTzRa5NUU6LQpS/ICQk1rf1i3QKUnBQvCf4Xb1w00hKPipen4fr+
         Q3KnB4nSn4nZb/OCTYNbRxlHw6Z9n0rWGuFF1Bh0UoKYkog5DRkCfgt3LsYTlcKAuoQt
         NtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724397355; x=1725002155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o9LnBsuiNCMHQ/tKzmi9+vKQXelSwNCK78V6qPKaPw=;
        b=hmZHHDF7SMRan42WAuZ2mnfyOolBd/s0nZVX9Bj5Po3HQDq6aa3ZP550xMxFC1Tpxb
         dTd4CnqX8bftq18x2ntQrkYG3uE2wZj1BrxV/Zdxo1oXT7jI+3REQvsD2HPAZ3BazAwp
         LdIG4LqpO9uTnAKdYEETLifQW9BK9ICKgGoyjVfDztXx/ockr7JXz0gs0YsfOwr1+jmq
         /OotnVYS0aTvKQCiOw1VdbBICpNPnO7VYlhI2nIxE6lLlvFmkVs7OXOOwE6oxkBYUBfD
         Vrf8oZU6XMmdNYA+/IwtgIgXU0onYS9iW9YkycCcHCYycOwm2do5VJiPmLzmnv3BKraa
         V6mA==
X-Gm-Message-State: AOJu0YwpYHOHjkiF6BzUC5o9YPHyClTywMMAUJtVVCn5T1zPBOfU9Iy+
	QBpmCRKwaAafWDse02J50jwoYAZy2LEFdXo5A5KVCtAgSd/T8JBXynNLvM7YSsE=
X-Google-Smtp-Source: AGHT+IGfLUX6FiCQD9aEqLvlkupNRiJA9Jtn5YHBs6oOcP0HOnOW4jGGnqgO2EwuFThEywno6ZbecA==
X-Received: by 2002:a05:600c:1391:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-42acc8dc50amr8466725e9.14.1724397355118;
        Fri, 23 Aug 2024 00:15:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef8175fsm84486195e9.25.2024.08.23.00.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:15:54 -0700 (PDT)
Message-ID: <fd447ab4-41a8-4185-9913-b849b2c92d09@linaro.org>
Date: Fri, 23 Aug 2024 09:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: core: Rename cdev-to-thermal-zone
 bind/unbind functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Huisong Li <lihuisong@huawei.com>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
 <6093162.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6093162.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename thermal_zone_cdev_binding() and thermal_zone_cdev_unbinding()
> to thermal_zone_cdev_bind() and thermal_zone_cdev_unbind(), respectively,
> to make the naming more consistent with the rest of the code.
> 
> No functional impact.
> 
> Link: https://lore.kernel.org/linux-pm/19beefd9-d3f9-4d43-a45d-d241996de2d0@linaro.org/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

