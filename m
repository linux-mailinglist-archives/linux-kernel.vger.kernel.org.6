Return-Path: <linux-kernel+bounces-563146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A576A63787
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E3D188E927
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E619AD48;
	Sun, 16 Mar 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wpi3c3yQ"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91438635D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742160800; cv=none; b=Im/h2yFAsCI0z1AYyFa/rUL/flRac2/f305zfVe5g19FIWCpsTIdaGlaQ96vuu/yK/J5P8x72xjDIH4xVUuYj7//O6dpTqSWZYFrLEvgeJCYPaNznSBHjtFjwlSQbWONudhtUkW3Vgyt8pobGdGEgeHKnRMDjiv5GnBFdYiQ3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742160800; c=relaxed/simple;
	bh=MFAuR/TMKLuki0j+RTcGb4vpj3YXaCPLdHZ7u0T1/7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N2uYVVVh9us0jhHMQstv+8yY+H7B40JFcRqAYr5PjL+T38SyEpGUW6+Qd0GAXhIooAfsk1P48pi33psrLxVU19IxxvZWFN0+Vx2Jn8zZnZgDM/Ke/oNfVobG57Z7kR2qcKWUeCJtz8ON8U/t4BMOcPOyQ21tVHdQuufv7peCpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wpi3c3yQ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 09C2D14C2D3;
	Sun, 16 Mar 2025 22:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742160796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IpXDqwy2ufhYr/pNc5TbxqALlCwwcmGAFBkdoSNVjgk=;
	b=wpi3c3yQJV6tarLzgigZeKSi8GdhA12B8yh1CUGK4OIR94BHx3iHWOkzuo/cf1HgNNMrnd
	2smGlYZqcy6hL9XulMhA736wyLtof9zbARqN0aRxXeaR5O1FTLPSxZQPlfbqOlk9IYoTsZ
	R4EB6m4swdM/60yZRUbREgndrS1USZOBRBLyL/KCP369Tswv6E94ZIrDAModD9c0jr6EKk
	DWCDzLUJVGdllQJBYAUM4zgMB65J6qWA2h5BiEz0vtUJeEx2/WwmKh1N3UCDsNJlKRnh9u
	qrXO0bvRlMPLCSK5rr2hr9LCymJ0zJ2MUdz1pzDcckAHl5Hr2kM2375uScSR+w==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id a0fcc002;
	Sun, 16 Mar 2025 21:33:12 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Mon, 17 Mar 2025 06:32:56 +0900
Subject: [PATCH v2] 9p/net: fix improper handling of bogus negative
 read/write replies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAIdD12cC/3XMQQrCMBCF4auUWRtJphapK+8hpcRk2g5CUibaK
 iV3N3bv8n/wvg0SCVOCS7WB0MKJYyiBhwrcZMNIin1pQI0ng4iqnftXSDwG8r2sStdD23jbYGM
 1lNMsNPB7B29d6YnTM8pn9xfzW/9Si1FG1WTbs/GotbtfXfS0CrnHMcoIXc75C2MI2P2wAAAA
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Robert Morris <rtm@mit.edu>, Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=MFAuR/TMKLuki0j+RTcGb4vpj3YXaCPLdHZ7u0T1/7s=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBn10OU5/0zSnMKgY1Mc7tBKoMbUPmXfd3jPxuxv
 Y+7Ac5tWt+JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZ9dDlAAKCRCrTpvsapjm
 cPB8D/9yzuBx3WrZ5BfnLyj/zf8bASP5vIa54gFalVSWUaP6lWPOdFMuJdu5AQXwNNGMYH3vwTf
 BZ7Q1HgShw1z2uAeFH6Q8oDxkELsQowW/lrF9VfYyWiMXI9y8tvs6vGaiH8rzeU19tiDf4QwWOB
 ZRbDTvK7qXiNdZWWyjWrEEk3riQTlqS/XWAgK2KvtAlvDnZreD/JxM1fmIOiB+IrBvYh0kWqK0B
 CKPX0duMamyML1SYhVYMq7WlHsuFDDDTrHeVEl42gkg9Gp1XILzDsXO4bUBgD+/J8dvypKhDnih
 4cKQ9rqrELukyXiYfswNZq1MwnoZ8GPrRsQdC3La62W7CzZDTpNdrWWuBw8YGH49XFunhDb5U68
 NVBpXuuhDFU/M372FfORQZurRjCMhpFoePx1aG1TAmZi3PCwy1K1Oei6jjUau/GAzNrUldsW3M3
 Q0p+GvjziEuGBKSmWy5cb4cyOCVTFHl1yKoDJtPosI9N+v5fiYAccb6KkVmoXwl+tAtC0yOtYq0
 /Ial30xZDWHMqZiFVl82bKXB3zmMcfSWRG2a5zYAweDDAfyVpcrimW3r5lFlg0L1uQgNa8SBqF/
 W9nKNxZZSMmVIdZIBc8627TjuFmDGo5wlqJGHDY35WcrLCuP0qAJ693pJsed9Yo43Oiid3Y0Y10
 pRehRpAsrCz0Sfg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

