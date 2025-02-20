Return-Path: <linux-kernel+bounces-524840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A015EA3E7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D68417E895
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513EB264F8B;
	Thu, 20 Feb 2025 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1BJcko6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6D1E9B35;
	Thu, 20 Feb 2025 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091444; cv=none; b=ttXtUVMuOg2bti41ll2IBMKCVvjNSGof01HmsayXHxZQBEhgcWQ1pBVTZyAwPx7/7doGlWVl4kPB5a7Tg8eLDVZZWmfuffScGJMIycO7nt7K9oqWeEbVuUfpvecNJfF8B9w1PcbaKrd7EMQDZzyeqT91PuLgCIGkrM27AxyYYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091444; c=relaxed/simple;
	bh=3EUalRDoRuULLuK/AN32YnioDbfGQ/egIgOK6d9ErAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Er2ZXe2a780dZ8+m4/DZm7gByM4PglC9a6eGo7fNGynfKZ8QA3SZoFPhLjXW49tf/SlC8kT4ucMXwE+g+YfM60tjoCQf9g6tDwhjZtIY/tlK43m5+oXe5bY7MbZvVxjRuz6cs5Li7+wGxboILZK/W6bezxYrzNrxyp0RJCsIG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1BJcko6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abadccdfe5aso254064766b.0;
        Thu, 20 Feb 2025 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740091441; x=1740696241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3deX91evMY5/6DRTKdBW5iuKG4VbntN431xcnsxfUqA=;
        b=a1BJcko642Eis/k3XrMo7j0EEHkgGTe9Pw30OJVHlqvzDDh8JJEXnBg7HmnyRC6SGs
         nJgfL3CGPOWsL/VAddxDh6+o4xHwS6qEghzIPnywCCf4Yca83GFj4DyVsB98CQCZSkeo
         Zw2mjejVwh1qaB+23pDukhNkMPFiZODOMR/i9BPCdVDIKHR6GDbnFYyg/vvMoEgg3btK
         SkHnAZr1mHpDo7NVal3BiRe2g8dTWts4nWtfaICJobXlIDiwNlOg0PRXxhFIcwiwVWcW
         f/+HG7J7Qcd2KzxN3c52Pker0E3p0lEtBB7cwn6E4OCFdU4MVzNL0lrGkfytuHwguKgM
         ITlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091441; x=1740696241;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3deX91evMY5/6DRTKdBW5iuKG4VbntN431xcnsxfUqA=;
        b=EgjIivtOVaH7tggFAXP7sCEiZJ1jxVQVvjWGw6vk/6VQ/yZWQGO67EnbSvQqyRybrR
         WS10PSZoIQjTaUbUxNsGFeRMqCNhbeqABJjFuoRWsJqU3kNuSssYcS3bdA5fzAYAodiX
         AcBxSPHwQGK/4Sl26CmHe8xktItECDGjcEAEaj8piN03FT9ShCnXD76bfNyaSmEl+Ncp
         cND32bVTy9eRzxpDqwBpk0s+/LqdM0A+UtMYJMWWDAMNkE9Y7j4OnbqWQL15+APEdYiZ
         Ercj1iazJXVEuxYe9P9mm0dGxzPLaNkIFg95FAXM2urUVmnGiklgMNL+MsivVY6CE+hJ
         DnQg==
X-Forwarded-Encrypted: i=1; AJvYcCUB0UDodFdcgRERZGofkBF4K6RxLmxCTsgPE1EWF2qwMBr3ytDn/7TZkqX1aLetiUefZHivyjJ6tETXDVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+/5Yt5uMClFDiJsKtV5rqv6s5Z8SS85536RKIK94SyOx+tsP
	v9O2LuhU3FsMS1JkgDShnVTIKXZUnpN5iHajiHnRcD+ax/DUmpOgofwFeg==
X-Gm-Gg: ASbGncthRkzaJrhwM0ErHrgWARCwpJ/HL0+3aGPdXLF0+r8dbVTclK08gBQgI/9pD7v
	kMaDZYCQ7rQprrXVl3n/YO+8Bb78P1iHSwXaiMJeSesVP7rbe4x83mwwGai1yE75M8JILCVlfv6
	RhQKDrDuABpWc0DS4FtFtrEpQhGTNg8NLtTj5a2CmmoELDHKkKQNgBCiJuGYUFN/OgV6UrFReCL
	ZxBz0hcWz0rJlqHVBRXv4p/+RAOn3uCxQOwdX0aafu/mZhHe1dnja9VUCph5CF1iV3any1qGub0
	qHzz1y6srEQmZKBwhY/+uY5kT9SEShaD
X-Google-Smtp-Source: AGHT+IHXgyDqiScyTznq8+ZJOhiY7M1BBjea0oFAMbfKdeVb2G+b6UwTnBxPrcAMndqzyGSbD+I1OQ==
X-Received: by 2002:a17:907:3da0:b0:aba:246b:3954 with SMTP id a640c23a62f3a-abc0de4fa45mr49218966b.47.1740091441030;
        Thu, 20 Feb 2025 14:44:01 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231fcasm1529528666b.25.2025.02.20.14.43.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 14:44:00 -0800 (PST)
Date: Thu, 20 Feb 2025 23:43:55 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman  
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] xhci: ring queuing cleanups
Message-ID: <20250220234355.2386cb6d@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I was looking at all uses of enqueue/dequeue pointers and I found two
rather complex loops which appear to be doing really simple things.

I don't understand why they were written this way, it seems wasteful
and I see nothing that should go wrong if they are replaced with much
simpler code.

I rewrote them and the driver still works. I exercised Set TR Dequeue
code by starting/stopping isoc streams, using usb-storage with crappy
cable (transaction errors, halts) and also the smartctl -x trick that
results in URB unlinks (both on usb-storage and uas) with some disks.

The third patch is a dedupe. BTW, that comment there about section
6.4.4.1 of the 0.95 spec seems to be wrong, I suspect it should say
that the chain bit cannot be *cleared* because that's how the code
works and what some commit messages say. But I don't have 0.95 spec.

Regards,
Michal


Michal Pecio (3):
  usb: xhci: Simplify update_ring_for_set_deq_completion()
  usb: xhci: Simplify moving HW Dequeue Pointer past cancelled TDs
  usb: xhci: Unify duplicate inc_enq() code

 drivers/usb/host/xhci-ring.c | 242 +++++++++++++----------------------
 1 file changed, 92 insertions(+), 150 deletions(-)

-- 
2.48.1

