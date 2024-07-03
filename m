Return-Path: <linux-kernel+bounces-240310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8F926B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023701C21A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D74B18E75D;
	Wed,  3 Jul 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aazw5Q82"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A6191F69
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046000; cv=none; b=H6ZOFiyvwAOXGZ3obzksOq1b9c1NoorJc7F/wp3X+KfiYUyfekJU5dZ9bxrF191o8pjYFrYuzNEURp+Fm3pfbMvet0tzxQ6WkyrOQBoDxN4wFuhYAFvmaLCa/AFhs339R7YEnDjo8R7D0IchWc4wdbErJOe+7EUQOkShf+3HLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046000; c=relaxed/simple;
	bh=KFg/rbkQmn4+Z9qgLd5RFdTVJuWPN6J8DyNWRoUAxts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbFxXZhu2HOaWee7QFUoj0F5UOxkceghrcvByD8kHsY61s8DbnC3z37ypAl03J7bRR6FV1kqZSGh5yva7CVhkVeKh+Vf7eLYMALjYLSP2bwonM7XBAZ5nkonNsx8+r7RkBRghg7eDjrhLWfygF2fl89zoBg/fqNxibgMyr6Mb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aazw5Q82; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70af0684c2bso51492b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720045998; x=1720650798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oIWu5LvDFQTuSLumXWbuf9a7+vs9Ao9dfYk4KDVvB4=;
        b=Aazw5Q82vakUl/FAbJUpooY9v9wqWQHAH2VyPXMQPSn3EDFS+YFx3z2OLYVQTvh70/
         ON/yeiOHC6g3AjJQhkHQ5Iu8d3olVYGLi1Mdd7C87yuwZTBjP5Jqxcr7X9adIJtAKT8O
         XMiZNblqGRsYzKWkyLReMJLviWRXWzNZ1v8AF+DLHLVAHd5QVsCm7bBT6VAY1i2p6OHM
         hPY69iYWMQL0jaFyopuYncJHWrC4fT4T/MbP1Q2Oph4YvAg+5/09CNUJ9pKcV7mk1MNu
         pvIY12WktqSE849/r+T3cRNiO4g1hM9D19q8N0WL1F71pjcoYnvFoCFDpQAZBK3xecAY
         NLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720045998; x=1720650798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oIWu5LvDFQTuSLumXWbuf9a7+vs9Ao9dfYk4KDVvB4=;
        b=q48GrNc2UJrDTH4FV21sdS91SIE4pDN3wpNUZUNCDg300V6L8Qt14tKsafG8BczdGD
         97IYbHVwbK1IKK4kqKGMvHiNAoWdAwwD0QPC5U61OZtTwMsLgVQTvKCNPOr8almJG7BT
         vuPvGLkneZF3c8Bg42Vdj9l6HiWj/hflLxeryndPYS/1gDzGW7bC6VLjSxhdJ3q7sM2P
         NuIdwy1g77FVL1dxFjMop8KQx/Y2bj4an4L1+S1tRqLTSRtewW2XHob5oqeYT8L/gBRd
         OXNMe/rYogUVFiIEV9ZOj+FhgHWKtT70ZSoK7uULlIblixgcVU5Fqh/ufb6VsnvT7bpC
         xTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNYT01ucC/Ktd/O+xMgxwUlVeRkAFg99uBMUYMi5Ue8FqcoGDV/TFAcdUXzywW9rIC2gV4YM1d2TBwB3oiLIQKc7P5M4uiVPw/mzcJ
X-Gm-Message-State: AOJu0YxxJAxa2z4JNHDKqU5DWS7lgQIvOgAqLBeAS7f/hrnBG6w9bV50
	LW67W3CXkeqWPi4bGZEMjvUQTeRti5CFuwz1dc26MbWtyNR9FI6M
X-Google-Smtp-Source: AGHT+IF8rsBR8SE1387cEngzKISqLVoRWHwAWn7/bnTtKa+yNdh9syvNaPUCSzklWyizIkZ8bFzMaA==
X-Received: by 2002:a05:6a00:22d5:b0:705:d805:215b with SMTP id d2e1a72fcca58-70aaaefd5efmr11756680b3a.27.1720045998259;
        Wed, 03 Jul 2024 15:33:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf74bsm10950636b3a.117.2024.07.03.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:33:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 12:33:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2()
 macros
Message-ID: <ZoXRrD48cLEGmUT2@slm.duckdns.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-2-bvanassche@acm.org>
 <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
 <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>
 <202407031249.F9EB68A@keescook>
 <f0333b86-212e-40e6-b41d-b393c312153f@acm.org>
 <202407031518.7320BBC9E3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407031518.7320BBC9E3@keescook>

Hello,

On Wed, Jul 03, 2024 at 03:20:17PM -0700, Kees Cook wrote:
> > Hence a different approach for the SCSI create*_workqueue() macros:
> > https://lore.kernel.org/linux-scsi/20240702215228.2743420-1-bvanassche@acm.org/
> 
> Gotcha. Okay, well, that's a lot of flags to open-code, but I guess
> that's fine? :P

The flag in question is WQ_MEM_RECLAIM and that flag has a direct cost of
creating a dedicated kthread which mostly sits idle, so we want it to be
explicit. In SCSI, the naive expansion is likely to be correct for most
cases.

It's a bit tricky in that the failure mode of incorrectly missing the flag
is critical (system deadlock under memory pressure) but can be difficult to
trigger and the depencency chain may not be immediately evident when looking
at the code. The upsides are that when it happens, it's usually not too
difficult to tell from the backtraces and lockdep annotation sometimes helps
with finding missing cases (which is suppressed when using the old interface
because it's unclear whether MEM_RECLAIM is there intentionally or not).

Anyways, yeah, we want it to be explicit.

Thanks.

-- 
tejun

