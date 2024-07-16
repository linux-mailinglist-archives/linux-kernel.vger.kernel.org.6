Return-Path: <linux-kernel+bounces-254426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7235293330E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FA284A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5834D8CE;
	Tue, 16 Jul 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYsjaTq5"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485704D8C3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162906; cv=none; b=nwxrecIHUp9pAz8svKWbohfK439RU9DgpLt8gDvACloQ3qPVt8duof8700GSgDkws9c1AzvgbwXZV4WwV/6eaKvjsDQt2SoteOxdR2Ky5hTXLcYDJeTsm1sOng9D0JDuFfmsbMgw8CUj7++DO5sdAILKQ9NQP6iNdNQoN0EGM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162906; c=relaxed/simple;
	bh=PP7y+WL2AY+msFEliyCUOfZnXqva6U7QCZDcFMaL1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gao2D30NHABxwNy9LsuRtqWmNYwtW+SejiEfXqtzA/f3VS5SmVqPMhRaFBuWFb1RKcV3To//kJTFE2XE2T1FlwUujlNfzr8zChT0rhIABeuHNzuNK72s6Xh0uf5vWFgGS1OpsJE8LDxGVT38oMzixVnTN0U0qfHy0n9ThQiSCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYsjaTq5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7039e4a4a03so3624213a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721162904; x=1721767704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwLgbXv+0AKPQzwn33w2M6jpxpfVd7tZaswXpHQn/IU=;
        b=KYsjaTq55g0P5Dw5L9iguADTly2Cci0+S6ZVpoIUXuJeGLA77vTNgkq5ZpBdx7uejn
         r3y+1GdVh5qeXzoyPU+Qwew1UZZd8bxiqRScHIaxk16S6H474uA7dy44AXpkQaZHfTue
         xmsfcjs/EGMn/qpYqd1A+hn64CzpLVS1EYeTXrglwaRoVFyrmji0Ypsjl+xVmuvUSKP4
         hF99Kgw2eC+kORy3ieQNcMD2AIqNltzf+fQ2wBfwuRrhdUY+5M3Pc24d7NUqzuiBtGq2
         V/QuoWhSZrB/o+kehhFeUa9zOi128yLNevx85jJ0BJsgySFsTfz8jHOdx0n6D0ij143F
         Te4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162904; x=1721767704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwLgbXv+0AKPQzwn33w2M6jpxpfVd7tZaswXpHQn/IU=;
        b=Pqh//pRZ2mP8vkLYy3mkA/phqE1kdAUGhlIuzBoOrmZmVsFLEvYKskK4/o1WJds9Dc
         2Sbv8ltP6LqKXFVSq6VO7WB5ASRhNVpVdmeslFMYDefvgtJnb8UG2Ir8zEGilUTCWtYX
         5KDbx0BXXfw7J9GSTi6d9/bxJRbFN7aQCZjlqHyQmPr+hI5tv2CfSkLko3E5N0tX/7Q0
         +IF3gGUFkv+CVWy+UMYHrHFIRkYKRmS8UupKOCvHI9+LG6r28jTC4m1g2h1zJ5ijHMDY
         SVPSMZKGNQCpOiGEtXKdBm9ZKQydYMs6G331RYmqfOaZIH74cSvuZGs4dyl6h98U+Al5
         rdhA==
X-Forwarded-Encrypted: i=1; AJvYcCWzEWG4WmSudvLnNiRTGk/3PXh0IUJinwMGO5zzq+3jkQljSheOi1Gd/BTDlJFZftPwRu9uS9lRLE4lvXEj2FCJ/jz5F0sM6CDzhIfO
X-Gm-Message-State: AOJu0YzrQy+Pm3al/EQT60SY7KbrdDGHRy8z3BxJ35etY6y+WSa4mJrq
	ZDZz4ErYcPe7ErayesnzFY013JQnVGMsTfoNDWKQT18lzWRDujjt
X-Google-Smtp-Source: AGHT+IHcuuyW2diFiVsIgYD8st796q0j4cvhtGkBF8ipn8ZmRPmEr/n4pwPozt1RVflhHuZd8VgAAQ==
X-Received: by 2002:a05:6830:700b:b0:702:1ea0:cfbb with SMTP id 46e09a7af769-708d995f497mr4256777a34.18.1721162904296;
        Tue, 16 Jul 2024 13:48:24 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7c5ddsm6802006b3a.124.2024.07.16.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 13:48:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 10:48:22 -1000
From: Tejun Heo <tj@kernel.org>
To: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
Message-ID: <ZpbclgFjf_q6PSd1@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>

Hello,

On Tue, Jul 16, 2024 at 07:32:09PM +0800, Zhangqiao (2012 lab) wrote:
> 在 2024/7/12 2:57, Tejun Heo 写道:
> > On Thu, Jul 11, 2024 at 07:07:20PM +0800, Zhangqiao (2012 lab) wrote:
> > ...
> > >   		if (p->policy == SCHED_EXT) {
> > >   			p->policy = SCHED_NORMAL;
> > > +			p->sched_class = &fair_sched_class;
> > >   			atomic_long_inc(&scx_nr_rejected);
> > Did you see any issues with the existing implementation? The policy is set
> > before the task is attached, so it should work fine. Also, you can't change
> > sched_class by just assigning to it.
> 
> What does "attach" mean? I'm not sure. p->sched_class is assigned in
> __sched_fork() which is performed before scx_ops_init_task().

Ah, I see what you mean. I was referring to the classs switching operations
in scx_ops_enable(). You're looking at the fork path. I don't think we can
switch sched_class at that point and the .disallow mechanism is there to
allow the scheduler to filter out tasks on scheduler start. I'll update the
code so that .disallow is only allowed during the initial attach.

Thanks.

-- 
tejun

