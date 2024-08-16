Return-Path: <linux-kernel+bounces-288870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3D953FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421201C22326
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC360B96;
	Fri, 16 Aug 2024 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtM3t8yo"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9058203
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776749; cv=none; b=ebS7rBNhtnLETZnjNNMSPr6DP3v3zVIGgR63Ba9LA09NxoGbdaISpsja8o4x2XmYhCF09be5XwZQ9F/hfGySeCZOV1hK1rzehOQjPwt5W98rrCMRQjIDdFCmPK5Rp7Vh+V5LH6yj5av0Eg7qaIBOxFAjBGjnbt14Wfdg9zt/ouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776749; c=relaxed/simple;
	bh=AoXvz3uW7Y0bevagrxVHIcc7RMCMijfLjWdpd5vMRP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXl2gh5/FCC8Tfh6k1KKOE/V9Qto6gF7YN3iSguwTrFD4jZa9mIYgG31eRnOAGMeGPHERZfHrn/X+5WMIS8LYjBebSR+o1Ttx+SlYlAjNNhHP0vEa3UmRpHBiuLSgRhE4Lvg87Oman0NotWHmYZwnwerN03pome/Xg4gx2Lc8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KtM3t8yo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dd25b2c3f2so695797b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723776747; x=1724381547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w99qzMOKf64PpVFZZE0xaREOL19ldxNuw4vJWeToT/E=;
        b=KtM3t8yoa+MaOGG3mZvgUAEcClqqMzRDL6U+GiVjX/X/7t0XCE3oDnDCu9mk/lISWp
         2m8KWJ/B+i4uV7LyB8e7axWfifBexXA3A4vJYUaShHbSlOUqPn+D0wrkTwrOz49ms4kp
         kPmyLYM74CPuX9mqq1P8JbIheRmrVGuIp4q10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723776747; x=1724381547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w99qzMOKf64PpVFZZE0xaREOL19ldxNuw4vJWeToT/E=;
        b=f0C3E4CHxDlw9oC7rQMmF953CrULnfRCaTwdeYwscx42AvvKuN4cJqups/mrBxJ7iy
         y+HbIB+5QeGSLViVrjwbXrQ7eVWUyL9BdB1KgQExMdh7m0weqNhnG/IZrG2i04MRxaFM
         wJvsCVVQB+uzRa91hLN9gLOWffGiBc065BWxw2RC5620i+Suk9L1GROIkDEnX1soZygD
         xwuguL/VhDxlSIZJ4bULiXdH2LAnT2DjH4qI3RdkD00jxGBidwWw79Q+mJbojR7rh7h0
         wfa8IvA/MtSs5NBlrCnTVStLKQI8paISYonVY3JmAFw/yWP1JU2fcF23COSIcqw1nmnq
         rkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT8YndikPczHGZJJfgvhLowws6IvDNa4ep1G9+wxihD8EWFREZGhcZOzVC787JPwXU12MsOfCvGn6+Sh7+CzOoGFFAm0jYhruh6Kai
X-Gm-Message-State: AOJu0YwrYoBIutS1FgvytMFdLtCW70Q0mVjxZBYH6B2NZoGiqgQ0ttJt
	Ng7KiibhapMfhrEnVgaKuOWjs8qSC3HI8DRRN+1iRMDcdfkLJ/Qc5aPcsM0NYQ==
X-Google-Smtp-Source: AGHT+IE+vq0dNGe84M82PWzdrQsyEwTspan53iqRC5Wy2F1TASPvcLipuPq17AIFRs2O0afovq3DuQ==
X-Received: by 2002:a05:6808:201d:b0:3d9:41d1:acc4 with SMTP id 5614622812f47-3dd3ad52910mr1959637b6e.18.1723776747567;
        Thu, 15 Aug 2024 19:52:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fe02:865:f677:1481])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61e7c7asm1893455a12.45.2024.08.15.19.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 19:52:27 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:52:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240816025223.GE12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>

On (24/08/16 02:45), Matthew Brost wrote:
[..]
> > Oh, I haven't checked the workqueue header.  Yes, you are right.
> > A macro should work.
> > 
> 
> To be clear we your change to __alloc_workqueue in workqueue.c AND my
> change to a macro in workqueue.h.

Oh, yes, correct, that's what I meant too - we need both.

// Plus a null-ptr-deref fix in __alloc_workqueue() error path.

