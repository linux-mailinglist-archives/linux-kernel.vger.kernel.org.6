Return-Path: <linux-kernel+bounces-201369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35988FBDA0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B267D2831E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FE14BF91;
	Tue,  4 Jun 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaBz1gTQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05714658E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534539; cv=none; b=UDBaVwwIR673EpVjGcSF3r70jVqW8e/ki0Uqy/z6Cf8/+sJqk5WiTg8WcWnUiMwWlPm02iGPzJVJOeDqTc0fTuDSGHfLzzADp4C2kbvt5uFHYdtkoaQJawPynj1BaiQrXJyue891DbA0gVT+0Mnr/Va3HlgpEBx3BP+OcNlJjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534539; c=relaxed/simple;
	bh=gpaz2Bi3HJsVOuTsDcwBI7Dpk/AZeaZi3wbvNAUKuOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZHVJE9XBphCGcOWOoMgbGccis1NUYP3q2iUuq4tXubShA1s7loQUojvfwoXwDarrvVWsrMnAFHO5rcQYxY5OwrVF7tWLU+X0IjIt7nW8l5zovYTPncc/g5x4HY+AVkIer4LoCbogPGlE7qVFahtFdcMuVoVXZtRpymjJw956Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaBz1gTQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c199e37f4eso4905144a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717534537; x=1718139337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gg64iSqr/mSckukuwBMpxoYIpWAZsVrZRfY9nsLTW3I=;
        b=gaBz1gTQXwE24I9p0+gBpm3yVLzsG4On/UK25snBCD5PhIgiGNLkYb933AuSOnJAon
         KrMPyVOVlO4i2/wMhtVzmm5wZDrfzfeantb3B3NibW+2Wrlpj9AZ5Pa9ACXh+QLTFde1
         cakN23cBrBW6Lo8sh0VZNy82JQ+m5rve9B2TNwkBH6i7iDO+IWhUujF5xUwRjtEB8P8n
         48TSoPpfFXO/PCCwE4C1il0R15m2yjH+J34OXvRx+Q2fJcMGf3RxYfj0roJSu3BxDRlr
         bRg6bGSgbc0Zlhl2Cp1tSghPvhVdLno4wCLDjBuKy8MN9fH911o1pFnXg62qbyu2PEuX
         CZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534537; x=1718139337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg64iSqr/mSckukuwBMpxoYIpWAZsVrZRfY9nsLTW3I=;
        b=fHlASco+KizI5h9dM7s8+D0K453eTDWiT4nFY5Wgx7rXqLuvxh2v9y/yQCL9PlN3TA
         W8fqb1RoJ1XdgZi6l/SlzRvICdBqqa6kgRJnI2CockmLPI/Kdx3qJzwu3C/a9yYKwcN+
         Lx/u07oK+wHIt2qfDaye3m2iyVoYSlupnVIK+O7rsawxRXDe6Q0S2EUOUA1n4iDGd6z3
         ktojMH1EqJe1LyUCuH2eDBm5XxOHF85dUMV9vMImRd/TqV+nzAoQLuSwMS8uHQqvhd6j
         ldQl1sPBl4x/De1Mv13EYvUpMsCd9lcj0qAHBrPNDkd14a8oSxevmLa6vNnQ+Ji7FYa6
         qTaA==
X-Gm-Message-State: AOJu0YxKi8T7mqrwFYxW+gAvLhC7tluaC9H2y7JuHgXof0SE/S5iC/ML
	spU9k+gQFHTV821Ih7cpwTgCYXujI28UL2DXI8s5FAPrIn6LU6Y/
X-Google-Smtp-Source: AGHT+IG/EKdULu7UeAXYvOs5ahcKDN1nSpIX8FTOreWaAGwF1DhB+zu48b7Oh4amtkH08MATpZ6Ofw==
X-Received: by 2002:a17:90b:19d3:b0:2c1:9e98:70bb with SMTP id 98e67ed59e1d1-2c27db03e19mr601204a91.10.1717534536856;
        Tue, 04 Jun 2024 13:55:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1327:f82:3fa9:728f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c2831aefsm8607421a91.38.2024.06.04.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:55:36 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:55:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/interrupt.h: allow "guard" notation to disable and
 reenable IRQ
Message-ID: <Zl9_RsKZNYPpmGJ4@google.com>
References: <ZljAV6HjkPSEhWSw@google.com>
 <87ed9c5yp1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed9c5yp1.ffs@tglx>

On Tue, Jun 04, 2024 at 08:51:06PM +0200, Thomas Gleixner wrote:
> On Thu, May 30 2024 at 11:07, Dmitry Torokhov wrote:
> > Drivers often need to first disable an interrupt, carry out some
> > action, and then reenable the interrupt. Introduce support for the
> > "guard" notation for this so that the following is possible:
> >
> > 	...
> >
> > 	scoped_cond_guard(mutex_intr, return -EINTR, &data->sysfs_mutex) {
> > 		guard(disable_irq)(&client->irq);
> >
> > 		error = elan_acquire_baseline(data);
> > 		if (error)
> > 			return error;
> > 	}
> >
> > 	...
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I assume you want to carry this through the input tree, so you can
> modify the drivers.
> 
> If so:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks Thomas. I'll stick this patch into an immutable branch off v6.9
in case you (or someone else) wants to pull it in and start using it.

Thanks.

-- 
Dmitry

