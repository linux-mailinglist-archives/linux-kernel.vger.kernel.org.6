Return-Path: <linux-kernel+bounces-173633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E694D8C0329
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB28281EB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605812D754;
	Wed,  8 May 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCM+WFPR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FED12B153
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189517; cv=none; b=Reg0KVGR+5hSvbYgTO7tKv83RVj234xVTY15oaedV+bp/icqMr/Y1N0Eptxom6blrVAqgaX9zBn4/oFosnToduSLOtgdJ4xnlqG//vB3akhZr1rzZtEGZCMLXjQa0WHnuTo1iTz+iuUPPs/2l76lxFJTZEg8evTQTrQ6Q448lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189517; c=relaxed/simple;
	bh=5xDT7DTBCjbbpPDtqZw3zek1av22h4oXew+hsl9hZOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8sPsMHpgoKxUc7xdv4YQ+sySpvJRdJEYVqJ5GNpQSjcr6R2GAmA9jT61iqH+shgvSpju25TIo3fzMwNPCuo96o/qeXNGIkKel5JL6IABINjOxpnHtgqgFpp9qvuOV1gRFKcqCdP1iMZoCAG3jvoN/yZ+n4j6CcmojmrZQKy/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nCM+WFPR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so28020895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189512; x=1715794312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LryZi+4xwYKtyQkC5nMcWsfEgNGSH+ki5if1tY9mlg4=;
        b=nCM+WFPRZqK0n4KYwKTC1b8m6FM5oyeYQZTwxokQ3YCgYXM+mUFSC+4EvK5pOzaXCZ
         eVQkOcuUr6vvWaWxylVrvp3mYYwm7FHP/DKtbhyfocIN+AoUs3bfGis2eo3an2FMt4ND
         PaooO3ZMWyXWXvvP+/AIIzWj6/bTVMTZ51qoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189512; x=1715794312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LryZi+4xwYKtyQkC5nMcWsfEgNGSH+ki5if1tY9mlg4=;
        b=XKqMn3Y+3gv4i3DxbsKqNIBDyAdX3tKRrpH38Yq+WlJYBz14KxeCvL1XBhXwBz1Suw
         V5y5aXKWvRGtfxnb6oHU1pUHH7Ra3Lr2CEbNsV4V/+vDkQaXCiy9XzlMy3p1p5DSV33v
         8zYwgK1Dt9sKhNGOjL/NVizero8nGNkC+0Q/SdLEoz2nMpXrktRlWwQxV/lCGY8LIb1G
         GC6zTgai0VXejKdDJhXXKrYiVrMSG+sDDmNxDGlp8TgE9eRubleUfSxepOhUZDL5Jgpj
         llfRX5q2gn6a8us+wWsIX+FddpgmjMTYHYJr2JaU3VCdE/0VXbg8egab/j72KbJ70o9b
         PhqA==
X-Forwarded-Encrypted: i=1; AJvYcCXsWCglvTLxbT0v4x/olcpd7eVNAD+8IaawusgaVDACQBOOarzBqUKwNpMs+QofWCHbiiHeGV5XkQ7qcUdlgFpEQNeqplgIWf5t6XRj
X-Gm-Message-State: AOJu0YwFkbTlcoXmvrEClviamEEJy9xF+cbmlswqIW3yh0J50jJBZ7q4
	VE+ZIv5PMZ8R3yBL9G1I6UJK662cXHgqMZjZwT3gHqLcggF2Z7KP9RdqoN4g3Q==
X-Google-Smtp-Source: AGHT+IEBz3iujEGHUiN6pMwCCHLnL29pazXkZjYSQaEFT4k7Uon0fGO9xIj8pPF7qEuotMY2ECs8Zg==
X-Received: by 2002:a17:902:f681:b0:1ed:867:9ea0 with SMTP id d9443c01a7336-1eeb09959b0mr33516135ad.57.1715189512079;
        Wed, 08 May 2024 10:31:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e0e977f655sm12119608plb.159.2024.05.08.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] binfmt_elf: Honor PT_LOAD alignment for static PIE
Date: Wed,  8 May 2024 10:31:45 -0700
Message-Id: <20240508172848.work.131-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5xDT7DTBCjbbpPDtqZw3zek1av22h4oXew+hsl9hZOU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7cEADvYffN1IC7/pVMiNzZAqfw7Siu+Vh+L3
 X1eDIp1zK6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZju3BAAKCRCJcvTf3G3A
 JmkbEACfFPYAlzDSyubCWagkKZa2qIhZ6/mp1d3/SgVGYzBvGQnXlJun4QXlTonBEGtFOXgxdpl
 ZwxYMmMKIVUgMU9c1MH/KPPOBmIaWpU9jjz/QrbWsNuu4VmFN1Gj7nl22S/nVG7HWsVv0jpC4lz
 7Sqs1+HpviNBmb8g6pqStPU/D/Yi/UrYqEonlqv1ZwHATGOK38l338xxyK9Z1ojBFHo1X+Qcb7c
 TabR6GmdvbsmsUrMuBJ+grnobY0qs11GQoQuOcHeLRQ0l8rLh3QC5Byrc4BU/2CiJQ5uschDVvy
 ZLOgpYnBNtypoT2jgmSYL7W0U3m9Tud5jZMJo3nWeM0SWGFnQxCFIA9/G5yUPoXUDs/ChAO1ZFU
 WmAvz4xGhA2LFIJew4hyv9djB4hMTzOjgCmEWb5ruq86U/vV5xXGTw6p2XIXfGNmTJQ8A88U+aO
 DT+IWPlcpvcH2bIaabMPuVsazNTByLLuKaC4hWlxUsbcT2V2sFysugeQmnBu1AkmNPic8F6E0N7
 m8PIo0vEubdPVFgKmSjqbnq+ggAollnp/GowN9s+7GGpWt8CYdw2JCLUkpz8ZjuqmT4TeBjspib
 +V6QOz0laYM4paS0xqONSlvrmCyanG2EFHXRFITXzG7F2xE/cH266l5bxOaoZi35b3UzS9Reeop
 xZN+QDCi hUsCcdA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This attempts to implement PT_LOAD p_align support for static PIE builds.
I intend this to go into -next after the coming merge window so we can
maximize bake time. In the past we've had regressions with both the
selftests and the ELF loader. Hopefully we can shake everything out over
a few months. :)

Thanks!

-Kees

Kees Cook (3):
  selftests/exec: Build both static and non-static load_address tests
  binfmt_elf: Calculate total_size earlier
  binfmt_elf: Honor PT_LOAD alignment for static PIE

 fs/binfmt_elf.c                             | 94 ++++++++++++++-------
 tools/testing/selftests/exec/Makefile       | 19 +++--
 tools/testing/selftests/exec/load_address.c | 67 ++++++++++++---
 3 files changed, 130 insertions(+), 50 deletions(-)

-- 
2.34.1


