Return-Path: <linux-kernel+bounces-383654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327539B1EC9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554C91C2132D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23617C22B;
	Sun, 27 Oct 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh6VmJx7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942D178378;
	Sun, 27 Oct 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039826; cv=none; b=uJfAhPV6gpQOMoVBGPgAbnrLLQeD+9MeYDjxDvFg2RbkBT4IR7bhHD50d+drciyK+VcgxVGCgrJIHnuOzRRJPbs+TQ6pg5J1IVeR+eTteIV+UkutGeeZOHlr4yMK2+N/Dzn56H3dqNjxa7+7yhxY3lcy1c0j5cOXg4Z1qacpKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039826; c=relaxed/simple;
	bh=6Qat5CV6Gvn1Mg9L2SWD8nbWS8IHMjd9Ue15KWtpNH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQnEsiBlFc6hZGmx1fCKv6F09EbuAxj9v+9+r2CZx8YAqeDBoIAT9DYXepJvKYTSGso7I4GyAfhDU7DTkeYVpd+xkhhX+pbjW4pIARY/JFMkiW/O4z73TsWYiLHu2KK30CYslZAbXFm8YJB5sYTsO1GXmppJf9cnsoZSVRFURCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh6VmJx7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so636446a12.1;
        Sun, 27 Oct 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039822; x=1730644622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=gh6VmJx70b6qCHMkkTRMKX/83EEVCtfHNxLForv9B+3doRD0kWMane0ejXNfSfDl9w
         aMx7tpP31dt1JVfW02hru8W7nHGpSpuji/3QnE8N6PF78GOnqfTmnMW+eEga4sn2eV5d
         j6rO41oboJbT2n9WKrvNHDCVRtGjEzRRbyX1aCKXfatjHfYGBxJNeWoFOC4IvX/y3Of7
         n8ZIthBONuoFTaz6EJDvG0OJfcRZ8aO3SLM7DoVx5g0g2Sq0UQ/QsnNGnBMl8TTobf24
         KMmsYpsFvn0HAI67hFFiTZR5ZmEwJMVDLY+8fIjfcGK8mOK5L+49mq05efg/wPOwmgw3
         4R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039822; x=1730644622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=bQzMd2eIrEap+wOydSXwITDqU+0ojO9orgZSdrWhhALZUL9Crfpi0cDkudZRrSYobA
         7i3GK/AmVrvstyxL0mDJGKvFprDYcw0hFVWHW8AsoW5QJbOdp4vM0nwmtkNoRhPrsrwH
         9I4QOYL75Xh4AIHLxL6ZtipmOcuOu16kQb/L5N7+LbtldIDduxGKkqAMSK+bPvW0ypft
         sdaRzocuLzRr1zhptS1C2LjcypvMUkfWDON3tPeXGEquiNp0duuvh6sSIvWQPTRcKAys
         cUQTw2FY4ewlP+N73gqxQLgSMjrlSzY35hVskxsyfQa4vU5jcZQgKAcwstXbzE6QzmH2
         MvxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMk4ovMncrw/DjBkFK5El/AuwC/XicYUkG4Ws7HP9kl9nvm+lLUJ0T8qFuvPShTdYCMmtXFEYMERX9@vger.kernel.org, AJvYcCXPbqHuSe/91MFu50/Sg8K+VaJ6XEtxVusPaK+jcN8NERdtOWohlo6SzG0IbSgwtOBXTdPr4y67geeMbkDl@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrYoY8Bq0wfgt1IQziZy5ODp9iVFhLe9KFnLly25tjFwWZV49
	D5DZIQoBrMrXjQ+gohSEgR5v2SScumcY6Tozku9I+cdJgSQuFni3
X-Google-Smtp-Source: AGHT+IFq+/3YqU85y3CG19oXlxAHhroIP4HprkLk1w87pTklDnYhtp9AfWkD6bKNxmp38/H9Ge9JmQ==
X-Received: by 2002:a17:907:d28:b0:a86:a4cf:a197 with SMTP id a640c23a62f3a-a9de5d5f58amr267932066b.5.1730039822400;
        Sun, 27 Oct 2024 07:37:02 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:02 -0700 (PDT)
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
Subject: [PATCHv3 04/22] ARM: dts: socfpga: align fpga-region name
Date: Sun, 27 Oct 2024 14:36:36 +0000
Message-Id: <20241027143654.28474-5-l.rubusch@gmail.com>
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

Binding and setup expects to match fpga-region instead of old naming.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 01cc5280f..1562669b3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -87,7 +87,7 @@ pdma: dma-controller@ffe01000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			compatible = "fpga-region";
 			fpga-mgr = <&fpgamgr0>;
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index aa0e960a3..90e4ea61d 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -80,7 +80,7 @@ pdma: dma-controller@ffda1000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
-- 
2.25.1


