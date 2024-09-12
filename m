Return-Path: <linux-kernel+bounces-327291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D15977381
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CE4B2176A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624F1B9853;
	Thu, 12 Sep 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cutMD+02"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277A548E0;
	Thu, 12 Sep 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175868; cv=none; b=n3vt9TJ9kkTWF8G+lLZcV9wSX5rdw71kG1M9zjcTqCJ5pE7yd6HL8zm77sLC87+vwmx1c5LdPKb1RSkmRDqlf1GxLy1ZjV0zSVMbNGbe+5mLEO3GUgtNGHQPPixXyHWDhv5jM92Tescwk172bDw64vBhyyO83GidcP00SJC7Q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175868; c=relaxed/simple;
	bh=gZWNDE4UdCE0UdmMR0zKoXdwa7nrr07TzGQ71siE410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsctHmEMKSTaEj0dv87VbYWRrIX3KRPzXll+x8/OPSpmVqklMMqM1UdSNotTmQv0q1mVbZVsz1i4rH6AA7VskxQ6rF/Wa2I6sswNWe6qfblpLwFreGVDt32R8UfSIv/MRkoJZHbbfrGrBlw0Qil+r1/LvseDyCuuyd06LehMUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cutMD+02; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2055136b612so19568665ad.0;
        Thu, 12 Sep 2024 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175865; x=1726780665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCcpbDG2pXlWL7N2ScI52jDb3w6apDJe4uAGoy/8sh8=;
        b=cutMD+02Z5eJ3oSRTe82DwioJ0o35nvSHl2lh1t8TfALJclQD8ZQ9Og4qoVj4W8Vix
         W617kBRmGZAuo/MtuxZuej62T7/B4kvUBB5OlikUzk9y9ZpAAzwwDQg/nRRzRfkh30a4
         cpLYEB83ohknyCrLOtBFkY/UWs52jWJfLFGb9NkJSAkMZVB/ANbSa8lDhsKxmmkCBi3M
         UpEID0nzGNOKGLEwXDdsV8NZXc/SeEdSeyOPv5VEim2FcSZW9IRT1yq84g5p1Z1jXdK5
         WLaK/I0P9JqC60g14ZRNOmBjleCIywq5Dvyxo6kJ0n0I70HYWB5++90flw56PbNqcTZ+
         lkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175865; x=1726780665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCcpbDG2pXlWL7N2ScI52jDb3w6apDJe4uAGoy/8sh8=;
        b=xJIQ5hO8STORou5MtONmV5gWmBQOY71YMvdofqyatKviqjZwwgXvSGuJ68Ure9ZU2x
         v4vUjSfKxssG3m5eFMTnLjVsBaXc/GRxytmuZpDuTxUwgOoUVHRrnpGquwjezODX2uFA
         vulTnivd6DkSrOlzTJOARfrq+C8K0UlG82wLN3FHyFiP4/8Ewfcs+PCTtfwmuoNmaD9N
         BNqVdWTS+mFK0igShREsGe5Vy2C8bFDflUfSx4iwQQ9azvsxVVD89ACCafqyxJJ/7hvD
         JYJAY3Uv8jA9WdJHilieySm88WnHZjP5kFKlegpxLPfvT+W0ZzZK2H4eL8Idar9Kv1WB
         DJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2C1dbOTX/RaKcP6ao0tcW1/c0UnIjDHv85KRJTk+eiPb9ZFMyG0+wNO4XDKa0cSql9CW2+xH/AF4zji0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQetm/5cErVDnk01SmJsz4s0LrPqzCnSfamhPDDuPLQqeOeHi
	oQzb4BbKNyTmT6Cza5dL0uodD/Y0uUZ1yO+tBhd/hvK7Hxb9oeMUD820Ow==
X-Google-Smtp-Source: AGHT+IEhBa1zNEvuSpKN0xwf+4TJa8Rd975bNw2dHYqIzXAlFHn330jM9y+vUpbDjz0pXweXE9MnIw==
X-Received: by 2002:a17:903:2b04:b0:203:a22f:6b09 with SMTP id d9443c01a7336-2076e334c05mr66647675ad.13.1726175865566;
        Thu, 12 Sep 2024 14:17:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe918bsm18111515ad.184.2024.09.12.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:17:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Sep 2024 14:17:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (sht21) Use %*ph to print small buffer
Message-ID: <b6411703-b9cd-4127-8681-2e5e77024af6@roeck-us.net>
References: <20240911194627.2885506-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911194627.2885506-1-andriy.shevchenko@linux.intel.com>

On Wed, Sep 11, 2024 at 10:46:27PM +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

