Return-Path: <linux-kernel+bounces-303209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26D96090C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFDD284FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA11A4F1B;
	Tue, 27 Aug 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DSqPvPL6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB251A0700;
	Tue, 27 Aug 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758715; cv=none; b=tKscRrWQHKfNO2AIctmKN7IdfJ600aEsvv77VVGzWWky3I7wq1ThFptylXxvoWcHzl3H+WeCJezwnvqjOHGyxJX3zPYSsPI8NUkIp3Ep+QT+e2P30hW4ihuzz/PBbR3S1MhmDQAVJOp6RYQSh3t3FuWCjpoBHpoh6+0HKW+bZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758715; c=relaxed/simple;
	bh=dd7GC03u4zD6sWkbc0yNJoF1DpIqg49RSl5o/3xbv0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCBC8ZDYe1J61AkIKqJy2BuJfCrYv0+bZ6Q9PMvbRJBqM7uIIT8eF735L9tLVxshB+k2QCIFZVQINsjRn7zNJuPNQD5LJVKY7p3MLFwoZ55YD7lRKjEN6PaEB1MG8dkwKD4vbPo+5dohyvdTzVMIwEa218WSh5gVBeDQElOf9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DSqPvPL6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RBcMuj080315;
	Tue, 27 Aug 2024 06:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724758702;
	bh=Ne2i8e9/XggNwnRBTxhm/c/hQ3msNKLME4hmQWg8FLY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DSqPvPL6SMvu049tykEDClpONol77MYWQWkL5yzVx+Ojus7WysNAybjJj8s9EmW+d
	 +QNDezWdLK1JQCk6QyDpJojoLEyiHl6OUbmzArAQj6nTxVogUWPEXlN8koYjF5WCqA
	 W7vc71xczDcyWWBLDHeopJkHC95VV01w1lIW8fRw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RBcMMb026587
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 06:38:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 06:38:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 06:38:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RBcMTY098250;
	Tue, 27 Aug 2024 06:38:22 -0500
Date: Tue, 27 Aug 2024 06:38:22 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240827113822.y3gyvo6ndwxpzg7z@entrust>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
 <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
 <20240826114259.ynxf5a5qwbm2co4u@press>
 <7ee8c6c0-3e1d-4262-840e-435407521324@siemens.com>
 <20240826195930.c7bylbgu6qma2v3c@siren>
 <8de13103-cd57-407c-839c-843dcedbac29@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8de13103-cd57-407c-839c-843dcedbac29@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:13-20240826, Jan Kiszka wrote:
[..]
> I don't mind via which patches we finally get to zero dtbs_check
> warnings, just that we get there.

Sure. Since we are on the cleanup path towards simple-bus, lets just get
there.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

