Return-Path: <linux-kernel+bounces-214007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C923907DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC211F24A82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC613B798;
	Thu, 13 Jun 2024 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+M2v+Bu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508D763E7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312167; cv=none; b=GwSHfwcigvWOzZLVRlyQbty5ga8D7hxLvvA4wiQ04JGrKrFBb4E9NtcqTS10pxgQ354lJXPNlVpshaJ18arSVghgKZtaK1Ygw/FKbPagN5onmr4FpIHWWU8/xXd1SpoDJdCpVs1hp2lC18mQIKr3hpqnvYGXy+013OMUT1RC9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312167; c=relaxed/simple;
	bh=/o9SMZeH0JArvECk6xRjNeh2FTZ6kHf/xA91ncCt6Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU/4RJhbC86m1SQY8EjWi1ln7MB7orrOb2g+wlHg4k0gecrYfbJrAByDQyt3pz6nhnHpC8s8UxJvcWqUEmneNqygb9XUC4LSkF6ajXDqt9GWRHRPf70iWoMhBbuUL9Qxvr7jxUd+tUahvYTC9RRNfQf0ioMKqWu5kSweGG6pCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+M2v+Bu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f1e35156cso1433314f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718312164; x=1718916964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCVlCd3UjUTBV+cEEBJwXjWu4fzORp+M3gwsYSHFfxk=;
        b=E+M2v+BuevQ0z9OLal/ypHByaJksoyg6ZQixe6R/NgjrUz5TIArdn8DXahbbZFt33t
         9Rd9U0bvFXLzs6iFIkOoO4K2iAdHIXzNugDXbAp6om6r59ikcd3foa+IRTie/ksfnCAy
         yh97coeLqnaJiqTaO4w75P85QB/nG2TW4LmE4Oq++8s4kvHTiEUhxPZv6iukdUTxkwIq
         nVPAQrvG9paL2Q0KAxduFppw5nvQ82IAdfb/1Tl/vzdbSL3V0DiF4OzbUTazp/ApGsnt
         U8rMF5o5ol2ovR2ICZZRWfs/CEWapOD/Ic/lX2BJKkKV2uvyYO4hx/DlNq95a/RM5Syg
         QEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718312164; x=1718916964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCVlCd3UjUTBV+cEEBJwXjWu4fzORp+M3gwsYSHFfxk=;
        b=LAdwKKNoc39yJeM7QzsYcqLEa891LXHAtxyyIZ/6Z1Cu44LCpPh/EBBLAG2rbHiA/p
         UsF7mcT0HXxLjBhkI7tW+vVpJMrBNxY2l6hSWbsYJy6UWY55R8qARuhKCXBZRIZJ44qu
         nkV1Ni0jA/76YTKetV1tpcZ6AEIpXt+7BNdCNKTz9sRA2SqDSLmNBemjnzsG50HqsFvU
         rwcDNZ/yLTXm450wxuQ/OChdqGDWkIeof8mGGgUOzQ/tHmNU54K2NceQ8PSjA9l2mfxL
         2OH7oLbS8oq+W65KPbwnp96pRAJIKDyFwVuiIh+vxAKEEl0OfmKIp8ULB6Y8Swl/w2Q7
         gdpw==
X-Forwarded-Encrypted: i=1; AJvYcCWrpG4E2YwsUO+SrXbJPmz+r+u6O0sDcojJu4ibT6uLT03/z3aWAAOdeO4Tctllv2jgls5p/ySZz7X9078pDLhLicZOVV5o9Co4ZGNU
X-Gm-Message-State: AOJu0YzvO8pgHCG2bg2W095OfH5NwEzYuFeN+wwJdXbpYJAj0kTM/rQ9
	4nqO8APtNs8Z3HZ+uu1wRFMD50a+PhZQ8TPHno0P74WJTJpe1cHygdlHq6CuRRg=
X-Google-Smtp-Source: AGHT+IHTv39w8lYeW6DtnAHirUWaWA+9uDEYHURyMfqcjKzNxs7TKlVdAHjocyZ0l2HAT3NjGfz7iQ==
X-Received: by 2002:a05:6000:1882:b0:360:6f9e:8a85 with SMTP id ffacd0b85a97d-3607a7d978fmr569390f8f.43.1718312164263;
        Thu, 13 Jun 2024 13:56:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad216sm2631782f8f.57.2024.06.13.13.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:56:03 -0700 (PDT)
Date: Thu, 13 Jun 2024 23:55:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Teddy Engel <engel.teddy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Remove unused constant IC_VersionCut_C
Message-ID: <ed5db92f-68a0-42ef-898c-236d8342c25f@moroto.mountain>
References: <20240612143326.6764-1-engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612143326.6764-1-engel.teddy@gmail.com>

On Wed, Jun 12, 2024 at 03:33:26PM +0100, Teddy Engel wrote:
> Remove unused constant.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> ---

Hi Greg,

Please don't apply this one.  Teddy sent a follow up.

regards,
dan carpenter


