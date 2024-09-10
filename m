Return-Path: <linux-kernel+bounces-322956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFD9735D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63B81F25CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315B170853;
	Tue, 10 Sep 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VO209v2F"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983B5674D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966079; cv=none; b=VyobacelwrtEXXgRVNctBnAP50Q4hZOtdF1qhPr9aAcKlL1wjH+B7aydJuyHilumCLnicnWffNZn+qSf1PX0Z7m/stwJNZETDvtWmygxuw05WT6aZ5vRveq8viOMNGsfLGb32bNSFibVs4nLi2yk0g26BJElHFZPv0dJbcklrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966079; c=relaxed/simple;
	bh=94DGp3C5AYMl/BFVYCl5gdrTM5mEcrQgTCi/e5Jdbl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYVFaFqg4+9/imm717s8e9h5TeGU2mPb2a/h15u2mL2jQ4oRCXqgMwhhB0n4wRO2AUUlxS9wwouLVX6W1hoi/qzG0Ag0BBeuNniRQl2hCJIZjWVJB0n3XHEqxMXYSdDQLR58RrZbtB+tuZ/6NTgDD2InO6WsRNR6k2EIz006O80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VO209v2F; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so264234866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725966076; x=1726570876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUeSoh4W/z0aMfTXKQTAeunZCl4Gx5YQHg82epMm3uc=;
        b=VO209v2F0tCysHW+6wAGgMYOJtU/EOcybXFZQMSx1dc0WDxNGDSfHkDK8UmFDBGyrx
         X+KGVVdmjwxS7ujxFoQABFlHgCmRNTMlMbEyF4dF62dSCw2ewIIyAKOeoZ2zQCx8Qb9i
         UDvIYhjcjlEYII4RpHuXL6gVOPpi6XMYXYzhLYESluzU8EucLE5PYpj0wmvJMzU5GPdm
         7qObMt2eAWhiEqGeu6O2KaGvybPForWCoK4yYKu/5mJ9c6Q+883CUnSgHrG0gdRzoz1e
         IZowiot+nge5cWfdadY9cAhRTlfcaR5k2AhdFevtc5DLiOTkSvwgcMjpE5ytpFUAa/vh
         8vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966076; x=1726570876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUeSoh4W/z0aMfTXKQTAeunZCl4Gx5YQHg82epMm3uc=;
        b=SAYjqsvsjSEImzboiG/A4iA5JjpdSQ/bNcfZhoyHMyoeFf0cPd+VCFwP7t07qpd/CR
         hzeMWBiGMzwdPZQvOBtK7Zm6S/yrKhnUKbs+0uWUGHgOxrfiRpSZs5GmRhw40dm0aLdW
         ZWRI/8b3VsGffcbxzzaPriAYEAOnbYZb5AVl/gPvmofHa8CSo+SEpsZRhTtTFI/pyaV8
         +oysjiVfZ5YN0CIw9kT1WsVl2HK2w2K9y3D/aEKr0hWnk7gyEU8Tx5CCbKynWesI4JU/
         3Zy62gr2Jp2RnFR6zVj/hu4/wkYWFbS/WGAk8vApKrR/xIum5gQ0Z97Urbd0kgRVvmzz
         ke2A==
X-Gm-Message-State: AOJu0YwBsF7YR2VqXD/jSZl5IWaQmfvrQIAnXdFJ+rFn4vHtzUBrK+CW
	Q3+REE6EqvmuugRjLCjRYeeQQGkik6VyytcXBGV+7M33lA69ydPTEV/ALVT8ICs=
X-Google-Smtp-Source: AGHT+IGlGSxo9U+KpP/ntytYsSppmVMzvkuoneIV9p/r4iqRyDAfQ7t5IQvknumFf+IAujZlTFQ2SA==
X-Received: by 2002:a17:907:3d8e:b0:a8d:4e13:55f9 with SMTP id a640c23a62f3a-a8ffaae3670mr36705966b.19.1725966075820;
        Tue, 10 Sep 2024 04:01:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61263sm466968566b.128.2024.09.10.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 04:01:15 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:01:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Livepatching <live-patching@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] Documentation: livepatch: Correct release locks antonym
Message-ID: <ZuAm-pgXO4SySyB5@pathway.suse.cz>
References: <20240903024753.104609-1-bagasdotme@gmail.com>
 <ZthJEsogeqfVj8jg@pathway.suse.cz>
 <cd1340e4-f726-4ac4-9caa-8e8a3c369203@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1340e4-f726-4ac4-9caa-8e8a3c369203@gmail.com>

On Tue 2024-09-10 17:27:42, Bagas Sanjaya wrote:
> On 9/4/24 18:48, Petr Mladek wrote:
> > On Tue 2024-09-03 09:47:53, Bagas Sanjaya wrote:
> > > "get" doesn't properly fit as an antonym for "release" in the context
> > > of locking. Correct it with "acquire".
> > > 
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > The patch is trivial. I have have committed it into livepatching.git,
> > branch for-6.12/trivial.
> > 
> 
> Shouldn't this for 6.11 instead? I'm expecting that though...

I am sorry but the change is not urgent enough to be rushed into 6.11.

Best Regards,
Petr

