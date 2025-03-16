Return-Path: <linux-kernel+bounces-563127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195FA6374C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2933AC807
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9B1E1E1C;
	Sun, 16 Mar 2025 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="tcxNN3cm";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ilzp5Mp0"
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E01A5B89
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154806; cv=none; b=nCfLrCBvczUQXrSLHzmwaQZNx7Ei24ZlOk6SWyHXxUIRl8QnyvdjZQsrIAi13fA6jizHns8Z//vVGAO2swnIqe3yPc5dMX+eQ0vcwg2iEExJ8oR2Dz6DWiZpvEFiTFAaoMVYDrTneyvDjWKpXPVcLsFAvA5cAjfJb2Qa2iAKtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154806; c=relaxed/simple;
	bh=H2hnrJCtHReCwTD6Y+SP+QvR8sCc3QUoDc4/K71eQhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhBnEnBRojOjcE2dSkBeLKBX9tg2/i8x3kgyoXZr0B0SwSvT9scVMb/NBdWnNrZyeZQh+jqdduwLRUnjSHQ49f1GKc1HUtKEGbohjtLqv0faEqTWI0R76NPyqeqx4ZnRpyE+mTG1jMuC8Gee8h1JqeKR5/lf6dicw9Tjml5HIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=tcxNN3cm; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ilzp5Mp0; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742154793; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=hUeiXtMpG5c+9kwlc+Cu/oS0ES51kI2lihM7zlWqsG8=;
 b=tcxNN3cmnmyVu4L5uRC9Gu15ELE43tQ8+1NSzeCBBKeqgrHfiA2vNP3oZYnj2DDAdkvgo
 8Lp0696B5rTip38XEbQ/PDnzHuZMep36uzz7zDj6Oroqy5Tysf8h+83XSmSqvncrR2iicUE
 EKQXj8ZFL3cTULB/7W4LJ+UqiGgMfDpXGa2ICV7HEFxZbqd+G+bkcmCPKteB89vg1Xr0Pe3
 qiyTeDCc7ENK7ZPfU7CLQ1jyKIx2kVJshx8rX6/XdvindB4hiFy6oX9UIvrVeyyBzAq+4UF
 6fopAVDQjWsG3hTlIwFf99FELmXnU7wz6DQ5cCLdlZwXjvmHoLd2fmFCII+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742154793; h=from : subject
 : to : message-id : date;
 bh=hUeiXtMpG5c+9kwlc+Cu/oS0ES51kI2lihM7zlWqsG8=;
 b=ilzp5Mp0pIxQCTzjnCzKSMowszFNpz14HGCHmvaw7cbP257OyNyscUjegFfo/IMTHd8Hj
 Z1jVmmTwmD52OWtmgnsJNG6z13gYddCchjdcm6EVv7mfz+VeFzLUUqaeSOd5EQtWrCO24ts
 5P/D+BRaN5RvXYeH7XYEL1/QjY1ud1jCCtnFMKuDSbmxN7mtcZ3LpKHpEfNbrsz0IpFb5lp
 P5iHsdxjrJ/GeQcDoausLyEuEKV96RwcSh88inABagDIwgDOaav/ICEZ17Rfp3kqmMqpyEI
 XqIRlfTD8unjdUCGj/unBQQq8iYiST1JEX+MxBQrmh014Jbz94AEP09NYVNg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ttu2o-4o5NDgrjN4H-n2Hk;
	Sun, 16 Mar 2025 19:53:10 +0000
Date: Sun, 16 Mar 2025 20:47:40 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/2] Fixes packet processes after vif is stopped
Message-ID: <Z9cq3A0bqQxmvo42@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741950009.git.repk@triplefau.lt>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616srkUgvcFJi
X-smtpcorp-track: 1CJJZmvwFlp_.PRM8wGLjVLxR.VaoBWwDF1wb

On Fri, Mar 14, 2025 at 12:04:23PM +0100, Remi Pommarel wrote:
> Those are a couple of fixes that prevent crashes due to processing
> packets (especially multicast ones) for TX after vif is stopped (either
> after a mesh interface left the group or interface is put down).
> 
> The first one ensure the key info passed to drivers through ieee80211
> skb control block is up to date, even after key removal.
> 
> The second one ensure no packets get processed after vif driver private
> data is cleared in ieee80211_do_stop().
> 
> As I tried to explain in second patch footnote, I can still see a
> theoretical reason that packets get queued after ieee80211_do_stop()
> call. But I was not able to reproduce it, so I may be missing a
> something here; making that more as an open question.

And I forgot to include the footnote in Patch 2/2. I was worried that
because the rcu_read_lock() in __ieee80211_subif_start_xmit() is taken
only after the sdata running state it could create a small window during
which a packet could still be enqueued passed the synchronize_rcu() of
ieee80211_do_stop(). But after digging a bit more, it seems that
all __ieee80211_subif_start_xmit() callers (e.g. __dev_queue_xmit())
take the rcu_read_lock() already. So please ignore this last remark.

Regards,

-- 
Remi

