Return-Path: <linux-kernel+bounces-428269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA429E0C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D3C2829EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E71DE4F0;
	Mon,  2 Dec 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RRYBhxz/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018F1DE3BF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168217; cv=none; b=mkj3MpRTJ63e651gr3KV7qDISgnnWTaMCMgT6IUCGOXhQOVx7uavAZ8nuoDJFIfY+i3VX+wZ/ob81FRG6F/GvCB3Y7zOn6z8p76zQ3rtoWDgfOfB7q6eONa2MvDGueTTSKDcTwsuNNMfQ7qShMYIr/zgnSm+8yKJRGmWM4ShAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168217; c=relaxed/simple;
	bh=PMsUv+q/+JfREQxpfuAbt3/PvDuUR3+8vgcngJw4L0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1TtUND3qyGz6YDmCHhjjmkyXhawL0VrSr8qVZxzvKPWtXAiTDgUjkuOYWB7rcBhSEr4DVlZ3rhpz/mLvtG49zHjox8QAQaMgS38VAWKAnviWWsEiZCIWLMFLg/suTvHSVkFs3ja9r4qIFYGdm9ulB+o0/0Ou25eN2hBOwJQLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RRYBhxz/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 11F5E3F233
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733168197;
	bh=W6aZlMtP8KSsoitzGDR7wpyoQGNVRJRxSI2L2J9zakA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RRYBhxz/VzaVyvozlEwzseCiVrxQKH8vMklgaItHTO30W8MIQ1et1tgHZ1ZFyIci5
	 26dExfxtYqwdeLMzfGxGWTNqG1cN3S0Z/KdO72eNKZLypOltU7Qk2IcUQNh6/pKPOy
	 xGQhdS0yEi1BwGJcganCGg5ooGvKNpn6ts+v/HHQjCBn+tvdphLAyDzM7oNDxCk6V3
	 tZ98GmaoSBdQ0VEzrZqCLxH0aTjiPzVdprolCMNOkPMm/A4yudpCpJo9YP5+G17iKS
	 7cOaGWN7zS36PKXdPhjfoNMeA+6AnQon1IO4LlBefrNpN7yw2q78NeQexBmkhb62No
	 +e9FqWD89/P/w==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ffccfce0e7so37599411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168196; x=1733772996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6aZlMtP8KSsoitzGDR7wpyoQGNVRJRxSI2L2J9zakA=;
        b=Q0BrFGUAlGjJ3kkAlksOHGgNQ+xwG6fRpDtDDJozkfBzmwiDA05hgvrXzfvPYZLG6c
         GfJL3sbrqpdxC+/g+ONVIP7CUSciplBcYTIVJf15gXFKpl5auSYcgA2ovkY8nyltmu88
         3s87r1x4OWLTpjyW6gm2sTLfjf4dcEIITo250FlitoOpFNs9HskK5TOTChq8U++BO8vd
         nsl9IS/106sDCxY0hIglcHzd0ZeARre3rBzZ2CyfFnE5mrcluhnUl7trrICN1+fo2PHq
         8fF30+a44JtADvGEyY0wrdVlNS8xsI7tYfxlHwhZcEmpKQ4LhjqTflc0T2PFCCJ9q/yD
         PQZw==
X-Forwarded-Encrypted: i=1; AJvYcCWM+hqHmGxysUxS8qpyWNKZX404Xwa80IjaK/AfR9e/Ik1KQ5HtcGxtmNP2JZ4wrRNfDWp3SVO5P+fARkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp48+xSIw/o3wlGo4t89Rnr61PU6bGQyNRrlhcFOwSFiTDbGhS
	8POkqU4gHz7veO0tiD+vDDI1RHJHIQHxcesniMnxVL984HG2R+1g3tpDLn/fD70MTnZO9iD/wfL
	sPBMosp75XLDrSiUBO4opfNDJ9v1Slk35xhTSemJn7Zo4zHpObc7GFLF5EoJNZhY8ocJ31LOAUy
	Rc1xqWh6ypetEhnfsByNd+rhSk+nqDsWPKHG+REnOA7U6m1X9vAPdT
X-Gm-Gg: ASbGncvTG36cyQluDNOBGf5s5w3s6kJ9avr9O6tJl6TOMfQFgzgrj287x4/fBC7jMiD
	TZmbri++WqC9byF1DCrnC8FbDyJ8suA==
X-Received: by 2002:a05:6512:1249:b0:53d:b4ab:13ba with SMTP id 2adb3069b0e04-53df00d953cmr13276678e87.27.1733168196283;
        Mon, 02 Dec 2024 11:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNSC28E6FM3qQ6WZTcAg556PxdrO7zI2Cs8OXWZhXXHB0JJrG1uq2dPIWuLVrFidClqbG+uIzIJVnnP73V5RM=
X-Received: by 2002:a05:6512:1249:b0:53d:b4ab:13ba with SMTP id
 2adb3069b0e04-53df00d953cmr13276668e87.27.1733168195915; Mon, 02 Dec 2024
 11:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <20241126103427.42d21193.alex.williamson@redhat.com> <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
 <20241126154145.638dba46.alex.williamson@redhat.com> <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
 <20241126170214.5717003f.alex.williamson@redhat.com> <CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
 <20241127102243.57cddb78.alex.williamson@redhat.com>
In-Reply-To: <20241127102243.57cddb78.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 2 Dec 2024 13:36:25 -0600
Message-ID: <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

This approach makes sense to me - the only concern I have is that I
see this restriction in a comment in __pci_read_base():

`/* No printks while decoding is disabled! */`

At the end of __pci_read_base(), we do have several pci_info() and
pci_err() calls - so I think we would need to also print that info one
level up after the new decode enable if we do decide to move decode
disable/enable one level up. Let me know if you agree, or if there is
a more straightforward alternative that I am missing.

- Mitchell Augustin


On Wed, Nov 27, 2024 at 11:22=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 26 Nov 2024 19:12:35 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Thanks for the breakdown!
> >
> > > That alone calls __pci_read_base() three separate times, each time
> > > disabling and re-enabling decode on the bridge. [...] So we're
> > > really being bitten that we toggle decode-enable/memory enable
> > > around reading each BAR size
> >
> > That makes sense to me. Is this something that could theoretically be
> > done in a less redundant way, or is there some functional limitation
> > that would prevent that or make it inadvisable? (I'm still new to pci
> > subsystem debugging, so apologies if that's a bit vague.)
>
> The only requirement is that decode should be disabled while sizing
> BARs, the fact that we repeat it around each BAR is, I think, just the
> way the code is structured.  It doesn't take into account that toggling
> the command register bit is not a trivial operation in a virtualized
> environment.  IMO we should push the command register manipulation up a
> layer so that we only toggle it once per device rather than once per
> BAR.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

