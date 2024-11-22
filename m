Return-Path: <linux-kernel+bounces-418537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255329D62C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F50B20ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FE1DF267;
	Fri, 22 Nov 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3MSKmPj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C87080C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295364; cv=none; b=iB52Oq55hwVBbiPEIMUg/KCInD70GktvemusmSICzgav/oBAaCA3VUuci1nbq6hPkWuD4YoBk3O900z9mZIjv+4cTZCZsqFgu4wirICkuf0h11doRLg53PDKb+/ew2RSvd2rhsjNHF/4nJUO3pcMu7X+ykuKdnI5flvnBl+Un/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295364; c=relaxed/simple;
	bh=4uv3hgAB+S3za/+xL2DZ95+IGt9Oz4NhyCw9RV6bStI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOapKyXkEqtg2zXfUxOX8dQgCjvC9ARjKGOIpxgGxB6dSZWQO4PXIyuaXkow+UZQD8WHdSKeWnp1vQfc1szE1PZo4YEjDrs0f6oxCOSP6OtVPoSkibLVd3iynciaJNOGfXVsG92TZmw5mtyW5Vjm4wbESHk6Hl9Q3KXuGub8XEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3MSKmPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732295361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D9DJq8SYY/SC2BNizkZX9WxstqXbV8fBbsf95JBRXQ=;
	b=b3MSKmPjt5s56t35y4QzkRjUXTbCank/ek/eNXVxPatgCs5oo6OSQAm6J6CR28BpqSSk9+
	PCp0NW9Q9sfIu1EssW4h804PVdiCEDOKhyoh3D+xCyhwE0DHLaypHnCm8LZrAQaYOYMqMR
	Il55QsCbsZFUxpWS5TMpGwGbuxEIs4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-XR81BlzvOk6wHM9Fi_s39w-1; Fri, 22 Nov 2024 12:09:19 -0500
X-MC-Unique: XR81BlzvOk6wHM9Fi_s39w-1
X-Mimecast-MFC-AGG-ID: XR81BlzvOk6wHM9Fi_s39w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4327bd6bd60so15718495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295359; x=1732900159;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D9DJq8SYY/SC2BNizkZX9WxstqXbV8fBbsf95JBRXQ=;
        b=TBGNEEmPs/FkWMtD/uHlULSlu/AbfsLEzwi8fKhE2xWMNdEFIxS5NQLxEyJtpygc6b
         QVw8cIEZD6llgpMSiVgg5TYk9l7EI2O9wlJOFG99LUbYtNXnig+Z2NM/v04UPk0ROC2M
         JRQLMDoQwg4H1TXs12kmX9ArpivBmP8/Aq3a7dzIf/cq0tfiOWmUugvLjU9MoKgHNDsk
         5th3XqCa4Ox4bOt7ZzWUkZcjHvXwNckNZJDsBI5uRIXl/6ahXrAvpcO/er4wTkrxvMGv
         RrU5quOpsoTLYVriuB8mySRnY8WsCVooSA2LQrhPuMmKcfbkw/HWG+18lmwoN2JdudrW
         YHPA==
X-Forwarded-Encrypted: i=1; AJvYcCVafHPHILiqVflachZxGcPN1pRyvq7PTCIhKv4ErFU2mQIpL+mgd/6nubdH5VN3RGgYSPm8UhcOwgheCBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZGSnaNn8bo9QXCgMVC5FZ3nC0MUIjvqZ74o1BoVNh7k++0Rh
	jzQ1W8dMKoqhzHPSlGJ+tvdPCTEmoiYOtSl5rao3UclJOvA1j6676lfzAtoCzZcHJsehaNlvHEl
	bx7tBOGF9wd3Pyb8aJ1wSxEH17qDp7kmIZCrU+A8odKTyX/2S7D8jutKbVwrrDg==
X-Gm-Gg: ASbGnct6YtWAGtd0xg/L1o0RhGNwKp5NzBTVx+nQmhRs6nqjoev685Dxq2zB64G4N48
	WTeO82H3Add0aiD/jaJMAOF9rLLiHokjkXHQMJA5fXLpR9Fi7vypnrbPOQZyZ7KUkuqmceguMC6
	ip7ZqtdcP1jY9zXukA2sSd9PPUKSaEFhwgWd24rlg3jV04qHNOwkwa/brygVZbQBov6NUTKZ4wS
	NzDKwJqIXFC4Y6GHJFH4qLDwkQ5bWd963nyms0HRf5Pob24zRtuQ/WtDP0nkwtgrd141vPNFysk
	B8BOXarkaFQrRKxpy17id/7RTlAVPU21
