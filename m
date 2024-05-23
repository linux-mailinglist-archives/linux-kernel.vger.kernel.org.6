Return-Path: <linux-kernel+bounces-187631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D98CD593
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8EA284134
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B414A634;
	Thu, 23 May 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lmb/2VhK"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DE1DFF0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474081; cv=none; b=TPVUDtmT5Ayexkmluy0SaRBJRellmLpmTHwDmO5s6pHqiZoOf9UUDHn/7D3xizWsuDeFtZNpFOvnL5NwmZToGJODce0TpkVOwO/z5gKDiAZVc/YXNuOQxFGeY3WGqzHycbU+gGyRe7pIMn+t9Zex7TCpAZ9u0MxUFc/lxXbWnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474081; c=relaxed/simple;
	bh=4qCvEiqdJkRLC7gxPX8duRxnncXR16Z/mdnMWYsPF20=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ldAyceuN1vRVvkrpnsMacM0s2I0uBUi/D3qyyTENAm0jGhDyYHtUEQWr+gWY58d5cjqyRhIKmX7GXdgiHOkzbezWVSXmoe6HBGgpyQNyimFZcFzQTpPrdPbX9WQqt/o71zagB6TSPBBpTwDt7XfyBfaBx75+DXnfF9ASetJ7gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Lmb/2VhK; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716474070; bh=FplW16AZk2WF+I4r+9I943Mw1CLOL+ZAA7jbZ8gsepM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lmb/2VhKOfDBMPWAqRjs9AH1rIiuvfq3V3f8Zs2lV5hUcJaJlJpsFItnhfT9X+gJP
	 PRdxQnIeTjTL++Ly0lMSLaSWG+Ikyv6YdRjOPSsSebrQ6rgvIni2IecWb4HZIetKQM
	 SbKO1BTmvHxoDO/IKqomi2ua0KKdXhaNPnuD/5Qc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 33BB6A37; Thu, 23 May 2024 22:12:59 +0800
X-QQ-mid: xmsmtpt1716473579thd68e5lf
Message-ID: <tencent_CAE2ED8ECCF07BB66D902CB16CA894F8EA0A@qq.com>
X-QQ-XMAILINFO: NonMLXQbqcUbSg032T6j9wNsj8KOVM3cvwClygZnLpwzjLVvIuHMwdPElPqT8K
	 XCFu+tALeI4rAEDiT35RsnUikAT25Wn8pbLC8N0CjcVmpTRVDHDk1HLFEdZlkAf0KZeIQ5uDqD85
	 qaN2Aq8UO4LEajS2+p10MRdSOFxSOU8XTiKfgCxpM4oVp+tVBeb93XpWcp5v3obfNGyClnqzUOrV
	 216Ok10yZfE3clnEK38SXnOnomcsVPeFl5K31pHf82IvckR1gPW8F4KX7g56dB5k0HR7xeADYP7M
	 iTVR0fsNfQm98hLNkS6bMZ6BNdB+nZPcEut9Hv0/VLq4fMj+VqubOXHRSDtjOO84yDcVDEqDUdGX
	 1Nwzri9qpWbRfr+hKARAo9r5UT1DL22YIqy1O4X/lwYvgE6tYuN6J0Opp+q5dvacoL5u8S9vpEE0
	 kATAapp9XfnKc72BeHquYjrPItW//r51gXfTeqLg6XAa0ZdXiUaDqRNCcKqKy8mF+7kLLDf5dqMr
	 ET7pN5hao3l1C2p+fD3zTtNxCjlJnl5zJFDsah/YkHTNhzw0S6airuO9CQwMXCUR55oNt5zmECB1
	 6hGDNQ+xDL9R19F5pGdlzQJIAXavRcrBI3yzV0k4oEedUTxiLJaNVQ7UB/aEpjApwRDA+OHc1UDK
	 rP292nvKSNu62bU5yder31VH+HposSV98o4SnpQrlPM2ExF/wlibkOCGz36UiLF6GHtcQtrnrF6v
	 Lg8b8h0TWeJIb4fniW+Fl/uM/iDv6WHYydZpLe5x9ODCHt1XhAwAdpqr/yGlEGQh9xDO3LiQpedv
	 ECnDSiB1KaP9/jATwXG7K9H/zLT/84RA9OpxurF8G/5e5RcLeHFDIeVPzlPa38bKKzsDDSXq+tOQ
	 LdbQI/Z7htSYj20/ZeweK52ueMtDvUn+D9Pzqz/ZK5KocO56TLl6+QRo5mnGyFZA6H8N39sit91K
	 eUSSboF2IKGjSAOQ1VR+DFvn3gRyphrjIGHXmNLrE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Thu, 23 May 2024 22:13:00 +0800
X-OQ-MSGID: <20240523141259.2708676-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr in iter_file_splice_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..2881e9a7e491 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,10 +751,19 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
+				printk("ret: %ld, nbufs: %d, buf:%p, buf len: %u, m: %u, t: %u,ring size: %u, t&m: %u, n:%d, %s\n", 
+					ret, nbufs, buf, buf->len, mask, tail, pipe->ring_size, tail & mask, n, __func__);
 				ret -= buf->len;
+				printk("ret: %ld, %s\n", ret, __func__);
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
 				tail++;


