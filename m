Return-Path: <linux-kernel+bounces-213684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC79078B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F024E1C21771
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8D149C61;
	Thu, 13 Jun 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGm1vR4o"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998317FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297469; cv=none; b=dL69KA2fFtXf+00piYRiUoppva5KbB1XdvOofzOknrxXQ6whapEN5E9DwIipHg845eLn6IoQnUIZcrCtBeesV++M/Zy3AIJLovL4C8dunut78D28y+EmSQ+xUAf9FcxONvHxh890zDPZN4dc/DA198syn638mh2vFjwC76yCwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297469; c=relaxed/simple;
	bh=6NWJFRUxcKND4U4SpQJfsTGcu3XSWWW8WSpW7MTVo7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ6I26G3QHisIQUXqczKkOVf/m4JkFopNOsJzDj32B5W7MbuJPUFOe48Slq2uEJ/8NUElCLuvO9k1/WeePITQ/5QqDIJTNNP82Q5WrKMx+/tEsGdV2bBXboY4vWhPcmRaoi8f91FhxNsPiBPtHyDduvNsaNKZ+vR0iMD7V/BE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGm1vR4o; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f2266edd8so969789f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718297466; x=1718902266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzzUB/FjhEnH/BYJNIleLEzzp0Ljx1jUDZ5+DBBvWYc=;
        b=RGm1vR4om7S8Tt++HKPbTOadylz7Tl3DrSPGjokihxTyrBD63tKC0gqow3MtdN65qq
         +VG4o8PLDTvVGiJYLg4MFDueIWpU8lgQniFDLQ85Hadlyzka4tIylvxQFW8otKusM9b5
         6xPsyehA3pmLxyjEcUEnUg6I1IGzCrKL1YREzlNCxgV1VlHyAbfos1i3QXSO/0Eq0m5o
         6/cgaCP6pr6qmwjigYq4lIaS4IHNlmBP/TUlh9lTKvZAuoHe8j/jdGRaBR9QNBdi/TVB
         4tE4uX1sKOqiHYOqKeXRTy8f88n1xNvEmEx/45AOOwBKuCvnCsOxI3fVWRVCHtIiVlz1
         ONSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297466; x=1718902266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzUB/FjhEnH/BYJNIleLEzzp0Ljx1jUDZ5+DBBvWYc=;
        b=MdZf67muG58wHQOYl3qEmhD/87CTk9pOVmhgnbjAVjDflwzUvQGAFDiHBZLf6GjCvV
         jwBcxFKRLv3+uWQdu2mOc3S0dKBzkjoO62CTRzmPOa4Fu1SLk639sizgsGOIMRy4a+3f
         L1sPs7DsIvyxO5touLFrXvtAMLLSNqK8hK+8mITjyx3YOB/MAt5P/uuKZAnSiOAMOB0C
         Y+bzTPgcJP3EVtN9iiAB+D202hbhUkVOKYogm1vYtTNZjv0cybcIY2ZYUSDNFkmA4Ya1
         4+0jcBHu45Selr+njgv8grMV0yOxLWnFNC5qPhBCVNejCjmc4es/i3qaM9MMjx0UhGZL
         doWg==
X-Forwarded-Encrypted: i=1; AJvYcCVCRqveUSxleK4Q/f/c8ht49DZ2IM/NL0Uf6n0Pi1U7b3uRSK/D9+uzLEoUKgrv4+KibN/CWDmpStpGxYN8JJcvenn6e0UYg3y02g1t
X-Gm-Message-State: AOJu0YyYczjHOYoePC3PcNgKI/hzy9zJPC1ecDLEhRgVLRq1rvPiIP+j
	631W4C9aWKYKScrp0S/O3boBisWmSZghxHkTQhHi/pMWmU5tfNrt
X-Google-Smtp-Source: AGHT+IFd44wXWFVM2hw1th+c947IyNuuiuSNQutEgNIYsg030ZErOxFLm+hL+7BwFMhxl6Lwv7yfZQ==
X-Received: by 2002:a05:6000:128d:b0:35f:2a43:3b11 with SMTP id ffacd0b85a97d-3607a78432cmr194032f8f.67.1718297466026;
        Thu, 13 Jun 2024 09:51:06 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d41sm2248075f8f.16.2024.06.13.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:51:05 -0700 (PDT)
Message-ID: <666b2379.5d0a0220.c7eec.8b6f@mx.google.com>
X-Google-Original-Message-ID: <Zmr3VW50gEx2qXah@Ansuel-XPS.>
Date: Thu, 13 Jun 2024 15:42:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
 <65d62b60.050a0220.c7b96.614e@mx.google.com>
 <666ad6e0.df0a0220.f8b16.4a5e@mx.google.com>
 <CACRpkdYJoNRpciyQE_A6dkb8f6Jsy4+qwb4w9K3bss2mkZpp1A@mail.gmail.com>
 <ZmsXdWWidNjXdbSa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmsXdWWidNjXdbSa@shell.armlinux.org.uk>

On Thu, Jun 13, 2024 at 04:59:49PM +0100, Russell King (Oracle) wrote:
> On Thu, Jun 13, 2024 at 03:50:58PM +0200, Linus Walleij wrote:
> > On Thu, Jun 13, 2024 at 1:24 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > 
> > > Sorry for asking again... but any news for this?
> > >
> > > I have also added the 2 patch here [1] [2].
> > >
> > > Been in incoming from a long time and I have seen other patch getting
> > > accepted. Did I do something wrong in submitting the 2 patch?
> > 
> > Hm Russell must have had some concerns, Russell?
> 
> I've been snowed under for about the last six weeks - with only the
> occasional day that isn't silly. It's that kind of frustrating snowed
> under where each problem is a bit like a brick wall placed every 1m
> and you're supposed to be doing a 100m sprint race - you can't see
> the next brick wall until you've climbed over the first.
> 
> Whether I have time to read the mailing lists or not depends entirely
> on what is happening on any particular day.
> 
> > If for nothing else I think some Tested-by:s would be appreciated,
> > do we have some people who use this that can provide Tested-by
> > tags?
> 
> Yes, tested-by's would be a really good idea, because my gut feeling
> is that this change has moderate risk of causing regressions. I'm
> not talking about "it works for me on the setup it's intended for"
> I'm talking about other platforms.
> 
> I'm also wondering about distros, and what they're supposed to do
> with the config option with their "universal" kernel that's
> supposed to boot across as many platforms as possible, what they
> should set the config option to, and what impact it has when enabled
> on platforms that it isn't originally intended for.
> 
> I haven't really read much of the patch because I've been so busy,
> so I may be being overly cautious. Given that I am quite busy, I
> would appreciate a summary of the situation rather than being fed
> with lots of results! In other words, the tested-bys, and "it works
> on all the xyz platforms that we've testsed, nothing appears to have
> regressed" would be ideal.
>

The current patch are used downstream on the OpenWrt ipq806x target that
is a mix of legacy (what this affects) and non legacy targets. (old
bootloader support loading DTB from the image and older ones require it
to be appended)

I think I need some help from the community to test this.

I can also move these patches to our "generic" target on OpenWrt so that
they will be enabled by every arm target we support.

Anyway thanks for the feedback, my only concern was that I messed
submitting the patch on the tracking system. Hope community can help
with this since it's a big feature for legacy devices that was broken
from a looong time (and only solution currently is to hardcode the PHY
offset values)

-- 
	Ansuel

