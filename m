Return-Path: <linux-kernel+bounces-260628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590993ABFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3851C22659
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD741C79;
	Wed, 24 Jul 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k87EGMps"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BD225A2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721795987; cv=none; b=r9WG5MXr76TQag+EiRL6v35iBUqxbX5cnjR26jma2I287EHULAMv+bjFf6+uZzKkX2Ree1pMVke8wLnYrm5ZtyAnrpG7BhsW/oKCkyXlGsv0IhkjviC6+WHnEwE40MQcGpJtK69TCFzyzVBfBHMtw5rf0s2cKjwY1ui1AlfUNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721795987; c=relaxed/simple;
	bh=X2B2h7YCmnQxgWrjlRimRYu68yfNkuWjdFuHQ3lVJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHKlHtu7bQjmBuCBN3OFdI+KpfPWp+P1MfIqN0AGv7e/O4Wf1HXMXaIMpMo0tE2a74LC/e/v1iD6FusS/irbBQczk60FOBRM0PiQ3u4h8BHZcVmG9An2v0gXtkzFF3f/J/UnjRxzRXhoQCBT0zTrBg3fKcNHWWp5er5FSmJG20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k87EGMps; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26119999171so2991534fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721795984; x=1722400784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydzy8AybJJkkCvZrEtKcB+LO2UJxL/0lB3QK0FrhXAo=;
        b=k87EGMpsEIVMh+8VzScAcxlXNGLnnQKqmPsbhR58r3jazUdV699Ge+ox7xzIUFvBwR
         Ob79R3G4j5i+ohtbBuKjpPm21HbZFANSRNMFv5bV0MBaIEBZncuVTwGAeiDj3scsLtb6
         UXVG3p3oG/aOndRkvJ8BNd+5TBF7ysUAMzR/rmlEKv7Hes9zf2tn0UJ82pLOCXU3PPEc
         iTazR39aH3O6e46ZI58Kz2quJzwUPqjQadE4yGFludwpI6wgXV5AImXAMmftc14khZ+c
         NTf4mXS9abqDziWWo80i0mCZ54tXr1AruvUCiZEukcko1RxGlusxp2SpqNBSNNDnJOO2
         SH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721795984; x=1722400784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydzy8AybJJkkCvZrEtKcB+LO2UJxL/0lB3QK0FrhXAo=;
        b=ZjCqOLUf2iEdXYh1AQx6+nV9TbKFt9XG+aVeyRiDvXyJqjLdpDhxlj4xeQyhwYbc3n
         aeQdNjwcWvxTAC6q1TMGVSpwYeS8WSBgfWgvCNrbMad2VjkEXqu90cVjvfExj7j+9vPz
         k3qXqSagH4BDSSfUVNfco6KNVOLZD/MJoIL5Q3isHqhJputUKVX4xphPloGLng5Fdsiz
         n06I6+nTm/QHWzU0G9EeusiGJi0uZd/0gzFh39U+nfrbLOzfwbNcKcW8UpkRrWbgbJC1
         8oaZXXeXPNwIPA3MQkKoKNYPiuDc1U4nbWKDBBhMgP+WlyEIipet5rZNMmTEa7sX4e5n
         Kzdw==
X-Forwarded-Encrypted: i=1; AJvYcCVtHdRbAr+M4W6+NjjB6x6ODv966nUm+fk6jx4KfZ5oONaFXcKn1HjKGfUkfQE9xd6HinJkGdy3sMVYfJXpJmMP0q142YjUaek6RePz
X-Gm-Message-State: AOJu0YzWLG426pwCuKbb7bRGC/1gTpQuKb5uUXKQYYiwsrhn7rO8Rf86
	ZewDe8tytAwcy082ngCDVwlh+SwyZQTfYD5sW+pb2FFL9L3zMJF6ZgClkvCXjMQ=
X-Google-Smtp-Source: AGHT+IFawSrYkpJ5B3GaqjAq4r8y+m8JJXA6riU411Tpew/uqsG/DaM7j/6beI731Cy6xC6aPZPTvg==
X-Received: by 2002:a05:6870:1682:b0:260:ea0c:acc with SMTP id 586e51a60fabf-2648ccc2102mr942284fac.49.1721795984585;
        Tue, 23 Jul 2024 21:39:44 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5527e9sm7734870b3a.138.2024.07.23.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 21:39:43 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:09:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: powerpc: add missing MODULE_DESCRIPTION()
 macros
Message-ID: <20240724043941.5wpa5di7ta4fjyl5@vireshk-i7>
References: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>

On 22-07-24, 10:14, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Per Michael Ellerman updated maple-cpufreq.c and powernv-cpufreq.c
>   descriptions
> - Did not carry forward Viresh Kumar's Acked-by due to this change
> - Link to v1: https://lore.kernel.org/r/20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

