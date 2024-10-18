Return-Path: <linux-kernel+bounces-371160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E29A3731
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33821F23054
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6216D4E6;
	Fri, 18 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="t/Gp0m7T";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ZsDjhZvv"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD9188003
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236745; cv=none; b=DvNW1Es02bYMm03kv0PCrsCcLBGFYuSKphb9MrzIerwTqv/2oxMK3IznzA039Utf5FtB0i5YsFawADYFsRmwPTiTIwcJMK0bqiYvm1o/VYyefr6zVsbf1K+8x9GVs7m+T+EdfkUoaPg/KteJ2WSV6wbqVWhlNrjtmcqRYrHXAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236745; c=relaxed/simple;
	bh=ZhaL1Kv0REb9l4nfCMKxPrXkvaeya1vprE3n5Ut4Scs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNrWMzGPl9l9Ozh1R/UkVdoyTaK9sAujJP1dY4xZbE7UfdYxwfkSOs+KLD8MzF7JNyhQua4k90j/rjCN7FHYpzNFexzrpKGS8q4SeUKlbrsQWE49LYPMBzc9mRLc5+XHx6To/Z0lDa09zaGo0YWA22wjyKi6bmwA5I6cN6zQo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=t/Gp0m7T; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ZsDjhZvv; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729237643; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=8PDd4QTcUgUWvTz38ShhzLJf4muGLCDzjQvYxmLqn1k=; b=t/Gp0m7TZ35aF0Bj0i4hYM8tRg
	NtbdFYkTO3BhdVNudEphxUMpFUz1w16PGYONisKh4j7vUXm4fCrnc5EHrJSNBjEdIVOZtmJJIR2ea
	GOrqzF4RKTSGAE330GyldNIQL71L2UcwhixOYkhJF0Qvc8+wo6m+hWM8TXpN2lMhmGD/ieYlcylFU
	bK7vXRkLeHRjNGGjh8AiS3nUmBdt9Ln6a90YjcEEZo3wqBhtDNuJPDn+R+ch0rs31vXJfylYE+lLc
	Iu70nLejYmaC6khApWxHC9+uI2LXZxWNeSkzKDliPXiY2f//xkYlJMEUGf1TqUBaF7LKRWR7Ol6jQ
	DF5AWEoQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729236743; h=from : subject
 : to : message-id : date;
 bh=8PDd4QTcUgUWvTz38ShhzLJf4muGLCDzjQvYxmLqn1k=;
 b=ZsDjhZvvkyYYuDResZu/1hBcx0FC3kf5KPujHFXNskUucy6e4nnnHQ5KA9c1XR3TcZr1Y
 cCz0bhsO4MekTFK7qyKPJPbFPiUHLI7fXF4VH3XnFGukZBLNM27u/ysfK1a9gGUuw7DsTJf
 WYdv7lMwmBCPziTm6kAoQmhlXB1nZ3ITN1vCGh7L414OAnuD7YK7RqIiMRc4mmhtfnsqTit
 p4mow9V9xH2IlI7nBknrd4o3OhvtytjrpI3/Wq+TwgKyI9vwNXTorbEaIFHr3ojyLYBYb8l
 yEoLxNkjYS6WsTTD7JFqNiTK4SM1uXnd7wRWZUilRrAvGfjjv1trKeTrXr7g==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t1hSn-TRjyG1-4L; Fri, 18 Oct 2024 07:31:57 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t1hSm-FnQW0hPkgPp-nZ6G; Fri, 18 Oct 2024 07:31:56 +0000
Date: Fri, 18 Oct 2024 09:32:07 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>
Subject: Re: [PATCH 1/2] wifi: ath10k: Implement ieee80211 flush_sta callback
Message-ID: <ZxIO90syOrMCD-_e@pilgrim>
References: <cover.1728741827.git.repk@triplefau.lt>
 <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
 <f9422f76-4a9f-4b37-8a4e-271b1344668d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9422f76-4a9f-4b37-8a4e-271b1344668d@quicinc.com>
X-Smtpcorp-Track: idOLJlbuGJ8J.7atAI7LKQdGz.EFgMqAGnVQb
Feedback-ID: 510616m:510616apGKSTK:510616ssHRJDegKN
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Thu, Oct 17, 2024 at 02:19:51PM -0700, Jeff Johnson wrote:
> On 10/12/2024 7:13 AM, Remi Pommarel wrote:
> > When a STA reassociates, mac80211's _sta_info_move_state() waits for all
> > pending frame to be flushed before removing the key (so that no frame
> > get sent unencrypted after key removable [0]). When a driver does not
> > implement the flush_sta callback, ieee80211_flush_queues() is called
> > instead which effectively stops the whole queue until it is completely
> > drained.
> > 
> > The ath10k driver configure all STAs of one vdev to share the same
> > queue. So when flushing one STA this is the whole vdev queue that is
> > blocked until completely drained causing Tx to other STA to also stall
> > this whole time.
> > 
> > One easy way to reproduce the issue is to connect two STAs (STA0 and
> > STA1) to an ath10k AP. While Generating a bunch of traffic from AP to
> > STA0 (e.g. fping -l -p 20 <STA0-IP>) disconnect STA0 from AP without
> > clean disassociation (e.g. remove power, reboot -f). Then as soon as
> > STA0 is effectively disconnected from AP (either after inactivity
> > timeout or forced with iw dev AP station del STA0), its queues get
> > flushed using ieee80211_flush_queues(). This causes STA1 to suffer a
> > connectivity stall for about 5 seconds (see ATH10K_FLUSH_TIMEOUT_HZ).
> > 
> > Implement a flush_sta callback in ath10k to wait only for a specific
> > STA pending frames to be drained (without stopping the whole HW queue)
> > to fix that.
> > 
> > [0]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> > 
> > Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
> 
> checkpatch.pl reports:
> WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

It has been reported on mailing list should I put the thread link here ?

> 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  drivers/net/wireless/ath/ath10k/core.h   |  4 +++
> >  drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
> >  drivers/net/wireless/ath/ath10k/htt_tx.c | 32 ++++++++++++++++++
> >  drivers/net/wireless/ath/ath10k/mac.c    | 43 +++++++++++++++++++++++-
> >  drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
> >  5 files changed, 85 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> > index 446dca74f06a..4709e4887efc 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.h
> > +++ b/drivers/net/wireless/ath/ath10k/core.h
> > @@ -558,6 +558,10 @@ struct ath10k_sta {
> >  	u8 rate_ctrl[ATH10K_TID_MAX];
> >  	u32 rate_code[ATH10K_TID_MAX];
> >  	int rtscts[ATH10K_TID_MAX];
> > +	/* protects num_fw_queued */
> > +	spinlock_t sta_tx_lock;
> > +	wait_queue_head_t empty_tx_wq;
> > +	unsigned int num_fw_queued;
> 
> is there a reason to prefer a spinlocked value instead of using an atomic without additional locking?

No reason except to mimic what is done for num_pending. Can move that to
atomic if needed be.

Thanks,

-- 
Remi

