Return-Path: <linux-kernel+bounces-422157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036149D9546
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91560165A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342619CC32;
	Tue, 26 Nov 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY9yMLs4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A4170A13
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616134; cv=none; b=CBnQK8h1s0bosVdFEDhqdM5HiKOp6Fzzqvn7YJ+uD/jlogwoJsdw5g8i/hVXyFMs/ajcyvw29V3mgDY3DYnphA3qxa48R7GQ0g1k5alzAVWDmVI/RU0a4vDMqBR7xcx3qgpOOzschx1sOMagLJPWkoOkjDS/W6jUlAB1k0HB+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616134; c=relaxed/simple;
	bh=YnwFrioJuWXkitIwNjlEjn9YMCR+Fc+k1bOVT8WkKt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l7FJ1IVKbAGW83GRTE9Qh5GHA/WrNgpjCzGB1eI9bvnOG4YefIcT05Cr9enD8n6meVHY5ScwkntV8me4s4KoEEuX3sfHS+08mL4cipr32S0AxINLGZFZDck6oZ4hiLEqrghSKVi5sqUoHxkKbY/vW0teaA604HF0IslzDWtcUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY9yMLs4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a044dce2so20917955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732616131; x=1733220931; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMHlNehhUeJtZXiuS3qHdRgWnpyVBbD3di8vAnUvhDQ=;
        b=NY9yMLs4HSNOamt4FPmU8Qhv+C5KMnRWIskZjGi+O0K5Lpvbekx0OwQHL20EVEYwC9
         f/jtY/GsNbJHTh6BrKjye/gImVc5j70dxIP0pKSpllp9sftIo/tSmmer5hIjqAFFdzcu
         4X69tyubIBH8BmoN/w6pSWHKuA6DsCtikx/xf3sGwgspVPjZZwNbSKHWGrnP/wwNuU2i
         Ywr8Q/D7+kvX7wpoivjmW+b8cv2ejy+yKVRVeie5gvqhPx7+EQ/T7NUkk8JDSYptt+p/
         Kd3JcEOnx8W4IgnVU/hv4QXC3IPQZdJFV2gRdbZzqE7xdWwTlAHr1gWeYt+8M8biFJpc
         7G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616131; x=1733220931;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMHlNehhUeJtZXiuS3qHdRgWnpyVBbD3di8vAnUvhDQ=;
        b=DhdBPWTojpeOKawvw7zknpy+jRf7EXxOCzlLOwEG+2qjJTX1U/wANGx827CK4248CW
         gYbzBCl0h1R44WdgBh/0j2siQCYP4tDpC86X1gb6pYLsht5em2aQXuGi4O9SND8lHdIP
         XMF4lxIVZZIa30XQDl4gj8llD7uAFe56D0OCrhTXk/s4naWXOQrTtdqFZ9qcIfkI13YF
         hMH2dmGV8RZL1l83QLUpREcuLjGL+32luSF4AcMI1IrxCI58xw8z99xATWVDXkRi0j0/
         UEsqH860UeZcQG0Xc3eld6J8bCMVIqKgzC0lqRMNI7Wgnhc8i2yqXFbtrn8cBn++d/3U
         ry8A==
X-Forwarded-Encrypted: i=1; AJvYcCU13YBhlnEMuWApImZ2ZORrqEylpiBegr/xRiLX0T9Kjw3YbMnRH5EFu5YpVcRUJRxJkMjXWsTDe7SiIBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJks9q3anleN+sEJjruuUbI/URnBzjoF9HZo/nmZNL9/lQN4v
	K0UX0lEsxQK7ba4A1kt67FkjMTOEMrwCUpPzubZlw7kzciyebLLA
X-Gm-Gg: ASbGnctIRdIUa+TXxs022CfJttaZNiq2wDILTQ48lkCSn0blvjNmfCDebrjzlA06AJz
	tHxkahkfZKr41X2w34h/Sm/aXie/z6SmD1p8Pg4wNMUeRglL6VBbe9dPlXEoXwoEGxcVpGZkjsr
	xzA4uR/1BXoZ2aq9xqp6LJs2te3oHvhMpvHlSwO7Xl4sleRSMOy7+2kNvtN3a8TB5dtjO8LhJMU
	aoWeZys+lXMW9lolCahpkwVn8V8fjxK/nWt6WbPNlgcEfMot8ihXqMPahgwkD5b0OXA4VLIakrR
	MVGQEYT4fDUYhGntvj1n
