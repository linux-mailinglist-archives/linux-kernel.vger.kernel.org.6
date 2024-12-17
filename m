Return-Path: <linux-kernel+bounces-449881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C89F5755
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E33516E276
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48C1D9A63;
	Tue, 17 Dec 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6YNXq9V"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53717BEA2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466060; cv=none; b=UuLz5A5kI5WdlRrD4SHgNzXU+zDUlo/naTsJ+uQLMW7jS0xzIxEFLoedBj1Ke25PyQC+sp7vDe0apB8upB5g/aFW0JvHg7ONrVVGzvpM8N3fYdekZJHr5L6ui6acBNrl9r9H/xiGmBqVtnBcjtPu+19EYEV+EvwT7flzrG8plP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466060; c=relaxed/simple;
	bh=vEc1kt6QDRRXv4GZYdj6Sm4aviyn9+KMpza9z/OtbdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzXkzkMmz2YiuOhlmERp25uhVuwxU6EVKRSgr/JUs3yi2k1ppnC9cF7aWAiI4ggw//5YvnoxdFFsem4U9hDt/Eb7dgsqe4uDEz71WWD8dAT9iSjoc33OFEETaPCQ1KjpYMibodqDbp7vvu7e5eTFAb65QgyT7WQHiGxnFu2ZAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N6YNXq9V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so9534804a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734466057; x=1735070857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QDxIqoOVZBeBoBYUpdpckR5+V8/ZMoPY75T4kvZXjg=;
        b=N6YNXq9VCpaGeeWdg4opOCf8Uue+3vsQX06aKkQIwMCyZsHpZAcpUZIjAG6cA1KCHz
         bo8SaY7ULVggZg1qeYAV1zn/raaD8bOwX7C3dmo614A1fERRFIdevcBGHP3FF0YvaviC
         SLS7uvwSzDkFP2gOEWYJx7d1ZDgsxuAM5S+4jSN9sTD1KgMClPgIZ3HEjkfOh+y3Do+N
         BfbidBbkeYWCuISdnrLZB5SeJluDZTWNHV8rqenZEiILj1/FUbp4JRoNpvFUU/S6kzIr
         jylyw9vuTcI5WeW5SBh/qn6DacAmKxzKfcaRm4S1fJjEjzGmqbXk0sEMFrr6GysDVW6I
         4oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466057; x=1735070857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QDxIqoOVZBeBoBYUpdpckR5+V8/ZMoPY75T4kvZXjg=;
        b=hA2M7SN4NJTBIGZmJJcGs+J2TLvsEo8n3D6AV7DEkzyDqr3FygWZQ+IpQcuFq7Nsdc
         juYjdGrsIRqYpBj4b0Zs4BdepCQMJoJ/w8SpU/DpWimivhjhsEjzaI97ZiPJ35jMfEej
         1DTPGAL31GlfUk9RAJjCiGjUWva3jzDrhrwwO+IebVsRjJ680bOjqEIh1jqYz8XIUF+m
         Q1tyxb1iCHW7YTP9rPNDSwgnlRtvVmuPe3wWEm+sQ1q+HCEFG5xSGeBjcZnWsmNsGVkN
         o31arU+i3JjHj4cACEaJnzC4yi44rKd+i95/aVoSaVXQ+lNFZ74m9ZCgbn2j3QmwOWwq
         vU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXspBJm2ElQfc2UJiphcSlZj8aRm32Xa3E69G1LEUEUxjj3a7bzwQzPfzxEA+WX1Xz/LLDRz+bumNWTupA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBe7SnYeYHAQl0Xt5+7UPLIKcO0fXoexbmtrTUeQZAtVDH0qz
	+1jBUVhGkWKZvH12q0jT8XgzGG3sf6X+4UsggJjLytGJ+w/5S+tfVEKnQiaHifxIrfLKtisBMEr
	N
X-Gm-Gg: ASbGncuNVF0y6aDf7J1hYSJaRTzyG6SCq9xqem7ESwjxFZ0NOIdrPLa/0Eggbs0gVSL
	pYjJNgI7etMZhSHmUaMNFFtGib87q1+J8U79az+TN209aiY+7rTv//k5RFMBlKKRduuh825SEAR
	csPBsqn4YERWv6gFabZFbCyl+7d2eCrUDuM31gfBHtxjixbPNsrvYlWFxpt/PWZvGf8p1TiHeAz
	GqwqKwAC0iBZ0pN6k4IryeK3BmZuMPy94qbryjS4Xdiz9j/EpWSOFIQZphVGg==
