Return-Path: <linux-kernel+bounces-249826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6792F06E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D4F283556
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6D19EEAB;
	Thu, 11 Jul 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="hh6uxwsH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E738DD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730240; cv=none; b=r7QRcMxLTgeve7sIA7J2SASP0O0ccYBsg28xHXv2Ml3lMj7KthtHfZZaP/BPeZI9iZimtw/z9b5rujiKM7tJFBonKKAWFQbFmw80LoKbC+EJt/VwpiTvLsbAJP1lGUom2+9UW02g9r89GpPxxQC09dOofLBOEzFaqp4etpFvu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730240; c=relaxed/simple;
	bh=ifVsO/BE+qnlPLrx1hI36429uKdXpygJkc87odKt5Vg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KQukWEKSutcZ2sSVB294I35Tl6oj/CgrhHbBKlHex/c4LKLXPuJURRkwhJX7Kq+6S76uoPLQkjQV7hHq7agjP+7Dggt0/l2Fju5Lf4LRIQ4lqLYeLJaHSrrZSBFT8ffiNvLPbHApKHSO7ZDlJMPjBoZANnbtpHqcguIwQXntqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=hh6uxwsH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb08d3f0b2so1005725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1720730238; x=1721335038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQm2wVcFVV2Ej/3DCwFpioRvEPP+XotE4XPlIbOYt9I=;
        b=hh6uxwsHBTBZHmlsDTg7ruWS2hrhwbPz9lxffKqH8emSMA1lLa8Y6wQKJ9gFJWWhBh
         qoeuXsZ4KX4fod1QH+xX1HM2Lmrq2QWgxhVrvk7/3YfHdDUL9Sh42cJPbKrfs18J4kxr
         ZIER+uYW+ii7brXVpBd7WKMaRQJ7guHizKwbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730238; x=1721335038;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQm2wVcFVV2Ej/3DCwFpioRvEPP+XotE4XPlIbOYt9I=;
        b=m3620Yb9yIMFRHXXpMpUM2yKV+q5srdJeOJdLo0NvEzawhO1rDmPC/vC6IUmU4x13H
         vYfVYyrF+ePlVkIPC7HIxbjMh2jMNOeMirmty2FA9pTbL83Llo+kRvK4P7w/NwKdz9+2
         89GWdaUtPh/UkNlgtv+ytLY5ipBkx4okON+YzoX9Nih7aD4b2aeqcFAUVBUjD7gIRq1b
         gLKtNJCmI7ldJiyS04s9oRckck3e4VGFln0pyGIVUZPXyZ+WmYZy9vzSPt+yVanUG+MM
         cYpJu0bDl0U8rgqWu7fB2GzHejOvFAPOEvk4iaKVSzni6EFbAOlFpx7jm+LgFW/e6tO7
         2P0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLJCZeAJbGgdPpztQ6csr/5B9W8MHErKEPxBU9tK7Z7DhmL+ISaHZqvX00+hkToktZXG5/uNKARmLv1sQdgFLCNKWnS0SaxGncKQmh
X-Gm-Message-State: AOJu0YyN6eUS2/IZxRB1s24xt++mRYeV0aqhpeLtHfTYPtnJ6iRqkXCq
	z6sSggp1spJBepxN6NbL7hVLdQHlLqn2jLP9WWgql/pDVXCc+/r29yr46XCOgz0=
X-Google-Smtp-Source: AGHT+IFxDT1MFtFyDgFQOw+HdKxecmIIfRF0jLmAo+tw80ob7sxgjLLFO1MjXqjSb7A2ok1PhNUK1w==
X-Received: by 2002:a17:902:e546:b0:1fa:ab4a:fb02 with SMTP id d9443c01a7336-1fbdc389e10mr36455985ad.0.1720730238082;
        Thu, 11 Jul 2024 13:37:18 -0700 (PDT)
Received: from [192.168.1.33] ([50.120.71.169])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6a12cdbsm54481135ad.48.2024.07.11.13.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 13:37:17 -0700 (PDT)
Message-ID: <bd9cb3c7-90e8-435d-bc28-0e38fee58977@schmorgal.com>
Date: Thu, 11 Jul 2024 13:37:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
Subject: [REGRESSION] drm/vmwgfx shows green Xv instead of actual video
 (bisected I think)
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have discovered a problem in vmwgfx that caused Xv playback to break
between v6.3 and v6.4-rc1. In v6.3, inside of an Ubuntu 24.04 VMware VM
with 3D acceleration disabled, I can run the following GStreamer command
("sudo apt install gstreamer1.0-tools" if you don't already have it):

gst-launch-1.0 videotestsrc ! 
video/x-raw,format=YV12,width=640,height=480 ! xvimagesink

And it works fine, showing a test pattern.

In v6.4-rc1 and all the way up to a build I just made today of Linus's
latest master branch and also including Zack's latest patchset [1]:

Linux doug-Ubuntu-MATE-2404 6.10.0-rc7+ #55 SMP PREEMPT_DYNAMIC Thu Jul
11 12:46:06 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux

...if I run the same command, the GStreamer window shows up containing
solid green rather than the test pattern.

I believe I have bisected the problem to commit:

39985eea5a6d ("drm/vmwgfx: Abstract placement selection")

However, the bisect process was complicated because two earlier commits
temporarily broke vmwgfx so I had to undo them during bisection, which
also required some conflict resolution:

180253782038 ("drm/ttm: stop allocating dummy resources during BO 
creation") and
f87c1f0b7b79 ("drm/ttm: prevent moving of pinned BOs")

Note that if you have gstreamer1.0-vaapi installed, you should
temporarily remove it first before testing because there is a separate
Xorg bug that causes Xorg to crash when you run the above command if
gstreamer1.0-vaapi is installed.

I'm happy to do any further testing as needed. I've reproduced this
problem across several different machines and distros. A fully-updated
Arch Linux is also affected.

As a side note, that same gst-launch-1.0 command is also currently
broken with 3D acceleration enabled, but that's a separate issue in mesa
that I've submitted a patch for [2].

Thanks,
Doug

[1] 
https://lore.kernel.org/all/20240702021254.1610188-1-zack.rusin@broadcom.com/#t
[2] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30116

#regzbot introduced: v6.3..v6.4-rc1

