Return-Path: <linux-kernel+bounces-315125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7596BE3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766171C22724
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD411DB942;
	Wed,  4 Sep 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoytOfnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77291DB553;
	Wed,  4 Sep 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456039; cv=none; b=NlTG2J2JXwvk93Q2Tiknot+adIODuDh91bstEv5+p43TyW2eaX80/dkBEmXl66cOVav6O9xn+qoOfSWM7L+FGvQV6Nu03vy9lHDrgP0Eufn0DcpJIGyIb7zpOUoTGFhvUO3t3EM+cFTzNOjtQ5zL0thsMxxh2wYL4kDzm5+7vIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456039; c=relaxed/simple;
	bh=wXXMkNPHzyiaoOtekDBMY5Ahv9yc6m0RbCrnPUk2Y48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz1Uh4vdlQs6y/6rdGI590giTuzzpNPTPUvqW+HHYMwT2h5+uIf+PVZ7sCsgYwmdWGFuq+WZWAu5apYxxSuFn9yye4segn5PQho8LaDPFO4PB9tiXMZyhndXfFEQ90eBtzDFWXV/U+rjdO0Yb6MsebK+aSr3B5ZgueirKCMPp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoytOfnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC1DC4CEC3;
	Wed,  4 Sep 2024 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725456038;
	bh=wXXMkNPHzyiaoOtekDBMY5Ahv9yc6m0RbCrnPUk2Y48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoytOfnPEfjkfIWoq07kolMUKOWCvfzVkVFXNgfirnWMZYWj9JpFbkzzcHGbCpMM8
	 /IsE8vEtWed8ziutxbztS6VC5Z75s2lthQGgL9sO24VwGGKbU/2QI8Sdk0EuALQRDO
	 Jb6iPMfchDkL6xeLk4a/SAeH9Qhe9GIViu233u1ey6fASYZQPQgOgxO4Vb3kIAUZlb
	 PK8v/PdmPEqr5yIqAYhNAkLQ8coALLSXBGaYxmURSqpRbLUwFooDwanYnb5QA0YVYx
	 n4pyqBWj0ee9Pbr9yJGyGUP6Jjjh8nQGCoSNcXcXSFQCu4/FC9M2N6ido6UvsnOs/5
	 FM4fJrOnrJnsA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slpwN-000000005Jx-3581;
	Wed, 04 Sep 2024 15:20:55 +0200
Date: Wed, 4 Sep 2024 15:20:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <Zthet0QqChgGWJAe@hovoldconsulting.com>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
 <Zta6cBq881Ju7r7H@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zta6cBq881Ju7r7H@hovoldconsulting.com>

On Tue, Sep 03, 2024 at 09:27:45AM +0200, Johan Hovold wrote:
> On Thu, Aug 29, 2024 at 09:44:26PM +0300, Abel Vesa wrote:
> > The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> > It provides both altmode and orientation handling.
> > 
> > Add a driver with support for the following modes:
> >  - DP 4lanes
> >  - USB3
> >  - DP 2lanes + USB3
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

> > +	retimer->supplies[0].supply = "vdd33";
> > +	retimer->supplies[1].supply = "vdd18";
> > +	retimer->supplies[2].supply = "vdd15";
> 
> vdd115?
> 
> > +	retimer->supplies[3].supply = "vcc";

I took a look at the schematics and it seems like all but one of the
above supply names are wrong and that some are missing. "vcc" also does
not exist in either the binding or dt patches you sent separately.

From what I can tell the supplies are:

	vdd		1.15 V
	vdd33		3.3 V
	vdd33_cap	3.3 V
	vddat		1.15 V
	vddar		1.15 V
	vddio		1.8 V

Also, have you checked that there are no ordering constraints between
the supplies?

Johan

