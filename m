Return-Path: <linux-kernel+bounces-201825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DA8FC402
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00ADB265E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A218C327;
	Wed,  5 Jun 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hdvcUrh+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61735190466;
	Wed,  5 Jun 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570648; cv=none; b=IZIuoMSYyn+OrIaKt8vFZL7xweNGmE8wy4NjLydqYs5Mu9CvxiW9iuVxROVspRpszonsNFc8DT8pnqzHS3rp9BR/vMWXlU0ThFpQOyufj0LIa+1z8/MMoWkweJ+gMt9ql5cKf4Vsw8hBCSE/Vj6n0BciuoHmSANXOTamIWkJr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570648; c=relaxed/simple;
	bh=/r0WB4OrnY3DzA0bEd+9+BuQn8hzAqdTPZfJEJmqX7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTug/i5l70gnOXjW2k2qpQrOgSQlXMqU6BFIs0YM1W9sRcW4VdFEZSz/N/ibQjjaTeiRViSTvfwgu42nhEmDCJomsgmzYV+CpojASMwJGHZL66VuMtNWTy59Y6mFpGXC3P5upyqj4Uth5R+4UKYI8XSPiBCv2516clr9Nl5DX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hdvcUrh+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4556v8XN021975;
	Wed, 5 Jun 2024 01:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717570628;
	bh=F8z9CDLYSSGbbwVtiDL55bOqeVlpcFRKEzsGFT6c6Bs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hdvcUrh+eTTYHK2/mLZTOoBbaQSQGy/m4eIJeGMXsy5ZnySaBZC+6Hqh2GGI9Pjz2
	 T7PwB3qnAswZyRy1h/89C6KVcON4b6PWSoq4IKKanlhhEOv0vKZg4vyPlS+hO0g6lQ
	 XcvwcNhncaJiB+6GDAFvRnmknbjFZ0st1eMWqTgk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4556v8Tf016972
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 01:57:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 01:57:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 01:57:08 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4556v7vu014913;
	Wed, 5 Jun 2024 01:57:08 -0500
Date: Wed, 5 Jun 2024 12:27:07 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 0/7] arm64: dts: ti: McASP fixes
Message-ID: <jzg6fhzcia2vfcayrz6xuts4wj5jmspytpibyqzyiajkc4hkrg@zq53frsxda2g>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
 <20240604133352.GA10282@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604133352.GA10282@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On Jun 04, 2024 at 15:33:52 +0200, Francesco Dolcini wrote:
> Hello Jai,
> 
> On Tue, Jun 04, 2024 at 03:11:01PM +0530, Jai Luthra wrote:
> > Drop McASP AFIFOs for all AM62 based platforms, as the extra buffering
> > is not needed with BCDMA already having internal buffering.
> 
> Is this related with the issue in which after play/record or use the
> McASP interface the system crashes or behaves in unexpected ways or this
> is something else?
> 

This series does not address that issue. This is for general latency 
improvements.

The fix for that is in the DMA driver. We have something working and 
well tested now in the evil vendor tree, will be posting that to 
dmaengine@ in a few days.

> Francesco
> 

-- 
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

