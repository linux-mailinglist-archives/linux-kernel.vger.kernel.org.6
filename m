Return-Path: <linux-kernel+bounces-236484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAF91E2E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB17F284848
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDA16C6AA;
	Mon,  1 Jul 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PsqPX8vP"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B31411DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845724; cv=none; b=or0b3LtZM+MSrwwcMqyvTOWuZd+By9q4TC/WgFvDxYFKu6B3QZdBfqMeUQ2zsZOWToJLmVQwRxNvCGpiAfNZwHMbKfzxakjpb6KhpiBKYJEc8AaUdfMZARrINjTkYilL8JL6RsEo8AWGOCCo88uMr+WBJpmKzWspk4DyxiqD6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845724; c=relaxed/simple;
	bh=Z/bdyZoftiVCCfagCNkuZ38rJuYzaoelbuKQUASnsBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFq5hgEdpLZKJdbysvFl2QAz6Fjpx0Ix6g71lJUvXEDuRpLkzYttjTFF1A4ApoDbboHJPZmGelT6k1TxWicHLdl+G16DX4JabDNAtbGHSo5zTmWwG4d3zjETiX7S/MeOsJpj4Fy4lBS9pWbLRj0OKeSqAWlryTaRngx5CRvoYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=PsqPX8vP; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719845714; x=1720104914;
	bh=Z/bdyZoftiVCCfagCNkuZ38rJuYzaoelbuKQUASnsBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PsqPX8vPZ25GGdilOqWy0p+dvnG/JcQujYygG7FGwstDVMm/BxulWrL0ZNUtJCs2i
	 zs2x7p14o1UpmbL73vt8lQD6pzbe3qpUlvTUmz4wp9GfpGtrQE5909CYkZyJdInGuk
	 YUV861aZTqNyMCZGh5PgX+WU6O5ZyI5Q5E69ESu4D3P5J1fFlkpfS/wOzXIqyndGtT
	 gtUHhLYn9TVIviwWl3eZr00q1ChcCiAc3B1ReL0uuDMjorCosktf5kBSYSYz9q9Ynr
	 nDJrJ59lQoWCQAWauQni+nOBj1Vkw+9juASlM+lsu/Jkrvnmz44j/LtJmXHfPLl4xc
	 s9OusJqd3v1Ig==
Date: Mon, 01 Jul 2024 14:55:08 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <HhniN4n96_JaNG8CoExQV0wVbtYBjetZdyYg5d29J85Cc2mR6RNR8ZiVhIx7OQMwK-kTh_n1g1n3LuheOayxsnjqgvAU-162TYAOb_RmuWk=@protonmail.com>
In-Reply-To: <2024070152-unpaired-trouble-2632@gregkh>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com> <20240624170921.mep2x6pg4aiui4wh@desk> <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com> <20240625180150.7awxiyvmztcuu4pw@desk> <eK0mvc1FJknv3ZTg6opsYgeqRGgQCTFIQ-gdp5k0KdB3EsY-dL7cKmKvsG93qcTKvPQhrjkbRTrI32YK-AqMXcqiKqLetkLeDnn_b5qs7AA=@protonmail.com> <2024070152-unpaired-trouble-2632@gregkh>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 7e604050ebe9770e297e77729a119c07d8472a7e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, July 1st, 2024 at 15:27, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org> wrote:
> On Wed, Jun 26, 2024 at 01:02:35PM +0000, Jari Ruusu wrote:
> > On Tuesday, June 25th, 2024 at 21:01, Pawan Gupta pawan.kumar.gupta@lin=
ux.intel.com wrote:
> > > Thanks for pointing this out, CLEAR_CPU_BUFFERS should happen before =
POPFL.
> > > Below patch moves it before POPFL and also adds a safer version that
> > > switches to KERNEL_DS before executing VERW. This should ensure VERW =
works
> > > in all cases:
> >=20
> > Your patch looks OK to me. Thanks.
> > Tested on linux-5.10.220 inside 32-bit VM.
>=20
> Great! Hopefully someone submits this to the stable tree so we can
> accept it...

Upstream is still not fixed. My understanding is that the patch
is on its way to upstream already, but not there yet.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


