Return-Path: <linux-kernel+bounces-561653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDAA61490
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBE43AE55B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE32010E3;
	Fri, 14 Mar 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MooJ+87A"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13537200119
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965151; cv=none; b=t/xTlk93tx7NSv+usavfdkR5zeOrkGgseEMftQk1KdR2hO2NAn6muA0yTC/cLY+ktBqqYfhrSr4gD+OprxL6yhs+XB7pvmav8zJJo4omZJMFZyu78xqZ+B+uoD4EF2m3N1ASfJ6WFnRWnBU9sS8YOvkjXTOLpVFjYsc3rHVQZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965151; c=relaxed/simple;
	bh=Z/mBFWOWPN84KN6fCGJCvisqvkWYZbVgUOuZyBV7HN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBRDfYPE2LS3p97XM1IpfJA6aPv/1HpVzf70ISgGg9rc4yAgsVAAUUtcDdmWjP7+IJX5emBdYjc6hESfCV5Tc1e3iJK7h3l6qwBDIcler+1apcXGjcXyOePCzKVoC57KVh3LTiplH3LlNMv9MxwmE1/v4sUwtSHI9ypSMIuAPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MooJ+87A; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72bb9725de1so240489a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965149; x=1742569949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3KZ1/oQaXA08a0eRHybd+5vc2Y6bCCMmFSxKY7Yun0=;
        b=MooJ+87AqbVVg3DMlyvgGR16Zzk1P8wI3rU1q8KzpYVh08XZKLsm9qu66oUBBimRCI
         M8mF1JOcxpHGKd5s4E6l++XwH0g9hdX87gFc+Qtx66bFy4yfqeu4vhqfAM9In/+Ka8RQ
         TE9mBrnUzQCFx+YfQiLw+ndENQBDrZEfw2GebUyk9hRv2GY4IHClpkm4hQ+e8tJh9yQT
         4bF31UIIye5haJaNl26lM5P7enTLCV+Gr0Ol2sL7ttyNRXEUijGCcSdsskCs6OX7+uFa
         WvsImMBcgQiBeNYC1GONnWTt7jUv5oVSDo1MXwEbqjYaxfN+PjtTs2Mn8xxGqokeQLaB
         MwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965149; x=1742569949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3KZ1/oQaXA08a0eRHybd+5vc2Y6bCCMmFSxKY7Yun0=;
        b=Izt2g9OOyJWNHqSUdiZxtAd43t3InIpdZgbNbyuysyrw2M2i3tvMFDyFZwy1lgysAa
         JT1OBk2rS+5oSn+78NBnk++IUARZAZYkIb6b0csUxhcZijNACa57RxiX4Wva6racWbwO
         4YB2VKacx4K2GOoH/ld5EjvA3VOz1P6WBbOTCXp9l98hGqRbW7jzGcLWyFiI6O0XG7zM
         KqNzCKiyMeky3Y3LG9bELHBcKIGnGbKCFna4t384qYz14dVWsCB+JT/28LuOhDnDp6gq
         1/uJr4KqiQLKF5Y8cEJbXEqF1+/gj9uyt8DyCXEOi5QzSt7QXCO3yY24MIh/VfZoMGeL
         4Zmg==
X-Gm-Message-State: AOJu0YwlV/h1uEvVj/sneHUZRJUnFFPkFHY8Hip8oTrEPiuqNFKFKtCU
	1dHDaJtjoLZ4ocUjskPD4iQYoF/DSE/+V6lNUuK9gK5QWRcZuTbFpyWH
X-Gm-Gg: ASbGncuqDdRiQM9uofF8jwt9Lm7YvOg9CT8JYFhhH82sfaCqowFI7kqoH7FZeYvqijZ
	B1PAT0z4svgvUutWaCsyOtisQDdbiVi4q/0UM2VJ3SJRnptZm+c0L6M81srNFMGOdycs/4kH48P
	pVoMXhgD9EntQkpzo2YHnTKzcGPqwZ4wYPIOxHEZ6u2eXazFgPr8zAdDFHiRwwYWLwpqEWo3xxR
	Blkvu/Xv50acU2hjBSKZ/yQ8amhsBaMIWxLlYoifsZ8CT8Fm+BGUvvObgbtAjgN+8bQdGzYX0fj
	DszOi1ingYhU5mWMrgqoOiLgiwk+YAFtEn4V
X-Google-Smtp-Source: AGHT+IHKcKPw2N6zm0jQbN2aB6XCOqmTyC3OuLhjzMtCeUGv0BpWCw0Y4Qhg90QOh1Geq/NfVXvA/w==
X-Received: by 2002:a05:6830:2643:b0:72b:9d5e:9429 with SMTP id 46e09a7af769-72bbc23c769mr1476522a34.12.1741965148737;
        Fri, 14 Mar 2025 08:12:28 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:27 -0700 (PDT)
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
Subject: [PATCH v2 0/7] x86/entry: Break up common.c
Date: Fri, 14 Mar 2025 11:12:13 -0400
Message-ID: <20250314151220.862768-1-brgerst@gmail.com>
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

No functional changes.

Changes in v2:
- Move Xen inlines to enlighten_pv.c (Juergen Gross)
- Don't copy comments on the code's origins.  Git history has that
  information already (Sohil Mehta)
- Added cleanup patches (Sohil Mehta)

Brian Gerst (7):
  x86/xen: Move Xen upcall handler
  x86/syscall/32: Move 32-bit syscall dispatch code
  x86/syscall/64: Move 64-bit syscall dispatch code
  x86/syscall/x32: Move x32 syscall table
  x86/syscall: Move sys_ni_syscall()
  x86/syscall: Remove stray semicolons
  x86/syscall/32: Add comment to conditional

 arch/x86/entry/Makefile      |   8 +-
 arch/x86/entry/common.c      | 524 -----------------------------------
 arch/x86/entry/syscall_32.c  | 332 +++++++++++++++++++++-
 arch/x86/entry/syscall_64.c  | 111 +++++++-
 arch/x86/entry/syscall_x32.c |  25 --
 arch/x86/kernel/process.c    |   5 +
 arch/x86/xen/enlighten_pv.c  |  69 +++++
 7 files changed, 515 insertions(+), 559 deletions(-)
 delete mode 100644 arch/x86/entry/common.c
 delete mode 100644 arch/x86/entry/syscall_x32.c


base-commit: d08c0d55110b7cbac186e5fa94b0c6d5f4d7905e
-- 
2.48.1


