Return-Path: <linux-kernel+bounces-182031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629E8C8559
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3523B224CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55CA3D0C2;
	Fri, 17 May 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpuI2+S"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8D3B78B;
	Fri, 17 May 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944400; cv=none; b=tWmkY935qzggHdHvzy4WNtDecOIRoLRR+svxHnUO5vcHER7nDuC9W3CXM3U4dPhyDR3yhhuhVzJ4HdznMARIWQCEcD5qY3zVq11klO+3x/Za7/LdArOwgf5nQYTCBywKuWDu7XkG6OOiES7JgeJpVcOQyI3lBQTrMUiJrkaFO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944400; c=relaxed/simple;
	bh=ypJWPAXdkM5itiG5UVH9IVJusTPRaIOKFrtWmyuLtV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHyxBJ90yXWvCCNFZZV+3Hid/kY04zM7WC+6jJ/ZB0jTQV6+IMb/lssrslv8GIumD3H1ffsUKTx0pLYHbGkUfmyVeTBHjC6kunLnIUAI6bAw5UX8jepNiIxOrWCH+pinH49sDcKJLfHvodH8AcHUX73nYQ0VtbCrbIjFNwFmjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLpuI2+S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a1054cf61so507059066b.1;
        Fri, 17 May 2024 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715944397; x=1716549197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0jVkMtFf3CbTZAlgcnmUWY97LIc8kU/RGoW8WnJqv0=;
        b=jLpuI2+SNu3lQQfyF82LV7PMcVN05kMdhiGHQqxxVQ8rxrHOzG82jUl3IyFk5HqEfu
         BdPTL2ujrkoAtaKRwx8IFDeLAlwPMrr+lo1CtWvFxQAn+QUNJnW5u/Nt0Bt9Mkc6eEIg
         I+Fn9Le8/t9WP358DymASy2SJ9YwgARvEbDo7zFKwHrSPSn7hS1FrWd9UH9YjsUN7fps
         Xnk9a1YCLX6NiLXS91nNojG9V8veD222osng8o/HHUXX6GIDxrJ4JCubfc4MCdEqsHc0
         0qevu+lC+6NuyB1jucdQMO1+2to1O5hsLk2PnPvs4UNGy+HTtg19oiEFIx5BuWWc5Ux7
         SKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944397; x=1716549197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0jVkMtFf3CbTZAlgcnmUWY97LIc8kU/RGoW8WnJqv0=;
        b=Wcnr3OPLIRrtJs/6D4MbmxBZ9A0pynb0qQuWr8V3YnNBNBbN8K3NXmoao/9Bwz2t5z
         OIaOvO5QlWC8Fh/PfaYc6eHZPgq0F4J3UGvWtr95DFfwHnkGJIScJnmfbNbz2jIuDGZO
         5ZCaNdvuD3V0JzD9XGUPq5KnVr1qRY4HcQWX5Yn40FAceTXGW3pOhNjDqYVG1gW2hn/B
         8oaTjdR6nRq7TikK6GQupHr8goCS+yyPrbIS0WRRblRhqJ5deElSje//e87QDNGWziWy
         ijZtgFB8Nb6lyguqd3Q2aEYqzcArvaKIeQbRlyUKabFal5b6A8Pk0mLmQIo8LLW4LMfD
         6UXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRCDZp34Etk4+LdV1IRRW6vp8hw4EKo4D1Ot1NyX0eg67oZjnEapRQRQ+9+UZnPwV3NDtcBkOe2pJzFOXevxva7fdZk6NpLzxS2R5dfBomavQ21NvicX88NVBIZYds3fGz8YE4vVoMd2AaDZ0cj1Jwfy2RwEEdx663O5PekLatkbWJkA==
X-Gm-Message-State: AOJu0YzcmqIhfI7NhaYMI7HKbGoSZZQXOFPCD5seLK/WvUMuJU5Z/LUm
	fh4mASxRoBZXDgi10fFpPzXreAjXbFmSsSgH4tbStBYdpLW2kIWf
X-Google-Smtp-Source: AGHT+IGIrnMJoafj6+anhAcQkvz0Z2a09SBsigRf595GGX82+EkMCcs70KvD27O3korKTEZjfi+1OQ==
X-Received: by 2002:a17:906:aec7:b0:a5a:7a4e:7e85 with SMTP id a640c23a62f3a-a5a7a4e7f2fmr1205784866b.24.1715944396821;
        Fri, 17 May 2024 04:13:16 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01399sm1127891666b.172.2024.05.17.04.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:13:16 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: gpio-sbu-mux: Add an entry for TMUXHS4212
Date: Fri, 17 May 2024 13:11:40 +0200
Message-Id: <20240517111140.859677-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Add a compatible entry for the TI TMUXHS4212 GPIO-based
bidirectional 2:1 mux/1:2 demux which can be used for
switching orientation of the SBU lines in USB Type-C
applications.

TMUXHS4212 datasheet: https://www.ti.com/lit/ds/symlink/tmuxhs4212.pdf

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index 88e1607cf053..48680721abc1 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -22,6 +22,7 @@ properties:
           - nxp,cbdtu02043
           - onnn,fsusb43l10x
           - pericom,pi3usb102
+          - ti,tmuxhs4212
       - const: gpio-sbu-mux
 
   enable-gpios:
-- 
2.34.1


