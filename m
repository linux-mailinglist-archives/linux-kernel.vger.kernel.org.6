Return-Path: <linux-kernel+bounces-435017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7830F9E6E80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B024416A27E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E512036E8;
	Fri,  6 Dec 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+n0/+uG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3F202F7C;
	Fri,  6 Dec 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488967; cv=none; b=EKJT2ySlKxVL61x2395We5Z2ZAI4E/0cBABx9BUg91E8p9OX+QVnHCSac/q/l/hc2ycQO/3QJ9fuKtBY9sO6x+HVxJPuF0IY632XTw3FYgDKHiFGgz7+Oc/5G+PQNNeLJSV1g78GnCF5WZX40PkjhhNhC8W02prsaJlzPzhdk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488967; c=relaxed/simple;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/WjRk2+uX36FnkstmggbHN2J9VeX5n2/aSpsYqcqNjKqN8ZRs+nNv1NhkGU2LtY51ssrn6LjTYJhEFxnnaaETfne6dmFBmMkpiIHUF0hiazl3QMsOI34VXHdDblP1Xv45kxxymIhxoPqtuc+YVKyGcxkfJG+TPYo1+0oY2909A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+n0/+uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44378C4AF09;
	Fri,  6 Dec 2024 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488967;
	bh=22NZyA5YVkMQ03pXUXXdocb9WXBGnORT9AlGZhxewK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+n0/+uGtvOKALSQgobwyvPSupUwFdAFldRrey79jA3zmTfz0f9LY/wT8nSWnjvGX
	 qRF6ADfoum7VFiQzv++Qi7innBfZ3v62/d9WSRIJja27Erlw6P6qXS2FbkVmw8KVXt
	 cl/nzbvY0jTB8LJAgqigY/Ff6ONACILEpzqBT3KiXR3jijnBU/Cx8x/n5ffgteVpeS
	 K3an0NaISg3uVTKrpqwH7N6+wzKGv+zkHpQp/WXCoyn7r9IaFtup2tqxpaY+s4aTls
	 mReDJ3BEFjINCjE0avmP2tD4QdjWsQL1UbeOToswptAM3B3SIjH6upL3AcwOMvnLyR
	 Gd+v1/jaxS/ng==
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
Subject: [PATCH v5 1/4] Documentation: ioctl-number: Carve out some identifiers for use by sample drivers
Date: Fri,  6 Dec 2024 12:42:12 +0000
Message-ID: <20241206124218.165880-2-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206124218.165880-1-lee@kernel.org>
References: <20241206124218.165880-1-lee@kernel.org>
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


