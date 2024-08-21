Return-Path: <linux-kernel+bounces-295961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4066195A3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733A61C222E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8A1B252F;
	Wed, 21 Aug 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upk5xP46"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514D1509A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260353; cv=none; b=Ortep14dX7VJ2NUrlwpOqiO+3GbHjcznLAgFzcDO+v5uo596fwJRzLAdqYQB1fbmp2nQv0UejZlwkgksYCJK5NOQBYdv2n2EQ9Gx2lvXyFpoal+Jq8mo7mEiL2utv7y/JHVC3szpZ/F3L7Zbce/bJiA0kLlBgNn4HaQYkQA8AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260353; c=relaxed/simple;
	bh=8AMj1gQbdOy6mzRKOvisGTOPkhNd65sI4xgr/VwrPjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ0M43RkL0cBhnMw8PL9KHP7JxbvMQhLluV7meBhK/6o9sSxT5uLi0evYKTUCFQiUu8fGGo8Q2mQn+lPjGOATtM4UcWbOVv4nTLrGLeQVkiGyu+EWLmAbaC8eZz3s5+ABAEDS2RMrzDoI+pYQIrvu4+ct+nw74n4jHI47oR4348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=upk5xP46; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7143185edf2so108830b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724260351; x=1724865151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PGuIX73MOWMnEgrAGHe44EShZU2W6VwRhKHeC2K7JU=;
        b=upk5xP46OfEFNNtH3SH5yhTKqD57K+7FyHr+IV0pyc6BZcvM+A17QmRF5ESdc8eZOy
         urpf6pmCGrdNB3DtXMbKpl5nyIbmpCEZ5eeqxV60uXWr8SmH8Bkn5/SdbrwHG8v6ZW5U
         rP8Rm2Z/arH6YmE6zk0+iKCq26QPe5flVcbPh1dmOB5mjK/VxnhSL88EYbdRCna+DMr2
         G2vdCvMj9154bHR21mnFQAnVgSmSs4HawEpsbR8/4HUy8UOt8Yfks4nAhtAmgFhfB8fQ
         PYNCCBemPFSc5jDp9mxYSIz0NoQ20p35Hw8CqecRUZG4rJc9tiwy+UfE8YFNrbs7V0Il
         H7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260351; x=1724865151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PGuIX73MOWMnEgrAGHe44EShZU2W6VwRhKHeC2K7JU=;
        b=QSKGbR2KIIZzq246qbvCpQnbRUyC4Xt21PZimOgwBuB7RAWfgOAEgjrXRya7UGL+/c
         SUTntxURLw9YFEmFppOn2DQIcSAteUF8p6W7j/GUVfc7Ux1I6zci2EqKDbxnNYhl5tYt
         sGs+nQ8xTf2bE7HKpqfau8ZFKQ5UcNNjlhftVl3Cbb+OBzIsvFc1fEhmgARhwfQc6Liv
         tR77hPDqq+CupPXff1IPyHTPSbEr8YGbq6GiBiE7kYiFU3upPYf+6Es7vGtYp69buya1
         TOcEzlzFnz97dIVkWR2Au8so5hhL5qT83riS8T0oKm02Plb1h+RLh/w0DVc4K0I5YHU1
         b32A==
X-Forwarded-Encrypted: i=1; AJvYcCWnQySjvGjypQ/syF2SeD7cAe5bjLVZ53yo2aWOn3JrWHqTbvuhJsxY6v4sN1GKC9vfkwy8tPkZGSd7v5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNc7NmdGpM6fDfuzAJT6vNJ+65Lfc7r1aKCJC+w6c9PvaicxMQ
	2KYk5HHRhjijm2FNHgN+VYW8VJBUyaMLKLWJCO+bfPei4f0cxuGQwR4wQQWHggM=
X-Google-Smtp-Source: AGHT+IFahu5nhyR9APNX81eGWYDvWGW2BXzcpC6njxXplKlq16tD6UzEgdsOMomgPVvunvzQIx/1lw==
X-Received: by 2002:a05:6a20:c916:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1cad818adccmr3000160637.53.1724260350919;
        Wed, 21 Aug 2024 10:12:30 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:167e:272c:2858:d319])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7142e28d8f9sm528460b3a.70.2024.08.21.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:12:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:12:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hari Nagalla <hnagalla@ti.com>, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/9] remoteproc: k3-m4: Add a remoteproc driver for
 M4F subsystem
Message-ID: <ZsYf+yR/SWfb97Ya@p14s>
References: <20240802152109.137243-1-afd@ti.com>
 <20240802152109.137243-4-afd@ti.com>
 <Zr4w8Vj0mVo5sBsJ@p14s>
 <Zr9j5HBjRqqRIoaD@p14s>
 <e5140426-7e69-41b0-858f-16f83eed871a@ti.com>
 <ZsNlic5EbQP2BdFB@p14s>
 <f529c5ef-f61c-4c8b-a589-652aca162f07@kernel.org>
 <98d65c2e-f5a2-4894-b76d-6fa0fb8b6daf@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d65c2e-f5a2-4894-b76d-6fa0fb8b6daf@ti.com>

On Mon, Aug 19, 2024 at 10:54:11AM -0500, Andrew Davis wrote:
> On 8/19/24 10:39 AM, Krzysztof Kozlowski wrote:
> > On 19/08/2024 17:32, Mathieu Poirier wrote:
> > 
> > > > > > Please remove.
> > > > > Forget this comment since it would cause an error in __rproc_detach().
> > > > > 
> > > > > > Other than the above I'm good with this driver.  That said I can't move forward
> > > > > > without a nod from the DT crew.  I also noticed a fair amount of code
> > > > > > duplication with the k3_r5 and k3_dsp drivers.  Dealing with that should not be
> > > > > > part of the current work but will need to be done before another k3 driver can
> > > > > > be merged.
> > > > > > 
> > > > 
> > > > > The above still apply though.
> > > > 
> > > > Me or Nishanth will pick up the SoC DT patches via TI SoC tree, once the
> > > > driver patches are merged. Feel free to ignore those but queue
> > > > dt-bindings (already has DT maintainers ack) and driver patches via
> > > > rproc tree.
> > > > 
> > > 
> > > Can you provide a link where the DT maintainers have acknowledged the bindings?
> > 
> > The reviewed-by tag serves as acknowledgment as well and the binding
> > patch has it. Conor gave it on some earlier version of the patchset. I
> > did not check if there were any significant changes in the meantime, though.
> > 
> 
> Was reviewed in v8:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240424190612.17349-2-afd@ti.com/#3302840
>

I didn't notice Conor had joined the DT crew and as such was expecting something
from either Rob or Krzysztof.  I am applying this set.

Thanks,
Mathieu

> If there was any significant changes since I would have dropped the tag.
> 
> Andrew
> 
> > 
> > Best regards,
> > Krzysztof
> > 

