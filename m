Return-Path: <linux-kernel+bounces-327332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F397744A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B0B1F25298
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF21C2DB5;
	Thu, 12 Sep 2024 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HvJ6SrZ4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE21C1AB5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179972; cv=none; b=BIDvl1Snkju5QY8Hjt3MXjgW7ol8yVwGVIFqzrQ+Mu/M3Cw1APVITZ2LEogR+d42P45vS2dxajK9MY5VesShyavPk+9HtArOeN/6CiR0JeQ+fFk78hqgwOdtfLH/RKeOZ9l1lHUmspf18FBoyDFzZ1WmlD34ail/y+nVeP2kXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179972; c=relaxed/simple;
	bh=KbS83rDiWhetHVtFkjA/wbafpTGhtpNgKVkrYNxEn7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsU4ynBWEyVpk1h3GKe60+SrFkTFR9IerB+KRFEPLHfBNiTB94Ty3jRz+Wy45aQb2AjUwjQ7QtTGkyDNNqCeIfDX5vn1RogycH0jsT3bqVEuZCtz3xh2nsAomWZ1x+fp3RxggKdOoxhL3GNCcE+urBqx7j8k6gM5dY5/gHysHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HvJ6SrZ4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so307243f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726179969; x=1726784769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeNLQ4zvks3207JaJjctekem2eb/h7As09d+6h+vRY8=;
        b=HvJ6SrZ4XOg7QdrDfupDUvarrACv/pwoh5022WXxvBgxX9RWRRTeAXUDEiwPxrlk5a
         EJDRaVQOkv+OMxCSG32BiaPWbG3GJHC7WsrIHxRayJTWk1bAl/yfH7017P4WCGQEbaqV
         AyO7GoVlMG6DERPSBFCG0NDHyc/fVXfc/2JOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179969; x=1726784769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeNLQ4zvks3207JaJjctekem2eb/h7As09d+6h+vRY8=;
        b=JN6j0UPpOP+aeEZla+SZYRb4ItZQJ17W8xQ2XK9B08qyAJtppVlIPAMLC3BjZUMie0
         aTpFuZerTWKo0KH0W/NYui6INExW+R5PlA2L8EpBOdHSowqEZ9ThW5X6OHWPeRT3uPmP
         F5ihAw/lKHyvWIOwGot/9hkNbU2dTpMDs+LR5yO2qkdSSBMKvI/swFdtXZ/rjlCcJ38A
         l6GyoQgIt9qyXK8eBubBfi4dxQk3uS/IO8jg5DiHWNh16o4ICN+HHGEEyCPl9ywwRBZJ
         26Q0MeWu5/H1J1vuCzjSrneHfvHj0wKjcwH34m/ngIHCPSoqB6jMZ+DDSXSD1GOKvqZb
         GZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKi26+lkaPu1YsW/L3f0VkZlWxfO1sQX1yi4osnF3xnP2p2+NB/jwGOdwpy0tCClwEUo0PU7RUJTG+3xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMojGWZyfoS+AtKLpKo9qxvHBiUAbJmYtW6/W/TA0FFXiwDQlh
	KzrrY9/kb57BmL9Ne3CBN9+s5/N9ioIZynSJMdyCPV+9w48ieMbs6GKCv7A7dhnQQZ/tA6FteGZ
	UbrCl6w==
X-Google-Smtp-Source: AGHT+IF8qsdD71KVMXJo+fnkee4OZGgKy8KerUC6ORrfTbdZccTTwvsei1wmk/yXskryCGaIRjjmpw==
X-Received: by 2002:a05:6000:1847:b0:374:c160:269e with SMTP id ffacd0b85a97d-378d61e28acmr687273f8f.22.1726179968374;
        Thu, 12 Sep 2024 15:26:08 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cea395sm802949466b.144.2024.09.12.15.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:26:07 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3d87dd4c3so131416a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDEmTPkvHaADeBmI6E0COwKZ6teJ9Un/AKZoJLTVQ74aJG6DFDyIy7Dl9r53PeptYpTFHkGEQX/MA2YQo=@vger.kernel.org
X-Received: by 2002:a05:6402:43cd:b0:5c4:ae3:83bd with SMTP id
 4fb4d7f45d1cf-5c41e193d3dmr666054a12.21.1726179967306; Thu, 12 Sep 2024
 15:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
In-Reply-To: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Sep 2024 15:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Message-ID: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	Dave Chinner <david@fromorbit.com>, clm@meta.com, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
>
> When I saw Christian's report, I seemed to recall that we ran into this
> at Meta too. And we did, and hence have been reverting it since our 5.19
> release (and hence 6.4, 6.9, and 6.11 next). We should not be shipping
> things that are known broken.

I do think that if we have big sites just reverting it as known broken
and can't figure out why, we should do so upstream too.

Yes,  it's going to make it even harder to figure out what's wrong.
Not great. But if this causes filesystem corruption, that sure isn't
great either. And people end up going "I'll use ext4 which doesn't
have the problem", that's not exactly helpful either.

And yeah, the reason ext4 doesn't have the problem is simply because
ext4 doesn't enable large folios. So that doesn't pin anything down
either (ie it does *not* say "this is an xfs bug" - it obviously might
be, but it's probably more likely some large-folio issue).

Other filesystems do enable large folios (afs, bcachefs, erofs, nfs,
smb), but maybe just not be used under the kind of load to show it.

Honestly, the fact that it hasn't been reverted after apparently
people knowing about it for months is a bit shocking to me. Filesystem
people tend to take unknown corruption issues as a big deal. What
makes this so special? Is it because the XFS people don't consider it
an XFS issue, so...

                Linus

