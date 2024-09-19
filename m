Return-Path: <linux-kernel+bounces-333255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520C97C5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BD284805
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C91990AD;
	Thu, 19 Sep 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kECUarCj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469A198E78
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735090; cv=none; b=eSc/nPQSTg/Gn763GozZHOqaGMcjKYUxxYgDmZQoPnE+dXvvrlBuQmEIcFcFmZ5ApZiqLJ5eVSXGmqKPRweU+apJXkgQ40zRKmRcgFM4JnBgX6u7fjtXjCw0iWby4M2pFd6ohYNKGvtuSghOLKhNpAO2hb5AISUUCBxs10X9x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735090; c=relaxed/simple;
	bh=YUB/0fLcjzGXnwiC4zI1rAwoYYavPrkSnnTvrKgHVVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so1l2j4z9Nn1wELHhYdp647g5ZMLwJHvimZNfxOtT8W21ClvQFDXJxSv6HL8VZDJQj8JDOfzVwohs3HPKTQQfRVXnmCVEfz5n3vVuScf3KkshM7yeiLyb+S0w6oewy4LBkYv6dm+5P+4/Ly8Jq5TT25Pk1EY2IbQHT9s46hxMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kECUarCj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-535dc4ec181so581556e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726735087; x=1727339887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+XA2XAWTlEdnUYeup2c1MqxMCgSg8DqVZ7RmeOX0C4=;
        b=kECUarCj/Gt5cEVNs9xUe8O1bQxsjXZizU/puJ8+tdoVDnXCsLGChdhKe/7+O44GKr
         pLyOfHg2spq++wE4/5fkdJfUMXBqaHWMNYKIchVQvmfchdeOl/5ksBvKqEv/xDHCJgc7
         xXX51MZPCFjhfKj2wMWl/Qetjs+5NVnaoS2f1iKKYys5axcSOsldAjUFWyCpwdcGOuFJ
         91+CugzM1NuVKZxrr2sUqg2LUoC2F+YrawQnhJ7a3QThZsz9UEqXSsq8VDXemPInGIXw
         nBk3MfQy9Lyd1Gyi6boM2Uxq8MwyDVNaN2t/+qNCM1hx1aVf3gbTZrZbVGuun78m0kZQ
         XOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735087; x=1727339887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+XA2XAWTlEdnUYeup2c1MqxMCgSg8DqVZ7RmeOX0C4=;
        b=sYqXbOQmCIaZhBui16cKkIuhrzOCMUNKgxQ/eXjNsg3a1/hS1pc6f7pnHYxEgFisPb
         d00uxo+ODNUUVOEWZTy1sM1l9YyCck0TWSItibqVVEUEJiRK+sFyQgMv/ra1ZXvkXm3X
         G5arocCco3A4cgHCT1I9p/ZK2OAOIm3cxsdea6sxVOULrc6h+c+fZUeKGqVKmYNAeoF2
         oeYIq0zE0oImDhLD37f8aqVegXtIw6DGWZ6Sr3jBizaNE/dsYYfnUOuCTcdViB/id7i6
         7hRPxcwKIQDW1kAfoeDkeCHgoYy9HLz3TgE0/WNuuX+KROcqnBpa5qTJFz4ncaNS/C2N
         6MSA==
X-Forwarded-Encrypted: i=1; AJvYcCWZEaiQp4ETa+2dPX0+84sqrvTfGUOouCaK6Gk3MfkJO9f82lH2z22aV9nvldF5jXILcDrC2aj1qo91fXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+t1KlNjsJPoshSr/EGbIEwtNv5P6ap+2U+DVrx1AVIKA8dDvh
	OdfsNKQUT7uUeA9y4sATq6C0VCJ52Ve/S8YjfPC6AYlPYFVbJotxi+QbiVnuagQU+4k/R/+RLON
	9YM/31RGMJ/9b6L7RnulAYyv9eYTtw1QdgXX9ZA==
X-Google-Smtp-Source: AGHT+IHlAd8jX3MKXVZb3aQKjC/g81iL8wnxQAiPyiHoR+AGu6/IS3gYvhYY5jrJ+9pB346nDJEx10hOjjAtq+yuc60=
X-Received: by 2002:a05:6512:12c8:b0:533:46cc:a71e with SMTP id
 2adb3069b0e04-53678fec522mr14377896e87.54.1726735086540; Thu, 19 Sep 2024
 01:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANLsYkwOrtXxObL5MKf30OrUYB_uT=DnGEXUtfjH503r_LyMQA@mail.gmail.com>
 <20240822170951.339492-1-abdellatif.elkhlifi@arm.com> <20240822170951.339492-6-abdellatif.elkhlifi@arm.com>
 <20240918154000.GA55399@e130802.arm.com>
In-Reply-To: <20240918154000.GA55399@e130802.arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 19 Sep 2024 02:37:55 -0600
Message-ID: <CANLsYkwgNoSnkqdrWYp7JvP3mF4d-h1iO7LtZmaP2t_+R7pF_A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] remoteproc: arm64: corstone1000: Add the External
 Systems driver
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 09:40, Abdellatif El Khlifi
<abdellatif.elkhlifi@arm.com> wrote:
>
> Hi Mathieu,
>
> > Introduce remoteproc support for Corstone-1000 external systems
> >
> > The Corstone-1000 IoT Reference Design Platform supports up to two
> > external systems processors. These processors can be switched on or off
> > using their reset registers.
> >
> > For more details, please see the SSE-710 External System Remote
> > Processor binding [1] and the SSE-710 Host Base System Control binding [2].
> >
> > The reset registers are MMIO mapped registers accessed using regmap.
> >
> > [1]: Documentation/devicetree/bindings/remoteproc/arm,sse710-extsys.yaml
> > [2]: Documentation/devicetree/bindings/arm/arm,sse710-host-base-sysctrl.yaml
> >
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > ---
> >  drivers/remoteproc/Kconfig              |  14 +
> >  drivers/remoteproc/Makefile             |   1 +
> >  drivers/remoteproc/corstone1000_rproc.c | 350 ++++++++++++++++++++++++
> >  3 files changed, 365 insertions(+)
>
> A gentle reminder about reviewing the driver please.
>
> I'll be addressing the comments made for the bindings.

Please address the comments already received for the bindings.  I will
review this set once the bindings have settled.

Thanks,
Mathieu

>
> Thank you in advance.
>
> Cheers,
> Abdellatif

