Return-Path: <linux-kernel+bounces-368238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652899A0D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8864F1C243EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9920C49F;
	Wed, 16 Oct 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rvE5axtg"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD71207A11
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089916; cv=none; b=t60YjXHbri3wSOIxiehkZ/1yxc4tmrmU+9icE7aORLsYm+G50VxsxX6UcdN2toiGOEzh87QqBwbgN43D/Puo1mHAeMHTM5cCIP6k1L6VGbFliY+hNWgAfxYMTqE2/NpgP7KoGh/SnG7oYz/ugVH8u7b/qBbx4+TJL5aV3Ghpc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089916; c=relaxed/simple;
	bh=gwAlnD0ysuHK0dO1AtwV9A/Ktyw1gycD/cvHcJw39Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq0hbvqsCfGsQcTObIiH6iGe0o1ab5qXU8JprB9UR6j3VF8eMcTqCz2ggW5WLZJW72Cgq2mdKevKPUQnxWPVJw8VTEwl2K/vCtzBVryv7IclHLvRHIGSBTIrLNRmxQcyj6k3krkEkxfaITEg5dIZCZynu4Q/gtJKKkF7+fEb9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rvE5axtg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4604bd47e35so27220071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729089914; x=1729694714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9XmZhIaaWknSEfe0YZyYzEdhsRIsVMiJXlqkvnAAdos=;
        b=rvE5axtgCiCvg/Jwh92HNaXNimIADlIVabrEbdG203vs58/c5dCpAp+Pf+lkYZETUd
         d6TV1jeQBrPgr2zTsvRzj2coFPkEgeC3FrewLO6Sa8d12HpS8vrhxp5QDOBAjl2S6mAI
         ajkttLYdYAZlR1vcFhQ64R7NExx5lYUBsZa/r6ZDvFTOrmA2gLeP81KMJ4ghMm7ggXka
         whkHxAJa0zz4wbkpUkGZPJDdvRLo0bNAekcORqw9tpCUxzU/n/K/IFjECMRjReZjf27u
         JchRntQErYaPGctxJ2/Vcc4BNVuevtXQiConjzj1N3wgaulFEqyi/o/6+RgzIaBVucEw
         bhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089914; x=1729694714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XmZhIaaWknSEfe0YZyYzEdhsRIsVMiJXlqkvnAAdos=;
        b=ctxCQKFkF16X8VpP6Pew+l1+J7BgYmvYPt+wo/rLQXY9/FeVSj0SxW0dRzHDWh1IsX
         8ntLEo9Ab98fG9hBquXJv994eyjTitNJ+H7/tLgd6Dygcq5pYB+vF1oOrobDvxZuhIDy
         HcDXEiU2jNmL0DcrNzo23qR/+qbU/1W3e5LT2zFtDp9zOrK7UG/Hm8nnACjiRfBQaaPg
         msqMVCpGN6zXWbpN4qZC9NweazE98fupQfzp36JnNyWReQDvk/ctMVotEMacqxHe3P3v
         ilrxPZTuxsp5+yOIr8mlMUN8bPJReq5eg0m1Ih08HUJ4wa5BlY/XqdoD7tmhe7zz6pRg
         NgNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfK1E23PcJd5RA4HzhazKHB0GRCoQ/zeqB1R0+FrRyo9A9wf71+XINjvy/336P+2lNt/wjaiVwv9BHtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQLgoYhg4/BT2yXuoOtdrdUvv4aUNxm9GrMknA2vGOIz/KQAk
	xJ1A0ernUVj1vazHOGeWcRmCtFgxOn6DbIQ9FvaVPX2+fZqCkI+fDvFNALQtyNKzuR3p7Hwpmka
	w4w==
X-Google-Smtp-Source: AGHT+IG8R7QOdgLdchH6ibtO555VIGGYtjlcpf7axOrrEKRn1Mv6DZi0dDn5WSQwaPsa1Hj5wwey3g==
X-Received: by 2002:ac8:7e88:0:b0:458:2e21:e422 with SMTP id d75a77b69052e-4608a55de64mr61130171cf.50.1729089914282;
        Wed, 16 Oct 2024 07:45:14 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a4989sm18471381cf.4.2024.10.16.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:45:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:45:11 -0400
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
Message-ID: <003263c8-c901-496b-ae04-7cccd7f3cfa2@rowland.harvard.edu>
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com>
 <9b5fe5d2-77a7-40b7-b260-856c35d9dcec@rowland.harvard.edu>
 <CAOuDEK2f_mtfiye7MdnOqEkq3pYW1kcdkwEMMBC5CkkQ1OGu3A@mail.gmail.com>
 <fddf19f6-d03a-469e-a56f-ef390c099902@rowland.harvard.edu>
 <CAOuDEK3mmR9052FWEJAVBkUanVJ1MLLebZoANiasUpD9TDBjfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK3mmR9052FWEJAVBkUanVJ1MLLebZoANiasUpD9TDBjfg@mail.gmail.com>

On Wed, Oct 16, 2024 at 03:40:00PM +0800, Guan-Yu Lin wrote:
> On Tue, Oct 15, 2024 at 10:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Oct 15, 2024 at 11:56:00AM +0800, Guan-Yu Lin wrote:
> > > On Mon, Oct 14, 2024 at 11:56 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > I'm not so sure about this.  By returning early, you prevent the drivers
> > > > bound to this device from suspending.  But they can't operate properly
> > > > when the system is in a low-power mode.  Won't that cause problems?
> > > >
> > > > Maybe this really belongs in usb_suspend_device(), and its counterpart
> > > > belongs in usb_resume_device().
> > > >
> > >
> > > To my understanding, after the system is suspended, the USB driver
> > > will do nothing as the main processor has been suspended. May I check
> > > what forms of low power mode and operation we are discussing here?
> >
> > S3 suspend.  You are right that the driver will do nothing while the
> > CPU is suspended.  But what about the times before and after that,
> > while the suspend and resume procedures are underway?  The driver
> > needs to be told to cancel any ongoing transfers while the system
> > suspends and then restart them while the system resumes.
> >
> 
> Regarding the cancellation of ongoing transfers during suspend, I
> believe usb_hcd_flush_endpoint() handles this as discussed below.

There's more to it than that.  If you cancel ongoing transfers by 
calling usb_hcd_flush_endpoint() without informing the driver first, the 
driver will get very confused and think the device has failed.

> Besides calling usb_hcd_flush_endpoint(), are there any other
> necessary changes before suspending the driver in our scenario? Maybe
> we could discuss setting usb_device_state to USB_STATE_SUSPENDED.
> However, my understanding is that this variable reflects the actual
> device state. Since the device remains active via the sideband in our
> case,  changing usb_device_state seems unnecessary.

That's right.

I don't think anything else is needed.  Just call 
usb_suspend_interface() like the normal pathway in usb_suspend_both() 
does, but skip calling usb_suspend_device().

Alan Stern