In p9_client_write() and p9_client_read_once(), if the server
incorrectly replies with success but a negative write/read count then we
would consider written (negative) <= rsize (positive) because both
variables were signed.

Make variables unsigned to avoid this problem.

The reproducer linked below now fails with the following error instead
of a null pointer deref:
9pnet: bogus RWRITE count (4294967295 > 3)

Reported-by: Robert Morris <rtm@mit.edu>
Closes: https://lore.kernel.org/16271.1734448631@26-5-164.dynamic.csail.mit.edu
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Changes in v2:
- fixed rsize to be u32 instead of size_t
- Link to v1: https://lore.kernel.org/r/20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org
---
 net/9p/client.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 09f8ced9f8bb..5e10fc174c3b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1548,7 +1548,8 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
 	int count = iov_iter_count(to);
-	int rsize, received, non_zc = 0;
+	u32 rsize, received;
+	bool non_zc = false;
 	char *dataptr;
 
 	*err = 0;
@@ -1571,7 +1572,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 				       0, 11, "dqd", fid->fid,
 				       offset, rsize);
 	} else {
-		non_zc = 1;
+		non_zc = true;
 		req = p9_client_rpc(clnt, P9_TREAD, "dqd", fid->fid, offset,
 				    rsize);
 	}
@@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		return 0;
 	}
 	if (rsize < received) {
-		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %u\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	*err = 0;
 
 	while (iov_iter_count(from)) {
-		int count = iov_iter_count(from);
-		int rsize = fid->iounit;
-		int written;
+		size_t count = iov_iter_count(from);
+		u32 rsize = fid->iounit;
+		u32 written;
 
 		if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
@@ -1633,7 +1634,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
-		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu (/%zu)\n",
 			 fid->fid, offset, rsize, count);
 
 		/* Don't bother zerocopy for small IO (< 1024) */
@@ -1659,11 +1660,11 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			break;
 		}
 		if (rsize < written) {
-			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+			pr_err("bogus RWRITE count (%u > %zu)\n", written, rsize);
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %u\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
@@ -2098,7 +2099,8 @@ EXPORT_SYMBOL_GPL(p9_client_xattrcreate);
 
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 {
-	int err, rsize, non_zc = 0;
+	int err, non_zc = 0;
+	u32 rsize;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
 	char *dataptr;
@@ -2142,11 +2144,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 		goto free_and_error;
 	}
 	if (rsize < count) {
-		pr_err("bogus RREADDIR count (%d > %d)\n", count, rsize);
+		pr_err("bogus RREADDIR count (%u > %u)\n", count, rsize);
 		count = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREADDIR count %u\n", count);
 
 	if (non_zc)
 		memmove(data, dataptr, count);

---
base-commit: 28e6f0643ff4431aac807e902ff0c8de16b2216d
change-id: 20241222-9p_unsigned_rw-03f95da525a0

Best regards,
-- 
Dominique Martinet | Asmadeus


