Return-Path: <linux-kernel+bounces-280278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05E94C812
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D364D1F23800
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669DBC8FE;
	Fri,  9 Aug 2024 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZRZCUma2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DDC125
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167277; cv=none; b=at383+fLs3FGIdiksFg1oD7oZe7Y6DlbMk2c1wwcpFqvN6yrhxkVXIaUbj8QsNOQBjcF/nKQ6twHdlfXQXf5/boQjx/D74T5tWJzBSDbKsp8mwiEz02/OcRLISdjVYH6FpxBLdkZL3N+61FR8oQX6AaexvL5dy62woVEgY0wzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167277; c=relaxed/simple;
	bh=ToaX6peDCB9hbmMU2GLlvLW1Nh9ojFmC84nfltrsG9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUQ+sDSRiexuNSr3JF1TeOEQ/SknaMO7rmDp2fLDtiWphk8PqHlzGpgRn4b7ctn5NZu7fV3E1aohAjHsIcGElcvSmA8Qa4r3cKAQfTSTxroaAwjafCEty/PWdyQPr/SIPT0ACsr6QGNUevcc9P/kji9pqgoOXsbT5eqLAR/8JWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZRZCUma2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3687ea0521cso1103373f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723167274; x=1723772074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9y2C8B+lF/Lu/CAlX1W3oq5Kr7FiXBOOsxkXKzU7Rhg=;
        b=ZRZCUma2IFtUDkf596jFg7TJW+3NCLbGJzuThML+q+/2SdY+W2erIhAQr+ddTyX5ZK
         qjga87kQhBv1GL3YRSZJSM3f/opkKvuLuEgprXZ+hidH9MU3/LlxQ67oAuaPc6VxRQDo
         1whSUnQaKd1HvxmiAxaAsox9mpPK2lESKLbZ2RcQGI8d+m1Mwr2X+CoqPO/R+gR5SLPM
         JnreJJ/lGn9X/ZcG46yQzvjC7uLbGodr+EzwSnMjneIcfo/dtB27wh8osmXbV4BTPB+K
         iFIR4vV1frYzJmw132Z74H1X2HLmeouow3eUWd+Lmh14U1GhFqoQzAEiSUNPkW+BNV4Y
         kyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723167274; x=1723772074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y2C8B+lF/Lu/CAlX1W3oq5Kr7FiXBOOsxkXKzU7Rhg=;
        b=srW7p6C1yqXmmAiDeoni2ddwxeJlm50Dfq14JWXGJtcy2VYE7KfuH5BPonTRPj0Pwz
         ODwIYYwkt2uGT/5tIxOxj11kx4XcRNvuFsRHwaoLKAWqaF8g+21nS7qjJE6DHpMO6M6B
         jOhb0O+JFoDIGES7rCCWtcBvbmk/qZ3hzif8jx5/1cbDgXkTnLuFyUgwGeHIDoGtxx70
         rbVcRGTlbA7jskk1TdeQkk6BSb/mY3ToLH6Q/OFRQVvQfZfoCIFhqziAGdhawnOfVhsp
         CGA+Ss7XpGWjOJwfdKPTVMG5KhFvp2arDxc8Hbxxre6FgsRSskI8dS/r/qO5Sa8eSk14
         W4Zg==
X-Gm-Message-State: AOJu0YxYfk9kBXiItxTeWRCvD9eKEyJobK9kdmPPZtZbU11eNA/7/bmT
	lwrkYku52IG3jmYPnUmeak2W4wMRcYFY5zgD2BND2+pAYdAJB80ghRVmUbw9ugk=
X-Google-Smtp-Source: AGHT+IHgxmkzadjixFKAZvgrgSR6E6CZFBClPkj7rqhI/8wgnxNh9+m5FX63Zkh1nB2PKYWXDsWE+Q==
X-Received: by 2002:a05:6000:b89:b0:368:3b5c:7a5d with SMTP id ffacd0b85a97d-36d5e1c7656mr13291f8f.20.1723167274274;
        Thu, 08 Aug 2024 18:34:34 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e970sm101502785e9.24.2024.08.08.18.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:34:34 -0700 (PDT)
Date: Fri, 9 Aug 2024 02:34:33 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/1] hrtimer: More fixes for handling of timer slack
 of rt tasks
Message-ID: <20240809013433.pazaymcdx37lhpau@airbuntu>
References: <20240805140930.29462-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805140930.29462-1-felix.moessbauer@siemens.com>

On 08/05/24 16:09, Felix Moessbauer wrote:
> This series fixes the (hopefully) last location of an incorrectly
> handled timer slack on rt tasks in hrtimer_start_range_ns(), which was
> uncovered by a userland change in glibc 2.33.
> 
> Changes since v1:
> 
> - drop patch "hrtimer: Document, that PI boosted tasks have no timer slack", as
>   this behavior is incorrect and is already adressed in 20240610192018.1567075-1-qyousef@layalina.io

There was discussion about this hrtimer usage in earlier version if it helps to
come up with a potentially better patch

	https://lore.kernel.org/lkml/20240521110035.KRIwllGe@linutronix.de/

My patches got picked up by the way, you'd probably want to rebase and resend
as now the function is named rt_or_dl_task_policy()


Cheers

--
Qais Yousef

> - use task_is_realtime() instead of rt_task()
> - fix style of commit message
> 
> v1 discussion: https://lore.kernel.org/lkml/20240805124116.21394-1-felix.moessbauer@siemens.com
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
> Felix Moessbauer (1):
>   hrtimer: Ignore slack time for RT tasks in hrtimer_start_range_ns()
> 
>  kernel/time/hrtimer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> -- 
> 2.39.2
> 

