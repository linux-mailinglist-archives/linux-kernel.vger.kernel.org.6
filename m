Return-Path: <linux-kernel+bounces-410600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C99CDDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56112824ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBB1B6D1F;
	Fri, 15 Nov 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x58n/RLg"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EE18871E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671719; cv=none; b=iWQhF5SlGEO+nQCsWx9bcQrn1Bh+1NfTqzIKBf0xR9/FHL11SDKNCVBXvkrTKCyOInpOQvFw/VTLlnhIvbK65/xfQXzmyTsHyAifD/stP1nQlEYd04dXyQyjD4raDOuwbYoW2M3CyhI0JceP+xCRoZ1PH2xB25GQzn8RqLLC0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671719; c=relaxed/simple;
	bh=N0Dlcy4ODEyINkyFqZ4OExz3WI7d7VOMlLyb9BnaUkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZfcX/79M6XIam5C93vN3bs1ONrweB/0w1//TI5BKNC+sjOtxncOYhr+jCQka6rcS0THDr4rOWxXZ7XR77Bt1KNmwTrpC6DS7P6r14JDqldIGT4pLn1JI7vDg+H9wAM2bBoOcMC7G89zFaFxuRKVVbxcSmzMCvbTBR6CaPUD9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x58n/RLg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1174599f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731671716; x=1732276516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNxG4xdSJv0mTSk+keMrkENbnyIHTmTRRxL8dSugZL0=;
        b=x58n/RLgHNQVi8T8uD+0EkC3Uyd/vNRlfKMXlvxVhpGR5bPI5lASaWhDHQLsgOoz+p
         hrvHf7KA92HiZH+wcCFUkLE0mBpwg1Foj7CEZzoDDwE39N5fqg1CITNAlqW+0iMoLrvJ
         dlG4yq4GfAUam4qIBp74tGLUiULdz4oD2At2EW8+V3I6iT5KjA7AAhQVNoZCRj2WNdRW
         V7yCmKQr5TydMyAOJYKzb37OoCPjwyspt2iwz2ur5+rn8RUHdf2exMT+s4CwiX93aVYC
         MWRmIDO48IjE9laFA+3VcOIMA6gI7CTiW4r8EAUS/3+VD9AExaLMVC5eBT50A0z+RSHf
         MNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671716; x=1732276516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNxG4xdSJv0mTSk+keMrkENbnyIHTmTRRxL8dSugZL0=;
        b=cXrsUV/S9w9i6Ql0vGiXVBTymbxEM/mmmlfQjznWuwOG6C6VO0MVRXm+OdaWPVAvlW
         RGXBNecjucjFz4MBwKk9OWcHWxkvKharU272NY6IouVu5I8chRrvUa8mHgW951KOXlUl
         m7iMSBFXNHwtEYnxV+KmVWut1ZXmQ0xY6JO5YHi0+xwJjHe79REj32M/33eCaumqADh0
         D29nGI3rFUCBpKiUqCtyA6iom5C2PnMCfpYSzVB490uAvkerl+yQHbfBrsT1t+emuUhw
         2lUF12a3XuzGv5f/3aieUjpZdyGi1i+TTgIUvFXlglUIog0l0FQQwZCQiL82TMqGjM4e
         lWoA==
X-Forwarded-Encrypted: i=1; AJvYcCUlgo0vgI3AfrRVeKajKQdUvByHY2+tT27ubJwkm1ar54dQ1tr6HOM+lRFt1pyRTdDVFsf4kXKnoB+fo/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK9SklKidh64wvvurYVbJhTzcfU/lCbIMMnBW0p+Io6t2Ire9
	tu3dYUf5CS/eLd6aSP8nLvVT4Gc0ejJOvY4ItHF7Oclr/YLOTI4pytkeeRBKF2Q=
X-Google-Smtp-Source: AGHT+IEDrFmWkNJyBlQfh9eLZ6iUWVe1jY5a4fTFgja8Q/hvy4vO1xvurXhI1C3fDweeY77TtX07yQ==
X-Received: by 2002:a05:6000:1f8b:b0:37d:4fab:c194 with SMTP id ffacd0b85a97d-38225a29fe4mr1936660f8f.25.1731671716421;
        Fri, 15 Nov 2024 03:55:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae2f602sm4157425f8f.90.2024.11.15.03.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:55:15 -0800 (PST)
Date: Fri, 15 Nov 2024 14:55:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Suraj Sonawane <surajsonawane0215@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: gpio-exar: replace division condition with direct
 comparison
Message-ID: <f9daa71f-cba7-4086-a523-a2e6aa526ff3@stanley.mountain>
References: <20241112201659.16785-1-surajsonawane0215@gmail.com>
 <ZzcWGJxqMJVYd4Tp@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzcWGJxqMJVYd4Tp@black.fi.intel.com>

Uh, I had to think back...  I had forgotten that I actually published that
check.  I can unpublish it.

I wrote it based on a real issue, and then when I looked at the warnings quite
a few places wrote code like "if (x / 4)" where they had intended to write if
if ((x % 4) == 0).  So it seemed like a good idea.

But in the two years since I published the warning, it has mostly been false
positives.

regards,
dan carpenter


