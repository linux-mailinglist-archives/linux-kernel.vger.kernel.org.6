Return-Path: <linux-kernel+bounces-350399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9099049C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F6D1F22446
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291321018D;
	Fri,  4 Oct 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZkoW04o"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C81D5ACD;
	Fri,  4 Oct 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049153; cv=none; b=dN6/pim0XaLtKSiElhOS2A2s1ZlmV333Lb1mtyPd7P8sZ+0JWkarinVIaqtsR4dE7TfJ/2xhdKZD1Ff6K/8mwd3QHPMX8PAfmPUuctusM+y4KS33XT4+7M4lVFbqs75ffOwnnYfLzLRypt+VVKBeLFCYCtvtse7QLDGrTgJj4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049153; c=relaxed/simple;
	bh=nlWkptd2WlCzsAoPbb4HgqhBsNoYDxBYrSACYDL3vI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzPXu5265wQDs8YXWQpOLkegkrYaZIt4uXrNIRfiRE5BKPn/qgkbKdUEJTuJPgCl+CBH2gZLfijQLu68wJ5lNMZ23apHgNxSxZIp2jyFGDZPiHCeRPfGo00b4RhkMjjgLf24kHiWKa4aJv49T8lByolDYBGQBRf4o39LdNHktN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZkoW04o; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5389e190518so264394e87.1;
        Fri, 04 Oct 2024 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728049149; x=1728653949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlWkptd2WlCzsAoPbb4HgqhBsNoYDxBYrSACYDL3vI0=;
        b=WZkoW04ofDPzoCPeO9JRfZVJKqYAoe97I7hcGVCXi+Mr6+18KJayBTk3rhMmrmHKDZ
         ZJTS1AB/uLNzbRp7VhiUpfF10ptzbQtRDEBYtIDjjHOfotHVm5R990wojLcrsAcYIs/c
         OxvTJO5mJYDY9J1HJj3yLqYww1kIcz+RBLsnLfP1a17OyEphaPxNler4+wz98jhe2LT4
         5VjTdyGV0XUAdA0PBpodon6Oq/wcBFS9QXFqW/z2x+jyzMFGd/xB46eRWUoFgJktsTuu
         Aam3jujIiVO6kDw2kXNlsiAVpUPIkxlisrV0ua/IvXy8UlFQzvFN3K9qt7FSxDzvn78o
         Lj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049149; x=1728653949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlWkptd2WlCzsAoPbb4HgqhBsNoYDxBYrSACYDL3vI0=;
        b=tt/gVWLyuj/n/zfeLAXXFweMyYK25CkjBfxcVH7R/vFjwRgMLyfYTJAiOcxTTfyXE8
         DYlkjm24lBcTBX/b9D6FPqa8TgOKDLToHHwre5YFNdCvevwcaVFY+JWhchueuI4LnhKc
         OYXm8laTCgpxuniq/R72miY9k0VIBWOM3zVbduss7M83ylOI5FT5qF1th8yNnwMTHHe7
         bG4Q2VZVaMwUivMMu6ov1+F8RGjT3tJjCsnDzKDQ5yD/H1IZUXx/Lupws4If1bT0S9DH
         /OnuzjYs6LhaR+SQV7y9CJN1RiG9rG4BGvnjNWEHXQmjB71yKVwEhmQILRo/zS8Mgdbg
         Lfvg==
X-Forwarded-Encrypted: i=1; AJvYcCXOKYaEpAvEtp2HN4yAmaTD2FQ746gCfFN2RdZ6E6lBsIFO8L6PtNdtXp2XkeWdaKSZaHVVL7r1e9uF@vger.kernel.org, AJvYcCXpprMGCXPOI0EtakeOio5I887EpbL/Eb+ggSqhRdju3U+GnZRhaOxlR9YuxFHSpGwnndmYGXOXNUM6T1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbL8ENno+C8OwGRvyXxO7Pu6WtSUysBAQznZReVYcpiqqtkNd
	FTHkrpr05invRrMsWy3uhU+pvVFAh59bRMdC5OqID2Cy4NrTuqCI7fb0OZYW8jx4IdO9CQ7n1LB
	u3dWyY2JxGXM1goOUf/M3d9YceU4=
X-Google-Smtp-Source: AGHT+IGBOK15JeoEnnApJRHjEvPeVmQtCtRkC/B9dSDuucPMgB0sL9Rv1z0K39Nt7wbtI40pxfe4ATB81Bs57gQbVJo=
X-Received: by 2002:a05:6512:3f12:b0:52c:def2:d8af with SMTP id
 2adb3069b0e04-539ab876cbcmr500381e87.4.1728049148982; Fri, 04 Oct 2024
 06:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004123313.2463701-1-bemenboshra2001@gmail.com> <2024100421-emerald-player-e331@gregkh>
In-Reply-To: <2024100421-emerald-player-e331@gregkh>
From: =?UTF-8?B?4rKg4rKf4rKT4rKZ4rKP4rKb?= <bemenboshra2001@gmail.com>
Date: Fri, 4 Oct 2024 15:38:56 +0200
Message-ID: <CAOV59eW1fyQYZWQO9+GvEamFPPo5DH=beM2P1eZ2x7zgwsX_iw@mail.gmail.com>
Subject: Re: [PATCH] usb: usbtmc: initialize memory written to device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pimyn@web.codeaurora.org, Girgis@web.codeaurora.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, nogikh@google.com, glider@google.com, 
	dvyukov@google.com, elver@google.com, pimyn@google.com, 
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 14:58, Greg KH <gregkh@linuxfoundation.org> wrote:

> Why "explicit"?
Thank you. I think we could use memzero here instead.
> Also, what about commit 625fa77151f0 ("USB: usbtmc: prevent
> kernel-usb-infoleak"), doesn't that solve the issue here?
You're right. This commit is not in 6.11, so I missed it.

