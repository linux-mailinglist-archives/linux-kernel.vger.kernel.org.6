Return-Path: <linux-kernel+bounces-336085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246A97EEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3191D281706
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490819E964;
	Mon, 23 Sep 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nb/PCPfG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED6197A8A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107871; cv=none; b=qYnFPNiAVbFweaJE5pfxtPoJahuEJ34Tuh61fXQn2D3BsyCB5+truiombivDedwwQpoIgCa0jyuwpPZE0pzAxrfm6KLBCdwUWsJHFbUq0xAXuXF8O8mvFQDKUo8wNW1JI5AMmk/ieK6h4i1lgBDCJeX4hT12CAASi/wh/jqNiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107871; c=relaxed/simple;
	bh=H0qQM/QpZlzFIJDKYf5nR5cykF3LyCuPz3uQnKwfl8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bxqpJuyTLS1eRGi+FHjInuw3F10TD9PqdKARzKJb40MiWaoIomivc4Ay5ZqaW/5bKYjn3O/1qU26d80ZWNr9OEbpI0nRsxtYFBy6yopd8CgMq022lryx2voByLRZyRK6fiQG0BFMFTzOrI6lGQcKKNn/3O4SKBnZhlOfsgjrvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Nb/PCPfG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A2D240E021D;
	Mon, 23 Sep 2024 16:02:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eY01NWPrd9CF; Mon, 23 Sep 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727107355; bh=cY4lWJG4vLdBW/vBl9oCJ0OXT+42w3dInHnJUip1Axc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Nb/PCPfGFZJytmlp9vQ1+yPE0VT+qfQd1qjrAjChGoAx5EQa8bdhxQ9VhIfQpavTh
	 L3Dqbp5RGoOauK3XSKNxMzEhj9y1VaW5Gj/Uu5l4DwfM3SJQ9bjHE2ly90AdRFxRh0
	 Ko7mh766HGiEPtEr4eOzGh0mpQNkP3mp8vL5OTK6sHWyfNnElvyt0R5RsKU2Q+JURp
	 4yDAKjl57hqbJyd3aDR4HI89sXoXU9KB3XwAz8I0MQbD0UjnwYrPTngttd0xS2cLg2
	 a8yoRihEyOHG9slhuSsaZugi5nG0mTLXJl8K+5Siw3sPNvZPQSvxZyIPR09t62Ic73
	 0J2OE2vUdlMn+RTXwCBZQAkYNlLILKT9rT9Fza0sVbsYpcm81Fbt4AinBWDmnC9/wO
	 vfMOYkBAPjAYsoGrhGjqlbbWedOx2myYPnSKEGYxWpidAn66pYPbRXaTS00SayqkwR
	 KmZV36X3h8zd09fZtHPf0O9620sYDjWwT1upFumCAXBNWoPCL4S/6zdDvRlvlC/OPy
	 ncdvKzQT9etr+20NZlBc+zgPoiwtE3BUFC9ZvtYU4BBKW1lIj3hAGFCTMy2B6Z2ChR
	 tXcO0v9AHn39y+Zxp9w+cCtaD66vJT+xTFtd8NhOV0f4qDbY2HxwSgt0+8j6Z9Crv/
	 JDqeMPJMqou4RGhXADyAjAsU=
Received: from [127.0.0.1] (dynamic-176-007-010-021.176.7.pool.telefonica.de [176.7.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3FDD40E01FF;
	Mon, 23 Sep 2024 16:02:31 +0000 (UTC)
Date: Mon, 23 Sep 2024 18:02:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>, x86@kernel.org
CC: linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/CPU/AMD=3A_Only_apply_Zenble?=
 =?US-ASCII?Q?ed_fix_for_Zen2_during_late_microcode_load?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240923154112.26985-1-john.allen@amd.com>
References: <20240923154112.26985-1-john.allen@amd.com>
Message-ID: <3C79F091-A19B-4BAD-8582-56961830AF25@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 23, 2024 5:41:12 PM GMT+02:00, John Allen <john=2Eallen@amd=2E=
com> wrote:
>A problem was introduced with f69759b ("x86/CPU/AMD: Move Zenbleed check =
to

Use 12 chars for the commit id=2E

>the Zen2 init function") where a bit in the DE_CFG MSR is getting set aft=
er
>a microcode late load=2E
>
>The problem is that the microcode late load path calls into
>amd_check_microcode and subsequently zen2_zenbleed_check=2E Since the pat=
ch
>removes the cpu_has_amd_erratum check from zen2_zenbleed_check, this will

End all function names with "()"=2E

>cause all non-Zen2 cpus to go through the function and set the bit in the
>DE_CFG MSR=2E
>
>Call into the zenbleed fix path on Zen2 cpus only=2E

s/cpus/CPUs/g

And yes, it should be cc:stable=2E

With all that addressed, you can add:

Acked-by: me

to the patch=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

