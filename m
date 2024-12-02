Return-Path: <linux-kernel+bounces-427415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D365E9E009D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C2A286BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBC1FC7EE;
	Mon,  2 Dec 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f0x2lwrB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E731FCD0D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138663; cv=none; b=lK+IY2XuC3w8jRP1W+q8xbjYtWqNOZafVC+xD4A8eMLY7b6d84DsT+HZJ29qB2OfZK4hXXh/menmlzpw9rtBmfg+dagNqNDuXRylt+u9y5hoAbAES31a+mVvF+zlUJoEAGfzAYwooGven/tQtbiA2lNuy33/tcErx057PR+YyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138663; c=relaxed/simple;
	bh=Le/CT0HdxkOxTxpEIgbZs00IaWmCTN8Q+VVslanzm5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ/CIyuEgnEL4E7Mc40LUXBYNHEey/hFDDCTSYvoZ4W3mNZ8hcKKvhwt4TkvzjZNYcYpO5OV+Rz0JKhF4InJjfb3qkn4BaGY7t7D8vG4iQGJp6Yksm8sZbosTi3Gx8K6s5uSbtvWwV9G/5FHByAFgFHkoZVjfCfbvc8cU4ATEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f0x2lwrB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so5294005a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733138660; x=1733743460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obnJSmZ+xwHfGrcrn3ssi8SdfUDTV1zzk++2UAhZeVw=;
        b=f0x2lwrBlohWdT0IgSS0cuTk4a42jUDqAMW8nQ4F+GGvYOFy2tSfY8wggTgf13y/72
         Pwe3qE3ntwgWq3BJ2F7bvKit4iMwXPpmlXJvVgeS5Es59aW6pWKZDn5l+dQn35NG2RQD
         hfUdvPw1ULrXachWTAQIouelQtnEghKg+ZTJ6t8HQkE2cT6fZLNXl4tmbffdFN9SFopf
         QVzS/BV7yEl+ixVLlpKLrheK1hu/unISYjTwz6nusXgqTB06vHl0nNqieGHHY6rXIYZi
         4GeKW5amgn9nLhsz+x//e/3sm0kUP59EJAZcB+r3sb2Trz2A4fgT6yLQ13rUYIwy5VC5
         Zx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138660; x=1733743460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obnJSmZ+xwHfGrcrn3ssi8SdfUDTV1zzk++2UAhZeVw=;
        b=SnNHwZhU3KSaUgnBFuYfqgzuIpMT9msdGAJO66+m5XUJfAy8Y+fpPvT3txkr3Bjk2G
         k0uiGVY6n+uVQacmoTp3spiKW1IzDJmxTwJxVpyEdapgTnwFHvlC6XY83t8awBsD4HGt
         9x/j1atP4eXBPEio7BrfsyAPUYMZctdalwOnJNOrkZa8qpBoaqm3pVepGKS1FotBL7rl
         oBLEexdtnebbjTqP/TmS67Z3eHnE9bVCGr/dnI0tjzgx2Eytq3mGifMn/CehbCWbcCQr
         Hykqg/qHvuuc4SzC4LaX0TmIqGTlmDKMGBEQexJ8Dyz5DG+Nz+jBFrLKNjK9L3xtEOLv
         wFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaydZAFEwpha6fLuFSkET12NkmDQIFz85oRIbXJs9MxVdShzQNsaZPSLiaiXCRmSTDGVRQSqB0J6EGpKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowmPnneO8+ErGATWMSlVLD3rLjqMY5xbYRdS8ZQrj5JBhdV0o
	jffdwBc49QdRo5R1r43pxq6grtVGeH2HQ8JzG8us97wmpsq87JCdEiVAoxmADGU=
X-Gm-Gg: ASbGnctM+kJzZp3053qgbcCAk3blG/IqiribEUYAQAVVic1h1VRZJ0fltH8L7MFfBeD
	OrPk1p+FCoZ7A1nuwgliqGThNxUnk7zjePLwdQQOOKxr0MYXNIA8i2cRLedzhrtclFxl3N8/6JN
	2UGwrEj5dxNobc6OZU/HD5/PFM+wKjohRTuv0nmHc9kd4shkEPog+69T/Nft/FUG0MYyj50Wfx0
	lV3WIzOlzSyeURrAQ4jpl9pEGgOwUnRzSIg8Gg3vuqKmIqD//Y=
X-Google-Smtp-Source: AGHT+IGRr2sfa3kPmLX9QQIs8OutMaXCzA3Y9HC3xsDdeYaVS+Qq/jH3EPQXM8M0WSw/SJjyL5wbUQ==
X-Received: by 2002:a05:6402:13cb:b0:5d0:e871:f2ea with SMTP id 4fb4d7f45d1cf-5d0e871f402mr4705115a12.16.1733138659730;
        Mon, 02 Dec 2024 03:24:19 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0e27b3da8sm1761821a12.5.2024.12.02.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:24:19 -0800 (PST)
Date: Mon, 2 Dec 2024 12:24:16 +0100
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <Z02Y4C5a-P0kbaq3@pathway.suse.cz>
References: <20241024083530.58775-1-zhangwarden@gmail.com>
 <CD7BF255-7128-412C-86EB-305CEC7FF2B7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD7BF255-7128-412C-86EB-305CEC7FF2B7@gmail.com>

On Thu 2024-11-21 09:36:25, zhang warden wrote:
> 
> 
> > On Oct 24, 2024, at 16:35, Wardenjohn <zhangwarden@gmail.com> wrote:
> > 
> > Add selftest test cases to sysfs attribute 'stack_order'.
> > 
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Wardenjohn <zhangwarden@gmail.com>
> 
> Hi, Petr.
> 
> Here to remind you not to forget this attribute for linux-6.13.

I am sorry but I have somehow missed this patch and it is too late
for 6.13 now.

Anyway, the feature seems to be ready now. I am going to queue it
for 6.14. I'll just wait few more days for potential feedback.

Best Regards,
Petr

