Return-Path: <linux-kernel+bounces-238243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5192475C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AE61C2450F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3A1CB320;
	Tue,  2 Jul 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6E/20Yk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822F1C0DD9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945478; cv=none; b=thXruVl4J/7Umqu97YTIXEoS8T7NIv9Ccfwb0lyMCtJS0x0NZMi+QnMTsdCGb2tErysAqdoOgCMxvSteduXQ8K0aNEJy3gOHiUJP1FzDlsiIoE2xbV6PEF8NP89hdvUWzrsd7PEYSDcEc2X2IODxj0rV/OeSMKHdAteji34oM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945478; c=relaxed/simple;
	bh=EJuM4BeUouWHK1O6ywRFzDk+t1MZsyao5tjnnmJjmvg=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTx4AZPM02LnuuA8NDv2rHZw1/MBkVaCv/7xHMFGJCTph/W4+M1bd0+vWUgN8tezHanqPTt/PYkTBUo56zEFDC3hMGg+qojc1hKPseWGdkEuUHVD55bwIA6qOOcbDHr1yDBx4y3G24ciAwsR/1jNX/F2F7m6dmGFPEdP+9MSKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6E/20Yk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719945475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSyFQVy0mrp4ZXotenEF6TBWA9Vz1QKR3hy/5ETJnho=;
	b=b6E/20YkR0XeQDQeXP8ty8o+veEH1G9g2Qt6BhH1QSedfdD2Stla9qrkrTecLFEH6Jb1ZD
	DlgWtQb76nRzXRG6HcW5lZzaB9NOC3CCBHPgVAKnPcfx+unvwRXrAPGJOn89qSaj9muZZK
	zwrVEPJQ+WAYOlpisOgIovJ8+EjD504=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-02Eme--pPm-1Y5FCpsvgyw-1; Tue, 02 Jul 2024 14:37:54 -0400
X-MC-Unique: 02Eme--pPm-1Y5FCpsvgyw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d6cce2f6e3so2763444b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945473; x=1720550273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSyFQVy0mrp4ZXotenEF6TBWA9Vz1QKR3hy/5ETJnho=;
        b=fp8uD4BEypTqXqJl6k4o7t4yRAMbdG9Vq+d5S+hvJwyFtIGr3/Q4AN8AXM6PHON+qn
         zc1hfKZVnaGkv6j99wf/vQrSykcl6duGIU9PLwMMPxLm6wBHrUjRRqYGj89K2qPNm9ZE
         U+5rEP0O/Q3OGmEuWLjpe+7InmtgiOr1b24O+yBqkCOoi4/C+Voz1OSa49nFuHVx5c/o
         M1FC9z9f5Ngm5EMGNPM+SXGgCcGgsug1T9e9vK8zfZthAonAKdJOc3ozJAKZBoRIiS6O
         fOc420+X9lJOSHPoBBTTB7vRoB3tdNa7gg2bH7KAYceENx4Vol3mzC3188fIktOTttDg
         mAcA==
X-Forwarded-Encrypted: i=1; AJvYcCXg+2QOQBuZTFDEJVjoPEtXMX1epdjxiQjZLsaD8yHi5lJ+pfPYHqRguCSSFprP1ZzEG5tHHIiNzXcE4Jk1pgXlWJahvKqeDNDHsqw5
X-Gm-Message-State: AOJu0YyOh/VPq+WTeRplhio0OwluU6gmOHEbOjPqGJ7HW+IV4Blj0VhK
	EG8MqNeJ8ylwoa1pHXn+00BCpbaT8TBletglZo6hA+R7voIF9xX9RrlUu73RoG4El4A1QGgL5K2
	dLwmnbnvvWluBjRDkEz1i6Z4a7E2WgL9OKu+sD89Q7RXKNtOMw9vG07kdTI9N3Xzmza2l0s7Mnu
	OQRuMT2kJQPcSg8jRbRIlVYow0rIuWLAexCLHS
X-Received: by 2002:a05:6808:14d2:b0:3d6:36a9:52d with SMTP id 5614622812f47-3d6b31ec0b0mr14206608b6e.21.1719945473577;
        Tue, 02 Jul 2024 11:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPSxkilT9DdWBJFZjsaNYQcIjxzUG1bXAru9m/dYqWgp631Sy+6424p144kpSXsZCB9Gqkd2hDhuDOh2nYhK8=
X-Received: by 2002:a05:6808:14d2:b0:3d6:36a9:52d with SMTP id
 5614622812f47-3d6b31ec0b0mr14206588b6e.21.1719945473245; Tue, 02 Jul 2024
 11:37:53 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 18:37:52 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com> <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
 <20240702093726.GD598357@kernel.org> <447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
 <20240702123301.GH598357@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702123301.GH598357@kernel.org>
