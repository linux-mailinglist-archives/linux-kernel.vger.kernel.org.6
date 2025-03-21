Return-Path: <linux-kernel+bounces-570823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838EA6B508
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53BD486DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D11F0E23;
	Fri, 21 Mar 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPkwgrXw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810341EFFBD;
	Fri, 21 Mar 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542123; cv=none; b=Ibsw5azT9o95rBvBHS1qSDFtZh8gQ2khwTjwAsVOiCSP6Kv4GDrHbqVw0eprMC/4mpngvnvu/8UzpziXlfcQRJry7B5p1agedl/shKz4PsZYP2haV1yZtjjTqvmN4epG/uPvGOWj9dLylVzl4hnG7aT0Yyz132MhicWOyLCaG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542123; c=relaxed/simple;
	bh=5pcZNEUlvboNDNVPjfP/G7Ub2nFpRDTz1Jz2es019M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHcjmf1FI95p5OcVThU2xD6deMuLUbeS92nAUYF7lJaIHylazam3+JCbZO4TmDsSZudXNjLuDBbJ0a9aCvV4cpU8uMaiJg3Y0G+T7G0uaHra0XRJ2s8NDbkvo0xo+CSZ6nNX+mZfQ1TwGAmNAi0SFYyQiu//7xqO5PhkAANOTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPkwgrXw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223a7065ff8so50534785ad.0;
        Fri, 21 Mar 2025 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542122; x=1743146922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieptwck2xbumRisfrT82whFeQnF/qSu7PPBUcK7FiUw=;
        b=WPkwgrXwyQyY16uTOmSJGVkSKFzjGYQ+v4sOgpctJUIqyYgzpuWhcOUVY4ceOPTsLC
         8AeNGhx4ldtUWewSuDLcwxCWN3gr1JLsmSbZu0+wOjKUReO+9mL4Ivu1g15BFAJP7ejB
         i48dNH6YjLNZDYioZR4DzsYTQ+ij/2Q4PbyUNwXnAqlvQkkmnO4aEfVGSmY/36HEJM0J
         G5BRnWAfQYt9jP5uPt3HzFvK4SMwM5tA9l58HlsUDr7XTds3pps9pS68EGC2S0ykLhmo
         giCDF1y0uEBEc+Ev10hRPiRKbaegd0OdB3sX0bkeZ7SIjB3kdUMmAVqb1x6QnTcnrktK
         taeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542122; x=1743146922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieptwck2xbumRisfrT82whFeQnF/qSu7PPBUcK7FiUw=;
        b=I5Jqh5T3ydyDkWtmRR8K2U1G9sYFf5i68KoYpNyo/o97OnsIE9RNIuXzRnt9xaOwld
         iUhvf+HjeoDM1xa8j85Nf+eReA/t3a4DCvy9nPOGCGXTFbdf6IKbezGFzZQMDXMSHrYT
         c1iK/EOt7oXthzU/ENnGPqYL0PksoRqkGLr9C/5MvmOMY08atGCKKNoznWD7kpWnN7qv
         VMHNqKTSPWsN5vXVhgjcIJKECrG2hbll3HpUWLZoFgAjHaGTapwl1m2IaM+Jk+44Xb+a
         2y7IwJCryCiilMiiv516Zxm5uI1SdEClP45lznIESkpljwnnylw+rF39y57MLiaTU9tG
         04PA==
X-Forwarded-Encrypted: i=1; AJvYcCXw4q+UTa1oDqGM7p1sTSIIrpt+rh/Vvps/oINTylP6I/thznX/F24OhMqUESZ5Ltlxoj1rl5CAGq/QFys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6TUYVGcF4uOEJhGdtS0bqN4fFk4m20zuY3PnBy57RR4wdUTj
	gY47eQWnO/bSidsMvES6xxGd10CzTUbWk6/5CuKvYlOj73yAFe5h
X-Gm-Gg: ASbGnctY0VpyGLS4vebmbepO4j38TQXJSdxsVF9Z+UOLF7tgDMrFI6iCtJKck3GKVG0
	g3970E6V2lHnXsHBd+oBcsXA6Kdi75J1BqswhSDgQarwFK9oQME2hXHSAmeN5z2vpYTaCNV4LxL
	C3+cBmdkIQANIj/Lptb2Nb7iV4A56InUUzC2swsliUfFcXf88PsPzbEpYIa9FqNpBlkiKhe1qFj
	QhRnlIw/wyUpUqbYQocsYO8xgp04hiLiX2fzbZ/y/U4ayLGIczMZCO4xTVnN31AbLeBAPhvgCIg
	ojJnHTlGWfYk4jalFpmyIWb/Qj86nCS6Eid4j71EvuP2dto3Nu3VNcrFAAaIYu0MK0tLTTH5/g0
	vb544qcvpd3rzbSjCmzo+2g==
X-Google-Smtp-Source: AGHT+IEjNtFI6VP/om3wHuMPu5o9rtQHBWQ3PoYv9Ejx4ZNfKMN6ezeWRVywDwtXRCBYtYNbqvqmXw==
X-Received: by 2002:a17:903:32c8:b0:224:1609:a74a with SMTP id d9443c01a7336-22780e14a50mr37653095ad.34.1742542121920;
        Fri, 21 Mar 2025 00:28:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:41 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:07 +0800
Subject: [PATCH v6 06/10] ARM: dts: aspeed: catalina: Add second source HSC
 node support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-6-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=5pcZNEUlvboNDNVPjfP/G7Ub2nFpRDTz1Jz2es019M8=;
 b=M6wY+kwMmAqRc2ixbv87/CrMLBRU7CN3BuqLHOdf6m5VlQvPK746/lKcFe0Hctj5iynCwOVZX
 s2cVFyFDJMzDo4NEQ88OMn+gfMFLSNydnqhPvBj9j6NMeddnDJLRHMN
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f0c8aca152e7..306931c08cb0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -562,6 +562,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1


