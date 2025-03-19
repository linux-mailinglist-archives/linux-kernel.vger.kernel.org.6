Return-Path: <linux-kernel+bounces-567711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F2A68953
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17CE178B11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7C253B77;
	Wed, 19 Mar 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqzk+EdP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09E253B79
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379619; cv=none; b=iFpbK4G5TcKzE6hHLlETut1zZ5lykEvATzR4j6M2JscWHWLx48tHeOYZ8u07nT/WM9tAeowOdf4/0hTXguwGVyqgway+ZoK2Mxk5QPA99Z7pyODKkdFXX/Q8fpNiF+fQHYW5WqMEIAJwd5E1NRMJAvpHoHZaliVIVVQCiqrMmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379619; c=relaxed/simple;
	bh=tK60PvB18wBvxWYt9lvP7XZvyX62+1Eh/q18fiab6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsWkz+FhJYqGIW5KsH1IsYVXjOebR15cvMZDMpYE1mugLLmL+MdIyy4Jt2JOw58fT3F5CrHS57i1YTGoDsGmehFgNYYVD/6vauCEE83e5sGCv1Wm7DEZp4smWwQbSKt7X1WdeeHVytxccVn/XxBbdrFwdHSF2a9+iYZLuVwGDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cqzk+EdP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-399676b7c41so1932180f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379616; x=1742984416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=Cqzk+EdPpIhDnCwd4eZQhRJmj37M2X58h2HO5uNqgSIH22V9OW14Iab3Ju3v2/JBGK
         FkBh+Vl+ywlPDXLek56OVX9eR8guijL21wCkGBOrgCBDqWVTlUyF3Y3fKKCO3l7SLWUk
         jOEddmM13XNbr2OwEDURPTNxBfXb5OlBEi/oxCUifpl1mr3whqiOhSu0CRKjMMNuUjh9
         9slN6j9TtWAO77QjCTesk6z9yRW7BBsUpTsypOZ+aWphqBGd+J7kGPNlXEE96Wdpk08M
         GbHQt7vH+zR/MLbHBv0S8POfgt0v5joJzok+xCZjw6r4elUMOvJEV4DVk/8Cg1gP+Ack
         KKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379616; x=1742984416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=umx3aYLyHmMeyopv4IQNPDJzNkaiowUwUeVyoNMbQP700RATkVKbywYxTkhiiZ5QSN
         UtB0kSlk07W7oo4n7Z92npAQAyCsg6hb0cu9uEDehGxcG3NJ1L+ZqyrQWHA3FCxjZ0VF
         kak2uV65tL6TI/G/mLWdKUtqe5fc4DGnszMmDYdQ4oPHDwjNbk22oY6EhtBvCknyZmn2
         /ybp4hT8jdzs+HHXRzlaPgwKY3b56HF4sfrHwAlNlHd/ypKMQfPB8qs7sGLvNfmOZV3+
         4fgTG7uzgmn9/dU3GGFVI350O6hQb8/33HBdwzo76Mfwix7woXFdoqk54AGmmlVFiXNa
         N6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqAc/WLkz+FZWPNK/x/a1W7fPRDHcr9OqtUC3e6a9w7ov9URZGfz+ObFGbmQvqiAIWcF1WlSdssyyH0z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejQccbEfngSaMuLe/sqxsf6zGDOQV1olK2wm0+O8fQGQTU+a+
	0ZVEgnLMH/34GwEpJjyziHd/I9T10soPNLjUj0KgRF2gi0AwZj2A5pPDIHCo2b8=
X-Gm-Gg: ASbGncuan6IoakrMfdYc2O2yovQnoGnCd04QtLn6D5qGfDuYccf2udQqM27Sv6uSOEc
	7cpszk3A4DAbFs7RKjRACYq7fDyzEtz6U28HT2I27A6iWV2Zzrg2PCursfz8JeYnRoegBOHqKq/
	KF8cxnjV/01FjUCFDM9sG0JBu8kTEghEdutr5nEWnHH/bHCxVFGE02DyKktTZNkMGk3D6G7zucP
	Rgz+MMgR4Y09vYu47CbTHP0m2iGuthR+KnMbUvKRHyscH0mqAAtixZ/xbFIyTiGE1UU4Fi438EE
	4qMLCzVk2Z8gEU9TGs7Bf+Dma+VeU44Mehl66itfPHx+0BjqlA==
X-Google-Smtp-Source: AGHT+IHjcG6/IeV2BOfDblPqcpvGjw3L7kajd7hg9EDti/4DwNoU0L0nZRG8X9Tat0FLH2nt55nwLg==
X-Received: by 2002:a05:6000:1541:b0:390:e655:f998 with SMTP id ffacd0b85a97d-399739ca2a8mr1441536f8f.26.1742379615798;
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3506sm21189338f8f.11.2025.03.19.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:20:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
Message-ID: <fc197abf-e65a-439f-9d35-83f4665519f3@stanley.mountain>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
 <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
 <20250318155946.GC13829@willie-the-truck>
 <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>

On Wed, Mar 19, 2025 at 09:05:27AM +0100, Christophe Leroy wrote:
> 
> Doesn't sparse and/or checkpatch complain about 0 being used in lieu of NULL
> ?

Sparse does have a "Using plain integer as NULL pointer" warning, yes.

I can't apply this patchset and I haven't been following the conversation
closely (plus I'm pretty stupid as well) so I'm not sure if it will
trigger here...

regards,
dan carpenter


