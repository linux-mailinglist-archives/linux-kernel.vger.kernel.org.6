Return-Path: <linux-kernel+bounces-373412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86679A5662
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D8E281190
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593419F49E;
	Sun, 20 Oct 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpaOAyWm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F25198A10;
	Sun, 20 Oct 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453265; cv=none; b=s5E+Sm78O5JEABzf9+nz36l0UzKbtj/ZZiMw0615Vxizxz3MH97hEAkgVPnlp4jHgkS56uzF2pfsxv+6n2WJTNR2kpQOe32ellSgYhdpcQm+o1QmI8LnFBK8VXICUvIWkokflKn+I9hC/TmJCg0EZD7cyKAjql81qMZPxzH8fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453265; c=relaxed/simple;
	bh=a1/Qj5PyfnECyBhQGnVUNMxHFfa8YJnOAJL12HCmolc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alU3fNwIg02lbzJ2CVKXxYEIDcoMqnB5wOGj4J/g8QTkyhnJWU8fE83Ga8bcy7ijOhGmDSFZEiC/DMFR9fSUtQ6uPEwN9odVRXMdNicz2VY1EcD6PuC3p9HbtTsTupEmdSoT21xy2Mi3bC40uk285Ms7LEG+jeS+lEShf630J9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpaOAyWm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c937982445so623112a12.2;
        Sun, 20 Oct 2024 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453262; x=1730058062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEwkRQKyrGW+W833s7HCmt28islpBcn8PFJwCF+FJmg=;
        b=ZpaOAyWma0AZAEyvoWGM7T+RFjG8llHbBwYiFL5Z/YjKr3zwPMo/UcpIq84i0GMW9k
         ce7OSaEfGKjeW/g7cMOAsjhBq8GUgVIpngxvfC1W45WoIA7v2ZPsY2OUQih38C2HrLyV
         0LVgNkO6pYC+RE1DmdO2S0DO3MY062BiwvE62jKJ1VGmBWiAPGHvRtK316BH4+tgoa0m
         4fPBhW9dpiIrWr8QQUBS6NabkoWYW2riedwW8eYH3Tz+Oolhz+guxh9GkGcYkTC/Wv5N
         uIyWE5BhUfnepEuNntE4SYzbyT7d/cWap4AqAT8A8gNGbVappZSX9+xbeuI+TnP4pyIc
         xfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453262; x=1730058062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEwkRQKyrGW+W833s7HCmt28islpBcn8PFJwCF+FJmg=;
        b=GBCUUCajsXamBUkIfbxvJmxhKAA5oMAoVLSgk2S/1Qv3cync1GjUyCw38P5lWNbBZl
         Hoo83Ayjq/mhW+iNpD01CPg6bEsklmz9XSPUvjSE5u2EJFrkluVebBQbfUNIG+Ka7aEx
         fQi6bh7PRAEGJW+r949PDgwETbEhxn4Bc7L18iFDJi55ydvlpUSlUA89LQEk5qo2NwZJ
         ha4ss+3kyG2z0Gj3T3v992y3SHf0HwBHuM52/kzhpKh2wMTs6+3vA7ABNxRrDouLcKrq
         Y5yOowe+JRLsNZnFkK3XzqBGOLRVlqkCj8+Yd9O/WZYW02+ETtYmrmLn/UsIodMj0kia
         3CEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDOPjEWSMkCD01JcUVVgThWl/c0RoDCYzP3+XFKhncELmtmy8u8TXX4IslL2Wocl8Wkj8qcf9tnPFe6+MW@vger.kernel.org, AJvYcCXt/4vIs+jNSvBe3I63QVTGVgqY/798W94Y1K4a8rfkGiwFZ3mT7uxG1KkN0Wj+32ytlKZwtdWtzCZz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15NhpNS2/e+V1flrwez37VqWPWLBWUFEsM8l3ydT7XQXrdnfC
	Ch4BVVAt0A8Ry+XJfOx2RdsnvXum8+qp8M/zzt8sjbSMrhboQDsJnJ7tGQ==
X-Google-Smtp-Source: AGHT+IEWIfnb7Qu0H6loNsnxp7hNSlxC7WsHLsWBrku4bHIoSH4HVcGWvWdxb/+B/LZcKya+Ni5DGQ==
X-Received: by 2002:a17:907:72d6:b0:a9a:20b4:4086 with SMTP id a640c23a62f3a-a9a6996dc21mr349540566b.1.1729453262089;
        Sun, 20 Oct 2024 12:41:02 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:41:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 22/23] dt-bindings: altera: removal of generic PE1 dts
Date: Sun, 20 Oct 2024 19:40:27 +0000
Message-Id: <20241020194028.2272371-23-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 51f10ff8e..1561f0164 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-- 
2.25.1


