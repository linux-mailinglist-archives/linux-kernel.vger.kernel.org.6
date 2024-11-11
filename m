Return-Path: <linux-kernel+bounces-404036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0499C3E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D63B233DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC7157E78;
	Mon, 11 Nov 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RF69mMCl"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4119CC0C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327289; cv=none; b=Fty/iwSXzf1dA5O2e7tgcWM2fkPolpaSWoPh52uJpc6lRQm4qTeFIxVOWIZu4MP8c1a13Na2P/hCepktvc0U0smQqs7SRPlQ8zNx56x3j6ZGRLfT8VEbEhzo6BZgjbh5/EgDeAscs7wdONjECyrIiXsU3NHTnEUFkxU2qUck74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327289; c=relaxed/simple;
	bh=bCmkc8IhJg96cUKot6LTRxchDsOoI7gWkzDhDIbbynE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/blKW98GuWAPJQvjh51/K3/8vwdMnc+HYyBsS94XOUcH+qzzPy9AJCL29kVDoDZnULDKlD4EmGQFUPmKbr0Zlo89wcuEoq2/QcempR2akhthdVS8oEkRMwSJqVsCizAn9Hqv3Vkypyr0I58P/YyoTtnHEWEbT9hfRf01ex9wU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RF69mMCl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so346234f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731327286; x=1731932086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCmkc8IhJg96cUKot6LTRxchDsOoI7gWkzDhDIbbynE=;
        b=RF69mMClLAVteKQzIp6aaq9z9Iswcq3fo6JmNlWUqfspD4GvMsyh1bphcdmU25Tbkd
         0OCKuoVi1GrwWk+BthcKYVdfOf1GPCMBMQ304SYU6KIHkf5+9Sr3iXUQ/8+JxIg4TA9W
         CVfSn+hTZ0OMzw5jmTPL/SifqLqGEbgo5rmKJDz3zC9euP5E18yZqIR+vA0p0W4Gp3eR
         GMX9CXgNlEYgVuTKzrD+htFMmCcnuUpUkAvDWP+Qm9Bgsumeq0s74wD+tZqYhJhONSJv
         1E4nljKHEOp9cvHIvsVCv+Q+JR8yJgzz00bJtqnYgME8hvKGfeHsRBcOO0Q435NwTDA9
         rZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731327286; x=1731932086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCmkc8IhJg96cUKot6LTRxchDsOoI7gWkzDhDIbbynE=;
        b=KuJrtSh/sVFAxsW4/dAkbfigtwScHJ+XPkHNfIWR3qAryE4W8I02g1UJ6wX2WU49D0
         sDTmJfyyq5F0HsK4G402nPflz2Rp5sqoxyOLy5BSLO7ehCoowVsO8jHDQBRGxEyTPGSx
         An/MqVJr/vYhbP1Y8WazgKFy1so+ZS7FwnopZzDauSf3jezqk7xsmNKd0pF/za6hkTCo
         j05OMapzkxiCjUdX0N7E8bVz7YpQyJOlbgkOikX10hVKWBdTE3Na2KUMTI44BnpAHO0T
         l4J2Vx+ZFMxBiGsi353VGi2woO+/WTdxUXomxoeHzQrItg17xnayzxCaKIaNpPOHeHIJ
         y7dA==
X-Forwarded-Encrypted: i=1; AJvYcCVfudg/jOdR69DCCUJlyChrrehlIt3ZhXx592Crf/zkoEjaBRPF3SXfkBvV7XEBdOGTT+5bR2M+dRJnmD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoyt7tWf4oNiwBbtqCGvztiDojiDcBA/aDX0Bm/gyY3lL7nYK1
	cKkdZgv2o84S9B7oHtbOCBSas7wuEE4p8Hf1ZPoSnVfIb50egVW+7zrIn3/2bxk=
X-Google-Smtp-Source: AGHT+IHCRPUSYQt4b35RRCC0MExvKCiN6ZaaIP+qXuxUzocpsZ6HQ17+o55xl13WnIQe42xbI8c9dw==
X-Received: by 2002:a05:6000:1ac5:b0:37d:4517:acfb with SMTP id ffacd0b85a97d-381f17143d1mr3889776f8f.2.1731327285838;
        Mon, 11 Nov 2024 04:14:45 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ec9fsm12916332f8f.42.2024.11.11.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:14:45 -0800 (PST)
Date: Mon, 11 Nov 2024 13:14:42 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241111131442.51738a30@mordecai.tesarici.cz>
In-Reply-To: <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Thu, 17 Oct 2024 13:32:43 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

>[...]
> I understand that Suse might be able to help with wider performance testing

Sorry for the delay (vacation, other tasks). Anyway, let me share some
results with you.

First, I have looked only at 4k pages (constant v. selected at boot
time) so far.

Second, the impact of the patch series is much smaller than I expected.
Most macro-benchmarks (dbench, io-bench) did not see any significant
slowdown. There appears to be a performance hit of approx. 1-2%, but
that's within noise, and I can't dedicate my time to running extensive
tests to find the distribution peak and compare. In short, I suspect a
slight performance hit, but I cannot quantify it.

Third, a few micro-benchmarks saw a significant regression.

Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
slower with variable page size. I don't know why, but I'm looking into
it. The system() library call was also about 18% slower, but that might
be related.

The dup() syscall was up to 5% slower (depends on underlying filesystem
type).

VMA unmap was slower for some sizes, but the pattern seemed random,
sometimes giving even better performance with variable page size, so
this micro-benchmark may be too unstable to draw any conclusions.

Stay tuned
Petr T

