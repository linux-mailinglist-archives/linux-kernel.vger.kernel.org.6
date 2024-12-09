Return-Path: <linux-kernel+bounces-438030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A79E9BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE9188763E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7414A0AA;
	Mon,  9 Dec 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lg/aGiJ8"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B7142E6F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762596; cv=none; b=Jn8IDppr86IacqBJlL6s8MrdwYh1O9Yi0IoNuEjx+5qzKAOBCbWX8an7y+ijZHCb8bNluz6KXq5lZjyF+vDaOR/aLO8N7bUBtqWRRjLAlclE9AmhIG70PzKBDppI2/bxAVK9YDklUIDzrAzTxuGRv8/2o/dGaqcJUVDSnbOJn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762596; c=relaxed/simple;
	bh=nBYB5Xg+BKjQqhoyzRiKH6a173lAGOtUAU2g7YLzwr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9O9qE7cmMQ0k9ezq5k0GfLR9ZkguFoBSROGApghTT+GO9LxL7uFWF0IbiG/SomRgCWDtkAEDlwUl0H3wzUgpjlqI3iVyiCGggOZoCUUCHSVYe0lwUlvCW2z9ggUYaXcoLDu7ThUakeH+YL7vvoAoEFlE5MnPfxKUO7kl0djzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lg/aGiJ8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733762592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0TCN20N6Jt0mRB8VQbmu+9cK5ofHCns5KRUsuZgT+A=;
	b=lg/aGiJ8Pg7m67V+hZdRMfgGfVv8lRJEG2K74gr/viHBR1cKDSQM9QeJ1oMsNX7OgIFEUJ
	kipy30LFIB1fieo4M5sItewGZL3CJWEIArht/dC8LsZ/pkphpMYW9aL/5KwFSI5EBl++yA
	tuwsC2u0T2Mg3EsiDXqlok4vq6x6dwI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] alpha: Replace one-element array with flexible array member
Date: Mon,  9 Dec 2024 17:42:52 +0100
Message-ID: <20241209164254.43724-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct crb_struct.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/include/asm/hwrpb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/hwrpb.h b/arch/alpha/include/asm/hwrpb.h
index fc76f36265ad..db831cf8de10 100644
--- a/arch/alpha/include/asm/hwrpb.h
+++ b/arch/alpha/include/asm/hwrpb.h
@@ -135,7 +135,7 @@ struct crb_struct {
 	/* virtual->physical map */
 	unsigned long map_entries;
 	unsigned long map_pages;
-	struct vf_map_struct map[1];
+	struct vf_map_struct map[];
 };
 
 struct memclust_struct {
-- 
2.47.1


