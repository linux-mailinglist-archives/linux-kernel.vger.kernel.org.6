Return-Path: <linux-kernel+bounces-558325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A051DA5E45F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2324B3BD46C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47419258CD5;
	Wed, 12 Mar 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Ofx+L6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46B258CC0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807698; cv=none; b=NTAqh5w5RvFsFBfzX7zpfVNxkDvqqOZmt2dcpMmTTTB7KgKkleRzikPZZlae+MCNkKSEDj8W+5U2dOz+TUlsG7cENtoY6f8JT4JM86RyCSr+JrJ7gWX2NWMWZQvc3jUT+HO+fAqPtzZ+av+IKZMBWa2WHjzgCsBzYl1NDow/lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807698; c=relaxed/simple;
	bh=s3g2eebk332dZ8skpCoN74mvYgcDzuv1avH7zP4dy3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4UP+ShHNgrmq79xQFbqekMR0x8gwnZBBs3iEaWguiqw37tGT9YDai6xPOcW5Q1G25tsPWuTvZmByLfZXfh1rmrvuuP3rLqN7+04GEzcLC7iyB0UraHl3Phq9S7X4o2s3R3aKai4r7HTZwt26a4hDTE5AkxWMghvA10iI7MmzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Ofx+L6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso1345215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807694; x=1742412494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V/jSnFbWDI0+QWL0cUoi4molZeZWfWefVGI40M+HXU=;
        b=g2Ofx+L6U1NHlTvRZh3So1OvO1EKYIrb8m+2oIY8/jbGpaLneq9oJLNyPQQzDSavKL
         6Tnef0n1EgCKMoh6vidhAoGr9WXSw5u3TtgyG+IjsnTiaQpCkR7L0CfVULugNn/SM2MF
         qA4e3M/qsIrObOB/qSiDMa1y07kJx2ESc3N005gXfFmhlBcPC19DbcB0Gobvb8HRpCGW
         yzNDmpL/J9TYf0SCsgfCD/UpCgh2qanSrquSiwZBEhYrkSBsJ9VcozUF2sFCiB4dHsxU
         vFql39HmlhnwIRhmocbxz3XxOBDcOybDXkQBAGtXdjLv1U0Lmaq9BViz0+GLJW2gllvf
         56Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807694; x=1742412494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V/jSnFbWDI0+QWL0cUoi4molZeZWfWefVGI40M+HXU=;
        b=W6bmqjcDtKxZBn9yHbUJaW/0qyyRFlVSnNGVOQhjbqolbDMWj2i85OFo1iR9zuJe12
         LHLqGUP+p7+KyOkI2dVGZpcpxx2gpZizg0J4+sgARLHdkTMbgmj3lhCQfAvgbmbg1fRG
         zE4FLkPGGhXsc6oYv/nhjpAJBZSNrCJvQQj6Jw+CMCsYXlHhWpqNfL1GxvYDTIlEPdFv
         KwVT3P1RC0zZfsagoKnajo7A1NzpF26yYYtiLuRrpASCJ4fqnRk7U+3SXNawm2gHL97J
         QDbjNb8hf4brMZO42nFPUFZ99KePf64D1c4pFCsINgXG1XpU6AQRujqveqXvEJ638olg
         fcTg==
X-Gm-Message-State: AOJu0YxEBhpHIqP0bjPfX/cfe9+1Yur6IXGnxThVHjr5fHbRGvezt0Cu
	4gWyibjuaD3MiJrqfMZ+WFwyYPXnUQQoSASTromf9pqkAyyTxX0V
X-Gm-Gg: ASbGnct6eRF+aEZtnO598yKwftBArkFyabRpZZjo0fvrkJBiSCiCsIBtBagQAa8kwki
	Cl028rstZQ3Ild4aIXGMAie2bd8CVEOI+kUhL/+M1Y+nsdvfkSs5U0fOqwRrxWwhnOuO4uaXtKu
	iHkYj2xW/pMoQZTAej6FeINXvz/ArhmI5FBkOb7ndk/B2dEroi49HhlWky6SzN7NwKp9idZs9+w
	7UrYoe3L3Wv0Mbc++2AZslGWpl5wkfGid/qZeeONcTVXf7IR7+ThkMGuEd6t62E7GGFALgQbzKY
	DxtZ7mEjtEFZ+ekAsdyYhPOok1F/0NH0pzi4gBOIkC8ADPXTTHyJzaZGYzRHDRLm6B9RPVRIgNU
	vWfNajbk=
X-Google-Smtp-Source: AGHT+IE31YQMp6AiWQEOmcHXJBfyfaZ9xyWvk4FeVhH3FatglAB5lSaUEW2pv57+YzwZAPxb3XKClg==
X-Received: by 2002:a05:600c:1c93:b0:43c:e5c2:3ae with SMTP id 5b1f17b1804b1-43ce5c20632mr190871665e9.5.1741807693251;
        Wed, 12 Mar 2025 12:28:13 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a757b5asm29581835e9.17.2025.03.12.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:28:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:28:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH next 2/8] test_hexdump: Create test output data from the
 binary input data buffer
Message-ID: <20250312192811.7632a936@pumpkin>
In-Reply-To: <Z86jTvOdq0fgvqRO@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
	<20250308093452.3742-3-david.laight.linux@gmail.com>
	<Z86jTvOdq0fgvqRO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 10:31:10 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 08, 2025 at 09:34:46AM +0000, David Laight wrote:
> > Using the same data that is passed to hex_dump_to_buffer() lets
> > the tests be expanded to test different input data bytes.  
> 
> Do we really need to kill the static test cases?
> Are they anyhow harmful?
> 

I was asked to add some extra tests for other byte values.
The static result buffers just get in the way.

They are also not necessary since the tests are comparing the output
of two (hopefully) different implementations and checking they are
the same.

	David


