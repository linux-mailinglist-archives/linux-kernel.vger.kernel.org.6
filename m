Return-Path: <linux-kernel+bounces-177039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328788C390B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8560F28180E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32753804;
	Sun, 12 May 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGncIo5Z"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB87F4FB
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715553087; cv=none; b=gaaIkyG/LGaz22KPk5jx6BxL2Ed+p1yGys19iJaO27t02gy3iOM4anoF4cGG8gOQpPESS7z2bTZQ74YTePCXcWUBlArOIBJDW+SRp/mA84PMQAoPBzSGrjf2YYRiOp/ICNozese4uiZb8/wsyCS9usKlweNX4n4ICa703PCdjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715553087; c=relaxed/simple;
	bh=/yY9ImVmCSEAiflO+WOW8ZKIoyOzJImonjk30GwiGXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oEjJMsPPcydh+G0LGrhnZWjuncs4PFRb32svXE7vhT3k2p+tunHnc+LfJQPPPEqwyIPZaFuBBhu4wpYd7JGcsshtR5TN8Nq5TOy4JZq771twU4+Ju6hEXcH9Tl4dH8xqb8K5gs5nMOGt79Bo6nIGEOZAdnpwRd3WAi/J2TipzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGncIo5Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so22283235e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715553084; x=1716157884; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hTlsDYwyT4XdXEVF75W0VIL+9giBKvf6T5/6Mrk28I=;
        b=YGncIo5ZBcUAGj3NmHiZj2vgasuYLtoWZpM2aDDD6Gl/PblSWKw8uvfs0f8kz2HsQh
         li88RnjMy6EMSiI3gN0pyw3rKJ+e9KEe4/PI+WRtjfroSILYgEaw66Pu2Z8KIX7bRqEX
         Yff91DwgUaY7byPLZjG+JNKDJDUTvtxeslnNnxx0AHYXnE9j03luXW2MA1xgSri4pjDA
         evv8kCiTP4J4JHD0NBSt6zUJ0unTD4IXVwcP7tXlZlKLblHJLuEbW0oYCymxbteKcUr4
         tRxHcarWyMSEnqhCP+n0NgrzjOuc8CIH7HXM7Qbz2eCkvTpagw6u5LBxoOz9N+5vggV6
         /psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715553084; x=1716157884;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hTlsDYwyT4XdXEVF75W0VIL+9giBKvf6T5/6Mrk28I=;
        b=Yh74BbUoxUntge3AvKKNus9WXYb2O/R6N5SIKcGxoVBTpA8JjYOnMgSe3uQVpmDj+i
         zfWCKl5biWHW1ySMJ3Lgz9kE8pEmFmN1R1p/eaJvacj+TSPJFnss57qq3kSH2ivz+eCd
         bNO4TcMYh5Ijch0pp0LXK0xtWbgg1ggl8PBLx9Tiduv2YQeipudUg81pHlKfjoG3CUKT
         mAndsR0wsnCClfiGBmJoe0SUUTwPcPFEynK/9p1Fe1pPShYW5XsafyF/w9j1xZYwXczx
         ag0LzS2gk7f4AqH2GztGT1xtak5yd3jG2qYBOPw0zvXytFZrVBQ1Y2fpQmnFQk6rVAo0
         zRwQ==
X-Gm-Message-State: AOJu0YwiBThfLPuFHBFotayme4aOIrfKFcN1M8+wcnMBlWPbxrpuPLNf
	SKbWaBlw2Z4fy56ZcsEeca8Lor+22Q1J9bYuH6Dgqu3KFzNqUrleaiVQsNs=
X-Google-Smtp-Source: AGHT+IGgS/6FhaOvnyvT+DC47ooQ7FZDwcrLSC65HFUbL2HSifClmthiX+4uqaocitUDX86wm5ZBzg==
X-Received: by 2002:a05:600c:35c2:b0:418:f184:53f8 with SMTP id 5b1f17b1804b1-41fead69733mr65951775e9.36.1715553084084;
        Sun, 12 May 2024 15:31:24 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f9bsm138671705e9.6.2024.05.12.15.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 15:31:23 -0700 (PDT)
Date: Sun, 12 May 2024 23:31:21 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: Use resource_size function on resource object
Message-ID: <ZkFDOcgVxnnzX_bu@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Cocinnele reports a warning

WARNING: Suspicious code. resource_size is maybe missing with root

The root cause is the function resource_size is not used when needed

Use resource_size() on variable "root" of type resource

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/pcmcia/yenta_socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 1365eaa20ff4..ff169124929c 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -638,11 +638,11 @@ static int yenta_search_one_res(struct resource *root, struct resource *res,
 		start = PCIBIOS_MIN_CARDBUS_IO;
 		end = ~0U;
 	} else {
-		unsigned long avail = root->end - root->start;
+		unsigned long avail = resource_size(root);
 		int i;
 		size = BRIDGE_MEM_MAX;
-		if (size > avail/8) {
-			size = (avail+1)/8;
+		if (size > (avail - 1) / 8) {
+			size = avail / 8;
 			/* round size down to next power of 2 */
 			i = 0;
 			while ((size /= 2) != 0)
-- 
2.43.2


