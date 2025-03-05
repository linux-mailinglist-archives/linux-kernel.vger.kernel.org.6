Return-Path: <linux-kernel+bounces-546262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A191A4F881
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14271678E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0B1C7007;
	Wed,  5 Mar 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMnrVf4j"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BED1D86F6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162596; cv=none; b=fcmpXHeZY9aBqJJxPdsPG20TNWskSFrPl6yP4hhNOH6JtwQ5KtUZvQZdmpwwNZDA0PBXITzOokdX2DJ7q2Rybw+XRXmd+OEhD3Snjr6XLBtI5AmNvI8va9aJ0kDfvDVMIlsKgv4DFfZ7VNIFbca2U2IPRbwB0R5tTqiHJ4o9nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162596; c=relaxed/simple;
	bh=hQBDaitCV3k+RiR+GDeZpY1Mj7OCsP0w4nSs48d2Xig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0EiC3RJkF0fNr3bxhNiUW2QmcPr1wGYyddLSc/DsggoUm65H0PWZUl97geHiMfTDeFnbwJa8KpqN66J+Hp3AAthKOIj1Bw/aYizxUaqMp+NwBVQSsSRydk+GUY+Txa5vTFEdINCqk3GMe3Vzp54DdhnWq+GTjDlbgGXNnO9Erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jMnrVf4j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so867285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162594; x=1741767394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTJdzy5tZQOPsL+EA/ogn6tq1I6FNzjC1eSU9Wnz1ds=;
        b=jMnrVf4j9h2bGHK/eRsOSXYCfK8t4wziNxdF/dSVRFAgC2N72c8U3HOgKTwou+p30U
         HEjXdkOfp9qx8QVuB6VbAjsFfkVSQUNPcMXroIDBoew/zPqZnFWOrwb+h3If8iNsllR+
         609MLXfoESGvHQrpnnNMafKkTWID9r1PCz6HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162594; x=1741767394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTJdzy5tZQOPsL+EA/ogn6tq1I6FNzjC1eSU9Wnz1ds=;
        b=JztQCkT9tekwQGiiHxDMhizaYbIr5+p36QQUcUcWRUDOHXIWuEUAqPMlPE3UWS0Hem
         UfxrUHEl7cub0tpzpmfD+BmHDfkVeLehm7F7tXSoi+c4Gkd0WObRs5i2MNZqeLagYJKX
         7gJSy+gmOVuA+Ocgwzuf8qygxEYKmTWH1v+80xrxRNhIayirxoFzz0bONGX0knlroMCA
         l3rI5LaV40k+DdgOsk1GkD1zAY4O0fynyYR4TZVbx7QriZ1Rb07hSH13k3JKFpmjOV8F
         z00ycPJBiLFWMyZIAOa5/TLUJ6c4XqiNoXDUSAWWwQd3H9WLu8KJ6PNO49v4/z1mO5ND
         zydQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzn9vs7hYYJ61V3+ZZM94QOD2mvJq4fntCqZKA6kYYqNsK+ak8wlduZYDCUDyGfkT+ZI7oP8CJ24Y/lC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntofEA5Z13crma9xYcIUruSs9ce/SK6snZf7Ok+v200ClLPNo
	qFNzgSS32BCsttRtcSRkzPDW/utom5UT9D8lmIrCzXvG9OpHIK5S92FV+TLRsg==
X-Gm-Gg: ASbGnctfuC+lBAnre2w0cfCl5kTGvnyZnhqBMDcA+Azi1IIkhdoRQmV4J4oGIxpMGTj
	6DKnwsDREZL0Tqkqn670ctY/WPCBZ+cmLsTxH32S/CVEQXSz8f6YfjiZ4blodncv+fwGvb0dZS2
	0a6SY0jwinOQ4w3VfRH9LgFZduzPf9LIA1ZTa8WSoIWjx+AtBFlpcwfV73KxruPzcYI4X8IdlLI
	M9qv231rQtu937rXzmFX3jFMmzy9FxkznME4/vLV8uJUAZKO6vFAETu1Zy36sfqYPTkIsjsDt+w
	7XrPvBc5vbG6ZChAPnCmcAo+l7uoO+O4TuYUUHLXdtdudh4=
X-Google-Smtp-Source: AGHT+IH92Jeo2OSG2Dg7iq1RkP1zK7B+m6EcGipbq2fO6N9oT2opfRYcEL70JNIP/8ozxwe1oCHIng==
X-Received: by 2002:a17:903:8c8:b0:223:28a8:6118 with SMTP id d9443c01a7336-223f1c9bb60mr39254735ad.31.1741162594555;
        Wed, 05 Mar 2025 00:16:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050f5bfsm108087595ad.216.2025.03.05.00.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:16:34 -0800 (PST)
Date: Wed, 5 Mar 2025 17:16:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 4/5] mm: zsmalloc: Remove object mapping APIs
 and per-CPU map areas
Message-ID: <lqm6t6nu2mipwjhsjyxhyuyssqjesxt6gx7fv6bkmf4xoa5jd4@nvyqk3nkqjin>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-5-yosry.ahmed@linux.dev>

On (25/03/05 06:11), Yosry Ahmed wrote:
> zs_map_object() and zs_unmap_object() are no longer used, remove them.
> Since these are the only users of per-CPU mapping_areas, remove them and
> the associated CPU hotplug callbacks too.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

