Return-Path: <linux-kernel+bounces-178504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DCE8C4EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D0E1C21126
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7A6EB73;
	Tue, 14 May 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NB6HBCBq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15511D54D;
	Tue, 14 May 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678672; cv=none; b=p8w6KsWDpvcM4Mj+ouH6Lb8Y2CIyFxseELOEKpkZeQe5mc40DWQaaUVRdccBHtNOiSUDX2W0RWYbNfEC99LmjegVIKpUbyhwLVtmlvp5jl9m6z11xnFKuSsrORgJtskkmqqNm7VrUZE/yQL80EMX0Mb/3a9eZeNv1pDD7+p8Y2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678672; c=relaxed/simple;
	bh=LZRsjaeOjhT3fc7Gt83pixaiOo8NRAcB+1YSU7d7qjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTmdLFCIMRsXt68vlqzo0wJtCwsr2j8jeejDYORQLR0WRdee4ha0LKKXaXFu0rKVaeBtGjSr/SJVzSA8BUhO32VsnWGDLDnBM3yD6qbGSBnDHkEZ5CuHR4rBTpjjza3eH5VFQ39iuGb2qNj5G1mU6kZSs45jue62+WH0zLue3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NB6HBCBq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OOsY077225;
	Tue, 14 May 2024 04:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715678664;
	bh=tuo0bZ+HCTL63TZkjOA1UVVSOrf1hVP5mRuCUQGpihA=;
	h=From:To:CC:Subject:Date;
	b=NB6HBCBq7UO/pvdNES/3gcnwzgVtHhfSwZ/atZsa4Nk1sEoomScIseJpCqfWVB1Lm
	 k0ABDKb//AY++1Yh81pfhTB5yvkL/iZHeUjIcGO2ZvOdmoDKV7LIfbFasTK4gSu+99
	 YZSpN/px8/9FpOab34WbegGUiENx2xh2flr3cf/Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E9OOPh020947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 04:24:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 04:24:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 04:24:24 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OLp8064099;
	Tue, 14 May 2024 04:24:22 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] TI AM64/J7: USB Errata i2409 workaround
Date: Tue, 14 May 2024 14:54:19 +0530
Message-ID: <20240514092421.20897-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds workaround for all TI platforms using
cdns3,usb IP. i.e. AM64/J7x

Roger Quadros (2):
  usb: cdns3: Add quirk flag to enable suspend residency
  usb: cdns3-ti: Add workaround for Errata i2409

 drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
 drivers/usb/cdns3/core.h     |  1 +
 drivers/usb/cdns3/drd.c      |  9 ++++++++-
 drivers/usb/cdns3/drd.h      |  3 +++
 4 files changed, 26 insertions(+), 2 deletions(-)


base-commit: 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
-- 
2.17.1


