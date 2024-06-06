Return-Path: <linux-kernel+bounces-203950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F78FE2EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14754B2C4D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899E13DB8A;
	Thu,  6 Jun 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoAzRnem"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C713C676
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664707; cv=none; b=Tt3Jo7ZlhCfWCVXYPMCSRbBUD/+eErBfrMdWfOWG0S0XsyTO2UQPLBcWjKo1am4UVa1+Rz5SRfwRpwEe1vCftj+HG2nEex1ZAFthJDtD0wpdBFH5yrLtYaAEw3fsVYk2GKzH5OHx3P/AnfsTDAE9JIT92u/eoZtjOb5Vk3Ulzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664707; c=relaxed/simple;
	bh=0gjAS+xeIiFVq0XbxUIPmoSznSCJ24z2/5slWqAi/Lw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAGBybyuHzsVnRfow6SKDX0HQiymitW8xhn2OV4UsT1WflNWRcZFBkJvhMHENlsKZpJIlHsqbF4iKlLBX8n98NmEcZUBQCl9tVDkbaGRRHXGppNU4VZdbZNqh3FpyyvRqGxJ1rx1kEeL65lVrduVX3EdFA5HyQlsjq4SO7gvmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoAzRnem; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717664704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ruboI7zvkXbsrncHAHmtsC+lWDyh3cWZrFiVzasUVM=;
	b=KoAzRnemLzYwL5FPpnHjCGfNvPIu4RhluEQzEaxaOom/wLM9LDZDYxMwVgL73IcFmI2FCm
	oxpP9+M2Pgu6Blf83beuTnKS5iOy0Wpw8YZPpnXdvvFNDEo5Lb40aYy466hdt6lKrDY7Jb
	WB0vu26gn+RRopyc5UKUkb4EX6XE2SM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-h-Z4TDRLNZaDbJ_9pK8JLQ-1; Thu, 06 Jun 2024 05:05:03 -0400
X-MC-Unique: h-Z4TDRLNZaDbJ_9pK8JLQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dee902341c0so1128772276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664703; x=1718269503;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ruboI7zvkXbsrncHAHmtsC+lWDyh3cWZrFiVzasUVM=;
        b=EwqvMb5HMhQiMQPbKcJraMHnPn9iO0jlS5sEJw7UMeeotctYQgBHQCme3f0MGTJbk6
         GM+4MYfOr665PXGKv/FBCz5tJD/BXd8vukYuEOXGHe6i7L5qLxgiULYfiWxIptPflzWs
         iHqbWKhDTQQaMu0Mr14/dvILJ7egfKDnbigPoy5I4qB90ApZR67/9DrvxOQ8UyQyr+uM
         J3BGyKAdcOlUpZj+vDg9nHmKiqB/996bt97OIIPs4HpfbhT9ybit01jOPSH5AZIuDvSv
         FFi8m2tGbI4i9hUp25pCdem3yoRy5X+ZFgKl+H6rFRqfm+1Ith6b3aiizoy7iDkI1VGH
         mnOw==
X-Forwarded-Encrypted: i=1; AJvYcCWAbhTMFwOpjmAQOCR5R/453f/5oKsqoX8rUNBl1c2yb6583YE6B+o6A7vUsSo9BhlGA5Uxxe3tE8qiulVmpGO/Mw6WWwbEkxFDS828
X-Gm-Message-State: AOJu0Yy+n2Yyg5AE000jao5Ds+HTW4krgwztBRcSspikBYe5zt5LiUvW
	zv0pCyfApTnraRN++0qxJNOsoPrLah557fGjzSXiO0FOrCD61Q6hDgzGB79pzHeYbS+pXfQXuVN
	0ggrRr9Vwbt10mS3omWMlNtnXiFmDzXEokbzSecC+S5hhxPSLXhg8WTbYU3PbEmloYxCD2biAMQ
	Yx4XbrYc56hrVhvaYDrYmQqeI2FAMJk6PopUeE
X-Received: by 2002:a05:6902:260c:b0:df9:20a2:227f with SMTP id 3f1490d57ef6-dfacad0c216mr5362590276.55.1717664702757;
        Thu, 06 Jun 2024 02:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OUuHz7X7dRHjyo0ZNWBFQUhicRJ5nvBw2LlT1l8R+gnkfcPQkNcyiYasymumWF/5B2+03g0NHTi8OVcdCbE=
X-Received: by 2002:a05:6902:260c:b0:df9:20a2:227f with SMTP id
 3f1490d57ef6-dfacad0c216mr5362567276.55.1717664702375; Thu, 06 Jun 2024
 02:05:02 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 09:05:01 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603183121.2305013-1-amorenoz@redhat.com> <f7ta5k126oc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7ta5k126oc.fsf@redhat.com>
