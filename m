Return-Path: <linux-kernel+bounces-266112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE2793FB41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5601A1F21E41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187A188CCF;
	Mon, 29 Jul 2024 16:27:17 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305E15CD77
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270437; cv=none; b=VtHv0grf2d0agXFuJReCKF6/5cLiWQ7mQu/hpXmfxEMMRZFgmnkEsIzX0UCW2bIYrrowLWy6rERXbSvAjL6jNtJ8jqhN1yi3kL+CrhYnVtvjQFZXEHEefYtDW++rFgyENOZPHrbXSuP68qC2PGTYUF2T/i2uPc+BbSn6kb/kqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270437; c=relaxed/simple;
	bh=XyxfFeP5fO+sBfnPBCeVxwj+AqqvbJt3nXJoI8+pVjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqY7KorkGbwMZ7QpyzKhBRpvuclQy2u79IfwxslmiLesEefhiu2UT/OfaSuIUZR2WA2BA64Fe++PQztMLApQLjpQmCioGs4o5CqPHw+6FNWOyeNQzpRyE0/NDd+VYlJAwfRG9T38zu5TdfeYnXAmdof+DJKtyAaUFXn7V7KUzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso3321925a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722270434; x=1722875234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbCJuyqdHkjYO3agTQ/GQTTLIxGsDUT83KqTY72Y3tc=;
        b=bx66LdgBOPcCfuZPVi5WffeoDBcntMvLWNTwvGYDPkVwQDJQoQWXTEwh1MBuoGjStV
         Y3MszXgwkJ8i+lfmKReGriZO90AKe63FEVqbWLSZi8I30go31abqlx+hvJ2oTzsMz6Li
         lCBNoHl4tlopz1JXrvZAdaIKtql9JNFL54t/Xtclgxhy18W7zI9uOUzXrw6PhsY6FZig
         skd2ai3tPd37hA4fDbryNUmZfoFB8KqTPoAHp/tp6zUo0C2y2/UpkN6JS9fR/m+2FPgJ
         svCzMekXYzlBrHn7LXG9CWrVmhnXEkvqfFDVRIJpQvizFMdsXBb+6FHjIC9A44sX5ZhN
         srtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZx6kITVnImfXW4DeABB2g8QzwfG+omuuobs1jkUlLZyfzRkcGxxgNLqb/ueyiXUaYurZIIsjE8j4/GYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRITaxnslkLAjHKls20NzOOA8VXZN1Lw8HEXPpzcHcemlVrgrf
	V0QYRt1vDIj7jQa6UIcf8Kno5Zy3ZwbxeUbbUAEU4DeS9NHT0FJ3
X-Google-Smtp-Source: AGHT+IFXSX8L1dgH10M41AmyAELmchc9pARJkJLkZ6W/vXjHZOGzSM9Bi8qyOQH/NkhatuVzkrtRPw==
X-Received: by 2002:a17:906:fe42:b0:a7a:cc10:667c with SMTP id a640c23a62f3a-a7d3ff9f305mr476837966b.16.1722270433325;
        Mon, 29 Jul 2024 09:27:13 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4d27csm530090666b.46.2024.07.29.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:27:13 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:27:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: jpoimboe@kernel.org, mingo@redhat.com, x86@kernel.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH v3 00/10] x86/bugs: Separate config for mitigations
Message-ID: <ZqfC3me0aC3N1iUQ@gmail.com>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240729092102.GAZqde_tdP_Ca-chhl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729092102.GAZqde_tdP_Ca-chhl@fat_crate.local>

Hello Borislav,

On Mon, Jul 29, 2024 at 11:21:02AM +0200, Borislav Petkov wrote:
> On Mon, Apr 22, 2024 at 09:58:14AM -0700, Breno Leitao wrote:
> > Breno Leitao (10):
> >   x86/bugs: Add a separate config for GDS
> >   x86/bugs: Add a separate config for MDS
> >   x86/bugs: Add a separate config for TAA
> >   x86/bugs: Add a separate config for MMIO Stable Data
> >   x86/bugs: Add a separate config for L1TF
> >   x86/bugs: Add a separate config for RETBLEED
> >   x86/bugs: Add a separate config for Spectre v1
> >   x86/bugs: Add a separate config for SRBDS
> >   x86/bugs: Add a separate config for Spectre V2
> >   x86/bugs: Add a separate config for SSB
> > 
> >  arch/x86/Kconfig           | 117 +++++++++++++++++++++++++++++++++++--
> >  arch/x86/kernel/cpu/bugs.c |  46 +++++++++------
> >  2 files changed, 140 insertions(+), 23 deletions(-)
> 
> Ok, rest looks ok. You can send a new version with all feedback addressed.

Thanks for reviewing it.

I will send a v4, where I will drop MITIGATION_GDS_FORCE, and keep only
MITIGATION_GDS Kconfig config entry.

Thanks,
--breno

