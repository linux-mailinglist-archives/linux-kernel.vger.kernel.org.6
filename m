Return-Path: <linux-kernel+bounces-213428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293C907537
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1061F22575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67214600C;
	Thu, 13 Jun 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYv5PwDn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BD145A11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289204; cv=none; b=dSLVKDw4nbSm7tEbQ75zT6XiDjWlza7qvibFBFKTLmx3UAsuBEtU0aCw2wPqHhcQwqdsIp04ZnTym8Jov8fNg+2BkS1DZhwBXMLRcLZW0j+dKQeedwYjajK7DMuUB8j8DjKwN7BbLE3YQ3aGZk0lpJ9wFM8lxbvfJda1qxLMlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289204; c=relaxed/simple;
	bh=36k0SvBf/xqZeOaPdRVVmeSGR1kCRx71+MzeGyhBGoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D1ompfl6OZUFwrHW7d63jil6TigJLMeG/Z3JXFpQm61l91QW6SHSJkzkpjMR7v0evxkjvUe+aPEMWXEpdWbH9FWPezdRmH2u6byAWhZomN0jvcExB9xwQ8kuwWPghTO69VDmaPbjL9hA3BYaesXmV5u3mIbPzeW3j3oZyCHq8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYv5PwDn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1c209893so1275772f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718289201; x=1718894001; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6U1CejGzjWUwZtad2oj4Tzh3DOcxhD9vinE0KAneMg=;
        b=sYv5PwDniEjZ5EGlIWZEB+W7R83U/wvW7Sk9WZvBdh9qP0Sqjywc4cuzDPtedNqTqX
         DAKem/ueqwKWiFPwE3jgWOdYCpOfzIFenL2wlV+98OOtsLLCnnBdNBUNNWL9ejtQXfqt
         MZbRIWPS7wQQIRDPcDymXPjKHHDgh5WWYA4/LLrrSTDyeR2nMZ4Kf0dowSVXtiNAwRic
         nYjACNvRJ4oGwzS25zPTwQl3kwqlZPFskWXMkzpy2N7XYCSbQgyYkRrrZiSeAqzIviMV
         HlxTbl1fEEcyhQAvUZBOsKfo7xCTo8qRUd9zQAi2kFhIy/bw3na0D1XMLQKXk2XHS7d9
         MmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289201; x=1718894001;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6U1CejGzjWUwZtad2oj4Tzh3DOcxhD9vinE0KAneMg=;
        b=q02tBxxOvZ/tlVva1VT5nFhHdBIeP2W3Q24FKHVP6Y2uXaZqROWvYC+uqwfzm844U6
         AptM9r+8QS8gakGV9A2pdoJ7JhYB40aI3gqkp0sZW2Li/04gkDuki5dc+1PgLNRg+OZg
         Sp4+nlKaMPFZKjnYuVopOBs+LD2jipyCNkJqMQbWEc0kgez1yHz10ODq59zlOQtiVy5Y
         zeruv1VWumYHyycICb9wTcxsYjFjSeAmqtE0B6c1sEWI/CFG1YvXYptqwrsF8JA5ujGl
         r+1GoRgxIkJiktwvZiF4tvTtVeBWtYrQPcKCat4zRAkdOaPHuhHB6yXILEuzHVf4Jbw+
         NsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXriR2b4t4b12/DiMJhp9V+DXvc5YkU6llw1/1nwu5jwZbykAUHADpmr4uOSsbrXIrSyPprcrZVzz9h/Qew5L/eZ1gKazPeaMUBxbMO
X-Gm-Message-State: AOJu0Yyba7j4UVFTGalgkJcxcXd0xe7D0KrbA5klqKWrTzY4wtWJKyH1
	XqFOCU530QKSD8Ts9TyFoW9nWwC1Nxn3oHS1wh+WYBTEpK8mvBTgevag687Wm6Q=
X-Google-Smtp-Source: AGHT+IEL71vJla7SdEu7h2w8oi8ZuIynKyftPuJdsCsgUx9vcPoZ8C1LBzMrSr8Hgt+9Gwu3fYiC3Q==
X-Received: by 2002:a05:6000:dcb:b0:35f:27ec:ffee with SMTP id ffacd0b85a97d-35fe8926a2dmr3951164f8f.45.1718289200747;
        Thu, 13 Jun 2024 07:33:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c890sm1905357f8f.28.2024.06.13.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:33:19 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:33:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yi Wang <foxywang@tencent.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: fix an error code in kvm_create_vm()
Message-ID: <02051e0a-09d8-49a2-917f-7c2f278a1ba1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path used to return -ENOMEM from the where r is initialized
at the top of the function.  But a new "r = kvm_init_irq_routing(kvm);"
was introduced in the middle of the function so now the error code is
not set and it eventually leads to a NULL dereference.  Set the error
code back to -ENOMEM.

Fixes: fbe4a7e881d4 ("KVM: Setup empty IRQ routing when creating a VM")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 virt/kvm/kvm_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 07ec9b67a202..ea7e32d722c9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1212,8 +1212,10 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	for (i = 0; i < KVM_NR_BUSES; i++) {
 		rcu_assign_pointer(kvm->buses[i],
 			kzalloc(sizeof(struct kvm_io_bus), GFP_KERNEL_ACCOUNT));
-		if (!kvm->buses[i])
+		if (!kvm->buses[i]) {
+			r = -ENOMEM;
 			goto out_err_no_arch_destroy_vm;
+		}
 	}
 
 	r = kvm_arch_init_vm(kvm, type);
-- 
2.43.0


