Return-Path: <linux-kernel+bounces-203367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE58FD9FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AEB2856BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B248160793;
	Wed,  5 Jun 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emHMLE2/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC5155395
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627534; cv=none; b=ZA/lTHHmXTIE1SHk8vOHDchFXP0Kd9KjXgXUmv6F7R0coO9yCjADUXTSdLiW0nwrWQ9W99G16vk9J4feiG5eNND/l4sMAIcctTBWk6RK9YF6Z6IMovIDGzqVy/By+LufDcs+ItpICkzDyt6X6bMlFof8/pO/IAgJ8jJZbXkJoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627534; c=relaxed/simple;
	bh=mf7aKJTKGggmAgNjvNLsXZpV2sd484SihQhDbyFc5FY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kHAmpKA33qhMbVWmk9RwVxCC0hfhohEDw+3lWwyTcZ9doL/YBj9AxMkyF/OL79W7mCRo4dSM77T+WSitPV7jdBw4evHedFZU9xxVrOVpS6Yi7vYI0MvSRpSfvTZmkIUyu+48BVnth+/xFTspUpZaDuBRDebSE1OxN/gf/omNlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emHMLE2/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso185685a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627531; x=1718232331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv42HdOcUKJtArSgUKGYW0zjR1yR4kizVdwWHo6frk4=;
        b=emHMLE2/HrPAoAKq5Tvb57eqbg6gD3KiW5Xf1eEeUJNw6UKggIRoK4TfvrVVvPOGc0
         4leiqV6sYUviugOIYy7z1PTE+abt67QIBf05MGH0wcuPn1yiOFe30fMW4oGtJIe0qASK
         ovNJh1umBSrYpUvr468ZyPvRR1DBMznvb50H8eEps71RX8uPk0MyU4yh7MH9MuyFZ2aX
         prNRaET/6ChKAYHUKat+Jfe1TPJv3FDsdlCgPVzCF7OyHv9/Pr+/U7JR8RQTxUpzNyrk
         YCONr5YLK38/aJiKRjV1yQBiHfR+961zzj7mWlbPOXfQMW6yHFfxoOXKddm/9jjdR5rx
         wkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627531; x=1718232331;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv42HdOcUKJtArSgUKGYW0zjR1yR4kizVdwWHo6frk4=;
        b=SQVt37gyK6nrNL6Vc7W8vrFuWFG3GUY+cTDfji4uWR3anhtnAMUP6YykY9gDzkAC7N
         8CchsQGQJIYeTcNj4D/HNIGx3Ad97SPt8X2aqIB7u9TA7fJy8qRVmlnvGa82JQBnZsCw
         H3TFlTYGDd3pIbSwyeK8WyiEUl03dHdeTYgi/XJydiEger/+6lpz/ecvpM7/h6B4yY/+
         VGMMO8WTNWfuHW28zGbrIZ1gou+cBCWHmaugMwH5ABRmMU/ZvqDVkrM4PbxJT/L8d/0g
         70o3PLllElYv7RtKZOVLSIYQQL648mT7pF4FGonvPiF5BsZVqKG3ywjPYSUrOpIvkSwG
         cHCg==
X-Gm-Message-State: AOJu0YxSL7mhyEwXoOv1Cg9h4m0MCVME08ZagHnp7V4AUKImxuo8iSTh
	S2yPt3VmKlkB2/fUQ+NGvIcc8o+jQgQNJ4tuIXbOKgbwXH9IWS8kV0wBvW0dHJ7JhBS9AstYqW2
	qiA==
X-Google-Smtp-Source: AGHT+IHZi2wMx39MEpFNykqh5uofirx+cfL9Zu4nR4t5J4mD+C60eDxba0CILAYsZSUzLvoKKkgKqaUg4b4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:680f:b0:2b6:4220:159d with SMTP id
 98e67ed59e1d1-2c2999ab0e0mr3719a91.3.1717627530167; Wed, 05 Jun 2024 15:45:30
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 15:45:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605224527.2907272-1-seanjc@google.com>
Subject: [PATCH 0/2] nVMX: Ensure host's PAT stays sane
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Xiangfei Ma <xiangfeix.ma@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug(s) where test_load_host_pat clobbers PAT and causes all
subsequent tests to effectively run with all memory mapped as UC.  Xiangfei
first noticed that this caused rdtsc_vmexit_diff_test to fail, but it can
also lead to timeouts if more tests are added, i.e. if more stuff runs after
test_load_host_pat.

Sean Christopherson (2):
  nVMX: Ensure host's PAT is loaded at the end of all VMX tests
  nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR

 x86/vmx.c       |  4 +++-
 x86/vmx_tests.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: 765b349b6c4b1c06473dfea548a15f799e0fbc2b
-- 
2.45.1.467.gbab1589fc0-goog


