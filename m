Return-Path: <linux-kernel+bounces-183714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9C8C9D06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A0628251F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF454FAE;
	Mon, 20 May 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hYvHRt5w"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E55337F;
	Mon, 20 May 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207298; cv=none; b=T1U7TcSblaem5IEiFZ0rjEv4F4OeeBYt3M7V7hio3YLvvZvF+YKks5P3sGhyygY2rowMN3/Pq/i09p4dQ9MFQ8HdNU237w+/hMwVFD8rnCFSufKZWF9nTx4I3Q6eMZX++zgyO4bSR/U8HQaBdTT1orHm3we+XcURm6UVyRafvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207298; c=relaxed/simple;
	bh=yyFjEETTLseT7dtN9+rXSzvJfQ09dPUxjbBDMLKEHP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6875BkbklQmpFveUMXL9q+CCeYjtqYUt6/abZ8mg5OB/EhNCPdDKbqAnSUFN4tlbAfdaCUNvwJ5CppXqjFIopvfFRPI2HTsyv5UkHi67oXnvrbNz3fGXrgfKv3JEHC+mIRMIGtOYXqUafxvSL/c81LeWJR5C3obpmnoPMxgEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hYvHRt5w; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KCEgvI125427;
	Mon, 20 May 2024 07:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716207282;
	bh=jqq3vLkhd8TaxcAmaBUSEYP9cRLD6oJAMLwozEckBg8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hYvHRt5wNHzHrsMXSyIAM6G/j8ACXQodgDkxoo7WTTfbC2pHksrI+qrXKfEeglSst
	 qaUKBb6sk56Ost7ziQPAAMd3I8GrQu+p9+PJfAR2+PacTfyT06Z2WPlxSuJ6G+CIfq
	 tKSRKrGa/F1TeLio4Zg/ivA3ofJhcdPrAmuJjscE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KCEgmI091100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 07:14:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 07:14:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 07:14:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KCEfNj128247;
	Mon, 20 May 2024 07:14:41 -0500
Date: Mon, 20 May 2024 07:14:41 -0500
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
Message-ID: <20240520121441.svp6oabjyev4vmih@magazine>
References: <20240517111140.859677-1-parth105105@gmail.com>
 <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>
 <20240519202754.GA3334@francesco-nb>
 <469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:53-20240520, Krzysztof Kozlowski wrote:
> On 19/05/2024 22:27, Francesco Dolcini wrote:

[...]
> > If it's not the case we'll send the patch later on, however some
> > DT files maintainers (e.g. arch/arm64/boot/dts/ti/) have a policy to
> > just accept DT file in which the binding changes are already merged
> > therefore I was trying to be a little bit proactive here.
> 
> TI? Never heard something like this from them... Such requirement would
> seriously slow down any work, so it's not really reasonable. Expectation
> is to post both binding change and an user, so DTS, in case of USB in
> separate patchsets.

There is a reason we have set that "soft rule":
- Driver subsystem merges have known to be broken from time to time and
  the dt maintainer is left holding compatibles that have not made to
  master.
- ARM subsystem merges prefers not to see checkpatch warnings -
  typically, this happens with new compatibles in the driver subsystem.
- Off chance that driver subsystem maintainer picks up the dt changes as
  well (should not happen, but has happened)

We have however flexed the rule when:
a) driver maintainer is willing to provide us an immutable tag that we
   can merge in and base the dts on top.
b) We felt that the chances of the driver not making it is very very low
   (typically after 1+ month in next) and the dts change is in the wider
   interest of the community. In such case, we have to explicitly take
   the action of letting the patch submitter, driver subsystem to let us
   know if something bad happens to the PR, also in our PR to SoC
   maintainers, we have to call it out along with rationale why this is
   OK. This is a bunch of work from a lot of folks, so prefer only to
   trigger this path in case of exceptional cases - there have been a
   few far in between.

Again, the default rule (driver in one window, binding in next) has
kept us out of trouble for a few years now at the detriment of pace
of merges, but that took care of a lot of conflicts that we had seen
during initial days of k3 - there are few chains in the lakml list
where this was the direction we ended up in after discussion.

But, yes - as you mentioned, send the patches of the "user" of the dt
binding and driver gives the subsystem and dt maintainers a chance to
review in the context of usage prior to the driver and binding merge.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

