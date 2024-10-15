Return-Path: <linux-kernel+bounces-366032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A458799EFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342DA1F236CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA91C4A25;
	Tue, 15 Oct 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="DR785tQf"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E621B21BA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003402; cv=none; b=AB3v9d3JCQfDrEDwYCCQSeMJT6NQjxBDP+4sL5GzMg2D2erR9e0+94YLHXx+Xa2QtWYEh0xXcYMWS5A6R0tIDQTMZP0ACqXS3ZklG59MLO+U5UmALNNatksNofNvlQIXj6OimAvtnNfugVzhIKbfxmShN9MrVjQ4DmEJJZH+R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003402; c=relaxed/simple;
	bh=3zG8ijviAh3UNaecnSyBL0gw5syOhcN7O0Z2Z+3aryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/Nr4Yb9IbFLEc9zirYKzhAXQ8CGdboWOLPSBCT/Cs6DqL0VWiyVZ17J8pE/5IkrfLDJrKfNdrWPn7gBBtc0rYReHCEj9EuN5yzP48IyI99H9JxMTKvoBdiaMP5TyZQs2y2OBcelsRis9bKmpTP6aUvc89q7HN4KGTBSzrMi594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=DR785tQf; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd092f7f0so37340806d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729003399; x=1729608199; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xi1uocso5/NdgZpE7t6HMxVGnFAWW+NbbBS6pPLwquk=;
        b=DR785tQfGwJEWbg4OHMkXh+e3KqPMsKYSWF4NAJhBif9uuZzCU/sMGSV7OAk++JUbG
         By17IuVFTxzvztpnRHsT160/tZYcFdARE+JT3cqmZrKEeBnlU2qLuGl7yFPeQPWqqEK5
         IANNA6frJFsFOtz6GoGFtzqIRIzghzEiENCIVlpgjCL7Xt3fzNm7kihTwhxIcjJahRNL
         0Yj/aI7wj+EAeA/GwE4j0JjNAtEz740G2E3rPV0nq/mCSeeqiOWpKs324p40T10QyYcS
         W8Aj9npm4f0NmIxhWtoq1Kgf0NJTa0Tths4+WvddLf/FKYd7qTqtTgbMoS8OO1PARvqz
         tsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003399; x=1729608199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xi1uocso5/NdgZpE7t6HMxVGnFAWW+NbbBS6pPLwquk=;
        b=t37//Ipl3stf62fmkU+QyBDVBV1jWF7I4y+cehALRoGSlHu8iTUl7pvDuqvDEOiJPJ
         4UylK6j/Hy1E7Vm6WzUD+KJGYJthGj5xsD9761nrEEeAi7uBsx+HTfrgACJI2AuPNiQv
         8+kZuZ2LjspMwXDhbQJ3MdFpaStcl6WU8opJoiAfSXB2x7By5/QzSvxTOKm55vuF0oYr
         Rya7VNjkXUbiS3StZm4w6/+ItAj16fEwrcHkSeVGyrRjegv/HTaP6EfZp1TiPx3xNw25
         BQrGruER6DvF78Lv/fX7obG01UWX1ke6+td1Y6yeg+2VjP5FqHtDpQtTnO85RguRApVm
         UZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTijmAY0toSNz9Q895HJiFg18bRfa9BnNOfJdtwV45wUgBxq1YQRhAwqisiM82zRKNjXwVPMLYIiQU/k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4f6DcyX3QgVbLa+t/qW7FpcCGDGTUioy8crJcy42Jpl1X8zGJ
	mVYroRkbds1znKY416TeNEI5ekDW2+6xicWAM2wEhPWb3ORK78BxL4NefTy4ow==
X-Google-Smtp-Source: AGHT+IHlwqwj2zLwxFP+7TNul9Pxh1d5Xd7nG3ml8Ey1XcTIoXlwe4sCsZV0vRFmkVLRCXSSsyvq1Q==
X-Received: by 2002:a05:6214:5d11:b0:6cb:e76b:d90 with SMTP id 6a1803df08f44-6cbf0044b74mr186884986d6.13.1729003399548;
        Tue, 15 Oct 2024 07:43:19 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22961b92sm7297386d6.120.2024.10.15.07.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:43:18 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:43:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	mathias.nyman@intel.com, yajun.deng@linux.dev,
	sumit.garg@linaro.org, kekrby@gmail.com, oneukum@suse.com,
	dianders@chromium.org, perex@perex.cz, tiwai@suse.com,
	niko.mauno@vaisala.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, tj@kernel.org,
	stanley_chang@realtek.com, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	badhri@google.com, albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v5 5/5] usb: host: enable sideband transfer during system
 sleep
Message-ID: <fddf19f6-d03a-469e-a56f-ef390c099902@rowland.harvard.edu>
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com>
 <9b5fe5d2-77a7-40b7-b260-856c35d9dcec@rowland.harvard.edu>
 <CAOuDEK2f_mtfiye7MdnOqEkq3pYW1kcdkwEMMBC5CkkQ1OGu3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK2f_mtfiye7MdnOqEkq3pYW1kcdkwEMMBC5CkkQ1OGu3A@mail.gmail.com>

On Tue, Oct 15, 2024 at 11:56:00AM +0800, Guan-Yu Lin wrote:
> On Mon, Oct 14, 2024 at 11:56 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > I'm not so sure about this.  By returning early, you prevent the drivers
> > bound to this device from suspending.  But they can't operate properly
> > when the system is in a low-power mode.  Won't that cause problems?
> >
> > Maybe this really belongs in usb_suspend_device(), and its counterpart
> > belongs in usb_resume_device().
> >
> 
> To my understanding, after the system is suspended, the USB driver
> will do nothing as the main processor has been suspended. May I check
> what forms of low power mode and operation we are discussing here?

S3 suspend.  You are right that the driver will do nothing while the
CPU is suspended.  But what about the times before and after that,
while the suspend and resume procedures are underway?  The driver
needs to be told to cancel any ongoing transfers while the system
suspends and then restart them while the system resumes.

> usb_suspend_device() did close the required port/bus to maintain usb
> transfer.

I don't know what you mean by that.

>  However, there are additional usb_hcd_flush_endpoint() calls
> aside from usb_suspend_device(). Maybe we should consider not doing
> those also since some of the endpoints are now handled by the
> sideband.

Those calls should not be skipped.  If the sideband controller wants
to handle the endpoints on its own, it can go right ahead.  The main
controller and the USB core need to know that they shouldn't use the
endpoint while the system is suspending.

Alan Stern

