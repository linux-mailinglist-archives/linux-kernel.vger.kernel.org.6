Return-Path: <linux-kernel+bounces-288675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AF953D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039E91C23136
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3015532E;
	Thu, 15 Aug 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMBjOQ2s"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C2149E15
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762113; cv=none; b=F2DoAJoNacsMVbpnuXbdGkgu7SfaACIOKWyOYTM/kUjHGQZ2dE9ofUX6YGsfeAHgDTmM5aWnxYTQ3gKjD0H00BHhSlM0qmO9jPGFXWEvceOFsSrT6ksmVUSOZapm3lo+S0WZJsuEaca4jJuvqF9qnSR0+rJNlJwW7nu0CHFDCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762113; c=relaxed/simple;
	bh=UW/YRpMyTxp4NK8nFqhJzPzvLEJ/46VEHPh7kxogks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxZkyeM3y20Wy2/cC7W4eFjBCyU1PbYLWaUVOPisgK2RSCeVwus1KhB4dTxhiZ749tLoTQ4DJXDO4Cfhw7NqsLDv6/+3FkvOmVfv2CuphT3CFgYwzfPxDAUQX64KziiSCF3X5H+sWbCJrxRFBYVkieEXXxy3nMMqIx1bJkNutIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMBjOQ2s; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3b7aba3dbso15074161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723762110; x=1724366910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UW/YRpMyTxp4NK8nFqhJzPzvLEJ/46VEHPh7kxogks4=;
        b=RMBjOQ2sl50avnTwNGKu9tvh8Nbi1gJaE84WSLiWr7b3GrlFw0cjnTiULQmYKvi9G+
         HNcSfVFVKD/bm2zFQgn0vLTfShFn0CzYFVkSRq8FC+ET9LR1tjOM3uDRVGq8eMmiiqAZ
         kCYBlVO2oK0RcFLdzEqLRQ3AqtBab1A+wY4p7GW7hUSWWJQR5hJpYEd0mShkVHnCDWjj
         gnlVzT5jfSJxh7C9yfeI3pW//sTLyrdbrHsgjx6LyyulnE6kjdOZovdARqRPjruN+7uB
         ZXgsnZPBjA4hAwK19IyTHyVcC4uhVGaccWjWZrfxdGL8Weoe6fRLWp11ba2pjFAjbI3y
         RnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762110; x=1724366910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW/YRpMyTxp4NK8nFqhJzPzvLEJ/46VEHPh7kxogks4=;
        b=MyCyqEFppkY11uM4t2/epENrHazJG3fhq7sh4yb64mbFKS24D9nTmv8FbHD1B0/9vy
         MWBqCFU4S1r/DFEWDjbkoTvVj1WRJPZxo3ax5C8RbjnT4zYlyksy1Osahr9t+C0F3rAT
         ZilpKonvBTTcr3IpjM8N00evVXL3n/hlWReq8GE+71CISWKVRcNyMXyNJBoHsK5TQyHC
         XxskZ3OeTDmaW6pUzq+WWck56N8hFVgH3OjL1ZpGNjsg+jy6+xUfQYNrUIfbWR4MCxYU
         whsuqz78EuZ2oURxFjGpQ2tEFVsrRXBJd95uFkP+GNpHdRpvFtMAK8Gj9Ir72Up3l7D4
         soNA==
X-Forwarded-Encrypted: i=1; AJvYcCXF2N6T4TlquSugLaR/zbufkjfLop0rYYE61oNuWrTN5+ngtUuWYlxH0uK9phuItHYlVC8V3YzQFR5ahDAH5eDFwZ55XphvwjrfUu+2
X-Gm-Message-State: AOJu0YzVPrZf5HLxjpal8pZ6R9UNTmhySgOn5puEmdXbQeceBIqiliCf
	J1rRqHh1c8SL+bTCw9EZAk5lBd1ryjG2iNotxi3wXtdj+ZK67yVt8WNZicNis/sjRWVxU1lHX1q
	q7jL2Co/0PIVdUKtSDlc7puKltyfm/y1akTY=
X-Google-Smtp-Source: AGHT+IFwD+gpxrSv9f2mlb9tWGsRsSveTZXRxRI9TM2Dt2SSi5qB0ff9Egi3tMUmdLDESdwRmySkUQ45MpA8ZdDDes8=
X-Received: by 2002:a2e:a99d:0:b0:2ef:2490:46fb with SMTP id
 38308e7fff4ca-2f3be5f59femr7171691fa.37.1723762109633; Thu, 15 Aug 2024
 15:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx> <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx> <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal> <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal> <87ikw6rrau.ffs@tglx>
 <87frr9swmw.ffs@tglx> <87bk1x42vk.fsf@nvdebian.thelocal> <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx> <87ed6soy3z.ffs@tglx>
In-Reply-To: <87ed6soy3z.ffs@tglx>
From: Max R <max8rr8@gmail.com>
Date: Fri, 16 Aug 2024 01:48:18 +0300
Message-ID: <CAJrpu5kqLky9eUogYEpF6Dom728ZPkgckCamhzTQKbBv=v-Rug@mail.gmail.com>
Subject: Re: x86/kaslr: Expose and use the end of the physical memory address space
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alistair Popple <apopple@nvidia.com>, x86@kernel.org, 
	Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com, 
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linuxfoundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Thanks, tested against my system and it fixed the iounmap problem:

Tested-By: Max Ramanouski <max8rr8@gmail.com>

Best regards,
Max

