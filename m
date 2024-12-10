Return-Path: <linux-kernel+bounces-439067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1C9EAA61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA2284221
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD6722F3A1;
	Tue, 10 Dec 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJRtRbwN"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31943221DB9;
	Tue, 10 Dec 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818571; cv=none; b=RRZcXt6hlL0nq8vg/aY64XCWEyIuxTU3mhNMFp2mew0js0ifxOnOUEv9VCR9Jtv/8dp9PMBPPP/jY1CYFjMY/2IjFeUhyvkM9FhZpnHUgMjAV1K5zV+0bfqIBPyDRBMV91EEUplI1txanUAsrkDsUWP/dtwsMRrdNZo7ML2Ic3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818571; c=relaxed/simple;
	bh=tk2H2/9Rd9FiMlbaKp18uxMK91TquZbHrCg7AAVEndM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCKH5pa119qdTBUia7q5u+Rkoz7cvajMO5SXIavF/hg0Z+1O4GYm4IyvTCfhHKjkA/revd5fpbWlD1cDlyJrZNaPvaoy20BcL5wEpMPrplAb4+I1FrQ8nKPjoJpO4U0FC+a8N8cj/MKFi1lRB8bRAYRsvvwozGB3YLNEyscK7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJRtRbwN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87121C0009;
	Tue, 10 Dec 2024 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733818566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRY1+oIIJyoFaLGb5rccCqTLWCowOu5T+fvqY7u529I=;
	b=EJRtRbwN27lNVgeYNUBALaCCuJCmHyaMuPrj0Vzeg8++NRggq/nqCdw6tGqZDV7WS6qvZK
	2y5Y/CnvoEDHF/eJcEdOcM1z5cLFsgh+IsUPQgnBtYQXHPhj4rGOnY0SHu8KiS+oTgg8Cb
	STIWNhnx5JWVj+7cqYRhJz6fK23un8SwiXwTYWELABPLeJoly2tZowQvkhlmgczs+TqkIu
	3WvRXqKCX+TGs++pCigy1MD16UOmxbliDhayogKx/EUVVBmFwN0uMYu1WAQByv0q6AMLuH
	ieNtDCjm2ilnbAETAhpTQzOWgYkcQo8oDTozB/CCg5kiNtj3d+uAWiQD3uIerA==
Date: Tue, 10 Dec 2024 09:16:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana
 Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
Message-ID: <20241210091604.512496d3@bootlin.com>
In-Reply-To: <CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Mon, 9 Dec 2024 14:11:09 -0600
Rob Herring <robh@kernel.org> wrote:

...
> >
> > Our overlay using the nexus node can contains:
> >    node {
> >       foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
> >    };  
> 
> Couldn't we make something like this work:
> 
> connector: __overlay__ {
> 
>    node {
>       foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>    };
> };
> 
> We already have to process all the phandles in the overlay. So this
> just changes handling of 'connector' from being a local phandle which
> we just renumber to an unresolved phandle which we have to lookup and
> replace the phandle uses with.
> 

I have tried what you suggested but I've got some issues with dtc.

If a label is not used as a phandle in a dts, dtc doesn't create the phandle
property in the pointed node (except if we use '-@' option but I don't want
to add all symbols in my dtb just for one or two connector symbols).

The way to make sure that the phandle property will be created in the base
DT node by dtc is to reference the label as a phandle in the base DT.
The export-symbols node references this label as a phandle in the base DT
and so, with that, dtc creates the phandle property.

Also, using 'connector: __overlay__' allows to have only one label from
the base DT to be referenced by the overlay.

I don't know if use cases exist where more than one label need to be
referenced but this 'one label' constraint is not present with the
export-symbols node.

The use case where more than one label would be needed is the need for a
phandle from the overlay that couldn't be translated by the connector nexus
node. Maybe pinctrl because it uses of_find_node_by_phandle().

Last point, having export-symbols node makes some nodes explicitly
candidates for an overlay and defines the label to be used on the base DT
node side. This specific label can be described in the node binding as well
as the nexus node properties.

With 'connector: __overlay__', the overlay can be applied on any nodes, at
least from the needed label point of view without any restrictions.

With all of that, I discarded the 'connector: __overlay__' description.

Best regards,
Hervé

