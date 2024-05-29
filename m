Return-Path: <linux-kernel+bounces-194579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD18D3E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003D51F24BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7341C0DF9;
	Wed, 29 May 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="XHAC2Omj";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="adq1corY"
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C661C0DD0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008341; cv=fail; b=FKlyWEniPEwdImt6OEIIvQ2+WjDJDLFOFk/V5stNn7ADXt7zAGqGl6d5CHs53SWrYvpvSE/4Ic0CC0bXnUqVRLJEQkg26XhDLI31t66aNp/SPN6gsuols/gi+pPF0ZMYcxgnii896yY2U/IKuM9ILPf0SMDpqVicU3+upbF2iMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008341; c=relaxed/simple;
	bh=gIeP032JAioJzmq3BqEUJqqimHYo1Cwu40z8ZHp01FM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbBxMzyFHe8Gr164RhR1/8+4W2xjUMbqapVe91Eh4RUHHPE5Ou/ar+/pSfMsa6xjdg7fv+ROKd2rTCdDOXEVIT73KdKgLoxazxYDUuE9opvLlOvjb8MS0al34uy0HsheGlgFgCGK0Vm5Y/GveBCJNOcflAeWDmYeYJR2+cIvpdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=XHAC2Omj; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=adq1corY; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 6FC4048099C;
	Wed, 29 May 2024 14:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1717008338;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=gIeP032JAioJzmq3BqEUJqqimHYo1Cwu40z8ZHp01FM=;
 b=XHAC2Omjyw5oajDy2GKmQfXGAs8zvy+mTKbPZhNAsQznR/sW6EAMwgTnzJIEm7mfMtb+b
 /N9lkPV3os32Y8ECw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1717008338;
	cv=none; b=fNMg57coIDdieG2KJCn6DCaQbYOCx88g07BsN9193hN0bYy66mVLjfUuQ3WAtadOA+B/T/RlMjgM88HFqV+Z8amz3n8Tad1sYc5/VW2t57shs9yQEhX1nnuc0NyHmfabGIpwexLB2LXooNOEDTn05WPEYrfoWctu7oeDCUt6Gc/FbzHrKd8GcgulNiQuqd6ykmhtR0vV0YOC748mFn8is2bimBtdbPyCwSpMJsnbYy6XOKS8AdhNj67llavqPrOS0iw5+d2+JslaHT22j5mYaiJzozCeKB/ebNE0Y+ZBLHhcT/K7wBoEqF/F4SIvtCyokNNuYmlrnRzrxkP64SRybw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1717008338; c=relaxed/simple;
	bh=gIeP032JAioJzmq3BqEUJqqimHYo1Cwu40z8ZHp01FM=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=c2HMc4Rg0acwRx/bDbXKwGNs60JqKwBG7ysy+hYyiT10UOklT2bzAubeQLR7dPhmWTVcs1t2O8OOrBvS7R58D4/JqtBArBYcAUowSnVhmibgx8jdYhx3Bfx1SC9oIemjmGxBpudy7Y6hpaZBpTareoeh6dg049X7LcZA4D78cJLxi9CiZO3zMq23kaF1QZQ7Go2j4LHLvOhnh4BmzWBjhWgyS2diavEnY4DA299fvrOtyoklXpYqDEVe5m0zhyP5YEcQqHvmyhCCgR00ijXFX9WfE+RPsXQdCqudFhvVIAGQk+xJjh9rq9Zh8B0T7LGOZY6grDVWm0QhJMN+J4lFpg==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1717008338;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=gIeP032JAioJzmq3BqEUJqqimHYo1Cwu40z8ZHp01FM=;
 b=adq1corY6yuLlFPivqpxZ/eQkNBuWKZN0Io12sSWuCJh/FCvAFx6TYLVVYXaewjPWLcZL
 uALm9su1b9OnAF+Y6NPv2i8bEoAbnTP68o0hZO9WHClLu8hFByBnmJHxXCVwgDurTInTym1
 rcyJr8wfPltAnlcZz4bYejM4vwRjXyvHQSh0QrQy7aayjAOFH94+VkINmcAVS6nwRA3Cnur
 a1YBj7q+RD6Q+92w1qVrinECHJom7/sNrctUBXe9e0xly0M0G4XyMeE+HAhQmC7KS3JN1kp
 1PBP/PKOTgcCHLzuMQPZ5/+/kAf89wRAGsKZE1Bncsav3WNeJaEM71Jw9ywA==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 50407280042;
	Wed, 29 May 2024 14:45:38 -0400 (EDT)
Message-ID: <0a8085356e59c7f359ec285f28c931d8ba79c3e9.camel@sapience.com>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI
 VMs since kernel 6.9
From: Genes Lists <lists@sapience.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Adam
 Williamson <awilliam@redhat.com>, linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
Date: Wed, 29 May 2024 14:45:38 -0400
In-Reply-To: <49bc946ed3f29b819e3b1b2f91f0c42f07b47769.camel@sapience.com>
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
	 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
	 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
	 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
	 <937e6c6b-7d98-4c9f-b3f7-47e1d6562963@leemhuis.info>
	 <49bc946ed3f29b819e3b1b2f91f0c42f07b47769.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-9pkiRwZlxgHb/IflJGk2"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9pkiRwZlxgHb/IflJGk2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-05-29 at 14:17 -0400, Genes Lists wrote:
> >=20
>=20
> Yep. I will set up luks + plymouth on a (different) machine first
> instead of my primary laptop.=C2=A0

Unfortunately the second (older machine) works fine. I rebooted
itmultiple times with mainline and 6.9.2 and they all worked as
expected every time.

So this will be more difficult and take longer but I will try and find
time to do a bisect on my primary laptop which shows the symptoms.





Gene


--=-9pkiRwZlxgHb/IflJGk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZld30gAKCRA5BdB0L6Ze
21M1AP498PD2dZnoqHf0LsWtF040kfifdJ4KIpnLVxl3dKOwawD/c8D2crW3GYs7
eBY5/b9cyu2Mc8YTS7RK75TeQcYz5gE=
=PbdJ
-----END PGP SIGNATURE-----

--=-9pkiRwZlxgHb/IflJGk2--

