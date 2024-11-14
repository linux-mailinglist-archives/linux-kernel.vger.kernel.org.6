Return-Path: <linux-kernel+bounces-409862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64A9C92A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69742845E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438F1A76A4;
	Thu, 14 Nov 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="aE83gcD8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0019340B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613877; cv=none; b=rAxHmQfSPLjrvQNYMCqQR5URqN047kpZoSsTYN4ELUaKTQ8ZP7lt42x4vTegVosg5PWVreCesYkzNiUyjYiTJrpjooPopkG9V8KTZeIGMd5ghX5fN2WBA1Zi1Ad4sgLrVuXXwmWuI5ppUjCGba/kzbZjnLTezAh4nPHSzlTm/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613877; c=relaxed/simple;
	bh=6Jiy1XQtVz3ggjpXB78+B5kVI9PN3UAJnrOhRftuiXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR9pJrhdCmkChSY3pGznR+EHdaeAjfu3CCWU/saYcjzvuEFYpUQvYy0/GHUxbub3Wo+DXyQqXOqfYla9L7CRtxs0tceMNXEW+XvVPAtBsLeR8FnXtXDEmxYRoSYpXpaTZ9gqVytTrMpuj4IzOq1WHpCc2ke3W4hK84XOzaSIFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=aE83gcD8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1034247e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731613872; x=1732218672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WUtALkjSye65cOuODIzVIJuEmqRgNvoIJj5DWFwQU=;
        b=aE83gcD8CchvJe48ngkmnIKcJV0/Jjm7rZv7IaSB45eNRr7388CGC+YkcQXOq466px
         Rmbum6ds5NDtBwJW3mZcmLf2884IaKngXOIF2JuAsXPqZsZ7jxmZVOBbcSm2WDvdDKFE
         gR7EF6CsT5jMrBncc+FCWpXUFpPUqoVuyY7kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731613872; x=1732218672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+WUtALkjSye65cOuODIzVIJuEmqRgNvoIJj5DWFwQU=;
        b=EismZyokph0gDhakqDKt88iX37nRrGY/o2DkQN/t9mjIFrPINQVn2JsRi/az3GUnWG
         5ZQV2c/iGwgtK74v7T4VWfhzLcISHKV3v+KEDFPFDqay9AK5nyXEvFYJuxofKFv3PqgG
         GuXWnf/4DfyHc8rXuWFLF7z/MavV70ts3xHexvHXX7wz7EoQNFGu5+FU/lRGnGJmNoX8
         qy8r4HqxqN0MBp6Xf8kFSCJpmbfY9iScYEml8w/UirAl34xacLrSMazz1T3H88CKQsf+
         dcdpPr3XMKbKYPRuV5VV3Hti79lFiNj07DKNEBD8t39u4zfshoscM9YVVqnmzlvrDJO2
         c0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFVm/TFSwS11HlcLNuZn94zxVn4ppYpQ+XAkNBCzPbIQML5aosx3BWCHi/1wpw6Q4HNvNXlNb65f256k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4G2epLazMAelFdBy/XW10yP1D7LSC/mIDqFFiCYKmLBqU/3Q
	tACyc3YzOp8sypCQH4vS4/0ExBlhK/U92fMfpjcVjQF4aVWKdfUvc0FI6vvn6tA=
X-Google-Smtp-Source: AGHT+IFJYFAKSN4vXxLSb2DTOieOWfQk536o625a5AAAchNjruC3YUkGAlycamJngjPvHpRkjvBljA==
X-Received: by 2002:a19:914b:0:b0:53d:a4ff:317c with SMTP id 2adb3069b0e04-53da4ff3214mr1588261e87.43.1731613872230;
        Thu, 14 Nov 2024 11:51:12 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530d81sm288780e87.160.2024.11.14.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:51:11 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: pmenzel@molgen.mpg.de
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	ernesto@castellotti.net,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	tore@amundsen.org
Subject: [Intel-wired-lan] [PATCH v2 0/1] ixgbe: Correct BASE-BX10 compliance code
Date: Thu, 14 Nov 2024 19:50:46 +0000
Message-ID: <20241114195047.533083-1-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
References: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code in ixgbe_82599 checks the SFP Ethernet compliance code
against IXGBE_SFF_BASEBX10_CAPABLE to determine if an SFP module supports
1GB BASE-BX. According to SFF-8472 (section 5.4 Transceiver Compliance
Codes), the BASE-BX10 bit is defined as bit 6, which corresponds to a
value of 0x40 (binary 01000000).

However, the current value of IXGBE_SFF_BASEBX10_CAPABLE is 0x64 (binary
01100100), which incorrectly sets bits for 1000BASE-CX (bit 2) and
100BASE-FX (bit 5) in addition to BASE-BX10 (bit 6). This mix-up causes
the driver to incorrectly configure for BASE-BX when encountering
1000BASE-CX modules. Although 100BASE-FX does not pass the nominal
signaling rate check, this error could lead to future bugs if other
codes start to depend on the incorrect value of
IXGBE_SFF_BASEBX10_CAPABLE.

This patch corrects the value of IXGBE_SFF_BASEBX10_CAPABLE to 0x40.

Changelog for v2:
- Added Fixes tag as requested by Paul Menzel.

Tore Amundsen (1):
  ixgbe: Correct BASE-BX10 compliance code

 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


