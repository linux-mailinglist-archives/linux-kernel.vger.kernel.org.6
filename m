Return-Path: <linux-kernel+bounces-170936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349C78BDE11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54F8283B56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B914D716;
	Tue,  7 May 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QLgOEwMW"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533314D703
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073862; cv=none; b=UEmNxuf/dMjy0Q09jNYeh0XdivwvIrcwe6SxVE5qafiKhvvCgs2RruBUDMFntvpFb60wXPOa7HJnQxcoPL3aNTJmFRp4i8fN7/HwcuDF3P0YDj/sDQmMWqnVb7pAW9yDy56Pa2Wo3kbjH1a5hTAbvBm5SSn2D8Xwn6soyRkz64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073862; c=relaxed/simple;
	bh=DbtwU8InckKBXtmRVsasd2jzJ8OYWGwrmpwdaL5r02Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcUY1M2O2UpvkHP7XBO6Mgs2HopegwZ5hltidGrmCkPth4/gCVklkTh/OkX6ItkFcJMzoMSOrWdpooCG5SNPqKV0KKmSINqdL7oR5Fcl8V2xhiChpKbNImmaeOzHkcbmUS3TlGT6iiPbz6CxvaoFWGWab8yIi//qfjZ2SOWycvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QLgOEwMW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72EBA424B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715073857;
	bh=L+nK70gt6qYfXCC8GaVCochZ/g6jNnBIwcw8pbcit5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=QLgOEwMW8B+O+PGNDksSKzMS2xYmiwFHdG8TQT65kP6vFf51FtRMKbeuVsyGL87vu
	 m4EudJfjAiPXS7IRGEJ3TRXFfokWcT19bQlvWf+7BEnIW0ed7Wh0mQ6J0YGlO8K4vr
	 oQ9SUi6h4iDKcILhrE7FLoT1N8pJ7J/kfpiDRdu+kRCZkF1xEaiKtkl+pR/JJ1uXE3
	 mZbPiOlywNcYln2n7msO0Nnlp+8lHaePBskKXY/1N1oL+WaM1s5UMU0fEqqt8ObIi5
	 THT3PPep7zmLcKcwFNLZnEoyV+31FWUfVyOdTFIM14XMesIXH/j5ReO6FpWHwO1Zh9
	 gqDFv+w7Ne8HQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34da03e19beso2257799f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073856; x=1715678656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+nK70gt6qYfXCC8GaVCochZ/g6jNnBIwcw8pbcit5Q=;
        b=ss26t1cQNfwQGZyhP7kBQ4/CN1Fho9wMYvXUvhDkGVjAvBMItWSf4ZK8jOshIfvs4W
         roOh9xbVP2Qvbr1G2ey8nT+sNxzcJoOXrZp6dw16r+/xcHgem2OmogkORfp0TZrkf6BD
         c4Qj9wv3LOijBdDTbioDTt3pojZuosNKRYCRzx21zrMUWWEbrN4j10ahrGEZLJJhMGrK
         Onm9P60+EPg1jcuzuYusRJQhjRbuBJD/tEQCcTLsd4Aj21XL9iYCIOWRpZ/gge1I1WlK
         B+KyzYhFpssUl7KbCt/c1LsQaKNp1kPDGo5PrdKcDxV3FRC+Ls2pI3YYapvivKE3/mLg
         ljxw==
X-Forwarded-Encrypted: i=1; AJvYcCVhMtOWRuqPUaYpYeKX32jBaxuGhXQP3HSsFdjzDhn+9EwcnP2rOAd3Jc7JrReO+0/2rux7MTY1U6Su9yRifKPRUnPbtLu+xeRzI4of
X-Gm-Message-State: AOJu0YzGqpdabDXiV7Lqqd9Ft6bNBMn2kL4ItXW1eOU7kSATUpojwGHm
	ANEXYdyaBRZwyatoYycjXr5SksUHynie//kzABk5OGjIX8Pxch3wk3tkRXwVTiBg0NgeReg/PMB
	mQMeW60t2xdQwa4P8h59CvCm4ECwTWb+edn4MsBrLPNuTN6CY8OrFKfu7f0iRXx7pVrt70feQaj
	KhQdoCGJ1vM7w/stF70BH7+5IhYfjD1vbGba7q4hPf6MOyPcVB2Tbo
X-Received: by 2002:a5d:55c3:0:b0:34c:6b36:33e5 with SMTP id i3-20020a5d55c3000000b0034c6b3633e5mr7548858wrw.71.1715073856797;
        Tue, 07 May 2024 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJawWFBRi2pUGfZ2AxzikXotCoi+SGcm4po3SlZ4MEuw3m5XCHXhPk5jDnRdkoqcxw9Tms4qQp5r+6576BHgA=
X-Received: by 2002:a5d:55c3:0:b0:34c:6b36:33e5 with SMTP id
 i3-20020a5d55c3000000b0034c6b3633e5mr7548841wrw.71.1715073856520; Tue, 07 May
 2024 02:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502091215.13068-1-en-wei.wu@canonical.com> <f47e0bb6-fb3f-4d0e-923a-cdb5469b6cbe@lunn.ch>
In-Reply-To: <f47e0bb6-fb3f-4d0e-923a-cdb5469b6cbe@lunn.ch>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 7 May 2024 11:24:05 +0200
Message-ID: <CAMqyJG0kMFShx8Kir17mNZ1rD7SaBt2f_Wpv4ir+5-92v3bNaA@mail.gmail.com>
Subject: Re: [PATCH] e1000e: fix link fluctuations problem
To: Andrew Lunn <andrew@lunn.ch>
Cc: jesse.brandeburg@intel.co, anthony.l.nguyen@intel.com, 
	intel-wired-lan@lists.osuosl.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rickywu0421@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Why PHY is this?
It's the Intel I219-LM, and I haven't found any other device having
the same issue.

> It might be the PHY manufacture has an errata, since
> this is probably not the MAC causing the problem, but the PHY itself.
Yes. The problem seems to be a PHY problem. I'm wondering if doing a
workaround on MAC like this patch is suitable.

For further information, please check here:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240503101836.32755-1-en-wei.wu@canonical.com/

On Tue, 7 May 2024 at 03:39, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, May 02, 2024 at 05:12:15PM +0800, Ricky Wu wrote:
> > As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> > some e1000e NIC reports link up -> link down -> link up when hog-plugging
> > the Ethernet cable.
> >
> > The problem is because the unstable behavior of Link Status bit in
> > PHY Status Register of some e1000e NIC.
>
> Why PHY is this? It might be the PHY manufacture has an errata, since
> this is probably not the MAC causing the problem, but the PHY itself.
>
>         Andrew

