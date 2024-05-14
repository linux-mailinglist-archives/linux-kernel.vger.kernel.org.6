Return-Path: <linux-kernel+bounces-178319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD88C4BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4835C1F22FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995661755C;
	Tue, 14 May 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1kBAYggH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C8156E4
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663305; cv=none; b=QacuFsZYPkiDcdq9JoFhFtBkYHPNFSl3Wr2PV2S+MaKgP3fgwaqPyzypRP3xeOsLzgpfRhU4HJdBbDB6fIt+gyPVNFNKtMxerxJ+EuhgOiI+yhCTcaS0cbUIgBOOxh6mRzCfXy6/NLxQ9lCtI9TX/XGv+DbIVamJIrJMCPfomQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663305; c=relaxed/simple;
	bh=ieIbWlqpi3qncOa+DKFbV5vGmc6SVatErRwe1s69pQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUk/LTwny7+SndXdTq0ZCFB5iZHbvCkLxqQ90hkIo6B7JAhPq0NSw/6Abv1Y1grxrrM9/MELhTg3zCspmxiFCnaM3TRsv9NmB8FqV0EJNmUgVnT9KVMsdKGL4SaR8jFJ8IsCJntGRzDmP8i/hC6GZZoPGR7dQCnHrtZ9mHkoa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1kBAYggH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41fd5dc04e2so31173685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715663302; x=1716268102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a19HgSmq/trWYOKDNko6X/3OBusO+lp3rPBD1dWx/PQ=;
        b=1kBAYggHchw1V0d942orl4mFmP/dzlqaPdoVda+RRlePbbq1Lcw3q+btsmYZRjm+Tf
         CULL8IrLpBY9C0h1NNT9DVPImzciDlP5JrNThKzNI+s+VoSxqUjrckZx/HSPKtd8uFuQ
         TsjSAT0nyvzmVxDODsOqngYdha1JouyfcrQrEAtabyoF0zIemO4aJuZa5ATPKc4BHUrO
         ieKE0F1umG0H9/ytMm3LkaK/5SKr5E+KXPkwM8kX9iWAdUfIuewuxbf18zT4uQBhxWtR
         eV47QyDDev4cH+59U3mik8LrmJSD20qKVwgaZSQF4ELoUisK6FXpVWeNJhQCGohXooF3
         bNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715663302; x=1716268102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a19HgSmq/trWYOKDNko6X/3OBusO+lp3rPBD1dWx/PQ=;
        b=m+iKxL+zm6NsJRr1fHkPTVF5fxU38EULtsMjJRbwq50WQOL4DvsaFjeLjHsx0xD4Qv
         21fJD+fD3gHNqSPns/r8RFil7FTbqURHSusroWNEqsyO+x95G3J6v+RHga0GMQDe8pkI
         ba2eSHFzmdVsrW3lh9kwBvZPVLuupdgOMwKaE69rtKzNuLb/BcabGTr4aJ9RrI7isQFo
         CigSMj6ZqBtubqMpLbFqFaBgDu8051PLtjTdNamiGTSzSMENAy024TZn8jIsHqRqlNgB
         fejhmYYuKmU8RCf5HMVuThGJ2ilRNE+4+IemP81E23dMCiUZyL5TdzoLRWsyCUPX3+Kp
         uRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCXAXd0RzBrExWN4RZw0eKpR2wTG4CQOxHiz53+M6jLjvWrUdptLJ3q+tOWw5G+8aqG5IPo30CZaomlQKumoO6NVxX99iW305o2Ikj
X-Gm-Message-State: AOJu0YxKwSSQLjQmQwvHp8laSquBqR4mLNfvvvJrhbZHyJmHxFoNeYls
	pfgdP7vnqq21LzOISN0orPuhZ/dAR256m0RQ0T2lKW+b5voauoeo54MDsX8A5h4=
X-Google-Smtp-Source: AGHT+IGlBf3IWKGC+J9VINEwYnh1B9uENrrXQXg3NIcAKjXjFsRFaHL1ijjFWUAjW3iOtpw9ewXEQw==
X-Received: by 2002:a05:600c:4f12:b0:420:18e9:86d5 with SMTP id 5b1f17b1804b1-42018e98859mr26458475e9.10.1715663301584;
        Mon, 13 May 2024 22:08:21 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm213889265e9.25.2024.05.13.22.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 22:08:21 -0700 (PDT)
Date: Tue, 14 May 2024 07:08:17 +0200
From: Samuel Ortiz <sameo@rivosinc.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] tsm: Allow for extending and reading
 configured RTMRs
Message-ID: <ZkLxwacH9nt6U9dk@vermeer>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-5-sameo@rivosinc.com>
 <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>
 <ZkHoiYMseU0XqEbR@vermeer>
 <a8ea533bf30c658508875948f29341663360db57.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8ea533bf30c658508875948f29341663360db57.camel@HansenPartnership.com>

On Mon, May 13, 2024 at 08:03:53AM -0600, James Bottomley wrote:
> On Mon, 2024-05-13 at 12:16 +0200, Samuel Ortiz wrote:
> > > However, it struck me you missed a third option: use the ima log
> > > format.  This has the advantage that we can define additional
> > > events and have them published with a kernel patch (the IMA log
> > > format is defined in the kernel).  Thanks to the TCG, it's also CEL
> > > compatible but doesn't require any sort of TCG blessing of the
> > > events.  Plus we also have existing kernel infrastructure to log to
> > > that format.
> > 
> > That's an interesting idea. It may avoid having to extend the CEL
> > spec with a new Content Type, but otoh the current spec defines which
> > IMA events are supported. So adding new ones may require to also
> > eventually extend the spec. But I guess since IMA is a Linux kernel
> > subsystem, changing the kernel code and ABI would de-facto extend the
> > TCG CEL IMA spec.
> 
> That's what I was assuming since the TCG is currently deferring to IMA
> in that regard.
> 
> > Here I assume you're talking about the IMA_TEMPLATE CEL specified
> > format, which is designed to accomodate for the current kernel IMA
> > log format. The main drawback of this format is that the digest does
> > not include the whole content event, making the CEL content type, the
> > IMA tag name and both lengths (for the content event and the IMA
> > content) untrusted for event log verifiers.
> 
> That's only because IMA doesn't yet have such an event.  If we're
> assuming effectively designing an IMA log format for non repudiation of
> external events, one can be added. 

If we were to follow the IMA_TEMPLATE format as our output RTMR ABI for
the event log, adding one or more IMA events would not change the fact
that the event and content type would not be hashed into the extended
digest. Unless we want to specify a different behaviour for each IMA
event, and then verifiers would have interpret the digest construction
differently depending on the IMA_TEMPLATE nested event type. And that's
not pretty IMHO.

Using the IMA_TLV content type would make that cut cleaner at least. A
digest is built on the whole content event, for all event types. And the
content and event types are trusted, i.e. the verifier can securely map
events to the reported event types.

> Although I wouldn't want to be
> hasty: one of the big problems of all options is that no existing log
> format really covers the measure container use case and we're not
> completely sure what other use cases will arise (the firewall rules
> measurements was one that regulated cloud providers seem to think would
> be important ... and that has a periodic rush of events, but there will
> be others).

Right. A new CEL content type would give us more freedom in that regard,
as it would allow us to define our own event content value in a more
flexible way. Instead of the nested TLV approach that IMA_TLV follows,
having one where the T would be a max length string defining the creator
of the event (a.k.a. the attester), would avoid having to formally
define each and every new event. That's where option #2 in the
presentation was heading to.

Cheers,
Samuel.
> 

