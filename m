Return-Path: <linux-kernel+bounces-512460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894BAA33994
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D6188CC87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52664204F7F;
	Thu, 13 Feb 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xi0lMrRE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41A20B7E9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433836; cv=none; b=H8HA1mi8Y4Oqz9ucdioyT0IfozTsQ6JHEu1KKVrn3wkRbk0WuI0EH86okmMLLYh5iEb+3PumuvMm8e9g5wN86QYKpom+SbvoDEaY9jtZQ9SnxXD28rNUzC+OwKCQ+yCxPDRJuwWkA1/X3CLYjlaSG89EPMjO3cgmBd64j0Y7NtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433836; c=relaxed/simple;
	bh=vE/nMK7SkZLF6SPBiS+pD5YKBv1qwS1OW7LGyXSjOw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqOclqHinP07HBYWHdF2/uwW4c5XpwDv2TJf5P5EAWZEshr4hhxGmTwu65v0gQknNzUWm0DrO38do6NQ0qLBnMntzual5l0uILgHg8arqa+YRXVoPhARdWLkPSb9qWs1NRWeZtwQbJq2LBVKJBUTUfvl8SW0qvFhQs5XFjzevSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xi0lMrRE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54506b54268so513521e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739433833; x=1740038633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fyc1yaw37X9Hy+KPrdEbRh/UJTHUV0AcPCsCJ/7TTWI=;
        b=Xi0lMrRE3aiCQjSJc1h1DrkxyWLf4p7g+fIsHYrnRT4/v7JGGDvuVhqKVc/EXSFIj5
         kU2srXhwqLJBsxgtodSV0ZoaWRx1LB/6ci2yUke6IOFrd+I9MZLMV8p8DW8EoR9jWZSh
         YaqZpdDfHtyWW9Q7EnKPZUnk1Xl/bIWjuwyCuYf2QRtPH87y71PWWIe7XFEa/AtAnzb0
         p64IS/egQiKzwE5OIyQEeUuYvRahTzh1CH2jb4/MzEtt9EwESRPIbkKuMXnokjNIQF3h
         fCjbKlnB1V10NUEK60DNPZCjwGtZh4zN0PCJgwu3pjZlahiMLvzPSYSjNL3wzUh7Jixp
         K9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433833; x=1740038633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyc1yaw37X9Hy+KPrdEbRh/UJTHUV0AcPCsCJ/7TTWI=;
        b=SrIS5Pc+9nlHmy9y8V5Vi2Kgs4ni7dfGNDMBetaUilbUOQQmDalt3M7BaYYMe9gZfN
         QV32CajiDOtDlvTnuAy5kbdGS2dqFt1NkjtbpheYev+esiewt/3pNML4WjpQaTPqZxNY
         Jv+NdJDfYK7ps54VxeXSPWIolD2bkzEmHN9FwojGZ2j/J+Gyk6kBq5O2CzDnQChDoXTu
         cIccds2ZKtQD98J2AaSTLEXsDZBYyidJbthiFzqJDD9imNcCJxPAFm4URGbzRRvhvM2l
         DCrApqkN0od403r2SWT90ZKJZOHEuzC2FP/OoK236PxPi4VcE3+AU932sMaam7pg3VVg
         T0UA==
X-Forwarded-Encrypted: i=1; AJvYcCVT9HKyxjewLCNKuoLcoaarKQzOmtV1BBZufk0Z1JD5AIrFDm92eTQ5U8UNwYVtIrB5dNMzykIFgkaEGlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nF86kdM5yLw9781b62XdlF5G7Lzua5ey4kLbQTZFM4ASDjHp
	uSoVs2RWBFtcIDEhHdZj6CaMEe+63CIPJJpJnaO6uF/E2HFnocIDx93R/zinBQD4XCBVPFtriEh
	ZauPyMmVr2kMQswGkh3bbhHyHyW0bqJWdeXyL
X-Gm-Gg: ASbGncuwRcXdlUx0oGT03DfmRDrgu6JDACudg6/2GekTXDkCxhgZkcHXq6qaoYtPiT8
	OlF9i/eWvcu5R2WWGMD7NXbMg3/GWuLbXwUVikTApflZI7rtyyCN3pEPwEQEH5+mP8BgmM6A=
X-Google-Smtp-Source: AGHT+IFWyIrhkyKlq1DLb3nMjYFpG5D1inOQfYzABRURIba5WYtufrGTgdJdkB8ZyACpw4GjQScdFhUnuN3eyI7vuSU=
X-Received: by 2002:a05:6512:b29:b0:545:c9d:ef26 with SMTP id
 2adb3069b0e04-5451dde812cmr595357e87.46.1739433832285; Thu, 13 Feb 2025
 00:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241225-scmi-fwdevlink-v1-0-e9a3a5341362@nxp.com>
 <20241225-scmi-fwdevlink-v1-1-e9a3a5341362@nxp.com> <Z6uFMW94QNpFxQLK@bogus>
 <20250212070120.GD15796@localhost.localdomain> <Z6x8cNyDt8rJ73_B@bogus>
