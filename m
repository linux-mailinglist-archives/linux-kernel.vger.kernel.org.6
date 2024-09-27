Return-Path: <linux-kernel+bounces-341928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA498887D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833C31F21A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9A017ADF0;
	Fri, 27 Sep 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbBEBMQi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3118B1A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451967; cv=none; b=Xm9c4200z8dJg195SqPGzw802noA18TZYO/ScAG6Pdoiag4sutZ+GmwtkDXEuuRDGn1yfmZKqFaM6J6bzdBqKu7wYILy7PPziDJ5EyNMGj9E/BVrJ7qrRdAV4VlheXB5L93vzD+p1Veqir02DRL+rjXzCiRWEMMgBBZSi5r4MDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451967; c=relaxed/simple;
	bh=AgyJyFGOgZH64q64HKY97dB03AkZI1CBZpgFYlnxgz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8IwW0mHwr7oXHTm+oR+xeoYusQU7KWj2s3Y+PXpMS98zq/XZGVF9p03DdTKQU/lEApBwMmD3rwd24X4Tyu7SFUgq7M/lpyYet4qydM5shTEFtemB+WSzRUA/9e5C8AaPHsjIo+Z4HkHHhobPbW2WwcKQDqm6d2jNiPijNhRshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbBEBMQi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d4093722bso317340366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727451963; x=1728056763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/WxW8gZW6eJDpQYWMQr0oHbrmDPE0iNGmBYL31OUvU=;
        b=rbBEBMQirEOfjKuIqwEqj+/pQ+RnS5FQq/781ddjRhMTh3095RI0wGseKKmNRaP+y/
         pCOrTX7iami3QopJqVudQkRgPYenmN9lKcaX0ImKM4fzPgyy44YrSL9wBg4X3BygyeaU
         PsRfzc8jthdfVlX33i0o+YIjZnwsop/8LvF/YvlQStc6UxABUvfHswKoQkBC0KBWRPDS
         krbkiyxe8/lOme/xMFQVKto3B/MCjbF87z5Tn0EewOuPI7IXZwnhxV+KiIZMZTKh1NEq
         VT/pBlucAPNJIgevLHLOut92QhEBmvBFqLz8tM7Gdf8vJY/oEL1VcdM/G3EHPxbU7n0i
         /EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727451963; x=1728056763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/WxW8gZW6eJDpQYWMQr0oHbrmDPE0iNGmBYL31OUvU=;
        b=ag6i7VEkEd1LbN3y3TOP8MwaHe1A860Dtqmj85RH7XT76yB1VZdlK2YxAl8i9D53dT
         k3iamxvAmsXMGK6qJiUqkTxDsurmOS6ZmS3suJmoScW0O9FnvgT78kZWypL6cCCwChW6
         ovT6IuQEoDcuWZbQYik2e5AYasQ9Tvo6t8GianTCQ3yWtwd7IKDoEfEyWE0IVyLatdyW
         KJFWIO0AqwILkYzb+/m2Qr9aOo0WUNjaGWneG1l3XPmtCdpoE+IPwXTuwL4RtTcoSkLl
         f3DAl7XqYcz4RF8kL0Cdv7PWjuFjHgXCjtiDH5C7dUQ2MlAPtc3ySuPRy8P3nuo0SuiD
         5HsA==
X-Forwarded-Encrypted: i=1; AJvYcCV0P163q95Tv7XQx7ar2jLBcq36iZymjv/l70GgdrPN7PuzSOJPt95Qk7IQghUSCklTHjJtQqWK5701TZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ezrSMoyzSA7hH5vihBQWCYrmTxcqVaq8ie0EpXTPNwStihNN
	4NtPjTgxfqTjGrxmMP6X+RfP8NNWj4VfPh+73t2kVLzVfm1Tu//lmqmjnhY+m44S/Uj7uNTX23b
	l
X-Google-Smtp-Source: AGHT+IFS8zAPgdbQYxtGlbbfShLRGKJ+Y1jDmj/muEsQvezrcrzsLgiLNr3FkrTisB6yxmTr8mVPyw==
X-Received: by 2002:a5d:67ca:0:b0:374:c23a:2ce8 with SMTP id ffacd0b85a97d-37cd5b11da6mr2512494f8f.52.1727451963205;
        Fri, 27 Sep 2024 08:46:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec169sm30953325e9.21.2024.09.27.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:46:02 -0700 (PDT)
Date: Fri, 27 Sep 2024 18:45:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xingquan Liu <b1n@b1n.io>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
Message-ID: <75267b21-f800-41a5-8a7a-ddbf0062ffcd@stanley.mountain>
References: <20240927151637.82772-1-b1n@b1n.io>
 <9bf11c06-85c7-4ef0-ba26-e4780a28f23c@stanley.mountain>
 <D4H6EYM973NS.13D8BVWVTVO2D@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4H6EYM973NS.13D8BVWVTVO2D@b1n.io>

On Fri, Sep 27, 2024 at 03:36:42PM +0000, Xingquan Liu wrote:
> On Fri Sep 27, 2024 at 11:26 PM CST, Dan Carpenter wrote:
> > On Fri, Sep 27, 2024 at 11:16:36PM +0800, Xingquan Liu wrote:
> > > Fix all unnecessary parentheses warnings in checkpath.
> > >
> > > Signed-off-by: Xingquan Liu <b1n@b1n.io>
> > > ---
> > > I ran clang-format additionally because I noticed the Linux community
> > > recommends submitting code formatting patches along with other patches.
> > 
> > Probably avoid running clang-format.  If we wanted to do that, we could have
> > done it already.
> 
> Ok.
> 
> > >
> > > I'm not sure if there are any issues with this.
> > 
> > This patch does way too many things at once.  This is a long way away from being
> > something we would even look at.
> 
> I wanna fix all unnecessary parentheses warnings in one patch, is it ok?

Greg doesn't agree with checkpatch about unnecessary parentheses.  If the code
looks like this:

	if ((a == b) || (b == c)) {

then just ignore checkpatch.  However if the code looks like:

	p = &(foo);

Then change it to:

	p = &foo;

This sort of change would need to be split up by driver instead of all of
driver/staging.  So it would be a series of patches.  You don't need to split
it up by file.  Split it by driver.

regards,
dan carpenter


