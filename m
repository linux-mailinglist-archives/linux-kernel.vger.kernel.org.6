Return-Path: <linux-kernel+bounces-263370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1F93D4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693D51C23779
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81310953;
	Fri, 26 Jul 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNs2edn1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10FC2FC;
	Fri, 26 Jul 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003667; cv=none; b=moff5SM6oD5P3VK1rKk8z1mjWXshusEfMkUF2sev4N33suV1icPqOiwOit/3EY8blAX1s64mBlwhnnu2kOOrjyYVBh20T1vpw6vxYq2hguie3RpcNgSJRem/MlAvkD6PW+v+9pKJo1RDifagvq6xNBz1vFtdAeHHHQ9gxuhyXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003667; c=relaxed/simple;
	bh=DNwk3I1f/fSk4di5p2HsLWzCelPOwoh9KSpwfjtRbio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmp3K0PpzMcLimCOE4TJy4T1M83C3QMbOMl9n9SSvWOnnyG7pkVdxk+1pXtBW64guo/LTo8p67w0VD8NC6uiLzUxqXDFox4Penayo8T+rqdfLacnTgRFQhfihSdu9TDWc4ll0i4dBvOF8S4+3BjVlxSitqBlIXYiCnVeD81U4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNs2edn1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d19d768c2so881031b3a.3;
        Fri, 26 Jul 2024 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722003665; x=1722608465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUNh+TkG6bDRDZgn3CoW/HOQcsGVtwoCqNd8S8gTyyQ=;
        b=gNs2edn1HzSM2kSq14AuHJY0osIOQ9jm2P1SE3jGcte4+yiHXaIM4lusbnDrg6PbEV
         Tk0umdBurXfPmrPGa3zJygigd0X+wRWVLkTFJNSLBU0gwmhqq14t4LCbxJPd9tcOoQxN
         RmSVpZKYgUjfDF/DxLDo+N8cXEAy6dNZUvvn5VLxMaGNSRqOr34aorsiwP9P5llmUSZk
         w9n2hxJUpe31VPhp7rh/LjpL8RMiFSu18CBAwcXuH5kLNPSEMhLVtgrxnpqgagileE4W
         ntuPkQhllDNG/u4iK+za/p8KEmgIdLauRsONGoPC6WKjKxd3wDRe0ad6ug8swmHuat8+
         9ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003665; x=1722608465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUNh+TkG6bDRDZgn3CoW/HOQcsGVtwoCqNd8S8gTyyQ=;
        b=MB1qUmbgjEyzBGIf4uT+HmsAU1ByXb3A5+rm1APoanckNXVshJ0OjzX5yN4x9d5qsS
         hh5KlRLv9opOtl7pslcdjxDnAC5CZMOiWSjxFwx4eAwFdfmWPh9nuqqOXXSKWQUj4e6P
         f+U4TV/MXgxMpzgjEKBn0WL8S1AcBJpggaTussDnnhqvEBQ6hfOebZXDJP2yxB1GtLTw
         zQAYV2STsLKU09+3zMgvJFL1l1GK6c1ny9Y/yvdu/x1wqD9kYCTSFyV5Tg9FrUDk2G4s
         ELsV/e0S3M489+ILaulCZlF5HBO7F3LDG6udAGuKRNk/awbsctq+ba86cdxqV/sX7ajG
         rRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjn6o0ZfBchGajNdU6LySUd4lsSHPShicMql4YwU4MuVoLTo7yl3Dk2mVphpqtX8ae9hHOeM5zvcCIlTWpNXnf9upwN4cdWLOfe8QBdUB/nNybKOcT2rxOfnEega+LRVtjk82fldLYkEk8GZbAjkC+VX+wuoyHZCjA7UuxoEz8MY95Vss=
X-Gm-Message-State: AOJu0Yy0Y1C/j08H0Jd2b2tc3nlek/hka4XGNHEtHW/E4WKzdOY80rh2
	CotFOSaD1PD+x2uHOjg6lCRGSL2jsdpbFd2x9S/N4xbFDppUdrug
X-Google-Smtp-Source: AGHT+IEw4oTFjdB/5J9Pj1YPyu96hZlE919BJH6oLA8KA0M0dqho43sCy9mA1k8SmpBYDRufkes6Gg==
X-Received: by 2002:a17:90b:1bcc:b0:2c2:5f25:5490 with SMTP id 98e67ed59e1d1-2cf2eb20008mr5937036a91.34.1722003665421;
        Fri, 26 Jul 2024 07:21:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73b32cbsm5499610a91.17.2024.07.26.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:21:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Jul 2024 07:21:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] hwmon: document: fix typo in oxp-sensors
Message-ID: <fca04d5b-5454-4642-aa59-06162f8d9262@roeck-us.net>
References: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com>

On Fri, Jul 26, 2024 at 09:21:14AM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> RMP -> RPM

The subject should have been something like
	hwmon: (oxp-sensors) Fix typo in documentation

Never mind, I fixed that up.

Applied.

Thanks,
Guenter

> ---
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  Documentation/hwmon/oxp-sensors.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ---
> base-commit: 73f3c33036904bada1b9b6476a883b1a966440cc
> change-id: 20240726-typo-616bb7db0f68
> 
> Best regards,
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 55b1ef61625e..50618f064379 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -52,7 +52,7 @@ Sysfs entries
>  The following attributes are supported:
>  
>  fan1_input
> -  Read Only. Reads current fan RMP.
> +  Read Only. Reads current fan RPM.
>  
>  pwm1_enable
>    Read Write. Enable manual fan control. Write "1" to set to manual, write "0"

