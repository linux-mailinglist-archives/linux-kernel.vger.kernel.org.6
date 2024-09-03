Return-Path: <linux-kernel+bounces-312454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FC9696D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D612280A74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42719C562;
	Tue,  3 Sep 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p26g8Pfz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B262200128;
	Tue,  3 Sep 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351502; cv=none; b=rpnqmPAf8bUThQ9FwxRsby+sZIvLssJ1p3HNrZVep2To7f1LcaFXJPN1IxXRUmAeDQdSut4wrZ7I3fD7cSnM7UpOiKtduKnaeHdPcKymB/Q+6mWBbhVnWVZ9avP4qHIfxHUFAutn+6INwXh/c1VmrdtBSs21SNoJLa5ss7aqxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351502; c=relaxed/simple;
	bh=VOTzLM+uak74pGtUm9YaUPZNZXthdWLwHpP4AI8Zne8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNxZ53/BlCWtdShrFMbGT9BI3BYss6DfgQzjKnXmZFQt+BCtYXUAZqXDhzWEgZrAjD8eTCqzQxAaBv25IxXdflc1q8guCGl5gtZ6fyDeKd5At66rqxnGIandbt+GXMadv3hsCQTqWGBWpm+UgheK/3lTL9v/kQZ0fDjStdRogP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p26g8Pfz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838IBoA050994;
	Tue, 3 Sep 2024 03:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725351491;
	bh=VOTzLM+uak74pGtUm9YaUPZNZXthdWLwHpP4AI8Zne8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p26g8PfzJyE/nsqtOJZoMdrAIRnmSq8xuqOK5djXwvVOtLDag1LL7A6R+t1t2PXox
	 Bg7g0m2PuyuwT+wcFq/zJboSfq+RtwUwoXR4VnpN+vQ1QecFC23JIkC5WlwxG9bBhV
	 bzUlVSAeay+7E2B0/JkKNqyTjYgqwHcZ+JMNi7UQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4838IB3f062684
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 03:18:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:18:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:18:11 -0500
Received: from localhost (nightbug.dhcp.ti.com [10.24.72.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838IANu101599;
	Tue, 3 Sep 2024 03:18:10 -0500
From: Amneesh Singh <a-singh21@ti.com>
To: <vaishnav.a@ti.com>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <robh@kernel.org>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, Amneesh Singh <a-singh21@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Add GPIO INTR region in ranges
Date: Tue, 3 Sep 2024 13:47:41 +0530
Message-ID: <20240903081740.533342-1-a-singh21@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903055733.3483840-1-vaishnav.a@ti.com>
References: <20240903055733.3483840-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Faced the same thing under Xen. This fixes it.

Acked-by: Amneesh Singh <a-singh21@ti.com>

