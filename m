Return-Path: <linux-kernel+bounces-302020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC995F8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1421F238BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391D199248;
	Mon, 26 Aug 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ns2anKii"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447C1991AF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695840; cv=none; b=lz00tqKcMCgyx21Q5cALOJ0EIklcJkZWgVApFD0bL2LG8NGWgZYhWit6Y3MDBxUe53G1MpHR2WWy9wNsFI1550nSNpy8T2mrYrCxSyGb41C7OSdGVb3+loQqbQu5wV3JfiFmUKqVbj5gK5XV0zc2wGIu7k3lHdSCIfgOibTcAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695840; c=relaxed/simple;
	bh=6MFGYV9dOo5notBoUk9NuvGDpl4YuxZjFoxUGaTl+vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UyTw2QP+C9v+ks8yy4EyegwCXL3cdk1Yg02N4Kvqd+GWmw+oTNWkLuOCNVe8cK3vTy0fEhAhq9VXsY2BnbYziMBZjfUwfgtKEaRSe+G44QObfyPEvfY4XIqKeYRZx3ryf1XTOACJDT5wBNHejC7eNjA2cik2bEwry1Byl/8346s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ns2anKii; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b3fec974e5so87229597b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695838; x=1725300638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTNZrCkUq0xQZGeO6ycrGRNs3S9b409ZMww8HwDIlNs=;
        b=ns2anKii621R92rhKc2OXTEs54A9zpdmkmXiMhHE6bifL4bypdqMvGjEqeuYCKjvnB
         q5aAkqMOK3K3cfofC9hq3uKRu59ssXm0fnbORZolzhSz6PYEAcpgNZhp+c/VTT6S0a8V
         17wXmvpM8cZwAiujeDKIkppS2TKSXzqyZIMBdnqWgNP3ZvZ48srCA+E6TOD6UafxsjD1
         o7SuYpNK1EymyxPFfV9+g6g5ppfmYK3Au9mXCr2GWhR94MMMRzX8vz+MvTtAHOlj13k3
         R0BB/mAp8Ca9VTO2AFR6guBCIstAI7sIAI6zWkNbNdisJGbVznSfrxOo9SyKC+RHr839
         RznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695838; x=1725300638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTNZrCkUq0xQZGeO6ycrGRNs3S9b409ZMww8HwDIlNs=;
        b=bQF8885tiKJi7cwlPjKaVkdbnPVjUzJdROwZIKc3hdHbEUD+z8QwAiiE9g7taPJhFu
         gj4elPXrNy1rSBdpZm6ZrHMgliRsNYVNrj3oWJYur/61zeK/KjyT2630JJV48l2qxDvZ
         dhmFrRppMxZgb25d5zcnCkccECUFl6WxzyAGmiT6wkA72L6YBk/1FVwBjVPnQGVA//BF
         90VkkdK/E1MWLQR1NweB8MJ69+WkiMf66BrWZ2mk1JLb6vaGNeX1M2J6UQL39Kw6WJr1
         kMzH5hjZYGwuNl6i57hriv8i9rmRjg6PW0N5wbVIP3mMnY6w1luIfcygQ+HVjaFD41oV
         eUxw==
X-Forwarded-Encrypted: i=1; AJvYcCW0KDIFj5qBkCkye1tleZk32ayUHoPBUCGX2+P2i5y+dEO1v48CKQ6GNFCCJJdutcc3M+/mPac4a4nj1Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEGbAeDXoZYhxQ1dkYUTuLh4QjEbftEeLrAdz3jiEmQ4gF1Zr
	ory9D0+rrO3B0Uon6ZJ8Dt15sHhWhfGnK3mc3VkW5geUxmMiwsZuP+td1TelI63WwQVQHFdAhKo
	iMsPB1e3LyIV6MJuAdA==
X-Google-Smtp-Source: AGHT+IGW2j9ktjrj8oF1PNYZ6a7M4kWNRrFjbvWYuEMXzqV8XYqAMNE4C7OSAkSZQUqUASb5aIzsnNsN20PmRRO7
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a81:8b4c:0:b0:6b9:fd00:95cf with SMTP
 id 00721157ae682-6c6288b107amr1615827b3.6.1724695838182; Mon, 26 Aug 2024
 11:10:38 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:29 +0000
In-Reply-To: <20240826181032.3042222-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826181032.3042222-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-2-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 1/4] idpf: address an rtnl lock splat in tx
 timeout recovery path
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, David Decotigny <decot@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Decotigny <decot@google.com>

Adopt the same pattern as in other places in the code to take the rtnl
lock during hard resets.
Tested the patch by injecting tx timeout in IDPF , observe that idpf
recovers and IDPF comes back reachable

Without this patch causes there is a splat:
[  270.145214] WARNING: CPU:  PID:  at net/sched/sch_generic.c:534 dev_watchdog

Fixes: d4d5587182664 (idpf: initialize interrupts and enable vport)
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index af2879f03b8d..806a8b6ea5c5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4326,6 +4326,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
  */
 int idpf_vport_intr_init(struct idpf_vport *vport)
 {
+	bool hr_reset_in_prog;
 	char *int_name;
 	int err;
 
@@ -4334,8 +4335,19 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 		return err;
 
 	idpf_vport_intr_map_vector_to_qs(vport);
+	/** 
+	 * If we're in normal up path, the stack already takes the
+	 * rtnl_lock for us, however, if we're doing up as a part of a
+	 * hard reset, we'll need to take the lock ourself before
+	 * touching the netdev.
+	 */
+	hr_reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG,
+					vport->adapter->flags);
+	if (hr_reset_in_prog)
+		rtnl_lock();
 	idpf_vport_intr_napi_add_all(vport);
-
+	if (hr_reset_in_prog)
+		rtnl_unlock();
 	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport);
 	if (err)
 		goto unroll_vectors_alloc;
-- 
2.46.0.295.g3b9ea8a38a-goog


