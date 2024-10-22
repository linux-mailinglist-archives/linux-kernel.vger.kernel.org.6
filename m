Return-Path: <linux-kernel+bounces-375919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93C9A9D38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05679283884
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592E184540;
	Tue, 22 Oct 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKe7gBqG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C718453F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586529; cv=none; b=aXPx6vp62+dRkiaZiWpwdg4HAz2FTTmoK44/Ev3YjIRwZQZvKQ9ScHsCVRUrzJhdByfns9yIQ5WVZNpmCfHILqBSIITwm49PKTGCMXTzESB+IAFLzisSYoaJVRERcirpM1RwX94Ui0e6SVPQ6UgEBvLy4PrMa2Zu1IH8SZT5jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586529; c=relaxed/simple;
	bh=c0NMTTR5JL1Di73BNEWR805V2eCvwQdiqw0CWy0WIXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ko0xifARN22sokOCUA5bAN0MhikcRoDCfNiFg8npwnsFbi+RNlnwULVbfr8r2dhA70tL+CzPH2+5LGhAPFLcZhzXZ31TrnANLJscLZq4Z98wIR3vq1/nHhlK3WNvfuYSKaUpLmwGG1mJ2M0Pqk1yW5ejicIksoqthNcj5wO54yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKe7gBqG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207115e3056so44166945ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729586527; x=1730191327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8i0a7jvEXBZjJllrGzrgyCiwD9G/M2/DO+l81c5UZVc=;
        b=WKe7gBqGNURxzLOAhKuiuD5AVawrKHRy0LFHhQchk7WM02a7eVSSiwBj72pQA0EEpY
         mnb52TqzKPnE+TKhbGf6XWJuvoTch0qP5ST4X8fknGChQgSw2n6hj8xHQ9rAN6yIIhlV
         ueY6mr6CeQXmMP8lcVU6ea7PLRFUN/ajf+q14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586527; x=1730191327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i0a7jvEXBZjJllrGzrgyCiwD9G/M2/DO+l81c5UZVc=;
        b=ei9ZT4+9rZfxhncErfE7KiQdR59rcGrAg30afGZjqJO2y7f8Olo/CFF+BEQFrXQEha
         4IMEZnoxOFB5wmo91sOBliIC+2rmY8bUvRPCBbkUFsAiyy1N2cOGGXLL/+K2pC1GCmJv
         oVfVjXOhp83lpR4QyZdULm+SJCfOm6RM8/o1VozI+dEpTtzfdyiSKbU1OEXJ6obo355Q
         tYKYNT3cYCV9OFldD0H0S+IogHLDCLIu7w8sZp5ZYhT6iVUH21kX35wq3GGsDas48Jyd
         fwjhLFC9OqOtxbFo+01TTQqbp0peAyiM5ag/H2MdV/ZZ6i+f+WtgcfZc7Lw2/vSOgswJ
         WH7A==
X-Forwarded-Encrypted: i=1; AJvYcCU6DjOqkP6HlYO71PsqJTTKa8o8wGJfOM2FFe6d85CcOeyDFhPWoiJKXUGHKlB0vS7kXHKUOC/WipvgdZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmXiSFLUddtmtprR68Mf7WdRngAfKzfopJoq1SPgT7u0nt/oC
	XEdR307NiUHSmEKEg6VoKzbiT7NVJxj+6BjWJ6JUSN8SXrZ4CIXxeauyAHiWrk4sQ/qKq0+gzNo
	=
X-Google-Smtp-Source: AGHT+IHHXLcEZX7LM2KTiNFEayojGE4cxvnEOzcvP7T0dkyGfhBZIC9tQpbmI9I8kax2k+yQyq9Xzw==
X-Received: by 2002:a17:902:d510:b0:20c:5508:b64 with SMTP id d9443c01a7336-20e5a923eb1mr179255205ad.47.1729586526789;
        Tue, 22 Oct 2024 01:42:06 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd56dsm38212545ad.177.2024.10.22.01.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 01:42:06 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so3926200a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:42:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY4inpxcCB9huk+/bQYITBQQxQ3JYT95rdt/6ha94Bg78BjOOD34P0I5R9iPyuxNiQKTVmfl1FmMDe8jY=@vger.kernel.org
X-Received: by 2002:a17:90a:3dc2:b0:2e2:991c:d796 with SMTP id
 98e67ed59e1d1-2e561602e2bmr15745613a91.9.1729586525467; Tue, 22 Oct 2024
 01:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6714a6cc.050a0220.10f4f4.002b.GAE@google.com> <20241020160249.GD7770@pendragon.ideasonboard.com>
In-Reply-To: <20241020160249.GD7770@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 22 Oct 2024 10:41:48 +0200
X-Gmail-Original-Message-ID: <CANiDSCsMAiEPhDLx+1aSHUsuYrFrC0vGn9q76nYOGwX=1pGjwA@mail.gmail.com>
Message-ID: <CANiDSCsMAiEPhDLx+1aSHUsuYrFrC0vGn9q76nYOGwX=1pGjwA@mail.gmail.com>
Subject: Re: [syzbot] [media?] WARNING in uvc_status_unregister
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: syzbot <syzbot+9446d5e0d25571e6a212@syzkaller.appspotmail.com>, 
	hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Sun, 20 Oct 2024 at 18:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> >     media: uvcvideo: Avoid race condition during unregister
>
> It looks like the issue comes from the fact that uvc_status_unregister()
> gets called from the error path in uvc_probe() through
> uvc_unregister_video(), likely for errors occuring before
> uvc_status_init() is called. uvc_status_unregister() should return
> immediately in that case. Ricardo, do you plan to look at that?
>
Just sent  https://lore.kernel.org/linux-media/20241022-race-unreg-v1-1-2212f364d9de@chromium.org/T/#u
to fix this issue

We probably want to queue:
https://lore.kernel.org/linux-media/20241022-order_status-v1-1-3904fafca340@chromium.org/T/#u
at the same time

But I am not sure if I should also mark the second patch as Fixes

