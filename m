Return-Path: <linux-kernel+bounces-267275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11356940F75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EB51C202DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B21A00E2;
	Tue, 30 Jul 2024 10:28:42 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBF1A00C1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335322; cv=none; b=Ohsfwnq5BToS41S94ak4fWVqppU+QTDR+yNiRa1n5unoXQR08Wl+pxKeUbT3M1+N5Z0q2OcTAIxSmle5ZPj7CWLGMeKyZmm5HllJu8UHytUfe6Qyh4uzqilQW/9OMne5vCHvCHELbN8uec8dvpt6MR86wpCXmiHKNgjF+fo4dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335322; c=relaxed/simple;
	bh=rOLHZJGWpfKBlfglkyuPs5+O+A/8QPBEOUV6PfojOK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ5fm9D2CHhYZdEIkx9fsDsnsQEGLawrzxA3FRZ5kiN4UQ7k1NIBJlZgDca7uT45kIMUQNdzVZewJgHcj72p9bs/fmuOBWKGLYHKga6L2LU3Ly82GHdkyf/1W0GYB4q8bsdtiw/XcSf5A9FPH3QunsSAqYgViviwNuCBl65qDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab76558a9so846479366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335319; x=1722940119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkadQeqdI6tE11FbIzlOQ5+g3K/rEnoOT+3/dR+zXIs=;
        b=s86cMpmA57JWKu+cVSdks8ZqpswAKZRB/bIzBEG11vMA9m7PDu+qzWLq3BtJz2Xfkp
         Ka1ufgeWLTLB3F5plo+QnomH9GqYmvSPh6LXFJM3gEATQRUAl4IDf81sh8RLK0GNvmEQ
         DS6uYEXp4OECLyLl2sT1MmuyO7IC/LoeTE02TCUq6Tsv60kNdHfgWbESUO/RIPebvUMr
         pigNmoWboiU9EOv3MGMXYVwOtEj6bxR5SYuKfFqGQxwk89cmPz3X2WXUmI6CaQN9FMHL
         QTxa6PhcHFNRSELS7tbeeeoXCJ/pyqyg/D1TDWbSBxypasd6iQk80BvjeSHPLev6ty1U
         RBoA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0ScdapaXJTzwVG+XDwZM0NgEOmu3FkqQJveHFobdFc/uhlrLgmCXUjlkwdnZTZPDHy9NeViP0Pvg0wdDTcBkihdWktsVoqJHa5z+
X-Gm-Message-State: AOJu0YxIPAa6v4VNgZMAp/ZIApZQvfVZjulKOqTaEfx2PxpNmw/5M8RH
	9pBj2P30DzAlck4dp5TbZucdE7uwFLMHt7Ct4QuvQAjt7BF/J7u1iQKf+A==
X-Google-Smtp-Source: AGHT+IGzxOyWYmqO42LydFtGqOm8dG3dI6WkxzaXrG6pskgWUf6g3JaUALk8JQoY7LRh+UN32zzKgw==
X-Received: by 2002:a17:907:7249:b0:a7a:b18a:69 with SMTP id a640c23a62f3a-a7d8590d130mr144805266b.10.1722335318663;
        Tue, 30 Jul 2024 03:28:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23f21sm625055866b.37.2024.07.30.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:28:38 -0700 (PDT)
Date: Tue, 30 Jul 2024 03:28:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Wei Liu <wei.liu@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Adrian Huang <ahuang12@lenovo.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Add retry mechanism to add_pin_to_irq_node()
Message-ID: <ZqjAVDBBdYSxbdPO@gmail.com>
References: <20240729140604.2814597-1-leitao@debian.org>
 <874j8889ch.ffs@tglx>
 <ZqfJmUF8sXIyuSHN@gmail.com>
 <871q3c855i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q3c855i.ffs@tglx>

Hello Thomas,

On Mon, Jul 29, 2024 at 07:44:09PM +0200, Thomas Gleixner wrote:

> >> I'm absolutely not convinced by this loop heuristic. That's just a bad
> >> hack.
> >
> > I will not disagree with you here, but I need to use this patch in order
> > to be able t keep the system not panicking and stable while fault
> > injecting slab errors and trying to reproduce a real bug in the network
> > stack.
> 
> Something like the untested below should just work.

Thanks. I've tested in a Skylake machine and I haven't see the crash
running the same test for more than 2 hours.

Feel free to add the following, in case you submit it:
Tested-by: Breno Leitao <leitao@debian.org>

This is the machine details, if it is useful.

	CPU: Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz
	PIC: Intel Corporation Sky Lake-E IOAPIC

> Thanks,

Thank you!

