Return-Path: <linux-kernel+bounces-190571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA418CFFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4B51C21371
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0DC15DBC7;
	Mon, 27 May 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxIAVzV/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD03C463
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812552; cv=none; b=UMj72XterCymEksPn9EEDdkd6d7Za3OR3h+aeNS6H/tqhXhbMz3ow0h0SE0zy/rrdg0RSDAiGPmiJVtLWMr6DjGpJ8ONqgmrUQxQkceqavB9ZJ/jjKrRreO+4UW7+UTXcPs+gE8f4zKK1hSozuILrs5ef6T5z28pAWKJBhPSsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812552; c=relaxed/simple;
	bh=D6/X4Q+ZVx1RfZYyIKjcJ+UXqytanBrJpY1KREx9o0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYuE8goc2DzMOoXMhBYdSmtk7vb9HHs1ow9P8BDvqiYmIjLXWy1bOJYbO7GaH7R7QSKfZc9oxwKpx/pR97hzc+gXnHaLAnilQXWjITc8gz8FREd5vhkb2YmXF+9XzrpOkf/6983VDm1c+hOc+ms7hL12uX7KCU+AtXC9INREuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxIAVzV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716812549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6/X4Q+ZVx1RfZYyIKjcJ+UXqytanBrJpY1KREx9o0k=;
	b=HxIAVzV/P4IbvG3e01gCEjCUIqpvONsajCgaG59EkrWAFOCK8HxGf518KeFpmBr4Yobscu
	jaYyPJbCDQ3yfYeZm6GB99nODz3Fm2XsViOOK26jv64H6HsT+WyQmH7cyUNgs5UzoVvWhY
	eZXAr7/9gBwE73YDUsveCQCWiGdKuk8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-F1fhJY_1OX-_6-pLg5mDjg-1; Mon, 27 May 2024 08:22:28 -0400
X-MC-Unique: F1fhJY_1OX-_6-pLg5mDjg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-24c9f218317so3991845fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812547; x=1717417347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6/X4Q+ZVx1RfZYyIKjcJ+UXqytanBrJpY1KREx9o0k=;
        b=ZCfjtFA8mRyfJQlZqwfYhrZoSPNAORLKr5IPR/SdSA80rulNMm4Ew6pBFbAi2ygkmZ
         VaIV3ciFyYSe9eylV5cHe7nNtvtCse7N7gDS2H8RC52vbdv69n3GCDcHDxBL8Ppg69k5
         5luOtg+yHCV8wfrRiQapqZCTpB4m3ejiQYgGDHKqXjPw65H/x5NJU1SQ8TE1Wx6ALKmW
         il+X/LDR3R+1Er/SpQ0yeeXxC//9oiBzOGYTYiIE46BMaFoXUjLnlLk9c3kapzB4Rvqb
         e1APfGH2yLCFn3PNbQP2S7c8uBVh10Y6Q298VRU+xKL16bHBTsr7Dv7sIizrkVSXuHCF
         DudA==
X-Forwarded-Encrypted: i=1; AJvYcCUUAR+eCR3smBB/z3C9maFbUsUnqp8i7nqdQEPAOc2fit8ZrlgE+W8DhUU96iNVJLnDyo8ZNOf9tQt5f36AjeA//HVZMkR9n8R7Gmgp
X-Gm-Message-State: AOJu0Yxjm6WsHlyieuOG/Bji0dL43msHJ/ZV4Gmwx6vCFXk1pyp9fFYM
	U4LWIoTdF/6Tv0b6A4sb3zisEe4dcqtWBkZMeX2mWJK9nu4quC9Ll6QJfzLl6L6ozd0zTNHP9d6
	KrhlMxijTGLtr4rzU4wkNrtKW18EZ2l1GNHDJhz/5dwdLvZagWiZF6aqP8tvNanMiwIrkrIzlOO
	0ZKUQl9mkDpVpxHjed2EULbmx47oeMUv/EpdmR
X-Received: by 2002:a05:6870:ecac:b0:24f:ca0b:a416 with SMTP id 586e51a60fabf-24fca0ba9ddmr8660847fac.25.1716812547521;
        Mon, 27 May 2024 05:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpbWE3sG5qxjjbcE+5g10+YLPBcXTh7NIQm64af4KCelQYvybRmXETJ7F3TEfsOhjU3VUcUja1bKEg/ReA+vI=
X-Received: by 2002:a05:6870:ecac:b0:24f:ca0b:a416 with SMTP id
 586e51a60fabf-24fca0ba9ddmr8660830fac.25.1716812547194; Mon, 27 May 2024
 05:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-5-costa.shul@redhat.com> <87wmnrj4uz.ffs@tglx> <87seyfj4h7.ffs@tglx>
In-Reply-To: <87seyfj4h7.ffs@tglx>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 27 May 2024 15:21:50 +0300
Message-ID: <CADDUTFx4XPtAYNUPK03BSFH0p8Z17OCftEb7aq+f6VqpnEWkoA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs
 according to change of housekeeping cpumask
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, pauld@redhat.com, linux-kernel@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello Thomas,

Thank you so much for very valuable feedback!
I've tested your proposal to use the hotplug for the isolation.
It works well for both timers, but managed irqs are not ready for this scenario.

Current implementation is introduced by
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=11ea68f553e244851d15793a7fa33a97c46d8271

How do you suggest to proceed?

> So why inflicting all of this nonsense to the kernel instead of
> cleverly (ab)using CPU hotplug for it in user space:
..


> Or something like that. You get the idea, right?
>
> IOW, the only kernel change which is required to achieve your goal is to
> ensure that changing the housekeeping/isolated property of a CPU at
> runtime is only possible when the CPU is "offline".


