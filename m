Return-Path: <linux-kernel+bounces-313432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983A96A56B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431C51F252F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202B18E035;
	Tue,  3 Sep 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgQRCcO/"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16B1885BC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384626; cv=none; b=SUyvKT0dZhekLr/49UVTWw5VUZ+t9KZAE8gYM+L2XHM4b276RZWu+yGWVqe3V8KMIPiAugiFEQfoowiZzreZPR4LE5zrtZpvk7CZm9/hdKgK29PvH/0brB9+li9UQGjdNczHqWdMrOBIZLkYjffGgf11sfRJ9ppTNviZ8nSEGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384626; c=relaxed/simple;
	bh=U7OgVxi/pHtRieXBne3ptoBmNWxXdsMgD85e7uHkkwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG1CLnpVsB1V+E1YXBGyUTA5IsqZn7vcKkYQuaHqPwl6JpJfkZN/vaYRWrm1NYsjKyZPnr9Me5U78Jk6++jD0fcIC1uCocBW+rxgFLevo+xxaIgNT8OdKA32WouMVFoJe1NDB15Uk5ol0gcNRfhOklGJ8aDIM7jBw27yh1m6WXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgQRCcO/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so2803940a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384624; x=1725989424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xq08cW6/BlT4ZW8Fc9W5vNoCU0ZXbSqCDwV0Nd5Dp90=;
        b=FgQRCcO/c5xeKDB3H60hgOnnAdoOHpfWB34xmYcNqS5WHBEsMu1Lh0tf1pAtt1ghm5
         M57n5MFbHGduUdFQnoKC1eMBuXym8+BgkdmMfHpsC63g2Y8FEaVdXWG8zKbjYFPKa7/N
         RxXdsDnJxbQj7yyxnERfnfeUtyru8sZO+hZFV6pGa1qqw/+9jCwLAuA1/IGGlsv+UbzB
         Id3cIBTxDn5aaY4Kea+/uPutYRvO+IZy1CozWuZCcghKny0OTQN9YGf0SUnmiaB/TJV0
         pk6omK1AtFh+5RjV1ebFBg4IgyFOcxIOKW27sIJTd+3dEuAutQxI26kOH3UzkjhBoFqU
         GMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384624; x=1725989424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq08cW6/BlT4ZW8Fc9W5vNoCU0ZXbSqCDwV0Nd5Dp90=;
        b=HV5rIrGf87bNsMbA7V4k2gaB8wyv3rzxNO+GE+uGH2mGay/tIB3hLHoKJ1sDt1cpzi
         uXZP3CwIim6YhDzXtI81vGV3Xl/HlCBdcZdBKJgCJsVY2gQdruY+NLMHmwj00+R0o1ue
         /xGLQt9wXH+/svXXrkaTZ9wS9wox0/+EFyHo9UcaB2+QlOX4UAO4tQav8VUevxUDdJ6P
         AJr3s3/1CvfnUfWe6QnjXPWI9waNPelSk71Tu+9SCAwUlgumcxoMXyzkGE8cepnGsyx4
         lP68yfxtI1P5kSoUSLx/sxY+1jymYRRrPvL8R61+KtZKYDl3kJ4EF1knDnt+Fke1GBwP
         ds9Q==
X-Forwarded-Encrypted: i=1; AJvYcCViBaOL1arMDV36NWs6uv98witJrhpAzEPWe4q8ZyRj1kDpJXjDoGwTUEEcCZxtQQytxLkmI/fM+CRu2cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKnpUrFssaj+/yai1Py2sg1Olu3+prkMggPRV1T0dA7RTHPAc
	6izpOr/wvEoo4GjbeLK7k7ayfuAK7HThg2qyoiNjHddJKwd4RY1GupSER/vp
X-Google-Smtp-Source: AGHT+IFlTE1TAIGJ7jQZn6Of9aSyW8eej73q05cpzIIbOcKFy+h7nv/o1+3+2HwdBeVpwYrTBE4w3g==
X-Received: by 2002:a17:90b:c12:b0:2d3:b49f:ace3 with SMTP id 98e67ed59e1d1-2d85638576dmr17939452a91.28.1725384624274;
        Tue, 03 Sep 2024 10:30:24 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.229.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8edadf788sm4086522a91.15.2024.09.03.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:30:23 -0700 (PDT)
Date: Tue, 3 Sep 2024 23:00:17 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, quic_jesszhan@quicinc.com,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: hx83112a: Switch to wrapped mipi_dsi functions
Message-ID: <ZtdHqXvwp/L9dZJ7@embed-PC.myguest.virtualbox.org>
References: <20240902170153.34512-1-abhishektamboli9@gmail.com>
 <87plplgkpa.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plplgkpa.fsf@minerva.mail-host-address-is-not-set>

On Tue, Sep 03, 2024 at 11:17:37AM +0200, Javier Martinez Canillas wrote:
> Abhishek Tamboli <abhishektamboli9@gmail.com> writes:
> 
Hi Javier,
> 
> > Use the new mipi_dsi_*_multi wrapped function in hx83112a_on
> > and hx83112a_disable function.

> IMO commit messages should explain why the change is needed and
> not just what the patch is changing (for this one can just look
> at the diffstat). 
Thanks for the feedback. I'll do the changes.

Regards,
Abhishek 

