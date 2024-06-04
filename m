Return-Path: <linux-kernel+bounces-200243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2018FAD65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA29D283F84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE21422D4;
	Tue,  4 Jun 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaMDVXjX"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE701420D1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489302; cv=none; b=SZsU4am5qeHMPb0NkdBQa3AgGKgQ2vdmAkhDkY5OsqXcmligxkofm4fYLDH4He+/2vnpGdvILPn+e+bR5SiEKkX3Ni7MfUW2z2jNwHHMqg6OVwHbZwwG9aBIaNhi20T6LNhbtd0CltR8l80iKb2RvQj4Y6O6c5SWLT83Ao6pWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489302; c=relaxed/simple;
	bh=xEmTz73vHv54ArGvlNCXi6ctPWx/IZMfFfBcTS0dumI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX32ugNbD2yf5oM3Q0oxhkjzMh6pkpm631ruRR7Z55duL/kLEvmhGWYShNTc0n7SseZfShKCMQL8ScGZgC1Kaw7M5uaMh2C+n5puqMhnKjs7P4xphpsWoAgotudNZPBaVmmQve6zgpFhVvCfLQwWlR850qd6poGQWddfHXftYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aaMDVXjX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a3d21299aso4325227a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717489298; x=1718094098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TANhGRUXVf1tnEOVOMay5ZJ84risT5rFmO6tGy0VoLg=;
        b=aaMDVXjXFpbNS2RyoVpYzRv7vKplEMWS4nT0MeSbWfaFqRaC6ZKaAO6qSy1vwuVc9n
         b7FManM4jrZT4BSBkekjpTOzAOocEuZ+yn10nfgV/CtQDt9c2mUFpvDHi9MhnpwmPn8f
         s1X13QjfkpB7Tf+KWmxATF/lNvL8TEOTlcbZWCtRv8jFdIc1z/xVOCIPwX+1lJfFSVsC
         E2L0j4EtBK2LB5mfL5vRN+U1mWMPLccOVn2ZPs6YVmoLHUPaBZE1TRrexhEkQA4nhSnd
         GhUJvBPSfOKSKm2RV4rE4JcTmiTj9FPt1yYOjIlz8ROWL57wGYCWfgp2TNWG+4Qbl3gv
         1tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489298; x=1718094098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TANhGRUXVf1tnEOVOMay5ZJ84risT5rFmO6tGy0VoLg=;
        b=kZNyW1VwDiaZOOlUsl44LGohBpcRgJjVl8WxpQvWmMKNLlj+BbPP7eJUSu+5fbDqgM
         thfYXefgV6xHv4y0ZaI4Qc6cMTuLTL0NNtdrqBO5m4PPpB5WeqNlqzf/jTLBQhsF3why
         vHK0/+wloco5CZAchfDrrB1z4Kebc226Px7vXkXmhd1n32Ed4RawLYPw93+GHkMf6tAt
         ljoaRJ/OXdwooiUWQhJywwFCWT0ypfHflyxfUd3R1rp32HTfFK9Em5kdPBF/tRyaDOeF
         WEBPZhh7FwL0XGucYMgmEC60DzDD4um7w1KnUKxVYkhB9NNynIYSkrQORDHubcSNc7t/
         5Bjw==
X-Gm-Message-State: AOJu0YzpZVy/VBlvSUYbbQ2ltWXUUyixh/tfm83Cls50s7KstHPm++lq
	GOUR0vVidVdHOlHzScO32QtYxgJFIzLJjtm4b6T7sb4JYlPXRMqK5Ip58w176QQ=
X-Google-Smtp-Source: AGHT+IEIawn+2ZBZBWVKRH2CiF9Dk3da2NmeyKuGb3+2mSkPfDnBLQSa+jBRzf/qk2aszlGoRqTNhA==
X-Received: by 2002:a50:9356:0:b0:578:2148:61f5 with SMTP id 4fb4d7f45d1cf-57a36448b60mr6977708a12.30.1717489298219;
        Tue, 04 Jun 2024 01:21:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5ad20b97sm4240233a12.44.2024.06.04.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:21:37 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:21:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>, smayhew@redhat.com,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, npache@redhat.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: kunit_test: KASAN: null-ptr-deref in range -
 kunit_generic_run_threadfn_adapter on qemu_arm64
Message-ID: <81d3f794-a19b-4b62-8c21-7c6ef9acb552@moroto.mountain>
References: <CA+G9fYuJtUV_Z4x74qYZDDOkbHP3SJbGvHskFNnsOCxOmPvr=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuJtUV_Z4x74qYZDDOkbHP3SJbGvHskFNnsOCxOmPvr=Q@mail.gmail.com>

On Mon, Jun 03, 2024 at 07:39:24PM +0530, Naresh Kamboju wrote:
> The following kernel null pointer dereference is noticed on qemu-arm64
> while running
> kunit tests with the Linux next-20240603 tag kernel.
> 
> This is always reproducible and the system is stable after this.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

These are intentional...  The function name just changed so it's showing
up as a new bug.  I tried to add a big printk before this NULL
dereference but the printk message never showed up in dmesg...

+       kunit_info(test, "Testing that a NULL dereference causes a test failure\n");
+       kunit_info(test, "*** This will lead to an intentional stack trace ***\n");

regards,
dan carpenter


