Return-Path: <linux-kernel+bounces-239756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287909264FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB804281DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182618133A;
	Wed,  3 Jul 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onk8DFpu"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AF17BB3E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021063; cv=none; b=ZRsYKO40dbUz3In6z5D2r/dA1bZDd/hTZWTzj3168jYKKHzC1GaJHOqziGrlWr9eRVPrxMtEEh147Mm7IuUXPuA8WYHG/sdRWNO7mODJkl1N+N1UA/22B5YH5l34C5wdDzNQNWsZgPeZxtIrRBzN3JKpTYVXCa5seQs5pFjR9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021063; c=relaxed/simple;
	bh=UuuWaa0tC3y7wOOJIpWxBS3gznzmQGKFf0mmHMtUpgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ui35J0r1ERktCzPI3px8Dr7sh+DJETk58MXx60ka1WCSAbInPXJAxFbKnpv4m2dmowaNCFSVexOhlCCMz/feWqJa9Zr4/sD/cOgACeK7V2fje2ueUa2oKAc7WzY0yfVDdjIz0n9Q/u0VTj6YRJOixeKo/EE6/i/uM5SN2MCdewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onk8DFpu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42566e8a995so41112105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720021060; x=1720625860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXHeYBx1feIyYBvodN+uyHwwuOXvCzbpoETmGReNpnA=;
        b=onk8DFpuxdpJCUTbcDyJLQ+/+EmgXGSU3ufTfhqv0porDu7dZgV6wlwbT+MqeMGhnB
         6v9YztyRSbn4feCJQYKfHcmtXiXNjBHkxsr5w/LdYJ6apiVWe+Mcp56sd5VZt/uy8/zL
         EzbmKlbYf3IoaTKSEXvEQWqXMUs0tE2FCSLonA1x0iLwsZ8JPGFTZxiLmfkH1GZBwSqr
         M0jzEsAVHkPir3BiqlFiUjl6b2g6ICZEOn8mmEbrAew0f9C5F9b+BUWL02sd2avW9hUw
         ZlgaojMSutc8k1v1R4HtpTSnYom9vWxdf5t0IL3S0H81/AgcORiEKFd5yaGYx/tPPTNM
         rLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021060; x=1720625860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXHeYBx1feIyYBvodN+uyHwwuOXvCzbpoETmGReNpnA=;
        b=XGaO1bPCrsM4kzO6ZRU23/aSt2USgkJu5wWbjUt1Gqlbj3e1YZb6aDWGidv8I0H66i
         ZOiWq5ecJaqJffbf1NGBat2Dr6kLwOfYK+du8m/5QqRKSirWRgKsnKu4jrvr9Cjy3+vu
         MW+MKsUQoiTs6erCzb0YOgw4sEpwSG7fWOFVGdyJO0q/osIGfKaY744ojnqEbzEw6oqW
         Q1ozhoOdMO8lyBnIIQgQsmxyyQKLIPITT9SYVBLXjMeqpc4YXkonjm6WE/g0C8X0f7Uq
         ez1DMU+P+wULMHPnSZi4nT89w1bHazNSr1qYv3gTOXUlK5ck07zO3h+YrxhkGsSEkTyu
         CFRw==
X-Gm-Message-State: AOJu0Yy0bF4ud6eDdO5S9cyNX57YtBecELJYkbUpv+Bnm1PlFV+CMtkH
	bHUd9UU7DOkPKsKKvaZFJbpDcpG6xtXEj2Ph6HSf3Q/UmZLLZjxsY6iVHbFUGMcI3SNV7YS6/bt
	NrSe6Bn7l+JTlyBAy3F592kGWYg==
X-Google-Smtp-Source: AGHT+IGSiEEFTCajMYHomHUZhVpXcTcBj4lQBmYUjRjnpTt9U/W1MKTV3Bdokpkt0CdvJgVhHM+9bzWcmGA7t0/TMvg=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:6d8a:0:b0:367:4e17:3ec6 with SMTP
 id ffacd0b85a97d-3677569d1e4mr17528f8f.2.1720021060119; Wed, 03 Jul 2024
 08:37:40 -0700 (PDT)
Date: Wed,  3 Jul 2024 15:37:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703153732.3214238-1-sebastianene@google.com>
Subject: [PATCH v3 0/2] misc: vcpu_stall_detector: Add a PPI interrupt
From: Sebastian Ene <sebastianene@google.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Dragan Cvetic <dragan.cvetic@xilinx.com>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am re-spinning the patches as last time I accidentally sent v2 twice
without bumping the version.

This is a small update of the previously introduced vcpu stall detector
which adds an interrupt to the virtual device to notify the guest VM in
case it stalls. This lets the guest VM to handle the reboot and to
panic in case it expires. 

Changelog:

v2 -> current:
* fixed the build error reported by the Intel robot
  (https://lore.kernel.org/all/202406132132.FBKSWFav-lkp@intel.com/)
* v2 was sent mistakenly on the list without bumping the version to v3. v3
  should be the correct version of this patch.

v1 -> v2:
* 1/2 : collected the Ack from Conor Dooley, thank you Conor !
* 2/2 : applied the feedback received from Conor and used
	platform_get_irq_optional. Removed the error messages during
	probe

Link to v2:
https://lore.kernel.org/all/20240611110136.2003137-2-sebastianene@google.com/

Link to v1:
https://lore.kernel.org/all/20240523160413.868830-1-sebastianene@google.com/

Thanks, 

Sebastian Ene (2):
  dt-bindings: vcpu_stall_detector: Add a PPI interrupt to the virtual
    device
  misc: Register a PPI for the vcpu stall detection virtual device

 .../misc/qemu,vcpu-stall-detector.yaml        |  6 ++++
 drivers/misc/vcpu_stall_detector.c            | 31 +++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


