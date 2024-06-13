Return-Path: <linux-kernel+bounces-213670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE02690788A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767021F2126A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8E149DEA;
	Thu, 13 Jun 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOgtUPa8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72752143887
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297069; cv=none; b=TnhfL9tsVDLGd0eyKU9Oa+MlexRFkBwLb2I9XI/hBWl3fBQwHwFal1/inyeDmm0NvBKyWUJUg8fEGtsOkCNzWlQYofwbFB/pOwL+H+Ymln4Lo5/AeVDpum+iogQuanMU797I7AdNBhW8UHD/Lu9xnHeUlZFwbuYOaFZV73aftFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297069; c=relaxed/simple;
	bh=OYE/Xcvy7p3lJfgQxzABES7ztNGSQ3aAbGFD5fnWbL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZh++HWvcZFG/zDGuZiyqFjoljEunXlQGr2vhmz7O3FjXMVexMIl4+mTt6oKTFeinqvB/pc0ebpyTf6M7aW7sqo/CVQQIxdJ7JPMfNsAmaCmZSte82v3SJ7p3/EO5jhkakf3Ez2ySc0nuXgDLD931W6a13AR08zVyR4cJCGuks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOgtUPa8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718297066; x=1718901866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60AjIXfo58T+HENYCNF845hVhoQVriIsm7V/ZBwIR6A=;
        b=nOgtUPa8wDb/AzrfxrpzyL4rlLy3Jl4jn7YGI3UNW7ED5tqZXFT9+bS/3b9Mo8VHwS
         XA6Gm+E12H7kIFX5vGD6xG2N3gyQB7z6t9m08Jo302b3PbhTVVoPzA/7zgSGqKOhOgAp
         kHXiDQTMuMC1EgLEHZnTU7znwzRc9CW+bJdTFXKR5/KiBXzEO/TmU1nOz69MJFT7/s3a
         5BK08WbeGA/++IjZcmhJItcmTYbVJwf5+8sH2vqjsw7Svx3tivFIcqPTclAfYyD9UR5N
         I3VkJ2wA1VFRuWkfW61DwV4J5PWyvj4MB6fENn5KVaj0agGspXeCwtA4dgp8w/sHqWl7
         KdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297066; x=1718901866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60AjIXfo58T+HENYCNF845hVhoQVriIsm7V/ZBwIR6A=;
        b=h7NqYlHxHHPdBJDvcBtt1hf+MmxaVzZEt/fWUTop+McKx16cKZjPD81eeb8JOAQmiu
         e99E5lbcy0WNDFVNVcBjRXGZR+rl4RgxI1OTVG5VlAdO7GfK4FTSDElA6At8Kl9XtGQh
         geBsunMbqQdSHRCSVZC9OtIPFWmGDmmirAcTqIN86FBmndclhRyfGCNWtQ/06ETv591Z
         VwKHXLf2hrSv3a/Imi2RFd6XfGAvrGrkQyZt967wZGTGjFfj06XATs0+9a5C8vpeztEc
         hN3MxGmxjit6OPSr2OSr7VK5Psry37JZ8PZSHBX3tBV99nAyPp6yG37++UmnE4Z68sfe
         5aiA==
X-Forwarded-Encrypted: i=1; AJvYcCUduXzg2LWNHJwm1uXcZ9lJvHKPwgE7RdiyQZ1ASix/AqG1mHTosxWMeK6s0ZactLUut21laP0h6nAKekkKLgl6uTF01PzH2Mcl2wqk
X-Gm-Message-State: AOJu0YzIpA2I2weqhHGjriiHNheVOg3SWdGy9DrXxQ02AbB9rnICauGq
	g4m3OXXgTQws3xcToHTCXIPuYnAjCG5ozTJsPv/8jnGznQA0BtFPqzrn9BNCsw==
X-Google-Smtp-Source: AGHT+IEKkUD3gscpagWRaWkiDGBIKwrinPH2oqVCfI52M6kqKGwJfJ4Fjefhxe6CptSIa/dUoU0i4g==
X-Received: by 2002:a05:600c:c1a:b0:421:75af:e66f with SMTP id 5b1f17b1804b1-422d474b264mr2382325e9.2.1718297065579;
        Thu, 13 Jun 2024 09:44:25 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a26sm2176227f8f.97.2024.06.13.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:44:25 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:44:23 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 0/2] misc: vcpu_stall_detector: Add a PPI interrupt
Message-ID: <Zmsh53PnONKG23MC@google.com>
References: <20240613141335.1134341-1-sebastianene@google.com>
 <86tthwki93.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86tthwki93.wl-maz@kernel.org>

On Thu, Jun 13, 2024 at 03:52:08PM +0100, Marc Zyngier wrote:
> On Thu, 13 Jun 2024 15:13:33 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > Hello,
> > 
> > I respined the v2 version to address an issue previously found here:
> > https://lore.kernel.org/all/202406132132.FBKSWFav-lkp@intel.com/
> 
> So is this v2 or v3? Having two v2s on the list is... confusing.
> 
> 	M.
> 

There is a small change in the patch 2/2 so you are right it should be v3,
sorry for the confusion.

> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Seb

