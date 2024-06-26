Return-Path: <linux-kernel+bounces-230798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B52918201
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F2DB2883F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22408187568;
	Wed, 26 Jun 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xlMPKyYW"
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFA18755F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.41.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407399; cv=none; b=A0QrUsAg3AdJoL5F7QjNi1NdAwA0xU8gp/b/+HJvpIDDU6niLAAHvA5llyrjiiwVRYDHVVTLBOK32dkSvIF4yWDS+DwzuCh3jY9VJfqaYzcFQKo8zSDFMoBqVr+HibLArMpJsZfzWE629xnOl0Reah0r5sZw/ko/38yLwKm9rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407399; c=relaxed/simple;
	bh=jSOdJ7SFpnohNvKStS8qPaAeKqoHfNSItZKb47fdocU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIgd1txsrTqc9nfc7Ug7fYWtgXgdsIUrWtglD19DkSweHEpXqktPT3h61cIlrRItSncwmsWSku/risrpqm0DGJqnIgDPB176A8jXB6rq6osHfRRfqGxHqqaMH9iY9c2HJ8DXh4iNXdtQUMOLOBlur7f7M4AVtRyH8QlqiN/Ka5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xlMPKyYW; arc=none smtp.client-ip=185.70.41.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719406958; x=1719666158;
	bh=jSOdJ7SFpnohNvKStS8qPaAeKqoHfNSItZKb47fdocU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xlMPKyYWuyHv97zROpV4Px24t/aheJhtUSLQZ2ISL7lDly4VOVdYLnBOUKnun7d3K
	 vhxnBpDy4sSuNFfFKimVQggjgDrxcwMb+/GtV+UPtaNQ7M6gS8oUCMnis0mjHcqC74
	 xdd4qwaB2o8DRhyDBrzDjQTwnGAlQte7MbrYLqOMh0tv1cVR427Vmze2dHFVVnvKDv
	 d3Xp5GRh7dc/WVk7xkyf8v8EcZ2gyyjx55xPXYQpVHdXozex376iV/9Ta6x3NfJ00M
	 7Vfq9iYiJ4jSDzhNZOEHC3VQ8wH7/9Nl93ByCW26LQRe5ixVXAQoz8GONBeBgUtxFb
	 uwlHu/AGSSbAw==
Date: Wed, 26 Jun 2024 13:02:35 +0000
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <eK0mvc1FJknv3ZTg6opsYgeqRGgQCTFIQ-gdp5k0KdB3EsY-dL7cKmKvsG93qcTKvPQhrjkbRTrI32YK-AqMXcqiKqLetkLeDnn_b5qs7AA=@protonmail.com>
In-Reply-To: <20240625180150.7awxiyvmztcuu4pw@desk>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com> <20240624170921.mep2x6pg4aiui4wh@desk> <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com> <20240625180150.7awxiyvmztcuu4pw@desk>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: e72d305d41c831dbdcec3f62e543a6421c02045e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 25th, 2024 at 21:01, Pawan Gupta <pawan.kumar.gupta@linux.=
intel.com> wrote:
> Thanks for pointing this out, CLEAR_CPU_BUFFERS should happen before POPF=
L.
> Below patch moves it before POPFL and also adds a safer version that
> switches to KERNEL_DS before executing VERW. This should ensure VERW work=
s
> in all cases:

Your patch looks OK to me. Thanks.
Tested on linux-5.10.220 inside 32-bit VM.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


