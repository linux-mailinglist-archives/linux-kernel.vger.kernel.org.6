Return-Path: <linux-kernel+bounces-312560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB2969833
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086171C233A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B901A303F;
	Tue,  3 Sep 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mq0mmww3"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77519CC33
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354187; cv=none; b=s+yjoPhpEYQQkE70D7WinrzlO4Q29mfpb24tPs8JOzTaxRb0FoF2oQKvxE92kmwOfWIYUt5X4oANeZSRiBlQ1MvIbIgpg2I3OrXS88DDWwD/JOut20yq4SMO3x+7XOJQjMUR7k4CPq5abK1VGaQ043lO3W6WpVhY8IcCyTYAhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354187; c=relaxed/simple;
	bh=k3H1YkyDwhln4REHugZO7lAU3gxw7rVDI3sze9tZ+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzGzWxwB4v/H26FTPEcuwUJC8M68MYMab4h88KXGUhkiMGSzWkiNY9D9X3If7pn6szgR4iq5wq31z6ec5IH1cXBTLLhmbYHyBXcHQJSRAXF+aNE4s1f4T48uip0j3IlJsSL6bz5X7bpIDaTSHYCxIOuix6xePqM0SH1z23Rn39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mq0mmww3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso3507346a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354185; x=1725958985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXMjQRozUzAfZtDGQl5kmRCarCMdJrz35wUmsxbqBGY=;
        b=Mq0mmww3DqSrb+Kk/GVbECopf14ddHCReuK1xiF+X2L6/h5vyfAPltGuo7Bz8D1L0U
         8BlgeURenGgjkxm/swXDL94IiZONr89htHfT+t7855R4sy+OwbN4gy4ZBthLjHM/Mp20
         8VGR1DzV6UTQ6NPv1ShBK/4ng9DMm0pvdY4a6qakGXpzk6TcdwQ0kRl1Ac6aIoZVwJ8k
         eohrBgsgEj18h1upBKM4HR9dIZHlpEuv972jLQitAePIx9/P1b4YAySjO4O3PZH2ftBO
         WW1NMdYUMAKmTu5WGtm5i6zZKE+Wok/sokViGrY2HlWljokS+lsRn9saEz+d//sTLyFJ
         cszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354185; x=1725958985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXMjQRozUzAfZtDGQl5kmRCarCMdJrz35wUmsxbqBGY=;
        b=YujnSII4TB1Vjj7pDJO9L35jjwYRpPMyXJWyvuh1t1kL4zyxV3N9fch4DYQWEhL4N/
         KqJYCujQ9twJljdt92QYbMt8JxveFMMYIjwzntUxCw++POSRDL/+LTevCBrjL+Ed0eJc
         2LhTD3Hx8HdsE+CJayghicBGUlZLlVi5a7oe/CcWQEzmt4eYXUMfEmIHXR9F+vgGwzgF
         ujobfNuJgBKBV7GZkbFOVQ0astNoZaHBQ2qk3OrehsTnevZQMsPwRx9yoYsdwA91C+pL
         udoegpUlBoejQLAS8I1JuSJjD1RCEk/Na3x2ukLEeHC3py8bT82bPegg5LG5xtBxiPAn
         NU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyP94nBtSNtzNmVzD3ZT6C1kcKeGoB6x89rJ8yoAFXHeOpum28UhzaJ0z6kjJD4QzPDhxleTpcPxra0II=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEEMj+v+KzoW5ZAkgplCt7vN+0OgJQOMlfx6e5TC3X1gCz6eT
	scWCLtqm8EA3zXCnkP2qkaGQcS2qnQmfiIG+OZKLKjOcqdx7G1aEEyDP7lwJdac=
X-Google-Smtp-Source: AGHT+IGbzt8vUGrEk6tocF11V7cRb1xoAuI7nhEIChNefDbTXr8mJQYLikgxuEKN2ui2+XiiLzZpXw==
X-Received: by 2002:a17:90a:2c9:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2d85616ed48mr19057360a91.3.1725354185405;
        Tue, 03 Sep 2024 02:03:05 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da5932d1ecsm1320793a91.43.2024.09.03.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:03:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:33:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: rafael@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix the cacography in powernv-cpufreq.c
Message-ID: <20240903090302.j7znk6icmztf3dnf@vireshk-i7>
References: <20240902082816.2599-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902082816.2599-1-liujing@cmss.chinamobile.com>

On 02-09-24, 16:28, Liu Jing wrote:
> The word 'swtich' is wrong, so fix it.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

