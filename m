Return-Path: <linux-kernel+bounces-541556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06DA4BE75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BA63B65FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFD1F8EFF;
	Mon,  3 Mar 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsD1mnsx"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5261F8BBF;
	Mon,  3 Mar 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000642; cv=none; b=Xle7lLF47BKX3ZnMlVVCWEXH1u9Ms+7wosxCpSWD0aIhitg+NoQNhkxqCklqAXW1MOQ+SD26Eo22JVZlpOcyTHOYQj7zz0uK4OlMZwhyO01tpzk2MsFQ6Aefg6zr9SfI29shGgDWtn59jgLMPioF6Dy6fmWyj8VjhGSk4opFYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000642; c=relaxed/simple;
	bh=Jqe8Y5KSRz+van0BhEQNwElHuoSXwhP7NXBrkvhu+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEGXKrUbOzacF2C7jbzKte6moKFCwJXRfD3iA0MroabsNn7RnyBQA6mh9uczfvy7mdMVbznHcbYo8RTxFiloBkdTtX/fteICEw0qqtR162uH1GgsN6Du001I2mkCCVRNUjddyqpv890wkaXTbRDQ+z5EF6/4VcY+koTdbhgecFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsD1mnsx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c08b14baa9so383108985a.3;
        Mon, 03 Mar 2025 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741000639; x=1741605439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cac9SGeYgxlf0ZE2MBOLXGNfNfGSnO8PvB/fPnkfcsk=;
        b=bsD1mnsxycAUgnk0Fd6rwReB+rphdgLX5W+c1chUTt0iHriTKa1zp0GZmpoLO4jknn
         rXiw6omp1+7F1/CiWYzGhxrppIm+QsXebAuOaCVGvSU5ZTa+kCf/qvDN7ABdmn4Yj/H2
         wgekc92iW2H32mYhenzmOuuuTAS9nS5OR2ZH6nLzhURtOGWPPCFv7PdbAlIduKYSkvqJ
         BbqgqQfbR94+QBlKjh7B8T7ezUjsAr3K628XyAaRve9M/UiUlby+m+3tkhm4gOflkE9u
         DYzcEW3CO3aGU98zNOz7louoGo111PyCSuX/oHVgFljPZyERVKq4YaDgbTlMG2btm8Ee
         FPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000639; x=1741605439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cac9SGeYgxlf0ZE2MBOLXGNfNfGSnO8PvB/fPnkfcsk=;
        b=i18+gTSY3sIVAOfDNu+nC/wPVI2dj8bFUMQ9ANWHChZ29o4DIKdcCcC9ZA5FDQN24f
         Icoi255W5ijBmht3KZcRDpbFVy0ObMz8xiuS2RcMcIexvHKXVUpMmg7VVFa//0mFxTZC
         XsdDHP709+PdHtSbgyxviHCxab5Rm3VQh9Ue5TEFOaRBT6Dj6DQpn7ScCl6mDUvfoeLq
         26MD5/l3VjJNwaB+Tit5TdThbEwsEhs7TXPKAuCPC1Zn/UdBoaSelxfHuIFRaQOc4Pq5
         wgRWU84sInlvU9b+YvbVBAHP+0nqKfVX+kl+uRsNKrZ1jLkUwGKmhVpxOKG4MyPhMowb
         Jfsg==
X-Forwarded-Encrypted: i=1; AJvYcCW5OceFXg5WEu2Fv02AyBAiOvuFxOdLfU6MJW+dKD/Zb8JVMbpKDTV+svYnAMzEpDBwXgFrzf0AaQgw@vger.kernel.org
X-Gm-Message-State: AOJu0YwumXWT9uvWNGnu0rXdbzxIrWQFhB6TF68UbE+fvmm9oXoJ7W0y
	opOye7x91UW5g9S7Q7dm3+BLIbJRRRYd9LYGSVoO3QgbX3X0oqCr
X-Gm-Gg: ASbGnctKqgOgkC3J6/JgOeemMEi5ZxdqlDAH3n0V73hwNaKWQg/wrdSjOswJqhszBsS
	WbRMzFsxhKMtmk4Gt3Fcu+0pMKwS+EumB3hSide7xqDd4IiNgHkS5kaCvAxueOKe51PJ4iRiQZS
	QgHYc6cuoAoPEQHCC5XY9m3RPjVJR180DJYUcZfqCG3vzB81LOHEjGdS+6fvxhc4gZ2vcuvLll9
	rL/pbJsdt6+BWkFtsf9pSiTb+Zy5Ff5tgU2x860calBcOnYwmglRftaLUIf3YLsJfgWZ2kWl1J6
	5i1EMMPVGMdN4dP+WJ20
X-Google-Smtp-Source: AGHT+IGeFdXvURQ7vI0EQuXxHZtwK5gbsycOL767I0CGGnL7OmQ9+5cFegMcJb3QiTypWujcAD+s4g==
X-Received: by 2002:a05:620a:1aa8:b0:7c0:b0ce:a577 with SMTP id af79cd13be357-7c39c4cd3f4mr2211231885a.25.1741000639324;
        Mon, 03 Mar 2025 03:17:19 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e897653722sm52123386d6.36.2025.03.03.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:17:19 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller
Date: Mon,  3 Mar 2025 19:16:46 +0800
Message-ID: <20250303111648.1337543-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303111648.1337543-1-inochiama@gmail.com>
References: <20250303111648.1337543-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like SG2042, SG2044 uses a similar msi controller to provide MSI
interrupt for PCIe controllers.

Add support for the SG2044 msi controller

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/interrupt-controller/sophgo,sg2042-msi.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
index e1ffd55fa7bf..f6b8b1d92f79 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -18,7 +18,9 @@ allOf:
 
 properties:
   compatible:
-    const: sophgo,sg2042-msi
+    enum:
+      - sophgo,sg2042-msi
+      - sophgo,sg2044-msi
 
   reg:
     items:
-- 
2.48.1


