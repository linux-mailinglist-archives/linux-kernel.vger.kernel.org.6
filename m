Return-Path: <linux-kernel+bounces-404386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D551B9C4316
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C80A1F21D17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A31A3028;
	Mon, 11 Nov 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qFfRve/8"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C0155CA5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344336; cv=none; b=i2jBKguvGvsrkwspACU9Tf2i5O8iNd/LYBGr9PT8rRHezT8z2BYu8iKA4ytINYhVBJJjVv8myz65Nn0vnDKwmvIZHp5OjYsRlhoBN5ERfl/wjgIgKSoi3zyxDjUhyBQU2u69vKlk+ACxp3cljTenH6x0EzE2gpIiYiM0rdkCVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344336; c=relaxed/simple;
	bh=ivypo4WOUWvrQoT8LvfhoQXdUHZAGcirjU7Qq8uXEDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaRSfhDeL3tyQ9cBA2fvIauOo1H7QLrCO3BHnkV1Lo0Z0NZFBSODlbCKzfMK318E/KDlaxpRSBM3o5oIdRh0ogi3SG53nvTX9YuW7Xk7w8CRNUu4Z/wAqaWmuB9iVB1ttkD82lK+xPImlNjXwdIV5PO9vtPJkdMhDAnrwo4JuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qFfRve/8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5eb70a779baso2326702eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731344332; x=1731949132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRXBULia7z7TLiIcVJlhflmrSeiQ9JvMc8YTlhNkPiA=;
        b=qFfRve/8bS16sG+cwr2ZOGNEVaIP+QNw+E9oc+5WWgRs2YGwoVgc6JUZuTXZojLoyZ
         wUmFnTiZI5v49G3rwnwy2rt1tMKqvbwh/yjE2FhKKKHcbctJWiWWTqeDJLdemIXwvt3s
         LQeuHTTf8XtccSnMD05i7G3ljsmSJVp2s/g7yqeO+z5Bg1KqDRujJUF5sQcBkzZ9YdNO
         uSK0mzE23LAZNgnSSiVuQxGki+HYcuc1SWYxjkKh35Ff64CB0WniV+xUBd7JmTuG/S99
         9W+k7kInI2YRLLJ4nZX5SXtJkl28ivzomwUoHdZmBHmp6noj8OrP+dCCtpbJ2JfKi/CB
         OUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344332; x=1731949132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRXBULia7z7TLiIcVJlhflmrSeiQ9JvMc8YTlhNkPiA=;
        b=ElJTn3RnACq/xrsMS+2u5LXgc4CU/OXozoxT+Qlh5hR+76MIFQ4z4KeVzXK1q1NmYi
         qswUoRsg8AIEWVFjvqtHgO/T/t+Vwz5Hvu3+zSHpD62IReTenIOyHje+Q/hYrm0gWyP/
         wRnbL9ZMcDTMtaNJDANgv2h/yaMaM7sgp+fesnU2TwqlfLHmhOKFOTfliEVpCy4CMzAA
         rpScwxvVsAskJfIPSdUphrJ16Qq1UiyK2oMUVdIpUXs5RcFivAhM0JJrudvdgZqtMbi1
         1FhpDOQw9URHuhNO6YcYh7HG2krAh1RhfDmToob+FEu2J/pBtPR8XRQ7JuU/lXa0r1dN
         7hAA==
X-Gm-Message-State: AOJu0YypF75MZKee7/KR5LHwSOsQ9xKbGLw01is3Z5/YBvt9boNK07DY
	HYtBe1rCYgGO4msaQS7V2BKFR0GPB4BL+PDL9Pnk9ut0i1vxW/Xu2QTCerd4gtY=
X-Google-Smtp-Source: AGHT+IG9gcTtOrRel7fsQEsUJUIH1JT/nHiJykQWFEDsIURa3LShSYPJ/+NuIdbyD8xv6Nn65K9Mfg==
X-Received: by 2002:a4a:ec4c:0:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5ee57a4dc2fmr9267609eaf.0.1731344332455;
        Mon, 11 Nov 2024 08:58:52 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4970a150sm1987595eaf.36.2024.11.11.08.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 08:58:51 -0800 (PST)
Message-ID: <8dee409f-4b38-4168-9316-1fd15c97fc89@baylibre.com>
Date: Mon, 11 Nov 2024 10:58:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: devres: add missing mailbox helpers
To: anish kumar <yesanishhere@gmail.com>, corbet@lwn.net, broonie@kernel.org,
 u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
 pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241106235217.94718-1-yesanishhere@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241106235217.94718-1-yesanishhere@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 5:52 PM, anish kumar wrote:
> mailbox api's were missing from the devres documentation.
> This patch adds them.

I've been wondering... Is it really that useful to have all
of the devn_ functions listed in the documentation?

My opinion is no, we can grep the source code for these if
we want to find them and we should just delete these lists
instead of spending effort trying to keep them up-to-date.

Or if the consensus is yes it is useful, maybe we should
add something in checkpatch to avoid missing these like
we do for MAINTAINERS?

> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 5f2ee8d717b1..8350a098f81f 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -346,6 +346,10 @@ LED
>    devm_led_trigger_register()
>    devm_of_led_get()
>  
> +MAILBOX
> +  devm_mbox_controller_register()
> +  devm_mbox_controller_unregister()
> +
>  MDIO
>    devm_mdiobus_alloc()
>    devm_mdiobus_alloc_size()


