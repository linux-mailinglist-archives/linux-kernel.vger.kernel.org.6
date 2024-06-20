Return-Path: <linux-kernel+bounces-222167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88590FDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF227B20BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC954F8C;
	Thu, 20 Jun 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0nW0RDn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC14CDE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868590; cv=none; b=BlqO5+zv1u/y9xbBWdqPwNvVc/bWl01wPhvKOV/7jWSrgg1FB2Z8z9311JWz+pd6hN6hWMPsWLIQUePPAkOtWCdA5pvYO2vz4h1PlH55RxqsMnWB+17h2ev265lkjIn0eMELSDkp+GLU7gtV2B5lSjgB4rdbk3fLiPEWJz6gc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868590; c=relaxed/simple;
	bh=8ZmitoDbH+cVJQHrcxtblPDnuNim+KyNprGyFrJmgUc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNVNO9HZGYocMujHVxVpBI35cktPE6jPaUa0z5UFFwwOUbzyIn6EG955GBeYLlnApoMEFx9pL5ZCUB0WbBYnw0J0oDlnAlL4nqd2G/NnnYyufeFz86HrGROy0MIUVgIQfn5d2pz45BbJ6C2SqQ6jhcGE3PT6uqk3vnsBfdi106w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0nW0RDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718868587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztKOnDGsf2GzDyPBbwHlxz7MtbZW2Vf4Gzu8EVZGA6E=;
	b=H0nW0RDnrxWsyXA1xvO8idgKENQ51VNSTNUWYsaeX3go2RPsFvDpkCaBw2aYoBHJFmIZDQ
	1QkNVnPbG/E17DOtPJMgQHSjomVORPnD67BDeqCZ6T+lzO84yR24H2bTUPAXf/xWLXJgwt
	ayeMT3MqC52Y+NlCiLUICIDeT1etZw4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-u-FK56VkP5-UDArHy43DTw-1; Thu, 20 Jun 2024 03:29:45 -0400
X-MC-Unique: u-FK56VkP5-UDArHy43DTw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ae4c8c30baso6340746d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868584; x=1719473384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ztKOnDGsf2GzDyPBbwHlxz7MtbZW2Vf4Gzu8EVZGA6E=;
        b=k575G6M7ySo2lcsMqtChF+NdnNQe1G6w1rgjeQERe+AxTgYO865RN2SBYRPX6oE6BI
         gORlvvEP1bIyYUACOxGbwdhv6KLvv4BKP+2VZoN0mUK8LqKxA8tZ3kDYfrtAHwJmlJ/o
         lJ2EYOtwMBMeMe8+fF+EMtGC1h4byTK19+GrN21ikW+STXLkE9HZQsRHW57b3Mah0yLe
         Yu3nWSgQz8zxJ/gtUaCserS68kobn4QU/4nyp+jIPXhQUnGP6ttkuEJkgnuv21SbOBof
         IPWIwKnC/cygFmJ1J8RakA1RRN8+9AYIbeaMMfdepFbeytm/iUXXGjXGya67bYPTUfF5
         SNJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhz7LYfBYhNqaBE27Doi98ln3PS5Ly2yDYMohjS1NBRaTSHMiwZfNDmPxy8aMycDDg/L06fd827oL58q1U7cRHm+Wu3CRc721rw25R
X-Gm-Message-State: AOJu0YzKYGdr8BWOxDXGVQffJNgGYCoEDzMY0EohelMzRYzQFzn4L/u0
	a++NwNkqxnBmzbtY2A0Os7qpRUflYu5+P4bYlUtCahf7KRWrTl7mjUGE2Av7EpZPvs8fXTj69OR
	J1vvORZiUDDerBZ65He7rJTLqG+KfjV9nbceTAUxcKHQxxGXp/9OiCgyBnsLTeRdt4Q9vf7ceUY
	DRGQiI0LaCdzVttoirWSHBOF1VT7grDZ+KSVqZ
X-Received: by 2002:ad4:558d:0:b0:6b5:6f9:3690 with SMTP id 6a1803df08f44-6b506f936b8mr32298726d6.36.1718868584640;
        Thu, 20 Jun 2024 00:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtucCfTw18OK/4driyigN7DscgMAJqfUMg8ePNH2mvWjujEgVbf0sK3qaDLw4s0/Ak66TSeuNfD+4wwT5BsSc=
X-Received: by 2002:ad4:558d:0:b0:6b5:6f9:3690 with SMTP id
 6a1803df08f44-6b506f936b8mr32298626d6.36.1718868584389; Thu, 20 Jun 2024
 00:29:44 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Jun 2024 02:29:43 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com> <20240619210023.982698-6-amorenoz@redhat.com>
 <20240619183943.5a41f009@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240619183943.5a41f009@kernel.org>
Date: Thu, 20 Jun 2024 02:29:43 -0500
Message-ID: <CAG=2xmO5jY7Rj=O+ZToRn=aSLXSPc4anzXfZM+_-PxMvqacWhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/10] net: openvswitch: add emit_sample action
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 06:39:43PM GMT, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 23:00:06 +0200 Adrian Moreno wrote:
> > +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
>
> Are you using this one? Looking closely I presume not, since it's
> misspelled ;) You can assign =3D 1 to GROUP, no need to name the value
> for 0.

Good point, thanks.
The openvswitch header seems full of unused names for value 0.
I guess it's OK to break the local "style" if we're improving it?
Or is it better to get rid of all of them in a single cleaning patch?

>
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
>
> kdoc is complaining that __OVS_EMIT_SAMPLE_ATTR_MAX is not documented.
> You can add:
>
> 	/* private: */
>
> before, take a look at include/uapi/linux/netdev.h for example.

Thanks. Will do.
--
Adri=C3=A1n


