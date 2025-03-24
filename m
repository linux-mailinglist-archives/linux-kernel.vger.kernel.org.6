Return-Path: <linux-kernel+bounces-573912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA29A6DE01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0688B1891444
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FD261385;
	Mon, 24 Mar 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="tJGDcCth";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="n8j2JR65"
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCB2A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829266; cv=none; b=YMQ0Jkx0nqjwRLPEkcEqWuKe7k5QTaZDQk2jnwaxV1T4VmNHAU7LgZ1Rug7vLvaWGT6kOl5D2BuTrObc5MB5UdnIiAymb8NfjfAi3UYWWibKu3u1C6+B9IbFkPN3MECfg767HxZOhzQVgGSyHdYqRLc3WTZSbuIhktXMlpDjpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829266; c=relaxed/simple;
	bh=69WISYTUeyK+qmVhLhIjtcyQ13uXlKzO4on/H7X2VoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ6vgVu2zhBzYsCo6KyIs8xrv7VGd7vp8GuzbZVIvPnDGmJXJduObmjedgM51jc7HduJJjmJyG9P8WkO+B+7bz8nzgUEimXbqJPBuzp/dKayR71MVDxPSSQRxfB0k+So0tfDXtZNrWx7kbCk4NiAyKskeLE5KXkIoDwBQMyjpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=tJGDcCth; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=n8j2JR65; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742829260; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Gyw2dOnwil2HjkxljpAsWuv+tbZspN2iCriGXDWGmYU=;
 b=tJGDcCthR1I0GrS/y72scFMIDzs5raA3FYZeI97j8+2CIv71K2UUF0Q+JV3ReUBxIZpuk
 T9sLxV2E+CY28/YJ+Gfm3dH2tHaFAX6jfn0DICmW7pMngRsxizAp3XW7FyuiwNfwNgJJAC+
 x/6ngMV+C15ISZB+RH+eDjEsfqlWFFDu+CoWIlqcD1rsCDtn8HmenxJ+dbYVkzBKJ7BBYqa
 UPiK5XD+oOlOh+jtWGdPsP21KZnmdGIs5nVEO8DqkIOdpZwSb8Y6M8ltSJVPUEUvTF/3vtK
 IFw7ZBBukY1kYpfOZzH+5OoTzzq0zDvZwu1rirQ1FfJP1H+s1nxLz+p/BoHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742829260; h=from : subject
 : to : message-id : date;
 bh=Gyw2dOnwil2HjkxljpAsWuv+tbZspN2iCriGXDWGmYU=;
 b=n8j2JR654008qFUHfDn1a7boLs6+r0v3NqX4a2aa+4Zs6QHynQQi+rgG1v4k6KKQPbysh
 8rI7WwAWZrFbKcFFQvF4rNM1AIPqbwMc3w9UeDIvuL8T+xqK936mxxOY6f7KDzWZX3deUeG
 IiyeyiJ6aOzSVF7wyMBHknfy3jMyN5qIq7U7/s2fRjlXLVn0BkoWgkYAp45Q4hEwb29eBlr
 p2lDgpR9a8Jl9RFonSNkX4Vw6FLiDdvits8CpNySn2FhJq94z+Khmhh6opzTSICGyLci+hz
 3eLXy7K/S6ci3sRQ+1EP/RmeGMn4VQqJ/8idgAegC3oGJHHiyHyu1FnZueNg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twjVK-4o5NDgrl40B-qkzt;
	Mon, 24 Mar 2025 15:14:18 +0000
Date: Mon, 24 Mar 2025 16:08:29 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
Message-ID: <Z-F1bfP7u6uKMK2g@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
 <Z-Fl9OUQ1EAEWW7h@pilgrim>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Fl9OUQ1EAEWW7h@pilgrim>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sK0fTxuVRN
X-smtpcorp-track: UZjAc0I-jcKj.VWiSFQswETCr.HsI-KAn0StH

On Mon, Mar 24, 2025 at 03:02:48PM +0100, Remi Pommarel wrote:
> On Mon, Mar 24, 2025 at 01:17:08PM +0100, Johannes Berg wrote:
> > On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> > > The ieee80211 skb control block key (set when skb was queued) could have
> > > been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
> > > already called ieee80211_tx_h_select_key() to get the current key, but
> > > the latter do not update the key in skb control block in case it is
> > > NULL. Because some drivers actually use this key in their TX callbacks
> > > (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
> > > below:
> > > 
> > >   BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
> > >   Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440
> > 
> > 
> > Maybe should have a Fixes: tag?
> 
> Finding a fix tag is not easy for this case because I am not sure which
> commit exactly introduced the issue. Is it the introduction of
> ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
> queued on another dev to be processed or the one that introduced
> ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?
> 
> I would have said the latter, what do you think ?
> 
> > 
> > And please also tag the subject "[PATCH wireless NN/MM]".
> 
> Sure I have seen the new subject tag discussion too late unfortunately.
> 
> > 
> > > +++ b/net/mac80211/tx.c
> > > @@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> > >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
> > >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> > >  		return TX_DROP;
> > > +	} else {
> > > +		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
> > > +		 * could have been called to update key info after its removal
> > > +		 * (e.g. by ieee80211_tx_dequeue()).
> > > +		 */
> > > +		info->control.hw_key = NULL;
> > >  	}
> > 
> > I'm not sure this looks like the right place - should probably be done
> > around line 3897 before the call:
> > 
> >         /*
> >          * The key can be removed while the packet was queued, so need to call
> >          * this here to get the current key.
> >          */
> >         r = ieee80211_tx_h_select_key(&tx);
> > 
> > 
> > I'd think?
> 
> I initially did that, but because I ended up with the following:
> 
> +	info.control.hw_key = (tx->key) ? &tx->key.conf: NULL;
> 
> I found it more readable to do that directly in
> ieee80211_tx_h_select_key(). But I don't have strong feeling about that.
> So both ways are fine with me, let me know which one like the most ?

Oh sorry, you meant to initialize to NULL *before* the call to
ieee80211_tx_h_select_key(), sure will do that instead.

-- 
Remi

