Return-Path: <linux-kernel+bounces-276822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD49498CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F33E1F244D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0882498;
	Tue,  6 Aug 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzN74Qqq"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC338DD8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974871; cv=none; b=VQ68RAFcLuQvwl2yWriLz9F01SS/l3h8IokgS+lMny2XDpCFvQ/DnONvCxv1A5Jmcv0CgrRrtgC+zlfHHW+F8XXW1IHEFifi5HaAuRO4uxRaJgXu2UOZoOo/wLGtTT4VMHjWVi/NlIssWrKa1wK6V8JNLYvT7LH6TXehZB+6a0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974871; c=relaxed/simple;
	bh=spYpuKe+YufYSHkJ1dbjLL9KO56fORb4N/F2Ur24EdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSQx1WanDLmefaNtO+tCluwS799cU8StoDn4OD7GSbUhXoABqO1Y52Uba9eI/VW1WaVBwvTxBP4G2F0sF4lXtU9YFeaCH42fiE3dJmnCK+0pFUSSjw0jyS0BXY5HbY4M7NNId25kWIujodN+rnQsUxLcTdRWG/KrLaudgKNAdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzN74Qqq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7b396521ff6so696176a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722974869; x=1723579669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE2up1BgP3c77I6PLxav9RvKnXu1I5j6uX44coRXaF4=;
        b=SzN74Qqq0DW63tGR2Drx3LGXZ7FQMzvIDDKN6j4Py8dbQsoUFMCYLUjZdgpsMtZ99W
         XwdJe0JgnP5Al4etDBcOho3Qw2TYVyHUOuszMxgrkTvS+wEvhLrJkcVcvmidQNbBGR9H
         K9DTnRC74rNCaYH3MCw1qmX9wTkJ3X21ZCvnSSjX3JYPN9Tm4l3sMMsG15i0yBqnk1UW
         eS5ctfiNna8xtB01NfpOZHOjlRHbgYmwmDVgy7ZZ71gZcLaaOftg70EG+19iZtawnoyf
         c9rb656a7Q/G+FVEJAxQxJga+d2MKCl3v1UyHxBnakSRAUT99RoTnw4Ac6xaaDkF6fyd
         UBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974869; x=1723579669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE2up1BgP3c77I6PLxav9RvKnXu1I5j6uX44coRXaF4=;
        b=RUWIfZkHhBYFZ8Y6g0Taqu91wmUEGcmD9+9ozSNdSpOB9S80cWS7yZ+mI9uIn1Ncxv
         R03cxDozGUQkyEW4H1MNn0ds/LACyLAq30ROFJpLRc66tSObYojFxitgKiRZ2WbEPGBo
         yftJgBqszthXt2RhwO31+yC2UcZZpbQGkGFDtdiOPdoFJLUzl8UsC5Zo9uxjH1a1wMmz
         cEqJ6GPq+6BqRIQRCQf64a8VGcUBVGB5g22Rac/meh8uhfyWK+FzLunE64tX9xVhgA3h
         4zQ3tezKBTrYF6j/ndolAiqt9wiOFXmUx/AYDnMuCTWANPI2FBbDag9n5y5KcUgxrswU
         pBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWrWAImiHQX4/fyhudB+pj+XGaaNnR6iXLxPzkjE+a0zpFBopNQA47KPVK5rh0FVhsJfkxDCHiM2cUVBZ47XzVkyCvqJl3QcAzAWd+D
X-Gm-Message-State: AOJu0YxU5nS1abWihTlzSMZbeMpusZ7QLJuO1BPNrSt7WMdVdddyax4j
	jzWYIAmJDLZECkq9Mkg7M8EOONmkCq1qSqSgHvG8jrZeNKTLKEm3
X-Google-Smtp-Source: AGHT+IF63w4KJx0GEIi96xwVAzB+2uB/dipNkWfnTmrfvj/uzxHecrp6jUYRnDK0bmqfKtxUAbiCSg==
X-Received: by 2002:a17:90a:c585:b0:2cb:5678:7a1c with SMTP id 98e67ed59e1d1-2cff9413dbfmr19665316a91.18.1722974868867;
        Tue, 06 Aug 2024 13:07:48 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc40648esm13090653a91.5.2024.08.06.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:07:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 10:07:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sangmoon Kim <sangmoon.kim@samsung.com>
Cc: youngjae24.lim@samsung.com, jordan.lim@samsung.com,
	myoungjae.kim@samsung.com, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: add cmdline parameter
 workqueue.panic_on_stall
Message-ID: <ZrKCkpr05sRN28nc@slm.duckdns.org>
References: <CGME20240806051219epcas1p42de88463d90d6084ccfea538d929465c@epcas1p4.samsung.com>
 <20240806051209.3352066-1-sangmoon.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806051209.3352066-1-sangmoon.kim@samsung.com>

On Tue, Aug 06, 2024 at 02:12:09PM +0900, Sangmoon Kim wrote:
> When we want to debug the workqueue stall, we can immediately make
> a panic to get the information we want.
> 
> In some systems, it may be necessary to quickly reboot the system to
> escape from a workqueue lockup situation. In this case, we can control
> the number of stall detections to generate panic.
> 
> workqueue.panic_on_stall sets the number times of the stall to trigger
> panic. 0 disables the panic on stall.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>

Appled to wq/for-6.12. Can you do a follow-up patch to document it in
kernel-parameters?

Thanks.

-- 
tejun

