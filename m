Return-Path: <linux-kernel+bounces-271484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5E944EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327BD1C224A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488113BC2F;
	Thu,  1 Aug 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsCKpQYl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5A3A1DA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525270; cv=none; b=jBCbVJT7cs2ZhbOdsnfQkR1ZJj4gqVVQNppdYUs61/tkn1bsDLqrPqxMM32ktl0zwUaA4NUloaCxaDyXNDSqhEZBkVcWuKTd5oh8P8s6t6YbOvVnjFunECKHm+SGfCPC/yl+jb/Xa3p2NnFaONtR9lzUL2rLBA08o1jNDDXEmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525270; c=relaxed/simple;
	bh=6zG896h081wSzZwTxbbSwGb+cRj1aNxaS4KVxqGaW5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz67FYEMuhD5gmqDCm7tK34f2FiGMYsxzhQLZps3qaISBrz1hKn9Wf7OvdmMjHbP6iCQDVKSAWHZgvWSzbg6SHGVXabLwMbftc1aNWfvkM2PmvA6cZhdOt9r/+L1UMjZhRElfQ9CdwrCtX0UonbpY4GzfXB4FA8E5CYIn2CzdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsCKpQYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuCkGuyhUvwr7K6Rptn/zJ7I8ssejuyGxAvNdiT19Sc=;
	b=hsCKpQYlle5S6v17DV0xPb8BrSmmAdlCgbY2WqUo3SwCyht0BFaymKaMdERqVifZzGMi7l
	EaWk3oE+ZVZZGOJtNgescOQrB3Wcawshb+blKrK5jl2OzyhBXkWTy4C7bZe9oEgi1vyfXx
	9XZFpiy4GJQXceLn9sUuq8EIlDI4nFY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-81Dux-z6PUSQIQFIUgBPHg-1; Thu, 01 Aug 2024 11:14:26 -0400
X-MC-Unique: 81Dux-z6PUSQIQFIUgBPHg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5af9df8ef73so3251422a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525265; x=1723130065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuCkGuyhUvwr7K6Rptn/zJ7I8ssejuyGxAvNdiT19Sc=;
        b=ZplHwGmcs3N3vCfBbsKQ9GN3HyR+R3lVmQsUqJkvP+Us0Y/mYD7udHBFtSST3m+e5b
         SD8BjNje0JynS+n82msjELUzCxCyu+004CMjpa4F3hLt+S18TmC2ejw06xXJf6JT5qZt
         fW9dMLnagda+XlFOhpwXW8+UYbHMg4LBXUd6St8qpFvTZZ+QI0GgOG7O9YJKoMz3nx7T
         /j7uPcdDZ4lKPbX86yPFSr/MVubr2klKOHEnOa6rL8W8wdOi2r664EfjBUC4zA75wJHc
         hdwndMSDBak+xYr51vYCCuDeEBhga1KjhR1GoRQ5P7teOCMmCmF+GFdMR5piJKl/kACz
         c6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa9hjRykEiceLqn5G8zwL8VsYsWtIBd7FlqcW9g6ZplH2pQ4pxws+XDXu60RtY3ibz7BU88bholkpaPxnYcqpBb/BhOBmrB+0MFsXZ
X-Gm-Message-State: AOJu0YwnsnrxSIVmIbAR1kMknGpvGiWANmTXouR+4G7pBmvfOvs3hYz9
	uDJijfWPrSm756ItnlLixtq4g35OE2a2Qs4jfDrXRt861cjg+5q+lamFRWEUru8K5lL4GYlWcw6
	lYPb1YGNBPirpII9GZst8CdaHKvNQLAyoTvkuXYB+d32J2vx8uNYr1AFwZeJ6aQ==
X-Received: by 2002:a05:6402:2550:b0:5a0:d5f2:1be with SMTP id 4fb4d7f45d1cf-5b77c2907f3mr1879072a12.8.1722525265342;
        Thu, 01 Aug 2024 08:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj4LCjAaF+V8VlhXK/sqH12Rf7Hd/3c/VAvvA4FypQ6qwCir32eUK1KIAGbf0dTmiuyK+YVA==
X-Received: by 2002:a05:6402:2550:b0:5a0:d5f2:1be with SMTP id 4fb4d7f45d1cf-5b77c2907f3mr1879035a12.8.1722525264801;
        Thu, 01 Aug 2024 08:14:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6358fa5esm10285512a12.32.2024.08.01.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:14:24 -0700 (PDT)
Message-ID: <8f6cb906-fb82-4737-89b7-15ab3c92d430@redhat.com>
Date: Thu, 1 Aug 2024 17:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use pcim_request_region() in vboxvideo
To: Philipp Stanner <pstanner@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20240729093625.17561-2-pstanner@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/24 11:36 AM, Philipp Stanner wrote:
> Hi everyone,
> 
> Now that we've got the simplified PCI devres API available we can slowly
> start using it in drivers and step by step phase the more problematic
> API out.
> 
> vboxvideo currently does not have a region request, so it is a suitable
> first user.

I have given both patches a test-run on top of 6.11-rc1 in a VirtualBox
VM using the vboxsvga virtual vga card:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Also both patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




