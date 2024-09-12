Return-Path: <linux-kernel+bounces-326078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26897624D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441FF1C22F56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6D18BC27;
	Thu, 12 Sep 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsT0YJ6g"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58288186E58;
	Thu, 12 Sep 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125132; cv=none; b=mxyeQ8YDE/0Q9etavHo24j2IuN024G1DP34QEXFaF/TeTJAxU7BGWKT7Ni+R6R5vungvAQVZLT0JxIoao3vhr22r5GBKO7JxidMj7g4a0oBTcs18PWOSecPxjXg44jxVHKQgSNGIZHbS4gZuz1DRL0XbKyy18sD/2bKAu044v2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125132; c=relaxed/simple;
	bh=MZG69yN+VrDh2mqtkQIj+eKhaHCGouv3mkdUyAMEDE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr0q4WxWorpZw9yv+aNimK32GmnuQpdYsfGqfpYK9bA1PI27YL+gJ+qnl/UXTb+XvJJLhQHApcEGz2r5hA7RE0b378xaB18f2oXggVrGFSyRxk6qubUC4YOAYdDJDCgyQ7pUAZzO5dy9IUtyi27wAXwK7dBb7bFWoxPRUGhRhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsT0YJ6g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso946143a12.1;
        Thu, 12 Sep 2024 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726125129; x=1726729929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPB8bSnbYYyaLXMYazm7IKm+KD/Qi3JzsUK5HOuFh60=;
        b=WsT0YJ6gfyLGThYZzFsBbwemVYL/esVyCJzA8z885N/7UwBnCZZjc97YmX8xJPwNsk
         ZUwHztMoqF4XtQqe7WTxPy2Od20LpPVUVEJ9ijHxu9EfgfTWluCslwHPFuYgzFVWDQnL
         u967+yrKFMV9whnjlyTEBVJjqHt74w+a3XcUjRb/jthGVjpu+OAmgsWZD+EzbA5J/fiz
         kGzktRAFzrjki/DjgBPjkXzYYWe2l6Nxy1Ndan1X7Kfy/MGX+B7d3VVMm4ZTktSfXXJM
         WdFjADOGx6ApGUICjmZmoV6t7ZoDEzq22knqLCyoAV3GvhSEJ1NLKIpwXNml2jNdHAUb
         of8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125129; x=1726729929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPB8bSnbYYyaLXMYazm7IKm+KD/Qi3JzsUK5HOuFh60=;
        b=Cq2rzFRtl7+3hlCdnoWTvjbCTtzyM7mvpGei14EWIWH7GeA1x/WXqiMTh7a0TZ3CWt
         M0UzoGlZa/BwApKqgII6uvIcZdJCMaedpx75DG+/DxRWDMr+DJoXsJIynkJpZFzNuxuM
         jeLBaRPUA/n2DUxj9GCxZ+Oz6q1QkzBeDhHWz3tLk46EWjB6WP9K1V5ORv4MASIAAEuW
         eOFRvJd2WqCgFjMZ5uIN4NKZELQQ2fuiGsLGZ7pDd2DQw2oV0axNzOZb31L2fP4byX6L
         jv0jVnzY5NdUsB/WLUKyF+2M6tMg8LvYrPzWSORjvwSxGytLJPLdcn+Upk0YjF2JkLva
         uu9A==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ5wBc+/RiMQKMKh0p8TU4TzYJkQlvtk9beuWKLxe0mIYmSB9AfJ8p/1QMSdSq/1GXluwcyaVzBvU@vger.kernel.org, AJvYcCVklZL6oyV9ASiMQGQ+FxpJAY/uhiK8nDCQ11t9D9PqszRlVLxNmcDLbY04sjTwK7vklL2cjpby+2pWd3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvNaKzsH7dgZlqmpq5/dBrieyEz+7Iqy7YT9TQRKgsrjROGeu
	qB7ex6l+E5IqadRqSj/15R2/4/Q2+RzGXu/vY91uHDB4owE8EoNo
X-Google-Smtp-Source: AGHT+IFjQrmnZ1v5Q+Orx0b/xD4kyE6g0/G6HJcyZYdPWz5D3lxa0VyltlCMrHlspyo4MAW534kIbQ==
X-Received: by 2002:a05:6402:27c7:b0:5c2:7699:92ef with SMTP id 4fb4d7f45d1cf-5c414387344mr2023513a12.16.1726125129160;
        Thu, 12 Sep 2024 00:12:09 -0700 (PDT)
Received: from foxbook (bio143.neoplus.adsl.tpnet.pl. [83.28.130.143])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd52099sm6142860a12.48.2024.09.12.00.12.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Sep 2024 00:12:08 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:12:03 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH 0/3] xhci: Some improvement for Etron xHCI host
Message-ID: <20240912091203.3ac9b88a@foxbook>
In-Reply-To: <CAHN5xi235kgU8Xd0VYw6r5NeieCM8uqWjgPnLSP1haAFqgcFsw@mail.gmail.com>
References: <20240911051716.6572-4-ki.chiang65@gmail.com>
	<20240911093828.58129593@foxbook>
	<CAHN5xi235kgU8Xd0VYw6r5NeieCM8uqWjgPnLSP1haAFqgcFsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> > I'm aware of one more bug which affects my Etron: if an error occurs
> > on an isochronous TD, two events are generated: first the error,
> > then "success", even if the error is on the final TRB (the common
> > case). Then the "success" causes "TRB DMA not part of current TD"
> > warning. I suspect that all Etron chips are the same. This should
> > be easily reproducible by unpligging an audio/video device while
> > streaming.  
> 
> Hmm, I don't encounter this problem.

OK, I know what happened. This bug only affects SuperSpeed isochronous
endpoints. If you don't have this kind of device, you will not see it.
I checked that High-speed isochronous errors are reported correctly.

My motivation to develop a workaround for this bug has just decreased
another notch.


On the other hand, I was unable to reproduce the control transfer bug.
The exact chip I have is labeled "EtronTech EJ168A", for the record.

You are right, not all transfers have the data stage and transactions
get out of sync with segment boundaries. I modified the patch to only
print a warning instead of queuing a No-Op and then did various things
which use control transactions: setting baud rate on serial, changing
the volume on audio, starting video recording on a webcam, running
ethtool on a NIC.

The warning was printed a few times, but nothing interesting happened.
Dynamic debug was enabled on handle_tx_event() - no errors reported.

Maybe a different silicon/firmware revision, or maybe it's another
SuperSpeed-only bug, or other special conditions for it to happen?

> Ok, I will use one quirk XHCI_ETRON_HOST for these workarounds in the
> next patch revision.
That was just a suggestion, you should ask Mathias Nyman, I suppose.

But, again, my impression of this hardware is that it's pretty bad
and full of bugs, and they are bizarre enough to likely be unique.

Regards,
Michal

