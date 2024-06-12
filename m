Return-Path: <linux-kernel+bounces-211026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB11904C42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6062F1C2140C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F216ABC8;
	Wed, 12 Jun 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqdCGtUM"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365B156222
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175737; cv=none; b=fmfoGAccu4TwNezt4ztBvMX2z9qiUu0CxuTiHOggkqxo2Wx1mRJ73CW2Q18Tdy9+EO9lUlzOANIn5Jwi/nzg0wm6gCHmPifkhhj3yYJIQU0jhTs2cTPgXJTm7/rDhuNPq11oNAG+cZAswk1NHCJDZ6cnKV4WO8oocvUkcFK4RXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175737; c=relaxed/simple;
	bh=cGHl4+EufxZ89LKo9z5dqDznyW+N/2shccJC6j5SQAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw7WUlzn/PvotqwBPbUnNhuYylC0L8oYT1QlRcK3Z8QLdWqR27CozIwBOp9VWckJ+MI7nDzvAaEKaEiD3AuESoaWl8IcwWi1M7pSzSiotFD/uWLm9mVigCqyhNO5gGNU9LHB/a5o/Y9UZ2kIb2lGwh+KVFysp7DorrO337cxB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqdCGtUM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso69524551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718175734; x=1718780534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/p6w3+gNaauBQl/sapM4GKetZ/lqIHXGxcBTblLfUdM=;
        b=aqdCGtUMTFO5l2lC47fcxo5OIFiTaQC/AMgWTT0rOkZVKCNj+TvSjwaGS6TQEcUuXB
         8BvKNUsgCfVfP+KCBp/iVkNra1GSx+j8reWgbiVTN69H7PLZk8FgxFvCA6iwXEGIWFbN
         XaLEabWo1hWCwzY2qPb668R2YBEmMHaueqvbFFEbzsSQ9gQ2Wjkeka1AXnszHThOMfjS
         1sH/ZMqiCzh5JdqZrRqLEUspFEyNDgSczP2dw8XOHkv86fH3B+2zekplbc2w9du1cYIs
         IzmeUHzq2k8C0thaFBrP2UWC2b6wWL7qczsaJxavm9wdYFHfVS0WTH8URiILwRbq4n7P
         6FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175734; x=1718780534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p6w3+gNaauBQl/sapM4GKetZ/lqIHXGxcBTblLfUdM=;
        b=YlR7TFKFhFJLwRRyMPtRZgDG0cC9hxApEdZ/lu0AFazTGudgqtO6I3Gj7q3O94x46F
         xX+O8dAsKXv6TVaJVsyEbIOeiQHJVIDGAtAkevlRILE6MbFiD/4C2ZwRqMqNtnfW2Y+o
         ju34QE5fscGAZP3BdB5LPOwJUxr3ZBwsW/gP1G5UMOuE/4GPEVF9Ra5/nShkcwlIFnQd
         Y7AgU3l0pn67XulaMpq4HS0SXjcUj9ejm6KBvCeelsTcPBjHJ15h8yvmhV6njPycFmjE
         wvroxYaEmzhFNV6Wx79JaB1A8ZtAJ3YTkkM5JzkeNLlCUKGr4ZDz/axcxGSTat6/gjJJ
         4k8w==
X-Forwarded-Encrypted: i=1; AJvYcCXxgTqgxSNWvJmWsyqRtQXNNt/dMCCAtHJj3IbTABw6kmqWGG9JkgWJQV0+cVO8PUuxqtHdC8IHUnNbIa0cbw8nEB+qf+k15Dpj5igi
X-Gm-Message-State: AOJu0YzsiqynDAS+lqe3V80E7gmMLmHjaM5LaNeDspLgxowOrzZWGPBD
	lAhH+jY0SjmrryDeVdWCfAoFeYiH+Dp1C84bdZsrZxbKiTzpS4lnz8FBuzMXlf4=
X-Google-Smtp-Source: AGHT+IEgvtglgv6iIdEb9puho7aQdqLLatngZHdSOryv9giJK+UvgrPIE7Fc+aAbvQkmSndfNV7rPg==
X-Received: by 2002:a2e:9e85:0:b0:2eb:2883:2941 with SMTP id 38308e7fff4ca-2ebfc964771mr4719081fa.47.1718175734162;
        Wed, 12 Jun 2024 00:02:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa07sm13585325e9.8.2024.06.12.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:02:13 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/24] Staging: rtl8192e: Maintenance renames and
 cleanup
Message-ID: <7918dbd5-45e3-4b61-8bb7-eb8a27a8d152@moroto.mountain>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>

On Tue, Jun 11, 2024 at 08:22:06PM -0700, Tree Davies wrote:
> This patch series v2 attacks CamelCase variable renames, removes
> un-used variables and adjusts alignment issues found in
> rtllib_rx.c and rtllib_tx.c.
> 
> NOTE: Patch #9 doesn't completely resolve CamelCase violation as the 
> correct abreviation of megahertz is MHz as called out by Dan Carpenter. 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


