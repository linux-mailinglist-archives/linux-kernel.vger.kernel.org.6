Return-Path: <linux-kernel+bounces-565689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EFA66D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D83B5EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4B190497;
	Tue, 18 Mar 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/zPgJgD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20521F418A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285363; cv=none; b=cDv/8oU3BOhcRtMkUPH8LoHHXufbWzz4jqade2GXjTLh8IBnn6zn/hGGCVvkFT8D2JhABHEPWUgNf7ThOB3KHxlHEsrgg+3MuYl+mbeVpFpqO02cuuHbzA3QxWlbzr21kgalQz9dIoBJCazLGJzbY6vxUQYHcmjWrOpPCYQ4HYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285363; c=relaxed/simple;
	bh=7Mp3l5IFx+cBU0LtsyIxw8lHW6ZgPBAyf3KkmP0Weno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQqObrbdhV2MS9a2Yh+4KgFEA9kZCkeqVfIBT8LcA/i2N3tL/uEJe0m6yJ/0adFdksuHkAE33C0DQbIsWZyDPDouLiFDZ/Tgc9FC51AoSHTcsNrDEp9e1zQc/kdsivJj+ccJo39KjiQwDk0DYC9cemuoV18CKzZ+lAs6l27AAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/zPgJgD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742285360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MOPIMVq4RYa2Qlhwo2paVsAS+Ja31+A7+LmeILgDQA=;
	b=E/zPgJgDHfhUUb/vDdgC3ywtQLqhMCbiAqfEH87am/HHCVVDq+US5iGZWsz7GPjSz+py+X
	yj7hpryiDRgwPJa0RzEyGcLsgOPPpQbFeYMr3t1AU5NW2RSXKtNZWTYGOSywNjSCeP+lsB
	ePF2rFHosTf8lvHgY6SWtMQsRvKCvv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-RWRvHbM2Mtyzk2tbU1YK2Q-1; Tue, 18 Mar 2025 04:09:19 -0400
X-MC-Unique: RWRvHbM2Mtyzk2tbU1YK2Q-1
X-Mimecast-MFC-AGG-ID: RWRvHbM2Mtyzk2tbU1YK2Q_1742285358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so14617905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285358; x=1742890158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MOPIMVq4RYa2Qlhwo2paVsAS+Ja31+A7+LmeILgDQA=;
        b=Cn6P++67qAQ2xpkm9TFPJj/m/gB2FnlOjoVmFZ92jybn1fpiQwZU3HyQhuyeM0pcn8
         El+ia8/JigzVNUg9qgiEVr60QJOiPmBH4tFUHBMyENW4tV3IELnfSXjXICZplagSl3zm
         eX7QCe4GYf6027e9N+p/2RV2UEAiQ1T2+qtKgs5kG4pqw8439F0C6zZ5L8IzKJgdG3Ya
         RE+QB1rLr3ryJotiHOc1Ov/Ke7Vib/6iyTbdDXBDDuAv6yrlvPS8r/0YgBdKeZ/JMHPT
         ktaZ7gZe4INOrr/VTr7vorzYIr5MMjzXljpDRkv3owp/6OIHY7FRRmCy5yoIAc/2gQ1Z
         N3sg==
X-Forwarded-Encrypted: i=1; AJvYcCWa1OpnSSuCatDn98KNu4kvGuQtu+vaC87lFkSCM6DGUwOfzCAyVQpgIiGDpjzEj9rfxYQkXOLgikwMU7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgy8eYPhnSdwpeGHryvDcz87Xf8QVeNAvxaULxMoIQWZ63NLY+
	gDAlWaKVEKaGfus4WlpuCQyVOHSbF6Dzwa2UzYMTEXy9M4w/bCVztTnOqZ1tK2yCZlF6l35WZDm
	rUdEbMHcqAXBJ5WUsvbSXgeWRCUbTu5CwM7fy+WzEYP5QOV/NZtTmfSbR+0wZEQ==
X-Gm-Gg: ASbGncsj8eZvoWWOzjXZcL77gTzDcjB1+mgv7kjTrk3oAmJsG0rjVqxWmS68iqCwIIi
	j2H/3DQgRXKSYxI5GX8bcJdsSCaEmTW71V4t9LRd4PYgzk1iFKdggTqZD4XZf/xrkPvpOOVOluS
	sfp7OhIl+uWe4utkSunIsiyZ2P7Bjx9OmqI0TlMwZNQ5HlKItrXYF1xekh1ghLAn2gCeYQm4C7r
	xn7NTaks0nd7o4JCIlGcb0ypqbBw02a3qmEZFLoH0wFWRDPKcqGlkUb8yvwlI1//CizBBnMul0h
	oHBb0gx4t5Zjh73CQjclCui/6pYl/4qRcXvSAsiitj53c/SItNgX0zN/FhWEfY0=
X-Received: by 2002:a5d:64e2:0:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3996b44670dmr2495604f8f.13.1742285357968;
        Tue, 18 Mar 2025 01:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTLxf1mjfmE9kJO903aRfrs3DFnwMwFBN6shttc0uogtpGRU10VKPtw6/ONRx4vNAinDz/MA==
X-Received: by 2002:a5d:64e2:0:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3996b44670dmr2495582f8f.13.1742285357554;
        Tue, 18 Mar 2025 01:09:17 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a75sm17490878f8f.76.2025.03.18.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:09:16 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Maud Spierings <maudspierings@gocontroll.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE MODULE SLOT
Date: Tue, 18 Mar 2025 09:09:13 +0100
Message-ID: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 8f1cc5242544 ("MAINTAINERS: add maintainer for the GOcontroll
Moduline module slot") adds a new MAINTAINERS section referring to the
non-existent file:
  Documentation/connector/gocontroll,moduline-module-slot.yaml

It intends to refer to the file with the same name in
Documentation/devicetree/bindings/connector/. Adjust the file reference to
the intended location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 561d394cb210..92af00cd0eee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10022,7 +10022,7 @@ F:	drivers/media/usb/go7007/
 GOCONTROLL MODULINE MODULE SLOT
 M:	Maud Spierings <maudspierings@gocontroll.com>
 S:	Maintained
-F:	Documentation/connector/gocontroll,moduline-module-slot.yaml
+F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 
 GOODIX TOUCHSCREEN
 M:	Hans de Goede <hdegoede@redhat.com>
-- 
2.48.1


