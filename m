Return-Path: <linux-kernel+bounces-436897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4E9E8C39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7D62818E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40790214A94;
	Mon,  9 Dec 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iJ2PUVR3"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AB155751;
	Mon,  9 Dec 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729765; cv=none; b=j/Df8XiALBGKs1CCsSXuIxxLiCMAHI1zs03N2CZrV0cINLjqOmyVKRbJjujtrnswnKXkShxQqkwE9repgA4E+VPCSz4rxp9T3nmZSL8cXeiCXJ1QGDeF76VLnvo49tTO55Q9lNIrJHOu5UdkBsWBovuyDyUdTBbMV8vF1pnZhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729765; c=relaxed/simple;
	bh=ozEPG5B3x7bDnu8neWhW6s4xV4Fs5uDWi0bVNT4nIeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OV0WsAYmHqTe0JCoCAqWsnqvV+cqctIzXCh2F/hpJXtc/QBnyXHx8dgUBWWjfua07uVZ+yAGmJ266YFtizERXL/hU3kiQVmRzOJYRNxzC6fPhcAdjBAARfLbb514Tu/aBFz09mj0thjBk/Z8kVn4pnX6bhhZYagXUEXUTkeQcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iJ2PUVR3; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 882E060023;
	Mon,  9 Dec 2024 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733729754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozEPG5B3x7bDnu8neWhW6s4xV4Fs5uDWi0bVNT4nIeY=;
	b=iJ2PUVR3rsE1jLme5fJDoqFVTfco0xRCs5MY3C0V6CXK0XcKMDvrVlmkVmwXwxGq8rSOhv
	OzIT0JkNZQSEMPWOa8KWu+ZEvSXM/bWQoSaiPmRg0tFIv6e+uXOe0Onw/O7NgabWIwMEZg
	1YzPjjb3XmRc/vlzqLA0O8tshWlwbRkNLuu8Z5yzAaeAYlZvfW7+TUFbOOYdFMeVYu5nz3
	DbpwSL+omkquGi4VJwvPdRjyFrHAbZl7mF3QK0nBZNwnHg7VnUXZeLT1TQxV2rREAaAfaS
	ZiYnXWM7qeYqDNxSDDY31/Z3iasXkYRthh1Xh5cOxFN/IHP5bgrN95Ypf33kog==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,  "Richard Weinberger" <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  "Rob Herring" <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  "Conor Dooley"
 <conor+dt@kernel.org>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
In-Reply-To: <BL3PR11MB653282E179DA562E3F4AB707A23C2@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Mon, 9 Dec 2024 01:36:57 +0000")
References: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
	<87mshawhta.fsf@bootlin.com>
	<ugcx6muozaven6lolhzpk5mvrt5fncoaahnsx5lbdsaurid4mc@i4qflh2edqnh>
	<BL3PR11MB653282E179DA562E3F4AB707A23C2@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Dec 2024 08:35:06 +0100
Message-ID: <87jzc9mhqt.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 09/12/2024 at 01:36:57 GMT, "Rabara, Niravkumar L" <niravkumar.l.rabara@=
intel.com> wrote:

>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Sunday, 8 December, 2024 10:26 PM
>> To: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>;
>> devicetree@vger.kernel.org; Richard Weinberger <richard@nod.at>; Vignesh
>> Raghavendra <vigneshr@ti.com>; Rob Herring <robh@kernel.org>; Krzysztof
>> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linu=
x-
>> mtd@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v4] dt-bindings: mtd: cadence: convert cadence-nand-
>> controller.txt to yaml
>>=20
>> On Thu, Dec 05, 2024 at 11:22:09AM +0100, Miquel Raynal wrote:
>> > On 05/12/2024 at 13:33:50 +08, niravkumar.l.rabara@intel.com wrote:
>> >
>> > > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>> > >
>> > > Convert cadence-nand-controller.txt to yaml format.
>> > > Update cadence-nand-controller.txt to cdns,hp-nfc.yaml in MAINTAINER
>> file.
>> > >
>> > > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>> >
>> > Looks good to me, but I'll wait for binding maintainers ack ofc.
>>=20
>> There was one, but author ignored it.
>>=20
>> Best regards,
>> Krzysztof
>
> My apologies, I forgot to include the 'Reviewed-by: Conor Dooley
> conor.dooley@microchip.com' tag that I received in the v3 patch. I will
> ensure this does not happen again.

Please re-send with the missing tag(s), otherwise they will not be
picked-up (automatically).

Cheers,
Miqu=C3=A8l

