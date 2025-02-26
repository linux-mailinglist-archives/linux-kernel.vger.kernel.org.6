Return-Path: <linux-kernel+bounces-533158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CEA4563D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C603A864A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C926B2A3;
	Wed, 26 Feb 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmoXtens"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7002267B9D;
	Wed, 26 Feb 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553382; cv=none; b=PqbJn0FLfw2SSURnBSdrmYRZJ56HWegsoQkOBY6Aq9MODugZ7lPsMkHqsYkSzLaBbpqjYCJMwRf1EqVlCx5N6PmfqymVkm4ohrT4ko6wSbZRGos8wCrhVLU6IZipYGCAn/pxeAQxFsnH2L14cIYjGXFBu07ot/h8J9fyFHJ+De8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553382; c=relaxed/simple;
	bh=Kqe1gQUtzcqKdab8ZBtaidJEpF+k2xXYoBmxUhCJeMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBRod9t/6/AmFWjZuWQmP8jcd4zHnXWIkEIDt3D+kHfzkd9To0pVca4lH+Iwiu1vPda3Ta+tY0RcKNyBLzwmNgVkbWR2YirdmEFR5IObHRBgV9aPZ8EPnA00VhBQxNMi+kkZJJRNHMro5Rh9LV6XrrAA6V4yzk/TTEx80x25cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmoXtens; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab744d5e567so98856766b.1;
        Tue, 25 Feb 2025 23:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553379; x=1741158179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsFdL7LBIygzcy20JDjI+85CJNQJPpaqLDWDofbFEjg=;
        b=EmoXtensci13Sa1+UyAfXf5JMiuNhLDKxYstDRVZ7NLiaegaOSdGy+SnKHW8WVjLEH
         vEp0qNS6/08blGt/3EgWuX9fiioHrNEpfmZJHQoE6EZGl1MLcBYBAVqo+Ez/GsNWuKbg
         ID2RFhfm2Qy9AG6CzQZNt3voSrZMsLhlUPSVD2e8IJw5PWqHjlIghRHx0z3GCGJGuacR
         KzwWwaGryUaVZKHORySO2V8XIwhCfESeuEJe0IvlukFNMMLrBLZAltQeBUMUPCBhspfp
         hWIu3uNSRo+4I7ff4ro5rOnoWt0GpiTIO4mjUzuWmCADW3KWwsCrfkqmwuLtYqx6ksZ8
         3wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553379; x=1741158179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsFdL7LBIygzcy20JDjI+85CJNQJPpaqLDWDofbFEjg=;
        b=nM1egPxIxzmOhMHxf1kIiuRvW1aue4O7VMdqxflmgHoQH+dOBwC0oS5CIGy4RQMnYU
         UrQ6qf2vM1jnVR/ZdFqG/GOq4HfP+nBjH8ANShAu1R30v7QJ5a78qJ5XSdzH+RZJirQD
         KEin8jcihw7rDE/7y/CFCRNoBt2LY+/YrnDWDQtcqraUdYxD16TnRmzdqXwm3F8Yl53D
         GJ3u7W/IScOrL7cHg2BLR6o2sRJb4VWkYTMcuPE915bV1BDfREwSHwGt8PLydSrMnZ2d
         ZyfZ6uhGV9YPP7nUp/b2kGh7K/fOOER/+FJF9vvPxiajtPsj1pQEk+54ly4u597Sz5DH
         sz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Hi+/buSnj0SAKCqjzyqKunFFB3G3RKDywA3EoQvavwFJwmM7idZ3J6dQhy5IpQxvOlOiYA+7u733@vger.kernel.org, AJvYcCX8hVE1K1fDbS8ezoclMQVwpF8KXj+btXpkrDVaUGOm/yfQt0NwICg6xyX6dtfZqcnsLGp40qeIleX7uvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiF18AqB6JcL8i9GbzPOsWMeHxK8gWqk8EcS7XrwPsCXMG28rY
	bB7LrQPntqYlcOhovvos8Ohbbzz4N8gfre4QrNaVpDzGkqUM53Lp
