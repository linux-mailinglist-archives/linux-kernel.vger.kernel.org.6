Return-Path: <linux-kernel+bounces-213758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF299079FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EE284B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9414A0A4;
	Thu, 13 Jun 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fFfUIfNl"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBC12D765
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300246; cv=none; b=J9uFb92ud5d5LvM76blg2pBwO0n5IwV+/lIYp0H2USuocqQmouUwk5KGzdVRdmBDG6OVXH3rqNBkbFRTinTsALeysQn4HYIw73SZFzwNyGnTyhJOnv9pxx+VWk2dDFieBRYN+OrdlLN2+LtarNcCDkuS2H8tA3iNzBYIyOV/3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300246; c=relaxed/simple;
	bh=tXc/IPw9F2ZzPAzq8zhKW3NQ/NzXgn/tJsZW2snLyt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPiGhDWKGmG5AR96zdNbLLxH+g5TvCjydqLOp6oAL77bAmPFXrfq15TcdI4LyufXIqJAfiEasj8hFHyrssGzH2gWHBLvw1+pLU9hZcWgPc4D2w9BFuTCuSGLyengHltVaY0m/swnkI/MKWC3GyAQ2G3FbuLQzYpXie10uq9MGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fFfUIfNl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso1056244a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718300243; x=1718905043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeXCvOjfZUoc8Yy0DfPd4nvN0/4du747GE3bH4Ko4l8=;
        b=fFfUIfNl6S4bipDTkvQBkYQzciacTD4M95mnlnbGJRfhYDY5uGfeocLh3fcjZ/IuDe
         9WbOo9TXes/ZrIclogkM0FlRxlrunuEFnePhRlbDDQtnpKmK28StJmp9xabue5KsRJlf
         23B6YwXgWIDFb+YPxU+ulmYnJxz6gXfzMGtpaD7jFHWlJL8iq4RZlhc88ROjCNwNl0AL
         H1dOxV0PpB9pSChW7X1bLhrjkkqBnISkYnIc5llgxOtHKB9DSmnbBwpmgLUEcRaMBnGg
         jl+Ny4DOmmFXQrxAUwc/grfvyVIPc1G5r+KnbcLAwmkhOQUQixYdHVvatnDprnJwCk+u
         e91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718300243; x=1718905043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeXCvOjfZUoc8Yy0DfPd4nvN0/4du747GE3bH4Ko4l8=;
        b=hBStsr47dkumRhKPOBXfN2yM2yQt9QWydZ9emhqhoD38rDthh09m2Utvj/SIuSAPm1
         JpaYbNaGWCZgaRri3VsJHYojrB7OajB1CAp5rfNCywPCbQCnmGSGwVbM4nT7uPGycLGp
         VzN+Ea2XYKeO56+eUvcPeMUv8QHirVrzQ4wl209KKUSaeDnzFNEu7Gjht6Kx+bgpH4A0
         T3JIZEWt+hPV6dJ/XD3tsQkjSp/d80GIwdN00ALsEaNXS2J1ilZE37rdaQXqImrn4WG/
         Xi+C1RvI5derLAmYSSuHpY0qEBSAzyAzr4ajekJQd4fK4TgupqA+2lUi3ckb/rav/M+p
         R57w==
X-Forwarded-Encrypted: i=1; AJvYcCXzna4kf7ProHLwDQ49lY8bX2MOettyQq2dZBgM6lKVKxfML1v1uR78Vjfc3e6xIFSZeBA1on/5dYyO83kc2VA12OHVlfNBbaSlBb/F
X-Gm-Message-State: AOJu0YwnTrywP2qMYoOLJBmDWzZZq/JaRFGhFKt0zahmx2W+mRdMb3ir
	6IxL/7dcTEagsmpm4B+kmGIRABeVHFSR9qY5js2B3rqCkaFmum729BC1wlgaHlY=
X-Google-Smtp-Source: AGHT+IHlqr2Gr/wVcfUHyYVtjtoS+IIJeHCrMCvXHq1erzaUkYT056DbAUb1350ehkSOSzCBD/aMgQ==
X-Received: by 2002:a17:90a:1150:b0:2c2:cefc:abea with SMTP id 98e67ed59e1d1-2c4dbb43d8fmr471729a91.32.1718300243218;
        Thu, 13 Jun 2024 10:37:23 -0700 (PDT)
Received: from ghost (c-67-164-127-253.hsd1.ca.comcast.net. [67.164.127.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76a9f14sm4303029a91.48.2024.06.13.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:37:21 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:37:19 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: Separate vendor extensions from standard
 extensions
Message-ID: <ZmsuTyVcxelGvGw+@ghost>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
 <20240613-deepness-refried-c6dea811f6f6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-deepness-refried-c6dea811f6f6@spud>

On Thu, Jun 13, 2024 at 03:45:33PM +0100, Conor Dooley wrote:
> On Sun, Jun 09, 2024 at 09:34:13PM -0700, Charlie Jenkins wrote:
> > All extensions, both standard and vendor, live in one struct
> > "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
> > it is likely that more vendor extensions will be added to the kernel in
> > the future. As more vendor extensions (and standard extensions) are
> > added, riscv_isa_ext will become more bloated with a mix of vendor and
> > standard extensions.
> > 
> > This also allows each vendor to be conditionally enabled through
> > Kconfig.
> > 
> > ---
> > This has been split out from the previous series that contained the
> > addition of xtheadvector due to lack of reviews. The xtheadvector
> > support will be posted again separately from this.
> 
> I think that's a good call.
> 
> > The reviewed-bys on "riscv: Extend cpufeature.c to detect vendor extensions"
> > and "riscv: Introduce vendor variants of extension helpers" have been
> > dropped in this series. The majority of the code is the same in these
> > patches, but thead-specific code is swapped out with andes-specific
> > code. The changes are minimal, but I decided to drop the reviews in case
> > I inadvertently introduced issues.
> 
> Actually, you only completely did that on the first of the two patches
> you mention, but I don't mind.

You reviewed the third patch of this series in the first revision of
this series and I should have updated this comment.

- Charlie


