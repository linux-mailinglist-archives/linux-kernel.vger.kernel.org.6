Return-Path: <linux-kernel+bounces-215612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02A9094E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E33B2136F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2552907;
	Sat, 15 Jun 2024 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnwD1lOS"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319B621
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409786; cv=none; b=DnoMq0oN5+kzeEXdwBK/YE2cPqM1kX92CDf3S1SSHBklceL9voD6OZ4/a00n9FVu4PFZbdN33GZWJo5RkVDcoaSybE8oA2tm2TAp3sYFFlWEhcSFHKiCs2wmdKjagAIpuDWqXuZmWkDMwtcxlMyNRvJB5KPuD1QYNonW87gBCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409786; c=relaxed/simple;
	bh=ckSubXPnhKnNiVj/54x8Q0EJzPrAh+WV8AbmQVVrhOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Whozz9I3UAxNvjrJ5VWq0xssxQgbS7cCOEmLxEvSGC3XGLwBTx5FTWs83R6wEUz7dqE+q0nTvfgDYWPKcttuPMHatOjbUIZvR2X2CnIPfS1b8PeN+SfVf6ai1+CZs36rD8ACZbuAgFTNRdhH+IGY7LMIiXK27r5KxDCLYVl62+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnwD1lOS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-705e5f5618dso381810b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718409784; x=1719014584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdWG57If2wiUtVgSeqsrLCBP+D2JtONZMYQed/ktHFU=;
        b=XnwD1lOS4ERdaU/0/CvTLwl/KfQyW5a7FhTR8SJIO9RIvIWxTiWykcHZpZtfnDzjb2
         PdYB4ndPfWMoA/ixUsOIFL9zXp5vf4bTwvKz1VEiIp+XrazcDZD0Fk2We2Vv3DkhLpi4
         CYNRKiVexBT7x9zC7oi1XjDa5pYhKAX8OXUG+xWe8GRqFFw4kYjILXVE4pobC9HINdy3
         Rf45szj5r4c4xzcXHLLBIam7DsSWIfqhqd36gieINxaRivzuGJZRQjDT1sO88n7d5n7I
         9QnT3917wKwrWi26I//Pf3/6Yqhn5Xavz83kUPM4q/iEDn64yMrxKS+do71i9BgXwx3F
         135Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718409784; x=1719014584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdWG57If2wiUtVgSeqsrLCBP+D2JtONZMYQed/ktHFU=;
        b=GLxveEddnPDUMY8cATuxiunNMTv+HSS06V7I5sSO8+/xCYXxnOCJlzwn8R4uLOvtIM
         onS9mzMmbTpld4CUEwHfSoD6KexF1VP+DvMXvzOQTHXOtjXdwsDgs8I+VZiFwpV1GteM
         EpDxXd6uiyJxtWz9s2ptTewivCzQIS4QAK9LjopqXLq3gtyiuFFvrct9CWwTAxk0Ldrz
         wg3AukxdiynM4eZZK0/Z0bPHW002LXBpebl5BKOUqSNLsXmPj5Xg0Jo1a/jgmewAT2I8
         6iYGLqX4h3vGKQ8f6FyKae7Ny9o7h+A6LTYmZnMlBrdO0JGv5c1R02+pBqJQtUjXfuf4
         O3eA==
X-Forwarded-Encrypted: i=1; AJvYcCWA3IFflCpjD40zClhYomaw79pfgz81+JyVTnuh8Df1BkQxLyf67SA+T9+Ml/9Qggi7i1mYMpmfx4nVrVrLlOSoC0eSuTTIKXyoFPT7
X-Gm-Message-State: AOJu0YybWm/sW9IeTWhV9X7V6fyEurAmtpO0C1IVsmjb/KjkgeA1sY+R
	OGg95GFtgksabxod6o0vO25CSk1TtETwEjPfHfQXK6HeIsezMgz/n9CsMM7xkUn0RxWwzaeQsue
	oDw==
X-Google-Smtp-Source: AGHT+IE75Eg8FJSE4bq9aZ/BYnEr+ouKJwiOKS/K41JZNvFHP5zQ4Tli5g5aeYCspFPmah9r+g6Cdwx3w0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:300b:b0:704:3ab0:86bb with SMTP id
 d2e1a72fcca58-705d71fa325mr40352b3a.4.1718409784313; Fri, 14 Jun 2024
 17:03:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:02:51 -0700
In-Reply-To: <02051e0a-09d8-49a2-917f-7c2f278a1ba1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <02051e0a-09d8-49a2-917f-7c2f278a1ba1@moroto.mountain>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <171840971654.1410787.550758149243431657.b4-ty@google.com>
Subject: Re: [PATCH] KVM: fix an error code in kvm_create_vm()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yi Wang <foxywang@tencent.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 13 Jun 2024 17:33:16 +0300, Dan Carpenter wrote:
> This error path used to return -ENOMEM from the where r is initialized
> at the top of the function.  But a new "r = kvm_init_irq_routing(kvm);"
> was introduced in the middle of the function so now the error code is
> not set and it eventually leads to a NULL dereference.  Set the error
> code back to -ENOMEM.
> 
> 
> [...]

Applied to kvm-x86 generic, with the fixup I suggested and a massaged changelog
to address Markus' feedback.  Thanks again!

[1/1] KVM: fix an error code in kvm_create_vm()
      https://github.com/kvm-x86/linux/commit/5c1f50ab7fcb

--
https://github.com/kvm-x86/linux/tree/next

