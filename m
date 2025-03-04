Return-Path: <linux-kernel+bounces-543267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9AA4D39C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594A71897765
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC971F4CA2;
	Tue,  4 Mar 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFMM4UdJ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8991DAC95
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068998; cv=none; b=qDKjPiuYVg8tJBmMRzR+wgVFL0hmFfW2FhDvl3S76GlDejMVwH153bZ/v2o8BvXZ5XPofxJviGJHa78aIxMl5gtmo6nMxRt/f0PK0go5Q4VBzZ6LO48vsSF0Z9niOK74CD9zDWkFKv7WLI8h0nWy623kQ9/6cBu6lsJflG/ovpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068998; c=relaxed/simple;
	bh=19X3Uwx+JKkXHVL064XwCITOPrqaO+UWsdIEHnMneuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEyDLVvOyo4vEhEYyDZMXct2o0wwwTnggPVdp0I+Gjmv2X10Yj4/J/Vd3gpqJtkbFYa5Z/59wwESMBb6xlUjuXvpO6P90yGqL1rjjRk7nqZironXHdj0L9RQvZYsSehhw279NR8BLVdu7P8KJZ+vQEjrDuevtlTaWIOFsl45TX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFMM4UdJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso6215591f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741068995; x=1741673795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/nKPX6DIjshEMAUl1KOyqAjGkCUe+ICt9ye1bUSmbrI=;
        b=XFMM4UdJk1Yh3GXNa173Jt80Ie/9MKLaAq7fUdk5ctdOkVE1ydX+AU/r3cqCskssBT
         bV9VWbGh11E9ZlAz7Nho5/q8rljPYp69v0/Y4PTGNOm8ce34msCN/jRFr26vUDj2Sj3t
         v21WDEDfj8EO0FU5J7OED6HOB5C3DB+JfLqCBsndVoSTMih9ESbl1Xhqti0rNfjK7X+N
         z7nRQFeHrxawLOstauxQMRkqwJXM0Um1Jv4RF0kQb4dJMLb5PbxxRgvT+ZYc7vmiqbmj
         SXYjfxmUTBacQSzj4LbilSlhNqXsH3ttM89n7RJ1SDafIi50KE3u4xwlDgvmeAGrVoHp
         y74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068995; x=1741673795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nKPX6DIjshEMAUl1KOyqAjGkCUe+ICt9ye1bUSmbrI=;
        b=QXWOJmWh/gddjKaXYDkGGbwfdeXxkjM4dtnTjb+RS9Dgxp9q995HvsQMFJOc5RLaZj
         A+xCULKRYhFFdw0kM2QS1MTkc7kdg96WYa+97NlUr96rjg0Dwevvlw5BLAjZxYVkRRpC
         JrzEqnmpDAIk5ei0JQX/QgfqxaWA0vkwQ0YVhqvDHI7LugbJKM5+wO7cUAycSbkkDhzc
         BQQMynN39HkRCwcF1rLdt7Imo1cQ/b1JaRRJdS0/vnnfFWvz564rWqezMkXOVQ6Le97b
         ONEhBzEZBwrakOonECoTOdnXwmX7weau8J9boTBryLKkXaNAU9bSu+JTr55aUDb/h3dA
         KaGA==
X-Forwarded-Encrypted: i=1; AJvYcCUY+OgYup7+SfEUmN9rBcfNdjASUuWbb1xEDI0PUTl9DLFfZ1gt/RNjuoiFhjbAfO8KU4tAbfMc+ZKLufU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tMDHmOLp0IsTIDwe2KxdzkM11q9LL0md0y4QeQbfoeEeP9Dj
	lgfKmH3oDHNO+SX7himJ3AfemDwbv7G3+MzRXmu1P1Fj3h2RHqGrxZueH3SqUPg=
X-Gm-Gg: ASbGnctWfsJgBEE/BVQK6huyK7VAcfhKW1ZVZqCp78UxOnjgU8BojCIXoms2qRi2clw
	IKmbrKNee7SV8w6MNL92c9v5pQOhoFooR8aIDL5kzHfGaV5mLrgYiO3hhGYhtwoQJXeVJXbmMil
	NXJINI/aSgKE0TZu+04J/LrIbRMVaZNYH67gBeb0I4JiHtjTeoLIjwwcKwYOoeD5ql9gEOThKgc
	XzPdmjlGmWUS9FQvJR96/dE41Uqx6Wgfc4LNqQ3417IoKFK6pgAH7MvEw4sExKOYVDgLN1V3bhi
	LQJZVcCQVMBfJf0VJIPXrFrUHyrbMkzS1i7QTlAUkADlOl9SlA==
X-Google-Smtp-Source: AGHT+IHGIpUcpblova9lskxdumW2y8lPrejnCbvxgbQgqTl6SZZm6j7C3FFjt6dcr0CvmsmXKYeMQQ==
X-Received: by 2002:a05:6000:186d:b0:391:13ef:1b35 with SMTP id ffacd0b85a97d-39113ef1da9mr2356446f8f.29.1741068994861;
        Mon, 03 Mar 2025 22:16:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm16819421f8f.14.2025.03.03.22.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:16:34 -0800 (PST)
Date: Tue, 4 Mar 2025 09:16:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>, Simona Vetter <simona@ffwll.ch>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Message-ID: <bd5220d3-e2f5-4688-919c-bd65f4a41eb2@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
 <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
 <Z8YF0kkYLlh1m5ys@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8YF0kkYLlh1m5ys@pollux>

On Mon, Mar 03, 2025 at 08:41:06PM +0100, Danilo Krummrich wrote:
> On Mon, Mar 03, 2025 at 06:49:07PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 5 Apr 2023 18:38:54 +0200
> > 
> > The label “out_prevalid” was used to jump to another pointer check
> > despite of the detail in the implementation of the function
> > “nouveau_gem_ioctl_pushbuf” that it was determined already in one case
> > that the corresponding variable contained an error pointer
> > because of a failed call of the function “u_memcpya”.
> > 
> > Thus use an additional label.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a double-free")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> I'm not entirely sure, but I remember that we had this discussion already.
> 
> Can you please send patches from the same address as indicated by your SoB?

This is not a bug fix so it shouldn't have a Fixes tag.

regards,
dan carpenter

