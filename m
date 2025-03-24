Return-Path: <linux-kernel+bounces-573858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE5A6DD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC5169394
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7124725FA03;
	Mon, 24 Mar 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXO8nEZM"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8A25C6FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827281; cv=none; b=Pm0zJHaHJ6VEDN5VYSidIhb9XL6umVfHU0FwrCEr01SG3TEfgfAklF84WRe/4p4092hFr2hROVunCeK7WqNDHIEWLJMkyMMdhiRETGMBgxDwE6NBKU3vj6cHid4zudYFP+c9pLeOSN6632pAOc2BR1kHloJxReWZ1v/lKfWMZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827281; c=relaxed/simple;
	bh=QMKV+YQB6q348K7itjiKyjN8edH1aruaEjBd+2BIwc8=;
	h=Message-ID:Date:Content-Type:MIME-Version:to:from:subject; b=jtY8thQTOqRV/4mDQ0DqKjThOwKEBbhhu3nC95NBa9X5AoZU87OT0HcZEAv66lDrc4Gemm7lyKXVPqoKwn/qb4zxOCX+dGsTQ9GocDQgppN872xxcqnUzOplJ2GDSYuMCt7Q8j0E3uYJISTl5y0iQaJmRUgz/wCwgUVCQXd8KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXO8nEZM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so81025425ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827279; x=1743432079; darn=vger.kernel.org;
        h=priority:importance:subject:from:to:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMKV+YQB6q348K7itjiKyjN8edH1aruaEjBd+2BIwc8=;
        b=EXO8nEZMUriUefJHtiUBEj0hZgQ7xAMF6TR1d7oXxK/msQZ1bRUqBKO6aHxDKlu5SZ
         kYdfoFjFaNoQx6mGbM7dhdQCTR1esU7t/sKXFtRNxpLbeC8vjsQKydI1vbWnieqR7qn+
         zRp7r9s6Iw7QBV7ztUCeAXi9dGTPNVcebLBhR1racDnfSGY2VHW6eURsAbLc3tldkfXc
         oZqU3/UJKB5JiW8yKBB03ia9zJ0eV7Fw4P7MsrDHnNS/EmK62XVEhKFUAm1iBXjWglop
         lJADmYmcEWMw9ErRTnsSFFCODv0lPenMRmTXUUhoiiEifgxNOjZ1TljtqJvmkcFsnlbc
         0zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827279; x=1743432079;
        h=priority:importance:subject:from:to:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMKV+YQB6q348K7itjiKyjN8edH1aruaEjBd+2BIwc8=;
        b=vMQeUmtrsAnv8hQ2AnvXquphBcZMAoAXR0uiYSx+I/ZZC+klfoCejCN9e2WwNutGC0
         EmSKzFrhmcOdKzpZhjILr4THhCzTkI1dFr+qIMrpKp++auDxNF81LxZmO0BFiRUCYSRw
         BWFJ9ltGB0SDY2v0S/djpUhPkTLbMLdlq78gVAd2f4b26qOFqPj4ls3vpvB8Z/83dGGX
         UWwRDWxCU6J8FOHEQujmB1BEv2q94h0kDfyMAHdL7Xg1pERxwhh4cvI4w2R/D1yRxDZN
         zEv3FFZlImJ3jE7J1Xb0pOOWCxSetT3/SkDAJnrHHtgb3PwiQ+LwNe5Tv+zmqCTuHAGw
         h4xw==
X-Gm-Message-State: AOJu0YxIWg25RSY8mE1Qhob4ZGmkVO7ZA+2DuAww8l3R00yYOl8Z9wTZ
	YH/crfKx0KzQk+iTbWxEkFk4FCmH5J66PhPE77q9VI0g3CR8PAaM2hMl4p6HYxY=
X-Gm-Gg: ASbGncuv5/m8hbuP/tUIEEntPGUUXEsoNylDzC1SF1HStiPGsCzcFgA7/qTCxJnsRL4
	PG7QmYAD6c+DxWrjR2b6QqdMLjzIZJiPZCsihPxZnAfOLFMvzaEhl2tnHcAvHbq+g/b+QoGrLxi
	nl1gi2P4yu4fHYR1rAzSZZ/p13PFO9gHGFBFdNwOXViEKyL8sf9nZXMqZCZ8JcpZn36aLG76zjd
	LscPQTx4SpuT5K+tHAgHyb4p7asB7ejxs7ze1+m0H4GFBwrZ57xY78hYMeJpieGIuScxDYLd14f
	VYZ2plXWYqx3Y3F0cHh1zIaLpJSMH4eMS5Cn9c0cYF/DL9CPQceFrobvbPl3nF/gSDsa/ho=
X-Google-Smtp-Source: AGHT+IHNQcByieFuYT0f7Aveo37pmX1yNQj36c14IhzWC9IiUGEEcZ2jpup6gcjEvhVdQSQwkUdjJg==
X-Received: by 2002:a05:6a20:e196:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-1fe430100e3mr23510527637.29.1742827279127;
        Mon, 24 Mar 2025 07:41:19 -0700 (PDT)
Received: from [10.201.0.127] ([43.128.216.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2805e0esm7147976a12.29.2025.03.24.07.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:41:18 -0700 (PDT)
Message-ID: <67e16f0e.630a0220.1bdef5.29de@mx.google.com>
Date: Mon, 24 Mar 2025 07:41:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4986939862290202661=="
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
to: Dear Customer <linux-kernel@vger.kernel.org>
from: Dear Customer <msbm85983@gmail.com>
subject: Shipment 779 is currently being processed.
Importance: normal
Priority: normal
X-Mailer: X-Mailer AeroDispatch [v2.0]
X-MimeOLE: X-MimeOLE MailMaster

--===============4986939862290202661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Subject: Your McAfee Subscription Renewal for 4 Year Has Been Successfully Processed!

Dear Dear Customer,

We're excited to inform you that the renewal of your McAfee subscription for the year 4 Year has been successfully completed. Thank you for choosing McAfee for your McAfee needs. We sincerely value your continued trust and support.

Here are the details of your renewal:

Product Code: 1579-rdnbwuq

Service/Product: Web Guard-ABC

Renewal Amount: USD319.10

The renewal fee of USD319.10 will be processed and credited to your account within the next 12 business hours. Alternatively, it will reflect on your next billing statement.

If you have any questions or require assistance, our customer support team is ready to help at 888-350 2394.

Thank you once again for being an integral part of the McAfee community!

Best regards,
McAfee Inc.
(c) 2025 All rights reserved.
--===============4986939862290202661==--

