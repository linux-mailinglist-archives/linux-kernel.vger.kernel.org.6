Return-Path: <linux-kernel+bounces-210525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2637904523
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41920283656
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035E1420B8;
	Tue, 11 Jun 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DRo8Ef67"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E71CD06
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135240; cv=none; b=OJS1rmbEuHEdCicx1WuY0tW6hyot0kyvhaKBXt8OrPiGQXbgH/U4Q3qlVgmZLFy8FYmKHlkMI27rNqHdNRrF/tetWpDMbz//+qHBnns23FQg3dH0RQvD6vqO491eyatlfMv84V/vzaRHaJgPhMJGsBR9IBwTT7ZVxSOEvDw//10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135240; c=relaxed/simple;
	bh=uCNDyWcELfp1Oid3wEh3hhNBU0sDdHXgnTWH4GJUymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJVurss2mwLmPABVBZYbZaOPlHUk06nuZD6rV55pQI1Fyx/oPrjUtjKKDkM69WgYmJVY2tqihMGYLpd0elc7rGhFPNX5qaFN1AS3gF57vb0z2pQXzY3g3zguGmJUwX/7cEn9Q+ohRWqYqV2y1XD20icrexvS7mgT+4Gk+TOt4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DRo8Ef67; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6c7cdec83so49178505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718135237; x=1718740037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qCkTNdoWHedtO2Rublq66t6G2AvnXm+h/79qji0mlS4=;
        b=DRo8Ef67svKZEGKbnvuzDIRbVD4BlGvPJXJXPS5BwZWv+Zty14v9Xjejn4YfIsQksI
         5a2/OwUtOCkQFfz2RT9Uw8Q3u2iQ9to1OSG4ORCRBqut8/wwUu/Ws2tQg60kjt8N06f/
         kiIMdiAiwvDSLmd09Jmz8v4kGtqONNdWP7E20gFBmjXis8qWc4CdqWYM9YxgtUc+Yl3o
         4vDTNIzK/dDww9qKsCV//9o/vIS9N5tat53P80VAIIXYkMSoGv2GcdyOKPQpC4yzEBo3
         Wbd6llY8qscNJQbz9OwkjXYRchMWutAk6UN4wQ1UnvFCZ63a4zZsrzuq3UnnfV42kwSo
         tb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135237; x=1718740037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCkTNdoWHedtO2Rublq66t6G2AvnXm+h/79qji0mlS4=;
        b=AbvAdsDaClNZSoyju2z5n82CV885o7R/8nxcPtvvK8+1I04BNCbzuLLmx+Fewy/2HR
         TCEhs2dWrV4zMnafTzYWcfgW3l4aLNnoU//VZNVlOHn5ZeuqKTrBWNJQUAXJxIBboGwZ
         3FqqtTnKPo0yACfTHw44PBaPZNdnxoGMqzjE++C/Nz2EcqkjuLLlEdTc82PpLPdg0GB9
         L4dNW5BMYRUgdb1UOk4n9moefA2+KJJMmJWXXJkNtcH2e5OZnveKVStdmB1nJDpsdUn7
         Bv5X7yqRiQ/C8RDJxv3yoyW1/AA6EFE0Op3rhI7R9ZkEyn2C85di3wf0bxu0dwwfFC8s
         aqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3w6yHjaOAqo7ukWshTcACO6lSvVlOHyuV/sB0wo5zRamIU7QCYJHoBiG/KMj5QcFscZiZeDxi6OJ1OQyi2M9P/cQmIJUPwcdTsGI
X-Gm-Message-State: AOJu0Yy8Rn1+5nK2r2xuBTrfT5ZDSW+Takj/c/YAXNlE0jVaTKejli3A
	yLRJLEKDOgM+XniGuo9B5FoawZBvUn7M1NuRZeqBm1IDl24raluvQgyyD3WNsHQ=
X-Google-Smtp-Source: AGHT+IF72CTY1GSL+psPQ685hIrEeRutg+9+b9kEwCoHappRKyYOV15sm3Zs49FEAcTiubbmLDM4gQ==
X-Received: by 2002:a17:903:244d:b0:1f7:eb9:947e with SMTP id d9443c01a7336-1f70eb99809mr71450745ad.63.1718135236937;
        Tue, 11 Jun 2024 12:47:16 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ff937456sm57302045ad.243.2024.06.11.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:47:16 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:47:13 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2 11/13] riscv: hwprobe: Document thead vendor
 extensions and xtheadvector extension
Message-ID: <ZmipwVN/WBCQcJdY@ghost>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
 <20240610-xtheadvector-v2-11-97a48613ad64@rivosinc.com>
 <CALs-Hsu2jFAfr7H9UfLd9VHEZvpfF7Q6Chxko3XbBZBCU94eSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-Hsu2jFAfr7H9UfLd9VHEZvpfF7Q6Chxko3XbBZBCU94eSw@mail.gmail.com>

On Tue, Jun 11, 2024 at 08:58:37AM -0700, Evan Green wrote:
> On Mon, Jun 10, 2024 at 3:57 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Document support for thead vendor extensions using the key
> > RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
> > the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Evan Green <evan@rivosinc.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 204cd4433af5..9c0ef8c57228 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -214,3 +214,13 @@ The following keys are defined:
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
> >    represents the size of the Zicboz block in bytes.
> > +
> > +* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
> 
> Our recent snafoo with CPUPERF_0 popped into my memory
> when reading this. Does this work properly with the WHICH_CPUS flag?
> Specifically, we need hwprobe_key_is_bitmask() to return true for this
> key since it's a bitmask.

Hmm yes I need to add that. Thank you.

- Charlie


