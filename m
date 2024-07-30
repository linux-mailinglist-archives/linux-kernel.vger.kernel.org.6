Return-Path: <linux-kernel+bounces-267441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E43941188
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E231F2379B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53519DFBF;
	Tue, 30 Jul 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A1tsN7JP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC192187340;
	Tue, 30 Jul 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341221; cv=none; b=lmPr5wImBNJsiXpq+1yk8RzmtHGGZvTFXGvqy1ggP9FjahIx0HekPDH+UwCVsYH95WUeb9IV83LzWlMTYqOwD5nSmdUQROoEAynXzcrL78W5Lkoqc2ByiKtEaY/WwvqVHU1+ZghPv7JnGFOpdIwRwdpu8RfW+Az5RnVK2ek16EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341221; c=relaxed/simple;
	bh=y8xxOEV1MPzP24Zs4oimJSM+10NnP1I1xSP9LgsLETM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB520ymEKKmLytvKqvVxtjamPe8xCkeGfzoxxSHqZxXK0xT2kDe005+Xr3I6haZz0gmrE699nyM+sN04F3lVI/7F8PBB1y9x+E7YBCfZGk0jsblxyfuQTdKwhdZFDTBGsi3eTjtr7Wm5+rR1iIgYmYSQ4Rehdhh2nSRR5qgKK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A1tsN7JP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UC6h2V031146;
	Tue, 30 Jul 2024 07:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722341203;
	bh=/byY9DrJChahJalqfXBpV4IySvU47q3wkusXtJjIk/c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=A1tsN7JPrCrVUb8EoUduUZRJD9qt40KLs+LNXwEiQp/fvVdpWUl9fAJKzT0/W+Tpb
	 WS2AfmJ0f2palbcnKljNeU4zMb+IDLfbZDMErAeOqpUY5S/4G5VLA8IkTGe8ohnftj
	 qn6TXjWwdv3Fwx0M0eXxUbiWpow2hsFPTtzE5nfQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UC6hxt027348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:06:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:06:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:06:43 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UC6h30076192;
	Tue, 30 Jul 2024 07:06:43 -0500
Date: Tue, 30 Jul 2024 07:06:43 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Parth Pancholi <parth.pancholi@toradex.com>,
        "vigneshr@ti.com"
	<vigneshr@ti.com>,
        "parth105105@gmail.com" <parth105105@gmail.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "j-choudhary@ti.com" <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Message-ID: <20240730120643.rp2xqo3v6o3jnmt4@scarring>
References: <20240730093754.1659782-1-parth105105@gmail.com>
 <94a0be3616425c7aef7bb0507d60ee11d4776545.camel@toradex.com>
 <20240730110444.fctc2lje62ewg4ob@safari>
 <20240730120034.GA39114@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240730120034.GA39114@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:01-20240730, Francesco Dolcini wrote:
> Are you sure it was not your side to mess-up with it?
> 
> I tested and it applies fine to me
> 
> $ b4 shazam 20240730093754.1659782-1-parth105105@gmail.com
> Grabbing thread from lore.kernel.org/all/20240730093754.1659782-1-parth105105%40gmail.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 2 messages in the thread
> Checking attestation on all messages, may take a moment...

It looks like Parth had CCed Jayesh in response[1] in html email and
that is what I saw in my mailbox. but anyways, no harm done.

Will wait for Jayesh to review.

[1] message-ID
94a0be3616425c7aef7bb0507d60ee11d4776545.camel@toradex.com in https://lore.kernel.org/linux-arm-kernel/20240730110444.fctc2lje62ewg4ob@safari/T/#t

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

