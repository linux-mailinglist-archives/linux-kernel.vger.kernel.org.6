Return-Path: <linux-kernel+bounces-415164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E389D9D3231
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8255EB23CED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C215336D;
	Wed, 20 Nov 2024 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Z57hFmuI"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDF2E3FE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069924; cv=none; b=cS9U3qryUODiT5JdYs+yNZwieSqHM1Sf8seeLA36X4gLYNuPBKN0yvwuBO/6YZgxIZau6v58r7jH95jpyTq8T9tC2uE74bL/UZxt/bL9emWpm3CQF+rjvT+AKc5t7rv5Ts3s1zgybrbuCdhSzQqDGrpB4pNxEYB8imNyT/Mda3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069924; c=relaxed/simple;
	bh=IJRHEBv22CCPwsTeJhDR5YAQTUAy4jX4+RLOHq4x16E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoWAA/9XecV89IgLGhq8gC0UzYCLRbvYvMrJh3aedEluI6ubrVa4BwpZkrXY8nuOIUCq0+tMBQU0h0cUI9m0Ke9OsC7GXPmni7ccBYCMFNrLN63S6lzVd2aEcg17Wa45IDPKh2QsVEngNoDURd3qKICnfoOMX9zkaGkgUSVQCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Z57hFmuI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2968322f5feso1410295fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1732069922; x=1732674722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3z610eh0qCJd2kaOZ7Lkn+Ilb4Xt4NLJTNRQhvjlOc=;
        b=Z57hFmuIYsd1iXfgUkBx+0kTGHrJ1UbhSYfDzUAIeaq8/zNetdZjIlYGA2nk4bG5hc
         V40H/HbiPtgwjpf2wL4NaKxaB+8h7tiX3MMUsZyUSWSx71yeg+yXiX9o45YdPHg/Q20D
         PXCIkXQ7/LjWJ/2GyGb4SHtp8tnGPl7oQO4Nxuu9c4QY9thwNxRFq5KKwdACrVfwKT6U
         koG5cPZfxTahoj5j6IFp5yq6sDAxbYjuv46sFGlJQccUbGQdzhnF6Gf4WXPHm5yz5XVf
         ZPUztQmIowpe4HvSHN3fO2B6JDWpbSGC9ErgBv+MFb+hjGnVaWjII9RLmBSOeePJBTj0
         Zzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732069922; x=1732674722;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3z610eh0qCJd2kaOZ7Lkn+Ilb4Xt4NLJTNRQhvjlOc=;
        b=GZWqY06dnMrTccMB8OzeBJMZEMJOrjlVLN75uf7nVDis9BrPW/dLOcVYzNcqPfn4C4
         lpeuJFfF1RKU2+LpiUtPo34dLEzPKoMUNd8hIUneFXehoVsmSwnn8fdNJYi32EMthJT5
         v80MMT/jI6JaL4dQ53qd0Nlc3ycSoY0PW6xk2thtNhXrWBIdfUoi98T44wE+q3tNb6xN
         Pz3wbqLb5MiFBrq2sfcxyLJMW/0RbmbmvgQXLyjwpeWmEj6eNDfcv1dMSsnGL7XKTG4t
         E2m1uosIFJCEb3fUzAx+vPvZpxy0oyCmvn0eXjC238GV/1qRRL4Xpi2LBE7OiELI46cK
         ie2g==
X-Forwarded-Encrypted: i=1; AJvYcCWYrOaHp7Mzf1FEQVwuhKic37ZbqtOKV+xggonrA37utkfpgw2suGIOclfgCemuGc50/GZwXjjsHcvwde4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/R5YpTSDh4OJTSyAl/60Mmnx0AmG3IYedL4r0hrofyt/tf2z0
	TGV0RF83OCZF/p0H44z3Pd2jE9LB9f/ssxG+0xQ0G3H/kiVmGtxfToi9DQRbPXQ=
X-Google-Smtp-Source: AGHT+IFfSumVh91w5x9msiZmygRxDbJS7v7w+BJEhWhfq2eMN5sfNcaNQ01peKn0p30SVbyVU7B39g==
X-Received: by 2002:a05:6871:613:b0:296:e4bb:80f5 with SMTP id 586e51a60fabf-296e4bc1d99mr314446fac.36.1732069922013;
        Tue, 19 Nov 2024 18:32:02 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ec53:8290:86a1:aa7c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651945ee6sm3977928fac.29.2024.11.19.18.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:32:00 -0800 (PST)
Date: Tue, 19 Nov 2024 20:31:56 -0600
From: Corey Minyard <corey@minyard.net>
To: Quan Nguyen <quan@os.amperecomputing.com>
Cc: Potin Lai <potin.lai.pt@gmail.com>, Corey Minyard <minyard@acm.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Williams <patrick@stwcx.xyz>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: Re: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
Message-ID: <Zz1KHCLwpOdsCagr@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com>
 <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
 <CAB9gMfphfY0H721G9qV8_3sm1d_RTnKkWbEOeqC-0ox9p4cfCQ@mail.gmail.com>
 <b2441bab-304b-4983-8780-43671e8add4b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2441bab-304b-4983-8780-43671e8add4b@os.amperecomputing.com>

On Wed, Nov 20, 2024 at 08:58:47AM +0700, Quan Nguyen wrote:
> On 19/11/2024 18:30, Corey Minyard wrote:
> > I just saw this.  What makes you think alerts are not supported in ipmi_ssif?
> 
> Yes, Corey, I see alerts are supported in ipmi_ssif.
> 
> My apology about the unclear question, I was just curious about whether this
> gpio-based alerts mechanism is confirmed through test with current ipmi_ssif
> without any extra patches.

Ah.  The way this would work would be that the GPIO is run to an
interrupt on the host processor.  Generally all the alerting devices on
the SMBus will "or" into that interrupt somehow.

When the interrupt comes in, the host will issue a request to the SMBus
alert address and each device that has an alert pending will respond
with their address.  Because of the wire or of the SMBus, the lowest
address will win.

On Linux, the driver for that particular device will be told that an
alert came in if it has registered for that alert.

The GPIO is just an interrupt, so that should just work.  That's not the
hard part.  There has to be some device tree work on the host side to
map the interrupt to an SMBus alert for a specific bus.  (I think you
can do this with ACPI, too, but I'm not sure.)  And the device, of
course, must respond properly to the alert request.

So the GPIO is not something that's unusual.  If it generates an
interrupt (and all the other stuff is in place on the host side) it will
work.

-corey

