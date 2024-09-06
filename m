Return-Path: <linux-kernel+bounces-318819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D145A96F3B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086341C23FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA251CCB40;
	Fri,  6 Sep 2024 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK8jUTON"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F51CCB34
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623652; cv=none; b=UqR/Lg2zw0enkIBfYEvAmmI0/kcBY0OL49ZlR91U8ufER9yO7u3QfdEPQ9RoigKQ+1isYAcs5PWMNrgnSi0VtWD8fHlPYJvrZTmDtbRp71KQl33A9+/Qk1752Vyn+ckjE0+WXRbnVH0MGPyX+wcJs88/+fc9MpJ3XWrWm0fvVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623652; c=relaxed/simple;
	bh=aXfRlCHO9U73rweATb+imgYLC7Nj0b4oIsmJXuGFxgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMMk5tDv30qpHPrE32ZM7lzWzLywnA6xO1X5OlHsbryiobwWEjRedqq71azqR3La8PYvLNZuc/z7VxT0Rop2zZq2Z8md8g6013juElPr/QOchVulcp3vHQLbmRpRzB9dIzjrgGi8/GtMxftvZ6GoFz7Cw7WGq+rOQ9Md4l2ivnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK8jUTON; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so1363672a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623650; x=1726228450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaWdTcmyOEM+3lRJdsVZfW3ZYgCG1mOBZ0L8KgSClI4=;
        b=YK8jUTONaY36iKQcDTZqung9n7Pg7hcZxYIJSEFhgUlQZOq6c7qEqcbH/Gzckwlp0C
         Cv1ObA5PIdGq9a01MmZQD1eTwnxd9ZzYU0YrxV3OR0FPE/iYsjRpXhnG3wZeBSMnl79I
         +Nsxbjl/KhbGoSYV0auDIl1L7F7AgbIoQPwsEodReY/Jd8rgq/dGF28eUTn4Ea9M2BIE
         1ACBB7Gp8VbyBFGeONV2rWHTXkPGR8RuY3a3xdqjQ3judVfKyPORmPSgMaXDOrx4E9Cs
         AvRvxqUCbhGeFb2/evtA3grFM/IelzAY+fBXPelc+CxvvlrDL6mLapwGvVL4dD2MXGac
         nChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623650; x=1726228450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaWdTcmyOEM+3lRJdsVZfW3ZYgCG1mOBZ0L8KgSClI4=;
        b=H6WFz4tQHhdYqo90PyRZnSXnNBP1rITzLtnPP81wE39G8M5DGXJ/dc5TLI/7he1xn6
         TBaSaxiNbFsKedA2og7aJlCvjaP5bgIcgyYAymbqa3f/bcbOIC4FspsQbh1U5mAQ1sBj
         rs3QVf51T/iislRf72S3OdNlf8hp66d+6ZV/Wm1h2LitEV4eVCmrcI3FnbYm2lD1KTWo
         4YGfE77H0t356QHELa+hfW778ijVypqao+KexiKg+dqpkGeVJ6L+vMXh62DOeLD44R1P
         uC1mOvDSaXHPSKii5D741jghuqrExhe4EU5+h998jxaTvyGx2TOl75EnOvX2OBle13dd
         T4mg==
X-Forwarded-Encrypted: i=1; AJvYcCULtDeqhVzy+C+RceObGU20GTEd2WrA94CnRW+H4VXQC5KFnUwLpZC4Ie59CGQZoIKbNsMfoYy87knK62M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PdJxUebwSqRzSuldFw8HEGmuYwFw/4tgPWG3RRgRpWu31bEl
	N7KhJu+RHA7Z82ZT0UZAVX5/OVUys1x3oLntw6X23uJVHBQadtkJ4g01zg==
X-Google-Smtp-Source: AGHT+IHDzmWP//+Njj10BsVdyWfN3lDqvi3n5d5LBuf+YzQqwz+Xd1/1AjHoVNoqEb4nKANILftjtg==
X-Received: by 2002:a17:90a:c90c:b0:2d3:d728:6ebb with SMTP id 98e67ed59e1d1-2dad4de1412mr2720763a91.5.1725623649635;
        Fri, 06 Sep 2024 04:54:09 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0ca704sm1357572a91.53.2024.09.06.04.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Sep 2024 04:54:09 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ni_routing: Check when the file could not be opened
Date: Fri,  6 Sep 2024 20:54:02 +0900
Message-ID: <20240906115402.30894-1-RuffaloLavoisier@gmail.com>
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
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..d0321a7565c5 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -139,6 +139,10 @@ void device_write(const struct ni_device_routes *dR, FILE *fp)
 int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
 
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
-- 
2.43.0


