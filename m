Return-Path: <linux-kernel+bounces-348235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADA98E46D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8891F23CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FB194ACD;
	Wed,  2 Oct 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Llc9XjG1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D588F5B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902178; cv=none; b=Ut9NNJKKuGsRRrZpaqkFYgZFE9lazpz0xjSRhUAdPP4CavliPFg6EoB8LnQjUpRtyGTJmDWxApUpZtcPLJPjZvQJBDJP++FX/pFgIM3kwa7AGYxvT9P1OfwdvU08JFF8+EckxJ5ehwlNgD2fVHX8kM/3HC6kCubWonOMUqlyMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902178; c=relaxed/simple;
	bh=uvsPBShSPO+yM/hAzKgPPqQv9tYuzcqq5Atfk72oAbQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cylVNXvnsQmlXiEuXEOnEnz3Dpj+0L7AjTSk2vp7tOyCIcdhHb/7ngsb+YeihZq+VXi+hG1UyDVgOP/ZJrEJfyWb8dS2+A1sU6e+G1WwditdYq8dbhYXRF1ys0jXSyMuuXxISMec8vtJ6qpiDnzkeSyJXNV7NZoMK1SR95p1JlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Llc9XjG1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398b589032so267752e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727902175; x=1728506975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1z0vltYtHMh6nM7Myzu/CUHs6ELzzDF6I8s/J7e4QNQ=;
        b=Llc9XjG1tBjNg/tDob+QmPHIfFHuNvoYfcKOOUepchvBmghnqYRQR4c5/YkscD7oYu
         CMDp3cgAk+xfnWnHEQ8y+YIHwueWeOtJ4k5h5XrAKsheqylMBzKTgBCnaaIZ/z96+nq5
         YgSWAXN4/p2IOAsZr+KBCe3iD0I6NLyMaaLGeJZfuA1sEQzu21+2pXN4LOgKg3qV4nF7
         4PW5le4Eb2xgDnocTas90g02X3pd2R+kyIuA9UTVEb5yaNi8wmy5yl8UUFC2zGhKm+kM
         sNUkGIVvFHuFd4eHkutHdWCUEK1BWfyqYca2gTPGtj9fj+Z+myG/p5BSkQ+HNZP/Z5ar
         sanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902175; x=1728506975;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1z0vltYtHMh6nM7Myzu/CUHs6ELzzDF6I8s/J7e4QNQ=;
        b=ltsiq5boDfMDd4o2BesQZukftGDt9l2rGbuO0eI1eLUh8oHkbP7p4xgzh0YXC3yNBD
         rho9XqrFk1H8s5O90fmCY8etPPpAp1o2LVO6l2+0mTmj5XfeeSpuVeFVK4/UsMgNZ/Yg
         pBxgBDDTEMGjg/a5gzAGSzn4vY7V4K4v2/VAOeCxwslOxGX+k9t4gIRast4A4Dg/dOKN
         u5wCBqmhrbzYyDccLfRZlT0XdXj/uMxRTLewhbLyJ+ymBgqBBGQESzFIjugfPhMMMG3Y
         gVZwemqjq7uCnA7TqKmOCNwNg0GD2ir9jcJJ/7okgxkNom/RbM9aj3yqXq/crCNiKMTf
         OQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8t2VHcmYSJNTohXfqmGvg103p/PBSiAoJShS9KARbVSdO1auLLt4sFUQkCtFPMeHiEs/dVlzFSwaooIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2o3A5ea3ktdssbBBIWBCGdnFnErPsNChW85+BJHPtWOhVBwps
	zOQO9ikqQ2c9wqXtkea0qKjQPhNrbDosB4aniXcpnOH1lLtcsBAgSURFPeqCjlQ=
