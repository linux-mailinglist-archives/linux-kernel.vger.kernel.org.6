Return-Path: <linux-kernel+bounces-411810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45E9CFFDB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E71A1F228E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE418E050;
	Sat, 16 Nov 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oVbntF+K"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DF1885BD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774515; cv=none; b=QweQmnP9ImhqLWVFr7rnCV5TKr6mrCiYltTs/uFcQI7RMIpuC0YvKjKIcbUEFaBgKcTZDiNO3wKYNzt5hAm1B0GZwzM7GkmcF6Coe+9U5PNIe6gtE+WBVpvSALb430gtO7SoFHHF56DJ/wWmyM7TAJQTswcs6TsLzsWVuuRYyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774515; c=relaxed/simple;
	bh=kOAI5lix9Ed17w5NCYaMHAZuqm5vJa1RMZ7TPcrnMmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1U2y/xIjNCIsLYSS8AoByrXsScxrW8me2brl27AmR/+ggdw3i3RmAGXBmRs3Qf20Bu9+lLq4KmSy36yCA31AwMPwB546QcJmEqB1fZCAtnoQP8+z260dft4WoVKsRSeUNeVySKgEyG4nOl+L3PH3dNuNTADwtO2+Tc/mSuWnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oVbntF+K; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731774510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YfwACum2e9ImWiqsDCrhshsPNGyjoxiAESW2iCRRMW4=;
	b=oVbntF+KoeCVNKrPqFHT3XZLLUtnR6mR8WoNGaa3Wg7ciapVbFvwnvzInmCx2rWwTpVP4y
	2Spsp9dC88vrdbG42KgYvBL69oXtXfYCsPWC1+dXD2BUYpRj/+/BkdUQrjlGOSvrmz9Vao
	UfCJLVGbMUO4B10tLtYprLCJu4xD+eA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: Replace zero-length array with flexible array member
Date: Sat, 16 Nov 2024 17:28:24 +0100
Message-ID: <20241116162825.33164-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated zero-length array with a modern flexible array
member in the struct sctp_idatahdr.

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..19eaaf3948ed 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -239,7 +239,7 @@ struct sctp_idatahdr {
 		__u32 ppid;
 		__be32 fsn;
 	};
-	__u8 payload[0];
+	__u8 payload[];
 };
 
 struct sctp_idata_chunk {
-- 
2.47.0


