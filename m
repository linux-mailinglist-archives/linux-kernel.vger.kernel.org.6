Return-Path: <linux-kernel+bounces-537064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17651A487AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D140C3ABE64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD226B2BF;
	Thu, 27 Feb 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN+Epe6J"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510A25CC68
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680286; cv=none; b=QgUEmkM/0yQ20AMpaMyxZhv0tsRJBCq36KWJ/vlBhrqNVuj/ymHAlqGXAdzjZm/uF3PLU/fkMOU/kGBRiV41lFu/K2tLPb1olWmszwUgrtPUkSy+TvBjt4oNJcKRpLSClLJznSle4TVeUUsTiOW30b47NRM1QkbuUJT+i7LZ1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680286; c=relaxed/simple;
	bh=LhCwUqw6aIcUAaIilumOSmmYJTZiSLI5LKxzpVRdtdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nxz2Yu3hhJEOS3pGkmQFfCYVWnZCIRafb6+Zqm58wcP4tlsPbBB6xXih2cK/3Y1V+qkuVnJMoHb5GLo0duKwXvo89mp9rednnDitGGdymwzk0AOSq8A1X4qxEYagPEkoaHwrMdTpVIHKI3B3FRJG9h3c8wfxrvQ+vzRuTHx83U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN+Epe6J; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43998ec3733so6836075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680282; x=1741285082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=je1VJ6mKVPvUaaEVhOcM6k4XIwS96a65cb57ultTPxg=;
        b=SN+Epe6J6HIm15Kps+TW6mY3u6cSZkrhy3AUaOCWjyaXs3IlGHp0ZDg7X+ItDtRddp
         Fw97h3aU69+WgvO4CKLrE+82LxKj2PcCEmBYrDuvdNmowDsj2twXoVZiesE8TMPWkxEL
         HIBQqwmlzUekY65wUCFvnsHDgbM2ZS7iUP6nOeS0LusMeaBVOYkhS5/BOzmSIz1pESb3
         2Wpsuzs830OmVBSu13qLZ0TXhuJfRjVjvElK8KgPw3SNwPL1sMqff1apa8n68uq9mfct
         +jU/Zw0lA7xwxOrEt6/CRkXVrXqGf2wHuSEcnnZeoJrMdjM5GAyESLL5s7tIVVjMLgGE
         ns/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680282; x=1741285082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je1VJ6mKVPvUaaEVhOcM6k4XIwS96a65cb57ultTPxg=;
        b=GMUW/sOeqrnF3Goz7KklQCLaeXmF4Q+8IVJXdjHB2RA+ToInSr5Cg4lkV/o1diE6gO
         rotZF1pXN/dm4yg/yPZGYGqjPkkISBeZ5eQWuhw6H5HidhbgjzO8aQrOryvnV4wEocq3
         OIpXBlVlfodqdXlhWrO5TUhWOgIcVimQGLCIVoj6aFpWpZ9+OAn8NWo02VSh9wPe23eD
         X6UyC+vhfH98Tkn04iuwk3S4vcId0WJACXl2tJiGyF1WdOuH4sKPwvoolgJdaI1moKPy
         LaUfrVRrN9KqPDAnBmYV+JcxTeov18Yv56PcA/W0xdlB4/37GfkLCBSFwN3Y+Oj1/z+Q
         iH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgTCQIjLYbNTPDQAicjDbU0eLeKSUZ81XOSgg0WEhBChvVRZbrcOvT119R4bRHBcATKu3u3ojTkzQl5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeR4a91TLUjUtlyHfolbb8SUQ8BWgOUWCjUhvwEJRqU/l1Tz8w
	ZxN9yOYu+lQJgsYekAi0z6w9eT6fDrSkLJo/WAqBjw9LhkyYkJjFy/+u9fY7mIEe7630Na20W1l
	9yVVuRmjeh6pE1LWmNfgP3GUQ/A==
X-Google-Smtp-Source: AGHT+IHIGWkJyk1W72MtPuYvvfSzBwxqwzISAWt47NfzIFTk3QsHe3svTwzMWq8Ixj0RG6cPRh6eQd4HAPYTSjvNZaI=
X-Received: from wmbek12.prod.google.com ([2002:a05:600c:3ecc:b0:439:948d:4146])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d16:b0:439:9e13:2dd0 with SMTP id 5b1f17b1804b1-43ba66d5bd9mr1947805e9.6.1740680282702;
 Thu, 27 Feb 2025 10:18:02 -0800 (PST)
Date: Thu, 27 Feb 2025 18:17:49 +0000
In-Reply-To: <20250227181750.3606372-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227181750.3606372-1-sebastianene@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227181750.3606372-5-sebastianene@google.com>
Subject: [PATCH v2 4/4] KVM: arm64: Release the ownership of the hyp rx buffer
 to Trustzone
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Andrei Homescu <ahomescu@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the release FF-A call to notify Trustzone that the hypervisor
has finished copying the data from the buffer shared with Trustzone to
the non-secure partition.

Reported-by: Andrei Homescu <ahomescu@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 861f24de97cb..7da0203f1ee9 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -725,6 +725,7 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	DECLARE_REG(u32, uuid3, ctxt, 4);
 	DECLARE_REG(u32, flags, ctxt, 5);
 	u32 count, partition_sz, copy_sz;
+	struct arm_smccc_res _res;
 
 	hyp_spin_lock(&host_buffers.lock);
 	if (!host_buffers.rx) {
@@ -741,7 +742,7 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 
 	count = res->a2;
 	if (!count)
-		goto out_unlock;
+		goto release_rx;
 
 	if (hyp_ffa_version > FFA_VERSION_1_0) {
 		/* Get the number of partitions deployed in the system */
@@ -757,10 +758,12 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	copy_sz = partition_sz * count;
 	if (copy_sz > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ffa_to_smccc_res(res, FFA_RET_ABORTED);
-		goto out_unlock;
+		goto release_rx;
 	}
 
 	memcpy(host_buffers.rx, hyp_buffers.rx, copy_sz);
+release_rx:
+	ffa_rx_release(&_res);
 out_unlock:
 	hyp_spin_unlock(&host_buffers.lock);
 }
-- 
2.48.1.711.g2feabab25a-goog


