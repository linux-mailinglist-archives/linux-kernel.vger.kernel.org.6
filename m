Return-Path: <linux-kernel+bounces-353761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E442993243
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475FC282305
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0661DA2F1;
	Mon,  7 Oct 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fjeq+Nak"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C461D6DBE;
	Mon,  7 Oct 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316602; cv=none; b=P3+ysPENKaRPbTr/8UU8mUvBhA87VzGprKNM5AMZlkrX4l+tYB3N8AL+jPApkIz0q4SAPiO3W91/JqWzl6npXxqpTgw+0iGuTyaRNzUh/vFqP76VQb3XFUz2FOLiG5dOgZNkafj8koBiorARwf/8j8j3N2WVLtALrDKP2sjkLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316602; c=relaxed/simple;
	bh=BAAmypm2Wp8ggdTRwMnI/KeBZkWEBwMWMDWVLW6Rf+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi/41wFGb1oZDjmFbPF7ZXpwqVwSO9vWWlZu+nlu+nLSUrzz33e4O7xBm68s1/8W4z7aJcGf0NjzGAX1XjxXhUlyV1vzI44XKTMeAwErEqxK5SdV/olGTV/Qh5NOMWgugVa5Juej4O6Bnk4XZ/0ZWdEQ3qaxdb1b3VoWsYuGzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fjeq+Nak; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7D88F22208;
	Mon,  7 Oct 2024 17:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728316597;
	bh=uAtU2I4ToJzDBdBMFerruZCUaBN2qFNGahYJOM+LPIg=;
	h=Received:From:To:Subject;
	b=fjeq+NakiUJVT5F7/Xz70vOYZnOycKcOE7tKEFu7BGMDWR+1rwm7hVI5A7fPe/dBt
	 9CL9MifUyUMa7BwynGKrRpgxkKZikJQKaC/Atkvdl0KYmpVUhrOU1+aO8QTNpqsZos
	 FrCnTEnk6YxoEV938wFn774656/Mskjvx0ISrkMH18yHYCVQv8xEf4OkswzI3hrwjA
	 Xw19vZRKEHZIdc1G+Flm1enQwpjUw672hds8aG5x446B1Uuo+i6+LQGFbAnVE+uIp6
	 MRPOhBedIxX5KWt02np66UPFuTkaWtMfmatxURa+JveZ5u3haubgAFIprSuk6VgWIv
	 4qlUzNVJtMd/w==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 2D1BF7F918; Mon,  7 Oct 2024 17:56:37 +0200 (CEST)
Date: Mon, 7 Oct 2024 17:56:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <ZwQEtXp5Hr0UL_mh@gaggiata.pivistrello.it>
References: <20241007093205.27130-1-francesco@dolcini.it>
 <20241007093205.27130-2-francesco@dolcini.it>
 <172831060758.15259.15265542019562102842.robh@kernel.org>
 <20241007142920.GA60623@francesco-nb>
 <20241007154446.GA726246-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007154446.GA726246-robh@kernel.org>

On Mon, Oct 07, 2024 at 10:44:46AM -0500, Rob Herring wrote:
> On Mon, Oct 07, 2024 at 04:29:20PM +0200, Francesco Dolcini wrote:
> > On Mon, Oct 07, 2024 at 09:16:48AM -0500, Rob Herring (Arm) wrote:
> > > On Mon, 07 Oct 2024 11:32:04 +0200, Francesco Dolcini wrote:
> > > > From: Parth Pancholi <parth.pancholi@toradex.com>
> > > > 
> > > > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > > > host controller. The controller supports software configuration
> > > > through PCIe registers, such as controlling the PWRONx polarity
> > > > via the USB control register (E0h).
> > > > 
> > > > Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> > > > as an example.
> > > > 
> > > > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > > > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > > v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> > > > ---
> > > >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
> > > >  1 file changed, 60 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > > > 
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dtb: pcie@0: usb@0:compatible: ['pci104C,8241'] does not contain items matching the given schema
> > > 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
> > > 
> > > doc reference errors (make refcheckdocs):
> > > 
> > > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007093205.27130-2-francesco@dolcini.it
> > > 
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in *this* patch.
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > > 
> > > pip3 install dtschema --upgrade
> > 
> > I do not have this error locally, and I am not sure I see the issue in
> > the yaml file ...
> > 
> > $ make dt_binding_check W=1 DT_SCHEMA_FILES=ti,tusb73x0-pci.yaml
> 
> DT_SCHEMA_FILES limits what is tested.
> 
> The issue is your compatible string should be lowercase hex.

Whoops, thanks for helping out.

I'll wait for more feedback (on this, and on patch 2/2) before sending a v3,
let me know if there is anything else that would need to be adjusted.

Francesco


