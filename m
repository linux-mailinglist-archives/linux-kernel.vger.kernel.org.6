Return-Path: <linux-kernel+bounces-380422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E79AEE43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723A0281BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96D1FBF5F;
	Thu, 24 Oct 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0+Fb/rt"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425C1F76A4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791356; cv=none; b=T2miT7O9ZJAgplc6e/wCbFaTxKkeFpC/mjqWLENb7KiAokF+lbqMxsX6TnUTfJQC05i8C50d3PcWUVSoHcALtzPY14Iq5Smfvb9vpJdplWsZUPj2iDGBXb4CHgjRk3FWVKvScnWC6iIOiDyYigXbQfp/989bKwnJafv92CthHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791356; c=relaxed/simple;
	bh=2BYxqbYfztHvjbaFtpSC+vFEKcu8+g94GzBgYCRNsHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgcW3DFwSCtbC79BIOPRm5+sTuVm1DjF68pNaUmYTLtoHD7kBecXA2NKWqfroO1ciUI5Nj2nYe1Chix22rKZpxFLS+IFYOR93bnZmwYucdiNhFAvM2+6ZvY4fOHidvsN1IXGQbxVLRT/Fpgf4djPc1cEbo8GRZdf8MDUEi/nAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0+Fb/rt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ea294480so78572666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729791352; x=1730396152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dji1r/mkShycMIqQRWpCHbxCI7reC1wukqFmPadAxoQ=;
        b=G0+Fb/rt2jDFfHueHG5S3e6A21JgJSQ7cohnPWB2DN4XI3/UxY73FwHFl4FT6nbxs8
         eNgRX6ex0c6ZHRYnBzhCy/j1/78YEOOy/SzV3F9Lt4TaBhT44rdDTeG9hL6Vy1G5lA+8
         ggAvO/7NeYC5WJVPcCDBRVtIlUo3spbwZGqLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791352; x=1730396152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dji1r/mkShycMIqQRWpCHbxCI7reC1wukqFmPadAxoQ=;
        b=NVDz7rF6LHmCyow3TX2YAUWq9Wt/jDmsJPQAmNLGazSCveOydOfVr+GCFneEB1BIs4
         BFHp6mQKINU+Y1RoF+irxc1uQbxmX+DfwyAyEvwfqzjPgDOTUg8r0k6W1n/icSJQQKMy
         7BOZB7R1K/HKmsgxyiVtFZHycf4g7hkPYHnbkZ5I0dCO5GNoMaK1LA0l8Dh+U68DINsn
         y5ENoun1/ioeftubUkteKTmSIf5aLJQ+hTN3dWqeeIjnF8GCTomVj6dAvI5bifDi+wm7
         BesZQPWEPstkBpniCh9jVOqHSoOmmF3JaNaBMn+B9uiRFdt0bSCl3uX8NVLmzPMpsG4z
         3KPQ==
X-Gm-Message-State: AOJu0Ywe1NDjry00YVRWoRM+ukxHiLdIOfF6FYv0XpggbJ2inaF/jctI
	tvJSR/g0yzwk6azC5OW9anK9J1iLMDiz9pasgx9MwTPQa/yz5133QvdNEuUcRX07PRYXM5Uw5eL
	kNs7I0w==
X-Google-Smtp-Source: AGHT+IGEYFKZAJ2pxcrV86FtBbWuqZVUP85I1/mU3uxcXwqr/uRLegfrcdzolhpJi80Jhongqz6avw==
X-Received: by 2002:a05:6402:50cb:b0:5c9:44bc:f9b3 with SMTP id 4fb4d7f45d1cf-5cb8b09abcdmr6627774a12.11.1729791351988;
        Thu, 24 Oct 2024 10:35:51 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb895f9a5csm2687139a12.18.2024.10.24.10.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:35:51 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d58377339so896684f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:35:50 -0700 (PDT)
X-Received: by 2002:adf:e386:0:b0:37d:53d1:84f2 with SMTP id
 ffacd0b85a97d-37efceeddfdmr6141553f8f.11.1729791350453; Thu, 24 Oct 2024
 10:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024013214.129639-1-torvalds@linux-foundation.org> <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
In-Reply-To: <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 10:35:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>
Message-ID: <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation issue
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 23:13, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I'm probably missing something but once LAM is enabled, how wouldn't
> this allow non-canonical address speculation?

Once LAM is enabled, together with LASS, non-canonical addresses
basically don't exit.

>  i.e. when bit 47/56 is
> set and 63 is cleared, would it not go untouched by mask_user_address()
> and thus be speculatively interpreted by AMD as a kernel address?

AMD doesn't _have_ LAM. When they do, they had better not
speculatively mis-interpret addresses.

IOW, notice how the LAM enablement is *dynamic* based on cpu_feature_enabled()?

(Well, right now it's commented out because Intel needs LASS for it to
work right, but that's a separate issue).

> Also, the comment above __access_ok() now seems obsolete:
>
> /*
>  * User pointers can have tag bits on x86-64.  This scheme tolerates
>  * arbitrary values in those bits rather then masking them off.

No. The comment is still correct. The scheme tolerates exactly the LAM
kind of hardware-based address masking.

The difference is just that the constant is now boot-time dynamic, so
if LAM isn't there, the whole tag bit issue goes away, of course.

>  * Enforce two rules:
>  * 1. 'ptr' must be in the user half of the address space
>  * 2. 'ptr+size' must not overflow into kernel addresses

.. except the "user half" should probably be "user part".

                    Linus

