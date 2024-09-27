Return-Path: <linux-kernel+bounces-341188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCC987C36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45F61F233F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9EAD2C;
	Fri, 27 Sep 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnhyfkpz"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD23D69
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397984; cv=none; b=oBBeEoLIC0IiS0CL4NsXR/hloroBJtpZ1bSvcqufggWpOpoW9vUkqONDOkMObvU3VLnc06ktL/RDJ5N9kd7Vj1s3sTLTXTYGh0o1UvolqJjMxvbs9sBI/jZ7ZrPLztdo1EEgNRnHuMqR/HQ0dASxeELI2SdlHLb0ED1c6RBx/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397984; c=relaxed/simple;
	bh=z673UoaL8z9ZI/EhvO/Qvk52JJe/KNbu8zqc11/Kyrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhUpgckKE+uFo8lgldsu+bO4x2UDpYexKPeDv5ziE9PAMQXCyVz4DFei7YQKJ1VWZycAE/SEyA1xpT8mT7+Bo5MJBKGr9a3of5BQ55D3cv9wp2ZtWmZFQMze0K+OWOOnQ5QL7DEg7xw5W1k60PCqRmwAwtImI0/NGYB26vYiBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnhyfkpz; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9a3071c6bso154120285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727397982; x=1728002782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK7XIg+h73Lo5G8j4I0+IcwU4eEQuc0allw56ITKwJc=;
        b=NnhyfkpzjRpRvaU4B/7TRiPEO63d3sXq8Ym718Ic/tI7iFRh+Hv2h8WIHKoYQRdGqg
         RxrZ2O1NUgbn3Uuja36qo/AOtdYPICCVhGpm9b30Bh4laYX7O2tMSVg97DdasCNQfzD/
         Xn6blZR5Sun7RjY1IUQCyfzHtHL/xAdd3vOjEfi/HRezT5y5GP6kXQsp002DJD+Xf0NW
         GlW2XlamRb2fGFSmKtqSQgqMzcfdOrz/8sPBGai0SCbIsbFvGY76eCAD3x2hz2wHhCB7
         aYqVifx4f/MEf3nhE70A0IDfxdru92Of2SEmAeKAnRtSSiypdKeeqU2XqW5uIQI9yaRe
         msZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727397982; x=1728002782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK7XIg+h73Lo5G8j4I0+IcwU4eEQuc0allw56ITKwJc=;
        b=OiknUjh2Hg/c+g4S579l9SH2c8AGCKDj9kvlr1x8pJWNwT7+08ZjaY7WZmZ/lDHy+h
         l9WrBZyBGs6lCJMqTdcCId5I+he+/V9RMlOOG6VKI+H3R1VEqfMiKYwJ/7V4D2tY2CKC
         uWd3Cr3BgdGPOkYFyDTGowFT/bK3zXXivYt41pRZup3st9+6ffpKqfoLYLzoCAadRcYx
         vC1MvIFWAxNtxRd860rrFiso9OeNxku8YpoaOxy2NAhprt1qr9G19lSTwCEbdI2BpIom
         jr6FS0dRHdK5Uhd3T3y9gI1sMqbADK67xB+W7wO0CWUQ2Mpc93Sl5/Rt1Xwp/kwOFfgT
         a4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5aYvhXyNNDzDGE5V5l6xPOQ+RdnYKQhoLc3X/BjR3g0q0z7jLqIm8s/+g5Paf8GtDsqstJXTeNuhc5jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRM4Y5Np5FH3K9I34yqBi2D2dvEGLup5WAXl9K84aD/nFRpdso
	5z56a4gXnVqJ0KflmfTQqUYrMssmOEkcAF3oRjUuJko9XQwWto8U
