Return-Path: <linux-kernel+bounces-214529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DCA908608
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF36281EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA441836FC;
	Fri, 14 Jun 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTBb7kd8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42321836C7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353137; cv=none; b=Y6R0xxWPmETWkYKvXGfLdbHRDLaGeWYfuvwjFgyC8j6DRr5VPKQ3MprX+n4+ZWx8SncmjEUlePfXJdmBya8VInSKJvht6rH+B/hJ5V2q0frJCNI4NsH+KplHT0IT5IkcOkb7cVlMNi93sfgyCJTTq/fIMU4Jt45z6RnckPpGp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353137; c=relaxed/simple;
	bh=vHbWI1fgikBeglG6cLpRlyipFzW0uVvi9xgjNoaTgnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PECQh2JKJvkYEaOtF3cdx0M8o5Mt52a+roz+MksMXxlLOG+R2SjOTwTS9mF3RR6QL1IwNt3BC/Y85fgkhik0VlJ3SsVsXF8fqmkadIg3UNtr+keG2JUW2nxH5LVbCnCM93nN9ZVe4YzSBy58vMtTuQA9Kti3JdQRHMgrs+OoBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTBb7kd8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718353134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HQALQbVExWflhKtpbFR5K9ctJeKb5Y/FFSLv5vUKGSY=;
	b=UTBb7kd8sZ6u/Exm49s+EdzzJOxWaM5uYJ4Cf+G6MZqfnIwKYtPhLlVgp5fFL7Ef8qJHuZ
	uCcorVtEOY/kMQ2dNigqoGjoQyKUkVMhJcgcw2vQDAT764eSD7jQV/j9r2O60ZMNRrAvOm
	fycsKvK54wtHMlQIMEfBsM0B4BTJFgI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-EREVEpt5Mie5fRXvxrRkWA-1; Fri, 14 Jun 2024 04:18:51 -0400
X-MC-Unique: EREVEpt5Mie5fRXvxrRkWA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f22a02d14so277614f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353130; x=1718957930;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQALQbVExWflhKtpbFR5K9ctJeKb5Y/FFSLv5vUKGSY=;
        b=oCuLPgQtID85Acsc5XllWHcmkoat/v/8SnU0cFd5jVW+c+3C8y1UU/qJ+hH8uRt3GG
         7iaRQvFex8RIAHIjCpxyHgzWfNs6qibsWjCUoF96MGVu3uLMFJ9ttz8WKOcQQyctqMy4
         +xHEc3+GuA4ow/ds6CQzOZKXArgNR9LS/CG9Aj9FvKHXt+5rc/cDrvP7/wZHby2WjYt0
         OvhlrkhUXe92goB/6AoO62NClXQDjDSvaztlkhFxFI2rDtYiExF8wza6X0mPraMZ5cVr
         3RPVZeFA5dcf3UCYqLzXWJXU5tG+qKUoPCYis1+Q+EJFWnxrVQWN8f6OvpdIXO2ONS7q
         jD4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwB7PDbL1qFrFBytMvtrVivkCSa7W1DGW3aKS944IDS+3rtPyaUYlNNBtfjoBZY+ETJSt+QK/pDq0kbPhkHF11WDa3d7tZW63cnBl5
X-Gm-Message-State: AOJu0YyGASqxLte/0A20hKSLd/ViaX5yMZlhlg8DBZPv4zYDQVfA6u4A
	Zk5kt2fEqFR8LkWQjpUvEVJUD9z2e9Ps3ks28JoDrRKmP7nvuombulbI/zJwWoayF+5vmLpM5+k
	aKZcUeD+eiMArZSTTgI1EiTfRKP5JKxZaRJHQ3nNBCgz69GyV0Vv2z4qH3ZGTCelhGgHcJmzd
X-Received: by 2002:a05:600c:1ca7:b0:423:445:4aaf with SMTP id 5b1f17b1804b1-423047d6db3mr15182325e9.0.1718353129910;
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFauQeUPQFQIvZN0vBHK4i6LNbOZkgTwwM5ezjPOyqm72WuIRvn5lKDQmsVAx8f90nCqmz39w==
X-Received: by 2002:a05:600c:1ca7:b0:423:445:4aaf with SMTP id 5b1f17b1804b1-423047d6db3mr15182145e9.0.1718353129492;
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm50844985e9.26.2024.06.14.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:18:49 -0700 (PDT)
Message-ID: <fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
From: Paolo Abeni <pabeni@redhat.com>
To: Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Chris Packham
	 <Chris.Packham@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ericwouds@gmail.com" <ericwouds@gmail.com>
Date: Fri, 14 Jun 2024 10:18:47 +0200
In-Reply-To: <20240612090707.7da3fc01@dellmb>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
	 <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
	 <20240612090707.7da3fc01@dellmb>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 09:07 +0200, Marek Beh=C3=BAn wrote:
> On Tue, 11 Jun 2024 20:42:43 +0000
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
>=20
> > +cc Eric W and Marek.
> >=20
> > On 11/06/24 17:34, Chris Packham wrote:
> > > The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> > > clause 45 MDIO interface and can leverage the support that has alread=
y
> > > been added for the other 822x PHYs.
> > >=20
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >=20
> > > Notes:
> > >      I'm currently testing this on an older kernel because the board =
I'm
> > >      using has a SOC/DSA switch that has a driver in openwrt for Linu=
x 5.15.
> > >      I have tried to selectively back port the bits I need from the o=
ther
> > >      rtl822x work so this should be all that is required for the rtl8=
224.
> > >     =20
> > >      There's quite a lot that would need forward porting get a workin=
g system
> > >      against a current kernel so hopefully this is small enough that =
it can
> > >      land while I'm trying to figure out how to untangle all the othe=
r bits.
> > >     =20
> > >      One thing that may appear lacking is the lack of rate_matching s=
upport.
> > >      According to the documentation I have know the interface used on=
 the
> > >      RTL8224 is (q)uxsgmii so no rate matching is required. As I'm st=
ill
> > >      trying to get things completely working that may change if I get=
 new
> > >      information.
> > >=20
> > >   drivers/net/phy/realtek.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > index 7ab41f95dae5..2174893c974f 100644
> > > --- a/drivers/net/phy/realtek.c
> > > +++ b/drivers/net/phy/realtek.c
> > > @@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] =3D {
> > >   		.resume         =3D rtlgen_resume,
> > >   		.read_page      =3D rtl821x_read_page,
> > >   		.write_page     =3D rtl821x_write_page,
> > > +	}, {
> > > +		PHY_ID_MATCH_EXACT(0x001ccad0),
> > > +		.name		=3D "RTL8224 2.5Gbps PHY",
> > > +		.get_features   =3D rtl822x_c45_get_features,
> > > +		.config_aneg    =3D rtl822x_c45_config_aneg,
> > > +		.read_status    =3D rtl822x_c45_read_status,
> > > +		.suspend        =3D genphy_c45_pma_suspend,
> > > +		.resume         =3D rtlgen_c45_resume,
> > >   	}, {
> > >   		PHY_ID_MATCH_EXACT(0x001cc961),
> > >   		.name		=3D "RTL8366RB Gigabit Ethernet" =20
>=20
> Don't you need rtl822xb_config_init for serdes configuration?

Marek, I read the above as you would prefer to have such support
included from the beginning, as such I'm looking forward a new version
of this patch.

Please raise a hand if I read too much in your reply.

Thanks!

Paolo


