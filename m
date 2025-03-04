Return-Path: <linux-kernel+bounces-545672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175BA4EFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737661890714
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E51F55FA;
	Tue,  4 Mar 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ1WJNTI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0F33998
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126587; cv=none; b=Nxf1zM4wbrseZiJn1+fP0TLpSTMMs34y+nxOe0jOocZ0Ik61p/Xc/BHnfvHHVsfEiaoT0pomCoqcLbhCPsGyLZ6ROW42qUc0I9Ak8jUHAA9gN1mkCW+XijS1YZtps61mAbgIailJtoLnx3Fcfh2n42UaF3ykXSB0BG6qWy9GViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126587; c=relaxed/simple;
	bh=J1zT4ttI1/ipMv4SRCFdEmuAVaIbre469EL8k9w3Oqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl+Ms6i+2r2LAbl2EJsHteNJQFhLqqXr4cRA5ejbc7FJPScAK/CWk7MwcQViS3uPW4K554KKcYIeRUTcGrZcUjQvpdrFNjiyOq94zhg1fzaSSsNAUmd4JWLVF3aH3VXInkjl9WZo91YT4RuVx/wGRTD/y2B/Hy35sYqkBZ2qI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ1WJNTI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5496301c6afso282933e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741126583; x=1741731383; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WX4nyHf58fSCu7WOT40A2wbQKdGUiev3A8Wr+Eeu60=;
        b=SQ1WJNTIFqJWl/1z89p2Xg1lnU80XIQgEHbRmr2cGLrx0l+K6l8MEna0j8MC8qhnAJ
         8xK5HRBKEpLPEZfgn0zoz52oyBG7WUkmdillcjuE/ziBKdeouhUhdySaBIRRJwt+DJiH
         3U4sWo67bstjPyOT11rTbybiV2ByfKn+12ZG9y82KlCrw+MG0Pc1Diblg7Mih18PsbTM
         ZS8VQg5p7HewB7PRQvrUZQj5NUhkQRpLEosPfWA60JbqGgdpjbzUeo8H+A6Ecxy3PXgq
         8ZSmEDc0lkeoEunSnhnZZeqxl9x12LcTj2UoXNT67rHMdp9dUm4PKvjblU6+TrW/V/Qc
         LiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126583; x=1741731383;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WX4nyHf58fSCu7WOT40A2wbQKdGUiev3A8Wr+Eeu60=;
        b=FwNiRsJNoR6kwCCW7QDNvSGxT4FVvgeH07tdYOaznnrOdQRr65SMJkbfDyUGRyvMeL
         o0Bo9n7+8ya9D0Jldrr0zg9MSXYFZrd6SFyfrvGvHMuj8bG34DiE7umOFFu91qivyzZp
         9ynxKIbOEnm+bc1dPne7y7Dgk0HTEbVdilQ3H3QoJXLlMnBrwu/LBQ9B4nVF0irdobD4
         7kjsoMxc2CkCF1T+rsK2AUAv/Ggl+PPRaRjfMwaEwb2LY/i16PY+BuyYhl76SY3eSh1F
         l0FoxiT9Z9PmlG7vbRj9i6MYogYMWTU0OlMXQiscW00usKgfOUzY+CbD6Biw8rhdAzyV
         LIhg==
X-Gm-Message-State: AOJu0Ywtp7ymgN+FN5pL44UfvjSut/fi8jE/7N3Bx8TZJtlL6/w2L4Po
	p0k8THpWXZCZs2PZI15caWUTHeZlnFCiMySTNvy2vlJdYByQsOA4
X-Gm-Gg: ASbGncvRWRWa9K9YncEZe2Jdc3kOfpVZXUICuB86KxaP4TgJHvSBJlt6M6rTXgUfl8+
	oSbrtUrWIonYv3yeAp0dm808L3LrJMgS7RGmp18xmK8N+A4PMHnB3OKTL4nMwN8xW2wkmGi89vu
	tevb36tplHpn+RxOSBZ6Qr4OcuHLFTtvGKwHFqDQQ3LKfbOfUU/UGWpbmSqjJJGhvK5LuYXlEXt
	KxAHJejgDrQ2SOKs+HjCRPVPrTBQxrtlQYSGCZHBjzPDGMhlMo4bSxK7I2sfBlsva8xyRo0/p1L
	iecx7prxUL+HG7J2OWuF6haFiyFCWL+EIY8CTLuEUtkSOg==
X-Google-Smtp-Source: AGHT+IGTaDy82c512qOasiS5NrBQ1bgGqKGq7jC9aALQjNTV4T7hF+u3nl3JLPQQdGDKghZG3WDunA==
X-Received: by 2002:a05:6512:3e20:b0:549:6451:7e78 with SMTP id 2adb3069b0e04-5497d3a04e4mr249202e87.20.1741126583004;
        Tue, 04 Mar 2025 14:16:23 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54961edb9c4sm884053e87.33.2025.03.04.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:16:22 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 29F145A0136; Wed, 05 Mar 2025 01:16:22 +0300 (MSK)
Date: Wed, 5 Mar 2025 01:16:22 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
Message-ID: <Z8d7tm5dQN6dZEvu@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de>
 <Z8YPQn0UpxucZLJP@grain>
 <87sentbyer.ffs@tglx>
 <Z8c-vvnMpPjYRvOn@grain>
 <87mse05yk3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mse05yk3.ffs@tglx>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Mar 04, 2025 at 09:30:04PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 04 2025 at 20:56, Cyrill Gorcunov wrote:
> > On Mon, Mar 03, 2025 at 10:24:28PM +0100, Thomas Gleixner wrote:
> >> 
> >> Welcome. Some quick validation with CRIU would be appreciated.
> >
> > Just tested in criu: works without problem, both modes -- with new
> > prctl and without it. Note that I only have ran separate posix-timers
> > test case, probably virtuozzo team might do more deep tesing.
> 
> Thank you very much!

Thanks for handling this) Also looking into this series I wonder why can't
we instead of mangling ::it_signal zero bit just use ::it_id with negative
value as a sign of not yet fully initialized timer? This would allow to not
read-modify action while traversing bucket hash chain. I mean we could do

static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
{
	struct timer_hash_bucket *bucket = hash_bucket(sig, id);

	scoped_guard (spinlock, &bucket->lock) {
		if (!posix_timer_hashed(bucket, sig, id)) {
--->			timer->it_id = -(timer_t)id;
			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
			return true;
		}
	}
	return false;
}

Then hash traverse won't find the timer until the do_timer_create will do

	scoped_guard (spinlock_irq, &current->sighand->siglock) {
		WRITE_ONCE(new_timer->it_id, abs(new_timer->it_id));
		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
	}

Or I miss something obvious? (Of course when deleting timer we will have to pass
abs it_id for hash traversing).

It looks that in case of many many timers present in the system traversing hash
in read-modify way might be heavy (though I didn't measure of course).

	Cyrill

