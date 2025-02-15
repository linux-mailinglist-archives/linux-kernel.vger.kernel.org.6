Return-Path: <linux-kernel+bounces-515932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F6A36A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787A41712F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0113BC02;
	Sat, 15 Feb 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUUOrfBQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60033CFC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581575; cv=none; b=nzjNH0WhXPwhW2W4+60xlQAnII7IKDtjzry6IlVCIpbA0D++6KmVpy2HnDzYKod3MzXCA2oHe1nLiXeWsbB0ikpCGannBz2ovf04SgHyNY4LpvNGyh9HDsuIfak5ZpzUmvrL9uf4h8P/04odPxN8awvMR6D+zWtjUejvM+Wcybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581575; c=relaxed/simple;
	bh=c5mT1kKJrJbBoF8W9ov5zGDfOIg+OOelnEWtDsywTcU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CjQ3a/U4lslsbyHuXWG6GpxPcAtaXMI25NZfbDVDTX2r3OwCrWkJMzAuyXDhoajvJq99eQrEgcHLMY0hM/Z5XOzv6fIodRgWPycaCEhMh0aal2Gq9E5S02EHPL53aFTeB6jVOTPIRF8NT+gdI+Fk1IzKfK2BxYiIhlqR9tc/das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUUOrfBQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so8083205a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581571; x=1740186371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2wtXUfCTjgHI7TGu3PXE3lApHG/pri/NcZ6lpL1NqU=;
        b=aUUOrfBQtjyEL7Uoo8LaAgBCJSPbu6DO/bZ6+sK7gh4Z7c2uRK4IuCGClNqY6UI/S5
         F9+CMU7RQLllJuoiRg3gbWJYpODjQdIQXXU5Y223OGJRO2SfjfnWKoJ6fudXY0HFAqMZ
         tYq1cxL1bNgFGvzdOyWdhy7OI0yq66NTsmd46jUynp7VkUfUD3WrFMJFLdHiz6953wAa
         WiLiRdeWfqL1wMV7jmeJmM7vytX66Cbjgz15UJzkAfFQrJHZATCmFRlrt8YbQsgUXDc5
         kAVA3TWv5/nV0c2cQL+O5cRUUqyTaJOXYsPdAi2vIHbrRr3nolzsUD+YdgbPmz9saScK
         s2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581571; x=1740186371;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2wtXUfCTjgHI7TGu3PXE3lApHG/pri/NcZ6lpL1NqU=;
        b=Vzu0Wv313JJdylqCb4nP6+VwqBCIkFaBh+FG4GSfe6GAniQBJ138eNNwT+y7xjddOQ
         Sckkvcb0HpFnj3/v0njKogQpnLnHl8ESgdAviJxeLh3SzOSr+uIYCeU8pXVBzspXlcqC
         ky20LRbsWg5eUzYKNyfUxjOEWeI59bGgaS9IDsNo0tJq81HZfz1IU3ZlE/Ymqac1J28M
         1We1JnNwxIu3869OlvICJ1Xg85oyAaPVucOgyTVnddGYNbV4Ksa+rA9+HaRlQmkLCeGa
         pOoCaPAhwQ7aqkVMn629y2qBv4I3JMN5M8afbmph4A8C9JHjPZGrd8H5ej/2DUH2shha
         ipqw==
X-Forwarded-Encrypted: i=1; AJvYcCV5f3HocIIkgwibTacIe5D1K0k7S5xpNMlhfOZ0Pb7i6gXAv7eoMZ0Csln4IBp7/W+7/bnkCOTvAEc5K1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNkivHfYIaOfuBS0oC47nFGTq1ztBx0i8bcA60t86NPJ/rHFD
	9OiBRqChSKHoEnmNABAI9IFh4I9GSGuGrxK2ZKTOxTetNysWO1uoIzkg06lxGop9o/BN4rtzjU6
	Erg==
X-Google-Smtp-Source: AGHT+IEYCzMbuX7xHl2Nvmsne3PdbtFPA0TlA2NZIveDqibzeV+LpQ2lV6/nn0zdhPIjP5m+GvpznOHJPUU=
X-Received: from pjbtd3.prod.google.com ([2002:a17:90b:5443:b0:2f4:4222:ebba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cc:b0:2fa:229f:d03a
 with SMTP id 98e67ed59e1d1-2fc4104056emr1548474a91.26.1739581571648; Fri, 14
 Feb 2025 17:06:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:06:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215010609.1199982-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Fix and a cleanup for async #PFs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix an issue with async #PF and protected guests (which really shouldn't be
using PV asyng #PFs), and clean up naming related to SEND_ALWAYS.

Sean Christopherson (2):
  KVM: x86: Don't inject PV async #PF if SEND_ALWAYS=0 and guest state
    is protected
  KVM: x86: Rename and invert async #PF's send_user_only flag to
    send_always

 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/x86.c              | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.601.g30ceb7b040-goog


