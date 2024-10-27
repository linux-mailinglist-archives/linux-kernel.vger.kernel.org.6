Return-Path: <linux-kernel+bounces-383657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6B9B1ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FAF282071
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBD183CD6;
	Sun, 27 Oct 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWtNCt7C"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E87166307;
	Sun, 27 Oct 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039829; cv=none; b=P3Y+CPh8BaYIbIDMhG9183VUDsZRME/JK/qiddXtAnZPhVDEeaItB8/VLLvDzI2aCwxyHi5tVlzkISR5DTmoNEOsc7i6msE4v9ShQLlLqL2QSh80xAHN0UBYYR77+H/qjdJEfTiLWGy5P8A0iBzrULEgdC/mFb7Wf4s6gf0xOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039829; c=relaxed/simple;
	bh=1KzJp/fai6aB837Tp2XCYOTjK4FVSS8lCtpXFfw4Wj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gL7TgkSGwl7I+eZJbPhC+n6THaJ6MhJx0TabH7CzHewlYF6scatONeYSXA8cQeCxX0ZlP+X1UEKnEfUlmvrpGVNO0Ojj8aYQrB/liLlf60i9yll65ebZ9w3XAHEZSgiMieguU8SykCHDOlhMyFXtcM+wBJif//gGpwEh2P2j084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWtNCt7C; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c93346dfc8so439942a12.3;
        Sun, 27 Oct 2024 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039826; x=1730644626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=EWtNCt7C/Zb8x9o9XBO4C8pf5wPK9o0ENaQVOIMBYnFetJfEBS6MfW+YdnZlETFgct
         6QJ6eyTa7Sy6LlTGw1Pt+/dXecYhB2jWLO7ixGq1mxJmrSf8noR5fpBVlGhyO9RSfC3F
         2u4AWtE5q+O/a4vvs0B2hU/rcaudzLExBhKksekCv2PRn6c+vfMFIqJqPfVwNmHQp03v
         sJhBrN9irJaKzzXb2TgztMnDaNPcE8kfMbkVwsTfi/1JY/AhukbJjTumvqvFXiK7QzNK
         KKPSJ7iSe6raNkUjutqyqfHQ19xZTrHNRO68g4X/Vwp2ViJyqpMyyNuScSPKw0MQ9EMi
         r7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039826; x=1730644626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=ElGG+uZn3gfeNOfddL19kGiUtMW8ERy4m6o5CDyE0sY+cKFN9QbBISuHVn8uIsxvnQ
         qbJ2tOBK9oZ7+pUTHc/ApL5uawvkWLw8JzgxE2t2Jzg6oVsmZb4ETLls0CqJ4pCLsBPJ
         CWkpyy8vxSHjvExdLcOz+1zqpGmxOc3gACIeGAmD9gpTqvJCS8f+eQHYHj6MaIVys/vH
         vqq8eTnb40tBGpj7uxPB8qR4ndgZphyu9zknBBsUWDWbpvjlWKxNqMvG8ZJZN1BtEuoq
         Qv6IcuJl6xcYJ4vAFxMqO4sEl4w0QPz1jToTsahPl4RfHX6NTXr3YjYj5Tsfe/aKJ5iq
         dYxg==
X-Forwarded-Encrypted: i=1; AJvYcCUSVM8L/y5cO+kD0JcAzftQhKh7pWyUsxziRMatjaCOwvjtGTJuL/fWnhmMpZiHxO/dIEmSBEVqblwzZqMA@vger.kernel.org, AJvYcCWr9Q0YTrTM+BtQW+eaSL29RZiKOzOp4ak/Yc+RxcK2cvtu3cet2cA65+whNbtfbyU4LKOvVWkM6/wi@vger.kernel.org
X-Gm-Message-State: AOJu0YwQT19BxWwFweYy5XbGo71LpBhgREHAdPyV5JWZxlOEsbZFWrgQ
	Vd1d7pneV3aWffrSWG8alIOC9LzzNrsXyQihoa/UGmPYr6ihuJO99izPmA==
X-Google-Smtp-Source: AGHT+IH7N+ec9fuWlTgo+hObp1OYAFN6tl1TIuPS2k3vhGrnYICKxluiit2A4Irm9+Hg7SIh2zYp5g==
X-Received: by 2002:a17:907:74b:b0:a99:fbb6:4956 with SMTP id a640c23a62f3a-a9de6175f57mr254372566b.10.1730039826379;
        Sun, 27 Oct 2024 07:37:06 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:06 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 07/22] ARM: dts: socfpga: fix missing ranges
Date: Sun, 27 Oct 2024 14:36:39 +0000
Message-Id: <20241027143654.28474-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reanges, since by dtschema 'ranges' is a required property here.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 4b19fad1e..65d04339f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -81,10 +81,10 @@ pdma: dma-controller@ffda1000 {
 		};
 
 		fpga-region {
+			compatible = "fpga-region";
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
-
-			compatible = "fpga-region";
+			ranges;
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-- 
2.25.1


