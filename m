Return-Path: <linux-kernel+bounces-392385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C099B9378
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4E1F24B97
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F61A727D;
	Fri,  1 Nov 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWnRu1WW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940C49620;
	Fri,  1 Nov 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472005; cv=none; b=RNGaLhD8x1fnRF77Z8B3p+gH8lfDAaLU2J/cIFNfffpSrSRdZBS1dwnUfLYwMp3FRAR69FvR9jgLDFbRizWxdT1+QjrrHvCGD4gq0vZz5dW/XRSlyTXotONRhpLrui4KQ8B1frqJs42SbafZQh+4ys/GiFgjUayNCNdMynZh8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472005; c=relaxed/simple;
	bh=6YLQlHvi/p4VdDm7l0sIzl6HHY18ceHijPCewbNDRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alz9XY+wOmiDhqMLXL5ZCsyhIW3n1v69xza7Y4hOyPpZ7ZAXnTk1p1R2rqCKnL4Kqb35UCMYVvvvbz/Q3A9xBOXEAhe7AQ07jtsBzOUEP8wRPQJw5vlyQv8Eng07nFmtdiy0oZwh/LUc9AZyFuaRVwdWp4axgyFniypeuGQLy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWnRu1WW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca1b6a80aso21634775ad.2;
        Fri, 01 Nov 2024 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472003; x=1731076803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LaKq2sZDJssQEEm2ipuTPYg2jD93ktOnyJ+1GFezS0=;
        b=NWnRu1WWcVjCm9HKsigJ4sHm0UHYimEe2rwqAC+gubS8Y3mAo63+ZQyPpjFCqTEleQ
         xKEPKVnGdUOBPHYPdyHnEqj0SWR0R7lj6FnlbpxLKeZgae/aEobGPqy7i89DyJQCVHSG
         MF7ieu8c6940prf6hn7S42Qk4BVl4pGHc43URobIIDH1jTuJ7xdtRtT7fMFlsX6htYHG
         5NgoKud9LuefPKaFHDMIq+7/SZVykcrOZ2xZUBRKadaRdpPu7knDgrAz9WZDJAoc1nW7
         Bl93qseGhvaCOi7GwvFd3XXJpwBj8efGRO5agLboVJVUT/IRTm7pPiqbBQChoxzs/FJY
         akew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472003; x=1731076803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LaKq2sZDJssQEEm2ipuTPYg2jD93ktOnyJ+1GFezS0=;
        b=SFNsijC7dek6V5XoIrOWAH8qSTiNZh1iTbVSC37Q/WiEPSZJlJo6DUUoXO0eFDT0mc
         HRbnCn4viRldCcOUqz0nqawJL5r/kAZzomh4ASfcJ6hqJJV5RsEjVUnhn3dEWmb8Twpe
         RdzBjvz9XnnZ0+zxU2hm16PIYA1iepqzoyRmP8niPnWdHwua+wipUdSrd+ZPJ3v0PGiO
         F/zjLIwrOSqEpbNuEY4V9vP12+grhL+3hYeYLxa9A4aJ/7gYHYS/jefcVSzTBl2hLc8R
         PW8eg6G3s3HXc4X1qd4YApnSf7Mj2O7T7ncDsA8nM4R+Tr1wgLyFgEKG50fvWCAOTDc4
         Ux4g==
X-Forwarded-Encrypted: i=1; AJvYcCUEKtgxE5cwp9pZbsOSOmH2OYtEHJwwuUVoXoJYCPf7nAVITz65xMCSCjkbZn7Rcf31cgoLHd9+uJqDR1I=@vger.kernel.org, AJvYcCUW3XJI6h9IMvOQ8pUtB2O9IlT1zV2/QIIPHmUnru1eGRe4CxuDktvGi+dHQuE3gR0NEkhZqjU20Fld@vger.kernel.org, AJvYcCWRxN5tziDsSiTVyvUl8Ds0qwgPZqlowEZj3Nywud4hAJyHgqj/J99It/qkjge7ht2Mu5xu+eyhauVaDgPx@vger.kernel.org
X-Gm-Message-State: AOJu0YyPj09DjFWug79AlRYM1T9JRSgFrpWTzk/JJCsaaohVpOoXtg3e
	idoDj/6O1THX32Fycm39s+SGl8BCm8tHM5rmTklecQVFk01z/mdX
X-Google-Smtp-Source: AGHT+IGcQP/Qh6G76gJ9k9+oQKhCOXfTSChXqE8x5NSOWwVBYYU7/qXMYXPudXeeXjWUS+RjC9HE5w==
X-Received: by 2002:a17:903:22c8:b0:20c:7796:5e76 with SMTP id d9443c01a7336-2111af3cb6cmr53047615ad.18.1730472002704;
        Fri, 01 Nov 2024 07:40:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a60f9sm22438845ad.167.2024.11.01.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:40:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Nov 2024 07:40:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, sylv@sylv.io, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: pmbus: Add bindings for MPS MP297x
Message-ID: <300df630-fab8-4017-981c-181b87280f60@roeck-us.net>
References: <20241022103750.572677-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022103750.572677-1-naresh.solanki@9elements.com>

On Tue, Oct 22, 2024 at 04:07:49PM +0530, Naresh Solanki wrote:
> Remove mps297x from trivial-devices as it requires
> additional properties and does not fit into the trivial
> devices category.
> 
> Add new bindings for MPS mp2971, mp2973 & mp2975.
> It is Dual-Loop, Digital Multi-Phase Controller with PMBUS
> interface
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

