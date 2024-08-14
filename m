Return-Path: <linux-kernel+bounces-286976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6D952109
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A7B25A14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F21BC086;
	Wed, 14 Aug 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD9sPO1Y"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1561BC06F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656341; cv=none; b=SkgzrTsbDZBtkhO1J2FxAF41HSnE0hWulVn4MklU3WNEmtdUIOksQdb0179uzBIUZ/hOd2ANlm9Faaknj7FlFsTvttH6Hq+i4yalZLSWvc3v5bFx1y/jn6ercjqhsH19P2yx6EjiOatno+q7mr+2E0EZW1gIP24NcqvI1xT7uT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656341; c=relaxed/simple;
	bh=iSGDc92YB8Xz62KJ2sMRdwTqgaoG9SBAyBD79T/35xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjGv5mepytMKBoP2Vt8PT3YxXN5ognNNo/jGEmLthNQbJGrKxxwjSR+UlAEBNKCggCaCch2SQc4K89Mck3UbVGi0wwHBbZ927jFxntOmUAh8Bd0llW2eSwtBzNIvQA65Frw4ThXCOzyxB63yUhpuu8n4Qv2exKLpZ0/wGtHI1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD9sPO1Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3687fd09251so96536f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723656338; x=1724261138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSGDc92YB8Xz62KJ2sMRdwTqgaoG9SBAyBD79T/35xM=;
        b=kD9sPO1Y4pjJO71WBQ4mQV2Klm/G0KFBSZFIdUVl3iy/RvmHrWttrEwqVT1JU65Y7I
         7WQ+GMCaEQsCeXT7eQljEWXAHA+nf5VScrHUw3mj0l0IknhjBZdOMhnr6Lhcw4UtiXfd
         Nzd9mydTUjW4BmhnK+wh5SwYysZVRda+Tlu4PSWSbzq8j7v74TG7MBAOAExHFXv5t/4p
         6dpeozX77WLuCo5e2vkywT8GOJR42x9BR2limwwcXcQC4/miS3KyZApCn/6+/F2A0SyZ
         YZjZxJ37Qkl3dzBm8NBszT5qhdcSpmbTC66XypZ42uIs7ObSJYyPBcKHlSxavkNlykcu
         3Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656338; x=1724261138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSGDc92YB8Xz62KJ2sMRdwTqgaoG9SBAyBD79T/35xM=;
        b=ud+mDlVFe6nJeO5he9ZWwnxfSnAM112DPNQBESuK1bJrThdGAa+MyQgYUwSUQSz5F3
         yLGwnDlFsSUBg7pZwAADopIXKFoThnnRHRGa3uRgA3trM4Z9EWHP9f9jHwFKtnGG4/MS
         oFs4NjB5eRoVSByIq+YszUeWPwEAI5swHjua+LOXCH8qngd59DQOZaKWqZmLU9DgvT6p
         iHL+GbS64b1JqUg9Cj8MQ/MRFMPdVxOhKz83oxUMyAmwhWkWYRa41Kyl/1/sM2Cq4IaD
         IuzBu9W5qApxAlP8n51m3hHM9PiKfVZxopePBQMxoxcFqD4E8fpl0mSKBHXUfBA02gqD
         oBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhMPDJCDVSiWdKhXor4ZbsDHHSCgvivZNp9KRZ3s0XgKowwml/6ZIkrgh+GtSN1/78d+9UpKvDhLkZdu4CU2HIAkKy7hVbMGbfnjVM
X-Gm-Message-State: AOJu0YywZPpbBcsXXTrAXqZrLKOfVWVsi61rnX5HiWCBGzI3bxkwLAGH
	4wyeW2ttxBIncUx8zpCaJHSojAb4wVspPhW+CjBI/sSYNRQI64ZpOEnbV+GWRK/exPqXzicIDdy
	U/a50dtraKcCWJzmCDppcG6g4P/M=
X-Google-Smtp-Source: AGHT+IFZrDCZJu+/SfoAk2pNssejLEdY6fGxX4ExbCLkD0QmJP7TjuPGpiKJ1CaAS/v1XnmOu2bLAq+1IoQIL5jJkRM=
X-Received: by 2002:adf:f4cb:0:b0:368:460d:d942 with SMTP id
 ffacd0b85a97d-371777652abmr2412409f8f.24.1723656338199; Wed, 14 Aug 2024
 10:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814091005.969756-1-samuel.holland@sifive.com> <ZrzY8Kk-1PwZlezI@arm.com>
In-Reply-To: <ZrzY8Kk-1PwZlezI@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 19:25:27 +0200
Message-ID: <CA+fCnZftrStjxy-Wu+Zb5K2o2E_34dQis6qDiQnEQ3O2GTYBDA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix KASAN random tag seed initialization
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, linux-arm-kernel@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Ryo Takakura <takakura@valinux.co.jp>, 
	Shaoqin Huang <shahuang@redhat.com>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:19=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Wed, Aug 14, 2024 at 02:09:53AM -0700, Samuel Holland wrote:
> > Currently, kasan_init_sw_tags() is called before setup_per_cpu_areas(),
> > so per_cpu(prng_state, cpu) accesses the same address regardless of the
> > value of "cpu", and the same seed value gets copied to the percpu area
> > for every CPU. Fix this by moving the call to smp_prepare_boot_cpu(),
> > which is the first architecture hook after setup_per_cpu_areas().
>
> Even with the fix, given the lower resolution of get_cycles(), there's a
> good chance that we still have the same seed on all CPUs. If we want
> separate seeds, a better bet would be to initialise each CPU separately
> via the secondary_start_kernel() path. I'll let the KASAN people comment
> on whether that's important.

I think it's fine if we end up with the same seed: SW_TAGS KASAN is
just a debugging feature, not a mitigation. We just want some kind of
randomness.

Calling kasan_init_sw_tags() after setup_per_cpu_areas() seems
reasonable though.

