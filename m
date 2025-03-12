Return-Path: <linux-kernel+bounces-558347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2164A5E49E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819401898723
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA9C2586E2;
	Wed, 12 Mar 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGQ90LgB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B231BD9DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808432; cv=none; b=uXwX6EdzTACQwdIqPm5Xb32t4W+byN7dF9C8eV1v60YovCR/9z3WWzLZnhsYRMtK9i8iPL9wFRLcTtWa66TkoqfQSKn8RXLm2t7GWkINRPKibDOMveMuWY2N8OdRZe5QMK9I5vLA/y7ZJ0dRZAPIUaDgQBycrsneoBqR09KNpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808432; c=relaxed/simple;
	bh=0sfjWz9/dfa5XlkZjoh3Px9tGDJeE+Y8rOqWI/cZvJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0Hu3r8a0RP4rMNAerPU7TJ8xy9z+2H4R0r5xNWA/b4qbPGGicH4DyVqfKOjUsvHSN3TRt3aXFJXrqgw8VqDQ7RTqcZmrsAP9lRLjZwT0m35iqHgcYU3T2guqOvch9Z4cZ63vI1BG6Rvwe+LWm1YjKyC/0S0QCLra2TfWrNOTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGQ90LgB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so1270085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741808429; x=1742413229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS8kTorDyOHdKsMto1ObS5FPe8uF59EmpLR3eUldbQU=;
        b=RGQ90LgBuEk72vAps+CDGcFcILMyvF5AT7vhxJEpHWgxUgySpxat4kW+KLwSGh71/E
         28xjX/bPfpg7BA2EMoF6rtiXGD7ZofY4fWv5tTmfCKJMXUArn6GP1qDidc6u6I7nkYv7
         PtSJz2Mo4dsq8Z5oWytX5RSw+fjLCom+typdOPw2AEzx5/J+xEhdYRKms7vaomqKACUv
         uyl+nmBEusZ45/GoxPqZ1RDHdvQsP2Mbfvvt+wkNznp97zygge/7Y4oqkYVU4SPfwE3/
         aghWfEuPqQQ3/XUFN6hVDNqqFGXH+deyVO6mmfhNey9POTXbPrcOVflNjrE4wexiGVBR
         Zk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808429; x=1742413229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS8kTorDyOHdKsMto1ObS5FPe8uF59EmpLR3eUldbQU=;
        b=Tind80wYTiFFYDSHpR5Kx6RbalQz3RH9Wmy1gKSLCmi99z7/MRAKdV3XlWiOGTU/sh
         5kGggKnRE+rCH92o0vLIzIT+hExUFO5hhiwNSui4Qo54YryVvfcJPSkeznvBnI0lkTWZ
         TeZaa2W0boFvasac3v5ptPZM61eC9R5pUIWocSBCOyOzsW3UMsUWx0udZl16aVS5WMVo
         YnBqZMOK9VNDmvR+h/Z707J6d2vwJ4+gFnvvBDNYYxIbEF9Flf/dDs8igGPU9Y+V5TU4
         AX0HTzs/DRSesefi63wjMaI6csdRgzBL06zsT6Lw1I3pQHxJZDgNFiWwKqX/rEzUMudW
         nkWQ==
X-Gm-Message-State: AOJu0Yx3k42utvuvSW/36RYbTMShNEWAPonxBM3ZMuOHngjJUHS+OGZP
	cOokowWk8qDv/74UCU125pJ0jSdZultYGZIb94DteZ/FudNNxtYn
X-Gm-Gg: ASbGnctB9f4o2Lvtz98CMajfpzJnVZ1cN5a46QTNzokIC2LFxENxpTctXoSdiED3occ
	kWMVk5a49nQfF1UVk/+Fk5AhWYMqwtGeEGPP0h4zkplreWKhmAkKuxugUTUF0cjuazXYMYWEyEX
	349LKaRviLs4Ny+UGNq9SyBQkSyIHwpF6NxrYPleqInQA8cEIM582kn3YsJJZWIsySd6YLeENzM
	5azR3gKUwnVbDTno8imQ7rfqJ9Kv7F8R47GbaXRpUVCsry5X83XUsz4sDwu/5TGqi8PCX1wICBP
	QZ6Uc3QNqw3c14ywD7OJju3CWZClAP/hC9f9WFOUB0IGy/Ul0xGie+J658Tp6t+UmKyFE2lWTxN
	3o0qNQNo=
X-Google-Smtp-Source: AGHT+IGoyh5LSAaHpp83B2PFWGk/1MertXP2HJBTaGWTdaMqGJ4/sfh9KZzasVwSZJfDKzCVDsslfQ==
X-Received: by 2002:a05:600c:524d:b0:43c:f470:75df with SMTP id 5b1f17b1804b1-43cf470797emr122311905e9.3.1741808428650;
        Wed, 12 Mar 2025 12:40:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d031d1438sm32442805e9.0.2025.03.12.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:40:28 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:40:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH next 5/8] test_hexdump: Fix sample output if zero bytes
 requested
Message-ID: <20250312194027.70c38581@pumpkin>
In-Reply-To: <Z86qy5LOAJUlmkC9@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
	<20250308093452.3742-6-david.laight.linux@gmail.com>
	<Z86qy5LOAJUlmkC9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:03:07 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 08, 2025 at 09:34:49AM +0000, David Laight wrote:
> > If 'len' is zero the expected output is an empty string even if
> > 'ascii' is requested.  
> 
> It's related to the previous one...
> So, seems to me the series need a bit more (re-)thinking...
> 

Nope, all its own bug.
This is a request to hexdump zero bytes into a valid buffer size.
hex_dump_to_buffer() gets it right unless the output buffer length
is also zero.

Found when I started doing a full range of tests.

	David

