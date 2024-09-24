Return-Path: <linux-kernel+bounces-336909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB7A98426C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9461F210EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8315666C;
	Tue, 24 Sep 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JPF3ZiNq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA515382E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170895; cv=none; b=YodFHU+ihMBv5Y928ErbxKLyj01efL5Pcf2TpIpycRqOW5a5yW1mViE3EZ/fdJhE+pvIyAblCvJWqoUgU4n7IfdoR9TeRJ7Rx5L2ba4zb78IdH0F4d/iq1Qj93Ta4nM0isbgR7EeiuXk32UGBQz9LIgj/v4v0A8/Ld5gQ81kFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170895; c=relaxed/simple;
	bh=GedxcBKhWt2Z7U5u72w9uG3TtkGrtcXZiRSM7hushuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKGOFFCktvOnle/1ZbgQIb01KyGPs/TuCRS3PkZlFq/ta3oUOL7np1W3M4iRmefSuQafTJo3ctsOcVGBSZmAENmtrhWoleN0yDu9woRk8yBIYrJznnk168pHXEkYsMc2C2CVUXFx3Cnd9sZfIwwt6llrrFY4Yb1FBc9PCrNeyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=JPF3ZiNq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c413cf5de5so7076126a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727170892; x=1727775692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OJtpv/zrtvpIdOh+Bobca5Nt5qYNBhXmHeFh7kw0Rs=;
        b=JPF3ZiNqsVfBavdziht4Jnt8HJfHSzqsG3PyjwR0U8Amg6sizVim02ZR0dn791y7r8
         s8KutKCWjIKlBXLhXLjlYpYlsVUZdEGBpp6eRe7AwlEP4OzXvs7OorRXaH5WjcHadoXv
         SEI3VvxPnbp8+CHI0XKhrOLf9utP7W2deVx2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170892; x=1727775692;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OJtpv/zrtvpIdOh+Bobca5Nt5qYNBhXmHeFh7kw0Rs=;
        b=jsYtKaSBXT+4UkmyAftOD/d8UEg8w15CTWcxcxm+nylHlSlzMZPYB5KkA66RgEAUQD
         c6ELK24LGftAAGC/SQ3hHX/pteYqHTqA76gUQfKQhUjwetFlsN1BQaNkJqhXoaMLYqUq
         TS8o7nLVw8XtgZZpu5wUfqvquIb7sdcJZNrhH+tEEUTmePWEEiWVgJ3qh1I9eMyNO/6T
         LHSfRolMMMNxOVbafNyhUvwMbDjNM7jimYd9MlxiS1wrvg1K/2VoN6fDj6JI/sRDJUhd
         Y5Eu8rGd00B64wpEPeRq6XcD2TSqgHuF5dW1KQEUDJEn3riwHzw0UdP1GMX0gJcMt+jL
         FK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDGdnbEs8jmUzQOFpec0oSu517jKNQc6tcJ6uXbxfKMVCNLR3tLuVJW08YoJiDkjTTahGisUy431UAt6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/UKB2Dqk8R45O9J9bMVlNEwN64Gu8doL3sTD7j7b1ZoV9W3g
	zYQAGHadfieCoteKfG9438XTy/k8dIQ8U0y02GetmWrxWjVTd3QshE8LtvynGWg=
X-Google-Smtp-Source: AGHT+IHRH++vS20RPDRF9y4U3FUyH+S9hoiJ/DWkV+3dx9TvRm0HAjfZboRDxOmpoR2n/g0yJgDb+w==
X-Received: by 2002:a17:907:d3ce:b0:a8d:60e2:3972 with SMTP id a640c23a62f3a-a90d4ffdd3bmr1319924666b.23.1727170892348;
        Tue, 24 Sep 2024 02:41:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134a97sm62805766b.207.2024.09.24.02.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:41:32 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:41:30 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] accel/ivpu: Fix a typo
Message-ID: <ZvKJSna2fkJh-AVY@phenom.ffwll.local>
Mail-Followup-To: Andrew Kreimer <algonell@gmail.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
References: <20240909135655.45938-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909135655.45938-1-algonell@gmail.com>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Mon, Sep 09, 2024 at 04:56:38PM +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Applied to drm-misc-next, thanks.
-Sima

> ---
>  drivers/accel/ivpu/vpu_boot_api.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
> index 82954b91b748..d474bc7b15c0 100644
> --- a/drivers/accel/ivpu/vpu_boot_api.h
> +++ b/drivers/accel/ivpu/vpu_boot_api.h
> @@ -8,7 +8,7 @@
>  
>  /*
>   * =========== FW API version information beginning ================
> - *  The bellow values will be used to construct the version info this way:
> + *  The below values will be used to construct the version info this way:
>   *  fw_bin_header->api_version[VPU_BOOT_API_VER_ID] = (VPU_BOOT_API_VER_MAJOR << 16) |
>   *  VPU_BOOT_API_VER_MINOR;
>   *  VPU_BOOT_API_VER_PATCH will be ignored. KMD and compatibility is not affected if this changes
> -- 
> 2.46.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

