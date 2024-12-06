Return-Path: <linux-kernel+bounces-435444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1A9E77C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDEF2839D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F71FFC4C;
	Fri,  6 Dec 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OfuALeJw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1E22068F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507959; cv=none; b=anVY4i4W/AYV1tTiV3GB4AGtwJ4Oy5qZ5hR8EEUpv2pLP51Uptboei/QgL9/nZvT8x7KukmPndXt32Xgdy536Eoiq02IVFVLWdZYYXjCXJD3OlIzFxmtVhItgc8UKqxAsMRpZ5HcZ+j4UpqAvPPET/g8+2HC7bHpksRXYvsOPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507959; c=relaxed/simple;
	bh=C7/IjrZPAe7jrd6+Hvq7qkkD7bICDlJFHdbE7CmOEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmFmi11OQWoZ1NTgtibLBmtKlQQ+aJJnOWXsbLshMjlciB439szC/UxDetAPw0gci5M++lm2+noXxUuyCaMFD3h+PDkSHLV2OOrQgSK8x84BtZzxQs1mgwtYK5hq1GsUStLLYUY5/F2vZULWMfQQr4CCui9DEMGWPTbzuj7bSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OfuALeJw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215513ea198so28417845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733507956; x=1734112756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXWTnS4ACRG69KERwtrtjSEjtFzKArian+QB5LBEOK0=;
        b=OfuALeJwEBFahJQqD6+JikVEowM5iKse4P5UTho6ywR5DQhoR6FYDDvFCcvSsWxB4+
         Etvt39nLzLVrsoEU7p+jCZn48LJB8Q7b3ctVV2Z2d/br4bz6DaofuLC28MZRr0hOrLlW
         Q5md3+NdEhM/nmdEHtGj4YR3PNLpHSjaJecdcswCzb+t0CErbqj4O7mHEK+FH72IwO0v
         BXbqzR6Uf9HvxymXMAniW7/16xb+YZdGgegV31J6cO0Qx6Re143ZgpJY9Z/aTu/oinkV
         wPAP99bkEYhcCIqHw9FI4bZsEsq9FtbMrdH1zQ64CALN4mYPERu0AHOfYUnJU8aqdEYX
         oe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507956; x=1734112756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWTnS4ACRG69KERwtrtjSEjtFzKArian+QB5LBEOK0=;
        b=LuagEBP75PQ150g3QTxz1cJrtAUBOvNm41rlYYR9wtntn8djmNnyAnQ1hSHZqT1e90
         Ud8kZp2CdW8VKqWDb+f8Wqkkjr5ir9zll8he2kiTU3NYTROUBWhKJDauUKtDF9Q60xxw
         0bfYQTOsWpqsPJS+ut+l1jGG6KqVxHekgLYAXF70N+/EwBCIAYzSODFIluev56sr0hzG
         xZL2lvXMeBE/k96e+HNdL5Ma+PQeUVwfoGMFoSMLx2Enu3m8X6nVg3ebjOilqoI9CbK+
         tmRguD1W95haq45qJgJ7ifAsYaSn5apANvsm0Qb2sOaGrPfWi7v9di8+QuOdmTWhyiXL
         dpDw==
X-Forwarded-Encrypted: i=1; AJvYcCX7xqFsRjLV444rFM1zAjet/1KNNfE1aqD/tnV2Pp6gztQydxpk0dE6hmf1dRO9EslHEPjxt6jfflfCDxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuE994eNjaXbDTeO3t+wufpHdTloaK4mvXdFV9g+fOTHyXB3C8
	MJkL/2gW40c4vhOsoIYoKVcZqC5xhLn1J9fo4yZaWTEU16svc2urdiwmUXmo9MyaWBhg8wCwTZP
	Y
X-Gm-Gg: ASbGncvt0R7i+2DfYTgVwYjXCzM6l6BZlE2bkbFxkDow6xVHp+lbexGxocneINOwM9x
	BRXXPOClywP8xHhvZE1VplCijWpnuDO8zSpV2uhyhIB67NiRH2UIlCcMTnqjxDpU51uv+hvutaT
	jixZcglb0iTd/f19R9FsSNm+6h4U1tFAvi0AW9J6IUS+VRNRhIRxe0A687qquLg6t62H/Bg6bfx
	VYBbIigBx07SrWuCjuXGKbZM/lvVtlXASYymRbsttcX+Q==
X-Google-Smtp-Source: AGHT+IE8qx0uEW+Lby99GPzuztrI/Tze8sHzsHxtrWCEM5K3xCHJB/gtU8TFHEdMyknysnx83WZqKQ==
X-Received: by 2002:a17:903:2b08:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21611afca0amr56824085ad.20.1733507956637;
        Fri, 06 Dec 2024 09:59:16 -0800 (PST)
Received: from ghost ([2600:1010:b0ba:197a:c0e9:4a0e:e502:edf9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efc906sm31536465ad.166.2024.12.06.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:59:16 -0800 (PST)
Date: Fri, 6 Dec 2024 09:59:13 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
Message-ID: <Z1M7cUPhV6D6yXlX@ghost>
References: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122073725.1531483-1-lizhijian@fujitsu.com>

On Fri, Nov 22, 2024 at 03:37:25PM +0800, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>      filesystems/statmount/statmount_test_ns
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>   sorted the ignored files
> V2:
>    split as a separate patch from a small one [0]
>    [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
> index 82a4846cbc4b..973363ad66a2 100644
> --- a/tools/testing/selftests/filesystems/statmount/.gitignore
> +++ b/tools/testing/selftests/filesystems/statmount/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +statmount_test_ns

Thank you! This is still an issue in 6.13-rc1.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

>  /*_test
> -- 
> 2.44.0
> 
> 

