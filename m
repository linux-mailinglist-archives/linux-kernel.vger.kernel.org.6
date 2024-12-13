Return-Path: <linux-kernel+bounces-444642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E459F0A20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CD3188C7A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFD1C3C0D;
	Fri, 13 Dec 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD/CAqwn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C91C3BE5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087210; cv=none; b=hfbUUpJxqQdpvtsNkHIvWdANfaSTCD3DStCLbo8/xiwR1cyE2sG2NerMCue+n6DM2bewJtC+sNZN2kcsqbEwT1Kfp2eKfeGjj8j28slqjgXjeMNVDGKgMu3mVTBR2EnyhfEpkYtFG/cPG0zBLn8AjA8YuMuc6cmGvwaiKVZN9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087210; c=relaxed/simple;
	bh=3RAKuwhJziTT1DeTTJ7GjajGteL0tlZLFZr1flfX9JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm4QFeyhi34Kjug4NZxFIpMqf4/87pU+AnlJdZvlZGliMEEhDLTdehvbgORDsYVvz6QWnFYnm/EbF6VsXfTMjoPcIUtvYze0XgXxhhVRRs2PajAy85sgI2RR8DCXf5JtgulqdtMWB5+t7/sXiNy3M2gfLDN0/kGai3DeSkSRZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD/CAqwn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so16930765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734087206; x=1734692006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yf+WwbETet8e5i96HNJic3txU9PUcKXniPQhzUEgHIM=;
        b=PD/CAqwnbBTuE35UU3gxafLQUnWrC78c/PqVCbUCqKsLP0KnsaynT2isKpQsodQSKo
         cJaPQNURKR6sJOuQzw9Cvxp2f6u4jeOBD3+1Q0OhuzwtKXrynT9B0iVwzE59Xcsa6hyX
         yEZ3UVwrlQWF1yYtZdfgq1DRGt2/MPwx+V/ioQk1gXSPvKUJRO/naFRT+xgKwRS6UiWU
         LsmUJ902fb5gpylI7rWqb2yTJXOkLIdtkyWFEM8USFihMbQ3G7ehL8vp4skOtGPLqdVz
         d3RZ9yRsTizgNOexj9ZnvWoujSl/Vte6zym1jPbyQkpRdVKMBRLFnJR87j559TkDQm77
         gv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734087206; x=1734692006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yf+WwbETet8e5i96HNJic3txU9PUcKXniPQhzUEgHIM=;
        b=P7ujJPFz/nKSRrfxhn+8sIfOw2elC619Kpg1sxDl29i0Qqvpl8ewJqPcEwCWzebCci
         MZ1zvZWKt2voXVGMg6VT2Qpp1TAy3uTGZLiAZSUD11UY057rFpjbVngVqlyp7Ia3YeKT
         /XdtoEQHwwP9rlmEgrbVjSS6ZmNCRy6v0xuxPiGioG9+wf8bJPQazSsJ7pOLfZhlv7NE
         QkwxrozbowzY3t/W6Pc09/LU6i3AFrB/44oYqA+NmeTIfGyKTi0RmLQYmB4sPPDkqcJN
         Kc68fE/YawWOw89k2nHkypiOl5bjzud17HZhKOp2orex3tI8Xe/tLJD4TBmJG0SbBTWV
         qqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjr4ouSN35p6FZ4cpz6KWt9EjanYB+8U0wod9aSmmRp19z3G3fYUuRSrbEmxoQQaNMrS3RmSf8YpdIOXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCs+m9l9WzThEzqow3iamFPg02OD9o5c9Is+cavRwCWX58jCH
	SNe2yYFQnkDA84kSZhH2kEV1rhBQGhafIjjwEhG/cj6L6dp3gHja
X-Gm-Gg: ASbGnctEwOAk+I4ROj4PWKhilANi6u31sGOXjIYat5EHcPZ8FrqiZCwd2DF4vAcWUBP
	x4Orrkvmc60Ger7HTKtgruWUyeUzYt3F+SjkOAU9jaHqkx9SJKI//2OQHbcPbkTLRbERBN29W9v
	fW8u1B4P2lkg7tNFdct8PFJHTqtCw95DNs0Pp1BJgMZiTCn7hvTaYO1Yb19cAUFAoUoD84E04ZZ
	bjJWq4rMosPoLghUrl1Ua+v0hP1dAFwJPIPyh2On5W+uA6H6CqQnLMv9ptJnozJ8gcGI/x6
X-Google-Smtp-Source: AGHT+IF7wpcLBiHevBCqFWuwzVTAWqMl+5sNE/JupCPWSPoBAsIudx1Jcm4rfZoivatzYHnZakf6UQ==
X-Received: by 2002:a05:600c:4e01:b0:434:a202:7a0d with SMTP id 5b1f17b1804b1-4362aa94055mr12963585e9.22.1734087206038;
        Fri, 13 Dec 2024 02:53:26 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706588sm46607105e9.29.2024.12.13.02.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:53:25 -0800 (PST)
Date: Fri, 13 Dec 2024 11:53:23 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	geert@linux-m68k.org, arnd@kernel.org
Subject: Re: [PATCH v6] staging: gpib: Fix i386 build issue
Message-ID: <Z1wSIzBOZu4gUJhv@egonzo>
References: <20241211164452.27464-1-dpenkler@gmail.com>
 <670d63a3-6b20-41a3-a4db-96b407b80202@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670d63a3-6b20-41a3-a4db-96b407b80202@roeck-us.net>

On Wed, Dec 11, 2024 at 11:42:36AM -0800, Guenter Roeck wrote:
> On 12/11/24 08:44, Dave Penkler wrote:
> > These drivers cast resource_type_t to void * causing the build to fail.
> > 
> > With a 32 bit build and PHYS_ADDR_T_64BIT enabled the resource_size_t
> > type is a 64bit unsigned int which cannot be cast to a 32 bit pointer.
> > 
> > Disable these drivers if not 64BIT and PHYS_ADDR_T_64BIT are configured.
> > 
> > Link: https://lore.kernel.org/linux-staging/2c6c7e9d-ca10-47a9-82a7-a2e26b1f51ef@roeck-us.net/
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> > Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> > Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> > Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> > Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
> > Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter
> 
Hi Guenter,
These nice patches from Arnd fix the i386 build issue without having applied 
my v6 patch:
Link: https://lore.kernel.org/linux-staging/20241213064959.1045243-1-arnd@kernel.org/

I tested only 
make ARCH=i386 allmodconfig
make ARCH=i386 M=drivers/staging/gpib

-Dave

