Return-Path: <linux-kernel+bounces-341984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18459988945
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E8C282F53
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8021C1748;
	Fri, 27 Sep 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqHbmtea"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94B13CA81
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455473; cv=none; b=H4PE3PLIGEwawzdNXyRG8vDQVBYw9Wpts7acMB1gQsQ6ptGptp6cPlZ7aLI0SkLrwREdJ1L/tNrrXIzYF9nS2yE0ex/vE7i5aBBQmnj/aUOP9zQ2mkDW7XmLueH0Sa8xtmaagzpwMDI0gUSXUT7weMp6qDHBil4gILr02rCz3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455473; c=relaxed/simple;
	bh=C/61GLLGEEVYHtyByRtDw7pPawa+NNpIeX7syWGrSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mrt1AZI621//+yswTZRh+UQ0ROl3FgY8QBUqzXNUj3kiPS/f+X7nXayTrrp2+SugjTJl1I0StMJ7V9iC8E9Kb3PH0332F6qrUeL2ZTszlKf4gKQPZ5ZgbzqZHNmw/cyXZKGD2A9mF9gJKXpK38v0f2B9Hg6y4FqFzsjbu9XnhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZqHbmtea; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso340731566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727455469; x=1728060269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpqzCsLOObKbwWe/AzrIGNw3HOBLR2W9N0IccOsIgU=;
        b=ZqHbmteaT59t7x8Bl6bBV9qGaPNP/Iwph1FfLuoBspZJyL9wtBU2RNIlFVvKLTPNck
         vYZ5h3Nl5IeqUGFY1yhn0NrwCnfr3IqDnKbiHNCKI8UYc9kM2wz/Tk1JSzuWsJDUxvVp
         CHBP1wvMI5Y0HKNW0IwgQuWb4UvHwnJCekEtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455469; x=1728060269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPpqzCsLOObKbwWe/AzrIGNw3HOBLR2W9N0IccOsIgU=;
        b=D2szb2a+xGqgd6SDPg7UWDzGdo3TVkjAAbc47hTCOuVaVYyfbHpv2HzSwognyOuF28
         vNZ51THb+krGYnAP/jjE8Wz4iTMpH0bvhHVZsSM+n6MBohXJW+gtylOIVGUSyJNoIUp4
         QbrDYJftIgRXodHRE+FKVfLJdJ98nOuRlPKOOrD5X4uoBFIT92ZuQSqaJ61fQGitmjA7
         Djxk50CvZjyAUK1zOse7ZW4Lys5m19VXSdK0QNBSmndJ8G4ZtDP1wKrhIftGTE3RSPkw
         raOnU7K/CfHDGCsyc9cVmATlJ1wMiVXP9HBbhA0ufk5XbzcMzJ0nJWNEcrncDYIOx3Ec
         O+mg==
X-Forwarded-Encrypted: i=1; AJvYcCXoX+xnqxJFCCCBqnMQvzfLuZ6u5pX1PXDs2S00XMmZ08oHLqtw7UtmgDz5MIpT0RqTmNQoUA6yV2GHkJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIbd/kXuIpUto8UNr4PSxllv+TPygbat7gkrZQ+kvFjfnTxHY
	lX8sNGD82xQT6jgSaGVd8Nikhs9TetJzqeZiDEkSwNL0+A+Xwz0Ce0jc1xzUBH0qgZE+5vs0CdS
	oAEW1mw==
X-Google-Smtp-Source: AGHT+IE6iqpfQrLzDdozhsxudm1hrmR2k78b5Dh+wEPtECg78y0n9h19knrDZhf98QHpl2M/sSiTJw==
X-Received: by 2002:a17:907:1b13:b0:a86:c1ff:c973 with SMTP id a640c23a62f3a-a93c4a4e10fmr338741166b.47.1727455468891;
        Fri, 27 Sep 2024 09:44:28 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775d23sm153757766b.4.2024.09.27.09.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:44:28 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso340729466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:44:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXSf8eHu6trX+HlE3UuXNDrA6rSn6flKi27UUj+xbzVB/EsW3w9uwMVafg4X34UAj/u0K6GwS6OOenkbo=@vger.kernel.org
X-Received: by 2002:a17:907:748:b0:a7a:b73f:7584 with SMTP id
 a640c23a62f3a-a93c492a391mr352824766b.34.1727455468157; Fri, 27 Sep 2024
 09:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux> <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com> <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com> <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
In-Reply-To: <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 09:44:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
Message-ID: <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 18:38, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Note that ADDRESS_EQ() only hide first parameter, so this should be ADDRESS_EQ(b, a).

Yeah, please stop making things unnecessarily complicated.

Just use a barrier(). Please. Stop these stupid games until you can
show why it matters.

And by "why it matters" I mean "major difference in code generation",
not some "it uses one more register and has to spill" kind of small
detail.

At this point, I'm not even convinced the whole hazard pointer
approach makes sense. And you're not helping by making it more
complicated than it needs to be.

          Linus

