Return-Path: <linux-kernel+bounces-449626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC29F51B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B27A577C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE51F76D4;
	Tue, 17 Dec 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAs8OuYx"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B761F758C;
	Tue, 17 Dec 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455265; cv=none; b=OXPI0l5Ek0g8vFwJ9p2yjZRPcG+Rwl5gPz83iurKlYgY6UcBvIspEVvHKBtvs30OEKPscE8sQWdedcHl+hN4cjLnk3FnfJYze0hAu6q46xISGNHw1MuBBkzos9IkCQotIOahfCp+qHcQoYPpDgNN0+zN4UsrXKXx0nWUo++CPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455265; c=relaxed/simple;
	bh=24YzlLUaesVmiCXA5ZZw3OEnO8/n0AggGr0PIFWJydE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc6xUyphb6r4nRNryXH4GR6xX2VYHjKKd3veT1Ktif3x3Z6jMGWlf7amxLkur5d1Zv/hfATyPtU1MXC0hLYPXBdRQCczV2oLuogkyITV0FTbw55rBYu/utM0MjiyOKedAmrWwRtyQ7vWrJXZiD8JEclzlakNU9XpOexLd5yetRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAs8OuYx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so2360846a12.1;
        Tue, 17 Dec 2024 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734455262; x=1735060062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX3YnKJY2Bc+H1TD9mItVl2Oo89nnkREc82Z6u9KUqw=;
        b=BAs8OuYxUNTkXISEywhuJifnNzvFI+7SSA9UJ34kR5DkCTiMRSmPQKW948/9zwhP81
         5tcJT4pSa3Y3qJgtxAGV+54f2ESlrJLZ9YfnEOTNlAOopw3dEsLVgCvDRBZig/w8+0Df
         Ye9/Pt62Ey0JHXso+Z8tT7Az3rw/SsqFZ5RB72SREb4I4DYw9+fcCszGHzOlONqusGEf
         /nTi5hUzWGeN7dyONtf5ZfTWKJF5m6IzHu2whYrk4QiuqrrdIwo8ITEInXHn/sUgVCER
         L0FjXEQD1hP2lf2F4I0SJHHbNlMFkgwRLXzgbCvq6yWskrhq4rhaqcc24DRM5ZN8d7Sx
         dghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455262; x=1735060062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX3YnKJY2Bc+H1TD9mItVl2Oo89nnkREc82Z6u9KUqw=;
        b=e8FZ5VH3OJn7g2HFXIb3ZYRO1wwYZcpepsLLbHIArW2K84ihHvR85C/xKiD3cHj46Z
         ChB1ObmGBBfoHwQOSZ9Nvuzjjec31mLJCS+yiis146BiX6ZIF4Fdu1qVVXAV/yTg8a9v
         hbWrOWfOMPrAjXlgV8X5IYh4GRqOsUrD3uIlfyoFVqDVVSbvriDL1BONN+DUFZaFw+oG
         1jvkkIawOUvnDjVWxHdKeQm59DV/i04Z/hzkPMRlrgm6qn6X+VtQk00jIGKSSUrZeIYz
         3PUhzaP2lW/oFqRDQGwnPx2Lpg0ZXdj4NcudMC3GqRKzrCNysQcaAE+PqLcnlfhy7n2W
         UeKg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDebRJXdeqHaWIuwLRhkh9g5ygK20STaZeENL0QF8jPpsJbnfy5qvFgfCjxaGi8IXLa751ReWzd/BIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoIcYqPuZMO7aU4SLsAE2EC5FiTgNdkKlrYy8GCkrOZbQ6OXa
	RWv/QDDrQcjPRtFwlNmt9BY7a3SLTc+RMVa42U8OS2T9BaSPMBy8
