Return-Path: <linux-kernel+bounces-348759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4498EB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209241C22634
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E213B293;
	Thu,  3 Oct 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8mNTP4k"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E55126C04
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943988; cv=none; b=sVe7NQekeUiU5Y9NwfIMqNjzJfGSkaUj0bXtwu6WDSeIo5yb3f0ymnqoOzV9Ab6FzfGl870eDcN3leSekjk7A21hkIngTbdTo87kHuTPEIprB5Jcx1yyUv5LB5V10zVgSsGx2qrtFOXJuFnRZNyJS/3L3EvQ2Pn0XRJwlKa2q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943988; c=relaxed/simple;
	bh=qpmQRQnZVx4EfuDI1N8bbR6dr9ruiPizqO0zs3iQE5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpeF6Q3CUvpLvkCcLJWhKiqH4sXwefTfGSf+ZSb0qxHvgln4XEtgM1Xxm8DIwtoGeG8/goblBsXb+aQHNhiwm55Rk1kMODys+6UJAM1GT5S6WpzqiFBo8JPJJtCUHUPi3RXpn5vC2dt1Hb792HgB3dy68xxZpU7wshSQ52VIDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8mNTP4k; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d446adf6eso105671766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727943985; x=1728548785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIkfckMFbIPCSll9im3PPNKoWBW2ZFT+VlD9hhSYw74=;
        b=x8mNTP4kgaC6i339m+RRlPD7d+8IHdfsROiEpcm/CaT+euGFzMrCbgx6qjcdV3pmqB
         5uqn+dH8YWe+NIQQWZMd/LElwi/2thiFOJIPikWya/b+1VjAEsn9DKxlJPDqewSvLbTl
         e5c9WgYvMLPHQ/aT12PKra/UEf9tlZlAar1FGASBhuyguiTDwdZvwWSGXLOZjROsr2eD
         k0GlZveem2enzoCY+oHmacSedMS7aLrnSOkG2VwkOvkimSAe3CvYtfcBTxTsD0/u10V+
         TgBWK/KpER/SMzHZ+hcSuReS5yPAxgWiLwkyzNnw1Y9OCXtPAYHvjKGZR/6RDP5bgOp9
         X8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943985; x=1728548785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIkfckMFbIPCSll9im3PPNKoWBW2ZFT+VlD9hhSYw74=;
        b=fWTZAUcvnoBgaxvVLA/GNbcAnyUQmDbwGhRIoB133paxXuAFYerNNO621bUuGfiqO/
         qONvcM9rulYDFuEjhCFwERJQX2WsJKtB1AWeiMC26/Nz7CpHvE1Oo06bLAC+HRylEQpN
         uBojnEBujG/9hgT+PtJKpdlzfgfnSN33cZ67ZyC1NnJIaqVjaxWla1h8gg3g0QdUZNaf
         3e5unOhM75DpLw9LuIWLPs6duWbboMhx8ArUIczOyTSA4D7ndyZ3GBcNjwi7nD9xK169
         sVlBedhP9g2mXfWxoBWdMsq6d1HLQJBgNQA4ORPA+F6Z0078qicN1UyjmUuHZqw/P9Sx
         S56A==
X-Forwarded-Encrypted: i=1; AJvYcCUCLW8/iXLdele/zXB1lnVXVH6zDHxrc1EXsMwLYJO3A7E3dTGy8Q13cp5+uR7pK7vft/+/TRZvUZHR2ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YysavWdznuGljjDZ6iQqvAJvzHCXjYhZZcV+BnABHgo15plTMSr
	97GfkCqV66fz8zUwWQDsxrQHGFPcfbzVcdVv3zQaO1qzS0nHyuyBuBbW/r1YZA==
X-Google-Smtp-Source: AGHT+IGoT5e8SeSMhvriaqzDRfVA+BAT+7tDzEyfBnZ2lwDQgQJLEP43iMWLAH2NV6uqBLAD6Gd8Pw==
X-Received: by 2002:a17:907:7f06:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a98f8234533mr516452366b.20.1727943985031;
        Thu, 03 Oct 2024 01:26:25 -0700 (PDT)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a359esm53436366b.6.2024.10.03.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:26:24 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:26:21 +0000
From: Quentin Perret <qperret@google.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org, qyousef@layalina.io,
	hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zv5VLXVr5oYsABED@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
 <71e7e154-584a-4856-b906-ba92c636b17f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e7e154-584a-4856-b906-ba92c636b17f@arm.com>

On Thursday 03 Oct 2024 at 09:15:31 (+0100), Lukasz Luba wrote:
> BTW, do you know that if you or anyone wants to improve the EAS/EM
> should be able to provide the power numbers?
> 
> W/o the power numbers the discussion is moot. Many times SW engineers
> have wrong assumptions about HW, therefore we have to test and
> measure. There are confidential power saving techniques in HW
> that can be missed and some ugly workaround created in SW for issues
> which don't exist.
> 
> That's why we have to discuss the power numbers.

And generally speaking +1 to the above, it would be nice to have power
numbers to motivate the series better. The hackbench results are nice to
show the limited overhead, but they obviously don't help evaluating the
patches against what they claim to do (making better energy decisions in
feec() and such).

Thanks,
Quentin

