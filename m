Return-Path: <linux-kernel+bounces-433274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767899E55D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277A81883DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B908218AB7;
	Thu,  5 Dec 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0WsMBgA"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA51773A;
	Thu,  5 Dec 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403102; cv=none; b=YXskGnDaAMaMJcGi0ekdcBgX1e7gEvEhDneD/nEsAH3tnDUgKVSyGqWhZVfg4Jf6vRBqqeKMjxEMiu0P+WyvtfnSCK2V8kTh0j6Yex2r+NMlbCaANKfHvshbtTIDeRLoftrSbbbV4XRNdruo5YYWL1gk2HVHxO566x43e6OJL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403102; c=relaxed/simple;
	bh=jS4E65byXasH63nw7XWyV1kv5nRvT19nS2OJkpP32N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSq9Uld+Fk5wcq0zKOfRMLFjl/O+ItSdsE9MHomfbohDTCVWv4zXxnQFnX/Yj+kJXiWZBpeKoJY8Sz324YWuibtAlMfNLbhNnAXC1skIgRj3b3IMfo2/seSHNYkvXiNO1a/KtlMxSGFgGB/jvWtEV4D1DbPmEI+1VLvr+ZZ746g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0WsMBgA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3984b1db09so915150276.3;
        Thu, 05 Dec 2024 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733403099; x=1734007899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS4E65byXasH63nw7XWyV1kv5nRvT19nS2OJkpP32N8=;
        b=l0WsMBgA6IgXwTjkwYCXzHpsgF1P9s2cv9WGF4hNTc4Eb9AxK6cp/pcLqM5HQZoM4P
         JvJ45+0MWW491RzfOtVnUa5BuMdKek6jcfu2qfeKBII7LhbndSzKvEvivm/NJrfPubeA
         FXIjOOpw3Af6rpvGa6c2KhkG0Ihf7lHVqGLn3n9moR4YBXTAMYzb1FtUy70I78epLPkV
         /BAM5OMQybay2ZpdohJKt1u2vR8pyNXqYC/qbGOU9q85x2wBfzK+y3MPl+ZashNhL5yg
         gZt4ednGNdl1T7avXi7DeF/rSbMEEoi7yX65bdUvQIk55IX//AwuuIxt9QQs+SKkSALf
         uAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403099; x=1734007899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS4E65byXasH63nw7XWyV1kv5nRvT19nS2OJkpP32N8=;
        b=hJBe6Uklf8UqQqM4aNDbhfmjkyHIrUgq++wxJFNnph2KoqWGh90WV6Wq90cyIast9Q
         Ofruj+BT26DXnLQ2EUfjMg42r7wDV3lsVGFv3rGFAL7/9YWfdHVmC1UdqIg8T+BpXhUQ
         /MQobLuMjE3boJ7EuRtB+X/BgFb7TnWZOaXcEOrnAOaULirE0njbHOd5HEu3pv6AAan1
         OiRYq/BBZaqphO0ruG5mf2CS8UgVwDLi8vybrQNnvaz1N/bWYCVGkZ5v5H8PIj/tftb5
         oeD9MBZ1Hy4xF3HXswxLfr55wMA4DI+j27NmscZ++Yv0PaHoJ+IrIB8GBCvsjdhgMBO+
         E9yw==
X-Forwarded-Encrypted: i=1; AJvYcCX9rhlIpnYuBZTku/dtehueWJn57pwBJBDRVjVQXBdXIBJZ7+wp44jcfYyx521BlHSis8SPj9y/3blH@vger.kernel.org, AJvYcCXsL4/ZDP4Ax6ifC+/RvlM19/69VqQZDt3qFZItE+U5ZlG1ys2pmJS5RIKYGqKexl4o5xRr8KfXXaGh2wIy@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlGb97whMpzLdaS2KJMlMW/yTISFBTD1Y2rWt/46pSywAj+SS
	5CavPYaC43ugHDsg2nNNTEY08y0QeKMlITPnEifEpG4EjYOTFxiunRspIP90OVVOwQhheFZe/q4
	n2Bo6E/aeL3G0+xWtSXnnaKJ/RS4=
X-Gm-Gg: ASbGncvzyHY1IopB/ICUh5wWOxyKo5Jt32a2cyl40NjW3EppqOLO6W2CtdnCC4gffva
	YNcCV6eAJlF3+Bc3XEznKhMlWcepuCQ==
X-Google-Smtp-Source: AGHT+IHX0v+XaBJaQPFuk/qhOCAUGBnokLL70FRyDWpxKkVmlHChQDq7qhPmvE6TqRld9vHwDAhCRVKa0tsQqMwHWhg=
X-Received: by 2002:a05:6902:2407:b0:e39:976e:cdae with SMTP id
 3f1490d57ef6-e39d3c22c53mr10848927276.12.1733403099483; Thu, 05 Dec 2024
 04:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
 <63b3be80-cb6c-49e5-858f-70fd826140c5@cherry.de> <2578458.4XsnlVU6TS@diego> <CAMdYzYr9bULWou5gf43G-AywREWRCOhHmJ-fOQ1cEDWJSmGSdQ@mail.gmail.com>
In-Reply-To: <CAMdYzYr9bULWou5gf43G-AywREWRCOhHmJ-fOQ1cEDWJSmGSdQ@mail.gmail.com>
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 5 Dec 2024 13:51:28 +0100
Message-ID: <CAPv9Zmmz2W6aU16n1NYZvCrMcsXL8QK3d-mtfWy6d0vsTaNYQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on rk3399-puma
To: Peter Geis <pgwipeout@gmail.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Iskander Amara <iskander.amara@theobroma-systems.com>, 
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 2:33=E2=80=AFAM Peter Geis <pgwipeout@gmail.com> wro=
te:
> > > > Cycling through the rx_delay range on two boards shows that is a la=
rge
> > > > "good" region from 0x11 to 0x35 (see below for details).
> > > >
> > >
> > > Is this missing a "there" after that? "that there is a large good reg=
ion"?
>
> That large good region is actually an eye that you are aligning to the
> clock signal. The board is on the tail end of the eye where it is
> barely working. This value is supposed to be tuned to be in the middle
> of that eye. You may want to test the old boards against the new
> boards, because if the original board was tuned correctly something
> may have changed in hardware that caused a significant shift in the
> eye location. Examples of this would be changing to a new phy,
> enabling phy delays, or changes in the trace length. If this is the
> case, you'll probably want to make a new variant of the dts to cover
> this.

Thanks for the comment.

Nothing should have changed on the board, and I dug out a really old
one to verify. It behaves the same.
0x10 seems to be the lower edge of things still working.

I will put rx_delay in the center of the eye with the v3 patch.

I also checked tx_delay, and we already seem to be in the middle of
the eye, so I won't touch it.

Best regards,
Jakob

