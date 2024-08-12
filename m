Return-Path: <linux-kernel+bounces-282604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D73294E652
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE52B21813
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3314E2D4;
	Mon, 12 Aug 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnImDly1"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386C139CFE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442248; cv=none; b=jeNY8sY7ZatSm/xzFw4r68BgmcuRf/0kE1u6oaxiisSbuerM4F7Y51G1AeAzOaa+LhsXOSlK3LO1VvpRv8YkhqyC/ZQ3Q3ko5WZjVRg2gk3pmy42Ma9JzQcCZJ675XcW7Ljo7jtBZ4skUrSqzqk49CTlogXiWq9AMma7QlVYVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442248; c=relaxed/simple;
	bh=JRTKe/+GPn5F97910E2NrqoeM2xkgWSA6uZKjEF14qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k827odX75Pk8c667DulzpE+0czYdv83B76fkRax1Rl66vap+l/9/+OUbaZwPL/JmKvRt/P/XGsQ9eE9Rucpy2KFzjUQXr8t76XeITLYLLy2qDL+Ydr95FW4+H6Fjgnq/cVJ+EEVXJXaQYFRrdaOd+UYm9EqWxJrUmUFdCFIc3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnImDly1; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70944dc8dc6so1999275a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723442246; x=1724047046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MWXWXuSpacZv3o44AtzQtJipy2mqJJWT9Z6XrKdPg0=;
        b=jnImDly17Q+OBB4web6518yUwabbxcwh2tq1kL8nnI7jZqGpv3H/iagHWRlQRx4pFj
         hypNhtCLiNczja2FKps3STVB+CFz8KzHWV5kTaSlOPsN24YFY1RyrbfCKgUsbcCJ6lwG
         m8LAFRIJX9g9UecNNltpH1iJgEhS+firsAIbtnVfffI+f+aZru3bTlpvOPBpSAM2rn24
         VcUJvamG6IldXtOtTyX+Lt3og5PlqDnhGcpN1yXPuflXoY0UTGdN+h1jfPk+QStt3zJe
         X2LhPi/wZ/f2qRnAG5XER4q418PhCowyI/1wOb0pi5EMp+TSwoa86yh/FiZr+MQHkXYz
         VyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442246; x=1724047046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MWXWXuSpacZv3o44AtzQtJipy2mqJJWT9Z6XrKdPg0=;
        b=YSba1tNfxo9FUPzw+vPx+0s+4YiUQQ2mAN2RHCoNRo9U/V6rp42ydMRSQYMRQ3J05k
         My5ThYPVjpwIqPh3jQvYagPuNf/QuEfTgMJLWoS6xcdebcUNs7FEkivFVQ5QRAhjzj+X
         ShMeUjSJ4U1yDYbdlW+EXm1kAgUzZLQGJLrTq6QIyWeZhhD05AgCrCrw3CI6vgCC/tBw
         jKcqSxzH7jmDti+uJwinbn0VNgdpj5lacD6IdLCZ6mJD1/otq9+ymDNhkD92GwSSKVnm
         jpndykNKFpNu8mBEYJYUWMvNQpOK+/ybAkZw469WXNQv9rftXFjmw4fG3T0AyIG7rCUl
         OwuA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Po6fOiqzo1hg12BIlWtwCELiexDjPPFCqYMeG/r1SV5cZy7JoVsG8QAAr7MAtWs1ShZOx4Ihq8AfHyijtqdjV6IHnjFnfvy0ferK
X-Gm-Message-State: AOJu0Yx5bdqTlJNcqMEvmHCNfGKSpR/4eo6odN+jV/IBQwbNja3cN5fK
	cKf/8jO76B1IvqNF65RtmEcTrNc/nrihXFhDgBEZ5CWPSBexNMqPunKcpyUnmg==
X-Google-Smtp-Source: AGHT+IHf/t8INFWtWT3kvCRMB5XYPGEi03o2KU92mgIQHoqs0qXKGXuZFLtVFW5IrvsyhiP2/g0lwA==
X-Received: by 2002:a05:6830:6417:b0:703:6ca6:27 with SMTP id 46e09a7af769-70b74731bfbmr11376167a34.16.1723442245724;
        Sun, 11 Aug 2024 22:57:25 -0700 (PDT)
Received: from localhost.localdomain ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe3cd6bsm3507702a12.56.2024.08.11.22.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:57:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for PCI native host bridge and endpoint drivers
Date: Mon, 12 Aug 2024 11:27:07 +0530
Message-Id: <20240812055707.6778-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit

I've been reviewing the native host bridge drivers for some time and would
like to be listed as a Reviewer formally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..3fb27f41515d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17616,6 +17616,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Krzysztof Wilczyński <kw@linux.com>
+R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.25.1