X-Google-Smtp-Source: AGHT+IGSUVR4ktjx520waynJHg6uz+q+sQ70n8ebOF0pRuJy89VrdCGC9kyQeWZfvcRuqeeAHVawjA==
X-Received: by 2002:a05:600c:4f06:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-433ce426a01mr176891285e9.17.1732616130901;
        Tue, 26 Nov 2024 02:15:30 -0800 (PST)
Received: from tom-desktop (net-188-217-53-234.cust.vodafonedsl.it. [188.217.53.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a0876a41sm56191495e9.11.2024.11.26.02.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:15:30 -0800 (PST)
Date: Tue, 26 Nov 2024 11:15:28 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieram Bingham <kieran.bingham+renesas@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: hints around rcar_lvds.c :)
Message-ID: <Z0WfwMJVCQOEZM3c@tom-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Laurent, All,

Sorry for bothering.
Looking for some feedback :)

I have a similar rcar_lvds.c IP's to handle but in my case:
I have lvds0 and lvds1 that are sharing some common regs (lvds_cmn).

 ----------------------
|    -------------     |
|   |lvds_cmn_regs|    |
|    -------------     |
|                      |
|    -----------       |
|   | lvds0_regs |     |-----> ch0
|    ------------      |
|                      |
|    -----------       |
|   | lvds1_regs |     |-----> ch1
|    ------------      |
 ----------------------


So I'm checking 2 drm dts/driver architecture:

1st architecture:
 - Using a single lvds driver to handle both lvds0 and lvds1.

		 ----------------------
		|                      |
		|                      |
		|                      |
du_lvds0 ------>|                      |----> ch0_lvds
		|      lvds_bridge     |
		|                      |
		|                      |
du_lvds1 ------>|                      |----> ch1_lvds
		|                      |
		 ----------------------


Issue:

Problem here is the 1 single link 2ch mode.
lvds0 and lvds1 can drive 2 display with 2 differents fb (fb0 and fb1).

Having a single drm_bridge to drive both channel give me the following issue:

In single link 2ch mode when for the first time the du encoder drm_attach()
the lvds bridge to the encoder(du) all goes fine and fb0 is created correctly.

Then again the du encoder is trying again to drm_attach() the lvds bridge
but this return -EBUSY obviously because is already attached.

Then I think this is not the way to follow because I need 2 drm_bridges
from the same drm drive, and I think this is not correct.
----------

2nd architecture:
 - Follow rcar_lvds.c way using 2 nodes for lvds0 and lvds1:

		 ------------
du_lvds0 -----> |lvds0_bridge|----> ch0_lvds
		 ------------

		 ------------
du_lvds1 -----> |lvds1_bridge|----> ch1_lvds
		 ------------

Issue:
I thinks this is an optimal approach but in my case here
the problem is that lvds0 and lvds1 share a set of common registers
some common clocks and common reset:

My plan is to manipulate those common regs (lvds_cmn) using
compatible = "simple-mfd", "syscon"; as follow:

lvds_cmn: lvds-cmn {
	compatible = "simple-mfd", "syscon";
	reg = <common_regs>;

	lvds0: lvds0-encoder {

		ports {
			#address-cells = <1>;
			#size-cells = <0>;
			clocks = <&common_clk>, <&dotclok0>, <&phyclock0>;
			resets = <&common_rst>;

			port@0 {
				reg = <0>;
				lvds0_in: endpoint {
					remote-endpoint = <&du_out_lvds0>;
				};
			};

			port@1 {
				reg = <1>;
				lvds_ch0: endpoint {
				};
			};
		};
	};

	lvds1: lvds1-encoder {

		ports {
			#address-cells = <1>;
			#size-cells = <0>;
			clocks = <&common_clk>, <&dotclok1>, <&phyclock1>;
                        resets = <&common_rst>;

			port@0 {
				reg = <0>;
				lvds1_in: endpoint {
					remote-endpoint = <&du_out_lvds1>;
				};
			};

			port@1 {
				reg = <1>;
				lvds_ch1: endpoint {
				};
			};
		};
	};
};
----------

I'm asking to find the best way to represent those IP's.
What do you think?
Any hints/tips would be nice.
Thanks in advance.

Thanks & Regards,
Tommaso

