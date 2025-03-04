Return-Path: <linux-kernel+bounces-544004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A191DA4DC4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0356189E739
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2C2040BE;
	Tue,  4 Mar 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhMSdpsR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACF2040A6;
	Tue,  4 Mar 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086830; cv=none; b=MwOpczcgcm8lEznjw7HNkGkDNgLX1nNL6MXxxsRqNMVYnOupen6OVXa8BX5IughNn1hGNXUcu9HWy8Ibig9Ra+FJzP+JtNtWqBPfbXiqV19zgifV8IDo1MCMnJQOoFXoSbHCrGbSq+2SbitFniADZnEEi6WfPiOSdip7Vc6VS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086830; c=relaxed/simple;
	bh=1eb2xI/Z8Fws5Q4rva7Mr0Ok1LH3OrqtSQCPoaRX6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxkMl/uF4iFSlo0ufH3c63aprRCGdyqTbTIaq+l+FGWtz39F/DuuttCLVXF9MgUtKfg5h66C97yYIqZ5EEzaMOaGhLQnqJ/6kQFBC4ETbAWI83Ja67mDv57R8SfCtb7EwqSwYrE/cjYfD6LXlAK78tyk3JNx9N4rmQKX/BEDXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhMSdpsR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235908a30aso88116115ad.3;
        Tue, 04 Mar 2025 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086828; x=1741691628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsvBQ42haXm44TkA4xjE5aaK6WLS+9Ndji8VDL/8jNg=;
        b=fhMSdpsRkc2d8APzy4ws6tNWlLAPJ/CvGlroSEsC78XtnrWUOoCePjcJ2GjwzaIWsN
         0b3zpZ145L8c0zAyW7CHjzEWxFXU/bvt4zkfFhV7H7bves/lrJgxCnFNBtXLIKbLfgxb
         IJTEyOb4d9zWlRmwdsuUWZxwN+ymsC/6lsLIdfAXtf07LzEY92rbtZSomByJ0Yd74KX4
         k32IfGPTLrpS5caddxMupk1XkCyrFYj982kQscrcmZOv3Y54GO4IwTZoBOwBAe4NdsK9
         BViEPIhdRTU5lnlaV1DwbnQ2BSOcLC6I4X5zZFZMOjCvdPYwrEgKZBu7Qvj4zf4Z6AHF
         0LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086828; x=1741691628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsvBQ42haXm44TkA4xjE5aaK6WLS+9Ndji8VDL/8jNg=;
        b=BJE37jLtaAvKzyZ4KoU3wmuQIlRNHl+Vw1Mu3q9locT3xvLlSzoPAMvUy+VV5Ho4t9
         gCjQ32001KRuk1Bs4QZPEwcwr8Vz6HkDnwYK68+gcqlbQkp+BrwrTA8dupnqAoKBnT9R
         9w4XKk2/N73o1tOHtxfLg8qI1L2e6PQLKaMEZtKLZkZ4Qqc4mCVQ/ftuwhPMEpTTobfG
         ZxRBwvfB0XKwzskFYaOUnB06P7TcSpkO6266snZBTADxxwJW1bF4eJlcrDO/rx31+jJ8
         dJlkVqoc/cYvQWXtL65kFd7SySZXzwsgTKuEoQHog/AybBRI5BFOs6JgdQBk1vmAOlen
         8L3A==
X-Forwarded-Encrypted: i=1; AJvYcCVG4KP+LCNKSyQ7Dlo7I+wj7gpcfKOldmLGeasKTGSI7Y81oD2cRHiF52NI75TQfbmr2E3gUKbStnTyAQ==@vger.kernel.org, AJvYcCXQoz7a13fUoex6cyMK97IHvTXLAUE2v499QETfaPZiOPbdaWlOQSRl2nDS94g9/uODGFYRIQKBNUcM3OoB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vHRez6MpUD7elWFqalbQRpAn1exc8cIr7OUYMzsasQ16ra7f
	9OeppAcaYC7//gK9k0ZIEByrQUUVXEPUV9xMBaP8Ij0n/CuU2eU/YkLyqg==
X-Gm-Gg: ASbGncvvdd1lPqEHFunBjhU3xTGklrLvSVHI+RVR1gXHA5w72U2fNfeymFXlkxZUprb
	mD5qpJvAEgM8iGJc+6UG51/v6vKmX3YnmOmOjfgsClf5oZE47ejiGNYPI0iQA306IYSicYnqOme
	gLb+UIOlS3GLdsXkqVoOrIRgjWjq71RqOom1EGDcExOqZrbV4u+/t1YTvpJAdhDNYkYrPF5ZVn4
	zstkkr+dtBY69+pAdGUP9xoiTzLVKYb3Ll4RDdEL1lqoL6DDi6oEHXNM1mh3N3KR+MxZlOUSXbr
	U2Do/pzI7Y7ILdL+PgOHKm9XVQ7TCWcuPa9FE4W4iwtCeV5hJjdw1AY6+g==
X-Google-Smtp-Source: AGHT+IHmeGNT7Bo6qQEZlyUPUIC19AmmHg3p/vwnkUVwP0XEgpMjL9trCezeXrwVY1FOM6HEcbUrAA==
X-Received: by 2002:a17:903:27c4:b0:223:668d:eba9 with SMTP id d9443c01a7336-22368f60c09mr213344335ad.10.1741086828047;
        Tue, 04 Mar 2025 03:13:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb54esm93371845ad.99.2025.03.04.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:13:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 4 Mar 2025 03:13:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH] hwmon: Fix the missing of 'average' word in
 hwmon_power_attr_templates
Message-ID: <de6321dc-1015-4368-ac25-971bc781c210@roeck-us.net>
References: <20250304074640.2770353-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304074640.2770353-1-lihuisong@huawei.com>

On Tue, Mar 04, 2025 at 03:46:40PM +0800, Huisong Li wrote:
> The string "power%d_interval_max" and "power%d_interval_min" in the
> hwmon_power_attr_templates[] are corresponding to the sysfs interface name
> of hwmon_power_average_interval_max and hwmon_power_average_interval_min.
> But the 'average' word is missing in two strings. Fortunately, there is
> no driver to use it yet.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied.

Thanks,
Guenter

