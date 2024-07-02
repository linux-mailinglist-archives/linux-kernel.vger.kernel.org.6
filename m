Return-Path: <linux-kernel+bounces-237613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC158923B81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D06C1C21BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EFE158A27;
	Tue,  2 Jul 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE8LTcyI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB914F106
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916467; cv=none; b=pcgQTy43pdMcC5wb4WDF3NA5ET7NwK8yHR3mkN3Tfmn3qSS//k+98NWmWJSfKeAjCsDjy0wOhribquazXc+RrumnkHhe/12Nj/3YRIWdkv5Mgk5AfSmO6WsJnxFZibVWrCdRNrYIpr44TAakvNo3HVagQGC+AjSHNsLTJeADx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916467; c=relaxed/simple;
	bh=x2/Oyy5DPkl5NQW/LRGwjK6gfV4hKaQ5VLGj0MD35GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azTdWpH7guYANwlySCjM5U9qyl7GSF4MsTjYUqddGxqNAZmQNFU8tR3ixlfZnH0Dnoap2+KV5E2YlF0H2Uc8QKhqDti45nnT0xPlNWrv+hVuxnqxWZ2VYCZu77x0OzIf0p9Kojh1ho9qhzHnxKvm4twa08Hq5xsMSLtKlZ+oyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OE8LTcyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719916464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNsm3cCjXERmJcGp+XO8HnPAr7s9nThDQztD3pwHsbE=;
	b=OE8LTcyIPdNur7RH2HaVy8o/ejBK5o3AFBkyUhPTFXwqmTV9JEFZyhGC7GJJAYUKkPN/uJ
	jyR52o5RwtlvewdgfGnpKggYSl/p+woOJ8HRks2evdb03pLOYuI6NSIN/+v6Ng1FVYk6AE
	BXduoQv9OxsGoJgE37Ym65E/UA4OfjM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-iYmLFyrGMXiMeetp0IqG1w-1; Tue, 02 Jul 2024 06:34:23 -0400
X-MC-Unique: iYmLFyrGMXiMeetp0IqG1w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a72436378bdso329131266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916462; x=1720521262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNsm3cCjXERmJcGp+XO8HnPAr7s9nThDQztD3pwHsbE=;
        b=LA6RIYRr4aQ5dtOOuXSLZ5Yk2FoMv5V4nS5oDGsElyDpIZ3XnfSUjE+N4O4KnF/Ai/
         V7nY+4QPclksw6hvpPiJd7X8Whk7+tUQHmSyg58JBEbQ87GPZ6YVW8LxA3jaVejPoGRq
         nC7/xKtTTJ8iUxu/CmIgMJsCN2FKqGPLlACBaCf6aKAD68zLWN/eBlLR3PhZqZTpId0e
         0OVZNY1CwGRgGqh6jVPdsF1HHSddZQp9BLUbfIkrZWFfD95QMHohBQ+hYCwZjx1wQmMX
         gTEUONJkYqi2ChuXA9Htb5XUFSKEkcYbQN8MypXCciWow9PfmodAfyv50JWkbZugJFO6
         R/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHqi4aTaTg8iIaN59C4JmnmOxdgVyg1nhB6/9BX5OSdMZcD60TJdHfs7kZCXVReawz+BR70q8nN6HJF2aA8cBH1NfBsDmst45WpVnC
X-Gm-Message-State: AOJu0YzlDBRdtfJBIyqzlnIbfZPrGma5DTSpc575XcNx8H+TbZys2mbe
	HDllR9/0RO3cNxFRksr4DB2nrU7pOP9hBVZRPkqZOIZxUOmfvuHMx0bm3Ke0uStxAboYb4ry79I
	QWrYLmpiZR4DhVYnUXk6wc2he8+OOzjNa9xVEKf2M+elB90bALdy7C9rE0lJTMg==
X-Received: by 2002:a17:906:594:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a75144badc1mr476047366b.51.1719916462667;
        Tue, 02 Jul 2024 03:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE02tMzwHkCasG8ml1t2odshm6nGKnezRzG5G+/ON+FwptvvDVPwLlQ1cIbeXnlAmgbhRORow==
X-Received: by 2002:a17:906:594:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a75144badc1mr476043966b.51.1719916461239;
        Tue, 02 Jul 2024 03:34:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cf7csm408654466b.155.2024.07.02.03.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:34:20 -0700 (PDT)
Message-ID: <bd635e11-53b5-4fde-9802-ee2481bfb777@redhat.com>
Date: Tue, 2 Jul 2024 12:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] media: atomisp: A couple of cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/24/24 8:43 PM, Andy Shevchenko wrote:
> 1/ Drop a lot of unused math related macros.
> 2/ Replace homegrown static_assert()

Thank you for your patches.

I have merged these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And these patches will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans



> 
> Andy Shevchenko (2):
>   media: atomisp: Clean up unused macros from math_support.h
>   media: atomisp: Replace COMPILATION_ERROR_IF() by static_assert()
> 
>  .../circbuf/interface/ia_css_circbuf_comm.h   |   6 +
>  .../pci/camera/util/interface/ia_css_util.h   |  11 --
>  .../media/atomisp/pci/camera/util/src/util.c  |  25 ++--
>  .../pci/hive_isp_css_include/assert_support.h |  23 ----
>  .../pci/hive_isp_css_include/math_support.h   | 110 +-----------------
>  .../pci/hive_isp_css_include/type_support.h   |   5 +-
>  drivers/staging/media/atomisp/pci/ia_css_3a.h |   5 +
>  .../staging/media/atomisp/pci/ia_css_dvs.h    |   4 +
>  .../media/atomisp/pci/ia_css_metadata.h       |   4 +
>  .../staging/media/atomisp/pci/ia_css_types.h  |   2 +
>  .../kernels/xnr/xnr_3.0/ia_css_xnr3.host.c    |   6 +-
>  .../atomisp/pci/runtime/binary/src/binary.c   |   2 -
>  .../spctrl/interface/ia_css_spctrl_comm.h     |   4 +
>  drivers/staging/media/atomisp/pci/sh_css.c    |  38 ------
>  .../staging/media/atomisp/pci/sh_css_frac.h   |   4 +-
>  .../media/atomisp/pci/sh_css_internal.h       |  15 ++-
>  16 files changed, 60 insertions(+), 204 deletions(-)
> 


