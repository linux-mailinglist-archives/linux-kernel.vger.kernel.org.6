Return-Path: <linux-kernel+bounces-387506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF29B5212
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F981F24300
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A7201020;
	Tue, 29 Oct 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="PcyBCZlJ"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E7206066
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227719; cv=none; b=bDxqL9SlFngqly/3mI/xpYmN2jh4j17jxXrJqMf4xvm1kF9wHa9dYGN2/LAchCrxvpvcTG3p9pceo5S1pF6AOYqVaNqem/siknBK0lG2cAa2qlhEtpm1MrwPW6F1IKxQzdDVgF5RM4relb1mvfWnmakVDrKJzM9t6YV8R5uI3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227719; c=relaxed/simple;
	bh=6HV0S8hXPLg9laP+k0p8fwpJV8/KlnJaTdjInZpFGME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQCQOZegd4fI7lrW6WdglJWugQvd0X10fsviyG+l/cca99q5LxxaHyDPw3pD/hlDuAFhPNISt2+FaY4xMxOl95vYYWMp6U+0kiN0vB8N0aSrduAZ2vKIwo9gTsQD8VMP6rsIrhkfI2K4m39Iddf6iltS9Ce9hGcU0VVbinjTEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=PcyBCZlJ; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 5dydtcZU7g2lz5rGetVSYU; Tue, 29 Oct 2024 18:48:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5rGdtYboqSAO35rGetQKvS; Tue, 29 Oct 2024 18:48:36 +0000
X-Authority-Analysis: v=2.4 cv=L7obQfT8 c=1 sm=1 tr=0 ts=67212e04
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=r4sGFtdbsuTx4_WqIAAA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pbp5kCtKVkek8o0gSz48K3TsDNPAJncgnHaBDwQPGhc=; b=PcyBCZlJekUjqm7r04dR7Io+e2
	et2Ry57xnDlfTZUYCv1ZqARidCMFqIP1GjnahQTjCXVX6mMehc2Nk0mW1T1lfQVYo3bGTdQARNUnk
	+85sinNBCpbi2TvOtv0ig1DP1SEeg4LD+N+X6IshVSJhymzD2HF1YPfqjbTNHHP5L3ugwTd1cauub
	sALIAJGAs+2U1HB5wyCggbIf70lhgSlOthpzdInHHdvTjJx7RQLIBd6Re8q0wVwZPt9iMkV3BiFZS
	zPf41tVxaGm82qpsh9FecLCmI/qmMomgZiYZAtTa1splHNyLAUUYpvYTgLIc+kx19260Dkd4xNZo2
	UQBWJ6AQ==;
Received: from [201.172.173.7] (port=56256 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5rGc-000hnF-0T;
	Tue, 29 Oct 2024 13:48:34 -0500
Message-ID: <26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
Date: Tue, 29 Oct 2024 12:48:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241029065824.670f14fc@kernel.org>
 <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
 <20241029110845.0f9bb1cc@kernel.org>
 <7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
 <20241029113955.145d2a2f@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241029113955.145d2a2f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5rGc-000hnF-0T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:56256
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF3l3A7qyhNj5nKrQ9qQ493Pee9AFRz0Qw2+aFXBJjnswMt3d2Q3AlR/Fu3dKGzmW5XZx+UEXKnSQIZOOqCl8tml2ErPatEgA6/Lme2RaIMsLc4v7Opr
 g3JEd/afV+ST554VUMnKqYJe9q2/1Snmn3vIdBpmBYe5NcKyFpss/kxfyX6WaRvPxNPFem5jZhvMVIM6uHUAdOm+zhiqmPL2qG0zx9BEQRZN5sKPbdgZrPH/



On 29/10/24 12:39, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 12:18:56 -0600 Gustavo A. R. Silva wrote:
>>>> I don't think you want to change this. `lsettings` is based on `ksettings`. So,
>>>> `ksettings` should go first. The same scenario for the one below.
>>>
>>> In which case you need to move the init out of line.
>>
>> So, the same applies to the case below?
>>
>> 	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
>> 	struct bnxt *bp = netdev_priv(dev);
>> 	struct bnxt_link_info *link_info = &bp->link_info;
> 
> Do you mean the bp and bp->link_info lines?
> You're not touching them, so leave them be.
> 
>> Is this going to be a priority for any other netdev patches in the future?
> 
> It's been the preferred formatting for a decade or more.
> Which is why the net/ethtool/ code you're touching follows
> this convention. We're less strict about driver code.

I mean, the thing about moving the initialization out of line to accommodate
for the convention.

What I'm understanding is that now you're asking me to change the following

      const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
      const struct ethtool_link_ksettings *ksettings = &data->ksettings;
-    const struct ethtool_link_settings *lsettings = &ksettings->base;
+    const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;

to this:

      const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
      const struct ethtool_link_settings_hdr *lsettings;
      const struct ethtool_link_ksettings *ksettings;

      ksettings = &data->ksettings;
      lsettings = &ksettings->base;

I just want to have clear if this is going to be a priority and in which scenarios
should I/others modify the code to accommodate for the convention?

--
Gustavo


