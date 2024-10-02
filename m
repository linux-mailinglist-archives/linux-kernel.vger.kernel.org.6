Return-Path: <linux-kernel+bounces-347625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E298D818
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458101C22D88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410E1D0BB2;
	Wed,  2 Oct 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkJZftdY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240761D0977;
	Wed,  2 Oct 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877357; cv=none; b=m5UAHGaJ0Z4+THba3vg4tq+BNmsaLcx+SjpvyxzLrKe6WxjG67ikYhq/UNH4c6G1Qf2HIHREtbQ68s/m3D72/h1I+8/nupMPPYRPKgZaUxja3ODRlRVughtheTx35ovelAOApfNyCOhxt0VhklAFR7RsXa5pxXhDvMi1jW/ZWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877357; c=relaxed/simple;
	bh=zx/O/05IKwA2MimNi/PFcCEvXS5nsh/mCtOkSIotGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APlt28edLoBg5mgZKAuvX/3eACXZFeQ6cA81tbfeEBfbeGteTwrbeo8gyG9spqbiU4dy2QgcmAmZ1JfP507psHBYfjRV5uFkrZzwuKXfcTw5FJNhee+qzJsiHer1p3JtYVRAfQmCIWMqNYm8LBgeVRT5jVpZRf06MWS5GMRjI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkJZftdY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b95359440so27551655ad.0;
        Wed, 02 Oct 2024 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877355; x=1728482155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Okmj3JLJUs+5vHu9gYMhbXC25kwp5zEus8iw9+6aKig=;
        b=jkJZftdYrnNhyw5v9dmL76dQpFvrBDlx9T9I/a1vsG5XrdDI+sMaCSWqxOqY/iX5EK
         XfjdSTsCObU2NssDMoWH72/8B5jnebbxIkMobUFsq+PNCrtqyE5SnGLwbg0qb8Np2nch
         S4osffcFOO6Mjtb4DzAdmChc7PSvKXbShNV8pj4i0KDgRp6+UuwuCXBys886sDxyHweN
         MtjNtnCb43xnrVSvwG5tRu5AUQbSvz1Ee5UscoVkc5eZT9dpUdX3iF9acFk7kZgKVWuF
         59hu1rxpM9Kw/a4bLonUBSbE6/aPZ74g0PbSB+Z7v1nEB873zdQ5BYfOZfnWIlol/DuE
         bYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877355; x=1728482155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Okmj3JLJUs+5vHu9gYMhbXC25kwp5zEus8iw9+6aKig=;
        b=hTLYyewYcHoHv38ungRlke32uhMdpJ9JdEhZGg9f6QYXP8OH2c3EaJP8piTMqlkdCn
         3UJsZx51tFHXbrHsF/w0JHLSPKOxhw00k2MFEBeddn4DLbc4IDJ8z+stOkbmRkNNj9kJ
         UUgwWLIaIrufqIacTbY4Pm7Ml2blYyVR92bnkJ9RoU1NDNALGELNSh1Pkrt4I2OIQP3n
         /1agj31g02tfJafoxcm1aE9lphrfzU9XbP7IleXKh4w+LmEmTrteA5PiizsRELf0Bd/2
         byYya+3GmhvqmX85CO8sXdARD4lZASfct04XH7aQwTjYP8maMQfFg7QjH52/+OlVUiNL
         V3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/1P176dm8bKhAqGc00HopjYMGcpfmwlICFQqaQ1MmZykuSL7BUUSqmz5jQuCzZ0dozeth3SzhhXLsbQ==@vger.kernel.org, AJvYcCVzNpOeI5Tq+EqZCXCrVcqr6CL1qg5BnXD1nhRStgikW+gnX6DsJOEC8HDomQ1dLCn7C3SqApUH+qRm+/z6@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtuFGjN3ojGVckgmp4+hZecoyq48XV3+SVpzkbe4+dtsJO6md
	MJI0D2B4C/6D4q+W70TwR4CLH4G3nMNKjfajQ3UaNnHbnPAYouyA
X-Google-Smtp-Source: AGHT+IFguJDptTZVWRYNzE3ZITHaM8Lklq9O3m7lEerEvkFQ6Ywci/XIe0tKwtpNRdjVEqB6FU6xDQ==
X-Received: by 2002:a05:6a20:c909:b0:1cf:4197:6697 with SMTP id adf61e73a8af0-1d5db2324b1mr4889278637.23.1727877355340;
        Wed, 02 Oct 2024 06:55:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e63a86sm84298955ad.277.2024.10.02.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:55:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:55:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon: (adm9240) Add missing dependency on REGMAP_I2C
Message-ID: <fb23f8a8-8a11-4c5e-990b-1fd09c9a4c6f@roeck-us.net>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
 <20241002-hwmon-select-regmap-v1-1-548d03268934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-hwmon-select-regmap-v1-1-548d03268934@gmail.com>

On Wed, Oct 02, 2024 at 03:08:08AM +0200, Javier Carrasco wrote:
> This driver requires REGMAP_I2C to be selected in order to get access to
> regmap_config and devm_regmap_init_i2c. Add the missing dependency.
> 
> Fixes: df885d912f67 ("hwmon: (adm9240) Convert to regmap")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

