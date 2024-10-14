Return-Path: <linux-kernel+bounces-363145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1B99BE63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC9A28308C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0A1369BB;
	Mon, 14 Oct 2024 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqXSRwxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0ED130E4A;
	Mon, 14 Oct 2024 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878255; cv=none; b=VQ/X+oRt15ANNVaJ/rImkFu1uxFGRanBiLqxqrbxYztQZ4ai0hSS1ze/zAiDbKRv9GKMKefD0Wry5vf/1SoGgxcai26auWXJZ85NSiXL4NYKz1sOUMrBTYShnrqe23oGxZhbTVmlQt0gQZTnQbcML/qOti6DwkFBdpK6sJSzImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878255; c=relaxed/simple;
	bh=kjv1k59V4Iv3EuGSi6TCLdCI2lLkb6B+qdpAvoR8bi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNTzRvCsDdr6KkBNIimNgf8j9zST6eOZ8FgwD7R6B5kw3xajf5TkgECubgg5SSYpPrbOGXpYWRgKKM7GKOje4fPCB1qv4i5ah74qsXbQHSSRTh7nGQBpthHiBUlezLZlIogTRgyvM5JbAWCppno1rl9SerHOluRf6Q9UbOkPVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqXSRwxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6E2C4CEC3;
	Mon, 14 Oct 2024 03:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878255;
	bh=kjv1k59V4Iv3EuGSi6TCLdCI2lLkb6B+qdpAvoR8bi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqXSRwxttk3eXJjYceI8RXz4+ZsbopJj20kMjKXkBnBJLb8Mun0jpuz2rjaVQ4vXK
	 TQixDMP2zhUhBjxnBLjRmnvgLPy1wR5ciX6PcQLXgwIRqT5ZlEmbctOvpF6klYAQyZ
	 aMsfi1tn2GfAtrY5IWzYmkOc+XklD32pGHvT+WZh4suwBr9dmI+uYKNt8n7zxSNYdt
	 a1AFhSKh7Ww1MXR8FAtq7rxKkPe7GiYSI3sfSt4evkaKT0g/ktFZ1hCYoRbH1hAsCU
	 6xwT44UkTP1I0k4bMHP3viBVi5Q3Stv+KoUZv23VucHhCh1HyOyhpagP3dvPYZHu15
	 UiWyxvvRSi67w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 02/20] fs/ntfs3: Check if more than chunk-size bytes are written
Date: Sun, 13 Oct 2024 23:57:04 -0400
Message-ID: <20241014035731.2246632-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Andrew Ballance <andrewjballance@gmail.com>

[ Upstream commit 9931122d04c6d431b2c11b5bb7b10f28584067f0 ]

A incorrectly formatted chunk may decompress into
more than LZNT_CHUNK_SIZE bytes and a index out of bounds
will occur in s_max_off.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/lznt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 4aae598d6d884..fdc9b2ebf3410 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
-- 
2.43.0


