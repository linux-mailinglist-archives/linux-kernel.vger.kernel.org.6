Return-Path: <linux-kernel+bounces-334046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9897D1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1288D1F237A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71A7EEFD;
	Fri, 20 Sep 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LoUFRYLz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A67D401
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817973; cv=none; b=MKCtiDVYXrmHbjdxCDCmgZz2QZa863ItKje1BHn8NOI9pNp0Mt3qqk5gTFlFkKRQIozKLIgQZrditBWZSK5oRXrJjDrwCv5280QB3FrDpc7p5CiOD1a3fVCMDcKM1zNnKtdB0++pAX1Le/jJ771pkd/wCcr/jq0qCV/Z0Z2CxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817973; c=relaxed/simple;
	bh=H2dmJr8hpjnnkdgnm3AAwF3pNuKwnFfGeFFtmmrBeZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njrc2bbYd52hEcIWGXUdlNlHuJiJvByN6a1vnGAs/ffL9en45g9Ih/oAUKomT9OQb60SVVihq8e2bxSM4NMfNIGB8Wa1fNso1bnho+OpxBhhOUfz5z6rBmi0p3NRQ8LAnOdCZGU7uxtUfW76k9s2nqwLJTLqcOWibt8tYxQ61jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LoUFRYLz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053616fa36so22744655ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726817970; x=1727422770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56knnfie3gn40U1586qIcyfLVXwVK5l1OK1pmMi2fA0=;
        b=LoUFRYLzxWPzVjkoFV9ao0yf/yF09mqx+0jqO39Uk0Z7jIBuwE3Fd/H238IuD6/jZX
         3rne++r3wl/LLYumWU3MVL5NKxzkeKqoc9IeoZut4dtixnpjZZj+xIOJIxhRQrH7iJQK
         j+/NqbYzfh7L3v1cooKZ79aJm8Zbirjz6Lf8tzuy/JS8P+hj3yQfnt+AhDqmIEk/AH4p
         TLCV+K5G2KUeFq+H7SeuiF0+XJM0RchFYDxsVtmJ+yqlRMxUpdFMXfsBa+nQtJhblyu2
         9YTx7CpiHsZvP+Pgg0wpwVF6qhjJLJic9ZAx4Vx0FAwSMZQCI2t2jOiVImFXRHki8jDM
         BKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726817970; x=1727422770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56knnfie3gn40U1586qIcyfLVXwVK5l1OK1pmMi2fA0=;
        b=usil+qVhWnIkxP9CkRi6fzWMP8kuHCVybf+Izihcpz1j2vrFO1RnPENw4fgB3h5aTv
         Dh29V9py7OlnyubMhHEhuBpcPXzVzziZyG6saajBBrbzHXjm2Q2ONgk6GeR4SFTBdzMe
         L2MAAMOfGIm5AxJonlB9FqabPAriOJE0h6bXQgTv6ePEGFtLJWpVTywvJ+VuXsVs2kH/
         f3KbQs5538eSTGwU19udw/OWUsmm19iqsyjgUOYxx17Lbf4+fm1LWtrpXYeRAnErN58j
         EOj1MtR1/2IHL2wxyQOgo7FLcc43lXQZSY3qpEdWiDMsAE4qPSHsimXwcA1kATPUCv8B
         ejug==
X-Forwarded-Encrypted: i=1; AJvYcCUgisM6NQjORFlV7LlvtHljD7GSl1WNZJONNBsZXOvCnJkqvgAgTWILB7x1e27JY6djPxUyCriEvG1+iN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthMDRT96fg3c7MlS1nxo5usirEDZhKJOYxoZtYEIuvwPetzF2
	tHnnmTSWpIiHmlzr48oc1bsRMn3RDX7fmWCO4mY4TCeQ8fVbdcYmYmKzwJRzUms=
X-Google-Smtp-Source: AGHT+IFdJWu48cTXjfm7pmPi0SJjjpoM8oaSNh7cs+sv8ppa+Eh8rcIfQI/ARHDbsMfIMGKI31JoxA==
X-Received: by 2002:a17:903:8c8:b0:205:410c:f3b3 with SMTP id d9443c01a7336-208d8442483mr26756335ad.59.1726817970349;
        Fri, 20 Sep 2024 00:39:30 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fcaa4sm89645805ad.212.2024.09.20.00.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:39:29 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Sep 2024 15:39:05 +0800
Subject: [PATCH RFC 3/3] riscv: KVM: Add Svukte extension support for
 Guest/VM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-dev-maxh-svukte-rebase-v1-3-7864a88a62bd@sifive.com>
References: <20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com>
In-Reply-To: <20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Max Hsu <max.hsu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=H2dmJr8hpjnnkdgnm3AAwF3pNuKwnFfGeFFtmmrBeZo=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBm7SalRgR20+oKL/qOJCPUSe6TlQ9TxOvvbzCZ3
 /oFZ1j4YAyJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCZu0mpQAKCRDSA/2dB3lA
 vWC7DAC6wEj/n9CbTmnWTmX1V13illBvFuFZRuglicYsApqy50khOjplX6PJZuGQ95zwOU7MgL0
 R3EiVMLLWH+svNhI0RKdAYZgkYaC+ebdN6rmtFUPZoTDzYN29PcsufuUTCYGVx6yhvRJ6tUsKz5
 XsfgxNU5bsp2/TrTrtpBr9ikId9PSeSaZjSvYX+XjxRKaRAUBl1ZEOjWlR6QKCMo0GO4KW5CSWx
 jptrxxQmq5XHZvg6nChHyWTNRYK6hDH2Kn6+AjKgyNIjnl/0QzAv4UalKsaHJk5wiwJWMQ3oCa4
 lQcTWE/+8v3Dtz9RlFFQHkuyEY06ph9ETUWB9+qstgSGitlZYBMi9uaOTRlXgoK9XF1yo0VmF7L
 p/gBoLYn0F29Vo7Zu2MiEfzlww2NgqTkTtIHEt5VgQZac5TIQq52VSoq/Bwz8S+4LBKeb1gOeR6
 bCoaMInYzf6Jur0ktZwEGciz7Mw/YS+SFW3LprnqtS5bHDVHzRYf9Tp9JY0o4dbSO3Yuw=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD

Add KVM ISA extension ONE_REG interface to allow VMM tools to
detect and enable Svukte extension for Guest/VM.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e97db3296456e19f79ca02e4c4f70ae1b4abb48b..41b466b7ffaec421e8389d3f5b178580091a2c98 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -175,6 +175,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_ZAWRS,
+	KVM_RISCV_ISA_EXT_SVUKTE,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index b319c4c13c54ce22d2a7552f4c9f256a0c50780e..67237d6e53882a9fcd2cf265aa1704f25cc4a701 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -41,6 +41,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
+	KVM_ISA_EXT_ARR(SVUKTE),
 	KVM_ISA_EXT_ARR(ZACAS),
 	KVM_ISA_EXT_ARR(ZAWRS),
 	KVM_ISA_EXT_ARR(ZBA),

-- 
2.43.2


