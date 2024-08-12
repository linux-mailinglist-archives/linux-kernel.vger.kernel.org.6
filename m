Return-Path: <linux-kernel+bounces-282670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AB94E732
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B61C215E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA71537D6;
	Mon, 12 Aug 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLIaLthJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD031509BF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445549; cv=none; b=eFp4pKA7L7MeNCT2YnKa3UZTNZP1Je+CDCvpaYa/d0S0KD5OwmL326GxAkglUkw53a8B+G4lHGd6GZTgwl+QCAKn5W7DiJgzFlml4eyxOR/rUE9JWcKgsgZR900Q2ev1h6fm8QxNbKAdevsAey1kNU+M1S3VAdqZY+AqZefj1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445549; c=relaxed/simple;
	bh=pSAXbYgoPyhOzoWZQq1jxIxbA5US0Ij9CvyBq+u9Tk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtufKDC0b87O/8ESZPrKE8zTWyjzDcnxSlIorTZ5rpsOi2OAWpJSY8qtHcQ9/JPcJlIOTTO5zhY8IrL/cfKV31vEKhpNuBmmMJynLYybV52SEDc5ITD6ttRvIQxmsO97QXyRkUhMrjlapDSCXyGkVbfd/Pr0HPme6tmDkcUaUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLIaLthJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530d0882370so3871768e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723445546; x=1724050346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYvutISkLRUGH6JLFpRcjOxTE3aMRs9JKjHJPpsTDJM=;
        b=lLIaLthJpbEBlDNDTy7Ag0xmsPD3sgBIAk9GlZLqO0Y8rKw0EfW2WdtouMaOh03Ljc
         dR/FYCw1qBJKoPn7ptw5UKusWtoX+O4mVCk89iq+lICTeBUpuaYf+4rzD9EJhSoIZbh1
         83j2FdroZRHvUumXX4WYwsEJu4aD0ePCUbzyTnjT1ql/jtdcwBx63nd82jM0ead3KcLh
         J6g7wJk2keAbPVaWNSuww4EqxN68XPRXIjBCoRyaSSlS+MN00sb8WZ+RiaXvwoPEfcfQ
         fN3PvxfHOKEBCuLugaqgSP4Duy97pmpsGVhppKF5MaI+F0VeFYlHQdXptVZlRHecsJjr
         Fubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445546; x=1724050346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYvutISkLRUGH6JLFpRcjOxTE3aMRs9JKjHJPpsTDJM=;
        b=U5qGlFOC3c0Lfv9yittSbz9vsjO2N++CiFJs08DaS5Ysuoek8XF3t8KvKK3Yj128V4
         +Ah8E7jJlSMm/dAdS4qKxcNL/AM6mbaMj5v0Z9bp8sLkd9muO3cajbLKhhqRpwuKjVLg
         RJPgwd1HoQniMBcyFmpovUZcrI0vQ0TA71/udhSS5o6ISEiq8jBV5GUmQsMhlTSj7yeK
         OQTqQdeQCTWSFfZ7b5fRAFfY3Dqqjk90LnfMeS7/rYI2tavmf63eml6ZGrB8NK/2KyL1
         3brHIdDgfhRyOUikc3QyLgFMH223nrl/INTnrZ60sV76wzebDXd1NIKslN98q668byN/
         Q6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8FyVwwIR1Rc4iocpXUAQrmL7XTQHWyRjEKCTc1qWiWYKpNe0aQbDw0aj2mwG+AZpSAtdQEg5ume2zDcDzWOkG8dxFqPU3ZfxAjUFE
X-Gm-Message-State: AOJu0Ywe2Oxo/Uth29G28igUNReAdnH+UBM2fEpM/eUwUaKLRw6mCuzl
	HK2QPGGcDTYCjOfTd718fMptJoEtPOcMU4xhbf6lPI8SwRkZ7edpDE+ECGOCqwU=
X-Google-Smtp-Source: AGHT+IEhleIQEZN/9JGTRhxG1EPnf++IP7O/xu5A3Y0gWPhqCZnhmQaXR3vNN1OTOTN5uX1Y1o4fGQ==
X-Received: by 2002:a05:6512:b02:b0:52c:adc4:137c with SMTP id 2adb3069b0e04-530ee984de9mr5848753e87.20.1723445545776;
        Sun, 11 Aug 2024 23:52:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a602220sm2012351a12.82.2024.08.11.23.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:52:25 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:52:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] drm/ast: astdp: fix loop timeout check
Message-ID: <989ba8b4-19b4-4053-bb00-ccced42a8829@stanley.mountain>
References: <9dbd4d2c-0757-4d5f-aa11-7d9e665e7633@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbd4d2c-0757-4d5f-aa11-7d9e665e7633@stanley.mountain>

On Mon, Aug 12, 2024 at 09:42:53AM +0300, Dan Carpenter wrote:
> This code has an issue because it loops until "i" is set to UINT_MAX but
> the test for failure assumes that "i" is set to zero.  The result is that
> it will only print an error message if we succeed on the very last try.
> Reformat the loop to count forwards instead of backwards.
> 
> Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: In version one, I introduced a bug where it would msleep(100) after failure
>     and that is a pointless thing to do.  Also change the loop to a for loop.

I mean this version also sleeps on the last failed iteration but at least there
isn't always true if statement to try prevent optimize away the last sleep.
I'm okay with a sleep on the slow path but not with pointless if statements. ;)

regards,
dan carpenter


