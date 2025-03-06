Return-Path: <linux-kernel+bounces-549202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F661A54EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317C41898B48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D988212B0D;
	Thu,  6 Mar 2025 15:26:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC393211712
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274777; cv=none; b=nkS1UaX6Sk7P9LDxWm12Ctzr46IuHSl0PrWZDK6jHjSC6KcJhgT7AJ/MioNPwEbJ62fASLXFQo2qCZF/q8KQo3nKLbrvGBNMAO6JlcAVUvCin+yplfxLDOCRC1ae50gCI4MT+qec76LyXvKOWrEtXAK9+18nAil+axozVOJZFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274777; c=relaxed/simple;
	bh=pwFEfRdozJm4g7+EyIWH83XcpgWwdPgvIhLl+JzbiAw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZkO/ax8S2M50qlmsw8j6flXwONhlQO4cx6E9wYdq5XAnXmEK1BzviuRR8JZoAKLIuHtRAgQGdVbfzw+0B8YJVWqfgoO66rU27OY94+W3kA0vk4GXFHRmz1KlxJEUIAyMSDtiwWXrfE8EQPEK+1XNNW0KF7WdRTTI9LeDTwQuFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA39C4CEE4;
	Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqD74-00000000MbL-2HhC;
	Thu, 06 Mar 2025 10:26:18 -0500
Message-ID: <20250306152618.395640284@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 10:25:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Feng Yang <yangfeng@kylinos.cn>
Subject: [for-next][PATCH 02/10] ring-buffer: Fix bytes_dropped calculation issue
References: <20250306152548.763044302@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Feng Yang <yangfeng@kylinos.cn>

The calculation of bytes-dropped and bytes_dropped_nested is reversed.
Although it does not affect the final calculation of total_dropped,
it should still be modified.

Link: https://lore.kernel.org/20250223070106.6781-1-yangfeng59949@163.com
Fixes: 6c43e554a2a5 ("ring-buffer: Add ring buffer startup selftest")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 87caf9d48edb..7b6bd1f3daf4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7446,9 +7446,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 		/* Ignore dropped events before test starts. */
 		if (started) {
 			if (nested)
-				data->bytes_dropped += len;
-			else
 				data->bytes_dropped_nested += len;
+			else
+				data->bytes_dropped += len;
 		}
 		return len;
 	}
-- 
2.47.2



