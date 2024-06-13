Return-Path: <linux-kernel+bounces-213289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBC907378
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBCB1F237E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F31143C6C;
	Thu, 13 Jun 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6qpDnVa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E37144D07
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284862; cv=none; b=YVDJM4hgktTUedod8PWmM67S4VKF9gD53mZ0n5hBVWyYCfzVPVV0UMTEBz5X1bBMIO7r7g1aChX1zdFso7Lp90E9D1zPCHk8/2/o2elS56fxdqIU903eB7okIx97WQcNw9HkQV+U5QVdCo21PeI6aE1ERPVuKRUu7FxjMnUki3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284862; c=relaxed/simple;
	bh=zFmo670I0tiDu31Oc+yMgEHTb7RV2is956ciDFrAEIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iuyjsCqQ8o8dO/jzohKWGbT27veMIRfQC/DqBgW5xERlKw/QBUpYkz8inU8GfWx5aE54YEjRd+1S1asnXoZOolu/8Mb61luybjSVJl+T9zKa0B0Ei4233hUz7xHFH9R8ar49STa9CiX7PGLAaptjCIs2+Q70TiJFHZ9Ca0LhjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6qpDnVa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfeac23fe6eso1859155276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718284860; x=1718889660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0OhOvlObTYcevtXo8Z7p/mIFsLXq1uqkU+zyx3S4LA=;
        b=X6qpDnVajjBNdljZKx26/cQgwXLfgW+4h3cb3PNP8LWqrhNhUGbPjnwQDuY4WMArGk
         vwdyRGdGMEewXHWgYnzt+59rww7NcvdCvSOBVjxjCWHcGNJn2lC2UEjnZniu2OnLWprC
         qahGIsEaQ4gUm0niJogaosUvrwSsRkJ6WB9ARDTHSS5a2JhBsYOJxNYrdZYSCFtiB3/J
         23VBls/YQqOqyBdvBZdXudKH5tmvOrGD4aUcIMxtY2qHjG26BjWGRREtIHT+wY5s3K4E
         BCwObd5sdO+3yjOoOTwuSf8QFA7uZPiRkOzyamNKaZThaDKn9vfLUaO3AyuL1Kur5vHl
         cZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284860; x=1718889660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0OhOvlObTYcevtXo8Z7p/mIFsLXq1uqkU+zyx3S4LA=;
        b=h6GVXn6ubfqhUTBYfOKPHad8Z65rMdh7Pasq70N+/aZETOvLOF9JSx9CELx/yNkOcJ
         yfbkP8NgQ84y4JlVuQ7d0hDgsqKtAt2Okr+7c+FLpYF9qfhhHaoLuXfUsz8/Xe++gp94
         LoT/yiZVIxLq8S96kfXy4NZf6bV4JjU2pAAzDsgbchYa/EmYzyB2AclwaWfNAozp7lC3
         F6rstVS3yupcILyGKOObuURxwdrStL+O1+2ef9H/zUNOJAsEkeywYIDE+qH8P1LmfErB
         KK98TcvFuB5fcFeJUKQMOUIGBp/ALNPJz2qHxDBYC7JicUUtC5L5Dhj0RQL6OlZMR+45
         fYsw==
X-Forwarded-Encrypted: i=1; AJvYcCVvNp8kP5yywGQ1J8gKq++IL7wVga9tZkqq8HMmI290HySiKc9bMDuCxy/JBwpWzWtNFsknGtV71JpVVPwGLw2UnG/4DGCVG0kD3J0o
X-Gm-Message-State: AOJu0Yz3JQIKqZ0irWbpPlp7vWIhJuClULDv3umF1yo4SJIdfEjAmwoM
	fGmwShHfkL6+zDRoIqpNn3KOAsM4L9M2E9N912jXML8Otwcm+QPYcsdauNORpmJleZA4EFnQNg5
	VjgD0HrY7rOlDl7vUInItvnjTSA==
X-Google-Smtp-Source: AGHT+IFmR5E42s+BCdl2zDYX/0jaaUeTAn+ERNofvz51IQhPRv6eG1U8A9CWU+hty3Xq9QgQmwvTlYwuQ2lHK/2XOVM=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:723:b0:dff:ee8:14d6 with
 SMTP id 3f1490d57ef6-dff0ee81893mr156506276.10.1718284859883; Thu, 13 Jun
 2024 06:20:59 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:20:34 +0000
In-Reply-To: <20240613132035.1070360-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613132035.1070360-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613132035.1070360-4-sebastianene@google.com>
Subject: [PATCH v3 3/4] KVM: arm64: Update the identification range for the
 FF-A smcs
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The FF-A spec 1.2 reserves the following ranges for identifying FF-A
calls:
0x84000060-0x840000FF: FF-A 32-bit calls
0xC4000060-0xC40000FF: FF-A 64-bit calls.

Use the range identification according to the spec and allow calls that
are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
identified correctly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/include/nvhe/ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index d9fd5e6c7d3c..146e0aebfa1c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -9,7 +9,7 @@
 #include <asm/kvm_host.h>
 
 #define FFA_MIN_FUNC_NUM 0x60
-#define FFA_MAX_FUNC_NUM 0x7F
+#define FFA_MAX_FUNC_NUM 0xFF
 
 int hyp_ffa_init(void *pages);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
-- 
2.45.2.505.gda0bf45e8d-goog


