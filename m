Return-Path: <linux-kernel+bounces-217889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7175E90B59D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D11F22EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE691D9521;
	Mon, 17 Jun 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Xr7WBwj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC91D9526
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639479; cv=none; b=qix5BIkN3GRkjsu7uvNENDfnxylreGjUFBQQmGhVyIiHVlRJDcQhu9mFeZpA4cPpRhl58uICFrclieogVZ4fRMKGijG/6xfmFJ34mLgw1ZakJLsESSe47py3Byai//4ZD59zrdx9T2GaHM1DAGzlnjmvY6+u5d0wuByESBtH328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639479; c=relaxed/simple;
	bh=Gl6mEoqAkIrRN9bRN6Tg1oiCsDVylHWziGdPna2H36A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YB9TSfjSRBaGysy6l7HGHvwuV+M/aHzO1UHcgQSijAGM1g9YKB26GfoFqMNP7frogb/JEce1AAfJP0gFz/QIfcy1hmXj8Cm7R1lk0uVTdwjeGs4CIjVPHVJTeLalaoElkOZTjHNV2n1LcBVBcWvMLL23oQrZv64BdcP6+aK+0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Xr7WBwj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe44496da9so7914303276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718639476; x=1719244276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmjnXUur+pQEKANZ6hOpI9ezYlLEVt778EOmcZMiXgM=;
        b=2Xr7WBwjlnR3SUJaFe87zhYveXY7Js4fk+qswDypGA86hiLU4ZznJQ+Au9k7Fxxlxw
         qdNtko/r8vuHaew0veisDvad3PJStvCxAP0de8tlGTxADYgEtsGf8kR/f2grRR4Qtpxe
         8B0hkbkh9LiuK3WkMU2N8+3yt8SgwFQydr/izoRgkk7RL/Hy2ip2zHliMuWtGv6V0ARx
         J7llIBVPHdwsvCl3FXSivG7qQ9aDKo9CM8sEWzk24dv5ercpnPzecEbWOkuF0Z077OSg
         S/QmOXm6Hp6xdXgNmE01z8/cSHCO0RPzSW6R5A8LukkvWpd38CBD80H/5mYSgLY8rgee
         EiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718639476; x=1719244276;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmjnXUur+pQEKANZ6hOpI9ezYlLEVt778EOmcZMiXgM=;
        b=tGjkZKeMAbg97BgvSnmmY1VsbEtA3Y4PkpcbjxyhkmOTpDpe/rcgIzfWHdUcGmV2Lq
         50ESEfj3m+mWryGm8ywXs1w/0CMP4TzvRhmRxdVlrAdxFizq5rE5vtT1QFp7hLmmWTHv
         kywhG0DU/gpFdoZChVUw9MC5eqrN4XwtKTdVn7orKBNt5raiXobqQwUgDfkFYq3U6Cjg
         ZglojimzGWfbbeKwFaGu0uwt+G5Q9UoD5HR1JA3Cojvt4hm1EF6wR/VRZHw1q643N+q7
         jHG2tfky4jixIJprwxThia9bF8DES/TA1LSvkIp459RRwCWuKoWxigeDRO8M7bopEMIy
         /3Yg==
X-Gm-Message-State: AOJu0YwzECufzwoCSZdfWhdCOr3Eho+G7aT9hvK/jgQ7uv7+wXHFZ63K
	m1yp2T34GOlUwGTFdneI86lLB1MSX/yVUN6nvTosK9iuGQxQ/vMqEHa2kV8QmMXVX0SMVznBQjq
	GSQ==
X-Google-Smtp-Source: AGHT+IHN3YE23nyRRG3lLscMlpvRRvWZoTv3qxGG0qqcuyi1Ap4PJhzaODpPoKmEM24Apl4OwoS2icaRQis=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b04:b0:dfd:a911:5722 with SMTP id
 3f1490d57ef6-dff1550b4f4mr1256878276.8.1718639476511; Mon, 17 Jun 2024
 08:51:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 17 Jun 2024 08:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617155114.1471233-1-seanjc@google.com>
Subject: [PATCH] context_tracking: Tag context_tracking_enabled_this_cpu() __always_inline
From: Sean Christopherson <seanjc@google.com>
To: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Force context_tracking_enabled_this_cpu() to be inlined so that invoking
it from guest_context_enter_irqoff(), which KVM uses in non-instrumentable
code, doesn't unexpectedly leave a noinstr section.

  vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1c7: call to
    context_tracking_enabled_this_cpu() leaves .noinstr.text section
  vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x83: call to
    context_tracking_enabled_this_cpu() leaves .noinstr.text section

Note, the CONFIG_CONTEXT_TRACKING_USER=n stub is already __always_inline.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bbff5f7f8803..1a23d8c7d8c3 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -113,7 +113,7 @@ static __always_inline bool context_tracking_enabled_cpu(int cpu)
 	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
 }
 
-static inline bool context_tracking_enabled_this_cpu(void)
+static __always_inline bool context_tracking_enabled_this_cpu(void)
 {
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }

base-commit: e4e9e1067138e5620cf0500c3e5f6ebfb9d322c8
-- 
2.45.2.627.g7a2c4fd464-goog


