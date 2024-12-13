Return-Path: <linux-kernel+bounces-444862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B029F0DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B7C28425A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF21E0DCF;
	Fri, 13 Dec 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgalqpOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD731E0DB3;
	Fri, 13 Dec 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097663; cv=none; b=Dq8QndV4MxLzQ9Xg1VzpNMImZTbifCstkveTXRFTMPpFESZxemraIuRzxV7EU7ZGZpO8VpEZTk9Tj43bHrxMmwdV0YrEH1bbFsUxlGdfrjrlbEwjLn95Ti/3/Iyg4mkOvJgCq+06yyty9tjMR7dL4LmUoWqr/5BLWtLGOGk6s4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097663; c=relaxed/simple;
	bh=lKocUKpsjHqNc6JQsO+YrfIuMd0JA6GMV0cGR4aKsRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPM4NaYSilKHAhgH3DI90q2qQCqEpfQn2n3PdKvlm2l+D6KbUaH0MVq2A7Sx8RS0ayslO+qPMqizhzqiSgcWx5VlpQ6Sd497O6K67voMFgiyRLXhjnvDZcnYUMbV6gf+NVvOTCVmdfjtbM7xj3m5q1BQIw7t0RASn6ZOP0BygA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgalqpOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03630C4CEDD;
	Fri, 13 Dec 2024 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097662;
	bh=lKocUKpsjHqNc6JQsO+YrfIuMd0JA6GMV0cGR4aKsRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgalqpOTqHFi+Rt8yzztUOjfblqEJeTIsaRF5FcImV7KvPmuu6VOFqZQbJqsS+C/6
	 Cwpk+E26A0SL63/z6/GjWUmA5c0lHjmxWxdNNEXlQf+kHf2cCybGps3ZdBgNRuhSxM
	 9hBHTIf3R51XVFnHD/vgy+PgChzwk1rRSisTZn6g/ESuA67yyFdx3xO+HnNl6IaGhl
	 Bf/raSkGlK5wsfg5yPWjWgh2vEXfcDxSzMzGbF4PFEMxUQlkTd3EXsdbOHD9oSFRjW
	 fuC2DmKmG1l/CFs7y3XrCILgufCJzN5z9HQh2aAJvdUat7uepMZ5GJHlTsnAey2WKf
	 3e+6kTo2I/I/w==
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
Subject: [PATCH v6 1/5] Documentation: ioctl-number: Carve out some identifiers for use by sample drivers
Date: Fri, 13 Dec 2024 13:47:06 +0000
Message-ID: <20241213134715.601415-2-lee@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213134715.601415-1-lee@kernel.org>
References: <20241213134715.601415-1-lee@kernel.org>
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
2.47.1.613.gc27f4b7a9f-goog


