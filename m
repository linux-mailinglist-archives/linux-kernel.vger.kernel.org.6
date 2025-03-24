Return-Path: <linux-kernel+bounces-573832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355DA6DCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831CA1710AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A83225FA15;
	Mon, 24 Mar 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="WgWgmzUh";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="LO8CJvm/"
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EE25E460
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826231; cv=none; b=OT45oIiptxxN+Se0UqQugqFi10L729HU+iTvDdk78boqqEs0V3Mz5HTrvYtM1JpX5C++wzhKfRYgaCjrb6rAXPx70bmE771WtqFpPhGWyr7eC4s1YYS1srRqm6gLnCi0sEg2cQVr2ryQ+dAQp90oC8u+W7DOrXvuE5uXq/goeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826231; c=relaxed/simple;
	bh=ToFyzl6GSpIn6zHTY33rxgKFVEyEWn3ZHzthUGrGIec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+28h82Q3dYfEk+uwYUhlkHUgzHYTYLH0/yWfzxZi7Drjx+ab2Kvwf2FPk2ve3WBKpnNJFlBFBLd9ZoJzp/J+sv3iEvkFytuAVOgBOJ8JrLdf98/KaGsx0r3gbCJVU2UmUtnmh5DWKh8aiG9h9nIIkhwrc+OlSWm6z+u0wAL76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=WgWgmzUh; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=LO8CJvm/; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742825317; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=zaXxgjvCin+rYsk8n7kZ8AobdkmIqB6g2RtdWZJsd+g=;
 b=WgWgmzUhWuCxY+4dbq0MoqCGPVETdk5a6/hchjC8DmqWJB20B5UIxv3P8aaiVmbhw3c7J
 pZRqhOqoUMj2TDF0g1jBwDI2THwOAE9+ig1A/c5Ss/gr4bMPSbC6myxSHpHJD/eicGgXVDX
 kClgTBh33u9PnHO20UzwMWK4S4JGnoUjbh49aYCWRNnDOpvLmcwtGrSknyriEq5Ez12T02x
 Yd7E9A5d1odTBHgozRwlTPWM5yn1B1iaJ4hjce39Lr4pDQPT6GAbZQDsIA0u2hV34FodHqB
 4GzCbGqJRLafLpPwIFtkJEyyyr/E0y7XNy4HyfryIctI1hdyczUrzP6W+s4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742825317; h=from : subject
 : to : message-id : date;
 bh=zaXxgjvCin+rYsk8n7kZ8AobdkmIqB6g2RtdWZJsd+g=;
 b=LO8CJvm/FvGgirqhIap8l4McedVo49YJ+szQxkml7niqaub3AvlgOVdvP8yX8OkvC+vOI
 O1Smp0Db4EIZmsL5Oh4TNnQRPBOucD3vKj5Dj3m1deW20afm8DmgvdYUA4Ol1nsMVmxNebT
 gicly7lAqWkeuTQpGRXGocxKyfwY6Wl04qL9xbkq2Gm2oDmJ8BaBEyYqs3e4QhK0qaZDZsD
 BM215r9REPJ21WF4N7fStaPvLZUhJkXYbkq9lTcbynRuysnI97jF2+89d22U0YY3vhIapst
 A8esnZEKEUJr8OsqI0eVk04A2K9MaoEuF8LoTH0PTQnu3t175d0zBhSN/2XA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twiTj-AIkwcC8jqrf-Hs44;
	Mon, 24 Mar 2025 14:08:35 +0000
Date: Mon, 24 Mar 2025 15:02:28 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
Message-ID: <Z-Fl9OUQ1EAEWW7h@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sK0fTxuVRN
X-smtpcorp-track: P0ErzDho94Qi.DD4jW5S3gZf9.9wFLkgl_P6o

On Mon, Mar 24, 2025 at 01:17:08PM +0100, Johannes Berg wrote:
> On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> > The ieee80211 skb control block key (set when skb was queued) could have
> > been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
> > already called ieee80211_tx_h_select_key() to get the current key, but
> > the latter do not update the key in skb control block in case it is
> > NULL. Because some drivers actually use this key in their TX callbacks
> > (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
> > below:
> > 
> >   BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
> >   Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440
> 
> 
> Maybe should have a Fixes: tag?

Finding a fix tag is not easy for this case because I am not sure which
commit exactly introduced the issue. Is it the introduction of
ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
queued on another dev to be processed or the one that introduced
ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?

I would have said the latter, what do you think ?

> 
> And please also tag the subject "[PATCH wireless NN/MM]".

Sure I have seen the new subject tag discussion too late unfortunately.

> 
> > +++ b/net/mac80211/tx.c
> > @@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
> >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> >  		return TX_DROP;
> > +	} else {
> > +		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
> > +		 * could have been called to update key info after its removal
> > +		 * (e.g. by ieee80211_tx_dequeue()).
> > +		 */
> > +		info->control.hw_key = NULL;
> >  	}
> 
> I'm not sure this looks like the right place - should probably be done
> around line 3897 before the call:
> 
>         /*
>          * The key can be removed while the packet was queued, so need to call
>          * this here to get the current key.
>          */
>         r = ieee80211_tx_h_select_key(&tx);
> 
> 
> I'd think?

I initially did that, but because I ended up with the following:

+	info.control.hw_key = (tx->key) ? &tx->key.conf: NULL;

I found it more readable to do that directly in
ieee80211_tx_h_select_key(). But I don't have strong feeling about that.
So both ways are fine with me, let me know which one like the most ?

-- 
Remi

