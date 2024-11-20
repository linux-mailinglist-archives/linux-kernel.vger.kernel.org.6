Return-Path: <linux-kernel+bounces-416008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D589D3F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF5285404
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBA13B5B3;
	Wed, 20 Nov 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgILwsQR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A913B7A3;
	Wed, 20 Nov 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116630; cv=none; b=qlFU+cXav0N0lr5TgHQCdkrpRrh3aljGSf2d1BkzlLy/uxRupkdsh+Iy+jysJRNTDKqkdI5B628AjHSSL2cNAVpJhbSJucWE6Oc7RECLUX2psm34DuL12IOIE74VaTFI1rXtlHnLkXQnUnsaMLp/PCQzbgKnV2bV9DNNShCSL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116630; c=relaxed/simple;
	bh=UumTKvCoWe8nSytJlaBvGLfUfcYVew/hPV1H7EckBlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYBeYW2rLK2x2fD50u2ZHdb30qKelFNQ9ZdQIeANnA5oEWdChK+iT7NtR0j8Dmw0pLdk/Ech2OROBe7ehweVtITlhA3zq6pokKLSPK0cAZBwOKIEQpOII4xnGLPCRSu8iKuoNVtqKWv/1UFQ3iFmHSpzoZ1sadhJIBsUqfrcwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgILwsQR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d01caa66so5230162b3a.2;
        Wed, 20 Nov 2024 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732116628; x=1732721428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHLmvHqrIbuv7ikhBl7oZ4TpYm1e0U03NGlJf+tGuh0=;
        b=KgILwsQRCaoGnRyjarRo/gNZnFyZhsjpbVkm60UnvLF7fL8LAefXssxiwvCHpSncOP
         vlDvkpwl5PWvE0B+g9igj0ZycucPto+7NXtsBJMzr8nykGRyFqXDZTN0zq2Gkh/uVdgs
         vqV32qM8hqdzmxV2Uh9muH9pLBpshdBAFJJgh79EoZ6IdLv3RCnSlzDfwb+0ibKH3BQZ
         S6eoI7FavJZpgjlOpTXGmv3Sh9hbevIuswkI6RhsSXBtLputjpca+ZKZSLeL9F1fozCw
         /F/r9vuyLgcXS2KIqmBfgFXD0eeWnvg32z7YvQe+D5cnUQIWJxT20mLUpXE74vAlpmda
         /cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116628; x=1732721428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHLmvHqrIbuv7ikhBl7oZ4TpYm1e0U03NGlJf+tGuh0=;
        b=D6X03Tf6vkCrgAeibFDjoMqjoq94H8aUY0Zvqj7n+G4byWya+q8BoYMCdcGlaA04XQ
         /375jzU4VFOJtI1fGtnZFJPnG3O2AedGctzeWJrB47ho3uWMksW1j4sqxv20LWdYtz8e
         5q9z2XsiubWFmqV7mZ6HC00bocTu+/8jHk7G20kB15aQM7i+JBXgHnxu/jGu+tvlQImg
         Cy5K7EoIGLl/WzPHjNxex962gliWSZaiY3XE41yq6o/y/wE0e8jJHvnXzxtKsGeCqWL/
         KBFf0b4bTP+P8Qkvv79mjQMV1qiz/3LK3D8Fj8G6aBMpz9M+csgk8eI6/j7BtieO7vFg
         b3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS4JU6iUKWpnH52K+wt6loYxrquvZq151cedSeCLs7JdFdJEFGjdSFtDWN2MHYLqsoNq42IoRg+RdJrtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVR4MDGyZSMe68Qj5tHGEUn4Eeva1/43ZLsQldWwOJ+p1MGmr
	6T9eQlpalPKj8qy5NZwjkIo3DaSa3KPL324N+y4UTxoDkSTm18XyC9bV0w==
X-Google-Smtp-Source: AGHT+IFYPo6DG5t3Oq/8L6iwB9FMFXmnhUCMTdPQdxwx4i5UG8Aw6Afuwy295VF/qTdvqHSNf4retg==
X-Received: by 2002:a05:6a00:885:b0:720:6c6c:52a9 with SMTP id d2e1a72fcca58-724bed27341mr3904255b3a.18.1732116627444;
        Wed, 20 Nov 2024 07:30:27 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befb27bfsm1754558b3a.169.2024.11.20.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:30:27 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 20 Nov 2024 23:28:06 +0800
Subject: [PATCH 1/2] dt-bindings: trivial-devices: add isil,raa228004
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-trivial-devices-v1-1-1f7cb48ee21b@gmail.com>
References: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
In-Reply-To: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732116623; l=893;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=UumTKvCoWe8nSytJlaBvGLfUfcYVew/hPV1H7EckBlM=;
 b=ajWbcYhMpGnkHUE9pRvj9ZbE2hKj2Xv8+Z/T7sdVXeAfYAO9Au34Iu8BHwsowo4EmCpwnu8+f
 nQehNui8CkXDfS6FB0nk8TdXxozFkgUoMvvzDqWlTSed7ypt8aWbz2l
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

The RAA228004 is a Power Converter with Multiple Power Trains.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9bf0fb17a05e..aa09dc51dab7 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -161,6 +161,8 @@ properties:
           - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
           - isil,isl76682
+            # Renesas RAA228004 Power Converters
+          - isil,raa228004
             # JEDEC JESD300 (SPD5118) Hub and Serial Presence Detect
           - jedec,spd5118
             # Linear Technology LTC2488

-- 
2.31.1


