Return-Path: <linux-kernel+bounces-217284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F190ADCC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59CFB23678
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829C194AF1;
	Mon, 17 Jun 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/wW7sfA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08544194AC3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626730; cv=none; b=Alz6a7zmPl3u3b+kZNpmNLZ56YerisOh4BXHEzWng9nGNyLXlSTljs+K1eXa6C3fio8lgliUAIpetZ09ymgrXBG3HOe08Xb/lq/RUI5Y5CHNjnkkSYv8QfQW334I/pSYuPQud/Sj3O1WhafWdNf0XPUjcVVtl9yaWDKe2Ld+tEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626730; c=relaxed/simple;
	bh=KvunzI4WddNbzqx07uzoYcKYuD+zv2l3SfAVCfDgcos=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQeRYb4QYDl2AvygqQQ86/ISv37wdEkUjTYe7iyRFjT9VsXT6f3pQEdfMjbYkAneAq42ac8k8DYr/Xpf5n6ZB2N6j41Of1ZBZTczrQUg0XdQAgUYFbhvQx1pOF6gUwL1AmlgCCDTEQQ4vvoEmbuj4PIDQNkDMVSoe6jUUVr4DWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/wW7sfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718626727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tunX5zHKdUC3AI9UXbpm7ZTTyILRGRESycSxcecMcRU=;
	b=J/wW7sfATPIByg5PHH65D3rWmuQ0jyIpNHD75jtQDTJ6OkhhaxLG+JCA5Wae+CH7QCBVKG
	zSb1JRhd/Eqd/a+l7uSjgCIgW7siTyYCh2qfhLt1v8z65BdTg3vJJYCbqDmFxIkGMjmxU8
	+ax82n1h+9DAUKu72QTuqwfjyDW8F+w=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-vgIroBymMXmLNV9XZBjy4g-1; Mon, 17 Jun 2024 08:18:46 -0400
X-MC-Unique: vgIroBymMXmLNV9XZBjy4g-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f96cda706aso4435922a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718626726; x=1719231526;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tunX5zHKdUC3AI9UXbpm7ZTTyILRGRESycSxcecMcRU=;
        b=hrwnta0rO6fKZXKUgkwRT6t+c7ka010DY5oAGgmv3cD9GxaSt3pVJX2BwmitGM4qez
         m4nxGcltIdu4n/dy9jAXKjoh3rRZg4XLPduwz53TLkGeL9NWzpoIfkgekHS5UeVZKi3i
         TLazfycPGDueojstP4UR+E8cec29et3uaUVO0Zv52MqssFvwzR6qYXFZgiIviWsvE2Ga
         +o/UTT5eYi9iUDFckhsKzoZDbZPO17alqU3+BScjmmlSBbp1V5YT4YS6AkjZJR+cNjza
         eE7/W2I+BynEwEY6OWBFyYzItHFstXoK3u6qiT92rRgRMHoRXfBt78FuHO10cNpWOsvU
         /UuA==
X-Forwarded-Encrypted: i=1; AJvYcCXQUBGzN6oUvtU5F17jLSdxMX1tOc5Am7kSfQOwtobGUi7k7M5IlAn4dUg0e/uxGpxoOmiPornNUuo8vfBYCLz9abcZ33Q5sZCNKE0N
X-Gm-Message-State: AOJu0Yyhhtj+dy1eC62Szuo09B+PGTrS8sac253qmWc/upLZmaOwyFub
	DluLtDvF3WfXaqlDIi24ortXl+Y8VB88GqfEEA/ZlELzJUVjcNgXmy2iOp07zFxo/MaG0Vm/Fdf
	56iNfe95j7M9z2JmC//6RCdq2ABlUbmNhK1n0RtOPYox9v/+W69T5YPOqQrfuRrpc5k5OpyMIUy
	q9qVG2N7mWk7EvdqAH+ktcCSgVlvgKJaoZ3aok
X-Received: by 2002:a05:6830:ed3:b0:6f9:5973:f8a9 with SMTP id 46e09a7af769-6fb9350becfmr9976820a34.15.1718626726045;
        Mon, 17 Jun 2024 05:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8X+Za17I50Yv6y0RBTKSevi/gJ0mG8u7aZJi4dWAzQeI1Az78m6u18o0HaIn0rByznMj0/F6LcjBvczbAIRs=
