Return-Path: <linux-kernel+bounces-427790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA19E08FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26FCB3A007
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D0207A2B;
	Mon,  2 Dec 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz5bmm3D"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8A204F9A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151153; cv=none; b=Bm9ZD6ZqHClWpCLQtxWGPiFL2auC8Hu2tHSNsZCaCMIzw17nmKNAPWZ5D8ifkMvx2lD7iwQ3FqLNEgJSn0+lGrr9vH6i/4UAqd108L4+XtezwM7sV2yp0DsQZwuVlul/R3TNokKfljabSlkYN1klN29but2R9zlKO+ofN88TjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151153; c=relaxed/simple;
	bh=jrRG+x4jQzJzNhcGIs7b6FHPgRdPwuIFG+cBHSXPm2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1C9pdcOsNwFWxRRKih0lm3gJz9HEOluM0EuIAF80y0kybVqf5h8mgUhfkVcbkwKQ6ez1UOyBEIrs4eV29ECcIG/R8OmfcMYBSa4BpGxK54otrpadEt8+4BWh7AQL9YRJyjq0HdkIyJgnNX1nKLfVZJ+wjRbbaxF9m6r+4dnJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz5bmm3D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21290973bcbso43222545ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151151; x=1733755951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qY4G00i72hWsO11pBQdjSeQLWmsDLsKik7ZCI1vFqwI=;
        b=Tz5bmm3D24R1FHCBLUdrPaDwXntShgNIExhycS6mM5A2yYDdfNZIAMtGlWJKlVYhKo
         OOf9FYXruG3hzJwztZt0Sc9knnPl7rEgRhJGrvD3l+RxxvvoocGrfxyczs587W9ryLSG
         laqowPSuRrDL4rKQs4tpd2bhGFVhKeM8PPLvFgxZPt/mi7kVjY2sIeQ+mbUSAa3RAdit
         Oq4CEw8DY82PgAgLKua8HKLgy1etipx9ni1ol0fB0XRi+xNFgztjvOy5AQHDsFpqKkOk
         AlNe45Fj95HwzkjqBwcaBcvqC64DsAtESC65xPkP0gfBOiHlZVenMEtSsc172wRBaSAw
         HtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151151; x=1733755951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY4G00i72hWsO11pBQdjSeQLWmsDLsKik7ZCI1vFqwI=;
        b=boUAnB14BUmqkBcWBDmn+K6K01xajxCeskPeNtW7XS60I2Y+gd/Mdf0qN8qjwQ6++U
         xA93eSu7bQi2lPsgWhU2piNCTXL1pevjusE6/RK/hKZDSbaMrmTR31Gc/ZCvq0jz19s2
         /0bxMvCHUhP/DnQbxUWNJgLJ8W+x8C+4KQoMjUsRkwzKxzbKDw5p5M9Z7+o/nLE5mQK/
         rg85F5Czz2eRgPgyApCx3qbnnf+rMEFQk6wmMDQc3vnTFeDCLTS249zNpzf1Ml/YnUGl
         42yh+Mv1Hg4K+mDIGjk6uHD3dxyBv21Yku6gqNIWMBp2Uxp5EHXIQIGQO73M6oUb/hZP
         bzHA==
X-Forwarded-Encrypted: i=1; AJvYcCVR2VKWb4Fo2xZIPCzzbKGCUPJYrTz6r0rN+e96hdYcwY6FvZMdu+MGlW8Rvc0hga/pEbjzjIqraVniYMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aUuA9WkDudXtbKsF5ZR40PobUGj1D0FWoGL+d+rNyueh4+vz
	UqBVVzMPkwrAr2QyA9bdNLsqDCceZo57kGg+zV50WOnCkLg7h2cUhzGDsA==
X-Gm-Gg: ASbGnctfWHdFs96vo1cJtde+8Df9XgpH9xkCcev2sfcYKuU9m2FjzMTSbYm+bny0nj6
	l/Erx/v97K7WcqAUyFREOtIukj4HT2daKWwx5gg+LkPsMa+Lw1S6/AzJJ81uKVP/Nh2MPaMOrKf
	ooKNkG52gtU6A/Mon2KP+5UQ6EX03iIVhRkcYJ35GUXu+NEGLuhgQdKDK+wp8XMayHoL6Ph72pL
	DiTK4y1G+Mojxqe2+Kp5Vk7lcAhDUGHroQaO8c0S5PLQzzkcrbMl5DHa9Mywto=
X-Google-Smtp-Source: AGHT+IGf7NoPu7BOLPEbIi0SaK309Vl2fbA9zl/kZ7oiQDGYy0PfgNZNKDYvNnO22siMMJpc2da/KQ==
X-Received: by 2002:a17:902:ecc7:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-215a3fd642emr22145965ad.5.1733151150953;
        Mon, 02 Dec 2024 06:52:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219be22bsm78161275ad.248.2024.12.02.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:52:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Dec 2024 06:52:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <f4ded99e-35c7-4651-8c73-376390ceb130@roeck-us.net>
References: <Z0lCyXBV06VyH96s@kroah.com>
 <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
 <2024113025-sly-footer-3462@gregkh>
 <7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net>
 <Z02Cz6GbdtGNPywE@egonzo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z02Cz6GbdtGNPywE@egonzo>

On Mon, Dec 02, 2024 at 10:50:07AM +0100, Dave Penkler wrote:
[ ... ]
> That is weird: the type of resource.start is resource_size_t which resolves to u32 via phys_addr_t on i386 which should be the same size as void *
> For compile check purposes simply changing iobase type to phys_addr_t the following error message appears:
> 
> drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
> drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
>       |                            ^
> drivers/staging/gpib/ines/ines_gpib.c:783:26: error: assignment to 'phys_addr_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
>   783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
>       |                          ^
> 
> It would seem that for some reason phys_addr_t resolves to long long unsigned int

Check out CONFIG_X86_PAE, which adds 64-bit physical address support to
32-bit x86 images. Pointers are still 32 bit in that mode, though.

Guenter

