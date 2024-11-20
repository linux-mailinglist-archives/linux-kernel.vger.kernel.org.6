Return-Path: <linux-kernel+bounces-415898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065F9D3DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F125E1F225BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E71AC420;
	Wed, 20 Nov 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Th4SUrKX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171519CC1C;
	Wed, 20 Nov 2024 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113739; cv=none; b=q0ghFaxaDdsvknGG30cVO+sJHx96ccLbopYe9dwXHSavEHV190+hFERX18KfH9Vq512VBUTPhKxmdLxbm7tSuHGQ8EOhHVuLCNS4HnmrKUkFo7z/VsWHcDXB7xxKWtjfSYJa1ltFKJGt7/f04fMrqFClVbDO07IhBe2UqN2PKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113739; c=relaxed/simple;
	bh=RP1Kw2p90iX6rPtWC67VguSwjjbk+gj+Sj/oC5MsXjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekvL62/UVmy9sCAdfTIhnXHl+rXNE7RXL0vBuOa3PctL3tdSD5RsFv8YLiMkKp75kbMig9Uclg3ImbE7tCqwqwW3fdcpFKkYUCNI7g6PHsVS2STTGTU5RM8kOPHOWTSBZyQGqq6iCJonzK2FC5hlrcAf1IBWd2m3wQmFQc9oucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Th4SUrKX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AKEg6wA060354;
	Wed, 20 Nov 2024 08:42:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732113726;
	bh=h7cbPIf87TwiKZjpYi5GKKH2MYKnXb0GCtVB2i4GALE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Th4SUrKXKt06zhdXslQR+c82QnwJOKZ+tJM63SBJnCcX9csoKKU6fW0pKEmUFwMUC
	 Y/URflkntpq6AdKOYYfzg+JPxn7kn4kU7h/1RfO0BKsUIYgWls7UUBDvkzTY9/Oeo/
	 EsgAyMhPN7d/Zz+znizGx5M5SvP7VeGIOSwKxbhI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AKEg66H087120;
	Wed, 20 Nov 2024 08:42:06 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Nov 2024 08:42:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Nov 2024 08:42:06 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AKEg6OW006418;
	Wed, 20 Nov 2024 08:42:06 -0600
Date: Wed, 20 Nov 2024 08:42:06 -0600
From: Bryan Brattlof <bb@ti.com>
To: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62l: add initial infrastructure
Message-ID: <20241120144206.e2axrtmg2tgcronw@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-1-4e71e42d781d@ti.com>
 <20241119173602.GA1858974-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241119173602.GA1858974-robh@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On November 19, 2024 thus sayeth Rob Herring:
> On Sun, Nov 17, 2024 at 11:34:07PM -0600, Bryan Brattlof wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > Add the initial infrastructure needed for the AM62L. All of which can be
> > found in the Technical Reference Manual (TRM) located here:
> > 
> >     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> > 
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml |  6 ++
> 
> Bindings are supposed to be a separate patch.

Ah my bad. I'll split this up in the next version

~Bryan