X-Received: by 2002:a05:6830:ed3:b0:6f9:5973:f8a9 with SMTP id
 46e09a7af769-6fb9350becfmr9976804a34.15.1718626725697; Mon, 17 Jun 2024
 05:18:45 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 12:18:44 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com> <20240613181333.984810-4-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240613181333.984810-4-aconole@redhat.com>
Date: Mon, 17 Jun 2024 12:18:44 +0000
Message-ID: <CAG=2xmM_z28JA1hm_PxATrUxB96miqpVRT4-WO+MHfFeaYZwPg@mail.gmail.com>
Subject: Re: [RFC net-next 3/7] selftests: openvswitch: Add set() and
 set_masked() support.
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 13, 2024 at 02:13:29PM GMT, Aaron Conole wrote:
> These will be used in upcoming commits to set specific attributes for
> interacting with tunnels.  Since set() will use the key parsing routine, we
> also make sure to prepend it with an open paren, for the action parsing to
> properly understand it.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 73768f3af6e5..fee64c31d4d4 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -284,7 +284,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_UNSPEC", "none"),
>          ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
>          ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
> -        ("OVS_ACTION_ATTR_SET", "none"),
> +        ("OVS_ACTION_ATTR_SET", "ovskey"),
>          ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
>          ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
>          ("OVS_ACTION_ATTR_SAMPLE", "none"),
> @@ -292,7 +292,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_HASH", "none"),
>          ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
>          ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
> -        ("OVS_ACTION_ATTR_SET_MASKED", "none"),
> +        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
>          ("OVS_ACTION_ATTR_CT", "ctact"),
>          ("OVS_ACTION_ATTR_TRUNC", "uint32"),
>          ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
> @@ -469,6 +469,14 @@ class ovsactions(nla):
>                      print_str += "clone("
>                      print_str += datum.dpstr(more)
>                      print_str += ")"
> +                elif field[0] == "OVS_ACTION_ATTR_SET" or \
> +                     field[0] == "OVS_ACTION_ATTR_SET_MASKED":
> +                    print_str += "set"
> +                    if field[0] == "OVS_ACTION_ATTR_SET_MASKED":
> +                        print_str += "_masked"
> +                    print_str += "("
> +                    print_str += datum.dpstr(more)
> +                    print_str += ")"
>                  else:
>                      try:
>                          print_str += datum.dpstr(more)
> @@ -547,6 +555,25 @@ class ovsactions(nla):
>                  self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
>                  actstr = actstr[parsedLen:]
>                  parsed = True
> +            elif parse_starts_block(actstr, "set(", False):
> +                parencount += 1
> +                k = ovskey()
> +                actstr = actstr[len("set("):]
> +                actstr = k.parse(actstr, None)
> +                self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
> +                if not actstr.startswith(")"):
> +                    actstr = ")" + actstr
> +                parsed = True
> +            elif parse_starts_block(actstr, "set_masked(", False):
> +                parencount += 1
> +                k = ovskey()
> +                m = ovskey()
> +                actstr = actstr[len("set_masked("):]
> +                actstr = k.parse(actstr, m)
> +                self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
> +                if not actstr.startswith(")"):
> +                    actstr = ")" + actstr
> +                parsed = True
>              elif parse_starts_block(actstr, "ct(", False):
>                  parencount += 1
>                  actstr = actstr[len("ct(") :]
> @@ -1312,7 +1339,7 @@ class ovskey(nla):
>                  mask["attrs"].append([field[0], m])
>              self["attrs"].append([field[0], k])
>
> -            flowstr = flowstr[strspn(flowstr, "),") :]
> +            flowstr = flowstr[strspn(flowstr, "), ") :]
>
>          return flowstr
>
> @@ -1898,7 +1925,11 @@ class OvsFlow(GenericNetlinkSocket):
>              ):
>                  print_str += "drop"
>              else:
> -                print_str += actsmsg.dpstr(more)
> +                if type(actsmsg) == "list":

nit: I belive the recommended way of comparing types is using
"isinstance":

https://www.flake8rules.com/rules/E721.html

Also, I don't see what can make actmsg be a list. It should always be an
instance of "ovsactions", right?


> +                    for act in actsmsg:
> +                        print_str += act.dpstr(more)
> +                else:
> +                    print_str += actsmsg.dpstr(more)
>
>              return print_str
>
> --
> 2.45.1
>


