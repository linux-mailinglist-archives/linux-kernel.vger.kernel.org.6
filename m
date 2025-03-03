Return-Path: <linux-kernel+bounces-541458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A13A4BD1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B23173F91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770341FA262;
	Mon,  3 Mar 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMw6IyjF"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FE1F9F70
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999227; cv=none; b=d3l2vOyiWZIEXIp8tiZoAE6LhMa8srPN6zO2g7xwjQo8bF85t5ggopseQNA7vaEgMsyXzEI9/GqORY0us/PSvPNlVZsOO5Q+gFpAQg8mhJ5rlJIchz1aEbZUr/+f0aD8qpTsZbpZlLtnjx4lsxGbtjgp4B04zmGiw/EHkEIHHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999227; c=relaxed/simple;
	bh=Kj3rTWIoDmPt+SLfBxnJONe1BtBMU+vHFup+WxsAQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E00wejY6/WFym9yPOnwkX+mzIRyobMUrB0r29QAi1u6DmMwbQVKRA1QSjpHEE4+GlBIkC76udrbBTeXty+OXY4U0g7xd8JFtWUOEgNlDc8LOqV7FwJyBv5x4m7cRgJWb3akh8lf+PCbTjfETh9HP6cAKKcFSnz5TS+TN9Vl4ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMw6IyjF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf48293ad0so340420266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740999223; x=1741604023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=wMw6IyjF1vxftNpwe3TiSYPJorx0sH1PenG75GdY8cZ3SGYvNdyoY65gyx1fwqGgq3
         ccKosqU9GeKwLs+tn7feTXe96ARw33I00otRm55hQYokhl3hnMLdUfivY1aOkLFLD6C/
         0arSEXxWRvqwl6ZcAqiwNrkYyv1GJlBtLo9obA/ntCpDrZ6/r53LPK8BK2UaiNa50v+c
         irXlpOwMkmZtoWawPh/0Ur8DAdwXZg9mJ2Yi1X7G0tGFa+yNjFqq8Qm4O8FmUTT+mX7t
         umnUJw43gjFW+5eEvl7ftYizOoaLde7Yzc4cMOp5NA3gb0avHVW+ceQlfxsaB8ncnaBZ
         0W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999223; x=1741604023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=bx3zY3LvKjN4dI3w/crqn8C/ThVwqbnVh7IDQerbUMpGJx8FKkAXsXbglPxyPoDFLj
         4A4xe132NVUnFPE4+4pS8K4SCEqWiylFM6ZpI7IaaNQNk+zrv44y617BRnl4EqqrBQ8Y
         RfMEWXs+UxmzIpmu1KJRMnIDkMLKKLbmXBSwU73mLem1aycNzIcFcGMEHr+p3BrzqQZH
         f9wL4bxDQrR0B1xqjEQ92/t5ZEG2q43vphDMzaZJnMjjZBo5S5+X7aJLhzGeXeHL5kcK
         h2gdorqPQn7E9ums+qTY82fefbrKZC4OxH56Sl+LcqVF/jPcKQidB84eNDLSIn7f4sIq
         8zWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLwvF8lkjtHHrJOrnd3GHUeo7kwMN8XGVFhrl7Yi0yUqF7fDDjXd2ZgHcf4tee7fzVFushIk/6yeBNHyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMcejJeE11D6q6jrjYDiVLaxh8xG5bYadj1ctmixDb5Eyy3F6
	b5Up21pN+TMJd31Oo1Vd9u7tFxDUZaagjuEMDmN7XcTbJCWjHvWyrArlYtirVwZ0+VoHtIe0WIg
	R
X-Gm-Gg: ASbGncut36iTUFUjCF8kFrBl5ol1zdDDoBQRvf0MHS1nTBIHTmryUlXsyA9vcw6DsRM
	inaeO9Gm0XnSlB7mgyWIftamL5aybRKs7FIDSqe9lv1fkXa6MUQ/0Fj02sKjclMzlrfMiwAZ79K
	2lqHMIIn6TaKoxrCX36nzLrsjydp3Jkom1/hnruoP2N/d+Qbqnvlbc519E2QUgES+tMbpmMCeln
	uyYy5OiYtsP1c00A4Kz9hjK6GhSDoy0HHy+igFtyG5yfFJzGOkJa5NZAxjTUZbbC5A87k5E6geO
	Qlq0v2rR/o0kENxvNyapU41RCPqg2dIeILxD3hni21dEc40Ilw==
X-Google-Smtp-Source: AGHT+IF878WM4Ac0lwU3U8jWhqiDwhdQ1OhLRZrdD2ubBpWef4yPS0ciLaeLOsRMTVQEjBD/4tiTTg==
X-Received: by 2002:a17:906:7310:b0:abf:13cb:c411 with SMTP id a640c23a62f3a-abf25fabbaemr1560894766b.18.1740999223509;
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf55e88748sm421511766b.54.2025.03.03.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Date: Mon, 3 Mar 2025 13:53:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Message-ID: <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>

On Mon, Mar 03, 2025 at 11:30:46AM +0100, Uwe Kleine-König wrote:
> On Mon, Mar 03, 2025 at 01:08:29PM +0300, Dan Carpenter wrote:
> > On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > > > 
> > > > The address of a data structure member was determined before
> > > > a corresponding null pointer check in the implementation of
> > > > the function “au1100fb_setmode”.
> > > > 
> > > > Thus avoid the risk for undefined behaviour by moving the assignment
> > > > for the variable “info” behind the null pointer check.
> > > > 
> > > > This issue was detected by using the Coccinelle software.
> > > > 
> > > > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > 
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > > 
> > > Should also get
> > > 
> > > Cc: stable@vger.kernel.org
> > > 
> > > to ensure this is backported to stable.
> > 
> > It's not a bugfix, it's a cleanup.  That's not a dereference, it's
> > just pointer math.  It shouldn't have a Fixes tag.
> > 
> > Real bugs where we dereference a pointer and then check for NULL don't
> > last long in the kernel.  Most of the stuff Markus is sending is false
> > positives like this.
> 
> I thought a compiler translating the code
> 
> 	struct fb_info *info = &fbdev->info;
> 
> 	if (!fbdev)
> 		return -EINVAL;
> 
> is free (and expected) to just drop the if block.

If you dereference a pointer then it doesn't make sense to have a NULL
check after that because the kernel would already have crashed.

In 2009, we had the famous tun.c bug where there was a dereference
followed by a NULL check and the compiler deleted it as you say.
And then, it turned out that you could remap the NULL pointer to and so
the NULL dereference didn't lead to a crash and the missing NULL meant
the kernel kept running happily.  The remapped memory was full of
function pointers to get root.

We changed min_mmap_addr so that we can't remap the NULL pointer and
we started using the -fno-delete-null-pointer-checks compiler option so
that it wouldn't remove the NULL check even in places where it didn't
make sense.  We also started doing more static analysis.  We've also
tried to randomize where functions are in the memory so it's trickier
to hardcode function pointers.

A couple years later we had another bug where it turned out you could
still remap NULL.  I forget how the details.  No one wrote an exploit
and it wasn't publicized as much.

Anyway, none of that applies here, because this is just pointer math.

regards,
dan carpenter

