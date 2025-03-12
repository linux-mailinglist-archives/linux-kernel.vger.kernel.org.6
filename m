Return-Path: <linux-kernel+bounces-558342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3ECA5E492
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80323B4696
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A252571A5;
	Wed, 12 Mar 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uti+ssXi"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054771E8353
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808249; cv=none; b=ZXGAPTyWZt+Smea20Wfjdjkj0J6qeCREchvufR0AcbV6Jp5S3mBmpD1Pebm3EtvnnBCMz5ayd/BIJT3gYEX4B8KZ+p9T01gMIoVCiLpDd2p8YbYOehWvGCfkqKGjXkLiDba7OYbn7t9nK/dRiQzeZ11oLWQrr6LGaJOtAcT402Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808249; c=relaxed/simple;
	bh=r/VCQD83HQUFyxiJuyUV5AYSbJAUtvEnXV2gmKuoOUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Louul6iEhx4tFsBKMhLsuObmI+gL2IZd8QXCfZ9BLFZcsMNrEREbE7kGHdPlc2qvl1bJe/gVGqyUhky3orjyLHOJVI5p8DZbrChRamSmIMP5Av3vh9JXfehSd9KKT9HxLlgDOthLEW+kQXxtFzBeGNtnCWJ61FlPCycm1Iu4Rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uti+ssXi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso1033605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741808246; x=1742413046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MeVWl1il0Bq1XAh1SlC+3/hqUDBCvNoRp00Z0acLZ4=;
        b=Uti+ssXifAAHlxkLxJVhF5CP0yZsqTgNuEVyhT3Xv/A1XVL5ydfdUt9y/ggSsISu9L
         1yrF03qf789PpuncivWNHPPqQH6C2XKeNjrfZUVuwDscaKoHW1l0NTT2n6/MEq3Iy6df
         KL1tpRxVl/7F6XpvNos9Zuw/xkosSMXjS6+G80LX7mvTybd+42/244UaSlYp+E2L3A39
         zcsDutL3f1kc9TbvrTR9Xliv8f0Pqiyd98VSrL+xFBh4cSiByhX98H+F9hNvNp2hNvBA
         dWWckfR+mc4I6+aD4Yp70gIhaFMsuwsfhwN5+iRlq0l1tfmfcNN4BlQo//U66SFA3y1k
         ozUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808246; x=1742413046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MeVWl1il0Bq1XAh1SlC+3/hqUDBCvNoRp00Z0acLZ4=;
        b=qVMNJwXf3/LcOjVmLyiiH+Ztr3LbT/knko+YUvkJjgjBEgCTmKb0skE3LM6XWTb2G0
         myc/iao3epngIG1BYMOEGkZIObvuItUUDxCY26XgL/F76qtyoelb5xIQ9kgKt91PAONi
         jPccDqpzUocITJw2U/l1hD/RpvE3v9sWOn+o0dDNTXCQWle9Er7lp63lHriOEFMHD2et
         /Pj8c2ZoYH0ez08lchhd8eg1ZhFr+qKanXkRS+QUIDa6yHd/SYqLdB+BRZF6C41hJQcI
         6jyo1beJRLX85jh0PgTJEb0oOi9ldaQwpwYkazoYYVSz/uH/E3rraS5LtZR3DazUn7qI
         +BKg==
X-Gm-Message-State: AOJu0Yw4w1TlHbYz8AY1jbIl0x0ufzhFUasdtBuqb740I+AryQKTvVdr
	hu+soBJGQr8hhiJgaJyI8cpimnj7VvJ90FE+MdAdhlfYctxivR/2
X-Gm-Gg: ASbGnctW0J0KWMZU5t7s2xC/orvwAQngt/nT9HOHQSVWsEQiXXSEiIdwGTMuEFvlLMO
	CVyelt3Cr7tHAxpL241iZcZQmJlzycb7sHeVG0kOyEQPGEDxmpadcfBytJu85/1pkBDRZHXovKW
	co4pbwVtEbFeyQ7aNoXQtawju1SCznAfXON+YZ4j0h4cYdGCHuq/OwIJV3jsxX8Ur0ywuDbc46q
	KD6QU6ENU6jvFSOLSb1AZ7Q6CruWQFn5pyDqifpxdqO5julE5huMM2aP8DPITbdZY3uJ0+e5brG
	gWI63l5dpx1vDzWg8yhO6RDZ7+Hx0jCVdo2aZ67AVHQzUpuB24RpTpmwVlU9FiFRgTSxVbj17l4
	SgixXduc=
X-Google-Smtp-Source: AGHT+IE+I9Dwy4yWioW1XFBdyEtYM7hpUKKM8Glvb4IiHyBtfEYR/lr2uCPiDxiAYg6k+X13VmYHBw==
X-Received: by 2002:a05:600c:510c:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43d045a9259mr79985095e9.30.1741808245975;
        Wed, 12 Mar 2025 12:37:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7310f7sm30588745e9.3.2025.03.12.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:37:25 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:37:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH next 4/8] test_hexdump: Check for buffer overrun of
 sample output buffer
Message-ID: <20250312193724.294c84b2@pumpkin>
In-Reply-To: <Z86qacj2hchPyFGK@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
	<20250308093452.3742-5-david.laight.linux@gmail.com>
	<Z86qacj2hchPyFGK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:01:29 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 08, 2025 at 09:34:48AM +0000, David Laight wrote:
> > While the output generated by test_hexdump_prepare_test() shouldn't
> > be longer than the size of the buffer passed, for safety verify that
> > the buffer is long enough.
> > If too short fill the buffer with an error message - output on
> > test failure.  
> 
> Isn't the function should behave snprintf() alike?
> I think this patch is simply wrong because it's based on a wrong assumption.
> 

The normal hex_dump_to_buffer() is snprintf() like.

But, as the tests are written, test_hexdump_prepare_test() is always
passed a fixed size buffer that should be big enough.
The test control code then truncates the output to the required length
and fills the rest of the buffer with '#' before the compare.

The 'testlen' (output buffer length) parameter is actually ignored.
So if someone adds a test that would request output longer than the
buffer (actually requires the 'rowsize' limit be relaxed) then the
test code overruns the on-stack buffer.
While the control code could be rewritten that would be more changes.
So it seemed best just to force the test to fail and make it obvious why.

	David

