Return-Path: <linux-kernel+bounces-296029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25C95A494
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA96D1F22E22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30AD16B725;
	Wed, 21 Aug 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koIJyjrA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4F4085D;
	Wed, 21 Aug 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264150; cv=none; b=UOJ4Kt7IU4RaV36jG0FuRpppVL1plC50yz17x4XG7Ue1mJVESvCALpE+ZjksWyxXEYp4Vtn57LTQjkgTFPDkoATkh39/7yP/bPsgK52OnNuxbzcRRK9jsqXvEm4T0hC0WzRShahbxDKHRjkZGaD3BJnBqIXM4GlqsFFqc0B5ilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264150; c=relaxed/simple;
	bh=WT4FqzDcBXI76PEhVbnCqBkwMzjeorAi2SdfHfNii7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnGFMTJIae2SMvZlmoh/F3ESYuPRqruoNZF8QkSryqjBumeW3yw2DlMUjR0L+fw/LsMz2M1lytK2ometYSO17wABt/UqxmQ4H5HASU+rMOaRwX1lOIWUu4PhfXUUf82hyB9IVsUjf2RBwZ8kWhVcGpQ50zTgItn51jyFeu6i8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koIJyjrA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7142e002aceso464814b3a.2;
        Wed, 21 Aug 2024 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724264148; x=1724868948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PNqGIZhhwKQlSK4vxc3HqYHLp2ABqUIqCgS8LnjfYs=;
        b=koIJyjrAcHW6nm7/IHYYvbqfC6fMAQ6fHwRVugo0W8t7hTpL4kQmXL26gpwmk2OW9W
         q46H0Ap3AeV9ssoiyE6W8xjVC5+WIt1vKaZUr/LYBhuKubcgXKBJrqe4nod2oigSufrg
         EyA+zidVOm8QZHikHkUCCcjq6ZlYmHiYRMNEekFsmTqdfWDO0l5tGYMfqc4EcBxhSuT6
         DLYXJOhEm9oTYiNvdKf9sQWRGB6TMdax26p/vKfVqRdSGrfWgsLsyKruL6SmqYqphWrM
         rUn2SbpiCfZrwg+D8GDXeut5+BIyjNTtuI9RhqnTAAXtCg2FxdbDxNqWMkfib9E7sKAu
         Q/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264148; x=1724868948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PNqGIZhhwKQlSK4vxc3HqYHLp2ABqUIqCgS8LnjfYs=;
        b=cxaX6DuB9UVoF45NWMOfQu2elwxrTevhowzTHAdvU/2O1gybX43rRC/rh3efoKhMNK
         D7og25RH1r6bFBKAvDX6JMiJ1GYNekAdxsUfRE7lOmQv6eiGtr3Ok2NHOzTnKIP3YJ9n
         eaKse1xhlIPo9RfC9rgvvpE+S2A6RQmviW9s8IkhLCaB2adWfYWFs90MeGup4Vw79aB8
         9QFC7o3fcTw7w/72T9w+JGAX6klZsIIzLkfVeZbKiqKI2EE7VPPGeTOiXz0fnPn+AhjL
         dBiAWQQXWiZ+MTyi49HUtTi+005xpFcI76H5KRBTLVG43mkcpJfCADpzhiGD727OJ96K
         nbJg==
X-Forwarded-Encrypted: i=1; AJvYcCUqQJxMq+Nevpla61/W7P+kJlKwIaOV9Y7VyuFqZtaYqCGjNZXe9Gq5T+P++BmXDTtY8cXUtn3FvKxBo9Q=@vger.kernel.org, AJvYcCVKnwJlgruf8iz/7jJi9KrDiLuk0r4RyikRMd4ZHX08zsLznApdnNjcfTUjmHL/TPIDooMY3v4rU43FQFN6g8c57fRRww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6id1p7UTPHttgP7KgiobWqnqRBucQnuO4H1YkfJArwFduv4t
	SvZpT8iTtNrw+g6S+AoDk0vCvG0ia9MzvrBK5fNE/yI/6lWpFTMF
X-Google-Smtp-Source: AGHT+IGraL5V6woCK5Q7KMxZmif7jaa8gcKMEHZ44ch0mqnHmfQeUu1DpHRaLklGb/2Q4SmJs6tp0w==
X-Received: by 2002:a05:6a20:b598:b0:1c3:b2b3:442d with SMTP id adf61e73a8af0-1cad816341fmr3966281637.40.1724264147913;
        Wed, 21 Aug 2024 11:15:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9790:ce1c:7737:a819])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1f2cesm10281565b3a.181.2024.08.21.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:15:47 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:15:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Borislav Petkov <bp@alien8.de>, linux-geode@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
Message-ID: <ZsYu0SEy8ZUKEJqP@google.com>
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>

On Wed, Aug 21, 2024 at 12:15:51PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 8/21/24 7:25 AM, Dmitry Torokhov wrote:
> > Convert GPIO-connected buttons and LEDs in Geode boards to software
> > nodes/properties, so that support for platform data can be removed from
> > gpio-keys driver (which will rely purely on generic device properties
> > for configuration).
> > 
> > To avoid repeating the same data structures over and over and over
> > factor them out into a new geode-common.c file.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Question has this been tested on at least 1 affected device ?

No unfortunately it has not been as I do not have the hardware. I am
hoping folks on geode list could give this patch a spin.

Thanks.

-- 
Dmitry

