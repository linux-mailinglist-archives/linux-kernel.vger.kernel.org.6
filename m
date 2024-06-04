Return-Path: <linux-kernel+bounces-201110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA078FB9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D49B23572
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82044149C51;
	Tue,  4 Jun 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqxCiX4R"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163D13D607;
	Tue,  4 Jun 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520272; cv=none; b=d2HA72vCtuKgWV+MBZAQbnl8LTFNdyLd3NU4aswpiSBgvVUK69M6vsl+/iWfsSauH/g+0i7TmP/REQ27yrI0Z6+oHsiO8Otf8FXdYLBuqAymAF1HODu6sl6o/PD7M3nJFxgXu5AEJyZYb4JE57J0egypiiN6LoufcGCAozvLUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520272; c=relaxed/simple;
	bh=Awzr5qzfrmmRzsEpJi3mNfPpydZiasmcYpDO8J9Mo4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwYzgC+1cN8MCewfjTDZDFyRg/Hpi5lc1IDNiO9J6pJcMpWBT502HfPfH7lhDrkFeFpSDXyEHjWaSYs66HrIix9vsZkTa6s0oczjbxsIQhbGEFIi8El+YlNC87CWCmTuiRC1SWaDxvNHgGd9EcDzOAcquGxwknXvOa8/zQEN8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqxCiX4R; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb01106015so194863839f.1;
        Tue, 04 Jun 2024 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717520270; x=1718125070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3rhsphMxNLAFdBX054OpQ7nOAeYOHeyOoUJEs+AJmc=;
        b=SqxCiX4RLEQFa7L22Un67I964hor5rn7mSMSv93XZczm0RUpiXbmJ7tbGxc1snwHsX
         jqwDJeAp2to/mu8Oc5ALwlAmeKxG8LGkXoCPdc1bEeyOC5sm09JaVkLmK20XcZGp6WTD
         /HoidD9DrENryY/znVXHUq6amG13SHgVnHPoUHdW+JvMv/+t0LDM+meRJk/SYJ7bFcMi
         SvquZgxYtqXzBSsdxUV6UQjD3E4ntBJytpDEpPHNQWz5vFImT4n+na7n3AQLPDgDW6mW
         rkIbB0kwxYPCjPTCHl2e35Z1M7iWqtG5p703lG2gOm5K1t0VJ4cTK5ypYdaHV7xvauOd
         SNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520270; x=1718125070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3rhsphMxNLAFdBX054OpQ7nOAeYOHeyOoUJEs+AJmc=;
        b=WrbzMT8M/oh9fkG4fYWXGtjmdsu/0rej7snO6oO8ywtDxwBchROmdqH/c6sfUX03E7
         Z3BBQp587hC1+EhXQ05r0N2Hf2jFlY+akD/QHoHmQdGpFaG6Q5Vdr4jmhD870/Iz3+wO
         p7pOIAcfIlYd/hl1nYun97p7dBl8zCfgEGCljhg64m+biDoQFSf7BcPzGPgzP1bH9dVE
         BYrrvjXYKr02w9NayGKPF0Vf1mmu80QjOHiZDo/c0mGMki29j2LhH7afKaNFd8E1IKgo
         +Z3pa6ylBsrGT19wBZmzeEMR/0v615AtJsGBBIDFAAq4TxwOEgVKOh2cRe9r3nneLhpt
         wRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWVPkSFjfguzmm4iwoVZcN3GjQMbvmQ7s5mvFxvkFSBqFDU6WiULVe6Io8bajErSfo3OUnJTAsbwpUsJUHIkmVYcU3ziBcRJPy6cMz/Po25lW+uKpCGxnMipKrd5ACTjSjda7p2HotnkrKBw4cX9s+uIUd0FwmFCeYjVnueXCj6gx/Pk0IE
X-Gm-Message-State: AOJu0Yzqzdx9KENwn+hJkiwjrhDzbly3Yg5wwvmvPT9SLKVYVfMeRjzb
	1qoQIhvSUanA3X/WDUVZWcxzR67BiY33XcJPT68iTEfDyO3ORQIA
X-Google-Smtp-Source: AGHT+IFPNVEPicX9BZCLLToRhnS+e14Z0ilxAploVr7MC+63wEfqFN6G9w1O8Gt7KcG5N6yE53A/mQ==
X-Received: by 2002:a05:6e02:1c0b:b0:374:a412:3d98 with SMTP id e9e14a558f8ab-374a412407cmr48703425ab.32.1717520270465;
        Tue, 04 Jun 2024 09:57:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6d31987e4acsm1381737a12.83.2024.06.04.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:57:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 4 Jun 2024 09:57:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Message-ID: <9b5b6034-6a2e-4bd6-a69e-d820bf195c64@roeck-us.net>
References: <20240604164348.542-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604164348.542-1-ansuelsmth@gmail.com>

On Tue, Jun 04, 2024 at 06:43:41PM +0200, Christian Marangi wrote:
> Convert g762 Documentation to yaml schema and port all the custom
> properties and info.
> 
> Add the vendor prefix to name to follow naming standard.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