X-Gm-Gg: ASbGncuEfKZDaH61CeM1R/Sua+/O897ccdCqBQyHPOgxVXjiU3OFst3HHrM2ElKugWy
	Y8NG3nMbCq8gp3k5u5DgQb/PzBtDYdvVYmdkeujmrz9JnCA0T22lmDEorWITlscjOxtQDq+1/Cm
	nBgKfkPqG8UEqRWRSfo/bkh0ihZbN2S0VFRErb02wI+ECxwKvc+SP6G7EIyrl/Wrje2yhukd9+A
	lkg3X/tzKz9fN1ZGBAHoMY3vIA2um/svotMYjQwjLik0a6pY7CdWKSRYuTtqv9muIta5aDf1Af/
	OBLecdy7rr1TQEEGDdhibo30B/I9tO9k0h33IF/6
X-Google-Smtp-Source: AGHT+IHLx4B9QasOhWDgt2i3SkmYkC/M3Wurcf1VMTIobHREkQU+9RTLNyYXcdFo47+x2c33nRzEmg==
X-Received: by 2002:a17:907:7e8e:b0:abb:b411:5e02 with SMTP id a640c23a62f3a-abc0aea5253mr2193603766b.18.1740553378770;
        Tue, 25 Feb 2025 23:02:58 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1a01648sm275856266b.0.2025.02.25.23.02.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:02:58 -0800 (PST)
Date: Wed, 26 Feb 2025 08:02:55 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] usb: xhci: Don't skip on Stopped - Length Invalid
Message-ID: <20250226080255.770ca055@foxbook>
In-Reply-To: <20250226080202.7eb5e142@foxbook>
References: <20250226080202.7eb5e142@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Up until commit d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are
returned when isoc ring is stopped") in v6.11, the driver didn't skip
missed isochronous TDs when handling Stoppend and Stopped - Length
Invalid events. Instead, it erroneously cleared the skip flag, which
would cause the ring to get stuck, as future events won't match the
missed TD which is never removed from the queue until it's cancelled.

This buggy logic seems to have been in place substantially unchanged
since the 3.x series over 10 years ago, which probably speaks first
and foremost about relative rarity of this case in normal usage, but
by the spec I see no reason why it shouldn't be possible.

After d56b0b2ab142, TDs are immediately skipped when handling those
Stopped events. This poses a potential problem in case of Stopped -
Length Invalid, which occurs either on completed TDs (likely already
given back) or Link and No-Op TRBs. Such event won't be recognized
as matching any TD (unless it's the rare Link TRB inside a TD) and
will result in skipping all pending TDs, giving them back possibly
before they are done, risking isoc data loss and maybe UAF by HW.

As a compromise, don't skip and don't clear the skip flag on this
kind of event. Then the next event will skip missed TDs. A downside
of not handling Stopped - Length Invalid on a Link inside a TD is
that if the TD is cancelled, its actual length will not be updated
to account for TRBs (silently) completed before the TD was stopped.

I had no luck producing this sequence of completion events so there
is no compelling demonstration of any resulting disaster. It may be
a very rare, obscure condition. The sole motivation for this patch
is that if such unlikely event does occur, I'd rather risk reporting
a cancelled partially done isoc frame as empty than gamble with UAF.

This will be fixed more properly by looking at Stopped event's TRB
pointer when making skipping decisions, but such rework is unlikely
to be backported to v6.12, which will stay around for a few years.

Fixes: d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are returned when isoc ring is stopped")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 67f3d8128b10..96b90819aec7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2870,6 +2870,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (!ep_seg) {
 
 			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				/* this event is unlikely to match any TD, don't skip them all */
+				if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID)
+					return 0;
+
 				skip_isoc_td(xhci, td, ep, status);
 				if (!list_empty(&ep_ring->td_list))
 					continue;
-- 
2.48.1

