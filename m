Return-Path: <linux-kernel+bounces-559086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C354AA5EF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EAB17D53C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0A1FBCB8;
	Thu, 13 Mar 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObMWDoR/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6321FA14E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857440; cv=none; b=mUCdOIU182wsdLW6+oK4hu58yV0S+jCrlKOB2GojRRG8PwwmM6EkA8xdQc7147wYCcgM+R3r5knI3Z0Na0q6L9GWoyp0n6U6Y9ZgpRzhvOIFnjl6OvxwdHQ8zCwUlmlTlLb0IU6uavTNbwbLgfPp23H4Gz83elitwEyUyfj5neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857440; c=relaxed/simple;
	bh=oAt2d9yMy0/XGghYj/fLOK2puoXGV28J6TCvTJdHHd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gpxenxe/coHPBPUXQRnPq8tcEK74U/q3BpYPPaZJZl/fAA9RNEz465w0svHcxsplHLYerOCNR2doBnIK3YT/jvtv9VBhvZPBmsac9KDxOIQKDCshlOI2PQ1Jwadg132oaq4F2S8VCz4qyfSnh4h66hg5B0X6FZ3jSVM+8dEc504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObMWDoR/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913b539aabso406952f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741857436; x=1742462236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAlpyObZA3aefY0Z3hfaLZstWI+s/7aOVbu9S30xU8E=;
        b=ObMWDoR/1TxfLE0RqUnz/6PIvTabvFehkBgSuyhYMuitC5aWzrMvIddzYZR6q4zFMT
         m4+rI+xqi6oJ5XrmVDiXGsJJJBalNaVV+40i4fW9nraFoe58IPlmC3XsyP0ZdGQLCBBF
         44D4MarFIgAoMSuhASeszaQP2z81BLJQT8yC+JewrUsCvw1CLh0ZavrVogoMjdzfDQ4L
         WrqDJKtHEbWR7qVAvstyCh5+Rd3c2N/UiX2NkSIJKrauqhbHcZLnmfjpf/c6YKBtKzmz
         nH2oE42h6L7iT9Smm/z2YO/WeciMkYJ+c35AnDaGEc1/69TgRrQTh/iS+kpkiBlvkd+5
         WfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857436; x=1742462236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAlpyObZA3aefY0Z3hfaLZstWI+s/7aOVbu9S30xU8E=;
        b=s9JCbaM8ttax4uvAuIfz35KDJwbqehbIVVin5SRdtzBkOOq5KEoVj62wUDg6Cq/jEQ
         i51dNKqhP42NmVTkvzbcvcHxZ9sAVrjZQwg0gqHRSPVRuFP0ASPZflXYTXJSD9sqrfRS
         bE7aOCWkfrBBCSWp9wH3o69hmJIFiu5vhbL2Aucj0LxoCQmv9lpkU+eBt9TQK6bhzEOa
         HGzlergf0naAnTp9gbsslieYrSmhpB4l9RZ7zZAetcP4vx4EkuMqwoV2XbLXX58mfXqQ
         rZnFQVbOATlMzROcglDDAJ3OLK5vLbYfAZwHmwElWbCz8gBPbxW/Ouo44eemWb2XuN77
         FemQ==
X-Gm-Message-State: AOJu0Yym93oTi/s8Mavj4SKQw+1lZDzM0Q4Ri9V+6pXLYvITEgAHLfTx
	LzpBvStur8+UHa0ZqkvszMyKL/6ibEbavuH0ViZQ4SAZscqZ7vGRmLPFtg==
X-Gm-Gg: ASbGncuMeXFrE2ZZxoQkCzcXX+syJTwUtMPqR4QLDg2GdQc4SRKYA3y2kC0ZFXq/v6t
	EEpztd6K6uZd91VlyBzm9CXMYcPoIqX8a/0uxxIJnFckzkfqj6fHGl1PkOL8685MwLv1b6N1tqr
	49B9XJXtWAhUpQJlmtNu67IWxt5Yh0qVW6CSUcWLP495nR0Q2gun0N6Xa73Rs9PTftAA5P+gOpV
	I2UlYpI9PftdxMl7a9KP4Zh2L3oGhjiJE6qfGebaMJNACwlkgu3HQ9wPZqa0KTtTKHAmM4DOzIb
	UuN3IBXtC/KR0R/VO9lxCF/t23hRb1RJm8ff5Qp8moK9Xo9PsEUsuXu5iL+lRe9w7wWjLgT1liI
	+Lg8tBwk=
X-Google-Smtp-Source: AGHT+IH4iGYRjUbjLzja1fTE6CTXE9NJOS5top0P7R1ktcTlB0sIX2ce3/JQW1GdKV/cI4Kz4T/iAw==
X-Received: by 2002:a05:6000:410a:b0:391:4559:8761 with SMTP id ffacd0b85a97d-39145598929mr10822738f8f.36.1741857436044;
        Thu, 13 Mar 2025 02:17:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebe4bsm1460594f8f.98.2025.03.13.02.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:17:15 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:17:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH next 2/8] test_hexdump: Create test output data from the
 binary input data buffer
Message-ID: <20250313091714.115978b6@pumpkin>
In-Reply-To: <Z9HiJM8VrXcglC5H@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
	<20250308093452.3742-3-david.laight.linux@gmail.com>
	<Z86jTvOdq0fgvqRO@smile.fi.intel.com>
	<20250312192811.7632a936@pumpkin>
	<Z9HiJM8VrXcglC5H@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 21:36:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 12, 2025 at 07:28:11PM +0000, David Laight wrote:
> > On Mon, 10 Mar 2025 10:31:10 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Sat, Mar 08, 2025 at 09:34:46AM +0000, David Laight wrote:  
> > > > Using the same data that is passed to hex_dump_to_buffer() lets
> > > > the tests be expanded to test different input data bytes.    
> > > 
> > > Do we really need to kill the static test cases?
> > > Are they anyhow harmful?  
> > 
> > I was asked to add some extra tests for other byte values.  
> 
> Right and thanks for doing that!
> 
> > The static result buffers just get in the way.
> > 
> > They are also not necessary since the tests are comparing the output
> > of two (hopefully) different implementations and checking they are
> > the same.  
> 
> Not necessary doesn't mean harmful or working wrong. I would leave them as is
> and just add a dynamic test cases on top. Static data is kinda randomised, but
> at the same time it's always the same through the test runs. IIRC your dynamic
> case generates the expected output and hence uses the code that also needs to
> be tested strictly speaking.
> 

The old data wasn't really randomised at all.
It tended to run a selected tests lots of times.
As an example there is no point randomly selecting between running the
'rowsize == 16' and 'rowsize == 32' tests several times when you can just
run each test once.

While that can make sense for some kinds of tests it is pointless here.
Much better to always run the same tests and to always cover the 'interesting'
cases - there are lots of very boring cases that all go through the same code
paths pretty much regardless of the implementation.
It is the corner cases that matter.

At one point I was testing all 'bufsize * len * rowsize * groupsize' tests.
Doesn't actually take long even though there are a lot of tests.
But there is just no point testing all the cases where the buffer is long
enough for the data. The boundary conditions are enough - and there are
actually under a dozen of them. The proposed tests do about 1000 just to
save working out which ones matter.

	David


