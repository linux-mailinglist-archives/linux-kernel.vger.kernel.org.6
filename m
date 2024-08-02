Return-Path: <linux-kernel+bounces-273100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D794648C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B97A1C20F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645426E5ED;
	Fri,  2 Aug 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfEmas5p"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917952F6F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631516; cv=none; b=ANp0QISsG7uYPP+4EEH0F2r6BuzuCpeqakDGGWcHkQ9KMOX1wm0BLHo3Tne6tvJUkoBo7/Y6LT5ykiagVCdYxf0zyNtUZkC2hWTqUG0oH1+3QFU7kffQbY7LTfD9C/D0KwJSx0uYBjK8ot2/2mbkMck1SuZHKVbLkRHBOtOk6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631516; c=relaxed/simple;
	bh=0EKMTekG2PqcHIBi8ou09HKVSjTqI9BmwZ+AxWSB7VE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ilxx1oAQWC5r8NkS9Meb1ghTDvCRVUsVlX5efi+fx6/xn0OaFYLuMwJtnZcEsMZPFLzHn0C6Iksz9zpLi0FB9DMTWV65QR/SEsujLnuFE6XsytNKp7Rhb86HM0W2mmyycXBosNIKlTuEA1jS7eCnl4ftkHQbKF1OtRkf8GGddIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfEmas5p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb575938f1so8679665a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631515; x=1723236315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmc+SGjIL8rAfHuvBfDUF1oUfGiI+T3IHfocQMC9wxs=;
        b=EfEmas5pN0LwKp0sSuJxZ17yUauCvXSGfB8uvadaPTR97iXNb6ZAKr9wnkiowUKw3T
         0xljMdpEytpElO0p0nXT9bYYnQhaPXjzVylwuBo86RIWHt3jLIoMQsaGXRwj4vG9Xr9O
         0/eH/bZsfXRwYNayJ23jLEaIGf5e1XB/ob2v1nKXdFlgdTpMG5Wn2pbzubWidccEsXby
         hzqjteMJH+k+Nf/C2Bj47SfEXpJLGy1s+VktY4AIzkfk25QU3U1qW8Mq2KEalkCVCwnw
         E2Vp6ok2KrLBQi4ZgOYm8Yw8rJfMjZtDsPlnTzTmIQYC0VfiLcoK09dIZXCoT8ZvTxno
         3wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631515; x=1723236315;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmc+SGjIL8rAfHuvBfDUF1oUfGiI+T3IHfocQMC9wxs=;
        b=la0JJGXdGQ15I02sWZtHL/R00rCIH3CE6yByUQ7ezcX+YeH+p24ZHNEvUBiA80a5yl
         IWxEXiW6t4nQasAEfyvXrz9Ov4WjxPYMqznSgGbDd7Q5MXAtgxV67539a/SPvRlTuBXk
         ulpjOP9rV3xPqbjR2uNoXF40Y+Nk0hBpRL8p6pedWXRB/D7vuzDwIc5S+cWF5NMYpmPn
         T/OEUJFX9UITqcekDnO1Mo8i9l0H9XJrvQta1CBrYT7j60cnMKueahI5I/+D44tHIZ3W
         0//0hBsIH66sQRFOaACiFZWU6w1HM3msdcr46A8YSBiOoEbA271CrVYXy/af8FIibPJ7
         6q5g==
X-Forwarded-Encrypted: i=1; AJvYcCWTW90jCImEmS82sAU1FO+EJuWxuPYWpX8zMzxu3icMuxhkOlh48YRxZgO1dx02sLpcKnTKnGg05QuYOZxG3od/VrLC/sMOMeS1Hr8H
X-Gm-Message-State: AOJu0Yw063FCOCCj9qz1+ehRfjJSaFNnQYnscrnFMP43qIpOxxexLDVQ
	csPttNH8N75v4NmtPzSHPApQhgOIZDdh3nzI6suKNYK1qjP8zpD4ZOY2OoCQnLD/jvYICMigS0o
	6ZQ==
X-Google-Smtp-Source: AGHT+IHHYSd52C/B4t1dkkwmxUIyBuw/Yequ85veuY2fdTDW1jV8v6EjSfptEUDCMZOcj82hlePhD4p/o+8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d188:b0:2c8:e1f8:afb with SMTP id
 98e67ed59e1d1-2cff93d478fmr10414a91.1.1722631513634; Fri, 02 Aug 2024
 13:45:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:45:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802204511.352017-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: SVM: Clean up SEV-ES save area management
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up KVM's handling of the SEV-ES host save area, and opportunistically
add a helper to dedup code for converting an SME-tweaked PA back into its
struct page.

Sean Christopherson (3):
  KVM: SVM: Add a helper to convert a SME-aware PA back to a struct page
  KVM: SVM: Add host SEV-ES save area structure into VMCB via a union
  KVM: SVM: Track the per-CPU host save area as a VMCB pointer

 arch/x86/include/asm/svm.h | 20 +++++++++++++++-----
 arch/x86/kvm/svm/svm.c     | 24 ++++++++++++------------
 arch/x86/kvm/svm/svm.h     | 18 ++++++++++++++++--
 3 files changed, 43 insertions(+), 19 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


