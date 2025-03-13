Return-Path: <linux-kernel+bounces-559759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04BA5F92F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C372C3B7F83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0D241C8B;
	Thu, 13 Mar 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SmhlXohl"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF7268C5A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878165; cv=none; b=ZkIP60S7Y8Y5OIrJUFhGcWaakM8XjhnZ5vJ6ZADNvoBhQWIkyg75NozhY7nAWtxdZl6HyJ7YlYR8mh40PjWUg6qzdhEV8V5CHALavBbujWtDOLxKv9nJFGW9m697/oXRrZctS7pNz/4WAFrvKHZ97FSXLBXbSl4hBpRGiQdW+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878165; c=relaxed/simple;
	bh=7zDs/4jK42T9rjEWm6oQy/xsWRIMK8LilWON+YAA9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMC31AGKt9O+hth/aTg8TZVkRUgtXVawSpHavB5MBr6pGtXIvZfrZoF9iTkG5wIny8ElMDeL2h7CFDgXD8odlG/MHc887a4POqTTkNmxeP2QX3KZ6rx1KYnh1YPdSYvPsfKTC4/5j55LsmlCQ7oQOFXdNaMnbYMpktd+5fePBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SmhlXohl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47691d82bfbso20942931cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741878162; x=1742482962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=SmhlXohlhOkw1inTkuCmudxJb2FtoXioVgM0AuPDIpjTaw4nhQDVMH33mTYf0ayYh3
         NlVUxUQpMSsWyvFZ4d6wJwbdCxwDNqNuoIXnLomTJgKbBJsxXtDDtwqZlyxtUYtZYp7T
         XUDnY2u2/GQdNS4oVr2MB5MGrsbEwlmBW7yiVBqcu7O1dEhmzbTio+MZD7FBpd+dbNN9
         GW+Tgn+xricC2tjHWeXkWOvChI6dSx7hera8rrWEkFlXxZYh9mgK29Ue/hHDNaNBzZOt
         d4SCQKtNU82r0c0NXdkmMNJFuIokn2w4a+8KaJc+WUSbPtqMP729pE4a0arqDEF4glJu
         ubmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878162; x=1742482962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=fP/mGuivGnQtt8ULPeGbJbm+FqjWgxHsfiiHpmkirTj6W8XlMRbG8UgK6sZYsGivba
         ulZL4+UxC68XAdS/Rqr/7HZSY8tWIHp9sXUzmrgN57lJykVU1Sc89Pl5tSa/9b+D36I2
         DJ0QygldZit8oV0pgwnim+1WmX8/HaFwx1FBm65StsgaHgF9Kr/hJmeP+5ceWPah7iBg
         /u5nzoKD6BcisbeFal2mT6u0BCjD2N62o4IhQo80vXFir19/JCbzJqJgf+RC7tJ8noIl
         lOjGgg3h9bb9stB2ByXl+fa+vu0wg9KQgTZMCoFQt5mAqbW9zkrIjvGEXNrKl8/r38/D
         Mncw==
X-Forwarded-Encrypted: i=1; AJvYcCULHi30EGPwshnKcyndQ7XJlL7lc9ArMmrdMWJUJ4Q2oujYZEXMre6QosoaLlKUHyjFT8Tev5IxzjofFyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsKyqoryDVy5xOYDKQZQZyNVOfvzmALNOWSR6xi3vvugZfRTz
	GdmAW+4e8ROSkMao0DLr+vDa0ZOdy30jTCsPWTbpTr8uTDkzORbqYy8TsJRpCHk=
X-Gm-Gg: ASbGncs8vKM81r913NpHRJh6xqT589euyTu+9HOTXrepfmio2HJVmx6T+5cfwAHnBHK
	K5sfUCRXglBkcm3C2FvHRwnhJsnoepLkMK6BK2SVqaVaMdv32b0C02sAZ5tBfLhLI+oO0xmY+YU
	iFXu5DjK/AjBM2qKIKDW820ttIZx2pMReZa+tBlLYTvxhNYtRk0ELdulyAFrvVC4VD3GsVljUjW
	Zlpa7dd68wsa85zyXS3NSOXDXrsaAsjbCUQ98n7ssi6dRSgMNOwycztbjquRCLWv1dBseKdzyNF
	ExN9TG3Cv3BDZOY6DTotFTOpakfMITUqJ6z8DeSUXx2da7yGN06cWZMmAsJ7x3SDavwz/q/IvP0
	OJn6gUWkWM+ycozS1qeaKQ30agY3ZWcriHT8EvA==
X-Google-Smtp-Source: AGHT+IFAMWILyZ8bMRGv7bdKKe5rM96j+5H6aHjq4gkCifNGEy5AffkMBaHGkUHELx5174kUe35U8A==
X-Received: by 2002:a05:6214:518f:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eae78613admr673006d6.0.1741878161817;
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24d025sm10481686d6.51.2025.03.13.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:02:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>

On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	if (srat_disabled()) {
> +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> +		return -EINVAL;
> +	}
> +

I thought the srat was optional regardless of the presence of a CFMWS.
Is this not the case?

~Gregory

