Return-Path: <linux-kernel+bounces-263768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8893DA49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068351C2330C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8A14D282;
	Fri, 26 Jul 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp5TIsdn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0771494DB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031028; cv=none; b=R26vIFat1WvG9wVARr/0ifyU64MG6QELQg84CWkgXi1HiOpUbPhzUxgX7AH8pPu4WSIV2YKSOEWP7rDZMLfZS3t+SmCjnESaHhVWZ0jSLV78YCmURc8enX6E+rOXlzUF6SqA23+9ykh5hG+73Y3KihLLYBs66F8eDM24Dn1GUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031028; c=relaxed/simple;
	bh=n5EgPjLJ4DlM/FvKwJG0Rb1NknqdotR7NtvK958V26o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bde7b5HiY0PmCg7/4plZTbPkXP4LWjRDupbc2ONAGwLWOXy8JFJvd4ReUSUA873J1moRiXurqNIP2hJEhaBXBqiu5gixfktlHevj5BHOSWOnXvde9P+SvaZNxJMDV499NCNk9k6Lruv0EUdoq73StDy6Y32EsBekggG3iF4LWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp5TIsdn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so8781375ad.0;
        Fri, 26 Jul 2024 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722031026; x=1722635826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7VvZc34TPqv2SpARPN9B3UMyNKJRlpoSjXgpLtWBpQ=;
        b=cp5TIsdnWTpUQaImw4UcM2deouT9iaBON8KVx+1BTrov0u16tL96UBi/CdsE3LxM92
         yCD+IzngYRISqExeIMcv9JjSZAk/r/YdW4p8iRzj+0efjYPI7ZrmKo18dijatupSkXTI
         t4SFmzZeejCvmSIpJSFtrLdOzteCSkRxR+CM+qhwHlszMWFgcf20mqI8lWd/wXRHwXkV
         H9TKE9hc/64eDHg+Wp4H9XE42deBf2XktwkcmOQCj+Ko+QvVL6+/c3q60N9bXJWuVRVk
         kWAVPEjDjeoDFWtFG+eURn/ZKz8ydQ7gQBzYdLOG/Aztnm7U2ZWMOCU21JGEpp3JnyQ1
         zF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722031026; x=1722635826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7VvZc34TPqv2SpARPN9B3UMyNKJRlpoSjXgpLtWBpQ=;
        b=Xrn9/YcZb/Q+KZvyXgpNQetK537KVa9dlsheLrQg4moAJyLlyGbTLGBonD7AIzxCSJ
         Jo8cxz19d2kCrMd5tgxNViy0cTRSFcZ16Kaiu6MeoQYzp3Qw5wcsqqXGzRzoKEM4x8bV
         lhOA+5IUF8VvIy5NA2jELNx3sVsVHEahXj/Y8UBr7u1XHB5XRyFRMdmynoJaMpDzGUN3
         e6/mcL4JinAtPaCnnAPQ5831hpS2fYrNsl0C1Tjk2qZmGnudrFyLj1zho5/brTMtFjRC
         ERq5lf5tvMd1q1QEE9VsMpHDO6j+Zqf4cYUyk2d4fff9zN3DO7Crvf+VVtZzijdaQPoc
         d5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUEJYdh9uJ80zY823fDrzKr4X0QOTWaCG+l+vRAGTvN3arIaV37Hszeno1FBRlIn8RRorN8+4cjvejdvTaCiG1TOvgtZA/la2DDu+yJYNXWvNnpq05vy8XRD3EuqhfAokl+FAcDVgHYrA==
X-Gm-Message-State: AOJu0Yz98J0NzIEWeUOciws4AHZlNqs+GvH1eLMl300qY0JMOI5ctgmT
	sD0JAUbMrIZq1TsUHo6doTVSa5qvgdOd9cAuSetFKDWwTvC3bJHbGIO/5w==
X-Google-Smtp-Source: AGHT+IGV9VFIAPhBUa6SDtwo5s8zyqiZeIy8iZDtSndQqmcqJuMXR74/sE3szho7hw7s1EWNXtbXXQ==
X-Received: by 2002:a17:902:ee4c:b0:1fb:9280:c96e with SMTP id d9443c01a7336-1ff04889615mr10456815ad.62.1722031026364;
        Fri, 26 Jul 2024 14:57:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:891c:7447:8bd1:fbbc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f671e8sm37699815ad.228.2024.07.26.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:57:05 -0700 (PDT)
Date: Fri, 26 Jul 2024 14:57:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: hdegoede@redhat.com, inux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - fix LED state at suspend/resume
Message-ID: <ZqQbr8aZnaYi20Dp@google.com>
References: <20240726102730.24836-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726102730.24836-1-maqianga@uniontech.com>

Hi Qiang,

On Fri, Jul 26, 2024 at 06:27:30PM +0800, Qiang Ma wrote:
> After we turn on the keyboard CAPSL LED and let the system suspend,
> the keyboard LED is not off, and the kernel log is as follows:
> 
> [  185.987574] i8042: [44060] ed -> i8042 (kbd-data)
> [  185.988057] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> [  185.988067] i8042: [44061] 04 -> i8042 (kbd-data)
> [  185.988248] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> 
> The log shows that after the command 0xed is sent, the data
> sent is 0x04 instead of 0x00.
> 
> Solution:
> Add a bitmap variable ledon in the atkbd structure, and then set ledon
> according to code-value in the event, in the atkbd_set_leds function,
> first look at the value of lenon, if it is 0, there is no need to
> look at the value of dev->led, otherwise, Need to look at dev->led
> to determine the keyboard LED on/off.

I am not sure why duplicating input_dev->led which is supposed to record
which LEDs are currently active on an input device would solve the
issue. Could you please explain?

The input core is supposed to turn off all LEDs on suspend. This happens
in input_dev_toggle() which is called from input_dev_suspend(). It
iterates over all LEDs on a device and turns off active ones one by
one.

I think what happens here is we are running afoul of the throttling done
in atkbd (see atkbd_schedule_event_work), and it does not actually turn
off all LEDs in time. But on the other hand atkbd_cleanup() (which is
called to suspend the keyboard) calls

	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);

which should turn off everything anyways.

I think we need better understand what is going on here. Maybe post the
entire communication between the kernel and i8042?

Thanks.

-- 
Dmitry

