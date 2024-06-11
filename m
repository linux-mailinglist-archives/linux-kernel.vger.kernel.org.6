Return-Path: <linux-kernel+bounces-209696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AECA903989
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A0B1F2240A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8317B43D;
	Tue, 11 Jun 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXYfL+0N"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD717B425
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103717; cv=none; b=erCujI8ZYNe6wIriBrrXGqQVPAvB/bsx7nwhN9gF3q1YTzqGgcfqZqn6eJgyYxyb8m0YcDAyFWKhJNHtxN5C1w7vz6O2XwtrGYO/uEvSUV0NqLrIJXbH76OaMMZ7hJa0LS0bf7yZnutoJv9S1o5nIZq3vm2Qbduyrkh77okS+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103717; c=relaxed/simple;
	bh=0BoR/ySkUdp86yQU+xkkVvDFb1VlTIvfRG05tr3vSAg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mQJzygoX3Sgit51p5y9yFehOOXBRClaPBbNQqJQr4aUyzAaAXmXREB0lMiBOmJ3ojqvjZIgjtA4k6+v7G1Ukeny32ku2tZJM96d2qE9xNSyapmciCMOukilufP+E40pxMd7D8W774YYjs3uqTw6wOoF96L7Y7FXmYcwcTpT8c5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXYfL+0N; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4213530af1aso5521545e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718103714; x=1718708514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYv3kpEvUfvo1XGO8nCMMZZVqKU0cSbjSBA134k1VjE=;
        b=EXYfL+0NQmChVpJZaFVfA2+5Wu6HRqzl7wP84rnsswCeW5x1mQaZrka5i4XKfR1DK1
         A27nx/LBJ+34U4N17OQXYdnAAkcEU8x1Lrzz9FhMtnAYSojCmEn76qIGGlDp0HBtWLbz
         CfvahTX5+r6B1vPVeWvs9xaOWA//104aihND6vAIrGyyoCa0eX3KgwiBBHS8u3ThDPCU
         lZqD4ZpZnh/8yyOmqaOpTP9DPLczcjchczhgc5bEyAsVRh+W8pAGzCRx8l9eiMfMAGFY
         VBP8WQ55rNL0C1c5h+4/b1F7rVofc1GrxhPLqLLxIuk+1/EWoEwCxkcsk/zoBafaCnpV
         xFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103714; x=1718708514;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYv3kpEvUfvo1XGO8nCMMZZVqKU0cSbjSBA134k1VjE=;
        b=OZlHjjhhuBVwu5qSTxUHqgF3DlrSprX25X0/CwObPDROPgJ5GIs0hQkKnhNNekneYG
         loLO+YnKJHK9kx37YiZamLhNxnSasbmQNQzpLbqT+CI4u5DFsmWjkX3LJz4dGGRy6FD5
         HgD54jNi2m1Ipl2GVIAz1QR6GbBh0ZlQWoiXukDzMwEVb4FIqJdXrI4W2WlkHRlA9jVZ
         3gSBAe9RJb7SYf7yrB8LM5o4tETp1+5Q5heIxyw/3TL/PajPRmGPu3J09M1oj+5Z0lNW
         OHuceM52tdzmgQTBnwJmm851f4EUF3BAThbbXOLRMUyHF1egQf5HeF8Uet/EPW5Svzxa
         EUNQ==
X-Gm-Message-State: AOJu0YzFTlM1DyaInxNnTnCwknT/8zyuzKvjKLKPMObGfgdoAISJv3N9
	mGErLB1GSmTwFfdbXM4EkbzyoIIKUSUdEjIKLDQCCnRVpwZqdBMs6l81j/irKn/S/9WcnT00Qok
	515vt1i4eHVVTB270pUl43/cu+A==
X-Google-Smtp-Source: AGHT+IH84YBw2ZmyJ2+Ml1KaV0R5/LVaYWBE3YAE5+auTkzKnYMkco4vTiLOSQDUFdAmJC6oe30A8hUqbzq8abY81VI=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3ba6:b0:421:79c8:dd2b with
 SMTP id 5b1f17b1804b1-42179c8e02bmr624795e9.4.1718103714137; Tue, 11 Jun 2024
 04:01:54 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:01:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611110136.2003137-2-sebastianene@google.com>
Subject: [PATCH v2 0/2] misc: vcpu_stall_detector: Add a PPI interrupt
From: Sebastian Ene <sebastianene@google.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Dragan Cvetic <dragan.cvetic@xilinx.com>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,


This is a small update of the previously introduced vcpu stall detector
which adds an interrupt to the virtual device to notify the guest VM in
case it stalls. This lets the guest VM to handle the reboot and to
panic in case it expires. 

Changelog from v1:

* 1/2 : collected the Ack from Conor Dooley, thank you Conor !

* 2/2 : applied the feedback received from Conor and used
	platform_get_irq_optional. Removed the error messages during
	probe
   

Thanks, 

Sebastian Ene (2):
  dt-bindings: vcpu_stall_detector: Add a PPI interrupt to the virtual
    device
  misc: Register a PPI for the vcpu stall detection virtual device

 .../misc/qemu,vcpu-stall-detector.yaml        |  6 ++++
 drivers/misc/vcpu_stall_detector.c            | 31 +++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


