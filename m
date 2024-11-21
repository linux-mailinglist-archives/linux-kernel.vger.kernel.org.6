Return-Path: <linux-kernel+bounces-416648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2039D4839
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4734282B87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E015CD42;
	Thu, 21 Nov 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoLWK4Bm"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF021C9B86
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174659; cv=none; b=NT7bJbuMQ6iBbav7uAYFDa02uTFiUEweJlyXQPW29weRFqMyPsIMNQmTWBKLjYJN8v8kv/eJu1pncgY1oQ53cdL91Ce9KkiZXWDqx8TJg2vYwkTsvfw9awQ7o9X575BqCkFY748j0Ax4vVQ/LV5iNITWVtmuzXDiXrTgPL7bJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174659; c=relaxed/simple;
	bh=GmWAuONAf+OhcB/eHqhC7jcnrOcmRZ2aXXH3NhfGLmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toEuT8CT1fU8T50JY3UmohiljcNAkI0XH+DHnbtWkdoABx0VkoUaxsF5u1K6GLA9U+cp4Z3xFFgvuYDETfOQwqQGDXDxLcTpaU2GtDY2TDb2tQu0bfHrj7ymYRSxrEVgr4DZ80SDL7nlxgcKEItSnB5jjuA6zD6y4p7h0FfczB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZoLWK4Bm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so78974166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732174656; x=1732779456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlJy7E5x9BwJc7/RzGitj/YCv0YzL90TKvD6XFRZdvE=;
        b=ZoLWK4BmULeNb2+1rxQkgdJTLgqKH0IcWJUg0nRGjpZkETfy2kjRgI2yibplh8uBWG
         MwhUcjgxz6LNzJLly3eu1LyReG0Y2z9LB2McmSxSq5k0kmk3daUQ10IiD8KZQxlVTNHH
         KzRW1WOxrMjFFado4pBRZoorA/4Ek42DLx5oBPyYjcp5T3pc26kTPiPBNoAG6aW/NBVr
         urlUlt/XZglRwhPr0LWu1J52Ynh1kx2/D6exuxUgL+L8Lg6lyItfu753/hriTTVCdAsO
         hR08Kh2bGeNNTFSp+xGO/XBQSpmG4KVfJxTFFg617Rsi8l9Ema4btUI6dUVHNpuMgO8Z
         knuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732174656; x=1732779456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlJy7E5x9BwJc7/RzGitj/YCv0YzL90TKvD6XFRZdvE=;
        b=kxv/B9j1DFou5M9eTBPn12xX6UyRNyEtFCbUDR7fVdqYIN1xBhIthVdmQQWdoQLpNT
         pTWHBRDTD5TDrphK1Jo1xqoetM7wf6lKgPRru5FCr3IPSae8QpUxRfDKThd9lizVOWs/
         eza8qCZLv2ycSAYoI34tzqwfiDfhxfLw4d8C+CX3K++vmGHFeqd6i1U5yTOHFUbuIeV+
         KkjSZDfMr31JDioQ7Vc5tYV3eZ01deevW8xl7W1F7+1t++f5pjeIfm6A0mU/U3VuI6gT
         F1yF5GLjcdqAV6T6dv+JyAv4TV9UC9fNZ7IfPdknDkDP4YySHDKVbtHtTbt9gLxWakrj
         pMFg==
X-Forwarded-Encrypted: i=1; AJvYcCVz2s5AZGLOJlylJ6qw885kGlQZz3E47/drJ/bG5fGKMnsnOTpPJu2X35XxoRP0eyFwEyEJvuTM/+Oqh3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedgMHDXitwhV40j0o/dmaf+H/y6rXer/ruSjaO24O7dmEJfaH
	1XUjz31juMIQ+6fnDBJXpBJRl/PNXdyhAQkLO6HaM/mMs4MbEnlVhTxKvS14WXffn2/mS7KRUVN
	Dy0agQQ==
X-Gm-Gg: ASbGncvpWYZVMMOjLFFBHcCMN+VerTMG6kA5BlA/KhrSYC3qMHCg9hkinu7+X0VYcSk
	kVrHbfGm9meUUiJkyxH7sGBdM79nUofeMGCn9XW+G2Es7jlvI31ha/n53yKDIogSpZvlUwLDxve
	Kph28p3FjCCGcV77znqkkn1fIPiVZJEUt/LFLHGrRebmvWoS4B3C6vJn5Fg3chfbcy9VpPdaIXr
	1P0KkhRb3ZkOS2Xf+4IYKWfoPad3Ptu7fJ6ADQs06jTaxZwr8kKV4w=
X-Google-Smtp-Source: AGHT+IFemxj512DaqvY1PLlr8Y43SJzh3VhaY0mOd3w4HEIgfr5qkWQWDkVUgWXrxavdTPZjLErIvw==
X-Received: by 2002:a17:907:6ea8:b0:aa2:ea74:917d with SMTP id a640c23a62f3a-aa4dd6b0c6bmr537097666b.30.1732174655017;
        Wed, 20 Nov 2024 23:37:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4319b75sm47346266b.148.2024.11.20.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:37:34 -0800 (PST)
Date: Thu, 21 Nov 2024 10:37:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Paolo Perego <pperego@suse.de>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging:gpib: Fix a dereference before null check issue
Message-ID: <b843f8a9-1562-458c-8f6a-c59b1037b756@stanley.mountain>
References: <20241120144653.377795-1-pperego@suse.de>
 <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
 <6ca90e87-965a-4895-ba72-8144540f6e4c@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca90e87-965a-4895-ba72-8144540f6e4c@ijzerbout.nl>

On Wed, Nov 20, 2024 at 08:54:16PM +0100, Kees Bakker wrote:
> Op 20-11-2024 om 18:04 schreef Dan Carpenter:
> > On Wed, Nov 20, 2024 at 03:46:53PM +0100, Paolo Perego wrote:
> > > This commit fixes a dereference before null check issue discovered by
> > > Coverity (CID 1601566).
> > > 
> > > The check ad line 1450 suggests that a_priv can be NULL, however it has
> > > been derefenced before, in the interface_to_usbdev() call.
> > > 
> > > Signed-off-by: Paolo Perego <pperego@suse.de>
> > > ---
> > You need a Fixes tag.  But I'm pretty sure the correct fix is to remove the NULL
> > check.
> In the whole agilent_82357a.c module there is no consistency whether
> board->private_data needs to be checked for a NULL or not.
> 
> If Dan is correct then it is better to drop the NULL check, not only here
> but in a few more places as well. There are at least 10 functions were
> there is no NULL check for private_data.
> 
> Run this command and you'll see what I mean
> git grep -3 -e '->private_data' -- drivers/staging/gpib/agilent_82357a
> 

I had looked at similar issue in a different driver:
https://lore.kernel.org/all/2d99b7a6-f427-4d54-bde7-fb3df5e19e53@stanley.mountain/

Here the NULL check we are discussing is the same thing.  The private data is
allocated in attach() and freed in detach().  The detach has no need to check
for NULL because we can't detach something which isn't attached.

The other NULL checks are in agilent_82357a_driver_disconnect(),
agilent_82357a_driver_suspend() and agilent_82357a_driver_resume().  And there
the NULL checks are required because it could happen when the driver isn't
attached.

I also did a quick glance through to see if any of the functions which didn't
check for NULL should get a NULL check but they all seemed okay because either
the board was attached or the caller had a NULL check.

So I think we can just remove this one NULL check and everything else makes
sense.

regards,
dan carpenter

