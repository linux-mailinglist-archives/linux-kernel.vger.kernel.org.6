Return-Path: <linux-kernel+bounces-275284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8699482BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C131F219F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D016BE22;
	Mon,  5 Aug 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyCSdmRj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35B16BE13
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887897; cv=none; b=iTe+I01V+UzEtbG9J48KXghSn9/pm4HiiFDIAlxzRJ9MFQ1COyignfqsQwQ+mmTxlCpqo6G40znd4jImgL/ZmRqakK2emSNs9kgTpupdL7MJgiwMTCDg/Hi6lb53ffTpMUThgb5RY+nzxxP4ORRQs2QkIj4SZybREchASAGo6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887897; c=relaxed/simple;
	bh=dH35ti2mjB6yEM3h/DET48dNvlk6wbPmHxtYyw1+vEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2ZY2xGQFkSNZVwuzOm5AnLh2wXk8r6ukHVCCiLlmnyb1pdYf6uJUH2m8MjfAX2t9kA0hS3eWqNUieh9SLgw2AzrBtp27aWc7EbMN7eRRQLEGtpU4A1TK2CfLCTpffC0bF1dE9Zty275ufjrNJ5sia+MuSNc2rTM935wihiY/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyCSdmRj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fec34f94abso87710325ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887895; x=1723492695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=th0CtboODd0Citb76V65kgmx4mMftUru7JrjT56ipuU=;
        b=XyCSdmRjAzfb8/eCmdLbwGalbf2gwO4qPG2ba0tLgIOeV9Am+S5hCzOC1SLCYGJCkW
         akeZ5YdzzjsNeI0KMbtJUcxer7kCchHScz5Ft/j/JIEwFXNxLkJ99WgT4A2Ygm1TtCiZ
         TPUGh+buT5IPmoZAhHH2g+E3EbelfjDkKgS4l89Rae8w8tsci1nwvplMmKAnVHcxhu5r
         32xTKjiFgG6csJPmmRH5WK45GPgKscGlqAWgW/0Kvt1w0SKjHG5jp5QZxKjWN37fuV7E
         Uhmrbr9f6S6BViQfG3aBvuUfhC3F+qA0ZoMgCuuDeFIDCDXNq1dv0Nk+H2XIiw1T7+hf
         TAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887895; x=1723492695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th0CtboODd0Citb76V65kgmx4mMftUru7JrjT56ipuU=;
        b=b8wtL4FLsSzC+nfOUsPoUlM7COPNwAJKoX2QvIPZPSquAg22ARW2aDrc+U8l3y4wOS
         T4v33Ol3Q5aFdZsZSi6Upo4dWE3oY9Rn7u/KyUWz0jwNHl5Yz1QWL49uayXh4CU19XrT
         SApPGNY8L6cxqGGrvFTob+q3YJhsiJI+kB/XJRVE3ku+2NMD0wkCqDxiLHNdzrSOQAqz
         mX9H/6Ghm5IuIJRrYLDKtM41YahAWMqNNFUgkzppPSts5eNwJF0OeJh3CJeaMDKkrC8b
         Iwx6BtSIbmBegY28+HpBeSFJ6driKUZLZFFgQpyBe0dU7YLSzW63mP5TLTCCuEx64k/w
         GNdA==
X-Gm-Message-State: AOJu0YzEHNuQTFfOX0srRJU522dG/btahqSDQwbl8XmgA9/GQ84i9Xw6
	c1zDjIZCifOhz2zyX+JhsWu6+Q3wACLRaBDDcwV3gFxL7sdX0OqBfI7wjzxeQg==
X-Google-Smtp-Source: AGHT+IEc0in4MhDmvFv26t5QsMWQOc1zvaMi0kJTQ2spgPHlbYmodh7I5rQVvwnB3R4H08ieYax8XQ==
X-Received: by 2002:a17:902:e749:b0:1fb:7e13:a7cd with SMTP id d9443c01a7336-1ff572e0290mr125815115ad.37.1722887894718;
        Mon, 05 Aug 2024 12:58:14 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929457dsm72326675ad.249.2024.08.05.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:58:14 -0700 (PDT)
Date: Mon, 5 Aug 2024 19:58:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
Message-ID: <ZrEuz9bjZcBq6jNG@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
 <20240723164018.2489615-1-cmllamas@google.com>
 <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>

On Wed, Jul 31, 2024 at 04:48:23PM -0700, Andrew Morton wrote:
> btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> bitsize?  Maybe "bit shift count for..." or such.

Yeah, maybe a _SHIFT suffix would have been better fit for these configs
instead of _BITS. Similar to PAGE_SHIFT or NODES_SHIFT. Anyways, I can
send a patch to improve the help text. How about something like:
   "Size for ... (as a power of 2)"

I'll also send a separate patch to fix the rest of the upper limits. Any
of the (1 << 30) shifts allocates static arrays that blow past the .bss
segment. Just as originally reporeted by J. R. Okajima.

--
Carlos Llamas

