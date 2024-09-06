Return-Path: <linux-kernel+bounces-318868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7496F45D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917E61C2413A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6D1C8FA6;
	Fri,  6 Sep 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7XqluW4"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4F2745B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625949; cv=none; b=q/lQ2i2B/RC4SAFKUDWf89NStMLJfO1MUZmsejO4/yc8A7AxAiqjAf1fxYRnxoiSf+WUmsVfhNBF3GK7ddnVLWeig/qsOb9OKt8yKUlFmIwqKIWxdD148OHzFyF6SwjGaLTPuQ+Dwzwqu3WgGkyTgmPd6+wRuhfZcqeU/gpAmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625949; c=relaxed/simple;
	bh=BdjMmt8J3spzuvVK2jxXiZJFpvMMHE1qWuKGsMcrFek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkYgWFRDN0EAtjPNM64r6baQMpChdfHJtgBjVvfcs9YErwp6BUj6tK+b7x3tfjKmJrtCIcBxGmekbJjRaIdeFVea4XRGmXSChboc5G1DLwsWjjxoSC7gp24O0JgAR210aNExPws7ftz9D3AjcWmIzJ4xZYtvxidm/QAhQgSMK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7XqluW4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so1364307a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725625947; x=1726230747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohleuXUYZA1tyY7CTumF4DAGjjc5SkvM97PKu4XlTI4=;
        b=S7XqluW4PfpwDcVXYndZ59Edd99P71T30+8zJUU4ur4SjLZB1PFfYXIZfe7l8JYlmh
         krTLszWZsiP+sn8wm6XTFYcCUkO3FThPynWSRQfvTaCuSP8Jo5mlYu0eq4nPCwIGSOc7
         BEgTDHP+AS0cly7SvVS3mmCh6YGUfWFF7Z5H6+6VttK7GF3XJiE6LyRQH/Vhh5PEbbgt
         rL8qerYPwoJxHvNsf0NIkTKhZQCk5oHTAUMsItICp9pnXVvfMF5O8CECsxz/jko61okd
         Jrh57oVLJD397ORMz8ARgqssowUd1AQQcaXZ9IBRoXUimmQmj0slq4ODn+GfA8tji3bc
         uSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725625947; x=1726230747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohleuXUYZA1tyY7CTumF4DAGjjc5SkvM97PKu4XlTI4=;
        b=WyKe1doYEgORiwu6V8o4YaUagojV1/AEfFB6NIgT1Lz2oKrXwtZEG46BzHhmVof/+U
         jzTL+z90Nf/6CZurlXCna+oXVq+4lb/ATGxvYS+k21MJ5F7XMWiiilJlWRiQC9OLEQX8
         98TohhevhaXHp2PEwQHaJKvRTsmPoDI4LpGZoLX5cKspSlmSVXnPIR8920FVzxieE5My
         wNMBEyiaeOP7HVH869Dz9C4fuzD6gSA4nVWTQ6a1ZLAJ24dMh/9zUuC+Z3u4a1f+EIfY
         jGUEBrCwszdl8HlgqPzYJngN6q0BzobE1sjIlwJn4ms8otftN8f03NddOmJ54geRRC/u
         yvew==
X-Forwarded-Encrypted: i=1; AJvYcCXCRR2jkwb1vCap5ozafo8d6lDMZ+9HuN0waFEHwp4S5f9T2f5oi2rmH1zSgM55dXDlaTUnx+KOwSbqlHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjow7TasmSaVFvRydCetkgDKSxX/UNBYtmzRJflsN9rskKMSeP
	VsD1ziVn0q2xG68XihWcPM8mVM73+PDRAHjt1wD0EzdgWn2StHWG
X-Google-Smtp-Source: AGHT+IEmqyU2jz9pNIlB8sZzd52kwoCaqvv27CGuHeb+SNCET66fa4Y204rtcFM2t2mLpKu6hJEqNw==
X-Received: by 2002:a17:90a:3dc3:b0:2d8:7c44:487c with SMTP id 98e67ed59e1d1-2dad507ac38mr4118126a91.12.1725625947324;
        Fri, 06 Sep 2024 05:32:27 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0e1558sm1427616a91.55.2024.09.06.05.32.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 05:32:26 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ni_routing: Check when the file could not be opened
Date: Fri,  6 Sep 2024 21:32:21 +0900
Message-ID: <20240906123222.32006-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---

I'm sorry. I think it's dirty because I'm not used to the patch. I'm going to write it all over again and send it to you.

This is just a defense code just in case.

 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..892a66b2cea6 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


