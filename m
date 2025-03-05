Return-Path: <linux-kernel+bounces-546281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B64A4F8B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DB918923DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F481F866B;
	Wed,  5 Mar 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1XopWia"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A11EF0BC;
	Wed,  5 Mar 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163060; cv=none; b=Q555if6t37M6Tiui5aWwEEjiqxwjI9qTT8AQV4WVI56zFYr58r+iZowiLCGlSjccIXbE5NfPsN+bBrcCkL6EyeWmC6MF7vEQQuUSrKsqL+tp5NhaZe4xTb+tO9XmNBIKD/INQiCeeibPQCoC6UAwyyhe5rIabgMiZGG4vHmqSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163060; c=relaxed/simple;
	bh=lN03K1xi9Y3putlUZDpoOokl0I2oO4EryAlBT2dG9pY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sObzbGFc7CZGc5FAVf9BUmrWTFCH470F8jFfOr27IEaVedRZcD7m3OjNMlxPBslX3xFMLRNjjo0J2JjFdEtRx/1hk3yQdIXNT+VcSJCksn3URvH9lI3v1oz07Z8OyGHvMC4s55L2hQx3Ie6tt5knUaCWyynZYY99rVlgTiLz/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1XopWia; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf518748cbso732006566b.2;
        Wed, 05 Mar 2025 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741163056; x=1741767856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79BK+e10AB+bKa/Vm8u0ZrB5eghyHNaMvjiP7yjTkx0=;
        b=O1XopWia+lyGSSh9RLBXfVpjC0HkBzcqmIX8y6cc+cvqGShn7RSHczp2Kfp2YtCGA/
         eLJjoSwm+sD+HX/rM++f/tiNCZeeiXiINXI4vAPd3LJ8dp2xL02/ImJusZ/lwbWaaMag
         tAdt/nEVcRAJSfa/aRzDxz7NrnxK7OvfYR8af86zoDySJcyyLilh9uUF5T0iyvuY74G3
         vEhUS9UtLBywp/IBdklKbADDZlcsgj+cOcxOT4wvxty3Z+WvvxV17erXpffIXdfqkUT2
         iF7a9AfDs+PbKfaW67Qs40vv/GvcSU8CokHdEXCTV2xPuV462ydRqYTBaqEtA5++A7wf
         PrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163056; x=1741767856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79BK+e10AB+bKa/Vm8u0ZrB5eghyHNaMvjiP7yjTkx0=;
        b=nRY50wV1vX/F9vFClzUfNNifpNueqN/Pb+G7Hgm+CD4Jpdr9aLb0smosHKra/VD7ne
         GAUR8lcOYXXHBHx0MeFcoL10m99yNEGrkcbCQYLVYsrosTrQmkDBhAmt/Ffr+LvK7+d1
         Y9vYG7hWF68PkACa+tZBdJna5pznxgF6I3jL01Cq9EL+5antaeS9qPSqEv+wD+us5Rr+
         71y4G1CwP2TfvstdSfqt3Ifen6dWa3YvHO9p2sbl3SWq3IksIXddloacLnxd6qb4dtE1
         Qp9Amji+xD0qNnhLSG4uVWtf58m8H/JE5Act7Z0bMsBnckyDSbGybjivyOrhQse8dSXD
         eikg==
X-Forwarded-Encrypted: i=1; AJvYcCWxC4vGLbyzwGxzp4ocFsXIwu+Kvh8gczkw46iGOUGpPVZPOz/4t+1T5Y4GLxGltfdVyAwoqXJMkLnb@vger.kernel.org, AJvYcCXLwHQy0QQvh4Sj41mgtn6FApE2tAj76860K2afGZkuXceQjzOTLgGMndvDYqTJ0K/anVLdBrputLz3Q5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7y97HxUXv9FqaQA/hZMkFT1VWuzHsJ9xqChoYYAQJOqYZ2Un
	rsOuxrc8ks+//vwBhinkanCbaLhMXZWMTMicJGo1O3EqlFWv++qd
X-Gm-Gg: ASbGncujfRPvQTFmx+GvTpeBAUjevrlKIcf+dYjgXF6KXOtCvrp8KMTf7WEhzdMwBDo
	5oi1FJDLKyLnkkp5lXJ7JnpjaZnp05P2SBrrp1VkYvc/e1Rig1Uxa8hMoc1xN0enboz2HJL6mD9
	wUsGYXyEcKRyfwdVBJ3xdrL/xStaPkhQnh4DsR08Hyzih7hYVXWLT161N7mgSiUQuMlhg4xSy1e
	LULvDDx68bD3O1WP4S2xPOCRoVRptRnpK+yByiDe1CsnITtcwPEfcc3dY1+o2/5dnRgVMe8SlOx
	RKtuye3dtU7RwXgOw1hjMxbkmMDRm+1V49KVnBprvdmCHB9L8TXSK79NDrxeZg==
X-Google-Smtp-Source: AGHT+IEtxIzWvwbu/sjMdy/JH/3B/d9l7iHGPaVCZ9SqGqtQO5HDFFWtMh+qdeZHjYrm3KXFGpdhBg==
X-Received: by 2002:a17:906:c149:b0:ac1:ea9f:a6ad with SMTP id a640c23a62f3a-ac20da8a2d8mr247263566b.36.1741163056230;
        Wed, 05 Mar 2025 00:24:16 -0800 (PST)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm633513066b.101.2025.03.05.00.24.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Mar 2025 00:24:15 -0800 (PST)
Date: Wed, 5 Mar 2025 09:24:11 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Niklas Neronin
 <niklas.neronin@linux.intel.com>
Subject: Re: [PATCH 1/3] usb: xhci: Simplify
 update_ring_for_set_deq_completion()
Message-ID: <20250305092411.6962ca52@foxbook>
In-Reply-To: <e3ca349d-c77d-4643-9865-f9991b34540f@linux.intel.com>
References: <20250220234355.2386cb6d@foxbook>
	<20250220234458.4bf8dcba@foxbook>
	<e3ca349d-c77d-4643-9865-f9991b34540f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:23:11 +0200, Mathias Nyman wrote:
> update_ring_for_set_deq_completion() isn't needed anymore.
> Niklas already wrote a patch to remove it.
> 
> It's sitting in my for-usb-next branch
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-next&id=ee7dab196a7dfc48a1608274329323cb10b4340d

I know that it's pure paranoia, but this patch removes a quiet debug
message about an obviously abnormal and likely harmful condition.

My patch turned it into a nice red error.

This will be something to keep in mind, for example somebody could
write a patch which reclaims an empty transfer ring segment without
chceking if there is a Set TR Dequeue pending to this segemnt. That
could lead to very interesting outcomes if all TRBs in the segment
are No-Op'ed and the next page is a transfer ring of other endpoint.

Other than that, I suppose there is currently no problem. The loop
for finding new dequeue position doesn't seem prone to jumping off
the ring as long as the ring itself isn't corrupted.

Michal

