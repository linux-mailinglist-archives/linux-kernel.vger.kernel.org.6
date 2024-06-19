Return-Path: <linux-kernel+bounces-221430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AC90F395
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BEB28E52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0415B112;
	Wed, 19 Jun 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VqH2/Fhq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127803FF1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812360; cv=none; b=nbUTbsUSpJebXxXDc4aNvrB+V/R1spaWSi/SVQ6x6p7QQwo2jzvxxkAh9otLzghlLCT27dQ7r12f6P1/ElYHAs/q/Rrm+gzJnybZmFhBiKPMXSQWuVH8051afNZRjLC3Rv7Po7RXYnxfdfrd8IiDKp2f6A7nPFW7ldGq2eqy2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812360; c=relaxed/simple;
	bh=YmvkiFWQ5tx/t+/IL4OgZ+0ERFSZhMVDmzA19FQbB78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nb8s2Ih6tk2zzE/sOIsZuddEcNuEUWOzpHNp3gWmMIXGXJ1hoBAt6YMh8oO6+wJEjh/DhmaIgNJFy2+DFzR4ecnbuPLMTJA5taI/l3g6uu5DyCFb3KsUnHDM/EbKurDhBFO5xV8Ho4HifTBlIR4VnBMc3z2Psi6Jr/zjTWnxH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VqH2/Fhq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c9034860dso8520830e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718812357; x=1719417157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B8s71NdX52Gwd8z+763rRphKSP2eeZm9/nzW3853+Qw=;
        b=VqH2/FhqjRLNDLh348FNLRuRRV/kDfiJYqk2RtIXT9qhL+fGEwDtzCgk+RSQZtJlh6
         jWi5Qw/A0u2ewGYlmnv122AMWcdr0qlJD6Z7XVkflKcv6UDNMtXAdkrFTNk9sqapDaib
         YV22EVRwlgQGbXC/xXuY8+YktEPbZRqfZUzjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812357; x=1719417157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8s71NdX52Gwd8z+763rRphKSP2eeZm9/nzW3853+Qw=;
        b=c/I+r6rwbcgmCbfhUxeR9Npd2d8w5/ciZHrTEFnEZYHi0nPB0A67sUW//Iazjxmen7
         c9ZLSXOmGdOXad9rH03fRewCEiEb4qYBt58J0sk2U0+DZrFTL4XWLLJEQYr6TdN1JDCY
         ZSEDBkdOY1kIwzBO7IxnP36i8WoH0QDKxNnGYxUz//NhB2PynP1YaziU+LH8vjPwvb2m
         O6fXJ+S0hTDQLLINWMRBhTlZ0mDNPjtjD/U7olIFAy8H7V/52lUYgyVL88I1ZH/KwKpr
         HWAlz+1slDgCS9JuqLY8MAEeb8C1SuJixpEMT1VT3djkQ1dFW4zMDeeQgHSnHK6CwPq7
         brig==
X-Forwarded-Encrypted: i=1; AJvYcCVzhfnINqlbhPFxtAXc+TpmeyZv7GjR4OelYkf80bthGWHe8898qYIEzz3bHUfteT/KimoCVRKEJJyaFI1gZTowb8Ak5RnAFgMjlOWC
X-Gm-Message-State: AOJu0Yz8HG3RAK+YbS+tk1y+j9ZQ+9FEjkqORnhT7yVlQCT5Wbqjo4mT
	1fgeGGEjPRUMwI/LS0B+NgkhAYQwko/DDn0VIuEZGOTsF1zLrFoQg/TKEFHg3RK1LgNF4711Nwn
	cYdxSyg==
X-Google-Smtp-Source: AGHT+IGcseous7XkA5SJyOS040CMkzP4ge5ff5l85ehVajRkxRQDyYJPF5j7vRofsF9pDhNNL7TTuw==
X-Received: by 2002:a05:6512:3c97:b0:52c:a2e8:dc71 with SMTP id 2adb3069b0e04-52ccaa595eemr2847585e87.64.1718812355074;
        Wed, 19 Jun 2024 08:52:35 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825905sm1800052e87.53.2024.06.19.08.52.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:52:34 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c9034860dso8520746e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+5GwBsoy+KS7ZXP3QWGO5PXrIvBTR1BjCJ9pkHWjZx6EHTg+2GvKWUC40Jhy6KfTipESBjdtquaWIyE70SlOcajkw0unGGGHO8sZM
X-Received: by 2002:ac2:5466:0:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ccaa36996mr1970072e87.36.1718812354107; Wed, 19 Jun 2024
 08:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz> <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz> <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
 <ZnABbKrIzmmEoFEV@duo.ucw.cz> <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
In-Reply-To: <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 08:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnwBE=n_K9q7x6R-bzQ-vRiLeYUciWTJtMokLC_1a7gw@mail.gmail.com>
Message-ID: <CAHk-=wgnwBE=n_K9q7x6R-bzQ-vRiLeYUciWTJtMokLC_1a7gw@mail.gmail.com>
Subject: Re: Linux 6.10-rc1
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rafael Wysocki <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 03:44, Pavel Machek <pavel@ucw.cz> wrote:
>
> Ok, so machine is ready to be thrown out of window, again. Trying to
> play 29C3 video should not make machine completely unusable ... as in
> keyboard looses keystrokes in terminal.

Well, that at least sounds like you can bisect it with a very clear test-case?

Even if you don't bisect all the way, just doing a handful of
bisections tends to narrow things down enough that we can at least
guess at what general kind of area it is...

                Linus

