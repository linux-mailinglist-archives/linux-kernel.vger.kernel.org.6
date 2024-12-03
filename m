Return-Path: <linux-kernel+bounces-429000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E59E160E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA1164EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835B1D9341;
	Tue,  3 Dec 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVkiK8KT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41088198A0E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215419; cv=none; b=jjz4Li+jPBnro6PxlI6RdPnTs1b+Yf65Pp9vni12xG1j6NEcZbITPIeXJ++cRN9+82rAdDcVKsYJbBz/2fGjj5VQkAL/JUAWy5eJfmBeXUN/vdr2ixmAbKsh94jj3fQraptdZpnj7XxxArZ9JOgFn2KBeBD2A1PzwlOX3PbTVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215419; c=relaxed/simple;
	bh=XUFBDuUtFue67ZYw/w8HYhrY9y8TqE5ABGL8g27JrgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPZS65Ch2AEPM50C6C7/p0oLeQ11KXXSypJ8OXygHXMBfzAe8JKCQGz5Pyzny2cyhm9uCFPWX970cQ7un/mq0oOnKrVPPsBc1MCjLLG4FGR75IMtshldwmQ/JlOOuTHtpyR0BEs3lHNXfNZQQd6bRFKsQTonPT8ljCpZTur7HbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVkiK8KT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385f4a4093eso1244700f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733215416; x=1733820216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqAESCNdyH0hYpJR1TiLOsIkSE13c2KuYctoyXS+XnI=;
        b=VVkiK8KT6lsGeXT1cU0t5+mVUXls3tLx+XgzA/KlG6dIPKg2+AfAro+n0Tj07DE4fG
         pIRj3ogFteZoUHhPy1/G6puopQYuayHgwd/HDTzozigocrePOnyAXdu9r/sclrDgQ3fa
         6NdbS4V5N5V9mcDpdBt5v5ikpqJn8dTv/z2gF5NjbGx78Oho4IqNk5k6adc1uyCs6Mh0
         fdoWDh9awCdXVX6fwvMaPP5aWBDP8iGwQrzsPQQK7ACekolth1tAMsu89uMq38KkdATX
         Oc/iSmJg//G0sWUnQuQ8RvXUnLQZdoTmQPNAsLAKLNT4ulbD17iLYr9oSn/oltXtztrw
         Fm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733215416; x=1733820216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqAESCNdyH0hYpJR1TiLOsIkSE13c2KuYctoyXS+XnI=;
        b=B66kL/eHpjEGRco+om+IZ+L19Sx0M6WoRlDJA0JBDdpL62nvbCFgKZb+P4LivC+n51
         t49tWEhKEielUWfTk+S2UZuHzsEAog3I+wB9extuxwYNpoCSGfVCC1CRPoYW9n86oByj
         UjYjt0oE78geBPb8Bj/Mq42B+aG3ORKrxCXXnUgiGRCBLb3l4wcEYalodVeK4OrEmmHc
         yKlqoKaE/6Ses0uNb1ullSoD6SPiO8rHzNpRCk4kLssEHm4lQ9MYmzKwUFPuaZ+wNWiZ
         10ghXdLYyyXuj0s1jMTvPnwWP0SU41lBKCo1VsSpVPSFahrrM97iUSIklxAof9azlIoU
         X3tg==
X-Forwarded-Encrypted: i=1; AJvYcCU8w9KnzaW3/WivPZcbBb4ojdU9c5tQjjGKiqpZJr14l6CHv+Lg1KDAL5uzpjqai9FERf0dkxDdLBmCPK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XSEBsBfF35NQXqELybfxqOsPxHC2g3OZ8kdzGqmAjKUHl4nD
	GEu5vA8oLWlqN/hc22VWYJQyBoIJVNvTxvnPZk7g32zFME1/K67LDr+yXNhf
X-Gm-Gg: ASbGncuJM9A7fclSCtd79l0LzrVejGV/9OEgIKoEGOGJZBZZjYUcwsG6eTvheK+SXOZ
	6m+SlJ2g//LDDiomG5XoppwkbJjt6B0goS47DkfTzLbNXVwmxSWmQn8w6YhfVGJ5Ud59jF1Qy7Y
	R/InPXR2fMSauL939fdWu1nmarlifA9vLV3XIvChm728/Gqn+AFBO8klG6GH2hNKI8/h8H8v1tQ
	7ZWl5Hf7XtyRb7yci3E9qtKN6ANZMMTlH9yo7GagribVnma0y/XN39RHUi9RTvanQ==
X-Google-Smtp-Source: AGHT+IENLOrwB29hz4yyazQXQj58T2rlPdBVtgNJqP7WpG7tt6gWrr2MNVy6B+j8IhXWXwChfidJyg==
X-Received: by 2002:a05:6000:4604:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-385fd3f15camr1504549f8f.35.1733215416260;
        Tue, 03 Dec 2024 00:43:36 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d25c5sm211926285e9.28.2024.12.03.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:43:35 -0800 (PST)
Date: Tue, 3 Dec 2024 09:43:33 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Fix i386 build issue
Message-ID: <Z07EtdJpe6mnKYOH@egonzo>
References: <20241202173301.6462-1-dpenkler@gmail.com>
 <88c8ede5-47c0-49ec-805d-161293eec679@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c8ede5-47c0-49ec-805d-161293eec679@roeck-us.net>

On Mon, Dec 02, 2024 at 09:48:49AM -0800, Guenter Roeck wrote:
> On 12/2/24 09:33, Dave Penkler wrote:
> > Both drivers cast resource_type_t to void * causing the build to fail.
> > 
> > With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
> > which cannot be cast to a 32 bit pointer.
> > 
> > Use ioremap() instead of pci_resource_start()
> > 
> > Reported_by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> > Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> > Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> > 
> > Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> > ---
> > v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
> > 
> Sorry, there are some more.
> 
> drivers/staging/gpib/tnt4882/tnt4882_gpib.c: In function ???ni_isa_attach_common???:
> drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1430:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> 
> drivers/staging/gpib/cb7210/cb7210.c: In function 'cb_pci_attach':
> drivers/staging/gpib/cb7210/cb7210.c:974:36: error: cast to pointer from integer of different size
> 
> Not sure if that really fixes the problem though, since there is other code
> which maps the void * back to phys_addr_t (or, rather, to unsigned long).
> It might be better to work around the problem for now by disabling support
> for platforms where sizeof(phys_addr_t) > sizeof(void *).

I think it is dealt with in v3.
- Dave

