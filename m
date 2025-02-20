Return-Path: <linux-kernel+bounces-523223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4DA3D3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A967189E38E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42001EB9F4;
	Thu, 20 Feb 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="MJH3RpHS";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="lJth78Nq"
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174E1EB1A6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041460; cv=none; b=Wov5lbPnT3OQcBShvlHphFGMMQYZHoNjV2lb+wAJorzRNUvNEPzRqwCOknFY9JGfmS4mrFNf0auVFOVaaPiYoKceJjFk7EHtRFuJvgYAbrdDkg8KIFhgL6rdItK6N4MctWQFiip0IRwr+5pNPEgNHi/8XFsLNF2QsKbC5LRDIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041460; c=relaxed/simple;
	bh=QgZGmY/TqYWpoDYiNvrmKxYFkIqjpyQZbJvy2w391GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA2p9N+yB+enqYodhE4HDultHYMj6rp8ysyY/GIopzyl0AWuWXoBw4IpFi9wjWNq/MIJHWG7AaGAXCnClUgkhKR59yapWRtNGMDn3fvsYnjeAcExFMsdEFqAVJUoJrVKxg+q46W7Yql5UT7500Mt1VhIVlRR8ijoaVD6TbBSf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=MJH3RpHS; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=lJth78Nq; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1740041454; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=gZJ9iz0m0ZZ24KhUTBL67qgk84ubyzcFuJB6euCDgcc=;
 b=MJH3RpHSyfgNVIlw8ZUr9nQVJzsr5TucXbXJA8D/9dlJ34VykvEo9MDpb1V60DYyiv7nH
 EgtN8bdaEOAOOcWoHjklravXGHbCRwjAGvMV6s8hkNDxB5I8/Gy7F5VjUyqavZKairTIU3s
 lPPQQX51iB7urspljxue90TtSvx4SfOO9lfQhPNuIrTNDknm7f1jQtBF0cFMrU7he17i+bZ
 33HXjDxPk/GZGoIHqWAiOfEDF7YvsGypSCk3dqOnzjtlHQ5Ui8mlJLHIa8w30hnzthVU2p2
 UFlBnZIdQ1iZ8X4hhs8axIE1JOrRUT+K6YpyJKWK20dc9Ty5x0vLMFage9Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1740041454; h=from : subject
 : to : message-id : date;
 bh=gZJ9iz0m0ZZ24KhUTBL67qgk84ubyzcFuJB6euCDgcc=;
 b=lJth78NqWdzhAkeMvkjv96VB1pyxCH8Kdsz/KaczZyZkeczj8W2N6XxfcqHmMl/MdTGGd
 NVK0Vfs+fCG98IdjF46XUPZYVPp3+rg1qbXRCG/+WC2F7nmGs49HJaNX3cnj2nsLg0JFpXu
 gvWG+ijcAQ/po/sNy630tru+idDikSRgjgW9l6PYmjiW9l6wPhuxR1+OsSlw2HJzCftFAjM
 hXONNQQORAZic75D7iShLk6dpBr+ZTezzJ+/GOIfEo6o543ZdcLVFyR0Jm6lvIqUKZOuujY
 Pu6NZ/jsd24LAz30/hpJtq/6tMtVRgEjVP+zzOQzcqXOJTTRYJkCsG9BMQWA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tl2Gi-4o5NDgrkR7J-pSdS;
	Thu, 20 Feb 2025 08:50:52 +0000
Date: Thu, 20 Feb 2025 09:46:18 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] leds: Fix LED_OFF brightness race
Message-ID: <Z7br2g8Rc9Tkcsle@pilgrim>
References: <26a2690e77671cfe687c5614613fbb6f079f7365.1739959820.git.repk@triplefau.lt>
 <e8ab8707-5ed3-44e6-b52b-a1d6131e7c51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ab8707-5ed3-44e6-b52b-a1d6131e7c51@redhat.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616swgfjtNkJ5
X-smtpcorp-track: Yp6sNbhsaLsO.VD7Wzym0Abfp.7Ix1gw-b0tn

On Wed, Feb 19, 2025 at 12:52:36PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 19-Feb-25 11:41 AM, Remi Pommarel wrote:
> > While commit fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
> > successfully forces led_set_brightness() to be called with LED_OFF at
> > least once when switching from blinking to LED on state so that
> > hw-blinking can be disabled, another race remains. Indeed in
> > led_set_brightness(LED_OFF) followed by led_set_brightness(any)
> > scenario the following CPU scheduling can happen:
> > 
> >     CPU0                                     CPU1
> >     ----                                     ----
> >  set_brightness_delayed() {
> >    test_and_clear_bit(BRIGHTNESS_OFF)
> >                                          led_set_brightness(LED_OFF) {
> >                                            set_bit(BRIGHTNESS_OFF)
> > 					   queue_work()
> >                                          }
> >                                          led_set_brightness(any) {
> >                                            set_bit(BRIGHTNESS)
> > 					   queue_work() //already queued
> >                                          }
> >    test_and_clear_bit(BRIGHTNESS)
> >      /* LED set with brightness any */
> >  }
> > 
> >  /* From previous CPU1 queue_work() */
> >  set_brightness_delayed() {
> >    test_and_clear_bit(BRIGHTNESS_OFF)
> >      /* LED turned off */
> >    test_and_clear_bit(BRIGHTNESS)
> >      /* Clear from previous run, LED remains off */
> > 
> > In that case the led_set_brightness(LED_OFF)/led_set_brightness(any)
> > sequence will be effectively executed in reverse order and LED will
> > remain off.
> > 
> > With the introduction of commit 32360bf6a5d4 ("leds: Introduce ordered
> > workqueue for LEDs events instead of system_wq") the race is easier to
> > trigger as sysfs brightness configuration does not wait for
> > set_brightness_delayed() work to finish (flush_work() removal).
> > 
> > Use delayed_set_value to optionnally re-configure brightness after a
> > LED_OFF. That way a LED state could be configured more that once but
> > final state will always be as expected.
> > 
> > Fixes: fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> 
> Thanks, patch looks good to me:
> 

Actually two additionnal remarks here. The first one is that now more
than before, delayed_set_value store should be seen before work_flags
modification on other CPUs. That means that a smp_mb__before_atomic()
is needed before the two set_bit().

The second one is that delayed_set_value can be bigger than a single
byte, so theoretically store tearing can happen and
set_brightness_delayed_set_brightness() could be called with an invalid
value. WRITE_ONCE/READ_ONCE could prevent that but because the
smp_mb__before_atomic() ensures that the "last" delayed_set_value is
valid I don't mind having very seldom intermediate invalid values.

So I think a v2 with smp_mb__before_atomic() is needed here, what do you
think ?

Regards,

-- 
Remi

