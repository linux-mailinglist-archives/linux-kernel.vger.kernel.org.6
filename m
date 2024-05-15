Return-Path: <linux-kernel+bounces-179631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410E8C628C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9BF1F22B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91A4C627;
	Wed, 15 May 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTySWFtr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF6482C8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760602; cv=none; b=sk9khNdkt6Wr7B2V0oVsz/h0xqO1zGgLVmr4cOb1AkI6kGk6v7aCQErJALP0EEGsK7FCyHmJOivtjBXazH+rLc+fB2mWnm4QrZwSGWG9diM/5uLC0DtWEq/vl8drZq6eqpCYLTwX+wfwFM7KU2kbnjIHws4UifBIu/JZcwIreFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760602; c=relaxed/simple;
	bh=KaO31ie8+TTFdpvxyLbHb6rNxvqQ5J6sXJPKDa2RNBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0J8dBdYaghcmIguvcwFrK+H03HmdIEG9/iPbQShx/8171zRK8Wl6KJY8TQvuqFh0iyWYCtcxEmzAMOGqj7EzUVwROkWKBELfg0AEdINs/DSpRT/cBxZ+6QsvK+quizzU50CC2DBxB6Ku/WKXYbhbEDUbd8wVarsCuUC5W4yM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTySWFtr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a64db066so113863066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715760599; x=1716365399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6O2kVoYtQ3FhhhHvKJ0ZHKUww8sQRpmhgptxqLh3T/s=;
        b=QTySWFtrxuhLAx1quJUB4Kc918EPL2ooL6R8plR1BjICLq+tEhkPbmyr+4Vlxyt0N5
         N6jFyzNU7vo3CX1+oY15slI1PwEEaGCtOSN9Hkhm6oUF3zebCh/IYIlLnZqMsfofT+Uc
         X4cGx7ARJLgxidrfJmG+rDJVr9tzs7QzQylXco/gix7mP7yxkQSH8FCpMdrVtsLRwHrr
         RpIXUjwZoYwM1Ojkp0vYCINnqNg8ly3y7KG3/VmExG89c2Jg09JPAXe1OfL2t7Q+xXNz
         UYSo3GMAFW40D5LR8qaUvCYiuLOl891pQKOjr/NrOKyEth1KueiR2zNveT1ry/Wu2Fkt
         sR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715760599; x=1716365399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O2kVoYtQ3FhhhHvKJ0ZHKUww8sQRpmhgptxqLh3T/s=;
        b=SFkRrL8x/bX6YvXMBI/o3N5YAI2co7xCwkQmGe3kZRjN72FF03EpNBK25b97gUJioR
         z8AA5MJuga9s347ZtD6iIbLUZb3SgfdRo9eClF6kwSZILlJHRn6dWiwbbstfFlL5JpyL
         CmkrSdGfke8r9PKHB9F6L6NVSnpShNMTrKL7yMtSOzp92h302l/fbM8pH4r0Eu+ujYz3
         atUJV0kweTN38u5pJLmGTa2Qx+DWHSLXXcn28IDw/BJsK2A1XgfpARXZtUkgwWU2pnDi
         P7OPaBHsUZNgmmjMOSw7b1T3+IevfOCpSv2Nl+P1tT7FkttNsIuNU1Yd15TgXqyDmJYB
         sF7A==
X-Forwarded-Encrypted: i=1; AJvYcCXlx22KjZnEWw7j41aGIoZ3FsTvz3HbEWm15Re/rKcdfoIUIZeyHCG+1ut+TR4rj1m9RDbZpUjU+Mtjh6ZNLlXmN20wHhtUI/MAbbQC
X-Gm-Message-State: AOJu0YxczOpDZxD2RXOqbn3/o4jQZQ1h7S9xf1cxUIMez60eVqwNuKbU
	MX/+Bjj0bL1H4Rbw7VArrhrRUa1trXvYjhA7K8rnm955Dag2lHT/
X-Google-Smtp-Source: AGHT+IH/B6z3e2c5RAbzLszJJnpexfiNGNBc8XahF+3UlaV2PXRJ9oCWOBwdWC2Dv0V22wNWtrd0vw==
X-Received: by 2002:a17:907:3203:b0:a59:ca7e:e1f with SMTP id a640c23a62f3a-a5a2d53b76amr1347669166b.15.1715760598537;
        Wed, 15 May 2024 01:09:58 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179263d9sm829635866b.95.2024.05.15.01.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:09:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 15 May 2024 10:09:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/boot changes for v6.10
Message-ID: <ZkRt1IpAdtBBk0e4@gmail.com>
References: <ZkG4cMe1TFI5w7sc@gmail.com>
 <CAHk-=wgf=jwo1HZjQN7UeFw7iYPtQ_i0ri7JNOci+7Rn5-pDcg@mail.gmail.com>
 <CAMj1kXHm_tmBPNTvnvn3r6myeRo5x1fX3_J73UA1j4bVBo_PSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHm_tmBPNTvnvn3r6myeRo5x1fX3_J73UA1j4bVBo_PSg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 14 May 2024 at 03:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 12 May 2024 at 23:51, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >  - Re-introduce a bootloader quirk wrt. CR4 handling
> >
> > I've pulled this, but shouldn't the compressed boot also just stop
> > setting the G flag that it didn't understand?
> >
> 
> I agree. But not setting CR4 to a known value is what caused the
> regression, and that could cause other problems down the road, so
> fixing it was arguably more important.
> 
> More than happy to send another patch to clear the G bit from the page
> table entries created by the decompressor, but at this point, it
> shouldn't make a difference.

Please - we shouldn't be creating page table entries with random G bits set 
in them. The boot code should at least pretend to maintain the illusion 
that it knows what it's doing. ;-)

Thanks,

	Ingo

