Return-Path: <linux-kernel+bounces-428529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13599E0FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063321648EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEE1CABA;
	Tue,  3 Dec 2024 00:30:57 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B08A941;
	Tue,  3 Dec 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185857; cv=none; b=uizbpxc+IXh60lYY4RQSZ3SuulHoJF5yV7d9ZpcmVgLwdpGtLLNeqvMZvDKK01uNv7hNzeS90cQfv1rPJFXEiu4xG0UTVhecOMO+nF00NquQyo+pZQNbmCE/3bjNaEhtgyyxFnO5U9cjy+uP5CTXa8xdZ0TCBnaSHncafuvZcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185857; c=relaxed/simple;
	bh=i3WRUpl0BZLoxANNr42JxqL0CF66B0J3ZcaV8LEb3IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKh+o+Z78z11QeSvVC4aCMDgdOtZDvBEuBuxjDF/aN77zxmlQtq1s3M7WmsoZX/3tQCb5XaruyJ0W8+FUU0/heszcgDZ6Jfh/hxEwZ7R/yowvZOT0p/41ZfsVDNYWUybYFj9lJnRp+14PK5ORcUXRIkakkRXcsAZhxmLNadiwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so2371050a91.2;
        Mon, 02 Dec 2024 16:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185852; x=1733790652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rEKgMITY6eL0RJk47OCb/MNEcyttEyLYDtt3MElhYE=;
        b=PJ8juDj8/QfuKqz7ydb7I4SyuHshAHHMgmHsdyDLoGKPO28yrVLO7guji56t8OYN5S
         Ytv1NJrYg1PCWVR5dYca3yAlSCvLK/I1z0g3+n6TZWzo+gs1nqhv5e7rR8ZIGG+LxTQj
         mERGqtM16JPKvButic27lWV57FJ2iJNR2YfOH1Cnmm827LFB2nDmSySD+hFeVqTMLFHz
         nas3RWEtZJnc5gGYJGIvTahLiNQUL77wJalhjOMDTT6gwV/IYdQ35os1B7gfj3VHkqh8
         n9etYkiIOKlHp2zezc9R2EvIj9pJOZhMC3gw7tPF3OGwoRhTYYO+zFa2/iLAmxsAhTln
         CKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqhPBi2XZnXxKhEMXMAfZgRef6l7HP7ApK1hIHg2t8+sNzyfceQmrfLeVgtK0XMHbsygFYCgZbSkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEprR3PzRmF3Av9T79m92ZqwU/StY8owTwkLvOH6+EyleR5UM
	zPV92CTNLhgUlDkgN3QmD818KLtjVP9BhzxiLT/hlxjzAg3FMKC8
X-Gm-Gg: ASbGncunfJN6gW4U12gHzhBPpE41GLDqdXNUGpm3HZnT8Wjqmgd5zj3DBzMGTjGdIym
	ElgGVdPDDOWRGsXr1TykHP5eUhSPczGwBqzHAk52vE1UT0RubeBb3SmI37heQ1bdQS+ZX++x/4m
	Blzl5CDAflO3qMPWMdF3aXp3M9pmdRpvVBuq/P7bDO4mLKu2kf97ZV8TU950QKhKw5fJYZtHtRV
	yNRzTPJttwAnLzS8kuEhA2rGmehhQKVXe8GnfPVsnQqXyAyMhTiWcRPedPdGW8fZeU=
X-Google-Smtp-Source: AGHT+IF64s/rjJNZnYcx/5CAI5cVxhxP2TWCnsnHeGRE1N1g6MDcCexDyP479VeqRx4Te2WwMesFJA==
X-Received: by 2002:a17:90b:2f48:b0:2ee:c918:cd42 with SMTP id 98e67ed59e1d1-2ef0120461cmr772697a91.22.1733185852439;
        Mon, 02 Dec 2024 16:30:52 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180f7c4sm9167412b3a.134.2024.12.02.16.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:30:52 -0800 (PST)
From: xiehongyu1@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH] usb: xhci: Add module param for compliance quirk checking
Date: Tue,  3 Dec 2024 08:30:40 +0800
Message-Id: <20241203003040.1518504-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024120205-collected-trapezoid-9dde@gregkh>
References: <2024120205-collected-trapezoid-9dde@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On 2024/12/2 14:38, Greg KH wrote:
> On Mon, Dec 02, 2024 at 11:18:55AM +0800, xiehongyu1@kylinos.cn wrote:
>> From: Hongyu Xie <xiehongyu1@kylinos.cn>
>>
>> In the old way, vendor name and product name need to be put in
>> xhci_compliance_mode_recovery_timer_quirk_check, it's not convenient.
>>
>> So add two module param for convenience.
>
> Please no.  Module parameters are from the 1990's, they do not scale or
> work well anymore, please never add them.
>
>>
>> usage: put xhci-hcd.compliance_vendor=[vendor name]
>> xhci-hcd.compliance_product=[product name] in cmdline.
>>
>> In Ubuntu you can use "dmidecode -t system" to get vendor name and
>> product name.
>>
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>> ---
>>  drivers/usb/host/xhci.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 5ebde8cae4fc..2007c27bfaf4 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -39,6 +39,14 @@ static unsigned long long quirks;
>>  module_param(quirks, ullong, S_IRUGO);
>>  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
>>  
>> +static char *compliance_product;
>> +module_param(compliance_product, charp, 0644);
>> +MODULE_PARM_DESC(compliance_product, "Product name for compliance comparison");
>> +
>> +static char *compliance_vendor;
>> +module_param(compliance_vendor, charp, 0644);
>> +MODULE_PARM_DESC(compliance_vendor, "Vendor name for compliance comparison");
>
> Also, you have provided no documentation as to why these are needed at
> all, so that's not going to work :(
Engenieer from RENESA suggested to put vendor name and product name in
xhci_compliance_mode_recovery_timer_quirk_check for some buggy
motherboard that using uPD720201.
For oem(or odm), there might be multiple names for the same
motherboard(or same design). And put all the names in
xhci_compliance_mode_recovery_timer_quirk_check might not be a good
idea. So I figure using module_param can do the job. Anyway, Is there
better way to do this in kernel?
>
>
> thanks,
>
> greg k-h
>

