Return-Path: <linux-kernel+bounces-559735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6711A5F8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0A77AF6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEC267F57;
	Thu, 13 Mar 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATYrfSPb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5994262BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876939; cv=none; b=FE/QOfhiEQnaiwJC2PIop4cPdOvY/N9Sazv11TexFjHXr0yjoMRtryEiuPgqVD0bE9+5oRx8/u0i0AfCoOp6HYDZKN22qRmcpWTSHdN2DveL7e1zf2k66jFC+IBcUig64WCMB9iEer0kCHoIVGF9UsxYw44tS5mqlbh2tBgAk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876939; c=relaxed/simple;
	bh=pS086Ei95dm9ENDvZ4JWMqYzbO7FAjHi8vpFlPQ07wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNGfF8Fk4n/gaDd/OTrdGLEtYGdq4tBrPSP8vxv2xczinRxmwljKvZJP1E2VoPeegl+nuCXHZMm7RDSb8vTyW2vLHdyqkfKyyr3zE4r2L4cLbm9lwCmXOkz862OTVa7BkdQyb7WQYq1cPeLa2z7wmbElRyJdoBboVlj8jxtRZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ATYrfSPb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so21529855ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741876937; x=1742481737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4RAcdHWt51v7tLhIYkLYH4BzZK7GOF69Cz3Sw2ySJM=;
        b=ATYrfSPbdqODoIEuKZdEOvKhi9AgZZgYuzF+Z1HqQEyf7WbBiGEFETtaqtQ7ZG1AqK
         EPmGXkyv9KQZzMFgfIXzYh0+22gGcOUvttZQAofCUNnm51zy16qLIOCW05Y1INiBuzyi
         ROKlCNAeMh8IofpKGtGdQNZggvSknYSztrjZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876937; x=1742481737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4RAcdHWt51v7tLhIYkLYH4BzZK7GOF69Cz3Sw2ySJM=;
        b=w9WirbmkxlbzK48jxRpoAijh3E8VbQaaVg5SWQx5Mn+MkuroZbiTY1DEwV76HT0Wic
         cVVdxwXltdBCUz9zbEjDoFKLLx4jczj9kwZczsrLGFxICzruNYiXweVN9KrCfV6uPNEx
         6YehkzKSDMpzPYD4iYGA/cY3KTKgubvEBBAT4AsuAwd4EZkajwDWFwlnxYrRCG/kvQAq
         J5qrbZLVc6eilTz4lFBW2t3TFkQa9iWowhX/OzKssWTdnuZNSfz+7qaH3PfLXlDAmuWR
         M1E4n9ezHzaMTop0ErYQJmmD6cY1/TdXY/z+Tz24/cYqNA4zUlzxFz+5nfznY+Nxopbk
         tVRA==
X-Forwarded-Encrypted: i=1; AJvYcCW9jpLzxonikv2ws7zL2mBcDWyZ/3GbmdsZQF2Qraj1iKFNvc/ImnvKfQa6mD1c5IB7JkYUcTYssRcGU5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDS3lssnqlX57OfizSUbuAvTGwf5UUW3U8qcDQ4euyY/JXm4OV
	OCoqI01PK4Gksy9fGCFmye87Q2qEMF36AIB3TBftg5xZ17PtMdf+DFCqXIS4rw==
X-Gm-Gg: ASbGncs08n92zlOouvdqpvlPj+QmSZdG0kn0Fy1ae9N37YVkNXl6Ctk+A4FIjlc+0X+
	C12C76kmkeIhBgRNE7Yw1bYuAAnCTo4eayWZSyrEWCquZLhzIlNGSoYElmEAILXreOWICHs5ogJ
	a50FR1c8Dm9kruWpJ5NNvm/Eld16EvfmE2rUuUalarO8UGcO9Ow2tO0XkoD/qGeS4o3u0eqHM4t
	NM8xHVGjQDftrR+ZhXHRj+PXXW94Bb0aYvSUqu7nhzi7Budr6+nXRMhiHMn2A52vW+MUO6cJ1KK
	X/KApHfEZt9cCcKSP3Dsb3gwdeHvmxAIUKqzrgfFTHhVq/s=
X-Google-Smtp-Source: AGHT+IFyACEHZ0RRWlOtfXTfMVStznnNSGYCYs2DoBDCthhX0Lr5bmyJsPFokwUzyYi3SjOlpOdoQA==
X-Received: by 2002:a17:902:d2c4:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-22428c0f48cmr368059175ad.45.1741876937075;
        Thu, 13 Mar 2025 07:42:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ef7a:848f:3b9:98dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe884sm13871045ad.185.2025.03.13.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:42:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:42:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm/zsmalloc: prevent integer overflow in obj_free
Message-ID: <w7ralg6gzp6kuqwulpczs7uv4htllt2rasuto5unoy7xasr5cv@2z6pd7syyj6q>
References: <20250313115147.47418-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313115147.47418-1-abelova@astralinux.ru>

On (25/03/13 14:51), Anastasia Belova wrote:
> The result of multiplication of class_size and f_objidx
> may not fit unsigned integer. Add explicit casting to
> unsigned long to prevent integer overflow.

I can't see how this can be possible.  Neither size_class nor
object idx can take values to cause mul overflow.

