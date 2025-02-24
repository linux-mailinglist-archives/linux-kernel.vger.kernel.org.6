Return-Path: <linux-kernel+bounces-530277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5B7A4314F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F341883350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE63207E1F;
	Mon, 24 Feb 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm8LqU+Q"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334221DB375;
	Mon, 24 Feb 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441016; cv=none; b=Xiq05BDRk6Uro40bw9in878kLiQtTntxS9aLeyPAqTonj6EIzd27U8KlFyXJATPwjq/QhXTDJF8yO+BfY/9wmHuF3MnLiHJ9CrHFQX+6+HkEvDBeH33VpDlUrTQZY8LNYseS7SSafjvkkeJ3/Co+fA5XJXylkXkXIUzjZuBiudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441016; c=relaxed/simple;
	bh=B8KYFDFY6aAz9K22ud6BAB+fiNsY/XqDHGMOB2c15xI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=ZQgvGTDa7QOIrPNvASL/9wUtSAVkmLwwa6PBo7KfuhdgkHyqtJtdP3WzkFSc+RXJvjdbfJVmUCx1667am+L03bIEs1fjccmNHHdqdFf8FJ0EYUkxEtkg8thMIR2UHT8tPqTrFecd+/DmBDhK97MzjuXGpysxn4z8DD5vNOD3B2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm8LqU+Q; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472242b0da5so38543751cf.1;
        Mon, 24 Feb 2025 15:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740441014; x=1741045814; darn=vger.kernel.org;
        h=subject:cc:to:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LNfkARXli3uVvFnrZ1vZRAcjsGQLR8DVcO+Dhioc7z8=;
        b=Dm8LqU+QZCrIhJHQ8o6g6G3FfFrp5JQSa7DWoMcSqsvF0ydca0rW/CuFst8EHT+J8F
         SyO88moCa0ZKmY9BOdNrJkjwQojJ3ARekKK8aLosY5lYzypEaF1EdkFoMxIBaaUvRkuf
         e3FthLumApvnu4RNHGJZ2gQAT2zvVpc1lfIHH0qVuAcvX1X3jdf6wa9qxVh5c2qptZt0
         XYyJx3V0BjdvT+o5sV2ojEABfjJKXBCqz351o9952XDijv2JhJPDQGa2temnPJVI8iCq
         LYur9S4KxVBzxSkragZ3+HdZghKMANjIT3sc/L9t8h2dVPEXAGcgfALO8IafHt+4t8aw
         uYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441014; x=1741045814;
        h=subject:cc:to:from:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNfkARXli3uVvFnrZ1vZRAcjsGQLR8DVcO+Dhioc7z8=;
        b=csoFU4XOwI9gMxwvNVk1S+30KFs5cYKCJQ/2tC/kYjdxYHTMZOJm28FyCcI7xsSE6d
         DWfAFfXPsSOJlvsTQZcdACIDpOl5nVk7nhamrM/zzBI/+Z6kFF/dnJPYx5PQyt24a8Jv
         nFH1UZw4oZ5fjU/Vdgq+FZm8hBItHoakBz2yJILBj2yqvtY1sk3vuQE2L88ZKWhGUm0U
         DF7C1Z4SKHtS2GUFBQpOKhbq06ocR6FJ7G1sDgZXtMF050wzohRs0v1i7bNkyNbotRUv
         3CYkJCxTtUKYIln1HFhFVoImvdAxLXwPdO5SenBIr/XL3tHPAJ6BXgbGtu+pV8f2KZOJ
         ms9w==
X-Forwarded-Encrypted: i=1; AJvYcCVJmPe7X2H6W7YfakRZutV+bNtRmiRFiioIkrejY38WF2BaK558W6MeVsUB3oLVxKiImLvmZLiXfXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlOxQvKTlblMwLEE0O0fil805ELwdCeVwxf3k7rAKm9aW+xM/
	Sl1dTH9+WANJnaESB8aYkxJDUdIJyy2btEaRmvKYHsHxlRUB0WkN5mZBweE23jowaQ==
X-Gm-Gg: ASbGncvO4z4v6ktd3GyFjco2ANbRh7IdAJf2oEvIeX5wanqG5O7pP0YCqvgLSV1xZPh
	rT8Tgcd2wXbz2x9mD4FxQEUjIODG2WBduBmDlz1b9+O7C8704VO6/R/YkdrlxBc6JvlxPDV6ez2
	99JfQTrS4jq6atRecs7FC8mleoaK1+NP8bOA166JXVQM2bwGxUoYMsCNta9Dwjn4s/BfQ3BwdnZ
	A29LUV4dQx3KN1K27n3lkc0RXuhHvZzPLu1hDRNZ+f6xBbC7xRf3cJHu4CI3hq0FdDbPjp/uzI8
	ovB/HpndbIGdqJOnaWfbxpX0sadLvpVYrfn7Bdst+ws/bN6nU1a24J1xDrbeAjwdTL8=
X-Google-Smtp-Source: AGHT+IFEpnzcYWehzDJLiUmDa43uEZj2rwjWrAvQaC9BmR0P6FPz7VDzsr6K09MY8ZmNZeqrdpFfPw==
X-Received: by 2002:ac8:5b91:0:b0:472:133f:93ae with SMTP id d75a77b69052e-47222965e5emr198262081cf.48.1740441013701;
        Mon, 24 Feb 2025 15:50:13 -0800 (PST)
Received: from [127.0.1.1] (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378084493sm2539351cf.70.2025.02.24.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:50:13 -0800 (PST)
Message-ID: <67bd05b5.c80a0220.205997.19df@mx.google.com>
Date: Mon, 24 Feb 2025 15:50:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2672866445194770799=="
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: gshahrouzi@gmail.com
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 corbet@lwn.net
Subject: [PATCH] Docs/arch/arm64: Fix spelling in amu.rst

--===============2672866445194770799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>From 748db76c8e9f6e5906be0033dcdec9bb5749b303 Mon Sep 17 00:00:00 2001
From: Gabriel <gshahrouzi@gmail.com>
Date: Mon, 24 Feb 2025 18:09:26 -0500
Subject: [PATCH] Docs/arch/arm64: Fix spelling in amu.rst

Change though to through.

Signed-off-by: Gabriel <gshahrouzi@gmail.com>
---
 Documentation/arch/arm64/amu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/amu.rst b/Documentation/arch/arm64/amu.rst
index 01f2de2b0450..ac1b3f0e211d 100644
--- a/Documentation/arch/arm64/amu.rst
+++ b/Documentation/arch/arm64/amu.rst
@@ -80,7 +80,7 @@ bypass the setting of AMUSERENR_EL0 to trap accesses from EL0 (userspace) to
 EL1 (kernel). Therefore, firmware should still ensure accesses to AMU registers
 are not trapped in EL2/EL3.
 
-The fixed counters of AMUv1 are accessible though the following system
+The fixed counters of AMUv1 are accessible through the following system
 register definitions:
 
  - SYS_AMEVCNTR0_CORE_EL0
-- 
2.45.2


--===============2672866445194770799==--