Date: Thu, 6 Jun 2024 09:05:01 +0000
Message-ID: <CAG=2xmNU4i5LwrfaSBNKODyOaR0OqVdxX3B5xhkrkNQX2v=S3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] selftests: openvswitch: fix action formatting
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 03, 2024 at 03:00:03PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > In the action formatting function ("dpstr"), the iteration is made over
> > the nla_map, so if there are more than one attribute from the same type
> > we only print the first one.
> >
> > Fix this by iterating over the actual attributes.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 48 +++++++++++--------
> >  1 file changed, 27 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index 1dd057afd3fb..b76907ac0092 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -437,40 +437,46 @@ class ovsactions(nla):
> >      def dpstr(self, more=False):
> >          print_str = ""
> >
> > -        for field in self.nla_map:
> > -            if field[1] == "none" or self.get_attr(field[0]) is None:
> > +        for attr_name, value in self["attrs"]:
> > +            attr_desc = next(filter(lambda x: x[0] == attr_name, self.nla_map),
> > +                             None)
> > +            if not attr_desc:
> > +                raise ValueError("Unknown attribute: %s" % attr)
> > +
> > +            attr_type = attr_desc[1]
> > +
> > +            if attr_type == "none":
>
> I agree, this is an issue.  BUT I think it might be better to just
> filter by field type up front.  See:
>
> https://github.com/apconole/linux-next-work/commit/7262107de7170d44b6dbf6c5ea6f7e6c0bb71d36#diff-3e72e7405c6bb4e9842bed5f63883ca930387086bb40d4034e92ed83a5decb4bR441
>
> That version I think ends up being much easier to follow.  If you want
> to take it for your series, feel free.  If you disagree, maybe there's
> something I'm not considering about it.
>

I agree. It's better to check field attribute names first. I found this
during manual testing of the "emit_sample" series but I ended up not
needing it for the automated one, so I'm OK waiting for your cleanup
series.

In fact, I also have some patches that try some rework of this part. In
particular, I tried to unify all attributes under a common base class
that would handle printing and parsing. That way, most cases would fall
into "print_str += datum.dpstr(more)" and the "if/elif" block would
shrink significantly.

> NOTE that version is just a bunch of independent changes that are
> squashed together.  I have a cleaner version.
>
> I can also bundle up the series I have so far and submit, but I didn't
> want to do that until I got all the pmtu.sh support working.  Maybe it
> makes sense to send it now though.  Simon, Jakub - wdyt?
>
> >                  continue
> >              if print_str != "":
> >                  print_str += ","
> >
> > -            if field[1] == "uint32":
> > -                if field[0] == "OVS_ACTION_ATTR_OUTPUT":
> > -                    print_str += "%d" % int(self.get_attr(field[0]))
> > -                elif field[0] == "OVS_ACTION_ATTR_RECIRC":
> > -                    print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
> > -                elif field[0] == "OVS_ACTION_ATTR_TRUNC":
> > -                    print_str += "trunc(%d)" % int(self.get_attr(field[0]))
> > -                elif field[0] == "OVS_ACTION_ATTR_DROP":
> > -                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
> > -            elif field[1] == "flag":
> > -                if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
> > +            if attr_type == "uint32":
> > +                if attr_name == "OVS_ACTION_ATTR_OUTPUT":
> > +                    print_str += "%d" % int(value)
> > +                elif attr_name == "OVS_ACTION_ATTR_RECIRC":
> > +                    print_str += "recirc(0x%x)" % int(value)
> > +                elif attr_name == "OVS_ACTION_ATTR_TRUNC":
> > +                    print_str += "trunc(%d)" % int(value)
> > +                elif attr_name == "OVS_ACTION_ATTR_DROP":
> > +                    print_str += "drop(%d)" % int(value)
> > +            elif attr_type == "flag":
> > +                if attr_name == "OVS_ACTION_ATTR_CT_CLEAR":
> >                      print_str += "ct_clear"
> > -                elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
> > +                elif attr_name == "OVS_ACTION_ATTR_POP_VLAN":
> >                      print_str += "pop_vlan"
> > -                elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
> > +                elif attr_name == "OVS_ACTION_ATTR_POP_ETH":
> >                      print_str += "pop_eth"
> > -                elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
> > +                elif attr_name == "OVS_ACTION_ATTR_POP_NSH":
> >                      print_str += "pop_nsh"
> > -                elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
> > +                elif attr_name == "OVS_ACTION_ATTR_POP_MPLS":
> >                      print_str += "pop_mpls"
> >              else:
> > -                datum = self.get_attr(field[0])
> > -                if field[0] == "OVS_ACTION_ATTR_CLONE":
> > +                if attr_name == "OVS_ACTION_ATTR_CLONE":
> >                      print_str += "clone("
> > -                    print_str += datum.dpstr(more)
> > +                    print_str += value.dpstr(more)
> >                      print_str += ")"
> >                  else:
> > -                    print_str += datum.dpstr(more)
> > +                    print_str += value.dpstr(more)
> >
> >          return print_str
>


