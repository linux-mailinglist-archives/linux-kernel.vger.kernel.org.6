Return-Path: <linux-kernel+bounces-427182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A19DFDC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4EAB2534B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0F1FBE8D;
	Mon,  2 Dec 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnhT7PPh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0E1FBC91
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133014; cv=none; b=udhYNIxheIOU7mchw423U0+C+iYWPq0TSaWKEBuOaMR1WinAfpmNCj0iFV4e2vmQco2X6AMpl0QmUwSHQF+CSagP0/TQzV44yd0IPsi7sOnEtTatkxotzeOUAw52jAIqrAx5QbQjk9xYsuO4VnZDIQ1oTszOnW8pEwJsDW4k/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133014; c=relaxed/simple;
	bh=yupbxSUbYy8LInAwf/1LDBrb1j4q0UJbTOpZzjh/iDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPXfPyZiU2GA9ro+1OdpeU42Dxf8SvJnVJS/sCEqIIGxws3THFuU8dlTNayBIX9WfisnQ3wa7YKTYBxzMd+wHckEi4QotUQXDy/mJbmXFLiU7/Fl8QgOGwq73cl3bbfV5wjUYkeIhS6DSSrnC1y4YdOPFxBWxgBcMrVyQCa3yI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnhT7PPh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso36832745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733133011; x=1733737811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGdJEBG9Txtp78vl9KMnzjxNyiIm9+dUdwbTmnsgMo4=;
        b=JnhT7PPhnyPDMxaXr106u1n7wlkgafG+1apC7wN9O603MvXE6/MvbAiFysVO78chjr
         8kDSN26zv4AyIueQD7zWpgVWqG6KGj4rlARJcGLIgVhnDGNOKmaesF6k4FwkyC1s5cqa
         CM/N5GsfoHl6e42/9a12KHSFAxkb3n+uY3bJmgJY/Hc9LA5Tmf2TQATSkb68UJZIBpFc
         3P3Xb/qqEJliwjpTez2mXsaKwaD3FGmfCDI27EkTGt3XLAJGVTn6cOlkxHTpmFAJvBTz
         4Sp8dtsizo42/Ntg/WiDqQcNvT8H3p0uDA4smPMVaUpXXMNPORdo6Svj53A01z3Aoxqq
         OcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133011; x=1733737811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGdJEBG9Txtp78vl9KMnzjxNyiIm9+dUdwbTmnsgMo4=;
        b=Tx8dfcAtvnzxZtO7bdOz12XhLILdX5a9WzYoDR315ZMMjTmPrHHNh8rLkQjCa3Kg3I
         wOqGErJB4CCQp551DpMbBjAJNMmgnkcBGZKdd4CLrp8OYTO75A5Bb8Tu2r3okUNqWl96
         /igTdMg67q6zEagRy87vA2Fg6Rsxh0LAkjfOEKvCuxm6NEqNCnrgeT6a04E6NmOGi1r5
         jRq5yhSOcWPYJhrb7zf7Jq+dXp1Cr+BH/LXmM8f3kTQ7aIlRNtV4ZNEMJ7U706zWCpd6
         3EtlpuciDgiC2whjoaX/AHjsX8UUvgH94lZSyn6w3v57NFLZohxwWlMv+VEheaoFa1R5
         vp9g==
X-Forwarded-Encrypted: i=1; AJvYcCXG2Tza2pKCzDJX7uhtZJqV4zm/sJC95voRpOEiRi3uuzbjXfgjFVX5tOt654sx57WJcgMJ+jCpWNUgr6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffLvtDGHJMLB3QbCb4tLLY3fLRAuZIObl00BZ0xDI0gbcnkgx
	V4o9kuqapBRjzZx8eUEE2CvHo3s1J5J5v8COEKBX7YKeZereM+0Na0APcsRd
X-Gm-Gg: ASbGnctKHXswxHUwpo5Oslwiim0xbodTiazHJjlokth3ahXydG2rv7KK0LJHokaPWeD
	lXlyk6ZXrLs61MDo4ElQ7QLlJY7YrDnl2oFGQkwq2YotDCUH19H/B//wLPqEIA+cfGh0IIxi9VF
	x8AUyY499pHWLMt1XEuLBsUHrMMFaTZ+XKWGSWtjDAMW5YdlhHaaLcWmruigT6MXVO1bj0WoiT2
	Fw1JqD99fgpj+ov1MKYdVueQIMTAj6T0wY2B45/rrZOPbaBuRP2utZvTfLkRGJW2A==