Date: Tue, 2 Jul 2024 18:37:52 +0000
Message-ID: <CAG=2xmNXJyyTtbEMDT149pZSv75birHYAH67oC+xc6jpxtQjDw@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Simon Horman <horms@kernel.org>
Cc: Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 01:33:01PM GMT, Simon Horman wrote:
> On Tue, Jul 02, 2024 at 11:53:01AM +0200, Ilya Maximets wrote:
> > On 7/2/24 11:37, Simon Horman wrote:
> > > On Tue, Jul 02, 2024 at 03:05:02AM -0400, Adri=C3=A1n Moreno wrote:
> > >> On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> > >>> Adrian Moreno <amorenoz@redhat.com> writes:
> > >
> > > ...
> > >
> > >>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > >
> > > ...
> > >
> > >>>> @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *=
skb, struct sw_flow_key *key)
> > >>>>  	return 0;
> > >>>>  }
> > >>>>
> > >>>> +#if IS_ENABLED(CONFIG_PSAMPLE)
> > >>>> +static void execute_psample(struct datapath *dp, struct sk_buff *=
skb,
> > >>>> +			    const struct nlattr *attr)
> > >>>> +{
> > >>>> +	struct psample_group psample_group =3D {};
> > >>>> +	struct psample_metadata md =3D {};
> > >>>> +	const struct nlattr *a;
> > >>>> +	int rem;
> > >>>> +
> > >>>> +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > >>>> +		switch (nla_type(a)) {
> > >>>> +		case OVS_PSAMPLE_ATTR_GROUP:
> > >>>> +			psample_group.group_num =3D nla_get_u32(a);
> > >>>> +			break;
> > >>>> +
> > >>>> +		case OVS_PSAMPLE_ATTR_COOKIE:
> > >>>> +			md.user_cookie =3D nla_data(a);
> > >>>> +			md.user_cookie_len =3D nla_len(a);
> > >>>> +			break;
> > >>>> +		}
> > >>>> +	}
> > >>>> +
> > >>>> +	psample_group.net =3D ovs_dp_get_net(dp);
> > >>>> +	md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
> > >>>> +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> > >>>> +
> > >>>> +	psample_sample_packet(&psample_group, skb, 0, &md);
> > >>>> +}
> > >>>> +#else
> > >>>> +static inline void execute_psample(struct datapath *dp, struct sk=
_buff *skb,
> > >>>> +				   const struct nlattr *attr) {}
> > >>>
> > >>> I noticed that this got flagged in patchwork since it is 'static in=
line'
> > >>> while being part of a complete translation unit - but I also see so=
me
> > >>> other places where that has been done.  I guess it should be just
> > >>> 'static' though.  I don't feel very strongly about it.
> > >>>
> > >>
> > >> We had a bit of discussion about this with Ilya. It seems "static
> > >> inline" is a common pattern around the kernel. The coding style
> > >> documentation says:
> > >> "Generally, inline functions are preferable to macros resembling fun=
ctions."
> > >>
> > >> So I think this "inline" is correct but I might be missing something=
.
> > >
> > > Hi Adri=C3=A1n,
> > >
> > > TL;DR: Please remove this inline keyword
> > >
> > > For Kernel networking code at least it is strongly preferred not
> > > to use inline in .c files unless there is a demonstrable - usually
> > > performance - reason to do so. Rather, it is preferred to let the
> > > compiler decide when to inline such functions. OTOH, the inline
> > > keyword in .h files is fine.
> >
> > FWIW, the main reason for 'inline' here is not performance, but silenci=
ng
> > compiler's potential 'maybe unused' warnings:
> >
> >  Function-like macros with unused parameters should be replaced by stat=
ic
> >  inline functions to avoid the issue of unused variables
> >
> > I think, the rule for static inline functions in .c files is at odds wi=
th
> > the 'Conditional Compilation' section of coding style.  The section doe=
s
> > recommend to avoid conditional function declaration in .c files, but I'=
m not
> > sure it is reasonable to export internal static functions for that reas=
on.
> >
> > In this particular case we can either define a macro, which is discoura=
ged
> > by the coding style:
> >
> >  Generally, inline functions are preferable to macros resembling functi=
ons.
> >
> > Or create a static inline function, that is against rule of no static
> > inline functions in .c files.
> >
> > Or create a simple static function and mark all the arguments as unused=
,
> > which kind of compliant to the coding style, but the least pretty.
>
> Hi Ilya,
>
> I guess I would lean towards the last option.
> But in any case, thanks for pointing out that this is complex:
> I had not realised that when I wrote my previous email.
>

In that case this version (v7) should be good to go? Are there any other
comments? Or is v8 preferred (the only change is between them is
dropping the "inline")?

Thanks.
Adri=C3=A1n