X-Google-Smtp-Source: AGHT+IHcEdRUR5uh4phvhOwDVy1ytm3q7xNabLtSvXHmxYIjsZDoMM4FxTGj/LmhD8w7cRl50pmmEQ==
X-Received: by 2002:a05:620a:1a1d:b0:7ac:b376:e8e1 with SMTP id af79cd13be357-7ae378c3552mr222688685a.46.1727397981585;
        Thu, 26 Sep 2024 17:46:21 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c5f1sm38930385a.74.2024.09.26.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 17:46:21 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7FA271200068;
	Thu, 26 Sep 2024 20:46:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 20:46:20 -0400
X-ME-Sender: <xms:XAD2ZnnDGt6WoiAtzE4WCbg6pjRZyOt2hCdaNaI6q2xDdT92WUk9uw>
    <xme:XAD2Zq0MhgYOhGsAEpjuW0PQmJU763u8vRZBYps-l4AcBH4bPS3CB9Iz4-tntYN3L
    az98TjVrxxm2Q8VIQ>
X-ME-Received: <xmr:XAD2ZtorU-OJ-iFpSOsMIOU45dBVO7JwhmiEcp9Bg_Jo1gZMhiYBJoj8m1Sd0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhi
    nhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthho
    peifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhu
    gidruggvvhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepsg
    highgvrghshieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:XAD2ZvnzqkGcIB4fnpq71-IHlMxk9_VS911VBH7YF-55E-zkXR7vpA>
    <xmx:XAD2Zl1by6BHG37H_NSeYFu3g8frN2wMKTcW-a84odlOMHNB7Uv4UA>
    <xmx:XAD2ZusQTouRqK461UZ81bMsu4VKMLVvMfx9G2_AVMK5jUNqqrRKjA>
    <xmx:XAD2ZpXnsUgP6Dq7kwg-ObDmSGKBW69ADnJIBh26nTUStc9MZDWzgw>
    <xmx:XAD2Zk1F3IU7jGUS3bhtoq4sPhkCyy2aZJSDjxw2GQTxBbSYtWTK3nF1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 20:46:19 -0400 (EDT)
Date: Thu, 26 Sep 2024 17:45:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <ZvYALG8PDrcwMSUb@boqun-archlinux>
References: <f7bd2b3b999051bb3ef4be34526a9262008285f5.camel@infradead.org>
 <ZvWHNLdMCeWwEQZ7@boqun-archlinux>
 <ff9c0a7328c4ead69f9f3b37fe8746ca6a3f03b9.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9c0a7328c4ead69f9f3b37fe8746ca6a3f03b9.camel@infradead.org>

On Thu, Sep 26, 2024 at 05:37:12PM +0100, David Woodhouse wrote:
> On Thu, 2024-09-26 at 09:09 -0700, Boqun Feng wrote:
> > 
> > I won't call this a "perfectly harmless bug", safe_halt() also contains
> > tracepoints, which are not supposed to work in offline path IIUC, for
> > example, you may incorrectly use RCU when RCU is not watching, that
> > could mean reading garbage memory (surely it won't crash the system, but
> > I hope I never need to debug such a system ;-)).
> > 
> > Otherwise this patch looks good to me. Thanks!
> 
> Apart from the fact that I can't count. Apparently I got up to v3 of it
> last time, so this one should have been v4. I just mostly forgot all
> about it, and found it lying around in a git tree a year later, and it
> still seemed relevant. 

My point is calling a non-noinstr function in the offline path is not a
"perfectly harmless" bug, it can cause serious results, so that line in
the commit log is not true. Of course, lockdep should handle buggy code
gracefully, but buggy code is still buggy code.

Anyway, I've taken it into my tree (I removed the "perfectly harmless
bug" part because of the reason above):
	
	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep-for-tip

and will send it in a PR to tip around -rc2 to -rc4, so it will goes
into v6.13 if things went well.

Feel free to send a new version, if the one in my tree needs some
changes. Again, thanks for the patch!

Regards,
Boqun

(you can refer some context here [1], in case you wonder who's this
Boqun guy and why is he doing this ;-))

[1]: https://lore.kernel.org/lkml/Zq5KmTEnalIOHf6a@boqun-archlinux/

