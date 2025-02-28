Return-Path: <linux-kernel+bounces-538015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9DA49395
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0FF7A2E31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C72505DE;
	Fri, 28 Feb 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auxYLErK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2E8F6B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731584; cv=none; b=kykgUiqBkk2Hk1Irxs7/itI/I0sqwdkJeB/S99AsbHYDxNynooiaplPIrEDoI0ZCUcdfwO5y3gSH9e/+YrgWBWeDaPsQ/TXVRIil7VzLO6XF6mHJnuvRhk+3ijAm8btGoZSdatpeT+LRZD9F6zOth+P8YCAvVUK4fbMj19j0eWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731584; c=relaxed/simple;
	bh=cSHRxodgbIZbSDtPjj7EDL43DTQYJBIzt1WtgpZdaBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnHz8bi2QplsbKMKia13/We7adBKr3wjEnPQHWd+SxSDNrkxc9xMXTYkVGpuF0MKbow9WiK5P0ZInxgX7Rf2EkCdEL3B3jFW5BUlIB2Y72/Mu5AzHCGSmTW6BCzu4JbKSx1r8KfFIyXh2eiGQsY80Ca3OliusjHKFWfPLW8fpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auxYLErK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so33601375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740731582; x=1741336382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulduPZI65xlBW/iQZ++ornEYkdX+PksumciMKnXCfdE=;
        b=auxYLErKsKtEgiMKGmzjC72d2IqMpW+y1seIgTWQ+9hHNEsKZj1+8sFWqL1JL2JuJt
         6oyAuoBK097/6I65hiTApLXQLHZ6Ffn8bMD79lNNKeiA1Mck9qbdWTDDYJFx1SUnwsLI
         6mMb8j4wija+8Urvmqnnd1JFz2Hb6yGf5z3VlFtNWNdNOYJ0sfra7rgeqpzRUUAvjknR
         wbPmWN+UxhyFmjJiqyzbWZEtxuZYtXnJzqnD/rprinD+kHpO03bdt1iZQSyHEC6mdJcR
         IZrs+u+mPHD+bvTkVVJjOQJoOjljiViRPKRuCPjymMNk0oWNi/mCWgQ7bI1f6KIcXU3o
         3/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731582; x=1741336382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulduPZI65xlBW/iQZ++ornEYkdX+PksumciMKnXCfdE=;
        b=wtVKjBfpCCnDKSqrEN9r8wi2aioHtt3tCc4UEohHzjMiJZ+vpBXX1I2vSqDI2PlvJN
         OsSxJrTJ92TF3VFopD8L1cWgd0js0GLzP03nz43xTHqVlX6HduJ5zsLHqveBf6vOrxso
         ynxvmIQmf459MPfyEamTlSzvR/WzCLTcTjuNCa+tpdxfKBCqpFDLGytR5fGMl122vGjE
         f0qzXJaDIzvo6VW6WdLPXohtSkmkJKdpXYo8BeOpjewOWev4sJ9+lYPEFmA/Fr5Ly9Ed
         wcG81GwJNjVJ8Jh1h0Od32esqBr34agOAxQcDzZ+Cc0loGDHUetFf3Fq0Kmz5TFNf445
         x7vw==
X-Gm-Message-State: AOJu0YwIdMCOAS3AvRdS76Oko9LzXK0z/b5kQ1cq0UiYiPbRDnX3sLep
	q+JpCc5rCnSr4vfacJ7GnGDvDnmyQ44NiUG2xrHTfbJBjgFOABDgle1M57nB+MNs8A==
X-Gm-Gg: ASbGncteC03TpFhO0ATuhf4aIN9tYgddO0Pxg+6sTAV/fU+8mkqj7dYQwjr+CUKa2oT
	K9jh3gexlobSH+CWCZQTP68c2hJePOfb2VWXOn2xfg/fd1Cv5vPVXCRgcLh896J8Zjtyha+1kai
	Lu6lYO81XmrVm5HhZh8LZaK/qF8/4eKB8+Dr36MhWnyXbUxXacSkyd/w998U5Yy0O3So1kjWIqP
	yFZEX1DH3USRdncpBK4+YFCLG3s4kJShvxnrwkIR8f55/nFspjA/8FwDEv+dZq+US/2K7Z5cQ/z
	cRLtH/ApITghiZjv/1BXrYwdFqUi18uaRumHYQYmpCA=
X-Google-Smtp-Source: AGHT+IHb/sdbhY1x0Sw1KrjvrY21hsN7ORugOCAcnujSSD+zrlsUowaYK4fAX2IeY9VGc04XaQ6qDw==
X-Received: by 2002:a05:6a20:a10c:b0:1ee:d384:7553 with SMTP id adf61e73a8af0-1f2f4e016b3mr5237476637.30.1740731582323;
        Fri, 28 Feb 2025 00:33:02 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1f7a6sm2803937a12.30.2025.02.28.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:33:02 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] MAINTAINERS: fix broken reference to fsl,qoriq-mc binding
Date: Fri, 28 Feb 2025 14:02:51 +0530
Message-ID: <20250228083256.55087-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsl,qoriq-mc.txt binding has been converted to a YAML schema file,
but the MAINTAINERS entry still references the old .txt file.
Update it to point to the correct .yaml binding.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..1d60ca116c5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19299,7 +19299,7 @@ M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
-- 
2.48.1


