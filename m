Return-Path: <linux-kernel+bounces-180198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B58C6B60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65D6B2412C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CC15625B;
	Wed, 15 May 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S+ycvS5s"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE85338C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793528; cv=none; b=lDVwLJQUjk1gUgi4wLyk1VWNdFkixleex6RnPE3D2vL4uBoyLaQ1MV2KIaLuKViOvTL484wgisiqr6cxdRU8jKDMMQJhvGPDzuvIyBzrmLLHrhz4ERLWhodzLUsq9V/COTGFif8cgNKPEw4Oe61vEtRhpwJA1cbN2Rgifgfe9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793528; c=relaxed/simple;
	bh=FbQk/akDgWQK4OgW2mmwZ7RtjG2cUSndWEchs5pTFD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlySSdV37jTFiS5TgaiQ0HZ/4tYW9S68EGgxSIIb/+wCqQwp6zXMWItmoULA3rTel2944rMHDbB/qKS90WH4NRfyNS8UkpgOMiajkyhB2LF+tbH0XI6Yr16H4iy9A56AuzJe22N+SFuSgb7B4t/R5rfqqXvrjrtktJVIQXiY1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S+ycvS5s; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so49679965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715793526; x=1716398326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMRgIxRDxTtgBIlS3j2j7+NXryr0xF0JVKBnk0pt4+o=;
        b=S+ycvS5sOE/QXA9ifMMGdJ+kXCmPO3Qkg2kSYLFUjNC3yL0EwuOlVcqxp8w4C/ncYD
         IORChfgFm8jfrXrx3eKoJA5EdEzl+A5DNpZv5BcbZ+V6hjgltWXVdnxqKqBBVOvtz/ov
         YGbY3xfI/VyuvjFMSY5MAAQNCFb3LIxidb+wyRqfz/SBOSNdvmwqZiLcAk7hEPzfh8D4
         Q8fl5KqzK5dd2BaiKkKr/Cot0JpidSdpEdtqSHNojZguKO4R1TYM5wFKYKM9N2hxFea5
         gcjIQ503fIWjKa/GKb4CeD9/nLMTjOmUtzskiUgkTaIJR6xFDEilLC1AUIeW+Y3ibREl
         eWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793526; x=1716398326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMRgIxRDxTtgBIlS3j2j7+NXryr0xF0JVKBnk0pt4+o=;
        b=fRUqZKbI3mlhnC6WWTXU/+4rmQNBIMyJyEQj3zUmjFv35k9tGuepEweWXGc6zVU4mc
         EfLySyvJgIxtlyMSIDJdbDalSreJCh5PL4KJ3g749GuoWSAaDuTdCJ96LaOEu2zdl6Ex
         RXBPVqP1h8+UkPERVugsbD/kuLl9Wn+EpskIK8Sn1QOuyr5ununBgJvxE15Zu+ABHMIM
         XZ2vG56KOIZc76w2YyfuOFCddW5Z7YMYNChhgy2uXj29QQJaIiTk410ISBhHjLNfrTOO
         yaLPUKAtkNzxP6Sw5ZKR4hDVNZ5fsLNF6V9XG4aqjHCkUa0JmJkKxh69ke4jDfM9LaRu
         Upag==
X-Forwarded-Encrypted: i=1; AJvYcCWA73ZBk3azbcKviH5KGLAr9LCjCOdEYLbog/EHh3VQIQ2y3QfvOvDIGgiiXEhXjkIeesb8VrQ7Zu/gwkcNyTxDxM1ivemAYiIw9Pwk
X-Gm-Message-State: AOJu0YwJj8x+xkcIpFSdU+FvL0Avagsvhfc4HZzaJ53t6fV1EN4N25GI
	fijaQ9Kn1LXU0mKDJW+gVTkM815OjhMF6xWPgc4DUiJ88xEFGzXFijy330JhCVo=
X-Google-Smtp-Source: AGHT+IE5hyJawzSf8ZM4GI4gk91af4sKnGyPtAY3fL7zCfLOuNGd4lOCiIQTpvmplgfpjQtAiPBA+A==
X-Received: by 2002:a17:903:1cd:b0:1ee:8fb7:dce9 with SMTP id d9443c01a7336-1ef43d18246mr199563625ad.15.1715793525935;
        Wed, 15 May 2024 10:18:45 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30b2dsm120929815ad.148.2024.05.15.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:18:45 -0700 (PDT)
Date: Wed, 15 May 2024 10:18:43 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <ZkTuc4fxXcS/g7hC@ghost>
References: <20240515-comic-sketch-3b40e6676f55@spud>
 <ZkTnlEnoFFrQdXi2@ghost>
 <20240515-slander-stranger-683758537aee@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-slander-stranger-683758537aee@spud>

On Wed, May 15, 2024 at 05:56:30PM +0100, Conor Dooley wrote:
> On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
> > On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> > > helpers") added includes for the new vendor_extensions.h header in
> > > the T-Head and SiFive errata handling code but didn't do so for Andes,
> > > resulting in allmodconfig build issues when commit 589e2fc85850
> > > ("riscv: Convert xandespmu to use the vendor extension framework")
> > > added a user of a macro defined there.
> > > 
> > > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > 
> > I was going to fix this in my next version but was waiting for the
> > reviews on the thead stuff. I wasn't anticipating these patches to be
> > able to jump the queue :)
> 
> Yah, the reason for that is I asked him to take the non-vector parts of
> the series as 6.10 material so that we'd have less stuff movin' around
> in cpufeatures.c so that Clement's Zc* + validation changes wouldn't run
> into a bunch of conflicts etc. Same reason that I pushed for getting
> Andy's vector subset stuff merged today, but that mighta been before you
> hopped in.
> 
> Cheers,
> Conor.

Yes I was a couple minutes late to the meeting, whoops. The subset of
patches that was pulled into for-next is odd to me because there is some
of the thead enablement code as part of the vendor extension enablement
so that there was a user for it. Since the subset on Palmer's for-next
does not have the rest of the thead code there is only a
half-implementation of the thead code, it allows the kernel to probe for
xtheadvector but it doesn't probe anywhere.

In my opinion, a better solution would be for me to get rid of the thead
code entirely from those patches. So that there is still a user, I can
replace the thead code with the andes versions.

Since Palmer already pulled in those changes maybe it's too late. There
is not a critical problem here, but it seems like it's bad practice to
introduce code without a user.

- Charlie


