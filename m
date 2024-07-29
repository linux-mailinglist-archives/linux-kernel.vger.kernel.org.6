Return-Path: <linux-kernel+bounces-265745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73B93F57D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A911C21905
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF17148840;
	Mon, 29 Jul 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqJrAdS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A33CC4;
	Mon, 29 Jul 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256468; cv=none; b=H3gD6AYLp/gc+XxBjtHBQ1dAXLhF3TSEU0qrlCi9+0KEwUUy21t5XbUrAbYnsC5U0qdpBuC+sZhT2I8cVZfWLD/UUecb5X8Wj6byrs32S/A17DLFp2YatuyvXaiY3AGi28jeCIUnC1Z3z155yadSNihQb3z4fkN4Lt+1+IeUZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256468; c=relaxed/simple;
	bh=PavqhvHVlbJEIDEC9uRsMhGz0jkAriuyE4XlKY9a4oI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J5mmqS/HcFAkFYQVmWH2fvbNFGygGDcFcXVqizGkq5D36hiuujzQCou/gVgEnOxWD765OGLb57VqZT9+ehwp9FkQTegm2eX7H0kz/ND9sGmWqImIDQVuZt+76qAd00lYiCxy+tkWSTWABgvfQFQANSRhGSoAIvp3mgVYDnFCUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPqJrAdS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aac70e30dso438743066b.1;
        Mon, 29 Jul 2024 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256465; x=1722861265; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGtiyWXludIBCabz0/oCNu77KmtCXJeZr9MMhoo8sIU=;
        b=jPqJrAdSx6/z12/BHME0UGTXzJm9csW186YusZVbtWUw+T7Z4qw0074M6qkeDZVtml
         6epQxge/9DqAonuaSkIlTrtBCo0bPYUX8oG4JUtGQADLPSvQH3Di6bYVAim9Ma5Y4o3N
         yTJNx533FEe1LKiDNiyqzGTF+TltplKgTbEZ/ChRL5/MJI0NAMcoUwx7GczBp+oGUnwK
         Xhw2IgR7iiSf9dH6Xv+UbVDmcLECnt/RZeD6z7Z0lWMpIr/P2SfCoKQMYT60lu6dUoCx
         YneLGml3JUT/mzFlgQWYDjZuUNM1jyrBzH0C8kjJeUH0VlB7fqcxPAUtUSNfHYS+9W6p
         NicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256465; x=1722861265;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGtiyWXludIBCabz0/oCNu77KmtCXJeZr9MMhoo8sIU=;
        b=OrgFRYemk7DNZnxnDf8ARrfPdJwYfc5xiLBcxTOVFN/UeDGKDAy4nFFANgC+06ooHB
         obs/sNoe7DWzuCstpuCgSmwd6NmhvGxrn9nsXcYxKVLu5a0I3EBJyS0+kikFWXaY4Rd/
         URi4+T+H+h/4sPbuH8ZOjLESsNP8eSUC2MDDS4YkZ8Bs6VBDeXr6gxKEhKp5aWSoo7pk
         I5aSchdOA5rcv6JCOgb4Gkx+uMKFjAfNQZwyiwSLj0AkIE1BH1HyenhCy7OEejdaCA2K
         h0bK60N54ilCBi8NDMg7FcyHyqmFUsTBIKQohfLybCUSzDNtANsfb/8HSXfKPabagltf
         /WKw==
X-Forwarded-Encrypted: i=1; AJvYcCWqO1co9RgYALEP+UBMVmyHzmMlnzheIqyOVhpJc+iFxuxpyeZS9ousetJlDhvKwrQHmhjsSfX4oN8loGHpjmB3rNLQSM+PoiTqSxDIExJggToyCUoQID8SLnkDIgbr5mcICU5zRLcG/g==
X-Gm-Message-State: AOJu0YycPonJNDwfvk0knfirpRA1OHIqHYnXPcpunU6gcHHzFuP55ZGs
	Cy6LMzAwropHplhWY4TjAF5lVi4Lr7/6b97moyfGBlk0WaJMHxyp
X-Google-Smtp-Source: AGHT+IEbbR/80fZ9Nj80KZ0baupqap5mu2p0AHvA22M2lKTzbqWELhoWcLVB7e5PmIHeJBWX+BMqhg==
X-Received: by 2002:a17:907:874c:b0:a7a:9f78:fef with SMTP id a640c23a62f3a-a7d400dc3fdmr562278966b.45.1722256465196;
        Mon, 29 Jul 2024 05:34:25 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-159-154.multi.internet.cyfrowypolsat.pl. [37.248.159.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadbb910sm505313366b.225.2024.07.29.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:34:24 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH RESEND v2 0/2] ARM: dts: bcm-mobile: Split out nodes used
 by both BCM21664 and BCM23550
