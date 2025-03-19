Return-Path: <linux-kernel+bounces-568435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31872A69569
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C04919C7AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A791E32B9;
	Wed, 19 Mar 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVmXWdKV"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6C1E9B02;
	Wed, 19 Mar 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403000; cv=none; b=vF3Km/HljZtNPULUgzJCIf1T5vvl3ek2qnHAUGJ2r3gCuS0p5jy8yZ2YWVhTAE0rXUhjNw7o7h2zrhs4spFmvLHPg4DBgcBrMrGycN27x3BN17mot4VnIgd9x2pzGXt62zT5IzRe9VqPhTfJcpwAmC43BwE79dhfMv2oNyP/mZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403000; c=relaxed/simple;
	bh=fRj+HqS0/z/8bGgHjoodt0B9Ir0h5V8r9zzaAzc3/NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0hMPZba2+hTvNwtmTgHV3hq0ReEOmU4v/OR3JToyUgEehkgzv9FM5ekjn1zNePZGbQZtvd9hL0nattIVNztjetBhzgYmSb8rdtuMC9I9eMOgsHjgflcbvmiikm/ajfxIk/cfQ2A58wznBYQY/GA77u8n4P7upRWZ8WmvwshwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVmXWdKV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso8938487a91.1;
        Wed, 19 Mar 2025 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402999; x=1743007799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMF3mmtUwmD4khm3oKxn+aJ/nnA528F+Soa/iVE6C0c=;
        b=PVmXWdKV6gt9d428wREtgQZgqpmITUEJiZvQbdP7HWxdogEWSXsasT7LmLP6S1YFMC
         ecoAyoHMF1DuT6T5H5loPcD5dce6d/WlKItjBHvdYni4qUcd4RQhxhr39eUAvvez6m8u
         M2U5Gn3FPUryMoxmVYzR2qvlOXZliSfnu9GUJmaDBUtGkrN/rTDemHW8YAd6ht8fxBpG
         EVSL+9JLgyBe3AnorNRULVOKxdnIgFeF1Lf9J35p980Em2Lv8cR7EEgkyW9G/+L/fRzs
         tZ7i+urzr8Vj7Ga+FSC9Itt9qEI8zEznbPlg+MUsnM0YwR7RubDVEKyt/Hfvd/9Z9nlv
         WUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402999; x=1743007799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMF3mmtUwmD4khm3oKxn+aJ/nnA528F+Soa/iVE6C0c=;
        b=tVX8kPKLjna/BlgIaFD79ZJFzgxu91Nqgg/W37rh1dxRWo2SjC5ZcvWdpmAGuwzxFh
         6Jqr6ddqZ3NtobOZieDSrWxox3eukoNFsnk3WfufH1xKlM8HZNRYIqJSPks2KYqAxqZJ
         /WfZfxb/yeEl42q+9bsYpf+cLFS2p54r8x0j9onHEwHXFwPL1aMH42j+ZuEzfF0Tw8uL
         IWbBFYua1BqxjCtfj05amgUVwFHWwZCksKzlKgDKqhEbyM6zcCZfNr20uScLoqTNMb14
         FCyw1Eyz2b9bB9QFQ9is3N7zffWa7ZDzDQu1BzVYlFqQ6oXlg7iEJNj1hb19SrAuFICW
         NYAw==
X-Forwarded-Encrypted: i=1; AJvYcCWFtTb5Ox94sxewiBgFy5QywOlxVItHsPeyj0TCb55c+34aEeECrY7ISMJrZqwMKSe1o7/Xal6Itl0xolU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sTtCvb0CzL5iJu3NoeDEkCO3eNMpB2SvWwmliMde32PY9FNr
	gbQ6pQcJb5JFdS5GHVYlNzUzRN2Px/jonSDpBYD2qdnXuFg2DYxx
X-Gm-Gg: ASbGncu3+0DjdPDKON+qP8AlS31240UOPf1JyuNEDagwfN0ZnbjDxy69FHxIkMcHwoY
	TTRhiGOsvQOl5fp28124QvkGEjoT+TacRQTwYFjFpvZmDdOPPEKeb6xU9/uDrWWRyhyfM6fjXfr
	cujLsc4r8f2MfXZdOEuR9UYddi792mrnhWlIF3a6uJ4FMxWm2QQT3iubZirdAMsktSdgggOt4Fc
	HWTFU1UwKXQcB6MUbt2n+ezCDl2TLZszoiyEG419CFWIe4i7bTZeMA2064ou5Zt5GLvJfBhcxXi
	1jVX4Op2lZHiYGvj8WCpFWgGleSayNAaIIaCzI9qY7X1aQz26q3PsWx0rnl90aiJL+xeBKRH3ms
	/bUP44zUxb8kqzfQF2vDm6w==
X-Google-Smtp-Source: AGHT+IGjgiVPyA5L8/7CTCtOk0Zz6PfpxKffD6G4wKCNeDm6lFH0aMgXYouj2+uALNgBvpYJUDjDpQ==
X-Received: by 2002:a17:90b:3e48:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-301bde580ecmr5237088a91.10.1742402998676;
        Wed, 19 Mar 2025 09:49:58 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:58 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:24 +0800
Subject: [PATCH v4 3/8] ARM: dts: aspeed: catalina: Add MP5990 power sensor
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-3-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=fRj+HqS0/z/8bGgHjoodt0B9Ir0h5V8r9zzaAzc3/NA=;
 b=w7NllEGYLAQNI5dy6Ou6SwtDdfHSy9epo01/OneSo4p26+sdl2YvSaKvr8R1wFWhXByeuM1GA
 lbAyblEy76eDZeJyGe1BTHfH1zULojNUw5W6S1DW1z7zIy5h6FzNTrA
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a device tree node for the MP5990 power sensor to enable monitoring of
the P12V supplying power to the fans.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index b9a7654325f0..db999408e397 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -488,6 +488,10 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
 			power-sensor@41 {
 				compatible = "ti,ina238";
 				reg = <0x41>;

-- 
2.31.1


