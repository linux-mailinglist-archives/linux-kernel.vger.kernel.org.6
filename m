Return-Path: <linux-kernel+bounces-177908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887018C4615
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB89C1C22D91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF262225DA;
	Mon, 13 May 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U2YkRFCI"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25720DCB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621553; cv=none; b=DAObrJjSXlU1XxdgJJ5+QUHA2iAXf9OOQlmyCGl0eeJEITxS7dy5l1ZVFoZoO6kg9I4ymYjy7RcYeoadn35ysbfcprkaKRA2QG9OMG3GiSmL8Npl12UD6Mk4zdAXDO1GpDhE+t29sHtdXhd2totudAZnsJjR7W0lWGoPcjjQa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621553; c=relaxed/simple;
	bh=fXGQ64UwaBGW2PqZrX1S/gcdyXJ/tJlPbgzzA2oT+MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPhsk1aQgRougCoFXKjP8AouT6Oo3QPFd911g7hy+/V35ca5L4LGQwMH6hbQ6ahhktLFVMApQgFxgF3B7MbUpXXMwH6sOGJK+Oyb7YFNbbMclp3dWgUfYLXEaqFRZusemO7VH8KYoqpDruHtLuitpfl5VHnj2G/ORJaUaaBTqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U2YkRFCI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2561184a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715621551; x=1716226351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBskcfG9aM08EQ3NqSBzF1A9Ml9c1SIZv/ydH3cvOC8=;
        b=U2YkRFCI60P/XRuJlR8+NK/0cAsD0Ch4VG/5GHHAOK0awnX1C46PgOVjhkG9rVapxa
         M8E5VklMMQAsHZUeedEdnZzafdaj2EckpYD9g9nuNsTt6CiqumyaTIPtHSyibgsXINV8
         vvuS0+6N5kdPKW4w24p8ZJri96se96SFA3ymY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621551; x=1716226351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBskcfG9aM08EQ3NqSBzF1A9Ml9c1SIZv/ydH3cvOC8=;
        b=dyW90E/zsAzKSZPaGGZg6NdyaN0lj1XHrfxYedVymTpRP1bEuOOCE2CirMCbmd9Elx
         3HAvwzZ4WHEV7EwDfkh/Br+6S1YwZNW6i5SQKH+4soo3TUiWkM3166d+S0+/ky1UmPlq
         auk6FntDVRlspl9egKQRnTKqPMJj0t7pbullAacewE66WB8KepUqjeM3wsgOGTSI7JTN
         M/Az9yZOGVItXbzw47LRhfw+bq85z7BlbPrF9IZ7Gk79khfl+mXytITfsl0I0PvKok4k
         PNTlyw0vyn3uuJeJ+N4oOHmJsnaMJ0C+yByRNMF0IPQ8IeugJZzTGFRqUK7CgeKPPAw2
         tRbg==
X-Forwarded-Encrypted: i=1; AJvYcCWlIzEDuAHviqhN8fnpWVszV4Ah8oA6TdNOaPK1Rc3D9/nkgORX4hgXhrD/iz2Bb9TRiKoHrtANmsF75JYCHjgj2atOyIXWLJgQXMD+
X-Gm-Message-State: AOJu0Yzt86S2+0Cd7qHPDcEgnVOPCqj14X0cjc4tNZMWgqVaYMVg0/RJ
	5W2MbxZflXUFO0i7QuYDoEVryJkA2skjS6RUqyzu8gE5wBYpIYOx2Abh5Ccn5rvvfqjCNHSUvZX
	bfCaxNDgbEEpmEmgrU5LmwQpfyztUMSZvr6PI
X-Google-Smtp-Source: AGHT+IF7+dEtjAXbfnCYpn8cxOY0NsZcjmqTQO78In26AeAGJNxjpO+h8xHhH1On7C8lWFuqkMS0FE5B4iZVrdBg0b4=
X-Received: by 2002:a17:90b:4f82:b0:2a1:f586:d203 with SMTP id
 98e67ed59e1d1-2b6ccd8874amr9380254a91.41.1715621550896; Mon, 13 May 2024
 10:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com> <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk> <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
In-Reply-To: <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 13 May 2024 10:32:19 -0700
Message-ID: <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, richardcochran@gmail.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 10:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sat, May 11, 2024 at 06:12:38PM +0100, Russell King (Oracle) wrote:
> > On Sat, May 11, 2024 at 06:16:52PM +0200, Andrew Lunn wrote:
> > > > + /* This device interface is directly attached to the switch chip =
on
> > > > +  *  the SoC. Since no MDIO is present, register fixed_phy.
> > > > +  */
> > > > + brcm_priv->phy_dev =3D
> > > > +          fixed_phy_register(PHY_POLL,
> > > > +                             &dwxgmac_brcm_fixed_phy_status, NULL)=
;
> > > > + if (IS_ERR(brcm_priv->phy_dev)) {
> > > > +         dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __fun=
c__);
> > > > +         return -ENODEV;
> > > > + }
> > > > + phy_attached_info(brcm_priv->phy_dev);
> > >
> > > What switch is it? Will there be patches to extend SF2?
> >
> > ... and why is this legacy fixed_phy even necessary when stmmac uses
> > phylink which supports fixed links, including with custom fixed status?
>
> And now you mentions legacy Fixed link:
>
> +MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");
>
> This claims it is a 10G device. You cannot represent 10G using legacy
> fixed link.
>
> Does this MAC directly connect to the switch within the SoC? There is
> no external MII interface? Realtek have been posting a MAC driver for
> something similar were the MAC is directly connected to the switch
> within the SoC. The MAC is fixed at 5G, there is no phylink/phylib
> support, set_link_ksetting return -EOPNOTSUPP and get_link_ksettings
> returns hard coded 5G.
>
> We need a better understanding of the architecture here, before we can
> advise the correct way to do this.
>
Yes, the MAC directly connects to switch within the SoC with no external MI=
I.
The SoC is BCM89586M/BCM89587 automotive ethernet switch.
The SOC presents PCIE interfaces on BCM89586M/BCM89587 automotive
ethernet switch.
The switch supports many ethernet interfaces out of which one or two
interfaces are presented as PCIE endpoints to the host connected on
the PCIE bus.
The MAC connects to switch using XGMII interface internal to the SOC.
The high level diagram is shown below:

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
   +--------+                     |                     BCM8958X
switch SoC               +----------------+         |
   | Host   |                      |  +----------------+
    +-------+                 |                     |         | =3D=3D=3D
more ethernet IFs
   | CPU   | =3D=3D=3DPCIE=3D=3D=3D| PCIE endpoint |=3D=3DDMA=3D=3D| MAC |=
=3D=3DXGMII=3D=3D|
switch fabric |         | =3D=3D=3D more ethernet IFs
   |Linux   |                      | +----------------+
   +-------+                 |                      |         |
   +-------+                       |
                                      +-----------------+        |

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
Since the legacy fixed link cannot support 10G, we are initializing to
fixed speed 1G.
>       Andrew

