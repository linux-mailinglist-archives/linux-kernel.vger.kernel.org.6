Return-Path: <linux-kernel+bounces-562616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F9A62E89
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048FA189B71F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70956202F9C;
	Sat, 15 Mar 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmSjBQ9i"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F619F130
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050545; cv=none; b=TxibURi2uS+RmYcLrQZCom1iGMZbGYUY+chnQwtzd34kWf8eoJmMVgx0JayqPSODIcgg5xhmi55iBq8RhNLpMXM+VDOgDrCiU9EX9r3wYV35rrP+vHhcwhA3be3jgtiEJARuKGE8qotXV69X7AAk4FRQaAC9QJICheRisNpAnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050545; c=relaxed/simple;
	bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=aK6J8SL0vjQXG2E/2aLL0s6rWlMOxXFj5IeOu8aVYjYCUvqsFZyDOIqDGbAZpPXRkh6qvZFktxp5rih3fBGZgdJp8F6qejdu34XMI2eFAzzbUa/f2ZoSVohZotc2iiYTCept0Nfozuu1Q/ZV9oQmFSMLODX0KdR4e30VvK1cWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmSjBQ9i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso1027021a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050543; x=1742655343; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=PmSjBQ9iXnLJUW2idUj4k2rryQQVbg/u4JfQq9Z7sOLQAWkwBeOXLDdObkRKX/YwA5
         VZKXGNshnwN3FzHVih5sE5LsjfahwEYo8mTxY+LFfphTknebNzB/lfuO8AgeHLHwztzw
         hsQclR4CmM2Swg9TQqh+7yBxVTAaMFPsWwwstd/omtTWD9gRwkFkiw3zLoYoHumY5V1+
         OGK3MYKiA74blXWHYoH8LmYf767Z13BBpm0aBv2/F0xio5h/xsfr2n+3+iVpbq4gm1iX
         bEVfjWwVFbRAM9csDsJGmDcIdCcvalQvxWekpf6eq4XRcvLFvrtmew58O7LnVVFdwxXC
         yFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050543; x=1742655343;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=WY/zxP2v7npUeH0uYFa0JMEU/DIcW8Dti9Zxol4PbswIJPHdf8a9wFRajRf+Wl0p2L
         Xp8Hg74fIQH3Fl4dYSvfixdbcEuTI9BY3ChC9c0/kBK6/JA1O+Ls1n/Qccq6ukHrtfNE
         gwdfDIKFueorI0B/mKLKoXS267USwTvbv7A/Blzsm7c0yHxhtIvY1cS856XUmMFFbi8Q
         eLPxz+nbIpZRxL3GcZKcCf2XQXF8C+RuLRQQWCdKb/CCtWt7/3NjCZIQ4Wrwaz3FiVw0
         dMv7E0O2DUZtSn0/INWNmyux7wmSlNi2F1mjKi1SlvRj61LMjKasctqVT4KonAudEYhv
         2IvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkmQ1JwCBdJ2xy7jsLpWpiVf20K+ek8wJJM0k+Q52BXpZrNerY+QdvAwG9PGl9u6upmCst7q44dCbzJW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SPSHB9fN1Q2kS4f5IJypKlzsoYMZTYbzpY4R9ENSvV+ealnV
	ytEEVwA+K/buTDoSrhIN3huLnLE3+L7BRAfy+MWmvpc0wcvRi4CB87TS9/zqjNvQiGTNh2WHoUn
	3+UgOy+hR9HgJsN7FrX5fVlmjlCY=
X-Gm-Gg: ASbGnctKLpvzdYN2+vPvAstkG/EHD0n6EjouZXLcp/3URKP5eQOef5oPAJy2GDfLf9T
	hsNfAvPrjoWb/vP388a+6JS8bkrscv7+NKazEk9paUMHISFfE3VJ+9u2WuJoKIzrXdj6oyYLhla
	mRIpoQ3L6eYMbB/MjCQw5G1/M=
X-Received: by 2002:a17:90b:2e44:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-30151cc2490mt7920206a91.16.1742050543260; Sat, 15 Mar 2025
 07:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
 <Z9ErEBuMMvd6i2n9@kernel.org>
In-Reply-To: <Z9ErEBuMMvd6i2n9@kernel.org>
From: DiTBho Down in The Bunny hole <downinthebunnyhole@gmail.com>
Date: Sat, 15 Mar 2025 15:55:33 +0100
X-Gm-Features: AQ5f1Jrmv7KQRCuWBIo_vXTI9aIDRsZr_EQ5uQHAURWeudjXpiSlHPWiANvw4jg
Message-ID: <CAAZ8i80e6CsD1Y36-sVrVs4QPB-82J1gPOeDvHa_+sQtfUpMtQ@mail.gmail.com>
Subject: Soekris crypto 1411, where to find ?
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

hi
this is probably not the right place to ask, but I've been searching
eBay and similar places for 2 years and haven't found one yet.
I support older MIPS hardware and need to find a Soekris crypto 1411
miniPCI module or two, to add VPN acceleration.

Anyone have an idea where to buy it?

Soekris company went out of business years ago.

Let me know.
D.

