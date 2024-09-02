Return-Path: <linux-kernel+bounces-310612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DA967F12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812091F225C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835A155353;
	Mon,  2 Sep 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q5mJT3IZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206414AD2C;
	Mon,  2 Sep 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256892; cv=none; b=Oxoy0Fc7uaIRsEkReIgRpmnwoxgZ+KBDk74+I6lHWE+74T6ZIqT51D6DeUMOK1EL758vlr5JvQFcUGpTSFnIBVcWG3J/pTRthd/Cy/BIL2vpPUfkjYa7B7YwG1Po7gkbJP8g5ShuiNYxoDjpxHMYwQGIkbyMriLm/z/p/HHWktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256892; c=relaxed/simple;
	bh=+xWLe79HJXtovBbhxEbMUqo7yFqESUBfMQwTPTUaXIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQtXMBHhxILzAiLcPcicaPoQAuILnY466rbtDP5wNd8sOgPgE2QgawJYJNVFdhbi8ej3auH6kvFEwVvmgmyBSVFTstv385TZ2DGEEvkI5wTSp6VMPHCe+0xZATi9X9nW25OflQU6ss6BpopzFXwXI3CYoOzL7DJq1s00ZHh4bqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q5mJT3IZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48261MH7023387;
	Mon, 2 Sep 2024 01:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725256882;
	bh=oWcmGmN0dTr+q96bgtYcy9wvtwewFH50PA2nGwV8ku4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=q5mJT3IZuVixE9Hiq4jylQgCYdIIwVK5Lrckv1OPLKm/wtjHS91DQRv++mrvHlycF
	 y72XaDkgU/+t7JRe13Qxqnm1yJ0RxHfFGSr3GCKthc9tXGVxkwvUUQAWxweoPwU/Xa
	 xQ02v1HcMXqndfKnjNj5vHFBG23NUdN0+32Wik4Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48261MC2021923
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 01:01:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 01:01:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 01:01:22 -0500
Received: from localhost (uda0496754.dhcp.ti.com [10.24.69.171])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48261LK6116074;
	Mon, 2 Sep 2024 01:01:21 -0500
Date: Mon, 2 Sep 2024 11:31:20 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Update OSPI partitions
 offsets
Message-ID: <20240902060120.n2qj2zkbd6vakoha@uda0496754>
References: <20240830090702.220402-1-b-padhi@ti.com>
 <20240830092234.veog3e22te7qi3ao@dugout>
 <451abe2a-7568-43c7-8483-242a9919684d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <451abe2a-7568-43c7-8483-242a9919684d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 20:38-20240830, Beleswar Prasad Padhi wrote:
> 
> On 30-08-2024 14:52, Nishanth Menon wrote:
> > On 14:37-20240830, Beleswar Padhi wrote:
> > > OSPI NOR flash was partitioned with a size of 1 MB for the initial
> > > bootloader ("ospi.tiboot3"). On the AM69-SK board, boot failures were
> > > sometimes observed when the initial bootloader size exceeded 512 KB. To
> > Why does the boot fail when > 512MB?
> 
> 
> It is a limitation by BOOT ROM where it can not bring up the initial
> bootloader when its size exceeds 512 KB in the DFU boot mode.
> 
> > 
> > > address this, the initial bootloader image has been optimized to be
> > > smaller than 512 KB.
> > > 
> > > Therefore, limit the first OSPI partition size to 512 KB and adjust the
> > > remaining size across the subsequent partitions.
> > I am NOT a fan of redoing flash partition organization of platforms that
> > are already in production - all kinds of ecosystem messes happen as a
> > result. Alternatively - give the 512K to u-boot tispl partition and
> > leave all others as is - this will at least allow people's current env
> > to be retained.
> 
> 
> This sounds good to me. I will let Prasanth comment over this.
> 

We can align things in u-boot level rather than changing anything here.
This patch can be dropped Beleswar.

> > 
> > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 18 +++++++++---------
> > >   1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > > index 1e36965a1403..641236918379 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > > @@ -1241,27 +1241,27 @@ partitions {
> > >   			partition@0 {
> > >   				label = "ospi.tiboot3";
> > > -				reg = <0x0 0x100000>;
> > > +				reg = <0x0 0x80000>;
> > >   			};
> > > -			partition@100000 {
> > > +			partition@80000 {
> > >   				label = "ospi.tispl";
> > > -				reg = <0x100000 0x200000>;
> > > +				reg = <0x80000 0x200000>;
> > >   			};
> > > -			partition@300000 {
> > > +			partition@280000 {
> > >   				label = "ospi.u-boot";
> > > -				reg = <0x300000 0x400000>;
> > > +				reg = <0x280000 0x400000>;
> > >   			};
> > > -			partition@700000 {
> > > +			partition@680000 {
> > >   				label = "ospi.env";
> > > -				reg = <0x700000 0x40000>;
> > > +				reg = <0x680000 0x40000>;
> > >   			};
> > > -			partition@740000 {
> > > +			partition@6c0000 {
> > >   				label = "ospi.env.backup";
> > > -				reg = <0x740000 0x40000>;
> > > +				reg = <0x6c0000 0x40000>;
> > >   			};
> > >   			partition@800000 {
> > > -- 
> > > 2.34.1
> > > 

