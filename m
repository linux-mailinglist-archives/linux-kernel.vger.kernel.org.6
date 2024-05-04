Return-Path: <linux-kernel+bounces-168529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBC8BB9B0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437C52830F2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDE1BA42;
	Sat,  4 May 2024 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izxKtOKL"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327184C79
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714806883; cv=none; b=YlzgtLlTMKFvxMkWIaQ4qJIxPP/Ulb+lQKODy9AWIyjaJ9DoHvkzM8s1FKdH/8ioLc6JZ7+Q7YyJOsslWGKcqiA/IIkuAxbQLnYm09XmvBSbosLpwlWaWc8G5bRK4Sa6XkxIUsrF1Me21tuxA/ZlJfIOcRm1relziiVkf0cVSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714806883; c=relaxed/simple;
	bh=JPi5SPuiU0SL02Qqqpcf1D/xtRrzm+mxaCVNvt4+a+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpwDAWS+eAkWx0v2Yl3z7n6p4JRpTg3URi3i5AiL58kwn4rdlNsJpCKMKJsFc9+hNSAyFfj4gajpKe4ZVIyHRiWBn1O5Uq3mcx7hBDmbNR8C3D5hvvqxmrrUYhfxfev3VeJWdpeXH5f4rXMV3ctDptrgGgQxslAlFEtgVJ7XkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=izxKtOKL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b2b42b5126so369938a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714806881; x=1715411681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4N1i5Pm2LxhMxIRBzRCWAdKMXxb3hPvU+8V8CPs4HE=;
        b=izxKtOKLOYYO40Npj8wt59QNYqm6xkHahwaDxdmIlmScIGuQxq/y1xmL8ZC7nv78IN
         WftIbMa1U1XC5ytIUldx+lyvjTRrRW6wp4/G0+1tdh2zW5qgc5bx0QMZhxZjtgKYwpBr
         +PfKt1UaJAW2bHZ9HoRJQuDjZC5oOY0B6Qzz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714806881; x=1715411681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4N1i5Pm2LxhMxIRBzRCWAdKMXxb3hPvU+8V8CPs4HE=;
        b=qrQA0HQv7liai8v/KIvGRImsl9CtgvOZmAnAyWvHDksCbYPtL5dIvZ25HDfo7jDU4X
         EIqGtBvmHeM5JPtbD/bkg7nC9wnsyBx99kbSFHl9ZI1EyOuFf3iPECDeTbupQW9A45HG
         cGg1f8pXUYMaMN/q76mxnrnAdhokipG6aLF0GWaRoYKW7AdMW2qvdhQ5skGpVQ90RJZA
         Xp04VkBKhGy+04TVbO5R1VHNddCKQt791LWM3DyTp4MMcqF69NloP16/Be29KyhqgZR6
         wzZ3ZpkyXcoRjLfNEz8C7IH5GWeu+ycUJJgDu8+9kA/fpmrrV94OgMvBHPIEfuIhJHZT
         UX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX01bRBqZRgWXyhwSgvkrW3p+ZDTezdpvgeJxHDLpDI3NlpYhKSDTaA/QM4m5cTG+OZwYRudDqWb4QltYM00ZbFq7h5Vs7jzRI5FIV6
X-Gm-Message-State: AOJu0YxDF8xxeXjVTLbhS7eAFHlHq1AsAz3tJoYZAvwtlu35+2L5znNv
	ueYFf6nrdMQTzlhj3MJgYNFjNWWW2h9wUbd1J65m2huOvCipgEUSqEOF6etE/SQxBgOPj8IskNw
	=
X-Google-Smtp-Source: AGHT+IFn79avCXCi7TK4D20lbbR6FREI9JMpMXrAyAVwamxmEgAFymvNjriz4FhRmJ0iOLvNa3EtUQ==
X-Received: by 2002:a05:6a20:7f84:b0:1a9:c28e:bc17 with SMTP id d4-20020a056a207f8400b001a9c28ebc17mr5550146pzj.45.1714806861314;
        Sat, 04 May 2024 00:14:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a616:7211:d0ce:9ad9])
        by smtp.gmail.com with ESMTPSA id b185-20020a6334c2000000b0061f42afa8d0sm1391585pga.6.2024.05.04.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 00:14:20 -0700 (PDT)
Date: Sat, 4 May 2024 16:14:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240504071416.GH14947@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405041440.UTBQZAaf-lkp@intel.com>

On (24/05/04 14:54), kernel test robot wrote:
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/block/zram/zcomp.c:214:2: error: call to '__compiletime_assert_285' declared with 'error' attribute: BUILD_BUG_ON failed: ARRAY_SIZE(backends) <= 1
>      214 |         BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
>          |         ^

So this is what that BUILD_BUG_ON() is supposed to catch. You don't
have any backends selected in your .config:

# CONFIG_ZRAM_BACKEND_LZO is not set
# CONFIG_ZRAM_BACKEND_LZ4 is not set
# CONFIG_ZRAM_BACKEND_LZ4HC is not set
# CONFIG_ZRAM_BACKEND_ZSTD is not set
# CONFIG_ZRAM_BACKEND_DEFLATE is not set
CONFIG_ZRAM_DEF_COMP="unset-value"

Which is invalid configuration because it means that zram has no
compression enabled.

