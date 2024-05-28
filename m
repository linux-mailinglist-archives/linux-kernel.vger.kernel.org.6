Return-Path: <linux-kernel+bounces-192441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43E8D1D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792E0B211E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E016F274;
	Tue, 28 May 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bK0TBYfG"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6017C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903797; cv=none; b=GRifwkpYTpXZMKaEAsrJyuN+9hd3sBVbocqbRPKKLzwxpPQQN3OQay8+XIUPBcEckCBG8eGmU6rrLFjw6VOfmPY9x5xDPN1cCJrHvHRiF/+0q/7/WHYp0QQWLCP9iGBGRAE8t7xH820Wp4tvZav+lDIzufkyVj3tfXJ3r3++3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903797; c=relaxed/simple;
	bh=vrlJg+gvxce4qVnPpoGhK+rjv8ov8o6eVLj/sB5TAi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuIPL1DgS0HzTT0mtpIiDmb+QHoqZVl5H/MggCLPKKISPueHU7OrWmpksyAnWupwPTUHaK7As5pHD2tq0le720xi6rMB82FxdP0jRkppKSvsy+YUKgI3uAtL3e+sYoexviKSTffSdyGbXmZgDREmHyWbe5oP0S5h6X/YCcfugbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bK0TBYfG; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vrlJg+gvxce4qVnPpoGhK+rjv8ov8o6eVLj/sB5TAi0=; b=bK0TBYfG69Gq6mE4Z1ATMxRxh5
	cD1jn5Ebio45blOl+cszvxPDr8Mr0I1fYUM3T942NiVkYED/yNwm0/0NpAgih4y/fOAURV+/Ze0ly
	kp6r6zMtOWZbovRQVdAiYU/44dk0suMbg4gzamSTaeajiuAlRF04iGOq6q4dAJzgh4Ed8jaxY8fuw
	OFp8Lk+6xZ0dSqututm9mXSOE8YR5iPDaLNoIwpOiciYpzSca6cN2R6QcK72hGXv/dTfk8rMQswhn
	Lq5Q1d0J8mDmK6GtAJ/fj20GvfI1HMTT0kWqHjr9JERhhFOx2npeUMmsiB8dpTQ7fw69sN8zxX4Go
	OyPktYHQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBx6b-0003Op-4c; Tue, 28 May 2024 15:43:09 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBx6a-000KRY-1q;
	Tue, 28 May 2024 15:43:08 +0200
From: Esben Haabendal <esben@geanix.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  "Aneesh Kumar
 K.V" <aneesh.kumar@kernel.org>,  "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>,  "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <56f19120-7ddb-4006-99f6-e1b043ed88e1@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 28 May 2024 15:32:12 +0200")
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
	<20240528-fsl-ifc-config-v2-1-5fd7be76650d@geanix.com>
	<eb911c50-2f66-43dd-a1ff-398a3e7c56a2@csgroup.eu>
	<56f19120-7ddb-4006-99f6-e1b043ed88e1@kernel.org>
Date: Tue, 28 May 2024 15:43:07 +0200
Message-ID: <87jzjevyqc.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 28/05/2024 15:15, Christophe Leroy wrote:
>> Le 28/05/2024 =C3=A0 14:28, Esben Haabendal a =C3=A9crit=C2=A0:
>>> [Vous ne recevez pas souvent de courriers de esben@geanix.com. D=C3=A9c=
ouvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSenderId=
entification ]
>>>
>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>> driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option=
 to
>>> be selectable for platforms using fsl_ifc with NOR flash.
>>=20
>> I don't understand.
>>=20
>> Shall I understand :
>>=20
>> While use of fsl_ifc driver with NAND flash is fine as the fsl_ifc_nand=
=20
>> driver selects FSL_IFC automatically, ....
>>=20
>> or
>>=20
>> ..., as the fsl_ifc_nand driver selects FSL_IFC automatically we need=20
>> the CONFIG_FSL_IFC option to be selectable for platforms using fsl_ifc=20
>> with NOR flash
>>=20
>>=20
>>=20
>> I'm fine with the fact that you want to be able to select it when you=20
>> use NOR flashes,=20
>
> But users are not fine... their memory won't work if they cannot choose
> it (if you meant select=3Dchoose).

Exactly. The IFC controller supports both NAND and NOR flashes. Since
commit ea0c0ad6b6eb ("memory: Enable compile testing for most of the driver=
s"),
it has not been possible to use IFC controller for NOR flashes without
selecting the IFC NAND driver (CONFIG_MTD_NAND_FSL_IFC), which is
obviously not how it is supposed to be.

/Esben

