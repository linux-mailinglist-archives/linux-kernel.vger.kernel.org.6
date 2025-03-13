Return-Path: <linux-kernel+bounces-560191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74DA5FF21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C0E3B97B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB51EE7BD;
	Thu, 13 Mar 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT/0e16J"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB6189915
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890167; cv=none; b=W4wyxDDmGfwoGsaw1iNxjL+8l/CgCrPwY/zS7jJ6JxB7Cm6mCrHA3MkdS5dieWflGacm/Ts0quQDRqeZjjrgl4zY/bNt+MRkPb5smtuk/iw3MqlMmBE6yCrJHtV5JDBj5xXmRkfvJf7lWLHcLFHzJA6Ol32k9y7gfttSPdkO5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890167; c=relaxed/simple;
	bh=7nYCE9T0OKDIgmF1DPJwJqcapaUy9aKr/ysB5+DUnj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHy237nMTNylnhIXVSg37gs5wbS/QzbtI0Xv7MsdgKkyNHMfo9+ZMDDQXc57Id08kkpf8WKcoaeAVHjd2XAO3Jjmk1395TrTwbpda4lONV5P6Gh0v57KR+uGbR0mrAwb6FDWKvt3rMwZ96pZKShGHOxuntI9Bteg0aMxDydPNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT/0e16J; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6feab7c5f96so12039897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890159; x=1742494959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejbR4Lv2ZaXknZh8BlEm9Au1Z944R57x9A5ac0N7Rqo=;
        b=HT/0e16J+CmqGtQ7hOjkFjJXfK4HCNQm6CEPluPivtE7yT/Bt4VaR+kwCTUdOtSsOB
         iygVY5Gx7Zl+mAzUCKKis/LPAAdw89sHQuFkUmfvV8W5BdeGWFHRI4uIleSsuv9idUVX
         NF/NJQU9yX6SGMEN8rO8VefCUdj9meEIqovVOEKtF+c0yiiD1TEufx58xji94VjDPe1h
         MUTGetlJmiGtDynrp8FpoFpgirhvA1S+VOdyk3Q/KKf8crw/cwmsrNy0X+UZbcOfSNTa
         UX09OupcDgduDI1Bhm6IJisiSXQ4L0PxTwVkIIOeg+6aSL8SiLAfyRLW4wKKV6s5uxH6
         nPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890159; x=1742494959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejbR4Lv2ZaXknZh8BlEm9Au1Z944R57x9A5ac0N7Rqo=;
        b=h0Os9sJbRGhZtm0ok6LC45uWhn2jFyO1nS77yROf8dRwnXz0mnysn/tz3JsuR3LP4p
         2nfaTC65u1D08CEtS7sTQHKEZI6g/h9TGyqZ5Omyf2FTVZOQMzIETiUh+FQTob+orD25
         tNDNcFmx3dJ5yMMekhvtl/FBw+yqIP8galT1gLOjVpx2wGyijko8L3ljTitSLI74ORoF
         /63wjlEOXz1cm8/ZhyqXqkVSSNzUlwTzGT+ws3ST0NkzJ2QQDNU2KCli9ePLRsd2sh1M
         JikN0FAym5L3SjdnTJKXFIUTLMrVb84s2ef4LFenQhwh2a0DPusE2pSXqy8Nwyn/LnXR
         32IQ==
X-Gm-Message-State: AOJu0YyMAzqjg7DeIuSWRPTKh6XicgEqgdB8uI/hTQrieS/Gj4uSc/5K
	XMRzvpYniYX0owEcGyFF5+C4UUZXQZ6VtgZBG6UpFaYGK/35OW6483ST
X-Gm-Gg: ASbGncsn6D1NNfWIczlBpAImepkHs3NR/wprpxeMAttQDKQ4jpept62STaJwnAF5WVW
	2A+HAIHxGj8QlNNQYQpMfhpTblQpToyEvXgjK90hPlYjfKZ+q79QyZYZru/zCrk1425zGmavzko
	+0wGbN1OGkaM8sWUXETJtGwPmos9RaGHr7dtHe2vg3Eypu+TGZdI+gW4rtCGw7qez3UBLdzCBOL
	Mp/WBGzGpzj1TqkAn+L1TOCWF+XyyoJ8X/WYbAb6pbHweu7pKnbNt3vu6QSqrOs/ES3vIj0tvm0
	ok61kb1iUZ1tZ7xqkZsC8NrPaQ==
X-Google-Smtp-Source: AGHT+IE0p4A5ZIJGH0hsvyfp68wcycD8yTR04IzcbRmr96W7maZKNQmusI7DhABZAhzQTGrbGjWVTw==
X-Received: by 2002:a05:690c:4b87:b0:6fe:af27:33f8 with SMTP id 00721157ae682-6ff421263d6mr8826647b3.30.1741890159409;
        Thu, 13 Mar 2025 11:22:39 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:38 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/5] x86/entry: Break up common.c
Date: Thu, 13 Mar 2025 14:22:31 -0400
Message-ID: <20250313182236.655724-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscall dispatch code originally was put into entry/common.c so that
common code for entry from and exit to userspace could be inlined.  That
entry code has since been moved to the core kernel.  There is no longer
a need to keep this code together, so move it to more appropriate
places.

This is code reorganization only, no functional changes.

Brian Gerst (5):
  x86/xen: Move Xen upcall handler
  x86/syscall/32: Move 32-bit syscall dispatch code
  x86/syscall/64: Move 64-bit syscall dispatch code
  x86/syscall/x32: Move x32 syscall table
  x86/syscall: Move sys_ni_syscall()

 arch/x86/entry/Makefile      |   8 +-
 arch/x86/entry/common.c      | 524 -----------------------------------
 arch/x86/entry/syscall_32.c  | 336 +++++++++++++++++++++-
 arch/x86/entry/syscall_64.c  | 116 +++++++-
 arch/x86/entry/syscall_x32.c |  25 --
 arch/x86/kernel/process.c    |   5 +
 arch/x86/xen/enlighten_pv.c  |  46 +++
 include/xen/xen-ops.h        |  19 ++
 8 files changed, 522 insertions(+), 557 deletions(-)
 delete mode 100644 arch/x86/entry/common.c
 delete mode 100644 arch/x86/entry/syscall_x32.c


base-commit: d08c0d55110b7cbac186e5fa94b0c6d5f4d7905e
-- 
2.48.1


