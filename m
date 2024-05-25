Return-Path: <linux-kernel+bounces-189369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CF8CEF27
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF981C209A1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758484DA15;
	Sat, 25 May 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dknAQ8PI"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637614294;
	Sat, 25 May 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716644817; cv=none; b=RKvYWr0fVeYxVnxHAXMVSJv+VZX+IZAp65Ziom5eEZ1ZxP6r6ZXPAJffVnUXSirbB2xec4fCoqvzFwZnkj6rnqaJO1pKtlCh5mK1OLKIycCUn2QSwyTKJucqdCs/oZL+Ea9MqhbZ3Q9XHK+oqsh6Lx63ISSyLOXraU7ycNF+cZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716644817; c=relaxed/simple;
	bh=9WaAe0JKFp4pkiSw+YjvVW8//r4l2kcEV6G/lW/jPDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBSTKJH36Q54WKs9hpOqEl/p/W6qp0sXD1ABlMo6X5vUzMBNPspvpDUqoQF1ON/5v1nUVnxmLJhjBaxPQhsfdqIfeiqZCupURf6BVgE2S2LEj+cVIQdV9mpdfQ+agRY1iIkfd8kUawps7x4ze6r8+HxrxTDNHbt+MvRRCQE1rB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dknAQ8PI; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48a3989641cso555304137.1;
        Sat, 25 May 2024 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716644815; x=1717249615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HPFzM8Up3WuBwRJqIYkFqYshq/Exodh2xLR6AUqOCEA=;
        b=dknAQ8PIk2cBB1ZUeMoxQGq5/Q0uX5654RWFqnkoKH+w7PnUHFmfffSdfE5unRw3yL
         mS2PYZ7i9Lu7jm9Z4O3RduhvhK3YSxTA+Lhzewpr6VZhAs1H2wdQ7vmrXeYyE0S9CM6r
         S+LQqA49zFN+wtrS1C/tpW/ybf4O0sm0px4n8GnI0edm+Oi99nCHu6qTUZ/3lYVTaiBj
         TtfNuoUH9q1nzhxve6FPuY05BUqmJvMwN2yNz6XtNLEVBkTBpsN52HvmibxtO4ig9SYT
         WEefNsLhMWyIjwwBKhNvkhETSIikvmXqZWm9+8acq9v6rBV5iyFxuZ/owOK2pgbjryLx
         ljLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716644815; x=1717249615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPFzM8Up3WuBwRJqIYkFqYshq/Exodh2xLR6AUqOCEA=;
        b=kgpoLkfVqLwslt8huhdbjqyAX5V5aiEE4x+oWYsGDGWY3oKbMjZTq+1sW4WnVWK9YE
         BUwrmnNqDWhdvK1byUpzF6RZ32FzwUlpTu8o3UWYeIdzozAk4M1vR1EJgbPZa6oY+x5w
         2jhHBwghg43NUqcaZ1zWnsI/8tuLmvyBhTmNGM8ZggKocxIp7Dy7aitRR++kFL+98drX
         TUqjLg1yYOAlAlvc4KN652gAU5v21353YsY02cU8GdiUUjHtFZKPNpij6EIGC+k6PRCa
         HcZBkNbvsHIx8YMap0qkoavUqsUW/DzOKOba9i0+zv0YYAVkY81Vdv+AR/UQ5yevfgY+
         6Cag==
X-Forwarded-Encrypted: i=1; AJvYcCX6+rnZS/ARQhJ0r4da8kfDMMTyVpIZH5zIFD50HKh0u4epHKRtV50g33zgAqLUoGepOvozEjtbaIh8D9vW7ORgI4Z53mzmwBvhwjD1
X-Gm-Message-State: AOJu0YzSDyzwk56lZHi+8iLZf2oLTf4u9IUrCRmzx353GMQugtHf6/id
	w1KNf45ftXnzowofsjmiugicyA7ytuizvfHfccyRAUyIptPFsNCtU+xkniWMOmRAWYTKkRWEVEs
	4Nxt+T5ML7nsBRXZ3UW5JBUny+e+7nulu0jI6iA==
X-Google-Smtp-Source: AGHT+IHqxLN0NVW7XDMJFFzMqHi/JtmLf1WUX2BpRnVNSXNjcOxS735dlMSFFP/FwvXGAwBhJFeypLjsJLKYSiMiY5g=
X-Received: by 2002:a67:fe9a:0:b0:48a:31e9:dce with SMTP id
 ada2fe7eead31-48a3851126dmr5115496137.4.1716644815335; Sat, 25 May 2024
 06:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525063653.2331587-1-shichaorai@gmail.com> <503256e5-fea7-42ab-af15-015b0f78ab33@rowland.harvard.edu>
In-Reply-To: <503256e5-fea7-42ab-af15-015b0f78ab33@rowland.harvard.edu>
From: shichao lai <shichaorai@gmail.com>
Date: Sat, 25 May 2024 21:46:44 +0800
Message-ID: <CACjpba7uNtPPDAh+mkHc5fU2vzTGiTWkkS9WOqkPZ5sXQXZPGg@mail.gmail.com>
Subject: Re: [PATCH v4] usb-storage: Check whether the media is initialized successfully
To: Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, oneukum@suse.com
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Oliver did not suggest that the patch be written this way.
>
> Now with the patch written out, I think a better name for this variable
> would be media_initialized.  That is a better description of what it
> means (it doesn't mean that the driver or the device is initialized).
> And then you could remove the comment, because it would be obvious.
>
> You don't need to do this.  The info pointer is an alias for us->extra,
> which is allocated by kzalloc(), which clears all the memory it
> allocates to zero.
>
> Alan Stern

Thanks for your patient feedback!
I will rewrite the patch soon.

