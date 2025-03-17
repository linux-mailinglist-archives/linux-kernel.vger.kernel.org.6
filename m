Return-Path: <linux-kernel+bounces-564152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466BA64EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3498F188BB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940A239586;
	Mon, 17 Mar 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="FxpHM8eN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B723909E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214460; cv=none; b=jsghBmD+OdPz5mB6ICvaKWrPRlLgZ3RTgT1kqjf7FjlBoFne0Xxo3JMb/05E/NF/i17Zwle1gGQpIz3ZCikcOHV/x21sZ/qC6UKE4GY3j+WWQHiNMKXSiHl608T0iPjqUV+U6Ll+tm8Vd4dZYNbOBhnH0xOHCv23d+DIG2PO1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214460; c=relaxed/simple;
	bh=G9AGoHxmANB2JPePAOt9Cyel6/BOshX+/IIM/82Kgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZFYwIvErPpgHUE/H2upsULTwk8M7WIhWdo+9MWkFM2m1EFHX61xaDLlZjXVXMm31yWcLTt267XSQ6jP95UIPShn0iXC6V/AiZ98MyONNiaBjbgo10hLPcWsxkVqTVl8AhZ8GGi3jfCFkAPLyy/tcYpJYdyg5lz6WG0RqxgInck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=FxpHM8eN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225df540edcso49397215ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742214458; x=1742819258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql7cl1jivUxEVgcKx4CnZzoPILXMvLJsMTxxnU4+Wwg=;
        b=FxpHM8eNHRU77jSNYXSmd52KcvL+Iygc4Rfm/aK22jol04wMshVL92mXlI4jGpgGM6
         Zov85s9+optEFcgu+Buno7pM+tI1JqmAM85J6ctAzCAo+dh89eZoL5gWmDjVNjSNFm14
         fsranYG7ngDVgDxDGQSB10IHb/z2XPfMHCOjuuWw4SpcJm0/2B7qPmG76C5UstRD7VPn
         Pen27LMUa5plito6WrrpA2erYIZzHaHpGacFU8y+gTOovgKrb4lD+52wyhAPv0Zuoz59
         Gl2hTPKlOpU1QMwa1mKKdGcnDdqVBNitlQyx8IJ1Y0lkdihJnAfr327X2BzrboAz4h+R
         wEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742214458; x=1742819258;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql7cl1jivUxEVgcKx4CnZzoPILXMvLJsMTxxnU4+Wwg=;
        b=waZd0M91IBagpGz7XN1KIDgYCeHK7ZbDZEOR165sFqjdQ1PpGzYOeJaml7swFH6Gz9
         ys0nRZsnjIzNTzOlR8QJoe7XWciPuIe+wUZ1x69n84x0abrY6lv3nIqtxRUlpTNgqHkh
         G2SK9lJR+Pgri2idgnJPy8tcEhhESuV+X6MR9saW24ycbpY8bbgFO33Iun8Amj3i2yPS
         /ODgU7B2l1KcYXO4OEQ1FyZ9HsvnR4q0KbImLV+SkLUNoT34hsUy/J0c7OPBcksRdtf3
         lLnyLExSHH3pxtk390RPm4ZlNhGhw0vRI0SUAxj1E3j+6x9A2Amn8FigxTxNir+sZr8B
         gl8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWp2zsEtFTUFU6VEXpLIOEhi/w/aLtotZoPfr8A2z3NDCTkMoBmGRGsPRDPJreX17dl/MLfvgTuy52oBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqV+Bmd4Wpzh4k/EoPm9b8Gsd8tSzXpivsaYds6dMvcj1pquM
	sWsvO0War8TYGLrkeyFwnUuTHXUCl7uUTpFKJYEntZS0WwR27nSxbSJ8CWBRJKc=
X-Gm-Gg: ASbGncsaBTFr5TR1+Xyogo/tXq5cH6U4e2KYHin0i5x5qaS2N63vX9ZRpa0WcKAnjLe
	bjxsDD/9hQHt58xhWVG2fHasTJl8VCemdgTto3kP5cNQUIPD9Hp/uC146n899d5UZ0TTIdJERqJ
	w9oZqYCxinvu2agkx42ocfF8sZrJEih/Yzh3714VVUlE/Dopfq/BIMG2wLUCE7N7xI9YiWteM+T
	Xnn4HULCUonGXxKZZ3dTe2j30fw3aesZcKIsdduqOVKoWy1ZVDOtLhd5eu7xdKHkS0JHSQ6s4qj
	6BbNdduzWNADSL2pcB7FnQXV6YVFXb4xbC59dD04ySU1QiOX
X-Google-Smtp-Source: AGHT+IGgAd8DQyYluWrfbCBtW7BNHVC6cJ+9kFyNdt5BjTXSIYza/k/RcKCulIQI3qlDd75/UV+Brg==
X-Received: by 2002:a05:6a00:6993:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-737106f646emr18394790b3a.6.1742214457512;
        Mon, 17 Mar 2025 05:27:37 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:d417:d7de:22d4:4d1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116955f1sm7655024b3a.142.2025.03.17.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:27:37 -0700 (PDT)
Date: Mon, 17 Mar 2025 07:27:30 -0500
From: Corey Minyard <corey@minyard.net>
To: Breno Leitao <leitao@debian.org>
Cc: Rik van Riel <riel@surriel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] ipmi: fix suspicious RCU usage warning
Message-ID: <Z9gVMuEMk9yNNL89@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250312131932.44d901f7@fangorn>
 <20250317-horned-nano-degu-a6e5bc@leitao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-horned-nano-degu-a6e5bc@leitao>

On Mon, Mar 17, 2025 at 02:33:31AM -0700, Breno Leitao wrote:
> On Wed, Mar 12, 2025 at 01:19:32PM -0400, Rik van Riel wrote:
> > On recent kernels this warning fires:
> > 
> > drivers/char/ipmi/ipmi_msghandler.c:1238 RCU-list traversed in non-reader section!!
> > 
> > This looks like a fairly simple lockdep trigger, where
> > list_for_each_entry_rcu and list_for_each_entry_srcu are
> > functionally identical, but the lockdep annotation in
> > the former has an extra check.
> > 
> > That extra check is whether the RCU read lock is held,
> > which is not true when the code uses srcu_read_lock.
> > 
> > Get rid of the warning by using the properly annotated
> > list traversal macro.
> 
> Thanks for looking at this one.
> 
> There was a discussion about this issue a few years ago, with
> a different approach that never landed upstream.
> 
> 	https://lore.kernel.org/all/20201119123831.GH3710@minyard.net/#r

I thought this looked familiar.

Breno, I believe you suggested a change to the patch that sounded
reasonable, so I removed the patch, and then nothing happened and I
didn't follow up.

This is kind of a mess :-(.  Let me look at it.

-corey

