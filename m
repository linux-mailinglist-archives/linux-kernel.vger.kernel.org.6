Return-Path: <linux-kernel+bounces-419008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F69D687C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42290281E44
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4317ADE8;
	Sat, 23 Nov 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do/QE1xL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97C15FD01
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355263; cv=none; b=IbIo+zFXwsI1NE5p/2nYG+GWCYMRXIo/lhr9irwIcCFzhqjbhWmMHCm5fqblAHH9vsCcDR76xnF71nf4BLLcxYGAoGDkwpYRHnh69Q9i346TZdEFE7qZCeSvcCCIf6CUqdAcf+1McNt+kGL5BUHZe/wMBAczcHtjQjJmob0k+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355263; c=relaxed/simple;
	bh=BnkEXVVnKFyyhWGU8GZW1deRcDBg8z2tADSZ1EoLPxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmXZ6CTshR14qANgmZtDDRPI2W3ZJnH4IG0PWP7EBBvBxayvSb29j8NqsRy1H+kaA6fplebMhtmTUCkNIIGIxT6j/u3EUAKUjlNuldIWPlXDDklEAfk+LiFZ6ZkF1Tc4Nf3HeBk1fKEb54n+TZTiprzvPcpgE7308v82sb7CkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do/QE1xL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so3694655a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732355260; x=1732960060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IdX/8pZLGsZSICxOFZ0Xebq8xGasmjhS1hPG9SrPZk=;
        b=Do/QE1xLZoEP9r8y/Iq8zRtBEvlxbcJOyhLfPSm1MeM2lRgI7eS9YOhyVJ/3yqlgqp
         3HZVI1tOWDi3Q4DnVei71sykP4ns68u1wNTGIvfvDHD6KPkTK+1M0lHhYsdYEt1gAaRM
         GARDx7xH7jXQlz+zjCm7ZPw0Qcn91mNNX8KYiSAV52TN+xL5l6HRi04/LYw/wq75Z3BM
         IClTPVjCUHZI2SH9KsTijZn6cDuFNelRUG3O731aLW1DXiEic8Dc1Oz6GMg6aj9Au+fj
         APd5RkblTsubEGaLuvwQvTxfzi+ts+gIzF2AJFVdC/gckBSWHveWQfw6nXNX6+ohOQeT
         0Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355260; x=1732960060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IdX/8pZLGsZSICxOFZ0Xebq8xGasmjhS1hPG9SrPZk=;
        b=QeNnE8ZIaxrDMdm3tvWNBlE08WmHJBkhV8af5Q3WMHuqOWPR9p8x/lxiYOpwp8rraf
         xWwk7oWwN0+s22T8BglofMFVZdlMthJck80bcPZKYLu1vWQFNRxScxtAlfd7I4iGALkR
         wysl3xF14ugMiSomikNXGJCvWkj4tUVHdskQUXM2rtZ8uM1X7wy+9EKfXTJj1IbVySi/
         XLjHQWiV6s06DSaDiZNmqrKqsYCTs+pp6X6RWjnYgPdaP1G/78XSLgWjbVi8YScETAOU
         X+g1N/L08GbgS9Ggi9EiE4pOculeEOEnX11dAEF2/BLZXxfi8sp91KsdksIlkowLl9SV
         HV3A==
X-Gm-Message-State: AOJu0YzOBPoXbVb40I5h2kuQYcaGpxVtjVDOczXxNfdRdR5JhoPJ1Reh
	/A7IR2cluHPz8bT/rEFAz4qiN8HF8DXNkOyp8wTxR4Om7xyouu2p
X-Gm-Gg: ASbGncu6wHT+8WNyJb0unwWTgYvkjDTmSVXCDyVr60CbpYX5TGa4FOifFOHTyEWXTGY
	r9fzWUOpA32RcKReTS1U9xsTcXw1KDU4FSoRdJt8JAum9DllV8aHHR+ejWS9MWi2lrkE9X/Rgnm
	OmemB86O/UrGnewsvlyYitqsDxz1bhhM9G7dVY/D/v48gpWcxlc7B1KGXw3NvsE4uOO1wIYgfVN
	aMTd8frBafPXdLnUsxXL4dxVCLMy+0UH4ImSCzFzRDFo3iifjyVJLoigqRS1bzG5A==
X-Google-Smtp-Source: AGHT+IEoLslTSuAXVFNWJoZefEF60E1sg+jCj3aVgJLZDGi7hQrHHVvXUUa7TfjZEePw7LpFhQiC9w==
X-Received: by 2002:a05:6402:5187:b0:5cf:d8ea:42d0 with SMTP id 4fb4d7f45d1cf-5d020601597mr4754218a12.12.1732355259472;
        Sat, 23 Nov 2024 01:47:39 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c2294sm1817427a12.53.2024.11.23.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:47:38 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	andy@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] retire bcmp, a redundant wrapper around memcmp
Date: Sat, 23 Nov 2024 10:47:27 +0100
Message-ID: <20241123094729.1099378-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reasoning copied from patch 2:
> While architectures could override it thanks to __HAVE_ARCH_BCMP, none
> of them did. Instead it was implemented as a call to memcmp().

> These routines differ in the API contract: memcmp()'s result indicates
> which way the difference goes (making it usable for sorting), whereas
> bcmp()'s result merely states whether the buffers differ in any way.

> This means that a dedicated optimized bcmp() is cheaper to execute than
> memcmp() for differing buffers as there is no need to compute the return
> value.

> However, per the above nobody bothered to write one and it is unclear if
> it makes sense to do it.

> Users which really want to compare stuff may want to handle it
> differently (like e.g., the path lookup).

Mateusz Guzik (2):
  x86/callthunks: s/bcmp/memcmp/
  string: retire bcmp()

 arch/x86/boot/string.c       |  8 --------
 arch/x86/boot/string.h       |  1 -
 arch/x86/kernel/callthunks.c |  6 +++---
 include/linux/string.h       |  3 ---
 lib/Makefile                 |  3 +--
 lib/string.c                 | 19 -------------------
 6 files changed, 4 insertions(+), 36 deletions(-)

-- 
2.43.0


