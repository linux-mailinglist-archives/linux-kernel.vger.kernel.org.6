Return-Path: <linux-kernel+bounces-434673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A129E69AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20C7286714
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041C1F6665;
	Fri,  6 Dec 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT3H8cV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CB1F5403;
	Fri,  6 Dec 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475940; cv=none; b=g6+/rE0lhEE2PfiDOxManDQ8l+XPQ/1aLsdM/o9SUDvEp7MaZ37eB+dC7D32mpvO/CNTFxbvY950Y+H/RSWWUd1irCUJPcjLjZ3j4GG+yj5piENjuzePYcWGe7Ti3XpitOS8z279U4R/wb00hiXbUsu+/upqGsvdTd4uCsEaA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475940; c=relaxed/simple;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htz6+3f+Igyc4JkRMO+KrqyEbmjacMPMhRm0c1ROLD9ZuIGPhqRvFcvJnRCsB1xCPltPc5rO70oGGUzjCIFM73Zl9zwNkz9vF8V5wl4b/4AjhN3FNmOXmXZCayM2shj5SXX/jOdFzOrq+AqHPHGr8vDhb0oWfRiFFqcH/vNlhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT3H8cV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40DDC4CEDF;
	Fri,  6 Dec 2024 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475940;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DT3H8cV3Moh7Exfxq4M978tHqv6qDn/2afPk84yQLdD7ypRQDppTKPcj7rOABjvjI
	 mXYQAPUNe5lJWLZV8bsoZ1GlgJAD6cbDdVKHW46fwRlXqbgEjfEBwN0oxGYmlpIlOm
	 UQMVCK/Of9JIMa2CNuoEqQxqGSbMeLGcUxLcJwOSQN3s07TSdMvr5LmENOpcFNTCcC
	 W9peqv9HfqnHOTOLbRJXyTRIp2eZyDGqkCJxC5p7hj/GA4ZKlAcCmk4oQ88lAGweGq
	 cipHGYhTPzg/SMhPCG+iKXukLYiowptznwKvsrpnSfi+6VG8u/NrOTlGWsOl2138Ub
	 TC0AfyJA5oW6g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 2/5] Documentation: ioctl-number: Carve out some identifiers for use by sample drivers
Date: Fri,  6 Dec 2024 09:05:05 +0000
Message-ID: <20241206090515.752267-4-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206090515.752267-1-lee@kernel.org>
References: <20241206090515.752267-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

32 IDs should be plenty (at yet, not too greedy) since a lot of sample
drivers will use their own subsystem allocations.

Sample drivers predominately reside in <KERNEL_ROOT>/samples, but there
should be no issue with in-place example drivers using them.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 243f1f1b554a..dc4bc0cab69f 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -311,6 +311,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:oe@port.de>
 'z'   10-4F  drivers/s390/crypto/zcrypt_api.h                        conflict!
 '|'   00-7F  linux/media.h
+'|'   80-9F  samples/                                                Any sample and example drivers
 0x80  00-1F  linux/fb.h
 0x81  00-1F  linux/vduse.h
 0x89  00-06  arch/x86/include/asm/sockios.h
-- 
2.47.0.338.g60cca15819-goog


