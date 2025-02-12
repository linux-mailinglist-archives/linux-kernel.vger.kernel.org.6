Return-Path: <linux-kernel+bounces-511237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16AA32827
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C191678B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1A20F06F;
	Wed, 12 Feb 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3SMC5GI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3F219ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369564; cv=none; b=as1rJB2tmpgAsWW9WFx8mo35UyDio73zPAqQKoUV+FioCzCP3nqLco/S5oO+UXJGGNAmtiRUeEjLJTqo5uQtl1dCFr6z4ntr8k4afw2UMRwlDIDHZHjf4A2z23pxX5RsPd3iEju8daoIof7yma7fHdWkASSqGYRQvUBVE13e0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369564; c=relaxed/simple;
	bh=0PgnPZsTGuDed6/z9wwIBHpTcSBe6JCKQsHjTB4Bkms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOTJGIJgLBnYFXNfqpQcvixsVe/OuQ4MMzvzK3sNUcEx7aCSLiJwp1H6AATPR8lQEOSy4/BJDMdaGDO8WpvzJX5S+SlYovnsrZDqPs52iU8G+CDPClnqxIdMfnV/2GqpLQ+mQmKMBCSTBII3gv5CpS+72lc+WFD8m0r1zJKQOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3SMC5GI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f3c119fe6so155294265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369561; x=1739974361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYU4s5CugQUFhnoWcNFYM55BtxMFvGMOkBes3VyQjjc=;
        b=f3SMC5GILB4epmGPy3kd50Bx9NrUvhHpvtVjqNqOgziei3zseALIN+jWYEsEOp3clJ
         PwSAPcPJtAk707F2h5M0pUOp1S4DkY1XLfnw1EuNbf2aaIXq52vV3GS26Hg4MLYM4ztA
         yShL1OgH68YXYHLkQjHDiLv2UFF9D65H3y+d9mAS+I2jAyQ3o/hYw5yuSpVw/c/k9cx5
         bMfzukfgr5CKaui4PPd2XNU4GTRJwHSvDtDheN6rHovaKxQc/ds72neWOvL/pfYhoMjV
         VT1xJA/030z+9uszp5zCU/dINghc/SJWJ1CNlvlWWTRzl6g6bh2HMsEIyhfG8qQBTWYq
         4TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369561; x=1739974361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYU4s5CugQUFhnoWcNFYM55BtxMFvGMOkBes3VyQjjc=;
        b=xG5G1JXUgfHG306i4Xu+7UdBDUuDFuEmMuICyw08hnzLkekn8MsobmviM33BPuJyJ3
         A+p2An9XNPPyIgfZxEYgLNVlo7pi/BiqcuUaYNuDP2iCkKh+no5hM/wRCVS6DT2n8TpF
         XkcNi1/6xB1Nuo9DAVzDixj0fjQW0SPnt0OSDd2+74edlp2CgLdJUvFwUXDLlyIjb5dl
         o0JHSKGTnbnZAMRjsV4xV4w5Dz2/EuVE4UifOHwyqKMV8PGTxfBGlMXPsTaC0QAbLpH4
         bEDuGpVeTxiYnHSwxdWl0kpgdFcWsRTa3Re4PSt+bwDjOrBvHHEpKDGrF4hZjZSExUft
         teqg==
X-Forwarded-Encrypted: i=1; AJvYcCXLim81+Hllv3OKi5MIs9fwaiu08ikLQN0eDpveofcin8OOIZSOMc7spqndfu6uaptlvWTuc57w0GoSVYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3LUgM1ijRZvxVjjBZ0+yd2iO4K6qzP/2K51yAKNf7P/VyyNQu
	izkLxJO4KP1PAvbLa4fgdGsJN+z6VWiWL5RDwHOyI5y+5T1K8Ot1
X-Gm-Gg: ASbGncu+UKg+a3frvvvXizApcX7v9s2ciB0NUSNAvUY9womzFsS6w4TNMBwlR+adOGg
	mzRX+iijgOj5dHe5qXLysD4TEUXW5WIvT5OMMJVZ6wz3D9r2lrM1eBu42umOrHc1ZbkIll3Soyh
	EKTeAMAOWGIb+9t9rjiqm0OkwEtBxTUb+aw8xjynTmCzL5m5Wcpyo9CcFFwpaJkgkLnXPJ78kgO
	AheeqplXf7zh0jvHQfcxz5FR+weRAujy+0Hy9qYTinCqXtSpMBJW5MHWLiuxD3TI7Yd3YRu+/o9
	r3APnP3WfFMtCUc=
X-Google-Smtp-Source: AGHT+IF4x03U2XL3LMqaq/QOPxrusKrZy/Z5j5Q0xTubyppnVW51XdIuOjSID/gBJx3Z/XLDh1+oyQ==
X-Received: by 2002:a05:6a20:258e:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1ee5c732f01mr6135206637.1.1739369560933;
        Wed, 12 Feb 2025 06:12:40 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7e6dsm11194417b3a.70.2025.02.12.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:12:40 -0800 (PST)
Date: Wed, 12 Feb 2025 09:12:36 -0500
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, anshuman.khandual@arm.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] uapi: Refactor __GENMASK_ULL() for speed-up
Message-ID: <Z6ysVBWFRfdFdLlT@thinkpad>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-3-richard120310@gmail.com>
 <20250211223045.5c2b92a4@pumpkin>
 <Z6yWbROu5rREhw85@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6yWbROu5rREhw85@vaxr-BM6660-BM6360>

+ Matthias, Andrew

On Wed, Feb 12, 2025 at 08:39:09PM +0800, I Hsin Cheng wrote:
> On Tue, Feb 11, 2025 at 10:30:45PM +0000, David Laight wrote:
> > On Wed, 12 Feb 2025 00:24:12 +0800
> > I Hsin Cheng <richard120310@gmail.com> wrote:
> > 
> > > The calculation of "((~_ULL(0)) - (_ULL(1) << (l)) + 1)" is to generate
> > > a bitmask with "l" trailing zeroes, which is equivalent to
> > > "(~_ULL(0) << (l))".
> > 
> > Yes, and if you look through the commit history you'll see it was changed
> > to avoid a compiler warning about the shift losing significant bits.
> > So you are just reverting that change and the compiler warnings will
> > reappear.
> > For non-constants I suspect that (2ul << hi) - (1ul << lo) is the
> > best answer.
> > But the compiler (clang with some options?) will still complain
> > for constants when trying to set the high bit.
> > 
> > That version also doesn't need BITS_PER_[U]LONG.
> > While that is valid for C, the _ULL() are there for the assembler
> > (when they are no-ops) so there is no way asm copies can be right
> > for both GENMASK() ans GENMASK_ULL().
> > 
> > 	David
> 
> Hi David,
> 
> Thanks for the review!
> 
> > Yes, and if you look through the commit history you'll see it was changed
> > to avoid a compiler warning about the shift losing significant bits.
> 
> I've browse through the commits of include/linux/bits.h , where
> GENMASK() was placed under. Though I didn't find specific commit of it,
> would you be so kind to paste the link of the commit?

It's c32ee3d9abd284b4f ("bitops: avoid integer overflow in GENMASK(_ULL)").

[From cover letter] 

> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/2 grow/shrink: 46/510 up/down: 464/-1733 (-1269)

You can see, Andrew tested it and found no changes in .text size. If that
has changed, we need to revert the original patch and suppress warning.

Can you please print the full bloat-o-meter result? Which compiler(s) did
you try?

Thanks,
Yury

