Return-Path: <linux-kernel+bounces-447686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAB9F3608
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EA01881B49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490D204573;
	Mon, 16 Dec 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhT9luJy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CF203D4C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366463; cv=none; b=hL3Jknw1bdzukE1QfYi9ODXQLGRa+mer6OhnnhLYqogfsVT94+f/GyUVIN6ObcoR62HfnOtc/zpXtLO9F4Igj5ZxsWUnd6akRqFLlYQ/lpCTjCFJramoPxv9IG8h+4XLwpkcxGI7EzmBYdIGUJx0CcHWTJncR+i3BjZGL3Hkm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366463; c=relaxed/simple;
	bh=Alkl5JK8XXPDhw4TegKE51lvaTrA4xkYrWRmB0nId1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q+Kki+lRgNJMITo5DgrUHK24afJIMJUBVsDUPm5n9pbOCScEGCyuVtR0+aD/6svX0STaLZJ5bV1POerrrg5Ta6Z1cYrmHcMoy2vFcBue1HjIHRa//7L4n9iLK+A1nXSu5xg871C9KfrRkgwxfZBVN5aOn7lbX4U4RaGERfnhpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhT9luJy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso5941103a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366462; x=1734971262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=474yaotgwCzzWyKV5Ltdz6258KpTVXmf9MtVet0h7Es=;
        b=xhT9luJyhtXB3cSxBPQp5siFawaoojrebXkf/t/VJjmr2CnwOpZL/SaQ712B/Z+2Rv
         Tbw6+cmi9ykJtYauYC7YBB2ibFbdufdZ+slI5J6jo8EMPbboYKj96UZLqU+mYMjzbdfr
         +l2wCZoHqJwkSQl6awGuVgib7pDx80JzaZwjZEL6VUcIVrcDsKwKIW/2voIFY73O+Glh
         SByu6DpjP9dro0RGAugm7L+8yorRNbvPlKje9+dTXrok2zSRSJOTovfI6PO33vtOwo6H
         NvPA7GdKRj15wQ/mPSZ87Cb4cqeV3VN+q8EWQ2OQfgwjqGVNrTe9u89FyKrhW16KDrTc
         Lbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366462; x=1734971262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=474yaotgwCzzWyKV5Ltdz6258KpTVXmf9MtVet0h7Es=;
        b=jG9DDHSLpfyl/4B3YueN0LqtvtxpXHfyY9faeA2I46hgKtLOc7m7fhh/cc+PRhXO8N
         HF+IiwkNR5+K7z9M7BLHrX5cU/Jtl/8ju6XnS2ypcRuDNeYVF/NaPu4EBlWn8yiw9O+Q
         2j/KDsv6pfaKV9PXPbYrNGthgxX6319UZL+y7Csu1G0+/by4CG7qemCtaqTpZfGdOSlL
         8v8CjenM8w7HATHTAHFMxv9xCcYer3YNKQpwvwNyQyGETURCBlqzO+uz6EZzbrTW2lnT
         artM+ewxj8cGimU3dlSOXoZ59PDr96/531+HkIcJxKWeUiT+Nf/cHCE0mOtlbYbz/+1d
         31/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBkrBLVLHTMtuS5sPA4KXp0n3oVP6NoqCQ5H7o6ng5XI2Y0Uk+fUbnUcBEVPIODOmAq0eUmdcI30Vp7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4j8vfACBRG8cUkHDLZPYMfluM6evRLvR78Pn4vN9dkkgCxXG
	WAjGVYUZxUIHtXa3efKCo3UTunUfqnaySVuYIb2AfihHrx+lQqVXX0poTmMzJlngJVM/XdlZvqM
	NfCypwg==
X-Google-Smtp-Source: AGHT+IHSei2yGRztaubYbqKCul3QQv1EHtbndGGlv/0ZZYijOdz2zocYYRlRLidwM2ED0OUQcir6SLdjFVu3
X-Received: from pjwx12.prod.google.com ([2002:a17:90a:c2cc:b0:2ef:8055:93d9])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c86:b0:2ee:7411:ca99
 with SMTP id 98e67ed59e1d1-2f28fa54f59mr18372516a91.1.1734366461730; Mon, 16
 Dec 2024 08:27:41 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-1-brianvv@google.com>
Subject: [iwl-next PATCH v4 0/3] IDPF Virtchnl: Enhance error reporting & fix
 locking/workqueue issues
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses several IDPF virtchnl issues:

* Improved error reporting for better diagnostics.
* Fixed locking sequence in virtchnl message handling to avoid potential race conditions.
* Converted idpf workqueues to unbound to prevent virtchnl processing delays under heavy load.

Previously, CPU-bound kworkers for virtchnl processing could be starved,
leading to transaction timeouts and connection failures.
This was particularly problematic when IRQ traffic and user space processes contended for the same CPU. 

By making the workqueues unbound, we ensure virtchnl processing is not tied to a specific CPU,
improving responsiveness even under high system load.

---
v4: 
 - Addresed commit message comments (Paul Menzel)
v3:
 - Taking over Manoj's v2 series
 - Dropped "idpf: address an rtnl lock splat in tx timeout recovery
   path" it needs more rework and will be submitted later
 - Addresed nit typo
 - Addresed checkpatch.pl errors and warnings
v2:
 - Dropped patch from Willem
 - RCS/RCT variable naming
 - Improved commit message on feedback
v1: https://lore.kernel.org/netdev/20240813182747.1770032-2-manojvishy@google.com/T/

Manoj Vishwanathan (2):
  idpf: Acquire the lock before accessing the xn->salt
  idpf: add more info during virtchnl transaction timeout/salt mismatch

Marco Leogrande (1):
  idpf: convert workqueues to unbound

 drivers/net/ethernet/intel/idpf/idpf_main.c     | 15 ++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


