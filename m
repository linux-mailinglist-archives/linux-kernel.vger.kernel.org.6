Return-Path: <linux-kernel+bounces-345021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436E98B12E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43991F24E20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB4188936;
	Mon, 30 Sep 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFQfvQAO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5080184528
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740264; cv=none; b=ZCPwxIUxNqgUgAb8pVuJFJA2wtarmn1QDQvSb1LbWwnl2/ma3SM9zdDGCcjH1f5+QEmiim2p34Nt/RZFyEVgTfpHOvGT+MO9R0Xw9jdaRsc2gz6BCqtdIO00iO8IzATB0oIJqFCX8Ve0MOXg0fsDWigTBwkYL+Li7Mh0wD+hcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740264; c=relaxed/simple;
	bh=aAhaF5+fnyhUXky/IjAdyOY7FUt77FmdjXSFaMAVyzM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5iHp97PXq0fIqgwsOivUdE9OL03j1UXrirhmKKIEOohWBCxYqUCzEFpgejCVJ74sPnHHk+TwvC1TgbPKt3fEJ2crloWuGR4g1GRgExVeI6shQI1WH+Ms88XRZL8VFe0q94qEt5Z23agu0myH88OyUBj1LP52Lg8GnHvDoptW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFQfvQAO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7191fb54147so3571122b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727740262; x=1728345062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZepAMv1IbXph/c5ZYMLN1yYOZIJMPZ4qHLLEh7Sp3H4=;
        b=QFQfvQAOt5g4sfvAY2ePH9kZixOePhttIgYSs1ZNkKo+3r+PPG7T8QOOLcwJSSMH65
         wYdAueUAfV8eHzKgN62Lmgf3QNBlqEpS0Cnwgj8Thp5vq9tRMIASOqbjL1RFUt5e9tjD
         +5M/WjnLmaJ43ZdBv3uvj3Pwdy5jgqqm29FP0yXKir9ubnnB3Q9eKRU0XR0JfkfnRywm
         RA4eDyn4c0409H6Gm20B0jgxZYK6sWqP8OJADWAvEkC11Y3jilQzK6HF1Bj89Nn+wNkK
         AQ8iPLNwguhID41Wwt0VWG5Yku/ULE9/s66wEIBMqHYk3e17rJBVFYy1GWKDPNtTy+lr
         zwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740262; x=1728345062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZepAMv1IbXph/c5ZYMLN1yYOZIJMPZ4qHLLEh7Sp3H4=;
        b=i1RHJ6AdFDRbW3Mvqf1jiaHPFcsBNBl+/mH/WI/M66jjICR37P9RgSr/BqVeRT4J4L
         Qmpya3dePRWrIQZXb6ZJ4ZYOmO2r6VvUKTj4/nyF/VZVezrrJfE51XAy3mYeeSIaHftP
         b69YmQnbTorwua2l+n2Lb/SvOCczEy9FIgOJzHIxub2rlIkaIe4WPKskQl9qjRdmtorf
         ns86v/jc9YJ1yzhDQ4DuTqJE/UEPirQZRyLb/JObANbghS24Fy6BGGYTUZF3+P4KTpNm
         +2xnXdE40aRMQGVyo4tjTwczsQ+lONbR07Ma3ot+moTN1jbHaLdU350BiJ/uKAA2iyNw
         /dWA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/GrGMjlehkA4/Q1wd82eO/O2bthdjx6erXEgembjTzHvar1O/hQrN5OaPhZdZdviXb41HFERCW/D2hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFZv2Y+GBoJFUUWjlaw8kmSnKl8Gjmcd9DOYM8VckHdRNBl3E
	4AkdVICwcqU9Xb5bZaz8xznXPofMTuPoEu+iz7JPosVlgL1vTXW2
X-Google-Smtp-Source: AGHT+IFc54oJB+eiGYePSjQ+HClIhGUtqa+ogaveg1+IBWvLcuDqJ0EDUycUje8IJjJWHxtnoVGQng==
X-Received: by 2002:a05:6a00:23cc:b0:70b:176e:b3bc with SMTP id d2e1a72fcca58-71b2607a990mr22178608b3a.28.1727740261905;
        Mon, 30 Sep 2024 16:51:01 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d4bsm6832508b3a.158.2024.09.30.16.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:51:01 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 30 Sep 2024 16:51:00 -0700
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
Message-ID: <Zvs5ZHCc4MGkE8XK@kodidev-ubuntu>
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
 <87bk0d2c51.fsf@igel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk0d2c51.fsf@igel.home>

On Tue, Sep 24, 2024 at 07:29:46PM +0200, Andreas Schwab wrote:
> On Sep 24 2024, Geert Uytterhoeven wrote:
> 
> > All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
> > the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
> > x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
> > The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
> > fails in the same way:
> >
> >     error: ‘retain’ attribute ignored [-Werror=attributes]
> >
> > All my gcc-12 compilers seem to support the attribute.
> 
> That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).

IIRC from working on the original patch, older linkers which do not
support this 'R' flag would simply ignore it and not error out, making
binutils compatibility less of an issue.

> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

