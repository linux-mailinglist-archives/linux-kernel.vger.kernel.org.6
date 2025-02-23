Return-Path: <linux-kernel+bounces-527917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E86A4113B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570E93B783D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF318B470;
	Sun, 23 Feb 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaqUCAY5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3E1802AB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337379; cv=none; b=stC67iLjIBcri/J70hyTQNfg+tb7fpsHJsCCKs3GT8azsxC2fWAttaW6bEywccDtj8u7WiVZjSL1VPUmsbwwtuArfqrNMiARXy+9JtrP0MoFbI6XM6w4UyF3tbV/GVZr9AzyzmMywKAj6MymnEXP5r1y/UCz0OXIKUFWnZ0G9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337379; c=relaxed/simple;
	bh=83ZmEIPu0rg4wzVzwOxpH0twJBA4klvkMu8UH1tfEHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHdK4ukCPB30f4GLYpXkbK5cCfO8GHE5GD9Wfz5+/wXLxzIXHJvaexaa1ygqc+fv80R2dVos9qbeBTXGj2DXvCl/ccHd1TXZF2T6Nhkwjqu8qTSthdN8kTyLQ/2lCWBOPD1mkhJMCzpt//FlZQT1PnxBKMGBoAu+Z5g5+91bJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaqUCAY5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d39a5627so54811395ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740337377; x=1740942177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KD60a3sYz4BVsJRUNz4/mfTK0PbJMWswr4r3/WyQyJs=;
        b=EaqUCAY5oKWs3Yxttsi9hYNMPH+h37HFluRqvZkWUH8H7z4tVDZchEleNr92U/8ZsO
         audMH7cPNAXF5z2Oq8beJF2PxqpJepRDdnSnNCCHhpqCKsGHqJy09XJ81Dnt1SIXsyq/
         uq78RiH2CxPY0dhRWSMA7SJJcbPd2cORUnfTjMrNTVL831pAsbSvZxPopggt1T+zOnto
         /bLCZX91PSLLfJBfW45Of5LtUoYnL3vhilrn252IVlVExn/IBvmwXvgvZ32GkpmbhuTU
         +7bmkRJncnzI/2WlgR2SBBZOCBKJWhImYv0qAmmsYhJP1RipnXxT+jyKGTVPmulMKqIE
         cd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337377; x=1740942177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD60a3sYz4BVsJRUNz4/mfTK0PbJMWswr4r3/WyQyJs=;
        b=M9dK5IJZxmHuHkh5K+KBK55fbA66fJiPlbV3C0BmyhZ1tSYGx3qtM9vO84fwGgLjwn
         TET1IJt7nRRHvZrfuJ8n7XZOaan5QF/0cGXT//uXmOXoNkzDx2yVXXvrHOI4IWx9PRGA
         ODxpJaIULLu4FqnmvugdNX+nnm2s1+ILSlZ339UFRtCrhqlOJwVv0rPfp3qq6UJSvPGx
         cCd4/KcDVbULGWWSpcfnngc4KijHMqxNPwRQdRF7+aVFadaI+TfJdsAYEM1mr29LeMkj
         389mLyftdiGn35UqL1OtEBDiK9ISW2bpvx4FuYmh8J8d61D+HVp6O00XUTrLKZyH/wni
         H95A==
X-Forwarded-Encrypted: i=1; AJvYcCVebi+9L3bbvrg6d6lyt4cw6zu//iv2o4lAOm7a+s/1JIuRCStU/am4x912oJJSPBYHNqxuvnACeRYm04A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVGep9jMMdEvOB2qPf2TCeEXxwwKzATj4VogYkDy91LUZ8oga
	tyx6EK8XM4ekEiyGw5R/Qu+zd8ycbIIniYzGd+fZqYBKdrdEtlza
X-Gm-Gg: ASbGncsDYRYB3lqftUjssDecdunnvEul3oL6If0zc9Shn8lgobW5xmzTdnnhnc0IqBb
	3mERmYnOEpj4lr7sKQ6RZJ1txfq/h0hD1yN/tkxp0hF+wm0LMyWKKQrbtaxIUMjY0qDlKIHZ2rC
	3BxBKyF710shR0EPxd2bapnlohG6DyYSwGZfqcr8mMYdK29oxI70d9O1tscdSP3fK95H0J3qKgA
	duHx/exmIcUbLLRXcumcKBLZjqev7PiIvoHSZ1ZF/IyjzkIWDU1XOTsHfckbNC+mqZUMBm2mugn
	60DvyKrh8QfgGcpdtrn0w+TbsOgmte/28XveZT5uAOU=
X-Google-Smtp-Source: AGHT+IGEQDs0s5Ed0l/WzJ2lo5pWHI190RI6/3auq9kjMI9eZgQeOwnjGzssp/E/UZkwfhFC9acUqA==
X-Received: by 2002:a05:6a21:6d99:b0:1ee:5d05:a18f with SMTP id adf61e73a8af0-1eef3daaa38mr19727956637.35.1740337377169;
        Sun, 23 Feb 2025 11:02:57 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:8f01:f01c:b79d:a991])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb586186c9sm17472779a12.35.2025.02.23.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 11:02:56 -0800 (PST)
Date: Mon, 24 Feb 2025 03:02:51 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	skhan@linuxfoundation.org, mka@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v2] uapi: Revert "bitops: avoid integer overflow in
 GENMASK(_ULL)"
Message-ID: <Z7tw2_AEcp9mYXOX@vaxr-BM6660-BM6360>
References: <20250221074208.832153-1-richard120310@gmail.com>
 <20250222091128.5429f1c2@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222091128.5429f1c2@pumpkin>

On Sat, Feb 22, 2025 at 09:11:28AM +0000, David Laight wrote:
> On Fri, 21 Feb 2025 15:41:49 +0800
> I Hsin Cheng <richard120310@gmail.com> wrote:
> 
> > This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
> >  GENMASK(_ULL)")'.
> > 
> > The code generation can be shrink by over 1k by reverting the commit.
> 
> While you are setup for testing this (and me being lazy) does changing
> the definition to be:
> 	(2u << hi) - (1u << lo)
> make it any smaller.
> 
> (A summary of the size summary would do, no point listing lots of '-1')
> 
> That can also be written:
> 	((one + one) << hi) - (one << lo)
> so an appropriately typed 'one' (1, 1u, 1ul, 1ull, (__uint128)1 etc) can
> be passed.
> 
> 	David

Hi David,

> While you are setup for testing this (and me being lazy) does changing
> the definition to be:
>       (2u << hi) - (1u << lo)
> make it any smaller.

No problem, I'll run some tests againsts it and let you know in the next
iteration, thanks for your suggestion!

Let's leave this thread here first since it's too large.

Best regards,
I Hsin Cheng.


