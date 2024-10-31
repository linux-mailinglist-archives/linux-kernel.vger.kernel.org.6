Return-Path: <linux-kernel+bounces-391459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E259B8770
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FD2B21E69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60E2837A;
	Fri,  1 Nov 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mC0UdA0R"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90C1B4F31
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419216; cv=none; b=blhczz0emfQa12EOX7e1qn2cVV4S8BG5ugrPyYZ1nZuwsvSrtiy9IPV2t6fTnRHsCPuWmq62bezAWNbVCI5zv3SPQwsuh14+XlfMMjHIEmaXboCFiu2g44DdzKtRoQ6SSFeMyz5fjMCbRwIoGkS+OzUqRpuL9zRbKJU3jtpXCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419216; c=relaxed/simple;
	bh=A4bq0N4uNagV3ukMVWP0KMHLucV+wRSRyhiufTLh9OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0+RWICjTaqQ0N1jLC1F0BX90hO3av1rQkgbXAuTub2UbZGn+c4sVFMTszMCM1VATijDG6O7X9FkIVMI4VUSF3Igbed3tIX0Zkqnl/R3AqiWUVm1374+HTUdoj2zNTt72SX2tsGh9l9MpkeQZ1VTVnRmK/xrMgXEu2yTHnETMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mC0UdA0R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so2556457276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419209; x=1731024009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bngmyXciCTbSjbg+6G3G0oMv+8YkE4Dj8JEhavO/K3I=;
        b=mC0UdA0Rk59J4YogjBUE4PfLnqf398/JrkcNthFriXtuJt1ozINivHlt0oUKigTpnF
         /u9ieQ5/R80p6uHobgW1J9QaCdtdXDMDrT86OaWXzuxD9mbsrl/K8m9+gD0e65VfU2Cv
         WaJmKpTYbwCJ7HvR/WH8TDQacBUxxO9VuFjdy52+s7RrTqvane+U62rmbcsbuzhqVPVW
         FgpyDtBCvqk/q9KOk9A+reYn3bLuFV7k38DWfnEnSrLD8CS075GPyqs0sitGeqHSbz8/
         hSo62dtllCqO4/YM/YOESxJfCan5sDW2jeUW6GgjhHlD/7a703SQHlGROLMBXjGRvgez
         gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419209; x=1731024009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bngmyXciCTbSjbg+6G3G0oMv+8YkE4Dj8JEhavO/K3I=;
        b=qjzMyHZxeG+n2t5Ly5ohjpcofsbdgD0t48zaGHgFLt0OieoQGaqJSCVIqqCVcOdmE4
         BOV366WD9VEv62LxVNIyRP4Sjk/vbv+YDXFvHgNyYF5AGeL/3iDk5p5DdA4obE5GzBCj
         5WmNoAFFwXG8PwUReOkhav2vXhX95SBqtn6n+jY0Y0q7b8ri6o1eTK2FC/faBt9lW9pq
         I2gj5KaIoKF8wYhRq/1vc2xKA8FU2f4k9Y9oYanrkRPlg04NgtgmuIM86/K1hI+4UY69
         gLLu1SOFAaH4zesdk7q6XE9QYhoPlM3gPoKkTWhaoJxkolmkUSDM70S5hh8iD+7YXH1P
         n1vg==
X-Forwarded-Encrypted: i=1; AJvYcCXJRHhIM3VBTRfNoZxC+FqYxYqfkztFBNmSJnHeyH3XbCKTpaQ5hjI0Xe6ceIN0SvGr6XzV/iwTWbiVG24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlqpPEJrH78GTEwiBq37gekyXo9QDdXsUk1xmvbwYrj+4S9jb
	m9yp0yNLZRt8S3Vu2uXcB8UVgXyN24bYqlJwhwMWRljPrUue2m4tcC+RiR9emOhTMtuXmAecSnA
	klA==
X-Google-Smtp-Source: AGHT+IHQfGP03Xo4Z1kmpAjYxnkeLA3AW7J7tuHBqRtNeq1/nshG4E/KrtXeW5RUm6duPvVgst5xbFme0YY=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:b321:0:b0:e30:d518:30f1 with SMTP id
 3f1490d57ef6-e3302522da1mr1359276.1.1730419209485; Thu, 31 Oct 2024 17:00:09
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:59:53 -0700
In-Reply-To: <20241031235957.1261244-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031235957.1261244-1-amitsd@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031235957.1261244-3-amitsd@google.com>
Subject: [PATCH v1 2/3] dt-bindings: usb: maxim,max33359.yaml: add usage of
 sink bc12 time property
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add usage of "sink-bc12-completion-time-ms"  connector property to
max33359 controller for delaying PD negotiation till BC1.2 detection
completes. This overcomes the occasional delays observed while
receiving PD messages where BC1.2 detection runs in parallel.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 276bf7554215..20b62228371b 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -69,6 +69,7 @@ examples:
                                        PDO_FIXED_DATA_SWAP |
                                        PDO_FIXED_DUAL_ROLE)
                                        PDO_FIXED(9000, 2000, 0)>;
+                sink-bc12-completion-time-ms = <500>;
             };
         };
     };
-- 
2.47.0.199.ga7371fff76-goog


