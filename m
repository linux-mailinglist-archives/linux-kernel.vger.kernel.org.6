Return-Path: <linux-kernel+bounces-213089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB1906AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5633D285D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363713C69C;
	Thu, 13 Jun 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo0vODEU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E7605C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277860; cv=none; b=dFtCT4OISBHbmUq/YP7UcxFQwSTnaKjhcsXAmg0UCwhfTTIH7QmZAZ6fRmLXIhE3feh/o4Be0ePdyOJpcVAcyywkfdmkefJysySj4LBVkXJGxTSCLTibJQ784f33QRsrceMa5CSTT9V7AXvQb6gtrXxBC4z8YxMF/DnfE/aE1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277860; c=relaxed/simple;
	bh=5uWifkIqfNvtkEZEWNBCD5mZT4FGV2QWpsznUPK7jS0=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gztw4CkxZQxjtiy8doqOPds90Ytsn9tJPBAa3/VDHV2DHegWBc5pzB/O5sWxj9hn7JQwyTlZtMUuf8QEQAQ972Pnt5YFqRWQFz4HpY4QtZHYRM2Reg4nq5mFmlQTkBT2NrrCTj7DX/GZTvHrupMoUKJBbxs1Sc8xFGajYkcHTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo0vODEU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so6700515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718277857; x=1718882657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2jdg3dqY24eRvaGZuvB/5TK1JcmIDjID0PLg7M4kd5U=;
        b=Lo0vODEUhEVH2d5mwLSx89orQQrBN2+3MYGXUv71JFQe5md9UsWdpRscFTUxIDY1SB
         qLzVpOKvPxQ/n+jbIGPoOJy6+Lr+PHBlZFSAzXPcAvUh3tLGpqfFQaXPO9E3PBj+KWNp
         puNkjpWsLHQEOtCOGV6KNNeZ68hVVbvMsO+ASZBrib9rQvG/q0U2Vu+zxvY5rD02vuQ7
         Hm3ZZu9eBa4xBLDNVCQ5Uasl7WISVqBXOMGBu7mBISyLin8XwSWUxwQPtqCj+GS36E2P
         N3QZVj8gR6wVpsqSdCgaaVmtEhhpN9mjImM1zupKdkSpI9oaLlexRylnmN+NZz1zN7HE
         mY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718277857; x=1718882657;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jdg3dqY24eRvaGZuvB/5TK1JcmIDjID0PLg7M4kd5U=;
        b=XaEm27Jw7q/s3MW9OxkknISZmdtAFVVq6kH8jvRd8xICEkoqTRxKDWm9OIbx/xIG7n
         G8iv9j4D90dHDRr/AHS4KlkjBpmTrnQYvkINN8EkHWo5wonVJBxrC9A7dCQEpHFPVWtI
         0zQSjWFUbMh/8P/nsUWs3yKZWgnPZmuoeT/vHlB7e3ltxdRVu7C4Q68OrVlgAsto/6pl
         T7Ol7UJXBntgZaf8nDUFyTHp5vhmlfQeSQHIp9I6V6U2QCCVxfZh6dnwfw5FF5Od8/mT
         tiDeU3sZiX3c5hVBd8j/W/vmQFb96fH+Qlei5SbkjYyOgXjOorcnZlMqn46QNTS7Zw/N
         jp5A==
X-Forwarded-Encrypted: i=1; AJvYcCXfbe8teWDLXWKOZjJxAWKOdH3pgXvZI34pHJnXrBwmk/psacgx/wL1awMaSZ004i0t4Khd8TSkc+aGAZd/oDLwwNIfhg+UNBGvHtPV
X-Gm-Message-State: AOJu0YyOivSv6/Qo6YOrTMf+S/pobFEXr+nrTWvnDFXhNRvtoRs3QGOj
	Ws/BxlXVCEYpGE0wIoWBMaUZkA2M1dcvEiCZgbEaDXVwjGMA6usH
X-Google-Smtp-Source: AGHT+IFKHAMa0G0apzUHaxJtWxNoolMf4OCMp/u5jVCqYmJIBWzI18m5bjVEaPMbkd2FzbV+3gv4Yg==
X-Received: by 2002:a05:600c:310b:b0:421:bf9f:a163 with SMTP id 5b1f17b1804b1-422861aec77mr47990885e9.4.1718277856545;
        Thu, 13 Jun 2024 04:24:16 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f228asm1431993f8f.73.2024.06.13.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:24:16 -0700 (PDT)
Message-ID: <666ad6e0.df0a0220.f8b16.4a5e@mx.google.com>
X-Google-Original-Message-ID: <ZmrW3XozQxtTsPeb@Ansuel-XPS.>
Date: Thu, 13 Jun 2024 13:24:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
 <65d62b60.050a0220.c7b96.614e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d62b60.050a0220.c7b96.614e@mx.google.com>

On Wed, Feb 21, 2024 at 05:57:00PM +0100, Christian Marangi wrote:
> On Sun, Jan 21, 2024 at 09:29:32PM +0100, Christian Marangi wrote:
> > This series try to address a long lasting problem with legacy device
> > that require an appended DTB and the use of AUTO_ZRELADDR.
> > 
> > With these device AUTO_ZRELADDR is not possible if for some reason at
> > the start of the RAM it's needed to reserve some space. (example qcom SoC
> > that allocate reserved space for SMEM)
> > 
> > In the current implementation with appended DTB and AUTO_ZRELADDR,
> > the memory start is only derived from the PC register and it can't be
> > changed by declaring additional info in the DTS.
> > 
> > In a normal setup, we have an intentional undocumented chosen property
> > to handle this and the memory node to declare the start of the memory.
> > 
> > With this applied and ARM_ATAG_DTB_COMPAT_IGNORE_MEM enabled (more 
> > info in the related patch) ipq806x can boot right away with AUTO_ZRELADDR
> > enabled and a correct memory node defined in DTS.
> > 
> > It's needed to ignore MEM ATAGs as most of the time the values from the
> > bootloader are hardcoded and OEM didn't care to actually provide them
> > resulting in funny situation where a Netgear R7800 with 512Mb of RAM
> > have Uboot passing 1.7GB of RAM with ATAGS.
> > 
> > While MEM ATAG may be broken, other ATAG like serial number or bootargs
> > might still be useful for partition declaration (cmdlinepart) or other
> > info hence DTB_COMPAT is still needed in these case and can't be
> > disabled.
> > 
> > I'm open to any suggestion on how this can be improved and I would love
> > some additional testing on other legacy platform but I assume this will
> > permit many legacy device to be correctly supported without having to
> > hardcode address.
> > 
> > Changes v2:
> > - Add Review and Ack Tags
> > - Use IS_ENABLED instead of global variable
> > 
> > Christian Marangi (2):
> >   ARM: decompressor: support memory start validation for appended DTB
> >   ARM: decompressor: add option to ignore MEM ATAGs
> > 
> >  arch/arm/Kconfig                        | 12 ++++++++++++
> >  arch/arm/boot/compressed/atags_to_fdt.c |  4 ++++
> >  arch/arm/boot/compressed/head.S         | 22 ++++++++++++++++++++++
> >  3 files changed, 38 insertions(+)
> > 
> >
> 
> Any news for this?

Sorry for asking again... but any news for this?

I have also added the 2 patch here [1] [2].

Been in incoming from a long time and I have seen other patch getting
accepted. Did I do something wrong in submitting the 2 patch?

[1] https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9394/1
[2] https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9395/1

-- 
	Ansuel

