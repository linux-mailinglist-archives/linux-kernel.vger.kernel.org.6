Return-Path: <linux-kernel+bounces-515523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50406A365DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ECF16B149
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29092193074;
	Fri, 14 Feb 2025 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQa7NjO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6415FA7B;
	Fri, 14 Feb 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558794; cv=none; b=e7j/uDG8CI4dmHg1YIAJDgKoghGMKdGPYaI/aeO4lUIa6kKaeOO5wvK7ReCkeEPRu0n4gD0psUIKIBhocHpANi/xPUhKGsTUwpo1vDyfXejfM0xFYjSdulxxgwDPqb/F6fU7S0yaU8toJxBAKRc6JfqzEIrI+UnLev6HGfu0jHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558794; c=relaxed/simple;
	bh=k8v5qhdqoLemogZgoy/wTu3l6FMPkvM6W1WsDqZkZGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVX3KbuKgfu7+sLWozQP8DN6SdLL3dphPJP0d29jBvhYvcnZQnSOlPVIs//nLxPUffgPiof0Dm/hI2XdGkyt8ebY5JsxvUWBDYFf71lFVuEXwo7r0kM4cppt38Gad3GwxzHx+V0FnxlDFLzaN4yGk+ejvD8KUEYtHsPse62JPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOQa7NjO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso17109715ad.3;
        Fri, 14 Feb 2025 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739558792; x=1740163592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IXg56dbuRhTCNiC33F7bGqLw4+8lQ6Jy7WLsjN+DFk=;
        b=jOQa7NjOh5pSuh4hcckp9ZefPhyZ1fLUMiMsymFWFOeiQ6eN1AeL1dAGAiu1SIl8J0
         IU8vO6sXzm5qw21hpZ6g9Eb0V+/BLRVxjSppeqHPR6KgJ6jTP/FpzSUlHgKBVz7iMxd4
         otu3OE5nyEiqcS1USHOXAmpxumk32h0Su6g1NQCLHlPHATa0As48fW2TcUZu4GpjG1PR
         EQtIBpcK5ScQvWXjoVtlKO7EO1+SIsNgN7f+93S848ah1QDbhy42vAYqZe25GGZh0yY2
         Zdlj261FOYo1sm8UZTeoP1nZlXuTLsujY9taQ17d1XqOz4vYyi9RoVwA3PEth+yIMe4i
         xUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558792; x=1740163592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IXg56dbuRhTCNiC33F7bGqLw4+8lQ6Jy7WLsjN+DFk=;
        b=il7D9OQJBNE8E5dRLS1fu/FixmOzG0iPOvMolkyq/V3ezk6MR5path89ZzGrQb5Ae5
         953JifAMrhKawq0wY9q/kgJ7k66rbjn6OcYQPVb3+wXjJ13g89gWc+7QpuO3MhaA+I/+
         vK5hbCWmv0hRxBhcTgB1bFdYgZVDG5kyoMgW5mMR6N9VOYjCSfyAxKVRW/PdsDp+5Q4n
         Y85/UGqGZcUAzRB7R7te35h2/HZ2cVy6q0HZR8X7ghoIj8sVa7rm+wYzFaq74PQOC2ey
         54W3dqMXuyniUsLSKC9Hq4SGdDHwnNfYmI6FsUoY4BzQHEoaY1t7R3ujEnezVmmoYJTC
         /kuw==
X-Forwarded-Encrypted: i=1; AJvYcCV+RNKoOtXbJK/D0qvXQZir5pmIYjhv6bkl0wypzBnNcMAjltprIJD44Ve15gx2IGGDk0jrn/aII/i1SIBBbyQ=@vger.kernel.org, AJvYcCWruZu7KBvf/IebwQqF2Bvgfpa67JBWrAscp5Xw2rJydiP+3Dkj+9HplvyROBqI99fZnnonEeXeqLxEzmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjqVe0afVFaZ+tdi/zFXeSOCeJRRDX5SDsvDXH0K/4FQiBKNV
	pzOl4yzN1VYYBREI2l9bYUdT6la6dLrYpYWit6cf07HcFv8N8xsc
X-Gm-Gg: ASbGncuvxp9ahNzr339tOIkwk6opNWI7cSiYRcDn3QjtpUMAXz+W10briqMcF8Z69DG
	sRvQkGA4BqP278QYTUdDaxKvT9pTBboN/kx+KMMnTyGbobN1DUGNVYvrqma3e60KrloeXjLoXcN
	HxwsGoAoNqyARmilv5QiT+CbZ1be32/JHuyHU3gP6yw07fL+b3nFM7ex1oc16hhg0Zw0Jr+6HFk
	zIhaR2dRmYC8gecILQddL18CyLSCmwbubo8mBrZc4kS9K/nG5C+cDOcfRp7QhqY5rCHuwTtplcb
	HLtmUlDVmSPbKmqPdREwg5Ob
X-Google-Smtp-Source: AGHT+IGEa2xoAJvGqA/caRei46XDwuVUymioMu0zRmdpSVxXXjHeG9yv8YE+8gzbvVeQyob29w1/rw==
X-Received: by 2002:a05:6a00:3d49:b0:725:e37d:cd36 with SMTP id d2e1a72fcca58-73261779909mr877375b3a.2.1739558792262;
        Fri, 14 Feb 2025 10:46:32 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546841sm3438637b3a.1.2025.02.14.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:46:31 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] author field in module! macro should be a array
Date: Fri, 14 Feb 2025 15:45:48 -0300
Message-Id: <20250214184550.120775-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field has a string type. Once that the
modules can has more than one author, this is impossible in the current
scenary.

- Change the author field for accept a array string type and enable
  module creations with more than one author.

- In modules that use the author field, change its value to a string
  array.

- Change the check patch to find poorly formatted arrays in the macro
  module!

--- 
V2 changes
- Merge the changes in module.rs and in modules that contains a author of
  module in a only one commit.

- Remove uneccessary "FOR EXAMPLE" in checkpatch

- Change from ERROR to WARN in message that is throw in checkpatch

- Remove the hungarian style namings in checkptach

- Improve code formatting in checkpatch

Guilherme Giacomo Simoes (2):
  rust: module: change author to be a array
  checkpatch: throw error in malformed arrays

 drivers/block/rnull.rs           |  2 +-
 rust/kernel/net/phy.rs           |  4 +--
 rust/kernel/pci.rs               |  2 +-
 rust/macros/lib.rs               |  4 +--
 rust/macros/module.rs            |  8 +++---
 samples/rust/rust_driver_pci.rs  |  2 +-
 samples/rust/rust_minimal.rs     |  2 +-
 samples/rust/rust_misc_device.rs |  2 +-
 samples/rust/rust_print_main.rs  |  2 +-
 scripts/checkpatch.pl            | 43 ++++++++++++++++++++++++++++++++
 10 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.34.1


