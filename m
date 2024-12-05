Return-Path: <linux-kernel+bounces-433660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7679E5B57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6621A1886993
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A63225776;
	Thu,  5 Dec 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXNVWB7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351A21D585;
	Thu,  5 Dec 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415947; cv=none; b=IHzOvAxaS5luTz38zuI7v1VV3ZTRmBQ7xR0A4DKIeDRdiatPjvKf86zTJJSBUC1DupLFc8Ah5y+HyzsHd+OloY3DxApdx4YjuM4rWryikeivwpxRkcMJMyMJ4fAchqH6dfLJ3R53slzyUUzvdoUYM14k+zzoorHaQpJcn3ev6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415947; c=relaxed/simple;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBsI8FLOw9hXdP8hnmsZr/7A/hRd9cZ7KmHeAmh4UxZVoCN6F2w5fs1fwtbKdCRNuIcZFpUaCLIaEvmhmOOYgAt8kWF2oGtfsqEjJUarFw5nCZ9X/YQi4zoycCt0uBkyjT+jKZPu0zqlcpi+M7qEWPgeuO9Bwo4klVJaSI8oysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXNVWB7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1323C4CEDC;
	Thu,  5 Dec 2024 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415946;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXNVWB7FljjxzxJGFWRyaESF3qeUWGZnSlD1aMqToGX03KiumzJH7WMrWLdgQunLe
	 tbi5Sh4NLX92sFohPchh5JVrZONYjAqy7bpQrv3bXoOzy0YB+YWs14Ig8FsrT6/V3y
	 UVoyXJF4HjSsnyxJ+8OtNBG7/VGgWPx3B0ZYhXGgrJJLKjAHlpsI2Wx4UrK4lHqLud
	 /NsywIFdqr06OXGh30W4FdQ3BdFsxZnfyNFt6W0Nd7tGHj84ppKCKpkux82sahfUzi
	 IH87V9tI9mA5JCCQRg51UmfodgckWheHN0mpX0s2MjvAN+y9GJhdnFw2Flt9J7CCOF
	 TzIs1NglPD5YQ==
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
Date: Thu,  5 Dec 2024 16:25:19 +0000
Message-ID: <20241205162531.1883859-3-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205162531.1883859-1-lee@kernel.org>
References: <20241205162531.1883859-1-lee@kernel.org>
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