X-Google-Smtp-Source: AGHT+IG/NVivYLg1OUuCE5VjRAF5LhER8lnv3l6zTFnhpZD70zQp/iX3dHcDM7WzvcQeakGCE+ffIA==
X-Received: by 2002:a05:600c:4f08:b0:434:a179:71b8 with SMTP id 5b1f17b1804b1-434a9dbbc2cmr165027075e9.1.1733133010404;
        Mon, 02 Dec 2024 01:50:10 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a972c33csm142136955e9.1.2024.12.02.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:50:09 -0800 (PST)
Date: Mon, 2 Dec 2024 10:50:07 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <Z02Cz6GbdtGNPywE@egonzo>
References: <Z0lCyXBV06VyH96s@kroah.com>
 <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
 <2024113025-sly-footer-3462@gregkh>
 <7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net>

On Sat, Nov 30, 2024 at 09:07:39AM -0800, Guenter Roeck wrote:
> On 11/30/24 08:15, Greg KH wrote:
> > On Sat, Nov 30, 2024 at 08:10:55AM -0800, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Fri, Nov 29, 2024 at 05:27:53AM +0100, Greg KH wrote:
> > > > The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> > > > 
> > > >    Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1
> > > > 
> > > > for you to fetch changes up to 114eae3c9fde35220cca623840817a740a2eb7b3:
> > > > 
> > > >    Staging: gpib: gpib_os.c - Remove unnecessary OOM message (2024-11-10 08:04:18 +0100)
> > > > 
> > > > ----------------------------------------------------------------
> > > [ ...]
> > > 
> > > > Dave Penkler (33):
> > > >        staging: gpib: Add common include files for GPIB drivers
> > > >        staging: gpib: Add user api include files
> > > >        staging: gpib: Add GPIB common core driver
> > > >        staging: gpib: Add tms9914 GPIB chip driver
> > > >        staging: gpib: Add nec7210 GPIB chip driver
> > > >        staging: gpib: Add HP/Agilent/Keysight 8235xx PCI GPIB driver
> > > >        staging: gpib: Add Agilent/Keysight 82357x USB GPIB driver
> > > >        staging: gpib: Add Computer Boards GPIB driver
> > > 
> > > I seem to be unable to find the patch introducing the problem (the link
> > > provided with the patch is invalid), so I report it here.
> > > 
> > > With i386 allmodconfig builds:
> > > 
> > > Building i386:allyesconfig ... failed
> > > --------------
> > > Error log:
> > > drivers/staging/gpib/cec/cec_gpib.c: In function 'cec_pci_attach':
> > > drivers/staging/gpib/cec/cec_gpib.c:300:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > >    300 |         nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
> > >        |                            ^
> > > drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
> > > drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > >    783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
> > >        |                            ^
> > > 
> > > pci_resource_start() returns resource_size_t, which is not a pointer, and thus
> > > can not be cast to one.
> > 
> > This is odd, why hasn't 0-day or any other build testing found this?
> 
> Good question. Another good question is why I see this only with i386 builds,
> but not with other 32-bit builds. It should be easy to reproduce, though.
> 
> make ARCH=i386 allmodconfig
> make ARCH-i386 drivers/staging/gpib/cec/cec_gpib.o
> 
> does it for me, independent of gcc version (I tried 11.4 and 13.3).
> I don't see it with clang.
> 
> Having said this, using the return value from pci_resource_start() directly as pointer
> is quite unusual. Typically drivers use ioremap(), request_region(), pci_iomap(), or
> a similar function on it to get a pointer.
> 
> Guenter
> 
That is weird: the type of resource.start is resource_size_t which resolves to u32 via phys_addr_t on i386 which should be the same size as void *
For compile check purposes simply changing iobase type to phys_addr_t the following error message appears:

drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
      |                            ^
drivers/staging/gpib/ines/ines_gpib.c:783:26: error: assignment to 'phys_addr_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
  783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
      |                          ^

It would seem that for some reason phys_addr_t resolves to long long unsigned int
-Dave

