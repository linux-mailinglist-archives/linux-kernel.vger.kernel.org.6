Return-Path: <linux-kernel+bounces-183754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB68C9D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92361C225FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A256450;
	Mon, 20 May 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yacytYOj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FF50275;
	Mon, 20 May 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208848; cv=none; b=sZvQsYonieeci7k2LCQtsUXkTAV2X2T1l8rYJOtGnZMTVumcqRmtuTHeZcSABRu1laWtDtQBfOv32RsR6JkARlUpq29aX9tguCA/Z2LLC7B7B+2cVhx2hQH/mZqF+ZufnMcGMr6fAyoUTGv8AgVSaNWh1tQPh5Sr/mrKyWjU6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208848; c=relaxed/simple;
	bh=0ghm8pQgH/Ie98fFuns1Qo6g1py5XierO6yhGzHAGBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH4IC4hzZPfr+actL5+UHC7k9wTu93keHzawNSr+B6TMLHptWbX6dE4BtaN/5XEeTgDF1CO21jiMNORL2bdjs4E9iujcABXkwcBwFdzDfva7dIcQosxoLv2YR548aXga51u7z2M4+CF3ynw+63wCViJR7IH0NyWoTj4tknKoymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yacytYOj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KCeYf7000884;
	Mon, 20 May 2024 07:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716208834;
	bh=Ta/6dDLVDBDylZDSxMvvq60F/fRcQie13vswtxKmeh0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yacytYOjk5DMrkwI+ZkGMnGOhGWd/SVrsCgbsHpQzS4WIQwHHE1YdoVpXVpdPSp/h
	 iXhXvcYEcppe8+YAu8sGi6LbP2FbNCcjQS1LGXRv5+dv/otGZqxbKkEbCpLNSXgnWD
	 926f/U2wKh+yTbUwizn0bekTQIEzhigFqo9dknCI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KCeY00024689
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 07:40:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 07:40:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 07:40:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KCeYhZ036464;
	Mon, 20 May 2024 07:40:34 -0500
Date: Mon, 20 May 2024 07:40:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Francesco Dolcini <francesco@dolcini.it>,
        Parth Pancholi
	<parth105105@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Parth
 Pancholi <parth.pancholi@toradex.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 TMUXHS4212
Message-ID: <20240520124034.mo5rhbgjsuakxoo7@severity>
References: <20240517111140.859677-1-parth105105@gmail.com>
 <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>
 <20240519202754.GA3334@francesco-nb>
 <469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org>
 <20240520121441.svp6oabjyev4vmih@magazine>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240520121441.svp6oabjyev4vmih@magazine>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 07:14-20240520, Nishanth Menon wrote:
> On 08:53-20240520, Krzysztof Kozlowski wrote:
> > On 19/05/2024 22:27, Francesco Dolcini wrote:
> 
> [...]
> > > If it's not the case we'll send the patch later on, however some
> > > DT files maintainers (e.g. arch/arm64/boot/dts/ti/) have a policy to
> > > just accept DT file in which the binding changes are already merged
> > > therefore I was trying to be a little bit proactive here.
> > 
> > TI? Never heard something like this from them... Such requirement would
> > seriously slow down any work, so it's not really reasonable. Expectation
> > is to post both binding change and an user, so DTS, in case of USB in
> > separate patchsets.
> 
> There is a reason we have set that "soft rule":
> - Driver subsystem merges have known to be broken from time to time and
>   the dt maintainer is left holding compatibles that have not made to
>   master.
> - ARM subsystem merges prefers not to see checkpatch warnings -
>   typically, this happens with new compatibles in the driver subsystem.
> - Off chance that driver subsystem maintainer picks up the dt changes as
>   well (should not happen, but has happened)
> 
> We have however flexed the rule when:
> a) driver maintainer is willing to provide us an immutable tag that we
>    can merge in and base the dts on top.
> b) We felt that the chances of the driver not making it is very very low
>    (typically after 1+ month in next) and the dts change is in the wider
>    interest of the community. In such case, we have to explicitly take
>    the action of letting the patch submitter, driver subsystem to let us
>    know if something bad happens to the PR, also in our PR to SoC
>    maintainers, we have to call it out along with rationale why this is
>    OK. This is a bunch of work from a lot of folks, so prefer only to
>    trigger this path in case of exceptional cases - there have been a
>    few far in between.
> 
> Again, the default rule (driver in one window, binding in next) has

That went out wrong :( - correction:

s/driver in one window, binding in next/driver and binding in one
window, dts in the next window/

Apologies on the confusion.

> kept us out of trouble for a few years now at the detriment of pace
> of merges, but that took care of a lot of conflicts that we had seen
> during initial days of k3 - there are few chains in the lakml list
> where this was the direction we ended up in after discussion.
> 
> But, yes - as you mentioned, send the patches of the "user" of the dt
> binding and driver gives the subsystem and dt maintainers a chance to
> review in the context of usage prior to the driver and binding merge.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

