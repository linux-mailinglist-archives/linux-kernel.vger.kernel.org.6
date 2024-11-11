Return-Path: <linux-kernel+bounces-403567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D579C3747
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C39C1C20B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867E14AD38;
	Mon, 11 Nov 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTijIKye"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F81145B1B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298284; cv=none; b=IFxLqXubrTSfbmzE4tdfMNIs16t9bW5LeBS9QrwCCXX8jO4xI7MQ3oQUuxWhScZmql5A/XBaiGXG+clKWAgvoSN45W3WL5DgRf3jWI2Lt8C8GflMFe9Zt7ePXEZq9seX87jGea/u5EkcraqJUo04P/cbnixJlP/etwgwjPpEzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298284; c=relaxed/simple;
	bh=9O0Ab0snlQqU/aOeDbp4uxXowWB39iX0K9xXwo2W1X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRScw+DgL43TiCFnC+Br4cFnGbDtIJjktKil/nX48GPS3UrJopDdi28/MVxbHIRfsfr0/Cmql7ik3hVaLpg0VEoo8cv+S8K2Q+Y+KgZCxNlVkYYdOTrrBlRf5WJW4sRuTsf7L3JonIbexO8sI3CkcGHnm9UifidXXm9xqfnde3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTijIKye; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf6eea3c0so39409675ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298282; x=1731903082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYw7alURWqiNGBAIOXjLelZmQpmzN91EzRD/rQ4H6Os=;
        b=JTijIKye1/ugqJC0nOaDzksUGH7PJ9IJePpm3Prq96Ne+vki6+BACRiXZ7HkMV84wE
         DW9ZHLPZ8NGXwYX8teafbgeiPBQIaGDtYb1wdvDC2GdGXknaLgwiOY3464fvEGUKaJPF
         o0N+oceLhK4GW1H5rWly0JKyC1uQkHnU+tlOl5tYDmyhNUf3rer3oHsZP7YwxAiKypnW
         KHAZW9ePJxBzZ9Y6wsg0aZo05BdevGBrg/Gz0/cDOAy3YEtC5DF2qLHkfGCIGJIl6rbw
         1sxePsXKUeEP2tjEtLlPrcKW60yvGVy9K4rhvQj0dyxonxDTfYgqMk5eo8gtD+ARByAe
         dglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298282; x=1731903082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYw7alURWqiNGBAIOXjLelZmQpmzN91EzRD/rQ4H6Os=;
        b=WUFXDUfTjwVs6mGyayh/COrVyGpq+VxvEBhWFRM8VwZSopFPmIF6TafcIWZl3v7grS
         U5lQQwvNE2GyKdtxneRFcWJVPqzY/V7VUPR7Q14sO0Js+fbB/Z7qdy1r1OG340cyo3TF
         P1HrXm70KqDwMwcUTSIZxYlbYitWucMr4O+Byq99KkOxAhj7kjR6EcdpUJLS7NTpoA/z
         lmeeCxhy1+3o6kxigFBYw2UP4hXQ9e/XHDG4YJEtpFxyO0v6wUXAErgrpjBkIBi3Vg87
         HREUMGyT1vYMQnHrifL4/QBh+iJoVY5qwC4HfBMDk0/tuOcDK5TLPM2jxvmgvRr895LQ
         R8MA==
X-Forwarded-Encrypted: i=1; AJvYcCWwdrgCpfKWJOqmYPZZ/wls8mMwYA1dfZW8ILaqurLQg6fNzmKHhF2FhRhUKgrECaWxvuq+PJHdkvvT6RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMZCC9ynGAPqL6DDTy9W9PeT+kXK4dHh69GRUfLkEyLU04ovj
	HgexYTqC1klwtqJETG23syAEFqlEqbxVoUSkYD6sV1R3QYbnhpuH1p6ccroy8Dw=
X-Google-Smtp-Source: AGHT+IFRGzEI71Hdu+luB1BFZRo3jerd07YG2aEwXqJww2mjVFtZo+80VCzdP3gEwUJj6Och9TmB5w==
X-Received: by 2002:a17:902:e750:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-211834e6e10mr139163805ad.4.1731298282609;
        Sun, 10 Nov 2024 20:11:22 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c343sm66805845ad.241.2024.11.10.20.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:11:21 -0800 (PST)
Date: Mon, 11 Nov 2024 09:41:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] cpufreq: loongson3: Check for error code from
 devm_mutex_init() call
Message-ID: <20241111041120.olx5xcwo6pom5enm@vireshk-i7>
References: <20241031134719.2508841-1-andriy.shevchenko@linux.intel.com>
 <Zy3Za5JvLjk-OYjp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3Za5JvLjk-OYjp@smile.fi.intel.com>

On 08-11-24, 11:27, Andy Shevchenko wrote:
> On Thu, Oct 31, 2024 at 03:46:34PM +0200, Andy Shevchenko wrote:
> > Even if it's not critical, the avoidance of checking the error code
> > from devm_mutex_init() call today diminishes the point of using devm
> > variant of it. Tomorrow it may even leak something. Add the missed
> > check.
> 
> Any comments? Can this be applied now for fixes, please?

Applied. Thanks.

-- 
viresh

