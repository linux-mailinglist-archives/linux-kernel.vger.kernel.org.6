Return-Path: <linux-kernel+bounces-445798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4919F1BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC087A03F4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160D29CE7;
	Sat, 14 Dec 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXAWyY8S"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25713D529
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138450; cv=none; b=Z6BDKBUqLuOmkIP1Q8xf6IyOyGz0lUcs8khWoosXAk8tU9T0drtlgB03dkVkWtu22ZXmm5pMzXHmqZG2CQRb3vxGpwQnRvwgx61liu/w1qsur4rTj+NTKR+DEEVfYAvgS2SVw4l7Uy/QIKW1lNp4KQ7LE/iEAUg+pcWcCiUz+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138450; c=relaxed/simple;
	bh=IZGgI2DCqaJpVpnMfmrHDxlduEJifpBvSH6SMCXlxBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVD9zR6rT+OSLaIRlAV/C0DYBxf3cvgQCL9fUxKl/SF/+xgfvJvRBf/CNwmYYZSe4KWjAbCdV+vuqRhLBbM4cB/tDGH3c06Wrl5FqJOkgeJ1Hf5BcGu//P07rp5lPF3eZgqkK97b/mE9/v+wpsPvQsAduVDupCvG4LCXGpvdYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXAWyY8S; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd305c2027so1507867a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138447; x=1734743247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eu7VheiDTVKr2LqSu+n9QlVxflc27k4rZOjnfcC28j8=;
        b=rXAWyY8Sv0RCMfhCPz0UHONPsRI8+dz3TY3YzDcfICwkJdhamKOW7JAAVFvhE112Yi
         PiR8SZ43QDsYJj8VN3VK6+Q2JOqUJOcTiliEyUI5awEwok8/9U+VL+zfhdqvlQkbPM7S
         5DY4Yj0oBVTL//7D9OGDFcL7yV5zUz8weOn/PnjCPjX/34UiiMNeeA1ajouVcBc/Lsru
         LlhUdMxwkqGSaQBc5AlNFhwC6DAg6ypWonAAztJkhschxDMG8/NJzMbh5nXBrJHWUPBR
         j6Ffhm4Vw+QS4vSrAQpDJ6J/zp+8zEhHH0sV+yEu3wqNFS46Ay25xVUy2+QT1wdyhKLS
         NDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138447; x=1734743247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eu7VheiDTVKr2LqSu+n9QlVxflc27k4rZOjnfcC28j8=;
        b=VNAJQx3KE2/7XvK3XwM3whyILObh2P5+s2nU0nPdKjqtjcKJUoehldBTD0xFDEz7MV
         VTCnClOFQI9scxiJFB9YH3UUfjnJFgP5Ul3U7b6l4Q6yze0INebpd2li+7uTpLRvrSpR
         FzujJCoNRjFkZSPaRmAizzJjdYiJmrptwDaLrG1FhQX9OXBX85V7KiTIIjINQa8qOsQR
         vrhf7f2azNtvYf7Q+eHk4MX70OqFaacEMnQS94nQW6IsmostCT/ZLzLjpRQ1zgWQJHot
         ASNfdSA4wujy2pvxP0Fy8y5xbzfHhGwYTzO3Msv+JYVqbrqAoqGfdVQ4G6WSgX0JdsZL
         gPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXmuRuvzsltuZVQL61QMbyAcEHAgKzp1ASdb/kNqsyO1t5OsQMkPT7ir0Y5JUxz9ivdRuoUZrurSB7cgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLigLr1a0BQQ4muujPO+Fiqt8YxqFf4HmUO3dC9Tid6gA9d5Q
	rlIFg6jddXXux15pTDoHmKFXIPK1fYVKDZhzylRiwFGmlUf4PX9jtGNOuYMf3PiwTCWsSznmSuj
	Oyw==
X-Google-Smtp-Source: AGHT+IHo1lFfCdYYSF7/JbyGHm3sFAr7BgyjSeNg7ivUxMiio3zLw8UbtxvqO5CTt5MTe7jJoiLSR2DQHRk=
X-Received: from pjtd5.prod.google.com ([2002:a17:90b:45:b0:2ef:9b30:69d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54d:b0:215:e98c:c5d9
 with SMTP id d9443c01a7336-218929a21c6mr49455455ad.18.1734138447390; Fri, 13
 Dec 2024 17:07:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:03 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-3-seanjc@google.com>
Subject: [PATCH 02/20] KVM: selftests: Sync dirty_log_test iteration to guest
 *before* resuming
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync the new iteration to the guest prior to restarting the vCPU, otherwise
it's possible for the vCPU to dirty memory for the next iteration using the
current iteration's value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index cdae103314fc..41c158cf5444 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -859,9 +859,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		 */
 		if (++iteration == p->iterations)
 			WRITE_ONCE(host_quit, true);
-
-		sem_post(&sem_vcpu_cont);
 		sync_global_to_guest(vm, iteration);
+
+		sem_post(&sem_vcpu_cont);
 	}
 
 	pthread_join(vcpu_thread, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog


