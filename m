Return-Path: <linux-kernel+bounces-418461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C89D61DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06729B25755
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE491DE3A5;
	Fri, 22 Nov 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOfXgJla"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A5AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292213; cv=none; b=Qz8Seje43cSAcromXspNp8jg0KFvq9KayEy8JYMWuYrSlAyuJTb3raMAN9/sUdjTNYp8lLjXLYEdvVzbtjeaWeXgGKzgPzFZ+cfjirSW7RbQFy/AzdYhwqKAJz9h+LgW4R60g8VsSY3h2drj82flOC8WqYROGb/q6DKc0y5Do4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292213; c=relaxed/simple;
	bh=Bv/9ofc9ECBUiElXTbQzb4okhG/cF9jXPCdH7n9GtGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XptlJQ8dDQUP1KsALNaH0oomcAn9Vkn/7y+ViXoHMhFX52KeLZE8LZJ4Wj3SJdaUxCEDhA5TY+YCFisAYHah4CJ7KgRsPWvbJ7ZSjyErTT/YEEUeHgHOUb5qNFpDDFENbTxIg8gNsniu7FHDecPcSDpkCxCTyyT5G/Nt2Cv3xL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOfXgJla; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqYsenDaD0i9ZHsyIrHLDcCZPQ9SNx4buFBPvNXiB+A=;
	b=fOfXgJlaHCH45oy3idUl7GG4gJz2W4YtqWBO4oRjX5JO9jVaFhCzGdUpG7+zAtB9N74Hz2
	Hge09rqBjt2AzAQ46EFYSD0a9C/iPZGFq3w1Ftn9hHWkVmKlDdJE/bu8fgf12WTWxSsEvG
	84nEvKFuqZfxTaVoAzy4scF0oGT/2r8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Hi7NmrnEOvihwbkhVGsDWg-1; Fri, 22 Nov 2024 11:16:49 -0500
X-MC-Unique: Hi7NmrnEOvihwbkhVGsDWg-1
X-Mimecast-MFC-AGG-ID: Hi7NmrnEOvihwbkhVGsDWg
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b14a4e771fso261391085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292209; x=1732897009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqYsenDaD0i9ZHsyIrHLDcCZPQ9SNx4buFBPvNXiB+A=;
        b=h6YafOhpff/2t8o7I6qUNtxpUeXN+/dmSS7ju/XzM3kB4a4ekDYPnjoiM4HAsT2AaJ
         82riLC1lml/nDzP8/1I+edO0vN6P5VFZP4zQhRjswQ5isvd1t4CCZxJvkQTrjP9eb1AD
         0wRHk8RbKYTlPSegezPAn5u3g2g+JDKdLLh37qy7ySF7/oDFPDcd9cqjWVxEGbQkey4E
         StcFZkEecw5naGoGsJdoSoQLqLefpighXH+6Wc5P6Mh5YsPpfoTIKZe1T5KAE/xlAHEN
         APIBibE1G493RGYoivtClprohVTRar7L3LUtCNt0G8HKGyPv5eunss0vQ5bLdywNkSP5
         U3tw==
X-Forwarded-Encrypted: i=1; AJvYcCW8rRbjeehsPNef3hxCYapwKg6XxX972RjOMt8nLZZPcmwOY4DfOyf5ile4D99XHPoK71llEvOGWpbqPMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWx+cKeOyE5P2jLGtEhRw4So0RYadP9GVFqSFPTLaL7ZFLiPgT
	67Nac+tgDEbjtYHjwGNXAOjt1tUqyuqiPdtb5Hzw30Lmo95wxZfZCd86au5HfWfUsA0hlJpOEm/
	t2DU3nJHVkJPcnr2a1XQBoISglEMNFa5bbIvVo12zTK1wxAMQSs4s/jFsJV2dew==
X-Gm-Gg: ASbGncssc2ypDRmhNm+oqPTRJw7T5vtc9mj7xPwitbTvtc9sx3xQpg/FUjrbblDG2M6
	TJCj6cGdsBSyeArP+s9kL8x3b66jZALOaXbxt8GZiWrS+3U+LytzrFNds9dxXd7QRJg/qJVWE/c
	ncSr+OZ8T7s8ZBFWRFWaQxAvIRr/U/If9ToHxkqL81FpPPK4lU3e2naZZSIlMOhC8YQEEyg4IB4
	1uMo7SDf4JsJz5BKkFm8A4X5yEfBMF2Z0jEU8QGIgx3SprlUzN/0Vb4Vci2N7Sn6AAubSfEkhYo
	r9yfkw6dyygrPY2HOr5RUslNW+//aqtmGsS6S+SrIg==
X-Received: by 2002:a05:620a:1994:b0:7b0:6e8:94ef with SMTP id af79cd13be357-7b5143e427amr458832685a.0.1732292208641;
        Fri, 22 Nov 2024 08:16:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR6hqiPkDWQ3B2eG437kkPrGRq1PtOCZedZpuboUGW7qkMTNvEQd4gGaX5Hcs1CDt/wA1lCg==
X-Received: by 2002:a05:620a:1994:b0:7b0:6e8:94ef with SMTP id af79cd13be357-7b5143e427amr458829385a.0.1732292208164;
        Fri, 22 Nov 2024 08:16:48 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51416cd4bsm99077685a.117.2024.11.22.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:16:47 -0800 (PST)
Message-ID: <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
From: Radu Rendec <rrendec@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>, Viresh Kumar
	 <viresh.kumar@linaro.org>
Cc: robh@kernel.org, arnd@linaro.org, linux-kernel@vger.kernel.org, Zhipeng
 Wang <zhipeng.wang_1@nxp.com>, Maxime Ripard <mripard@kernel.org>, 
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 linux-pm@vger.kernel.org
Date: Fri, 22 Nov 2024 11:16:46 -0500
In-Reply-To: <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
References: <20241119111918.1732531-1-javierm@redhat.com>
	 <20241121071127.y66uoamjmroukjck@vireshk-i7>
	 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
	 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
	 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-21 at 10:13 +0100, Javier Martinez Canillas wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
>=20
> > On 21-11-24, 09:52, Javier Martinez Canillas wrote:
> > > Will autload the driver for any platform that has a Device Tree node =
with a
> > > compatible =3D "operating-points-v2" (assuming that this node will be=
 a phandle
> > > for the "operating-points-v2" property.
> > >=20
> > > For example, in the case of the following DT snippet:
> > >=20
> > > cpus {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu@0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 operating-points-v2=C2=A0=C2=A0=C2=A0=C2=A0 =3D <&cpu=
0_opp_table>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > };
> > >=20
> > > cpu0_opp_table: opp_table {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "operating-=
points-v2";
> > > ...
> > > };
> > >=20
> > > It will autoload if OF finds the opp_table node, but it register the =
cpufreq-dt
> > > device only if there's a cpu@0 with a "operating-points-v2" property.
> > >=20
> > > Yes, there may be false positives because the autload semantics don't=
 exactly
> > > match the criteria for the driver to "match" but I believe is better =
to load it
> > > and not use for those cases, than needing the driver and not autoload=
ing it.
> > >=20
> > > > I am not sure what's the best way forward to fix this.
> > > >=20
> > >=20
> > > I couldn't find another way to solve it, if you have a better idea pl=
ease let
> > > me know. But IMO we should either workaround like this or revert the =
commit=20
> > > that changed the driver's Kconfig symbol to be tristate.
> >=20
> > Yeah, this needs to be fixed and this patch is one of the ways. Lets se=
e if Arnd
> > or Rob have something to add, else can apply this patch.
> >=20
>=20
> Ok. Please notice though that this is an RFC, since all my arm64 machines=
 have
> their own CPUFreq driver and are not using cpufreq-dt-platdev. So I would=
 not
> apply it until someone actually tested the patch.

I tested the patch on a Renesas R-Car S4 Spider (r8a779f0-spider.dts)
board, and it didn't work. I think the problem is that the OPP table DT
node does not have a corresponding device instance that is registered,
and therefore no modalias uevent is reported to udev/kmod.

FWIW, the OPP table is defined at the top of r8a779f0.dtsi and
referenced just a few more lines below, where the CPU nodes are
defined.

As far as I understand, there are two options to fix this:
   1. Revert the patch that allows the cpufreq-dt-platdev driver to be
      built as a module. There's little benefit in allowing that anyway
      because the overhead at init time is minimal when the driver is
      unused, and driver can't be unloaded.
   2. Modify the driver and create an explicit of_device_id table of
      supported platforms for v2 too (like the existing one for v1) and
      use that instead of the cpu0_node_has_opp_v2_prop() call and the
      blacklist. That would of course also eliminate the blacklist.

--
Best regards,
Radu Rendec


