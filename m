Return-Path: <linux-kernel+bounces-177722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6548C43AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE512830EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F94C84;
	Mon, 13 May 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM99eoOK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F41C01
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612717; cv=none; b=e+/+LBpohLdPnJldSkCHCf1dpshQUxlQnPSjbYD0nLFsTjnYDLSV2Pt5ohc8v1nIhtAQ/d8iD8lF+NQD/POd5Ls2srMNZpD8itnx7MyKO9YEYsy46W7gUWeMSWs0aMysJNXUez5RnelEkDFFLL1GMYxxsxh5iPyZqgVyAqJvbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612717; c=relaxed/simple;
	bh=kPaX16GAumoLkoxVvW9Riw3RfFqAgptTl67y6E6jEmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T64Z5YUhukEdQsiSxKoJBqBAF8wCj5eITyU2uRoS2dmOeaKpgWq4MFAXnxPs3K6Lku8nGvRBKdnlyeIhcORPtQ3g6kdDsLbv1MDrXJ3wKmyWh3vBCPNIIP1Y643/h8BjIpUhTdz5sPCrpwMTdi2ybsJEduspC+rRnOu/jj58X2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WM99eoOK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715612714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyjE9PAfPntlI9F+E3R7TZESYJSzxOtguEEK1S0AZZk=;
	b=WM99eoOK3jMGdtGpzRVZEz40Vu7nXWbXW1+ytAoji5MFMwC+MwX8LXz2uQKxulir6zVhrR
	RSzalkqra8f04nZ9W3QRx9P3Q+hmvOwqk3lH5zM7krju5yoSJwWll+x+LSLjvMCRMd72Kk
	odf+BhzAkGrSK9HxibQ8QMg9QNaUspY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-HvNHvXloM2iajv0g93VnMA-1; Mon, 13 May 2024 11:03:52 -0400
X-MC-Unique: HvNHvXloM2iajv0g93VnMA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5206ef0d6fdso3992066e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612628; x=1716217428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyjE9PAfPntlI9F+E3R7TZESYJSzxOtguEEK1S0AZZk=;
        b=Es191bTb/h56AEZpny9DdAw4hi3lV9RBK5M/n4iNq/t9IXoa/ehHnWmb0uv9lURVIb
         MEkpSNCfw5lqDULj+LNgjHYaIfnh3Cgj9lQNAqrAZjLVAhoZCCuL6VBl62GaFaLQPK9n
         js6JszjGNt0rjLmZkX7XlYjHfZPL+1AsRD5Qjiw1t3N0l3ETLJc9Ur+mrrUUMcUTPUfH
         SZB3rM4nwNy2icijkK+hCygy0nKWF1C27jXvG/+QFCAHgQBSflVIafWpvVNaZTN0U1I/
         y8hYQEh+MuOvfRwEgigGK5j0WJNFPr3N4bnnp0feDddf6HV6/x57uQw4X5FoxQJenaD/
         bNMA==
X-Forwarded-Encrypted: i=1; AJvYcCVX9HuONjTFFX7VLsOmwhZT0SgUIYbtyr59YGPYmAgbsqT1twtYy4/3LNDsIPROlcUi5prAwxa7yoyifZ2fLUZPo/XLQOfds/jIcGVN
X-Gm-Message-State: AOJu0YwpXSb4097dnrx9Duvy99pcWGJxUi7cxjADDHr+q8q9C3iR0WnZ
	9e9S+KnbDUT+5UsY3Mq5SLRidlj/yqEWYUpnrzYqBIOuxErPN3Elpx0FbJ6xFODv3fkLyOiIYJV
	5jtpaIt9RU9qK3afwSq0QWWG1SdZz+6QkBYZIQ/us10e5ri4ZId3h3PCaFESA0Q==
X-Received: by 2002:ac2:46ca:0:b0:518:95b6:176f with SMTP id 2adb3069b0e04-5220fe7a008mr5844786e87.50.1715612627937;
        Mon, 13 May 2024 08:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPEzbJt9rhoLuAPJVxmbZBS5Is5DbsQzF5kOol2Qfa6kMaUpfMmI4ti7VSb0rQ3Q6ozKqv/A==
X-Received: by 2002:ac2:46ca:0:b0:518:95b6:176f with SMTP id 2adb3069b0e04-5220fe7a008mr5844774e87.50.1715612627379;
        Mon, 13 May 2024 08:03:47 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d708sm606825666b.41.2024.05.13.08.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:03:47 -0700 (PDT)
Message-ID: <9df151e2-c4db-4114-a6fa-1d9c732efa16@redhat.com>
Date: Mon, 13 May 2024 17:03:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] devm-helpers: Fix a misspelled cancellation in the
 comments
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
References: <20240503173843.2922111-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240503173843.2922111-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/3/24 7:38 PM, Andy Shevchenko wrote:
> Fix a misspelled cancellation in the comments.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  include/linux/devm-helpers.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> index 74891802200d..708ca9131402 100644
> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -41,7 +41,7 @@ static inline void devm_delayed_work_drop(void *res)
>   * detached. A few drivers need delayed work which must be cancelled before
>   * driver is detached to avoid accessing removed resources.
>   * devm_delayed_work_autocancel() can be used to omit the explicit
> - * cancelleation when driver is detached.
> + * cancellation when driver is detached.
>   */
>  static inline int devm_delayed_work_autocancel(struct device *dev,
>  					       struct delayed_work *w,
> @@ -66,7 +66,7 @@ static inline void devm_work_drop(void *res)
>   * A few drivers need to queue work which must be cancelled before driver
>   * is detached to avoid accessing removed resources.
>   * devm_work_autocancel() can be used to omit the explicit
> - * cancelleation when driver is detached.
> + * cancellation when driver is detached.
>   */
>  static inline int devm_work_autocancel(struct device *dev,
>  				       struct work_struct *w,