In-Reply-To: <Z6x8cNyDt8rJ73_B@bogus>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:03:15 -0800
X-Gm-Features: AWEUYZlo14W5CDbxko4W2HItMT0EmqxiYqRbj09Nfq6VGtFk976X-V52R5aJvug
Message-ID: <CAGETcx87Stfkru9gJrc1sf=PtFGLY7=jrfFaCzK5Z4hq+2TCzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] firmware: arm_scmi: bus: Bypass setting fwnode for
 scmi cpufreq
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:48=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Feb 12, 2025 at 03:01:20PM +0800, Peng Fan wrote:
> > On Tue, Feb 11, 2025 at 05:13:21PM +0000, Sudeep Holla wrote:
> > >On Wed, Dec 25, 2024 at 04:20:44PM +0800, Peng Fan (OSS) wrote:
> > >> From: Peng Fan <peng.fan@nxp.com>
> > >>
> > >> Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > >> SCMI_PROTCOL_PERF protocol, but with different name, so two scmi dev=
ices
> > >> will be created. But the fwnode->dev could only point to one device.
> > >>
> > >> If scmi cpufreq device created earlier, the fwnode->dev will point t=
o
> > >> the scmi cpufreq device. Then the fw_devlink will link performance
> > >> domain user device(consumer) to the scmi cpufreq device(supplier).
> > >> But actually the performance domain user device, such as GPU, should=
 use
> > >> the scmi perf device as supplier. Also if 'cpufreq.off=3D1' in boota=
rgs,
> > >> the GPU driver will defer probe always, because of the scmi cpufreq
> > >> device not ready.
> > >>
> > >> Because for cpufreq, no need use fw_devlink. So bypass setting fwnod=
e
> > >> for scmi cpufreq device.
> > >>
> > >
> > >Not 100% sure if above is correct. See:
> > >
> > >Commit 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a d=
ummy clock provider")
> > >
> > >Am I missing something ?
> >
> > Could we update juno-scmi.dtsi to use ?
> >
> >  &A53_0 {
> > -       clocks =3D <&scmi_dvfs 1>;
> > +       power-domains =3D <&scmi_perf x>;
> > +       power-domain-names =3D "perf";
> >  };
> >
>
> We can, but I retained it so that the clocks property support can be stil=
l
> validated until it is removed. I think there are few downstream users of
> it. It is not just the DTS files you need to look at when dealing with
> such things. It is the bindings that matter. Until bindings are not
> deprecated and made obsolete, support must exist even if you modify the
> only user in the upstream DT.

Sorry, been caught up on other stuff and trying to get to some long
pending emails.

Sudeep,

Do you know why commit dd461cd9183f ("opp: Allow
dev_pm_opp_get_opp_table() to return -EPROBE_DEFER") was needed? I'd
think fw_devlink would have caught those issues.
I'd recommended reverting that/fixing it differently instead of
creating commit 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure
with a dummy clock provider")

Peng, Sudeep,

If you make fwnode ignore the cpufreq device, then it'll also not
enforce ordering between cpufreq and it's suppliers like clocks and
power domains. Not sure if that's a real possibility for scmi (I'm
guessing no?). Make sure that's not going to be a problem.

Cristian,

Thanks for taking the time to give a detailed description here[1]. I
seem to have missed that email.
[1] - https://lore.kernel.org/arm-scmi/ZryUgTOVr_haiHuh@pluto/

Peng/Cristian,

Yes, we can have the driver core ignore this device for fw_devlink by
looking at some flag on the device (and not on the fwnode). But that
is just kicking the can down the road. We could easily end up with two
SCMI devices needing a separate set of consumers. For example,
something like below can have two SCMI devices A and B created where
only A needs the mboxes and only B needs shmem and power-domains. This
will get messy even for drivers if the driver for A optionally needs
power-domains on some machines, but not this one.

        firmware {
                scmi {
                        compatible =3D "arm,scmi";
                        scmi_dvfs: protocol@13 {
                                reg =3D <0x13>;
                                #clock-cells =3D <1>;
                                mbox-names =3D "tx", "rx";
                                mboxes =3D <&mailbox 1 0 &mailbox 1 1>;
                                shmem =3D <&cpu_scp_hpri0 &cpu_scp_hpri1>;
                                power-domains =3D <&blah>;
                        };

Wait a sec, looking around at the SCMI code, I just realized that you
don't even really care about the node name to get the protocol number
and you just look at "reg" for protocol number. Why not just have
peng's device have two protocol@13 DT nodes?

cpufreq@13 {
    reg =3D <0x13>;
}
whateverelse@13 {
    reg =3D <0x13>;
}

You can also probably throw in a compatible field if you need to help
the drivers pick the right node (where they currently pick the same
node). Or you can do whatever else would help make sure the cpufreq
device is attached to the cpufreq node and the whateverelse device is
attached to the whateverelse node.

Looks like that'll first help clean up the "two devices for one node"
issue. And then the rest should just work? Cristian, am I missing
anything?

Thanks,
Saravana