X-Received: by 2002:a05:600c:3acb:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-433ce40ffc5mr34571045e9.4.1732295358595;
        Fri, 22 Nov 2024 09:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0Loy99fQ4/b8pNOzmARFWs+vDdHBIM1wqhp35EqpYR2nSElIVJZOdQm6LgtMtblbMz+3zeA==
X-Received: by 2002:a05:600c:3acb:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-433ce40ffc5mr34570805e9.4.1732295358196;
        Fri, 22 Nov 2024 09:09:18 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde05eaesm33849145e9.1.2024.11.22.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:09:17 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Radu Rendec <rrendec@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh@kernel.org, arnd@linaro.org, linux-kernel@vger.kernel.org, Zhipeng
 Wang <zhipeng.wang_1@nxp.com>, Maxime Ripard <mripard@kernel.org>,
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
Date: Fri, 22 Nov 2024 18:09:16 +0100
Message-ID: <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Radu Rendec <rrendec@redhat.com> writes:

Hello Radu,

> On Thu, 2024-11-21 at 10:13 +0100, Javier Martinez Canillas wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>=20
>> > On 21-11-24, 09:52, Javier Martinez Canillas wrote:
>> > > Will autload the driver for any platform that has a Device Tree node=
 with a
>> > > compatible =3D "operating-points-v2" (assuming that this node will b=
e a phandle
>> > > for the "operating-points-v2" property.
>> > >=20
>> > > For example, in the case of the following DT snippet:
>> > >=20
>> > > cpus {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu@0 {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 operating-points-v2=C2=A0=C2=A0=C2=A0=C2=A0 =3D <&=
cpu0_opp_table>;
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> > > };
>> > >=20
>> > > cpu0_opp_table: opp_table {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "operating=
-points-v2";
>> > > ...
>> > > };
>> > >=20
>> > > It will autoload if OF finds the opp_table node, but it register the=
 cpufreq-dt
>> > > device only if there's a cpu@0 with a "operating-points-v2" property.
>> > >=20
>> > > Yes, there may be false positives because the autload semantics don'=
t exactly
>> > > match the criteria for the driver to "match" but I believe is better=
 to load it
>> > > and not use for those cases, than needing the driver and not autoloa=
ding it.
>> > >=20
>> > > > I am not sure what's the best way forward to fix this.
>> > > >=20
>> > >=20
>> > > I couldn't find another way to solve it, if you have a better idea p=
lease let
>> > > me know. But IMO we should either workaround like this or revert the=
 commit=20
>> > > that changed the driver's Kconfig symbol to be tristate.
>> >=20
>> > Yeah, this needs to be fixed and this patch is one of the ways. Lets s=
ee if Arnd
>> > or Rob have something to add, else can apply this patch.
>> >=20
>>=20
>> Ok. Please notice though that this is an RFC, since all my arm64 machine=
s have
>> their own CPUFreq driver and are not using cpufreq-dt-platdev. So I woul=
d not
>> apply it until someone actually tested the patch.
>
> I tested the patch on a Renesas R-Car S4 Spider (r8a779f0-spider.dts)
> board, and it didn't work. I think the problem is that the OPP table DT
> node does not have a corresponding device instance that is registered,
> and therefore no modalias uevent is reported to udev/kmod.
>

Thanks for testing! Bummer that the workaround didn't work. But that's why
I asked you to test. You know, like Donald Knuth said: "Beware of bugs in
the above code; I have only proved it correct, not tried it" :)

> FWIW, the OPP table is defined at the top of r8a779f0.dtsi and
> referenced just a few more lines below, where the CPU nodes are
> defined.
>
> As far as I understand, there are two options to fix this:
>    1. Revert the patch that allows the cpufreq-dt-platdev driver to be
>       built as a module. There's little benefit in allowing that anyway
>       because the overhead at init time is minimal when the driver is
>       unused, and driver can't be unloaded.
>    2. Modify the driver and create an explicit of_device_id table of
>       supported platforms for v2 too (like the existing one for v1) and
>       use that instead of the cpu0_node_has_opp_v2_prop() call and the
>       blacklist. That would of course also eliminate the blacklist.
>

Agreed with this. Likely (1) is the easiest path and (2) would make the
driver more aligned with the rest of the kernel (that have a list of OF
device IDs to autoload / match instead of some custom logic).

But I guess that (2) would be riskier, since not adding a platform that
uses v2 will cause a regression.

> --
> Best regards,
> Radu Rendec
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


