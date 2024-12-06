Return-Path: <linux-kernel+bounces-434613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D6F9E68F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA1F1882F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603891DA61D;
	Fri,  6 Dec 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GukpDvUy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFC19DF66
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474006; cv=none; b=iG+zlH4rRsTQLmJMeDJgVVGKoh7riNDrBsamsZKKN8YALIAipyqSOI4+2HMf/aOqqrfz0+FC1ySqLMVbbX8M6s71bDZPq5gh4ZgQ2eqRsStMte65r2tvgZp+W93j0trOcXsFNh1F3roEWCN24FSzuUoonJl4SXWojV8IH7DD3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474006; c=relaxed/simple;
	bh=1UwquMqHQAEbMWHm24NJ3i+17h6zazMQWy5+3k3rLW0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NC6SKuqbE7mtau8poGCxaRXtNZxMPbY+MkQN5yTi5jX2O46X13htHjZTuRJMWLAUlw19pHu6ROyqEonpOLzmHb/u6z9mvqtaBAl7NMC2fN1Wwo+F7M7pyKGo6iwi1kVoTDfDv7Vv9yhX5vA4VhMgRiXsOfn2tISTXZYoLxHUBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GukpDvUy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so171179f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733474003; x=1734078803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UwquMqHQAEbMWHm24NJ3i+17h6zazMQWy5+3k3rLW0=;
        b=GukpDvUyNRqdYIuMPd6mzKwhLKQJakUb0vlOfCaIFSmoXTKYtUVtHGEHz8zIAUvfvN
         9jkOapTOD5Wl5Ch+WpFBaKIlwTVpNWKUXw7ozX0PAJWQGCWlRKan6QhaZzQszeZkQFhx
         vkbZd4L0Rj6/6GWR/sPxklVxEe2rmre9vKsDhW5c24aaGAVrSYqUwaUwgr3CP4xCn2+G
         Ryl181SXWgpCMCmN9VPTl+g+gXx5i05GJTWIwUYfjP9/G582e9YKU1UdT7MVJtYd+Ahs
         92BmtvzsU8y/wzwUuOn24MvH6vrmsOj4cJkQ2plIiPVap/o54l79PvE7h5QcCwfrSJm3
         Kirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474003; x=1734078803;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UwquMqHQAEbMWHm24NJ3i+17h6zazMQWy5+3k3rLW0=;
        b=PGZjDutUedx+XVRzePK9K4IxkF3rZTRJUTMPtEhlDqYK6PTC/xomOsFdFE2K0FVF3M
         N+eo7caIsHIvwlaO6UIrexf7VjPzZDSHKbB0MHs6qYNmKtR9BAI0GhZx/HPA0ugRjbFh
         h44ZXJs0BzucKc1YjNQeDZMKlcEIFZLI8Fp1MPAIceEGw6wcyOBrZQ7r1SteLwt3uqhq
         OnJEuCq57X0lqgZt/Yoj5lmsFlG7mv3Q7b7mbQLtplnKaa0d6aQmahT4wMlRzhxHxBMc
         6zGgSWfWvCb7odPVbGnh+SJVR2PoqrLMK/eRyQFVG3DXfcc7o/+pwE19LRZibShigEFJ
         nNSw==
X-Gm-Message-State: AOJu0YzVXOVAGzgoSt8ywoetNGEavOU3csKcmD62rhzgjNmnQEMo8qoA
	kNKKp1l93NKsOZMKh6oNwZEJeDmZ3ZuWtulAXlgNSnMS9cLZw7BKL27lMSZjq8zbwUOmC4c2Avn
	QcVfMs+cs29SQPzeHexK5O2aHTNE=
X-Gm-Gg: ASbGncur3D5NDr6nLLYQmuWlp/7QRNYpjKrV3fZeA1TnwXuFa3Dltpq6pblGGv2e2QQ
	7akGFSSWNWAaoTdMxh/GWouv6k+z+41c=
X-Google-Smtp-Source: AGHT+IEmuAIU0mTKGq/6tyiv+faRyxylaFEW1ymbM8aaM75TuBDPrX1SjlYvQZ+S74OUZZ/o13CLBsk08f2Llqzwq20=
X-Received: by 2002:a05:6000:4026:b0:385:fa26:f0b5 with SMTP id
 ffacd0b85a97d-3862a91496emr1291250f8f.20.1733474003070; Fri, 06 Dec 2024
 00:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Fri, 6 Dec 2024 16:33:11 +0800
Message-ID: <CAJNi4rMfhZOCT+7Ki14vUs+dZbv9cxCZ0s+jgn6=_om4NTgo_A@mail.gmail.com>
Subject: Question about interrupt prioriyt of ARM GICv3/4
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, will@kernel.org, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
Currently seems the GICv3/4 irqchip configures all the interrupts as
the same priority, I am thinking about to minimize the latency of the
interrupt for a particular device, e.g, the arm arch_timer in the RTL
system. The question is,
1. Why don't we provide a /proc or /sys interface for the enduser to
set the priority of a specific interrupt(SPI/PPI)?
2. Is there any way to verify the higher priority interrupt will have
more dominant to be selected to the CPU (IOW, the priority is really
working) in case of multiple different interrupts asserted to the GIC
at the same time(some debug registers of GIC like GICD_REEMPT_CNT :-)
to record higher priority wins)?

Thanks

