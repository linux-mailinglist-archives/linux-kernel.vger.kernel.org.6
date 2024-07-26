Return-Path: <linux-kernel+bounces-263791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8F93DA82
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0097BB2519B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D9314EC47;
	Fri, 26 Jul 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQRxWqdX"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345C14A0BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031275; cv=none; b=mRYJ+zSgwMHfJXaXXE60guntwSht3qYojLE9HyS2VP09WbwtudbCgGRinGybCsOnMy7vW/Dvttsvm9ojdLORZAAu6C+SmuIYkCabo0Da90wIHhxyaxBkt7e7/2a76FNxo11IKlApYV0pXeH5WhK0eerbRplV1K0f2fATZJKCCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031275; c=relaxed/simple;
	bh=IGcUNr6yiwltJOH+n2/ZQt7C9G0zNgnUYwEKP73IvpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsDjUsAUzCQx+pl1jgelmiHZQZ83eZ1abumdI9gcaBQxaUcHUDduzGEem+xN/GtOl/UtKaDt8XbuX/3uB4zuYymNuUf0NVTX2U+ksTG5deiI5i86gfyMXIV+dN4jXjJ23zlPy+rOrzsvXPpXNV/LPhtD84T9OTdcdNFo0BimhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQRxWqdX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so1042300a12.0;
        Fri, 26 Jul 2024 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722031273; x=1722636073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePMLs6JuWxZrAt7txUfAPwcMCQPULxDTb2mv1WNbrvI=;
        b=YQRxWqdXlj41mWsGh31oCFMqzveN4whzpHKR8zH+6E3JAVCoDwiDQWpdSkj21WsMlD
         P2kHhaW36KzBNC/JHwa/ecj/DaxZ2xsUvauKYldq6MpdHu6qC6kCx5+HUnwXZsCUSVK+
         ROpBXBzagqAAL2ci/gFsrPAEBRtE11V2+HdhOGEVP7S/FnsIJ1wkmW3RyQ7kCxsd5Exi
         Wx91PP2CTRgGWyew1aiwKSVoPjG6pgqbrPB08izNL2npBgCtAMQglCwlmliYNEcnCevd
         jUsovGbcsgv7G2PXo4A/KutztCeJFvRgJSx9DF7EGmg10wN4qbXQC07w249a9cjCf9O8
         DtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722031273; x=1722636073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePMLs6JuWxZrAt7txUfAPwcMCQPULxDTb2mv1WNbrvI=;
        b=kBIJLWaBCQiaaNYCsNXO2uaRv/lQ7wW62ynoS2+W2Miu00VcfwvG6+kn9N5+H5+cVb
         gACJVCWuAV/WfOqIwmd6byzpuVigCUeDLCNnCt+z5/430BIU+YXDrTEElpKU+ErBGTN6
         W2BWK/pd0wkxezJZ0tzYP5+XW/peqp93bRLNrv4yVXjQSY7msEg+CgnpEepnXn2qRnfB
         Po5lyFsiey2RI3N5VxXD6TPKl43PYxIRzn5CE3gKkHlyKq72r1/xrnEtROmWqktkhlAz
         VecGf6+RQtme7tgmhIIVSdA/u/K2LeXSN/oSHyqrXVC2oTv8gZk8lnpAHGq9sBUz8vf9
         MyVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxYxBtGK8mq06bYHeDoUMgpC0yNLQPaV1E3G20ndQOTrBU9XZiLTdCZ3ZcEJ9zlMoyiSgppWGhBMOJNTMmXS8Jt2MobcWI4VU9jCN6wousj8Sz+B3+mLXJkbThksHQBaF5VmX5CrSnvw==
X-Gm-Message-State: AOJu0YxQj+i3LM9YYT16X1e6S8ttvkcl7QrtDAMslgUXQHtqwSOdSMEi
	2CndRP629XzvahMN64AeSFgtr+oeWEvb1npp5EVDx/qhlCrCye9geCJe1g==
X-Google-Smtp-Source: AGHT+IEts6WckIjECAYZSDX4dXMnyX7rNQxQQg+Vw03paBC6QDZKPlaG35xCkQvF/iLBnqWBUXP1rw==
X-Received: by 2002:a17:90a:1c17:b0:2cb:5678:7a1c with SMTP id 98e67ed59e1d1-2cf7e1e1e69mr1038710a91.18.1722031272806;
        Fri, 26 Jul 2024 15:01:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:891c:7447:8bd1:fbbc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7fef3sm4029710a91.16.2024.07.26.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:01:12 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:01:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: hdegoede@redhat.com, inux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - fix LED state at suspend/resume
Message-ID: <ZqQcps0s5ilLmV1W@google.com>
References: <20240726102730.24836-1-maqianga@uniontech.com>
 <ZqQbr8aZnaYi20Dp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqQbr8aZnaYi20Dp@google.com>

On Fri, Jul 26, 2024 at 02:57:03PM -0700, Dmitry Torokhov wrote:
> Hi Qiang,
> 
> On Fri, Jul 26, 2024 at 06:27:30PM +0800, Qiang Ma wrote:
> > After we turn on the keyboard CAPSL LED and let the system suspend,
> > the keyboard LED is not off, and the kernel log is as follows:
> > 
> > [  185.987574] i8042: [44060] ed -> i8042 (kbd-data)
> > [  185.988057] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> > [  185.988067] i8042: [44061] 04 -> i8042 (kbd-data)
> > [  185.988248] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> > 
> > The log shows that after the command 0xed is sent, the data
> > sent is 0x04 instead of 0x00.
> > 
> > Solution:
> > Add a bitmap variable ledon in the atkbd structure, and then set ledon
> > according to code-value in the event, in the atkbd_set_leds function,
> > first look at the value of lenon, if it is 0, there is no need to
> > look at the value of dev->led, otherwise, Need to look at dev->led
> > to determine the keyboard LED on/off.
> 
> I am not sure why duplicating input_dev->led which is supposed to record
> which LEDs are currently active on an input device would solve the
> issue. Could you please explain?

Ah, OK, I see it now. We do not actually toggle input_dev->led when
suspending, so atkbd uses wrong data to determine the LED state.

> 
> The input core is supposed to turn off all LEDs on suspend. This happens
> in input_dev_toggle() which is called from input_dev_suspend(). It
> iterates over all LEDs on a device and turns off active ones one by
> one.
> 
> I think what happens here is we are running afoul of the throttling done
> in atkbd (see atkbd_schedule_event_work), and it does not actually turn
> off all LEDs in time. But on the other hand atkbd_cleanup() (which is
> called to suspend the keyboard) calls
> 
> 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);
> 
> which should turn off everything anyways.

But still, why ATKBD_CMD_RESET_DEF does not shut off the LEDs for you?

Thanks.

-- 
Dmitry

