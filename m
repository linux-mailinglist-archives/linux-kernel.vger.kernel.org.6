Return-Path: <linux-kernel+bounces-433540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A19E59BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550C6282A69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2521C18D;
	Thu,  5 Dec 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b="Xu36Xfcp"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AF21882B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412752; cv=none; b=g7ysi02pZNNRA5MmnJ/JkfE/j4nXfwYyW5utJ7RyT6Ybs7eSCrBDPem3Sti2RDAKJUUgpspLuZhFcpG9NjSM9Ni4U1VgzBSwtymvn697az4P40YpjcTRsSlgD8RbE2jPJbnU+KMA7ovVwVx9e0jvBmN8Y2+NKEq7Xfle/2hTuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412752; c=relaxed/simple;
	bh=RbLc9FFR8wF5vdi7GcDZl88v758ckVMZlXxdmckY0ts=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jn6bcmqIfskKUwgba4p5K3IxtDYBeRN51fm+XDEBkot8MHmGv/VHWjiE+9RMKXnnO2jeTM4hb5hjjUFFERnlHjgFjUFDpW63l0ddzYkUIDu7rjAfVhkdCYmVg/DBgQyH0oRXfrgtu9dXeWUcIogDuIM1g+/uYf2wQ+ldzxlcn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com; spf=pass smtp.mailfrom=cornersoftsolutions.com; dkim=pass (2048-bit key) header.d=cornersoftsolutions.com header.i=@cornersoftsolutions.com header.b=Xu36Xfcp; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornersoftsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornersoftsolutions.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e71d653fbso586341fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cornersoftsolutions.com; s=google; t=1733412749; x=1734017549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mSVWv3kzGyP7Ixr3DcJKWQ/Cs0NKKVxGUdtaJxvtNOU=;
        b=Xu36XfcpVRRV/h73WFcs2W1seMy/Plmi46O0rOsIZdXEqEX8eiejQMtMZWBMoVD+5M
         4HsR+/rN3KDMauytsqMFzo+aAipi1guI/Qyqm/2zaBICtkqAX45FF7690UqzUQDlbqQE
         Svy+iH7nUS8ezrBLnU/2+h/Z1BHd3Z8Ejp5MStzvcODrFd0MRKsl7zlEcLPPIU3K0/AI
         IjM8goce/YBwxGnXmOm/HPT9T2bzLXp/CvbtadwWDS5Hf9KsSpEfFvtFEU9ZtpaSPHNz
         0DTotzdCmMV+THSpvouedwhve+0b64cnzYEcOiln51hT/7cLxsO+Q1e9/Hki7NHYnoHH
         qxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412749; x=1734017549;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSVWv3kzGyP7Ixr3DcJKWQ/Cs0NKKVxGUdtaJxvtNOU=;
        b=jhBxgNsMeOieYHJ2hHLUx6xBHrbk2EBMEByp5Tdqnx4u2A9gb+JlIdlDhxUs1Af2O5
         IeJEH/1acc2NrghfNXE2ydh1K+OT3aVr2xAgiEr//dXzmA0BxQVgln7naCNbmyaKa12w
         0v4K38gGREQWoLOgWuOuRH7vl9Bml+uG8Peh5aAp0mHhF0iUwm+HPNXIAKsrG6vWCs0R
         jxzM0uNLVmOFPH5cC15B4xpEKXjWKS41PAoeIcIkJR9mGG0elzC5AKruKKqBFLDrbkGt
         p5wUUIzpNtLKkTGPYCymvZTdYcPXQ5xOzhWkV5T54qxHbrovl6pQLaEwFxJV3HEWfWMb
         fjUA==
X-Gm-Message-State: AOJu0YxNgL0Ow9zaoTzP7uUR2uvPuwCVOpi+tvEhWVGC9t+iJHHD69PR
	ed66KBRBXlR+vDS0pjnpMd4rgtqgvVlpJnT+Yk3hJk96Vd7VVHOoDstqD+dIm8cT6kX6DZ+2K1z
	QNZJe+IVPbsaPP+K18pdafP1JH+LdtZwZg3C995rBbkW1ySIx7iS12A==
X-Gm-Gg: ASbGnctfNmJ2ndr0Jr0PUNRPnOLaQITxbGNkNRXLX7DfIyxhCnVWwmsEoKUlFcE0TZ0
	OaKgLbl3A8zCW6FobHB1E5eTXq8lFpyYf
X-Google-Smtp-Source: AGHT+IEXh3wkarBLzAyKqYC0kT/Y8r28C1neLlKp6rQpRD5NvnZVxaGgz+SOmihpuXwnZlzhFMNga5hrHKjeRZiwzUg=
X-Received: by 2002:a05:6871:606:b0:296:ee2e:a23c with SMTP id
 586e51a60fabf-29e88560c9bmr11677702fac.5.1733412749132; Thu, 05 Dec 2024
 07:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ken Sloat <ksloat@cornersoftsolutions.com>
Date: Thu, 5 Dec 2024 10:32:17 -0500
Message-ID: <CADRqkYAaCYvo3ybGdKO1F_y9jFEcwTBxZzRN-Av-adq_4fVu6g@mail.gmail.com>
Subject: [PATCH v1] dt-bindings: dma: st-stm32-dmamux: Add description for
 dma-cell values
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	dmaengine@vger.kernel.org, alexandre.torgue@foss.st.com, 
	mcoquelin.stm32@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, vkoul@kernel.org, amelie.delaunay@foss.st.com
Cc: Ken Sloat <ksloat@cornersoftsolutions.com>
Content-Type: text/plain; charset="UTF-8"

The dma-cell values for the stm32-dmamux are used to craft the DMA spec
for the actual controller. These values are currently undocumented
leaving the user to reverse engineer the driver in order to determine
their meaning. Add a basic description, while avoiding duplicating
information by pointing the user to the associated DMA docs that
describe the fields in depth.

Signed-off-by: Ken Sloat <ksloat@cornersoftsolutions.com>
---
.../bindings/dma/stm32/st,stm32-dmamux.yaml | 11 +++++++++++
1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
index f26c914a3a9a..aa2e52027ee6 100644
--- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dmamux.yaml
@@ -15,6 +15,17 @@ allOf:
properties:
"#dma-cells":
const: 3
+ description: |
+ Should be set to <3> with each cell representing the following:
+ 1. The mux input number/line for the request
+ 2. Bitfield representing DMA channel configuration that is passed
+ to the real DMA controller
+ 3. Bitfield representing device dependent DMA features passed to
+ the real DMA controller
+
+ For bitfield definitions of cells 2 and 3, see the associated
+ bindings doc for the actual DMA controller the mux is connected
+ to.
compatible:
const: st,stm32h7-dmamux
-- 
2.34.1

