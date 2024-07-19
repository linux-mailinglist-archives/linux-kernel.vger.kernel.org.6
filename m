Return-Path: <linux-kernel+bounces-257646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E976B937CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B671F21846
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8401487C6;
	Fri, 19 Jul 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2iZgHv5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A41482E4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417393; cv=none; b=vExClG+yG4xnc5Ykjx/LAIq3mkyFl7LXZr9lEY+8Yb09isnlBbKQCaJg6PWHxbWQuqU0WpsRzPoBBDlROMhhev1TKGTxS7dDo0CyRWDLrX5pZMAWENLGmGqRSH8ZxHJV+/iLSGtbVcsp6cS5jsGG/QEf29WjMEfMlWJZaOtrlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417393; c=relaxed/simple;
	bh=0EHVbp2daWpQGwNYfq10YHgmxxY7u4mrDySNoqcEc7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhUnN4tSeeCtn9O1GUF4Bjdb1ErUJ9MS+PFnFEkjcamVy1odIkycnq7lg8IT0leu9lJn5lYx+WJo47eUfcXETP4cmGB46BCwkJaZ3hNGhtFv3xqG+OL59zRKb3V+DORKsQDUHt5wVtJbXO78CNrP3zbSOLdAGY1IskTfdqgn8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2iZgHv5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso196233966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721417390; x=1722022190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oslSAI/mSD/PodYWoA3bo9fn2aMenW4Wlg65Kffd6g=;
        b=j2iZgHv59L4f5Xa9BB/aYay4ZmSpNvzD4JdT1dSRqwdjiiHF+hmkgvhq8mSlESsVQL
         vYmED/bka5fqtdpMCQpsKR9mTtc3dXYfRUvqazivg5NgBg3yVrU6S/zw0pxFBtOoY1rT
         bo26vSOsV+mpSVzH6sqOp7zPIp7svrWT5kqG6YlkpqDLQoBQCMydzH7ApoKkJmZlEK26
         72Av5GYJ/i3DW0IBDvJxXjS9RANz98vhMjvMo+RqRtz0iopRWi9twQ5yK0SZdpakkYAm
         q0W6r1BIg8hdAJd7aB6/yZ9/uIrmfMXVFwgWfbnLo3UOSu5K35JIOVJxFQtu9Xd84PfS
         TgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721417390; x=1722022190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oslSAI/mSD/PodYWoA3bo9fn2aMenW4Wlg65Kffd6g=;
        b=cPRbBeDpHIJXLTE8dKBgwNv1Vyor4wUl8oqICs+mfci8QDLDtDN0ifeL0xJ/tsQ5O8
         5h4F0Ha+kuiGpBmfRvwxOqk8110npq+vHCQ2JhqWfGQEdKkUO/qv1izNZk6rlMbshNGU
         /Em67G7fDna440x9KYs/wemdaivB/OO7/KRnrQuuIivAmidz54L/5yGOvMm9z9IXVfCw
         C1DjoUmm5aDKGB9sCeZd/7TFlwITHVrJggSf5HF9MhzsF7n1cuzJnGccYN3T1F3hzEBA
         fWs73NjO2QP6KwfSvd2RJEwh+fPlgeMFPrLZjcuItDPfsNgiIqVB1fSc3+C/+9fb+YGl
         E/CQ==
X-Gm-Message-State: AOJu0YwXI6FIcsBGnwZApwhMUoUHwYBeEKHgwi8fJBWMhhKKhOdANZGb
	P376nuEOlu5TH2BnQn4ZQwdx2WpupSnilWCaJGITQRZXzjPjd6o=
X-Google-Smtp-Source: AGHT+IFTDtIIf1Hx8Ef5vxQXNo9arJCHZvatgI739g1uz+Iy6SuCPzyHUGsCfdiwZny3oi3TVFdt6g==
X-Received: by 2002:a17:906:f757:b0:a77:c548:6452 with SMTP id a640c23a62f3a-a7a011bef19mr575062666b.41.1721417389624;
        Fri, 19 Jul 2024 12:29:49 -0700 (PDT)
Received: from p183 ([46.53.253.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bf079sm67433466b.104.2024.07.19.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 12:29:49 -0700 (PDT)
Date: Fri, 19 Jul 2024 22:29:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH] simplify container_of_const()
Message-ID: <281a75d6-4aea-4d71-9d90-082e2744e491@p183>
References: <a088c95b-53d2-42ea-9eb3-ae81fbd07c1b@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a088c95b-53d2-42ea-9eb3-ae81fbd07c1b@p183>

On Fri, Jul 19, 2024 at 10:19:37PM +0300, Alexey Dobriyan wrote:
> * add necessary parenthesis so that
> 
> 	container_of_const((expr1, expr2), T, member)
> 
>   compiles without warnings,

This part is bogus, I'm not sure why I wrote this.

> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -30,9 +30,9 @@
>   * @member:		the name of the member within the struct.
>   */
>  #define container_of_const(ptr, type, member)				\
> -	_Generic(ptr,							\
> -		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> -		default: ((type *)container_of(ptr, type, member))	\
> +	_Generic((ptr),							\

someone could sneak in additional clause...

> +		const typeof(*(ptr)) *: (const type *)container_of(ptr, type, member),\
> +		default: container_of(ptr, type, member)		\