Date: Mon, 29 Jul 2024 14:34:19 +0200
Message-Id: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=PavqhvHVlbJEIDEC9uRsMhGz0jkAriuyE4XlKY9a4oI=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp4xOpX1UkkfLWnYcuSXYtG2/bew5YaK64Rx/0
 /mxOrNNnWCJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqeMTgAKCRCzu/ihE6BR
 aDtvD/991Ym/RDAMQlWk1hoeReQYdJPc/+A4vD+5s3rYlOwRLJ27JAtghjmXDYArIxr83ZcVcSN
 FEKkfPm3sbiJAO1zmOiVlaGlDXZCAHPKdpD04V8tJSKJtiFn/im7qG/AuESUigjTPBH9LDF56ot
 2YZWNJhGbWOgRDFwuXVMgdSEdw1SMK2NFXk6eZPYN6IMliqlwoM5tu8RIXzXFbXxOPJYbfPoqYy
 N0Owicfk5TrrQ0CT1onnoFxrOXWPjLZ+xP8uuU2GVxnVpVm0YIhR9DrM55d0iUOQjNiXCZjcD1Q
 Ujr/1UGM4H8fm0BWmhBr5gEvbLokAipip5jBWNv6dowOrALded0SJqgmxjUONoQN+uJ+quG1h0d
 uzdQfipv94ArO5O5TvldVCqITJuN7ho4Cj+ERoKVdgiuKfBBVCngMMZCtZQ3WjPf0J3OYgwZ1SD
 YWAlJarLTNirTE5iRFN4M68O/SigNyNu9FglCumCJgy+tKqCb8l7ES1hSOKAs5UUDbH/fI2RwNg
 YIECvRFueP3gQmQsv0voSfPInxR+XgvS/H2cJ1bEhwrZvwqD3jXeiL2SEjD2jRzUUpHB/EWO0X9
 +rLhTwg4tMd5LL6A8mk4LrdqjGQfMwW5HMoSOJ7LJMfUAPY8TnZsNPlFtbCXCUGsS1DPBFIBU9/
 hKitFLk7x7rZPGw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The BCM21664 and BCM23550 are nearly identical to each other in terms
of register layout. This was verified against a downstream kernel[1] -
Broadcom's kernel has "RDB" directories which includes headers with
the full register maps for the included hardware. Running:

  diff --recursive arch/arm/mach-{hawaii,java}/include/mach/rdb

reveals that the differences are minuscule - some things related to
ISP and H264 decoding. Most of the other differences are related to
the different CPUs in the two chipsets - the BCM21664 has 2x Cortex-A9
cores, and the BCM23550 has 4x Cortex-A7 cores.

In mainline, most drivers are also re-used between the two.

To make development for both platforms easier, split out the common
nodes into a separate DTSI, bcm2166x-common.dtsi. This only leaves
the device-specific nodes - so, CPU and related things - in the SoC-
specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).

The new DTSI is based off the bcm23550.dtsi, with its split into
busses. Since it's pretty much 99% identical, I kept the licensing
of the original file (BSD 3-clause). The license for the bcm21664.dtsi
file remains GPL 2.0 as it originally was.

make CHECK_DTBS=y on bcm21664-garnet.dtb and bcm23550-sparrow.dtb
seem to pass fine for me (thanks to Stanislav Jakubek for converting
the bindings to YAML format!).

[1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
 - Renamed bcm21664-common.dtsi to bcm2166x-common.dtsi
 - Dropped model/compatible from SoC DTSIs
 - Moved apps bus peripherals in SoC DTSIs under "&apps"
 - Re-added SoC-specific compatibles into SoC DTSIs
 - Fixed warning regarding address in GIC node name
 - Link to v1: https://lore.kernel.org/lkml/20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com/

---
Artur Weber (2):
      ARM: dts: broadcom: bcm21664: Move chosen node into Garnet DTS
      ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550

 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts     |   4 +
 arch/arm/boot/dts/broadcom/bcm21664.dtsi           | 342 ++-----------------
 .../{bcm23550.dtsi => bcm2166x-common.dtsi}        | 111 +------
 arch/arm/boot/dts/broadcom/bcm23550.dtsi           | 370 ++-------------------
 4 files changed, 77 insertions(+), 750 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240528-bcm21664-common-14064864a4a7

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


