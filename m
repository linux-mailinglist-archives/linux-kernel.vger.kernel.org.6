Return-Path: <linux-kernel+bounces-546805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64468A4FEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760BE16BAA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49946245032;
	Wed,  5 Mar 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sJETZT0d"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246B201270
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178701; cv=none; b=PSta89gOF2Nupnr17dhfVnGWUTrT7isadKi09O6EqZbvCeTHa4iVS50vsL8pK0MSDdlY2jcpHH4iRyIKxKu4zFl8St/oEHR9SDTjk+ya0ETpD1NAmVjgGlvqVMJXj5flG/9kfYNttrxpfj6tauhb2acj3RD+XhTRvWRm10VuZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178701; c=relaxed/simple;
	bh=yO9RSssbgEUbbG6Eui7gZpTUFd8pnSYgqrFrmf0GkAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocsf2AWMTq4jaS74xnbtey/u0hfRzKY8Y9/9xwNxH1kDCNgd0Bf2u8xekcrP48uv0q0sLawWLojK/nEFYJKo0c2kwiQJPtmWcT5KWDGwqeh7nI6oYEdxxTC4vnSYvdc7FP2hZBivhMnJCra1I617klnoZZYMNO2fZQ0ts27dYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sJETZT0d; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4FB373FCD7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741178691;
	bh=urCwtfpYBHrLbpDpp7U+vepeooaJV4Q4tWy+4UvDFzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=sJETZT0dmmtDqVpxunBVGXvxh3A3ncpsrIflMBlHW/QCpj8RYYF/i2DdQN3u9Ylho
	 uEcVqykXxnzZiECvpW/jT6Pjulc+/2CGsMVevZiTmX86Pdhoamj0aQubPIr2+PURH/
	 qOM0t/8K+gWJPHJeKMDS95c+5OLB4AgsPqE7LEgRn0Kzhd8RoCozf+tTne4evbHMUF
	 6E/oZCWPYh6xqetTaWMp0pXIHoQUD0rPlszhwEDldW2JgLEN8mLsV3Lj26kC85EbcN
	 2Qtj9P9R21CuHz/TT6fcAM9Ia4CPeOlswtsM8LriT7FgsqeQx69nNNuTNxsjZ0m+BU
	 TTUD8lDPqNURA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223878ae339so60383685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178689; x=1741783489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urCwtfpYBHrLbpDpp7U+vepeooaJV4Q4tWy+4UvDFzE=;
        b=VibyldWpA+Uya3HM6Vn7RToWhprQ/hcjE/95g1iw8/5s9SFaBOWOlv/QnIUQMsaxKz
         q4WsiIi+wc7c4zP068XNKT0B0qNj7j6B/hq5SP7GSg90PDQJmtaPMpyyd7ompnKSFwTR
         eYKIKu8ZslivYhoNCx3ztUN5vIzn+pnFUaGZFeyKBm3rGMqVmxM1k8rDT34k93J1zb9m
         /TzCwEQcsjWQsMYHpsdh86XKHotD0S0QP+AhqvIk/5Ts1iivIJ3B/Bur/G0YsJbW92Em
         8sOKIQnUwc9HoqtrkQgzSkLQZrGyKY/IFJz7i1bVWSUxafQuSy02TFMHCGitssuBgMXA
         HBeA==
X-Forwarded-Encrypted: i=1; AJvYcCWernw2TdRpObJs+fjuDdlNx1f/8huE8PnaX01IAqSbtN52XgiRSBRotlPAbfqpEf7mGVYevjYJtUhwpKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wi2hsq3XXfeu0nM+V6tTExeWWq2uWhl1HvHcxU8h2+Tkadrn
	DaUqWMTNlHGCiesRRGBmf+PUHbux8trrmhKfttQh7FDOA3K7muesSSN0MWOWvXJQZk/ob5AnZtx
	bDD8eQV5PWd6cIBCtnyJMazD7xUiRIcx9qSp4EG4uRiIEDi/Ocus8kHguauAH6s8Iy6Edvcx6kV
	GYK93S188sIQ==
X-Gm-Gg: ASbGncvdQ5xA1+oueStuCiUwIX+T4A5Us5Ks13xdjUrFfBnUYWDPVSdFc2HaBmxKjug
	Qek1hps3Ee/AYv4VClEmtaMPqfx33KVS6jGXVi1W4zvngLkGXJ3K0KjGWtPr2MceUBMHHX8WT/L
	Hpw2grJdMVQrPqIg2L3fzpqzAFSdQZI7OKYb7HB1CDf8W3ehv0jd2eB3/OogRWyKfM6GMIiDlJm
	z+Opi7XVJpwTuSGrAsPKr61eYK9S8C37o3mdkJO+nh97bD0xm0B0U0SD0ks8EZ+9nU28QcVJUoe
	Fhn9PMKMLqJs1gHu
X-Received: by 2002:a17:903:1aa8:b0:223:5645:8e1a with SMTP id d9443c01a7336-223f1d24c43mr39977625ad.51.1741178689711;
        Wed, 05 Mar 2025 04:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDAT8zt0xy6LiC4EWYqcnGzlPoc6M+Lwdom0HGZWoZiXyYU2ER+E9bGNsMCb2zeHuOhGe9Mw==
X-Received: by 2002:a17:903:1aa8:b0:223:5645:8e1a with SMTP id d9443c01a7336-223f1d24c43mr39977395ad.51.1741178689425;
        Wed, 05 Mar 2025 04:44:49 -0800 (PST)
Received: from localhost ([240f:74:7be:1:b58:f691:f9bf:7104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050f11fsm112505365ad.196.2025.03.05.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:44:49 -0800 (PST)
Date: Wed, 5 Mar 2025 21:44:47 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] gpio: aggregator: add 'name' attribute for custom
 GPIO line names
Message-ID: <m3a6hcsh2a3j3rcw7x2f3tn3gif6mtor7bfxdmwkgp435vmxpg@upgh5b2t3ukh>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
 <20250224143134.3024598-6-koichiro.den@canonical.com>
 <CAMRc=MdoMKdqyzGMFDa3aMz3h=vfZ0OtwARxY7FdsPKcBu9HQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdoMKdqyzGMFDa3aMz3h=vfZ0OtwARxY7FdsPKcBu9HQA@mail.gmail.com>

On Thu, Feb 27, 2025 at 10:50:34AM GMT, Bartosz Golaszewski wrote:
> On Mon, Feb 24, 2025 at 3:32 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > Previously, there was no way to assign names to GPIO lines exported
> > through the aggregator when the device was created via sysfs.
> >
> > Allow users to set custom line names via a 'name' attribute and
> > expose them using swnode.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> 
> IMO this should be part of the previous commit, there's no reason to
> split the configfs implementation. But only change that if there'll be
> a v6, otherwise I'll take it as is.

Honestly, I held off replying here, hoping to get some input on:
https://lore.kernel.org/all/CAMRc=MegKxwX-RjQQcWMGe_JQyRCv82WRRbD0naYkeXshTGXGQ@mail.gmail.com/
since I thought the decision on sending v6 might depend on the feedback.
Anyhow, thank you for reviewing.

Koichiro

> 
> Bart