X-Gm-Gg: ASbGncu1/ICSZmttjbTEztMrjHzXCc+EUOUbIWYBk5Qhp8JhvpH6kZ71NnnrHWHeIZV
	UOdrXlFfh+bV53T6CK4DOYZaNdRH18y9P1LWcHE1l6gc7NQEWRTKk/6Fc5UM2d/7x+gMUEGCkdB
	a44IVvIzm0L8Rej0C/+Su222AuwKrJfoBLp09Wjp0VUQO6/mv1TJ13kTUJ8mbatfY3hOMH6LD26
	lKu9g/f9WiWDEj/T5dg6Tr24HpDcNRViZaaTOiRo3qlaozOEkXlp2ixtGeSvlGpt5YkgLrp34TC
	ZmTim+5uzVDqnEBy
X-Google-Smtp-Source: AGHT+IEJ7qjx0yITRgxXoUN87onsLYTMNwlr+MdD0KnG4pxhmEJWMvDunj79TW6GaEeTRoCs6SoDPA==
X-Received: by 2002:a05:6402:26cf:b0:5d0:e826:f0ec with SMTP id 4fb4d7f45d1cf-5d63c2e5349mr17070247a12.4.1734455261855;
        Tue, 17 Dec 2024 09:07:41 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f26e5esm4678163a12.63.2024.12.17.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:07:41 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 30151BE2EE7; Tue, 17 Dec 2024 18:07:40 +0100 (CET)
Date: Tue, 17 Dec 2024 18:07:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-53144: Bluetooth: hci_event: Align BR/EDR JUST_WORKS
 paring with LE
Message-ID: <Z2Gv3Nhye80RUQ7n@eldamar.lan>
References: <2024121709-CVE-2024-53144-ee57@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121709-CVE-2024-53144-ee57@gregkh>

Hi Greg,

On Tue, Dec 17, 2024 at 04:55:10PM +0100, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
> 
> This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
> ("Bluetooth: Always request for user confirmation for Just Works")
> always request user confirmation with confirm_hint set since the
> likes of bluetoothd have dedicated policy around JUST_WORKS method
> (e.g. main.conf:JustWorksRepairing).
> 
> CVE: CVE-2024-8805
> 
> The Linux kernel CVE team has assigned CVE-2024-53144 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 3.16 with commit ba15a58b179e and fixed in 6.1.113 with commit d17c631ba04e
> 	Issue introduced in 3.16 with commit ba15a58b179e and fixed in 6.6.55 with commit 830c03e58beb
> 	Issue introduced in 3.16 with commit ba15a58b179e and fixed in 6.10.14 with commit ad7adfb95f64
> 	Issue introduced in 3.16 with commit ba15a58b179e and fixed in 6.11.3 with commit 5291ff856d2c
> 	Issue introduced in 3.16 with commit ba15a58b179e and fixed in 6.12 with commit b25e11f978b6
> 	Issue introduced in 3.2.61 with commit 373d1dfcffc6
> 	Issue introduced in 3.4.98 with commit bc96ff59b2f1
> 	Issue introduced in 3.10.48 with commit 6ab84785311d
> 	Issue introduced in 3.12.25 with commit 778763287ded
> 	Issue introduced in 3.14.12 with commit 9a5fcacabde0
> 	Issue introduced in 3.15.5 with commit 039da39a6161
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-53144
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	net/bluetooth/hci_event.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/d17c631ba04e960eb6f8728b10d585de20ac4f71
> 	https://git.kernel.org/stable/c/830c03e58beb70b99349760f822e505ecb4eeb7e
> 	https://git.kernel.org/stable/c/ad7adfb95f64a761e4784381e47bee1a362eb30d
> 	https://git.kernel.org/stable/c/5291ff856d2c5177b4fe9c18828312be30213193
> 	https://git.kernel.org/stable/c/b25e11f978b63cb7857890edb3a698599cddb10e

I asume that https://www.zerodayinitiative.com/advisories/ZDI-24-1229/
back then which has referenced CVE-2024-8805 is cosindered invalid
right?

Cc'ing 	zdi@trendmicro.com 

Regards,
Salvatore

