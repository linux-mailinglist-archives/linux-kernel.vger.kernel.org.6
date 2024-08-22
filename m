Return-Path: <linux-kernel+bounces-297812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255795BE08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4742B262DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBE1CFEA7;
	Thu, 22 Aug 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUIuJIbQ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326B745E4;
	Thu, 22 Aug 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350270; cv=none; b=Wq2LgHeCpMRKq+mOlz6KpBHPXZF7mKpyEiEjsGcGB1ex4Nc4HsJ12MypsnB0Pxa1xdSuZiPiNIReHFE/cxiSNZlKOkudUsG07+JJlkXHFqpJ+X8gURq1FE5kM351VYynR0NmsRWe+YlZF22JdotcPRAYqubyweUvWRxeUQRg//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350270; c=relaxed/simple;
	bh=OYTwh459PHCilG+ScyRaP+iNn9JtLAN2NfLZaiYeK88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/Rgx9pD7hqlo01CtE79K9gSBpHuB3HWTg0PJ8iP6f/W6f9IvXILo8C2L5AA4HbGL7WF/2mI1fBBEoKpWaPH4U14k033s9Yrv4tP8ok/BhCPV3CAfkQ7RqCupvOxU9gHuXLRLPKUzzFqlKPd14gysg7nbl1SbmZcrbk7g7cPShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUIuJIbQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714302e7285so959129b3a.2;
        Thu, 22 Aug 2024 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724350269; x=1724955069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCtZ3qFBHp3nz1+RkNmsTKoCTKR+TJ1aU88TKNHiil0=;
        b=mUIuJIbQBz5MPKoQGuyn9/fN0DzwJcigbflgbOWqrzRj1DQOz2/Oi6mx67UT2gvL9s
         UZVph5VAgzcmHaam7GEGaguryWSHUZrGwPPbv6wYAqOpN96XfpXdc4+ndyt72PW6bB04
         +k9y+jSUoo8YruSzQdeAIN5KswlrJLKmyz8U/8iSG6Qm20u0zFb72+pozDLRMzd4VAH8
         TSxxT25tltgjAxy6hqw3Nvi9ohT40jE6rnhGHxwi2N/BCUIr1ptPPT6ClDuSnAm3JKD3
         tIIZpFkSSPvfeaYr7QWgGy5CjcndneG0i7TOuw9+wdib8JicZkSekumjfwoCtDWr490V
         JCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350269; x=1724955069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCtZ3qFBHp3nz1+RkNmsTKoCTKR+TJ1aU88TKNHiil0=;
        b=odAkqudeXujiZA7TcmeZnYa79S/6uhA65KCtSAkVEspPLOiDWCCbtM20zkao//y26E
         +akVMAkW9X+5uvfi9gbCaLeLYV9NjkHoR/m22JlsXw/RZxikootOCUJ0f3nXY6MuGa0f
         IiJnYPKYhqI9jiH6glUoTIDTMcU1c8X2QZPYMpfCf8s4QXQY5GRkgvgREuhiPr43dSxR
         Uv6Sg5tnSj1se5mQyBzhp6mrPBDWTK4J8wk8eUfjjy5HgKdQjyJCpVY1FnRa4gqMFswc
         1ii92Lc9S/gLuMBqglogzXPAmyeet5CndjbxCZlb4opjBiwvOOuvjKDCE6R+Tc6W1GZ4
         sJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMJtW89Xsp0nHAMSzO8p+kdIFLB8fYtGYsWH18gDl9tIpIQqApaq0xZZITnVSpkefKwAZqx4BhCDICWeg=@vger.kernel.org, AJvYcCWaPvfHDy2FDHPwdI6gpkbMQANX0qLireuYPuVMuLYNmzXpKfJaK/EM8T0yWUqkoFauyhCviOOxnYIp0J1dZiUfNtYCDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYeeIQvKg7NU3PH/5Ea81KeBsSs12/PcN1aCLopif+v5lHElB
	qemr21hlVHgk/ziSOtdUq7US4Jrr+vjmiARLjVLQ9L2wCcrJCQ/Q
X-Google-Smtp-Source: AGHT+IESCvsBu7NiFS1g7NbPN048+bp1pHF47WEG0ECMbFNDq1bKXZrSUohix7g5EsxiUNLQzhHZWg==
X-Received: by 2002:a05:6a00:17a8:b0:714:24dd:b3ca with SMTP id d2e1a72fcca58-71424ddb494mr8079909b3a.24.1724350268336;
        Thu, 22 Aug 2024 11:11:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ccdb:6951:7a5:be1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343060fcsm1663806b3a.151.2024.08.22.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:11:08 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:11:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Borislav Petkov <bp@alien8.de>, linux-geode@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
Message-ID: <Zsd_Oc4iL4sEQsj0@google.com>
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <ZsYu0SEy8ZUKEJqP@google.com>
 <0923283f-0b7a-4dcf-8d22-b55595b1ba35@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0923283f-0b7a-4dcf-8d22-b55595b1ba35@redhat.com>

On Thu, Aug 22, 2024 at 11:46:33AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/21/24 8:15 PM, Dmitry Torokhov wrote:
> > On Wed, Aug 21, 2024 at 12:15:51PM +0200, Hans de Goede wrote:
> >> Hi Dmitry,
> >>
> >> On 8/21/24 7:25 AM, Dmitry Torokhov wrote:
> >>> Convert GPIO-connected buttons and LEDs in Geode boards to software
> >>> nodes/properties, so that support for platform data can be removed from
> >>> gpio-keys driver (which will rely purely on generic device properties
> >>> for configuration).
> >>>
> >>> To avoid repeating the same data structures over and over and over
> >>> factor them out into a new geode-common.c file.
> >>>
> >>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>
> >> Thanks, patch looks good to me:
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Question has this been tested on at least 1 affected device ?
> > 
> > No unfortunately it has not been as I do not have the hardware. I am
> > hoping folks on geode list could give this patch a spin.
> 
> Ok. I assume this is part of some bigger plan to remove platform_data
> support from either LEDs and/or the GPIO buttons ?

Can't say about LEDs but yes about GPIO buttons and input devices in
general. I would like to move all of them to generic device properties.

> 
> I would rather not merge this untested, but if it is part of some
> bigger plan, then I'm ok with merging this if still no-one has tested
> this when the rest of the bits for the plan are ready.
> 
> IOW lets wait a bit to see if someone steps up to test and of not
> then lets merge this before it becomes a blocker for further changes.

OK, I have a few other boards for which I am trying to push similar
changes through, once they are done I'll bug you again.

Thanks.

-- 
Dmitry

