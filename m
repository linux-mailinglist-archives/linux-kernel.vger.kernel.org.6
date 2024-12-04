Return-Path: <linux-kernel+bounces-431931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD99E42D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915B41666C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57720E30D;
	Wed,  4 Dec 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvY6gWCY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230E20E306;
	Wed,  4 Dec 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334833; cv=none; b=YPupMSIwxsRqoq9rDGDTk/BnVjo7x8KCgjgVXdj0g0efAuuWi7y+ovtGyNtJ9KVMpNqVBu96aZkqC3fKZufQcHxB2+O0k++IPeV/Q04UEq93pyFXb7sD7c/DzNcUjTqBKPmGOlZ2IreBbYllS+3oqfSVY+eiCgC2oZNloL98J8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334833; c=relaxed/simple;
	bh=YgI6bbVf8fawNLoh5G27JRcUteiQDukkT9IoSyRi4/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajun7SM8n0sg8hD1k8Fett4zawKyXWGqVLLi9SWguWU9gj9ymS8er3SSoptdvcg1wUfTqnvIGCNTVoS+aG488d7BIlmqTEK45n4i9CysOZeO6Gf32StQlXJpwuRAazZQL6igJenqlUjJ7+RaK9EhNtVJ4sXrUQVpKTT/aE/4WwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvY6gWCY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso89410091fa.1;
        Wed, 04 Dec 2024 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733334830; x=1733939630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzu3n2Qpj3CtMKuLFOgq+iWAfCQoArTJr+VrPbBeo9E=;
        b=dvY6gWCYperKkFM10bamyG2DJb6eyxD/mWr0DrFWndVM/9Hgx+dwH3EUB3bOva1hGd
         Of4POnF8zRn+gxU6RJGtv02B4r3Oaw31sw3Yd/egP/MPLDdH5eBlDX1lNTksyZ4eBARn
         p0YkoYYDT85nfkzAcK77dh7cNPxZWjb3ZpqtP7+bRdqfMB4BPE4y/9N/b4X5OKG1EA7l
         hhcPiUGSEscfh/lpbI+2U5/54jcttTbthW6wR4PNXoVkmLsgjxKbkS220MIbWK37T+D0
         wTeJM+DisSj+WGG6HpCVCjDiTF6D3EA+uWESAhrmooi0ZVYMTMlbDhZjIRQn81dbH9LF
         li6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733334830; x=1733939630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzu3n2Qpj3CtMKuLFOgq+iWAfCQoArTJr+VrPbBeo9E=;
        b=uhHz2TqEarbBUCo6xEltDPFkdEb0aQHz/MpomQJGHDdcA3LqPSXxj7UI2Mtko7oVI8
         P09WVhAQqyBWA+vn21tYrsUCTnkWwcrP9MDhRFefd1Sx+NjQ99b4rdYHsWBfH/1a0njs
         Hqd8vC/L4D0Jc6s62u08gzh0kb4gfdipUoit0eZcHUxMTMZzOqo94h4W2UjM5ykwJ/9a
         O2EtTGX/mzJXIdx/NggsRLQdZf/70P0ryB7Rkf5bAz7XZN7abYYDSKd4Lfd2k+k+Xcv3
         uUXsxzaTh7gpSuumXVh2FiGg+9bRwKQXtKAUIKmka8Hc9TBmdZlY4OK5RWcMlMYasFFn
         JMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmo44LDR4yOEoO7qpJ0z708U/K3hhysaCwpgCwUVYk5xheks6u9+12C0I5tXe/mm0ivkk4lH4dWkqzT4Y=@vger.kernel.org, AJvYcCW1hsr3icy0dT9vosrI4dGGKqfmMO7b4MpVfGIi65NklGZldMjWM5igQVXj0JQ55MeMDKAt62w8GGup@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSLoW0Im6UI3VIDrs9DRsbT5fyU/cpgeyfxwkXplxTa7LWMKg
	SztYc8ocKT0sfScYunHZldaJwPEjoHbd9xXGmDu7vSRDKAlxX6Ts
X-Gm-Gg: ASbGncufG+9oY92wfQ/3YqXpg3UtXkZ48cmeqrQmyV54mxy7qteS1YmlhjJ8MX3MZDN
	+AIdOFQ6SEvLz4f7KU3SWNlDRSSdV/5qGX3urx2ZpK4bOlSiPgFnVw07duZuRtpeVon9X/uZA6L
	Yl1xBBqXjmwwVcRtdylcXCf6uSNmYyaW9CmEsKMY1iLpBvvxMkEAPl99/Qon5WAMxnpoFDJJbwl
	S+qVlPoZ2NWTo1lF6yj54LTcCkgeqHHxumFls7iDWkCWHQsT1tX0UBSEhU1nox98lw=
X-Google-Smtp-Source: AGHT+IFBp8c7Yqy9B76Hkkh7O7QcdGo83+Q1/4MpNXwhFipbF7NUX1lTPPYUaOz1fhbjmJvK4fW8Ww==
X-Received: by 2002:a05:651c:502:b0:300:1c7a:e22f with SMTP id 38308e7fff4ca-3001c7ae68amr6011191fa.5.1733334829763;
        Wed, 04 Dec 2024 09:53:49 -0800 (PST)
Received: from foxbook (adqz254.neoplus.adsl.tpnet.pl. [79.185.159.254])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3001959c429sm2305771fa.103.2024.12.04.09.53.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Dec 2024 09:53:48 -0800 (PST)
Date: Wed, 4 Dec 2024 18:53:35 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: xhci: Fix NULL pointer dereference on certain
 command aborts
Message-ID: <20241204185335.7514166d@foxbook>
In-Reply-To: <20241203205249.513f1153@foxbook>
References: <20241203205123.05b32413@foxbook>
	<20241203205249.513f1153@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I confirmed that the bug is real and behaves exactly as expected, using
a USB microcontroller programmed to NAK the status stage of SET_ADDRESS
requests forever and to reconnect if the host gives up enumerating it.

Command timeout was reduced to 500ms to sooner reach the segment's end
and some relevant debug info was added, hopefully self-explanatory:

[  +0,378926] usb 10-1: new full-speed USB device number 109 using xhci_hcd
[  +0,501006] xhci_hcd 0000:03:00.0: cur_cmd 0000000000000000 enq ffff88814671bff0 deq ffff88814671b000
[  +0,000001] xhci_hcd 0000:03:00.0: Timeout while waiting for setup device command
[  +0,000005] xhci_hcd 0000:03:00.0: !!! avoiding dereferencing a NULL pointer !!!
[  +0,712001] xhci_hcd 0000:03:00.0: cur_cmd 0000000000000000 enq ffff88814671b010 deq ffff88814671b010
[  +0,000001] xhci_hcd 0000:03:00.0: Timeout while waiting for setup device command
[  +0,207981] usb 10-1: device not accepting address 109, error -62

The driver and host controller continue working normally after one hour
of testing and several avoided crashes.

The only thing I haven't tried is actually crashing the kernel, but
considering what's inside xhci_mod_cmd_timer() I think it's obvious
that this is exactly what would happen next without this patch.

Regards,
Michal