X-Google-Smtp-Source: AGHT+IHw+cshu10He6CNCBmdI2iYdCk1JHyIZU6NlAWirtthcx1GR1PIMz9XM9sPHv0UnO1QSgF8dA==
X-Received: by 2002:a05:6512:1056:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-539a0792f99mr4173573e87.38.1727902174449;
        Wed, 02 Oct 2024 13:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([188.119.23.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775ceasm911357066b.21.2024.10.02.13.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:49:33 -0700 (PDT)
Date: Wed, 02 Oct 2024 23:49:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurentiu Tudor <tudor.laurentiu.oss@gmail.com>,
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
CC: "Kemp, Bryan" <Bryan.Kemp@dell.com>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Tudor, Laurentiu" <Laurentiu.Tudor1@dell.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robdclark@gmail.com>, Peter de Kraker <peterdekraker@umito.nl>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/3=5D_arm64=3A_dts=3A_qcom=3A_Ad?=
 =?US-ASCII?Q?d_support_for_X1-based_Dell_XPS_13_9345?=
User-Agent: K-9 Mail for Android
In-Reply-To: <322946b9-bef1-488b-a1a7-e35b057ee018@gmail.com>
References: <20240921163455.12577-1-alex.vinarskis@gmail.com> <20240921163455.12577-4-alex.vinarskis@gmail.com> <f9997a19-5aae-41c9-9ca2-c847d8071230@gmail.com> <CAMcHhXohz6kquH_JT9eAKMntxxyjDt+oZUB_kfAO840oJ5=LPQ@mail.gmail.com> <PH8PR19MB7071756BFAFA1BA3E92AF3C09E772@PH8PR19MB7071.namprd19.prod.outlook.com> <CAMcHhXo7PNxoOs3BEhbS7v-hDqEZQSyQJnzHbpTMoRbeaunp3g@mail.gmail.com> <d54d98f2-f678-491b-8448-0dd2be32aa82@gmail.com> <CAMcHhXr-0+mBggJ9PmT1G=Jti1BY-bmLfKJUz6=-oKg+4Rs2cg@mail.gmail.com> <322946b9-bef1-488b-a1a7-e35b057ee018@gmail.com>
Message-ID: <ED86D6B5-E5F8-4965-BE59-C90535EA543A@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2024 10:06:41 PM GMT+03:00, Laurentiu Tudor <tudor=2Elaurenti=
u=2Eoss@gmail=2Ecom> wrote:
>Hi Alex,
>
>On 10/1/24 20:57, Aleksandrs Vinarskis wrote:
>> On Tue, 1 Oct 2024 at 18:23, Laurentiu Tudor
>> <tudor=2Elaurentiu=2Eoss@gmail=2Ecom> wrote:
>>>=20
>>> Hi Alex,
>>>=20
>>> On 10/1/24 19:09, Aleksandrs Vinarskis wrote:
>>>> On Tue, 1 Oct 2024 at 02:47, Kemp, Bryan <Bryan=2EKemp@dell=2Ecom> wr=
ote:
>>>>>=20
>>>>> Fascinating topic=2E First of all, thank you Alex for the explanatio=
n of your logic, and thank you as well for the work on the device tree for =
the XPS 13=2E I understand completely how the Dell naming/numbering scheme =
is confusing=2E The shortened version down to just the model number could a=
lso be confusing=2E For example, there is an XPS 9520 as well as a Latitude=
 9520=2E The 9 basically translates to "premium" not a specific line of bus=
iness=2E For what it is worth, I would prefer the dell-xps13-9345 naming an=
d I think we can have to be mindful to avoid a naming collision in a decade=
=2E
>>>>>=20
>>>>=20
>>>> Hi,
>>>>=20
>>>> Thanks for the input, it's really nice to have Dell's perspective as =
well=2E
>>>> That's a good point with latitude, I was only aware of 5XXX/7XXX
>>>> naming for that one=2E=2E=2E which I guess further highlights the con=
fusing
>>>> naming scheme=2E
>>>=20
>>> Yeah, completely agree=2E We will raise this internally so that in the
>>> future we'll do a better job at naming platforms=2E
>>>=20
>>>> I will re-spin with `dell-xps13-9345` and `dell,xps13-9345`
>>>> respectively as proposed then, unless there will be any other feedbac=
k
>>>> on the V3 series before tomorrow=2E
>>>=20
>>> Great, thanks!
>>>=20
>>> Couple of points:
>>>    - i'm thinking that maybe at a later point, as more dell platforms =
are
>>> getting added, we can re-organize the device trees, e=2Eg=2E have a co=
mmon
>>> 'dell-xps=2Edtsi' which gets inherited by specific platforms
>>=20
>> Completely agree=2E Although I'm not sure about the name - analyzing
>> DSDT of Tributo it seems there are quite a few more things defined
>> than particular laptop utilizes, eg=2E support for x3 TypeC and x3 USB
>> MP while current device only has x2 TypeC and x1 USB MP=2E I believe
>> these are either leftovers of examples being provided to Dell which
>> were just left there, or ACPI tables being (at least partially?)
>> shared between multiple platforms - eg=2E Inspiron 14" 7441/Latitude 14=
"
>> 5455 etc=2E In the latter case (unfortunately cannot test myself due to
>> lack of hw) perhaps the =2Edtsi can be inherited by more than just XPS
>> family=2E If you/Kemp Bryan could share some insight on that already wr=
t
>> to how much is shared (if any), I can split to dtsi/dts with upcoming
>> re-spin=2E Otherwise indeed can be done when the next platform is being
>> introduced=2E
>
>Regarding ACPI, hard to tell as I'm not familiar with what's exposed in t=
here=2E=2E=2E there might be legacy / inconsistent things=2E
>
>For now, I'd suggest to just stick with what we have at the moment and bu=
ild on that=2E More to the point, have the device tree for xps13-9345 accep=
ted and derive from it, if / when at some point in time similar platforms s=
how up=2E
>
>>>    - just noticed that the firmware paths point to something like
>>> "=2E=2E=2E/dell/tributo/=2E=2E=2E"=2E Should we reconsider these too? =
Maybe something
>>> like "=2E=2E=2E/dell/xps/=2E=2E=2E" would be better?
>>=20
>> Yes, will drop 'tributo' altogether=2E Perhaps "=2E=2E/dell/xps13-9345"
>> then, to match the proposed compat?=20
>
>
>Sounds good to me=2E
>
>> Also when Divo/Huracan/Perfomante
>> will come out, those are still "XPS" but I would guess will have
>> different firmware files, so maybe it makes sense to be a bit more
>> precise with the naming?
>
>On naming, there are ongoing internal discussions to make them more coher=
ent=2E
>
>Apart from that, could you please Cc: us if you plan to submit stuff to l=
inux-firmware?

Only Dell, the final copyright holder and product owner can submit files t=
o linux-firmware=2E


--=20
With best wishes
Dmitry

