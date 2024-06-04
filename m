Return-Path: <linux-kernel+bounces-201565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B38FC00D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F4B1F231EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7314F139;
	Tue,  4 Jun 2024 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJW1vHPG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043514D2B8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544401; cv=none; b=nOfptIhmIaXSgav8YbTWVgSMCIBGi4eGmIKSfkF6xHkD1ZJSZYEuAgrs45uUwVc/6iIgOye8KEnkAzepStm615HjZLrUJ+T015eIv4GNll3LiqHzH24JSQl1uAxoDiITtch7VzKeBDHh8/ee5L0bcCMWfuHup2rxB2eRcBH2j4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544401; c=relaxed/simple;
	bh=ZkUU2s7YT2yjYFDYrFKN0OyDTFEWJ3XnBoulxDsjwm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mp37t7oGrUeQWAgviYpdhQd4CCkh5uK8mzahni+04HQ2JA7Onnt728RdGfw5STCPuTCVrJ5PEn7B/SZtFcouZCev7Fw52sVHoVA+F9Inl9F69VvQq6U0+mot3LoGqoPTcb0tQeBj44B8wh8+1JtUtqKi1lGrvDKDl1UHU6ggSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJW1vHPG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a1e9807c0so5424307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544399; x=1718149199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SE7huESKi5HuBouKDmqrLhttjeAwWKTCKSgfCkXoz4M=;
        b=oJW1vHPG8NiO3anCS5PKnK3QeAGkt4/Kw32b+mkuzMsFDXuZG9Vulnp77K5EgOOhJB
         T8ewBZb/FIAeamk/vkCU65HATC/AH5mamtY5qxphMYLiNjvY4qKFJpkXmmoQMeF5Zo9Y
         t+YeKHA2Gjcyq2OCvuiB0O8nkQBdGb7SeWfNRbJjckMAxYUm5euSN35GNCQhn3hh4bwt
         fgqL4c7Wq+iPAcV3h3fAnCtHD1Amgc5E18zy3JKNcTFmt9JCmfGdGwzpGEAeBDtgz6kN
         FwVTqaLiWRd01crOT+uNnJXVnudzWEdmB8UuuNxo/7A3HGuRA8tg26ozpCUBMCevmNXJ
         dVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544399; x=1718149199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE7huESKi5HuBouKDmqrLhttjeAwWKTCKSgfCkXoz4M=;
        b=QC30XqRAYdIzujyd0YgoZEJaMsJujGPwZteXUELIwzMvUH6nS19eDReD6ukuOveg2t
         D/0/DRJUcuRDLu7gyBgckjGxluu0w4KelLu5iSB+vdORzUQAMWXBZygszdhQoaWZd/Tx
         cj5e1o+o9gQHBvrSi3kMdEMrV/ky3YipD2YgjjrgGfyIGUxvqUc2DbYSIfQZrPPHDLPf
         H8a4d+Jdh2KJfrY45wbDtz063f3wv5w4sdGIFGwn+aEJc7shcuBx2mYJFHPv26cQxMnE
         G+FA/LvKLXrKiMBYgZ3iyQceBYTnqGOPRJyF0Qs8uw8qRaPsCSE245MoYMMPNWdQChQc
         ny4A==
X-Forwarded-Encrypted: i=1; AJvYcCVFH+T7ngcIwFVQTjf7/8ZrqpMTBhqBco0Tayn1mwHHhxR0SHx+RMop9lRuq7mElf49xnrY0jZUXwH6XgvtQ4vC99eGqULLeRqOQZ/+
X-Gm-Message-State: AOJu0YzBTyGIXFDNO05nTmfNbAqNKuIYGqoKmaJon1e5UCSrcyP4wQfH
	cwkEkxZftOJdhJTD3HtsMVst6+xHI2sKRqfh55VBiL/UqsABq1qGklYwcoedVtdEycBl8ZrxB9T
	8UA==
X-Google-Smtp-Source: AGHT+IFEUfCRDeqFSOjfCbxwRuJDNVLj1qRCvp9i4iWFvxVDCc1hcitsMhTyH4opoA5K/hQxiokX37nuRys=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c906:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-62cabc4cd34mr9648967b3.1.1717544399227; Tue, 04 Jun 2024
 16:39:59 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:53 -0700
In-Reply-To: <20240602235529.228204-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602235529.228204-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754329970.2779150.530235553362373493.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: remove unused struct 'memslot_antagonist_args'
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, shuah@kernel.org, 
	linux@treblig.org
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 03 Jun 2024 00:55:29 +0100, linux@treblig.org wrote:
> 'memslot_antagonist_args' is unused since the original
> commit f73a3446252e ("KVM: selftests: Add memslot modification stress
> test").
> 
> Remove it.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: remove unused struct 'memslot_antagonist_args'
      https://github.com/kvm-x86/linux/commit/f626279dea33

--
https://github.com/kvm-x86/linux/tree/next

