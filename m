Return-Path: <linux-kernel+bounces-434670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA69E69A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20381164FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4E1EE014;
	Fri,  6 Dec 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxIAu4kP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9C1DE8B7;
	Fri,  6 Dec 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475935; cv=none; b=T9Nlp5TB+SJTL1TxYiesErK+2AmPfFUd80LKjQKcRmWt39sSYzbCv6snSslR8R3GitcdnyyxLPMydOE0VllMvSu828xbM8NyeQ13aYlUZzNY+pOUkIovzJKLVuJpINq3uw9mmzbQN2GF202NsAGYjy1w3M7100+eUfA7qDCTvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475935; c=relaxed/simple;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZWGRcOZ/6HkED7IWDQpmeNtuseOKo1D7PuCrkCS8HAZ7LOejQ5+Qn6zb8lEOyKscy9EIs+TORJu+Lo1/+tm8J/JsgC0vapTU3Zs93KbdhqSyZ+1DovNRjmqpWZy3h5Ktuo8tD4NIlptzl5CyTRQFv2YJv8IZ27fUnLMCaFVKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxIAu4kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE6EC4CEDD;
	Fri,  6 Dec 2024 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475934;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxIAu4kPguSdYqB8VqbnjCCcCYv9b1Ig2tCGogUUuV+gj2S8b3IAUaAzFRbrSe+me
	 52TEHYUGp6wvTK3lQA9VXuwuUcy7BoDqCNpXm6G+nohza7x8eDqDVKKck4DFBgz3be
	 0IO3dDALWxg3dZMYXYx/cj5rZvdFmEVxRGs9IrpHs9U3MGSbOeATovXZItMAsacE3I
	 gFL3A4VASnCW7dOrPWVGkU7pnCe5L1hLIT7260rVA89RLMDrgGLRjsA4NBXn2wc3Jq
	 aHbk8uWO3nDd5oX9ZqbqCvAqDd+a/vsZM5ssyi0+iBj6U45069B5t+/jcaS3sJLY2w
	 fYn8YtaGKRheA==
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
Subject: [PATCH v4 1/4] Documentation: ioctl-number: Carve out some identifiers for use by sample drivers
Date: Fri,  6 Dec 2024 09:05:03 +0000
Message-ID: <20241206090515.752267-2-lee@kernel.org>
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


