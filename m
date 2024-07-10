Return-Path: <linux-kernel+bounces-248411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB492DCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA5C285C61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C949115A865;
	Wed, 10 Jul 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lyh8M3Vd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8EB158202
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654961; cv=none; b=Ny4KD1iUNvEQX4GUtbU2lnJ4HFKlI8acS0T3SGj287ILZjkcgjb5EnGSm6VFImv3v5lL++CGXaJA2PSjnCOFec/baUJv1Es+sVgp3JZ/g88esENz+Fw4B2PaZ2JkzX+qLAluA9EVLbukMD9RZRsYop2sG+yYY8GFlKS2xgZ9iIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654961; c=relaxed/simple;
	bh=xxkhVIBeGXY8pX54WQHQVUoU/lEQy1GRiLeaV2vAb5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XeYlo7Tdfr88uYNlqz+1P5dsLhw8xBaNRh40tCMNolkvmakTV5Ye3tDxxT1JZwKenfmP7NpvWtRAQHksCzbKoX6HIysFZpq2HeSI/vpGQUvzaYoM603sf8PWlMbqhKO9o9E504e7jqT5JojoukCy2VIApb6Cagi3SaHHQc5IxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lyh8M3Vd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-652c6e92147so5070187b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654958; x=1721259758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kOa+bY4z73FQuKac3t3a5fniJTGUgyq//kzfHQQRXg=;
        b=Lyh8M3VdZs3SrnF22+yc6jjwGOAByZI/gs4WKQyaPWDQ/dZGlw7hv3Qt+tt7a8n0Ck
         FIsjNM39OA3GttUqKtaxtRf8ZHHimuA6Qe3rrPBKvjAk83Zyo3NTyfA+oB/941aPi1uS
         ifwteOT577EadUZswco3QaM87ObQzX6tq/iyn+XjuuHpWoIrz+8IlJB+mlo2XXR58G+Q
         4C8dDQAHHF3ek5t4JFIQ15ymqnBw9ErC+GfACcRKLqObBQiQ8iHvF5KRkp3wMBPW15fu
         anfXxeZkwx56Nzjm5g2DFeQmPRY9g6J+2R9vIKDPNGu/x6BChGsjg0rZEI0EFTh9vbo0
         O7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654958; x=1721259758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kOa+bY4z73FQuKac3t3a5fniJTGUgyq//kzfHQQRXg=;
        b=dQz09TdRvPNC0RRYazCOvF6vfXRaQOBXsVM9ZHCqF6AVx4RQxTtrW/ixjubnP7NQAl
         zAY2Xj5473FQdUlFZPg+RYiMEhpY7hajO5/ZomTDLnQWxeiZJfFmJZMKXTzON3pR0WIU
         GqfLn08QOi2jxFZZYg3lsTIy6npfQZqcYUSijkezenitS5FqyEqkBT63h992ROrte6TJ
         n5xS6+gvJ9T+HHeP74JL9Zblk5lGhRlW7qpi6eUGcOQg6uTVp6UMO0v4Ml3Zgj2kRmOQ
         7KB0D/FBRkDrgrUdBuLnZnzCy48G3QaAW82jSlovR3f9WqNPUI/UrB2XTybQ4RUnEITu
         E1qw==
X-Forwarded-Encrypted: i=1; AJvYcCW1B4H2kq/vt0Q+WcYLdyxZv0TJ2CEyS/vXkY6htrikT/NHKh+T7KQHLeTB3iQKFZ5Y/tjkWT+n130vU1+1s13zqMexJ8vxSZbqf7Jw
X-Gm-Message-State: AOJu0Yw9JK6+U1K00+L8Zqnbjb7EeHDFRrjwyjQbAp9xAS9SB80jC30Z
	B62NQyg8hYzV0xqqGiJZa7rnDGa4GkpxQ41oQiF1oGGquZeVd1lJCB4DtbyWkYmURYcl7IFlYeU
	k3935f8GUzBneeHjGHQ==
X-Google-Smtp-Source: AGHT+IEQILe/Q46nVYjT6VvqMQTMH6KcT24WPu+37xvorf2J37tSktUkMizR+hLJi1VSG+Olb8BNJuoCHzqVyuyh
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:161a:b0:e02:6dcf:e9ab with
 SMTP id 3f1490d57ef6-e041b0688b2mr15353276.6.1720654958570; Wed, 10 Jul 2024
 16:42:38 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:05 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-2-jthoughton@google.com>
Subject: [RFC PATCH 01/18] KVM: Add KVM_USERFAULT build option
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Some architectures will not support KVM_USERFAULT, so we need to have a
build option to avoid including it for those architectures.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 754c6c923427..f1b660d593e4 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -117,3 +117,7 @@ config HAVE_KVM_GMEM_PREPARE
 config HAVE_KVM_GMEM_INVALIDATE
        bool
        depends on KVM_PRIVATE_MEM
+
+config KVM_USERFAULT
+	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	bool
-- 
2.45.2.993.g49e7a77208-goog


