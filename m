Return-Path: <linux-kernel+bounces-530380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BCA432AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC181188E31F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9946140E3C;
	Tue, 25 Feb 2025 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMwvvjRx"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C113AD11
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448417; cv=none; b=VtD16cAEZ34j8uSWhq5XzTfcyz5AJ7861pzD93qCYXwiEE8EYjiz2A0M7wS0Zv1GPb3FPnLDQsuLRlQPuERJl9NQkuGSaROQePFbakv68SpnAehGbiHLW4dlJOsKZvNS2eDjubSzlqiDNf3WdVgq+LhKsyRjjTgumyyqOfdGgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448417; c=relaxed/simple;
	bh=e7B/eoAwu89jaT4gQ5rsNPl33ADnwHw9PC0+ErFwCr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j9ELGZoNf2WV6ncGhjE53uWEif/H/QKffLY0ux1n+/Rmks4ioW6/PxV5cInXI4a9hzppHfFgFe8kS1RaK/FMqNTwPX7y4N5ZtjZTFc2JW4mIUk4/UV+VsbKbRaTXbS8Wj2Bz8bl/71VShMzh1pMbAzjEt5xewKZxN+zO4kN6V+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMwvvjRx; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abbba16956bso639663666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740448414; x=1741053214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgX4G/wyCIy27tIesuPjLRJPT0WJaWFAbFWUEeP8CW8=;
        b=qMwvvjRx/LTsiQilrU/DMynw0ScH3q9fJJ9TtEO1F6msEMxtyRovFVCs2pJOcKTO6w
         KsIV6hDT0ySkJzeuZl+0LH90c3sLHb35Qb77OtEtDLJHt+y7Y+U0R+h6gJNfFW4K1dZt
         e51prfoNPT4yN8ioWq9VjLjrqSE6h7n32fm+44dwNzQrD686QzOaAZnOP4CzjQiNyMnS
         PlsUm8tsqPKth+Pbri35X0FLQuNLcrnMFLgafBEMZh1nr10kYUdaxhPSec05xy1b0HH2
         BOlrXM6lnJTog1gDusDLjZsaeRqEFe4FJtfwux2/Ln8q5QaTMzh50uoR73hOr7py4Uii
         d5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448414; x=1741053214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgX4G/wyCIy27tIesuPjLRJPT0WJaWFAbFWUEeP8CW8=;
        b=taft9Z9R1IzBAZvk5O+zTB/bKD3+8y+3K/kV7WkDY4jRDOcR8DTf0mUX9K4/0iloIe
         U173YIEfCDr17baTGakCeBswV3rb1jhJIlhGs6km2fMz6e7+JDjH8bsw2CJseMoHqiCS
         ofGo7lxwPWZD5TsRHvrqfsgd11ubfgUpAJ0ZTUhfEwN2IbvGyZSDB1ZbbLuAjuKwvMZv
         mwYcti5zJzzyEw4m66fX/fNwKUM6vdzhMavEcI7X8HeJOzdnWiqIMhXfffYSecLrjZ4P
         MLwizcUJKZjWoTxep0aCWpBQm5Ev0ZW8T8SrfXOdTr0wDvl5KulDYIwF65txlrTrtg4j
         yGuA==
X-Forwarded-Encrypted: i=1; AJvYcCUkcgw0EO/nKsw3AAtUMx+QpADxdKp3qw0h2aqpL5Fr/VW8UBetoh0uwUZI4Nq9Yf8JOmdCYQEZGz3sEaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFBPam6l1zZghyh+3+18qHA2ZKAFozcstOLyUs3rQc5NU0za2
	nm7SVPZdNWhNF5aKxxfvpY/L063yYPDWGfbj45iRXcGLhEs47DTwqeGvLjCnQmfNpKXE4k+Y2nb
	syCZQjA==
X-Google-Smtp-Source: AGHT+IHaEufhivqbAqPz8dmOr7ipMkvz7Mo3kJou3GygxqUP3Pfy+Ob1mNc3FS5PEksGnbTAMER6tHUCQA2u
X-Received: from ejcux14.prod.google.com ([2002:a17:907:cf8e:b0:abb:b80e:12f4])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:3181:b0:ab7:e8d6:3b21
 with SMTP id a640c23a62f3a-abed0d764demr127674066b.28.1740448414099; Mon, 24
 Feb 2025 17:53:34 -0800 (PST)
Date: Tue, 25 Feb 2025 01:53:25 +0000
In-Reply-To: <20250225015327.3708420-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225015327.3708420-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225015327.3708420-3-qperret@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: Don't WARN from __pkvm_host_share_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

We currently WARN() if the host attempts to share a page that is not in
an acceptable state with a guest. This isn't strictly necessary and
makes testing much harder, so drop the WARN and fix the error code.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 19c3c631708c..ae39abc7e604 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -912,7 +912,6 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
 		if (page->host_share_guest_count)
 			break;
 		/* Only host to np-guest multi-sharing is tolerated */
-		WARN_ON(1);
 		fallthrough;
 	default:
 		ret = -EPERM;
-- 
2.48.1.658.g4767266eb4-goog


