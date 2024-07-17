Return-Path: <linux-kernel+bounces-254626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E67933597
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B131C22BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2778F6D;
	Wed, 17 Jul 2024 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMUGhkL+"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BAEC7;
	Wed, 17 Jul 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721186032; cv=none; b=RbjeU395DEBBXPHqAOBKKAe9y0qTNeUyUMoYXWHoQN968A0LOqcsg5/FYifAmxaUjJ4v6vbzFGSze8UrqOYOUsZI9pYiZM7po7CJXojqxVfjY9gE13fD8j/Arky2iVJvE5iC8/hvgpd8++LxiYRp9pyGenJ5sfqYxQj1h+HldNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721186032; c=relaxed/simple;
	bh=Fcarn7s9rPhpRjAERfo5ik6wtMS0k+cdjjk8r/rhBZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcM0O4EL8FEVtPdOdMowDJ7pPGn/3TtFNbQGkNAuMt0vGO96g4NtPmGGxc2vDQT/TaFQyvyOepQV5f8PDHTEWaYKz+bxqcgnE3NKjynH/Q1hzppdQADnwh12gRW6DZikiO56MHLgLP+XigexFBDCjvcFnh+OksZoQt/ThKc2/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMUGhkL+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4c51fb41so180680a91.0;
        Tue, 16 Jul 2024 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721186030; x=1721790830; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBXkKPZ/jalUgSlf5TgPccFoCBM8ukwzJY09wBHIpc4=;
        b=HMUGhkL+igJETQ10mqh66weSMc5b6wSkHkg29iLPSN7BBdi2rq36vZ4SV9doNnGCca
         HIfSz5hvu7XVmziXCyvfVNd+UPHjm5IlVkFWPuyE2Ms6i6TE46WPGWYZA/V7wuK/Q71X
         69SsNtjSxZoOd1vq+hl5oaME2lr4I0QOEQBz61zPfTjuX7fPNWsAzcmm5RWRgaOYon0a
         MYooOVK4mCpj4fg2cOpSFv/kIk7/M3/Vt0/El1fAXJmpQQAkzusX8IvSlPYyMxJAOOT7
         cvUE/J3tXMYCsCo2CMTMW9zGOfyfPjgOCXQ7jQ4hZ6j23ycruQ2QojXMjhTnUOkUlLxj
         HQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721186030; x=1721790830;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBXkKPZ/jalUgSlf5TgPccFoCBM8ukwzJY09wBHIpc4=;
        b=qVXKcDBhW+RlwqXBzpJAP75XzfZk3pEUp60SDNZIlTQX/YWT4UvM4FYc4RICmezSv4
         SIljjlPnd9sWOIN8QifcY5WegZwUj6JZM15sJTDOuNgUjZDQJmrc/awaOF4WuFfbS8hh
         QxqBQzRgmRFP5GQ4zD1clH3IsQZdfzdp3jbi9Saugo4L/gyjs+WMLKlwOrZ7m5kkMOlj
         yB4bEVKdStv7YcFHQiIn8O6o0xWt14zcr4YnfBY+AfRUJlDrpfbbdizDgiU0IaIKtXhA
         +bUNBaEkKzzT4CgOPzSnrialSpAKA26f6gr/6jJay0GPr/v7HixwkrNcusszCdXsqioh
         TUkA==
X-Forwarded-Encrypted: i=1; AJvYcCWn6muU0uOYxU7xqVi+4jjzPb8iheRP53XbIkE3dyorm5qmSJmoZytSyAjZfZVlpoPaMj92hWCJGILrt6LUSLZwn1ssiFnNsS8umxsiGLuQGxlBFRPDYRAOUd7h8tdVIVDH416dxs2V
X-Gm-Message-State: AOJu0YyETFf4BVoR5Hj1D/FtG6ZZzgRXQMGXoPGISKTfbNXaZTkSw/iD
	lpQWF9v3S50uFGqIXf+81hBPb+GUpuEA48rC61L33NO3wBu6IWVu
X-Google-Smtp-Source: AGHT+IGqP+M0Ee7JY1ExYQ2wwfOpJ2Ifyjg7phZTgR/vqMwjxduSc+thY5pdB4K7kZPRVWVM2+E1Gw==
X-Received: by 2002:a17:90a:f0d1:b0:2c8:6793:456 with SMTP id 98e67ed59e1d1-2cb51e5f06fmr303594a91.0.1721186030034;
        Tue, 16 Jul 2024 20:13:50 -0700 (PDT)
Received: from js-pc.. ([116.162.132.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedc92d1esm7012247a91.44.2024.07.16.20.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 20:13:49 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: stern@rowland.harvard.edu,
	xy521521@gmail.com,
	oneukum@suse.com
Cc: gregkh@linuxfoundation.org,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Wed, 17 Jul 2024 11:13:39 +0800
Message-Id: <45b87923-d256-4c5e-8167-8ef764add1e9@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ee0a5160-233a-485c-a34b-99d4a1e046c5@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
 <ee0a5160-233a-485c-a34b-99d4a1e046c5@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D

=0D
=0D
On 2024/7/17 10:05, Alan Stern wrote:=0D
> I'm ignoring most of what you asked Oliver to focus on just one thing:=0D
> =0D
> On Wed, Jul 17, 2024 at 09:43:38AM +0800, Hongyu Xie wrote:=0D
>> Even before usbfs->reset_resume is called (if there is one), the USB dev=
ice=0D
>> has already been reset and in a good state.=0D
> =0D
> You are wrong to think that being reset means the device is in a good=0D
> state.=0D
> =0D
> The userspace driver may have very carefully put the device into some=0D
> non-default state with special settings.  All those settings will be=0D
> lost when the device gets reset, and they will have to be reloaded=0D
> before the device can function properly.  But the userspace driver won't=
=0D
> even know this has happened unless the kernel tells it somehow.=0D
> =0D
I was looking the whole thing from kernel's perspective. Thank you for =0D
pointing it out for me.=0D
> Oliver is pointing out that the kernel has to tell the userspace driver=0D
> that all the settings have been lost, so the driver will know it needs=0D
> to load them back into the device.  Currently we have no way to send=0D
> this information to the driver.  That's why usbfs doesn't have a=0D
> reset_resume callback now.=0D
But I still think that there's no need to rebind for a USB device that =0D
was using usbfs. Because rebinding doesn't fix settings lost. And it =0D
looks strange from user-space's perspective.=0D
What do you think?=0D
> =0D
> Alan Stern=0D

