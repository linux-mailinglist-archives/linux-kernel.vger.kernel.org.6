Return-Path: <linux-kernel+bounces-319486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BAE96FD3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B607B241D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58415855D;
	Fri,  6 Sep 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFcq6rmh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C412EBDB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657692; cv=none; b=QaelwPveR52Pr1SyY8XbBXF3SaRYahwpIedzwWHioaapDeAa23biJvJlcVjMrRNdsHyELzyDEwmt8Xc5nDSG/Lra4Izp7cs3IFjUObmzbVaHFu0tzvoXd8pCE410jVUPO1D7p5CBusXPR5oX4yFbcXmQFnifxMBD2YePn8RhB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657692; c=relaxed/simple;
	bh=77VRHMarnLC9+06pIMqdace4gh0xPmxnyDEd3vRq1Og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eilRosC2A8NIRPG1iTThZpoRjj67JK/va6O8xkb/SjxI0zSxR64uMYcvgCy8ORIqeqTMxD0+o6DrnqgvISkBQuu3LKsip7EjMesevBAaPbfThtMn17B9pL5mty1Alck55QPkNgEcvvLpNmjCCMJ66oGoQwHSZN/Zy3aZrTe15GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFcq6rmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725657688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2atfuylcaHZP18LX2jodStGnvLL7mR/gEGWw/5X3gfM=;
	b=GFcq6rmh46q1Sunn3xbZGnTUMZv9QT0n5whIvf5Fp6EXwLVvIVcaoGPx0nMGVeRj65g/MG
	/w7KxvqLo22xYQt+yJKLIp30LdjvGbAAy3IqgCVF9g1N/nQMlwYSGkQBYiC13GZfE7FcjG
	GIvmmeXztGtz65opnklMIL4L1kQYr10=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-8mhYEbSiN0Wj3swq04-IIQ-1; Fri, 06 Sep 2024 17:21:27 -0400
X-MC-Unique: 8mhYEbSiN0Wj3swq04-IIQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-457c418ddb4so64398071cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657687; x=1726262487;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2atfuylcaHZP18LX2jodStGnvLL7mR/gEGWw/5X3gfM=;
        b=uMefg7pEOvHHtzB+3i5+Ga5wSF7elKhCPSoSCXDTcuvlpcGibhsZbJ8+unvYn3Nd9z
         BDcSJ1aBBdZXHCuyRiM4asE1/uP1ksT3Rgqjsq2Bf7CHV8EUwrFupjKbjOQbaGU7vH5s
         ohxQRtjV5rW8+Mqi3+jzR9A6+WJgRi88aqRJNp1+ZW2UfUPYoZCcPLPKMSk7ygVTOI2L
         Sx1pfzs2z3sEAJLgHUavI7fH1H2bQJu0zuwN6OsxHrxafwIwq/7kMIIi2FtaPIx2a6rN
         Zpc2eAIK9lMal1kmqpL6OI8rsPGutfs52t/VeCzr5bOgkV6zWdr0492q1kb8kxR0oTSB
         CKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5A6Bs1Oxgavax/qebNbppsvR71kV4mhQbtHqF3ordLvHJcAdeLP198nVPfmiiU+1Y/KTd/3/maN+92Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkTF9icUskr+hj8GoqrxHUoHjHMFrtKLqVm5mGRJ113+dCcm/
	9ZJQT0wGFSHVtJJtHFScZ94w3cKZFt0IN8tBTAvD+j7KFcOCN3dIEqEmgXaH0kq6+hSpEBE/IPM
	h2wckEvPqfm7R57yc6gU9Vb6JnB5/djMXo5f7lFsQ6PebSkIFG9WAnJX1FKaTYA==
X-Received: by 2002:a05:622a:1825:b0:457:c4d9:ab00 with SMTP id d75a77b69052e-4580c29ccabmr88764911cf.10.1725657686892;
        Fri, 06 Sep 2024 14:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMTprCBpTPrSboUYqNEADXJxjOqEQuclNrV9ctHChgpiEwkJEV+HkG+vz7b6oBHeYQRHNU7w==
X-Received: by 2002:a05:622a:1825:b0:457:c4d9:ab00 with SMTP id d75a77b69052e-4580c29ccabmr88764441cf.10.1725657686416;
        Fri, 06 Sep 2024 14:21:26 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4581add3a5esm4554791cf.74.2024.09.06.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:21:25 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413 and
 children as bootph-all
Date: Fri, 06 Sep 2024 16:21:01 -0500
Message-Id: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1y22YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMz3SxzC5NiE92SgmIzU0sT3aT8/JKCDF1DyxTjNAODtCRLi0QloN6
 CotS0zAqwudFKQW7O+kFuIUqxtbUAzhzlC3AAAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1

This series marks tps659413 and its children as bootph-all in order for
the nodes to be accessible during MCU's u-boot SPL.

This in turn is desired since the tps659413 needs its MCU ESM
state machine setup in order for the watchdog to reset the board.

This took me a little while to track down, as enabling the ESM, TPS6594,
etc in u-boot would result in the below boot failure:

    U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
    SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
    Initialized 4 DRAM controllers
    SPL initial stack usage: 13408 bytes
    ### ERROR ### Please RESET the board ###

Which turns out to actually have failed far earlier in spl_early_init(),
due to these nodes not being accessible in u-boot. That's hard to tell
though since console isn't setup until later (and for that reason I
think spl_early_init()'s return value in j784s4_init.c isn't
evaluated since a panic() at that point would leave a user with *no*
information at all).

I've tested this in conjunction with a u-boot series which I'll link in
a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
on the k3-am69-sk at a minimum, as it should suffer the same fate if things
aren't setup appropriately.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Mark tps659413 and children as bootph-all
      arm64: dts: ti: k3-am69-sk: Mark tps659413 and children as bootph-all

 arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 11 +++++++++++
 2 files changed, 22 insertions(+)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240906-j784s4-tps6594-bootph-19d3f00fb98a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


