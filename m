Return-Path: <linux-kernel+bounces-525432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3918DA3EFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A64F3BE951
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666A200BBF;
	Fri, 21 Feb 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ONaMuAsV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0A201116
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129591; cv=none; b=Lfakuma5aIGv8XnQxV7Y1ULcbKWgbBTrtXQsgxNz5mEgUU2uys5uAuUGS72Jzqpb9xZwxM6JbfdhvyfkEr5SN8E77vTijOPf2jkc06Co0vQu9v93QmnizqEdvwzaELDnloYULz4gjnPWpsfe7WodOYeHsa8lGGJSLjrpbb0c6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129591; c=relaxed/simple;
	bh=gw6v1tXcUsIpJCh+dr75gO4/HTnsrWShEHggrdXmRLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lts4aOvLpWQIlVZYL8tsa/yN1QC/Lhm23HfrM8l0TtfWgHXQpw+4rqWiXM2qG0mxjbh7UHakpRHqS7VVZVqt0d4O0BYjuRcp0hcTJ0tzhW//MmNbLWUeiAfwGYJLe2PtC2ChREHlZ9TxrXrd5t1a0H+675bBoWy7k+B7luwmQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ONaMuAsV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DGtNm/6Rj3M3I05SqA47GaE+4eGeDnYscf5oZXlZBIE=; b=ONaMuAsVw2TZehARgoay6h+aKV
	n66zx596ZMTDByLqRXHEVGjS0zoW6ol1tXDDpbn3r+hqXRuKgygDp7CRNx7utn8uSZEcKPMCFHtfG
	1jv/dczkx4thJdat+4VkLsNE9XCP0uROKeJTu8dTb01eCGmVPLVunSbPkUD6kyN4ewu3Fkntyq/3q
	yBDAa8/Y5N6rh5FVEa/D8kzGbMtvCslrH9r66Z8E5JONl8e1Z7282RhJiqzObifsS51fjUyD+VlM2
	QxvBKj/X1Bk30U9d9pirnGBvZDzUo5S8q/gOatjRJak9VhcCg3eP+Jcr/D8WBreVVspP96PXn+QDc
	kTWS5PtQ==;
Received: from i53875a87.versanet.de ([83.135.90.135] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlPBe-000227-Sd; Fri, 21 Feb 2025 10:19:10 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Salvatore Bonaccorso <carnil@debian.org>,
 Diederik de Haas <didi.debian@cknow.org>
Cc: Valentin Kleibel <valentin@vrvis.at>, Vinod Koul <vkoul@kernel.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH v2 0/1] phy: rockchip: naneng-combphy: compatible reset with old
 DT
Date: Fri, 21 Feb 2025 10:19:09 +0100
Message-ID: <6647031.K2JlShyGXD@diego>
In-Reply-To: <D7XZZ70KM9NT.14VSJDFUTH0H5@cknow.org>
References:
 <20250106100001.1344418-1-amadeus@jmu.edu.cn> <Z7gosm7PJMR0zCg4@eldamar.lan>
 <D7XZZ70KM9NT.14VSJDFUTH0H5@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Freitag, 21. Februar 2025, 09:57:14 MEZ schrieb Diederik de Haas:
> On Fri Feb 21, 2025 at 8:18 AM CET, Salvatore Bonaccorso wrote:
> > On Tue, Feb 18, 2025 at 12:45:34PM +0100, Diederik de Haas wrote:
> >> On Tue Feb 11, 2025 at 2:03 PM CET, Valentin Kleibel wrote:
> >> >>> Chukun Pan (1):
> >> >>>    phy: rockchip: naneng-combphy: compatible reset with old DT
> >> >> 
> >> >> Applied, thanks!
> >> >> 
> >> >> [1/1] phy: rockchip: naneng-combphy: compatible reset with old DT
> >> >>        commit: bff68d44135ce6714107e2f72069a79476c8073d
> >> >
> >> > Thanks for your work!
> >> > We found your patch after NVMes stopped working on a rock 3A with newer 
> >> > kernels and successfully applied it to kernel 6.1.128 (currently in debian).
> >> 
> >> FTR: I've reported it in Debian here: https://bugs.debian.org/1098250
> >> 
> >> I confirmed it (also) broke on kernel 6.12.8-1.
> >
> > FWIW, we have several users in Debian reporting the problem, so if it
> > can be applied to mainline and then flow down to one of the next round
> > of stable series down to 6.1.y that would be highly appreicated.
> >
> > Diederik, if you were able to test the fix, you might contribute a
> > Tested-by (although as I undestsand its not strictly needed at this
> > point as commit should be on way to mainline and stable series)?
> 
> AFAIK a Tested-by could increase the chances of the maintainer accepting
> the patch, but that has already happened (commit date: 2025-02-04).
> The patch was already verified to fix the problem before submission:
> https://lore.kernel.org/all/20250103171109.2726312-1-liujianfeng1994@gmail.com/
> 
> So AFAICT another Tested-by would either have no effect or a delaying
> effect (adding it would change a bunch of commit IDs probably triggering
> various CIs to run again).
> I'm not aware of anything (else) I could do wrt this patch.

the patch already is in the fixes-branch of the phy-tree [0], sho should
make its way into 6.14-rc shortly.

Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/log/?h=fixes



