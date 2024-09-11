Return-Path: <linux-kernel+bounces-325561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7D975B51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC00B2108C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222D1BB694;
	Wed, 11 Sep 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh7OfAqK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05931B7917
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085201; cv=none; b=nAMeotS2jzW5OM9gCfYvqtAPlCmZsT+SN+bMBJ+/PFjdkuN88wjsE2hvF9d7X9lc6g+bcWVp9G053vC6M2HGY2KA+dCuAwmfJzsJsz9EekEwhFCsAp7O1b9sNBFZBTsLVjNKCXAm9RM1WExXpuLlF4JGNINA/+4Pf+LBDZJNn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085201; c=relaxed/simple;
	bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsZMdMKpO1dU5PlXv198W6hIV82u8T+LkgZqvdOgSQU315fLmXfHDTV/16JxbpMjPmgBMnARGpQV4fsg67gUHg13le6OhNprXlajl5chtEXl4PivqftnE8oeAcDd1p+HkbaNq/Aw3GENVoEU3EXPJrtPIrnXF/JMXDVrfD7fN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh7OfAqK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d64b27c45so31787366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085197; x=1726689997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
        b=wh7OfAqK/weJiKFkUN13DToL9fg6+E1XvOjurEltrOW2rXpsJ6byFUI24DHsTR6oQr
         +9C2k/tqYD9oJTfEQ8sPrAl5d5vIx3nDe+r56AYl67ZBlxM1gJ21yXChlUZrjf9LN8ip
         pXTcOtG8h8YFTNiHDVDd/djlDpvhu+xoQmfkulbdxqj4jQbHJbDiD7jmdp0mIgjnNz0A
         +iHLS6cacl/D5QzlCGhlqm40k3kb9MZGNiO0UvdNmh5TACG97Xum8LyibQaIF8w5yWer
         Ho0Sjf42BPPd8lrYuHQY4I7/NbNw6fAqj7M7DrrDzR00K/V6PSp7mtyFHacG7SicxfO2
         3WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085197; x=1726689997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
        b=lXTn1yHDxLHJnDvzpnwPogHRWaARVrBpPDzUi76jZWr067A6qXmlmLdcCDYP3atRim
         /Ji7NrBdGtJKPP2Oqf4FxffmoEm0Fg+RDgbr2JJ/oNgSSFPKpJB2ntcksqDPZK5e03B/
         IY2Jc+ROBx1ena8CzhZzMXFjV3jS9FW6zW+Qs57mtqb8cKWGM4xhfbNUIT3plS0v+LKk
         y9k7fkOWbU9DIQI2u8Ce00krsKMVOjFLN96q7BwZT11XV22UuOQV6hjIoA4h9H920LS4
         EKfqKIaeFrDvmnknoE+q4TDcfw/cWAMhMI/zvOP82tn4OZqAk9IIJH2CYmWXVpqUk+0G
         aUYw==
X-Forwarded-Encrypted: i=1; AJvYcCWG3VxZflzFFaxaM/CWFbAYelqeJmb6cCph/3ono8YVYF0ZpJlGXh3x5mWXy3yEa9VQy7t0w5MsMRpyBp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHH4OyHK/HNpWX7B7TbWvItH2GNK+r6D8d2APwX23A+l+u81V
	XfPPes/pIyR1cxvVPnyWqS78YfKMrftdCDsqPNLBNDesAH5k1m0ReGIQsLj/fyBiEbPXr00OTvh
	4vsD61Sl6wJR3ZmWyCUK5WisEyFX32yhRtZQ=
X-Google-Smtp-Source: AGHT+IHmK290nFygp6EEmdgHjHHbcvRAsJmqrhscyOIv+qlRglD+XMLEZu7wBC5Z9BykbjmT8X0itqm6UXxPcC36azE=
X-Received: by 2002:a17:907:efdc:b0:a86:9041:a42a with SMTP id
 a640c23a62f3a-a902963a320mr54843166b.62.1726085196764; Wed, 11 Sep 2024
 13:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:06:25 -0700
Message-ID: <CANDhNCp38Zydv-6XBCfWp3gDUhdNVWB76_Asz+oBM3VUoE9JKg@mail.gmail.com>
Subject: Re: [PATCH 01/21] ntp: Remove unused tick_nsec
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> tick_nsec is only updated in the NTP core, but there are no users.
>
> Remove it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks for the cleanup!

It would be nice to point to when/why the users were removed, but from
some quick archeology I didn't find a single insightful change, just a
number of places realizing they weren't using their references to it
and dropping it bit by bit.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

