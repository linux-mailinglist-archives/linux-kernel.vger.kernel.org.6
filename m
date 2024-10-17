Return-Path: <linux-kernel+bounces-369283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC09A1B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C43D2815B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E11C173F;
	Thu, 17 Oct 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1oLTo2Q"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141A155A24
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148621; cv=none; b=goHRjvhLFI29dDvVaTQGWiSNqTWttrrheu4sgwSJb6SsBxA17+lj+hT1LB4agADktNC+shW2Ljeb6JMWVJk1oOZRV7XVJ8B6qfEtisKsVf+c5jQDBnJ1Nyp2YaHZ0ouQQHbLCb8/rcRq1dtHQqUJ3DHkssfGIRLUAEQ1RqNGI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148621; c=relaxed/simple;
	bh=zDXGu3x/zNVOof1rSjPWuobKaTHcITYX+c97b1xcpvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1IFAd90ml0tmMf1YMIGzQLvmr1XoHVTwwMRoIVqEFm+Zca7PT3rMbY+wtkUPhL78u9pkCP6+uzt4hPjfjEfBQ+bhNkdyGV0TNnGD3q1EOAKAQgW+Wjh7kCc8JrmKO9eTBKxXj44vBguV2MuNfxo/HUcRaEcphb2yvGH33rk/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1oLTo2Q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f58c68c5so944068e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729148618; x=1729753418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iawtoavv1G2RX0l5WVjSkFXmpKxh1NpN/ld6wwOOv/s=;
        b=d1oLTo2Qu3FdVYuKCpTUJ8ku5itJn8wPy0PEjQjGEN5qaMwbuEG4Z3VO/OlEN2DQJ3
         9z+icAbYudIvBymVS6HDQozCdvt7BQ5urrjLqpfptqfapjf9/2IItfq32RBCYJZJGSOz
         4qV4VMBrqaCFrmrha+YmzjEHcas9WJYAlEYyEHFX9gI4Pop+H7wZR00DfWAhALDH09qe
         M5dA4bKDW3SlNgXrSQcrVBdXKpQNdVVLGmhE2tc4nPKFZhVBAUFi3fzmNLuQcgedwCB/
         j0Oaf+lkLtTOF8XmSKxng3MaXtHiDojWGGjXspIq6QMhxmZ/ntjPad8Bbhx66YlxMT4G
         eY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148618; x=1729753418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iawtoavv1G2RX0l5WVjSkFXmpKxh1NpN/ld6wwOOv/s=;
        b=i5h4y0Rng9c/dc91fY0YECHVtwYGQpgCwULa/4LawSSwfD3Xw7mX48Su+KGNMslZHR
         gHtELwf9rBw5SA0vI94fyauZH1cmkKdvPIJ6QNaXPhxthscjA0XlHjqzGiQbZeSz1KXF
         s6zGeBFcLtC2EAQ+bbzYp9rMgQAIwhgQPx6G07tM0m0UBOezvoh+hXK8iHnqdU+e0TpD
         8NMzk9IXxU7MS7aW4QMa3e8KxkDjXAa3Dq9GAwRlppBezk2pr1Ef+zNwm+cqiriQmdSM
         hbFDgnu/xT41GYSiUpkQ7V/Napj1JOQGLB7xxKxDlOsJxuaFgf5vN8ZMDo9tHmssDp7v
         FUng==
X-Forwarded-Encrypted: i=1; AJvYcCVXBxPX3+40Q4R5f3i91XLUmipP+o8iFDo10SPoyw4Q45oTO+e+895X8nC7gKmOhVUPdkOHa/epQu4/m4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RADgnb9aIpkBwuGw/z3W5jqeyQ1vzifApKTMrDvVwOxlKgCA
	cYBoTLu3wwuyylMq/Qy5hb64jPrUMZUeeYBNWYuHJ7RHKtXsNaR9hsUxfA7kPuI=
X-Google-Smtp-Source: AGHT+IHSDq0H6zQ11CelWpuA9izCcxSo97xdpRi0sSnTkqGYNPxSymFsUjn53qQvY3ZhbDmWOfE65g==
X-Received: by 2002:a05:6512:3e06:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-539e571c959mr13304029e87.39.1729148617644;
        Thu, 17 Oct 2024 00:03:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29717324sm257782966b.36.2024.10.17.00.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:03:36 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:03:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: Greg KH <gregkh@linuxfoundation.org>, dpenkler@gmail.com,
	skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Message-ID: <92acd116-55f4-4262-8b86-840da55481c3@stanley.mountain>
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh>
 <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
 <f3fdd6b8-53bb-4e9d-bb32-3816035d4d52@stanley.mountain>
 <CAEO-vhFAb=xfc2sZiezW7Zn0dWNQ4axVxE6GErayKs76NtG1bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEO-vhFAb=xfc2sZiezW7Zn0dWNQ4axVxE6GErayKs76NtG1bg@mail.gmail.com>

On Wed, Oct 16, 2024 at 08:47:21PM -0600, Everest K.C. wrote:
> > $ git grep get_dma_residue | grep static | grep -v gpib
> >
> > arch/alpha/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
> > arch/arm/mach-footbridge/dma-isa.c:static int isa_get_dma_residue(unsigned int chan, dma_t *dma)
> > arch/m68k/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
> > arch/mips/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
> > arch/mips/include/asm/mach-au1x00/au1000_dma.h:static inline int get_dma_residue(unsigned int dmanr)
> > arch/mips/include/asm/mach-generic/floppy.h:static inline int fd_get_dma_residue(void)
> > arch/mips/include/asm/mach-jazz/floppy.h:static inline int fd_get_dma_residue(void)
> > arch/parisc/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
> > arch/parisc/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
> > arch/powerpc/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
> > arch/powerpc/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
> > arch/sh/drivers/dma/dma-pvr2.c:static int pvr2_get_dma_residue(struct dma_channel *chan)
> > arch/sh/drivers/dma/dma-sh.c:static int sh_dmac_get_dma_residue(struct dma_channel *chan)
> > arch/sparc/include/asm/floppy_64.h:static unsigned int sun_get_dma_residue(void)
> > arch/sparc/include/asm/floppy_64.h:static unsigned int sun_pci_get_dma_residue(void)
> > arch/sparc/include/asm/parport_64.h:static inline unsigned int get_dma_residue(unsigned int dmanr)
> > arch/x86/include/asm/dma.h:static inline int get_dma_residue(unsigned int dmanr)
> > arch/x86/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
> >
> > Only the Sparc functions return unsigned int.  The rest return int.
> Why is it so ? Are there any resources I could go through to
> understand it better?

There isn't a reason for it.  Programmers make millions of little choices and
some don't matter so it's just a roll of the dice which way things go.

regards,
dan carpenter


