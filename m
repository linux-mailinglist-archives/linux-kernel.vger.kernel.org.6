Return-Path: <linux-kernel+bounces-335544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651E97E73D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853A01C20E96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9D5FBBA;
	Mon, 23 Sep 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="D5C7b3qO";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="AdrISO8D"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5865DDA8;
	Mon, 23 Sep 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078916; cv=pass; b=oCCea0DDYL1ngFAzwiJE9KXbN0/gJZ0HLjGWDFzfMbtDLbWUCKzOk5sL1Jyd51ngjM2MxkcVsV7LyrU39+KU6yRneo7ZdOWadB0w1qtcjRmWEKxqN2uTBSrPzStHGdrR3ONZQpeFgO2Wx6SJGl/Igw0bWXIPvgVIP/GxiW3Gegw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078916; c=relaxed/simple;
	bh=1QVCddyUVoxAqj8pQxyLJzuxnI5bt+LsrHASbey5M+c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bnbgkz0kE6AttJYcBUAKh75HV0lKrnBnq5lrJLWOReD0Tdtku/SBIilmIFAtzgCZNgdAmje7ojNS06tU0mfl5PvLfNosrns9qujexC9QLxL9jkibpd4H55Yq+KiSRyB41ZnchRPHLrMDH7AUno55rl4MR3VOEz+q3C9piL9AQTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=D5C7b3qO; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=AdrISO8D; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1727078879; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qKwB86n00GmfcdUJfGBW/5bqno7ESssB/Zz8YN9EMWYJTb2VpCa0KxDO8giRh4TlzX
    7hjh78Fu7tnJNfvNMQr/mvziVh3lNrOCldKjwju4eB8epB3QAPLphU67ZAnpLTNOTZdH
    1R961uQEI4rpslq7P1+8E1RUuDp3BXV5cViNVmqpLMt2jfLh6rYzh2ETc0L33j0bsuFG
    vYiLxXWfTqaBhd42pzi3BFHvYVFzsLRZ8JhnWS3Ma/FgLWTex7YR7SFfaPMmIBJ7HCoW
    IytEeqrIysa0BnhWBGQbs9K92/r6Wa6saP1keHSErkgEPqNahhQZXGrSAlETqml0eYok
    V/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727078879;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VIQRhUxEARqR1v/zOQvtmNidqw74JAtjsezcmG6rzK0=;
    b=XF15O3S+YKxdNtIzfuoM9GtJN1M6ctDTNuuwPmgGix43stSmFSWR1n6Jp72OKdt5Mv
    xy11wFAjOZr23d/LB6x2ZQV3ArbgdSC2Ceg2MjN2rOsORh2Ra7SAQLUteXgUwb6csYW7
    ppx8W6p/aScq7DEuoYG2A7JJxcZlK49ZUv+WxoxtXH7AXyvc2eN99B0WFQhT3ir7HwOh
    a3l6c2YADe8SBwHMZgJVqPm1mJz4dtqYrF8GSZ+lx5r2GobZD0S1xBvRDp1J6vmUDkdG
    OOisFf1vBFmOMelqeFoUrRBWsoT1cEBVPlRu5K9UwoI/srmr8UCUIw/MHHK4d0FHMtoF
    O1cA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727078879;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VIQRhUxEARqR1v/zOQvtmNidqw74JAtjsezcmG6rzK0=;
    b=D5C7b3qOMSDo10DcEeUoQARntf/f97LPrwchUHF/8NdI0bKfSqfLv7q2WCfkfjFEwt
    qWsaPCnesmF4SjV15u7wwbJEzTgCJdt2xyWghvBsC/0EHcGJDttuLY6oj4enmX7R8vM7
    bVSGxptRUAqC8qLBAWSziAuCKP6ucdzQ/BuqT1GUjTLHhXkHtDF37fidlRUTlM+c2pP5
    PhW+yvfOMjgtFVPsth8FvDvbOunV5RNFhs/BtyjJ/OzQaeK6OYkKcQaowlQNdVNRSKkB
    CCljsMiGrHM6nuYLaLlU8cFd2IccP/c/NDTc9Gs8vc7ksgLDtc7nOMtyGhVlNpNCeAWa
    C3uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727078879;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VIQRhUxEARqR1v/zOQvtmNidqw74JAtjsezcmG6rzK0=;
    b=AdrISO8DrdcnwY2zxF9hMFSw89l6bB6CfzRbUYC4+70csYj2EkYnrrt7+1gPVFoEtL
    CVQTGj1IM4lyotvF7KDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTAZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.7 DYNA|AUTH)
    with ESMTPSA id Qd0dc208N87wRua
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 23 Sep 2024 10:07:58 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] ASoC: topology: fix stack corruption by code unification
 for creating standalone and widget controls
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <3ceac85f-e419-44b1-b04b-1d1cf99a3e87@linux.intel.com>
Date: Mon, 23 Sep 2024 10:07:48 +0200
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 kernel@pyra-handheld.com,
 risca@dalakolonin.se
