Return-Path: <linux-kernel+bounces-551690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B6A56F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13983B7A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899B22173E;
	Fri,  7 Mar 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ZhrvSr"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0121D5A0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369721; cv=none; b=sQ/pzrptatWk82ANt+l+4yXXufnXSVlCsS16XKZ2OLm0y1W6MNkMHwgkc2eo4WvKzZuUSEy+qhOQhwVsnR+i/8f79yEqv9vQWwipMsXDkTTDHuLpmk57nrISMC69m08w05vTyt/jRAkqLwIeoXh41Dn+qn2l4vjxTz0ODGmncf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369721; c=relaxed/simple;
	bh=L8kvjfaDQkCeD4u3QssJJBc2Nta4inNjIuURRBFJoZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmOOkHX4l+rLAbkKk/IQdKKDwofYyHx+wOMxK/lQ2Abq9MLMhKRWC0Rg72/wJI3Q80O9Zft/9G28PAjvNyuE1ixnIMTsLm+nidlOyOoVArlKfyxDjDZi5mvZ3ws3ruZnM3Zcccycn9RTnd4BZ7W7NnQn/EKphSpzbJR4mnGpR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+ZhrvSr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234bec7192so12956285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369719; x=1741974519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRufdviAnmuT6DteRbLHEBa+gV4tGFtrU2SoznIeeXg=;
        b=V+ZhrvSrAWp/ClK8DFhwKJNlNg4iZTNu0hkl7LkEyCn3xEBFHLNwsd0+Kh16GKRVhJ
         7g419moBF3XBLjjKWJ9ETHmjVln+zpS+lwMB2R3qlPoLKARUyMhBdQs+WLjlOVDAmXB7
         PiQdk99pz4/nmmL6vmP3kJ1MxMsMpnJAQZcDgUKTY2dVQRSl1wq/FktFuq9w4S1WSHEQ
         K9AHSSLg7D9+QZ6fmcQX+Z+zjT4tJUGpNktZVLTwM35zWq1BS5yVF7Udgr8Dfi2A1ASS
         oM96gCOZwgITGlRXiTtzi+5rjQY0TqY0Drc1Z2kwycYRUnilxv09KkHH6y2W3TC0E67K
         OAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369719; x=1741974519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRufdviAnmuT6DteRbLHEBa+gV4tGFtrU2SoznIeeXg=;
        b=XFyrEG152tdGt87W14ubV6fppO4XXTOqEYjI1raVKl+elQu8ErkUxfeuaV99b2fmIG
         Nlw8Mp3dKoiYNTi1lyW3ElIOXb4afr7YY6huU6q2QOuIdk044NqmVthmeImyAegF7BkH
         dVxv0RhgqjmyPqas9+YhuE3brG1aJ2RCQqyTelRlN6eIei6T4ovrT7KtgRNprSc78jCu
         pDCKgBe8zCd/8/rN6dY88HxqtyaY4nhyT3ABTIy2YRWThscSgAL//vac8N+zEn3k1Ba2
         qSmwk/OSOt1W2Cy6/WYoPWhuI47DbOSUWGYItZxBIcjolO7f3R5W15jj2N+3u08DoCij
         AViQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsEaEA0S5VDY81H2nHcNRbTIOpnQqw+UuQWRKo8ozsuHbGQUScaBO7/AO3ZjDceueNzjoi9WoFPUkBWXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL14LPd+Fey+aNC9IDKliz7E6yGDLQT6HHUKhZaWHtYv4fsg7H
	D7KUuLGAqI3PJd/gtcIQSDQpZ5V+oYox6HZOU0XrznmMfMkHthu6
X-Gm-Gg: ASbGncu4KNybRsZ/U7fzSfsPTHxOjSxa9f8m6lOOhEoMztWFWPcJoXfUqC7WCR3j2s5
	T5JMpmITemsZAvYwYJvZFCPkVsUWihOwK9LZ46V1EUq4y1HDCUieeEU+tXfG8FtG91kHI3ZUnax
	YFbIVorUePEZ3YQOzboepGPviMt3halAaHiOwhSO5d5ZATNtfDvqAJYOySmaGMRLO337sHbgenT
	dELQL70j4IU7pgBnhXBPDbjY3cAMm3hD4ZmNkA2H8JFsfFC4Az9sx1X0jnccEK0Vu3M8o9bFPob
	Bij0ncfrKxc4VEhJpXFH4fJbgkiscN8nnCN96AxAKR5h
X-Google-Smtp-Source: AGHT+IEjZU9p4DHsi8ki85oRnVlIV3neE5cWyioPrK7kaRY8hlLWs1+CZSrq8Ll4+I1znDxUmj29qA==
X-Received: by 2002:a05:6a21:10c:b0:1f3:44de:6190 with SMTP id adf61e73a8af0-1f544c93787mr9937505637.36.1741369718923;
        Fri, 07 Mar 2025 09:48:38 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810be5aesm2821781a12.34.2025.03.07.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:48:38 -0800 (PST)
Date: Fri, 7 Mar 2025 12:48:36 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mailhol.vincent@wanadoo.fr, Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 0/7] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z8sxdOjk3LksG9ky@thinkpad>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <Z8sqSpKZzfolKm8Q@thinkpad>
 <Z8swXUGf9rtTHw1o@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8swXUGf9rtTHw1o@smile.fi.intel.com>

On Fri, Mar 07, 2025 at 07:43:57PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 12:18:02PM -0500, Yury Norov wrote:
> > No rush, please allow your reviewers a week or two before submitting
> > a new iteration unless you want to disregard the previous version for
> > some reason, of course. This will not get into the upcoming merge
> > window, anyways.
> > 
> > So, what should I do? Go through the v5 and all discussions in there,
> > or just jump on this?
> 
> There is also question to you. Are we going to leave with U128 variants or is
> it subject to remove? If the latter, can you issue a formal patch?

I asked Anshuman about it as he's the only person interested in it. Will wait
for a _usual_ few weeks for reply before making any conclusions. If you know
anyone relevant in ARM or everywhere else, feel free to loop them.

