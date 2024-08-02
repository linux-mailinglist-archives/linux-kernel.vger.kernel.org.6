Return-Path: <linux-kernel+bounces-273033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B094639A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49FCB227BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186181547C8;
	Fri,  2 Aug 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEfeUEs7"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9301E522
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626006; cv=none; b=oVZHII1Rn1d+ncmGkf7/MWE7+Si9tNo6Z75tXDXarb7dSk9GvZudbhGGo4+ZJ4QVioZdNB0obvYyjfhlUjJ8hXOdGnWIPFHJq6MssvibYv9ntmH06h6CVbZ7e7NErLlWTmUTanXRd0HCT/eOlOdziYEJ6nxBcC4OaEHHPdcOTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626006; c=relaxed/simple;
	bh=I3VjmxF7k32AXcwFvptEV8eX+JKPI5wtGa0DGaL5t5E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdFKFvk9K0jl/xbCn6Km0IyuonORctNPhpDZpScfLVRpr6PNKdfsXHVRGuew4Kgp5gk68wGLPNXMLFrVnsLZyRf93pKa2e+RBlI13vTH+Ex2U6fgxNwf+UmYyTyrqp8Tp1Rdt1tImjJgi8kgI8B98cXrQHYIlxAUtBh2ocigFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEfeUEs7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d1c655141so6535555b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626004; x=1723230804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kd3hPVBcALVvyx40YxWv669M+TnDHdKtlBMWsQ+Vjg=;
        b=YEfeUEs7s3Ndx87XkyjyWogNW7xPfWk0aaRuTpL+98y8HO1UMiQwNH6WFCmm2u2L4s
         qrrjz+lkJb54woWPRAPdv8DTl30y+ZevB8NsZtXQim90wd9Y1bqByEUgt0iAUtInUGCg
         li9HLrfqp6dRYGTP2lMfFJEt0pNGNYv/1SK9hj1QHShcVYPnBtWkQTBTuruPnGUv6sJX
         Y9R+rIvCxEXRI7+sJjdM30VovUoOnZCROU0A5kkaF67YftnVlBoP2tk65DRPhoz98zgg
         movK/pttK734o0LX5ADR14/sk9RnD6xrpTfjqVOmiFuUPZhLPa9BBjDld95+ighfnjEw
         YHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626004; x=1723230804;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kd3hPVBcALVvyx40YxWv669M+TnDHdKtlBMWsQ+Vjg=;
        b=mk5u3yeA1DrdfBNpWYn4W67WMtlMdcigGYoi8TyZLrelD679h33EqhySXg4e5juIr0
         E8e9vP45gpIEPWhxXgdRkVdt/mE8G9MrRo30p6y61G4JK+hMRgcSRZehixCQ7oYj61yW
         WZM6XC4opEO5QAstCbFNhUqtsn7FSedDvjOfNqaHyS7KWfTUne1yposlVj6PExJRJyYH
         XMdY+VqZ5u+IZ8oKomlrwtyk+Twu+VEDD3wCGSLI0SUSQwNUPNaXPquvGhX9OTlRMCcb
         z7/XF4rx63YiSL5nODZT29rGsOrmW+7I5Z+yQhcD9TXHhqe06E3DFsONIRAKCCgeg2nd
         ujJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0a6wFn/PKviMZl6ZR/UMkyUjH4M6z016iHToipwJOgUy8PavF+wjUUYLlpC9vQVhDzz2CYTWEUXqAT8ooqVrFP0oIJhZ4pVPw18+b
X-Gm-Message-State: AOJu0Yyo/VSGFFyy/aXy3MCBXdFMlyH4TRz+TLTM7tbGYnaihDoXwF1U
	dDKQu4okZX+a9OHFZISe8zuA0UDX5AQiz7oN9gmNYZrex9Gkqb9/
X-Google-Smtp-Source: AGHT+IHaNBhhCLj+rLb1MIIibOCBQ8qGhaPzw+HBHeO7I5ynHDW3RImfTp739FfCCu8PEtMN+bF5cw==
X-Received: by 2002:a05:6a00:888:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-7106cfa30c5mr5905834b3a.10.1722626004477;
        Fri, 02 Aug 2024 12:13:24 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106e7f2981sm1685460b3a.0.2024.08.02.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:13:23 -0700 (PDT)
Message-ID: <66ad2fd3.a70a0220.226e03.5a9d@mx.google.com>
X-Google-Original-Message-ID: <Zq0v0ao6hp2DinXD@DESKTOP-DUKSS9G.>
Date: Fri, 2 Aug 2024 12:13:21 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 21/22] mm/zsmalloc: fix build warning from lkp testing
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-22-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-22-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:33PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> LKP reported the following warning w/o CONFIG_DEBUG_VM:
> 	mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not
> 	needed and will not be emitted [-Wunneeded-internal-declaration]
> To remove this warning, better to incline the function is_first_zpdesc

In future iterations of the series, just fold this into the patch its
fixing. It makes reviewing easier.