Content-Transfer-Encoding: quoted-printable
Message-Id: <746AA9D5-9D53-4351-A534-B9F86A5B9B82@goldelico.com>
References: <7eca678fa7faa9e160b998192e87220de81315c8.1726847965.git.hns@goldelico.com>
 <3ceac85f-e419-44b1-b04b-1d1cf99a3e87@linux.intel.com>
To: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi,

> Am 23.09.2024 um 09:39 schrieb Amadeusz S=C5=82awi=C5=84ski =
<amadeuszx.slawinski@linux.intel.com>:
>=20
> On 9/20/2024 5:59 PM, H. Nikolaus Schaller wrote:
>> After finding kernel crashes on omap4/5 aess on PandaES and OMAP5UEVM =
like
>> [   46.367041] Unable to handle kernel execution of memory at virtual =
address f164d95c when execute
>> a bisect did initially hint at commit 8f2942b9198c9 ("ASoC: topology: =
Unify
>> code for creating standalone and widget enum control")
>> Deeper analysis shows a bug in two of the three "ASoC: topology: =
Unify code"
>> patches. There, a variable is initialized to point into the struct =
snd_kcontrol_new
>> on stack instead of the newly devm_kzalloc'ed memory.
>> Hence, initialization through struct soc_mixer_control or struct =
soc_bytes_ext
>> members overwrites stack instead of the intended target address, =
leading to
>> the observed kernel crashes.
>> Fixes: 8f2942b9198c ("ASoC: topology: Unify code for creating =
standalone and widget enum control")
>> Fixes: 4654ca7cc8d6 ("ASoC: topology: Unify code for creating =
standalone and widget mixer control").
>> Fixes: 0867278200f7 ("ASoC: topology: Unify code for creating =
standalone and widget bytes control").
>> Tested-by: risca@dalakolonin.se
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>=20
> There was an earlier patch for same issue which got merged:
> =
https://lore.kernel.org/linux-sound/172675955522.1842725.17347774552974803=
458.b4-ty@kernel.org/T/#m527c2b9bee99d40d7cd5224cb1d8046dd0528097

Ah, I see. They were just some days faster than me :) Great if it will =
be fixed asap.

>=20
>> Notes:
>>     There seems to be another weakness of all three patches. The =
initialization
>>     of the kc.private_value is now done after calling =
soc_tplg_control_load()
>>     which may pass the incompletely initialized control down to some =
control_load()
>>     operation (if tplg->ops are defined).
>>          Since this feature is not used by the omap4/5 aess subsystem =
drivers it is
>>     not taken care of by this fix.
>>    =20
>=20
> dobj is internal management detail of topology handling, I'm not =
convinced end users of topology API should touch it. I would say that I =
would even be worried that someone touches that, as they may corrupt =
list etc.

Well, someone may want to inspect values or use the list to see if it is =
empty.

>=20
>>     Another general observation with this code (not related to these =
patches here)
>>     is that it does not appear to be 64 bit address safe since =
private_value of
>>     struct snd_kcontrol_new is 'unsigned long' [1] but used to store =
a pointer.
>>          This is fine on omap4/5 since they are 32 bit machines with =
32 bit address
>>     range. A problem would be a machine with 32 bit unsigned long and =
>32 bit
>>     addresses.
>=20
> As far as I know that's exactly the reason why it is unsigned long in =
kernel, you can store a pointer in it.

You can't store a 64 bit pointer in an 32 bit unsigned int without =
getting into trouble
on conversion back :) That is what uintptr_t is intended for, but it is =
also just an
unsigned long in linux/types.h. AFAIK it is defined by C99 as "unsigned =
integer type
capable of holding a pointer".

BR and thanks,
Nikolaus



