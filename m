Return-Path: <linux-kernel+bounces-519966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934BA3A418
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC83166F75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C6270EBF;
	Tue, 18 Feb 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvELKrz9"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974D246348;
	Tue, 18 Feb 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899302; cv=none; b=WYg7McGqRfNpJ+T0Kxbv5sYyWH/U9GUaEdKeOR7GWg9kwyNwHs4hq5DV4cmujLU6TpRd3d72SEk9uH00HWHeU77EhL1+OdS9BO8f2w3/GQo0j93qXw+gz0LldD8TTfkjxAMkqIIFAlqoRLCf+dmpdeG/CLh4nXsmUuiZmaoznyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899302; c=relaxed/simple;
	bh=RaFrchUHNvXgjR7C9k/y1msQHecC4s/ei/HRkQ7yBRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMv0+7XX4u8NWpuXnMgWqJeLlEs0M+yhQ2vbQj7w3B3H+WJ/vH5CfsM5whB3DhslOGPLTT57JhqjoYFaVAxWi54VyLurXTyM0RLkH/YdtcbxHJT97Vt0neaRT49Bb457EvefxqkWo1jgTS78wJi/bhCF0iHv0Sjgz8DAaGEt3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvELKrz9; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b38896c534so2913971fac.0;
        Tue, 18 Feb 2025 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739899300; x=1740504100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bcln5oI8K28orNNqbjHGMYoJeMfc1JfQgrBVtXkPSs=;
        b=SvELKrz99flJBSbi8fX9kwVFw5s9ouOlaTL5XGektjJinyST+YguGKFLH2YWu9uKOa
         5+gstFjD2/8Mo0fVaSiEWOFR61vF6zRskqkDhqCFa5MJshFEO7CyX2KZZh+b96Ori6u4
         JaEXrbBTGFa7EeHBQOmqTzTtomOzKPCtHG1kcV7z0r3xVg8hTfXhVLXAoSVqWp2VbBPg
         AKGsJQXpoa9i1RgQu2PEOslAlN9NavlamB0dkECgYyzRIxKCwY7aobFe3vM89QFaa44g
         imGHldvjrHJ2/WBdM5UVX8lh09Xy2QAAHplQ9Mx25NiW2vlFUo+AvPkX7uk6yEnHgusr
         ntkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899300; x=1740504100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bcln5oI8K28orNNqbjHGMYoJeMfc1JfQgrBVtXkPSs=;
        b=O01uGYTG7TGeUJFjfiOt+YsJMrp7qaxbMiKl3auSg5WmJJUVILJPdrL1jJKCrOQuDi
         /NCXaGVFAPktOJS2khc7BGp2qScnftEASu2kiyUKm4ViTzFTimqJEN5frvCiIGNmrdJQ
         2iIrGXxvNoxYf7Xm8O8nOKwlwjTDJk6k0+w9ESqwCLvbF2tCTcDIwZpyG+OKk8tw93DM
         q+cjcrnMk5tD5clCxk8Rvcbx1dvHP8vA9GMhSIevDw0gj8KKBGwV6aOI0zBYjMBAkJN5
         xW2Du/CwAXv4d+NRDhczUVogd9u0OncWPxepZwpdXprwnlSPrdk8VgjJFy5gu16yreBc
         Ttgw==
X-Forwarded-Encrypted: i=1; AJvYcCV+jCx33o/3LjNvIRI/B7WFYHa6Zx4pDNJBWfK3dNDPY2S68RJQel8McoqWlxmwOiYCF1PTNeHiFNgc@vger.kernel.org, AJvYcCWRfs0QSH9LRb4fg8whUS/RM5hhgtuKB9bCi3bKsCsQct4e5aBIlNSnRz2rc4z9UhJWoXqAJc8JxJg=@vger.kernel.org, AJvYcCXqcfGXD280q/W9tcLp51KrkkSobB+A4DroNjMtlgkddyUT9NDHf78NnjruQPNRmAGdN7wzxKsMmbkZ2TjV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyua9N/3p0+4Hh2AxIaUX0SED13t2887g8jEeZfl4DQ1Ms+SmvV
	M7dmsl4AE5B5wVcd5+4zWyG3c0A7KGP+IjrQ50E6LZrP113NP629
X-Gm-Gg: ASbGncuJEubPCahgWSVw8t8KAVQ9LBcKOfDrcBPs/YyyhwerFoQPuwc5U/J3NbMoJmd
	wS6i07N17eB40+lVtIWmb5lSkwwiZLeRUJlVvWncBZ3kt+bGd9v7fbHW9rX437bdgVkLB+8Qmvd
	v3RtHBQHycrcSG4BA+qft6m8KAUQgAT+1lBNge/D+v2a4BtbZik7zMlQ6T9DN3jL/S8M8hImYZC
	ExtOQCoBe5q2oASXZbgR9kVysWjyhU5YcM4+/DkfIVH5kkJhJNn7MIvDxtad9gVVFrHqaSU8PWf
	AQbffKJSjmO7JQxKHfpbGDrKSCoZ5uugkcGxIarB2olkSH3E1E4y4fAfuOCw/t9Eh1c6ZPAm5bF
	RSkI=
X-Google-Smtp-Source: AGHT+IHZpaIB9LTXkiJZWg2osBqVSzIJ9naPlRNqVlqVuaAFzeRjuO5dX8FMhjGHvmG+ygfS2UIhrw==
X-Received: by 2002:a05:6870:e97:b0:2b8:e8da:e89c with SMTP id 586e51a60fabf-2bc99d3fcc4mr11051533fac.29.1739899300285;
        Tue, 18 Feb 2025 09:21:40 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2bc70042fa9sm4367409fac.43.2025.02.18.09.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:21:39 -0800 (PST)
Message-ID: <43861456-c8c3-49a0-ab77-670e6703267f@gmail.com>
Date: Tue, 18 Feb 2025 11:21:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-docs: Add book to process/kernel-docs.rst
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Carlos Bilbao <carlos.bilbao@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218154303.45595-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20250218154303.45595-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 2/18/25 09:43, Lorenzo Stoakes wrote:
> Add a reference to my new book, The Linux Memory Manager, an in-depth
> exploration of the memory management subsystem, to
> process/kernel-docs.rst.
>
> This is not yet published, but the full draft is available on pre-order, so
> it seems worthwhile adding it here. The situation is made clear in the
> 'notes' section.
>
> The 'pre-release' was made available in February 2025, and full release is
> scheduled for Fall 2025. The book's ISBN-13 is 978-1718504462.
>
> The document will be updated upon release to reflect this.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/process/kernel-docs.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 3b5b5983fea8..c67ac12cf789 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -75,6 +75,17 @@ On-line docs
>  Published books
>  ---------------
>  
> +    * Title: **The Linux Memory Manager**
> +
> +      :Author: Lorenzo Stoakes
> +      :Publisher: No Starch Press
> +      :Date: February 2025
> +      :Pages: 1300
> +      :ISBN: 978-1718504462
> +      :Notes: Memory management. Full draft available as early access for
> +              pre-order, full release scheduled for Fall 2025. See
> +              https://nostarch.com/linux-memory-manager for further info.
> +
>      * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
>  
>        :Author: Kenneth Hess
Congrats on your new book!
Reviewed-by: Carlos Bilbao <carlos.bilbao@kernel.org>


Thanks, Carlos

