Return-Path: <linux-kernel+bounces-255242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589D933DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E344F1F221F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9887180A8A;
	Wed, 17 Jul 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qKaRu1Z7"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DA180A6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223901; cv=none; b=F6EDNvKJ4vEFXWQiVP1pRGMAk6mGKCTwii2eTMPmssT480DOAx3MBZtaJfHrPRn6zt3N8Kidf1qOE8ZLpLhNT4k+mSOCcjTvNzjUJbaNAEWW8T+s1AdBUBQcM9sSHKu6c0da4C358Al/Oa4gMFGCpFxpKZh3wra7MAlgMT7mK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223901; c=relaxed/simple;
	bh=UhIxlitTqUL4U0DQIwp4cW2RFYwu4E8Y2tCJXj6ijuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIHp0wkBRJ93EOe2WM5xiRqwpfBtZCFnuU13zjKHW6J4guAiu/di9QT63Usu51Jq8EVmdyblkBRh2/5pThhO0w4FgvQBAGAA/5qTwtXBA5OlDo0OJGwLUn2WxdwTn81Fa3+q9i1wkyGZdR9PrW0G7uEvZoiwhCPXjvS12g9ghBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qKaRu1Z7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b6199ef089so40243126d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721223898; x=1721828698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fALf2MLt+/Aew92qcalHrsbufxZ0gJXHdDz503oT6mw=;
        b=qKaRu1Z7m1AKPXWgx/OiZYCbDAubv0y0XmxeN8gpol/ekxRJOI2wZvbwOjLZxwNZLU
         /21OYRQkEG3+tJZKv/MqHEN3mT3DUEoT0X8/oZY7YMAcAr60FRQHVeE9G88zn5zEnmet
         TAvqEdXM0khWCPmL+z24jIVTjcGhaqv1icjuJInpTs3Z8Cgpo7WDc9o3+lGx3P3Z1nky
         ZBzAphTbMJEJu6qwBQAOZS9YLf4VEm56GhnUTZVS7UqSc1pUlMIKUoRg3BE97YK9oRo2
         zDr6lxChk9VxF77rtAXkfDHZY/yJ2GEW7j8pYFOWQ8KHQiQg39OJGFZ6DAz+paelFNHh
         gaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223898; x=1721828698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fALf2MLt+/Aew92qcalHrsbufxZ0gJXHdDz503oT6mw=;
        b=BqBGfNxJta1BCtawwDGCc7xM/+ZZUqg3h4s604Tt2EMkwJ0D4RaNBCcsZQwqorOitW
         cFQLKuZDm02BSRzGa5GBLoNuTggba7G8jTZKVPjyaNbqKp8uWACCebPF6KfALNDDAzww
         ddKfta+HF2nq/k2w/vF9BHeWu5iL8Nrlamny9wZYkPnERM9X3ig7VERnJshGgyRB6TCG
         iOEm+g1dhY6ROSXz5ucw1Pjj0n5Pv13kH0/sSUeQpOgM0wXAswEOZd36oxEhFMw3vR7M
         rpAiCDkZSuV+xCOzoWE+8RjTLhveYbCWbuRB5ZFizwYkq4WC3mBi4ZwQminj9EvVtmks
         2U4w==
X-Forwarded-Encrypted: i=1; AJvYcCXNH7PMkqiOHr2TH+9Cs4QCe62T8+le9omp2lIRY12PTGV0CGZcsaCFvjTPw26USOGPGVfudO81UjLGFfvnJbZS9brsnmnRRuYTBygc
X-Gm-Message-State: AOJu0YzHyI6YbJa/vx36yUHxUvjFw9WtgwVyxioMuc7jaoFJfmi097+X
	b4kRxSjt543kwN4XMc+OmbV3LZHYTf+9/qOn5uJe5QyyEw6KOU7wLatu0ZHhww==
X-Google-Smtp-Source: AGHT+IGNKBfEji09mQgCYN6J5M9ELvRh6o7b8ZiHnX25ZfQ2FIPphQSEpffxTGrF4fLI93qhhb8fbw==
X-Received: by 2002:ad4:5ba3:0:b0:6b5:e7e5:e62d with SMTP id 6a1803df08f44-6b78e30b992mr17886106d6.43.1721223898481;
        Wed, 17 Jul 2024 06:44:58 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a0fa46sm41860096d6.93.2024.07.17.06.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:44:58 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:44:56 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hongyu Xie <xy521521@gmail.com>
Cc: oneukum@suse.com, gregkh@linuxfoundation.org, brauner@kernel.org,
	jlayton@kernel.org, jack@suse.cz, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Message-ID: <5413aa3b-92ba-4367-b720-2fa4161638b5@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
 <ee0a5160-233a-485c-a34b-99d4a1e046c5@rowland.harvard.edu>
 <45b87923-d256-4c5e-8167-8ef764add1e9@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b87923-d256-4c5e-8167-8ef764add1e9@kylinos.cn>

On Wed, Jul 17, 2024 at 11:13:39AM +0800, Hongyu Xie wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> 
> 
> On 2024/7/17 10:05, Alan Stern wrote:
> > I'm ignoring most of what you asked Oliver to focus on just one thing:
> > 
> > On Wed, Jul 17, 2024 at 09:43:38AM +0800, Hongyu Xie wrote:
> > > Even before usbfs->reset_resume is called (if there is one), the USB device
> > > has already been reset and in a good state.
> > 
> > You are wrong to think that being reset means the device is in a good
> > state.
> > 
> > The userspace driver may have very carefully put the device into some
> > non-default state with special settings.  All those settings will be
> > lost when the device gets reset, and they will have to be reloaded
> > before the device can function properly.  But the userspace driver won't
> > even know this has happened unless the kernel tells it somehow.
> > 
> I was looking the whole thing from kernel's perspective. Thank you for
> pointing it out for me.
> > Oliver is pointing out that the kernel has to tell the userspace driver
> > that all the settings have been lost, so the driver will know it needs
> > to load them back into the device.  Currently we have no way to send
> > this information to the driver.  That's why usbfs doesn't have a
> > reset_resume callback now.
> But I still think that there's no need to rebind for a USB device that was
> using usbfs. Because rebinding doesn't fix settings lost. And it looks
> strange from user-space's perspective.
> What do you think?

That's right, it should be possible to avoid rebinding.  But we can't do 
this until we have some way to tell the userspace driver that a reset 
has occurred.  Oliver's idea is to do this by returning a special error 
code for the next ioctl, and I can't think of anything better.

Alan Stern