X-Google-Smtp-Source: AGHT+IF0ctSU7tlRy9ZkNJBTwZZVTMJOgOzLKCAl5fTg6inVF6J1UBzDEgqo98gERo5xi6Qqj3Z6OA==
X-Received: by 2002:a05:6402:13d4:b0:5d0:bcdd:ffa1 with SMTP id 4fb4d7f45d1cf-5d7ee390546mr302236a12.2.1734466056757;
        Tue, 17 Dec 2024 12:07:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25a39sm4619633a12.69.2024.12.17.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 12:07:36 -0800 (PST)
Date: Tue, 17 Dec 2024 23:07:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: smatch usage (was Re: [PATCH v2 4/4] net: mdio: Add RTL9300 MDIO
 driver)
Message-ID: <c5bd368e-bd4b-4001-b612-b5293a8b2c1a@stanley.mountain>
References: <20241216031346.2626805-1-chris.packham@alliedtelesis.co.nz>
 <20241216031346.2626805-5-chris.packham@alliedtelesis.co.nz>
 <20241216164814.GH780307@kernel.org>
 <cf77f08d-0516-4adf-a701-9589f0d99eb5@alliedtelesis.co.nz>
 <20241217103509.GO780307@kernel.org>
 <c656bd3f-4ad0-4c2b-8d91-1c81f7e41c52@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c656bd3f-4ad0-4c2b-8d91-1c81f7e41c52@alliedtelesis.co.nz>

On Wed, Dec 18, 2024 at 08:40:08AM +1300, Chris Packham wrote:
> (culled the cc list)
> 
> On 17/12/2024 23:35, Simon Horman wrote:
> > + Dan Carpenter
> > 
> > On Tue, Dec 17, 2024 at 10:47:10AM +1300, Chris Packham wrote:
> > > On 17/12/2024 05:48, Simon Horman wrote:
> > > > On Mon, Dec 16, 2024 at 04:13:46PM +1300, Chris Packham wrote:
> > > > > Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> > > > > switches with integrated SoC. There are 4 physical SMI interfaces on the
> > > > > RTL9300 but access is done using the switch ports so a single MDIO bus
> > > > > is presented to the rest of the system.
> > > > > 
> > > > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ...
> > 
> > > > > +		if (smi_addr[0] > MAX_SMI_BUSSES)
> > > > Hi Chris,
> > > > 
> > > > Should this condition be
> > > > 
> > > > 		if (smi_addr[0] >= MAX_SMI_BUSSES)
> > > Yes. You are correct.
> > > > > +			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n",
> > > > > +					     smi_addr[0]);
> > > > > +
> > > > > +		if (smi_addr[1] > MAX_SMI_ADDR)
> > > > > +			return dev_err_probe(dev, -EINVAL, "illegal smi addr %d\n", smi_addr[1]);
> > > > > +
> > > > > +		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
> > > > > +			priv->smi_bus_isc45[smi_addr[0]] = true;
> > > > Otherwise it seems that smi_bus_isc45 may overflow here.
> > > > 
> > > > Flagged by Smatch.
> > > Sounds like something I should start looking at for myself. Have you got a
> > > link to share?
> > Hi Chris,
> > 
> > Smatch is here: https://github.com/error27/smatch
> > And my usage of it is informed by
> > https://blogs.oracle.com/linux/post/smatch-static-analysis-tool-overview-by-dan-carpenter
> 
> Thanks, I did find the repo.or.cz mirror and
> https://lwn.net/Articles/691882/ after I searched a bit.
> 
> > 
> > FWIIW, I run it usking kchecker on individual source files.
> > 
> > I've also CCed the author, Dan Carpenter, for good measure.
> 
> Odd thing is I can't seem to reproduce any error report on my buggy code.
> I've tried `make O=build_smatch CHECK="~/src/smatch/smatch -p=kernel" C=1`
> and `O=build_smatch ~/src/smatch/smatch_scripts/kchecker --spammy
> drivers/net/mdio/mdio-realtek-rtl.c`
> 

I wasn't able to use O=... with the kchecker script but if I call make
directly then it works for me:

make O=/home/dcarpenter/progs/kernel/build/build_smatch/ allyesconfig
make O=/home/dcarpenter/progs/kernel/build/build_smatch/ C=2 'CHECK= /home/dcarpenter/progs/smatch/release/smatch_scripts/../smatch --project=kernel --succeed ' drivers/net/mdio/mdio-realtek-rtl.o

regards,
dan carpenter


