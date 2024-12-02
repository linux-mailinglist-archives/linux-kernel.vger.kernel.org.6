Return-Path: <linux-kernel+bounces-427136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA779DFD1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5116A1628C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4501FAC59;
	Mon,  2 Dec 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V4LHsKFd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7E1FA179
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131652; cv=none; b=bQxjrOEGxzrQUFUAUycDSpOgl8Do/wgd95YoUtydjYSXVYbpweohejChwD9tz4k1hkYSre6TgVurA7AGS5GnG4ea1BRkajIJB+VPwDC3BFXbOHv3fIGfykhxBhhsNJIzfEWlHH5Y+uCD6CLzPqLTTXRf4DL66vb0X1p3H2DF52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131652; c=relaxed/simple;
	bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puQxWSKqnRm7S+b3ohPCPasIhfO4Qn4lqURuFbHwP/FBl6mXyG/9eZVFjKPC3q3Pf+DwpQs76TvDhx3AqBml308MjidmQXp80epmI58GQ0pxdGBsK3dZ3O794lm6iLY3fgdICxuHYPvJkzpuKPXxG3543knKiftoK8UXr5yc1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V4LHsKFd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e44654ae3so525184266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1733131649; x=1733736449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
        b=V4LHsKFdNLMpnxNUcoBkFMOwyfjhCM7hGwl8AyYz8JDZPRoYbrgARMB7LfMzajn5Eh
         +uRCoXbPpiWKCAENxRMoPuaQC+mSD4FnrG8DILMUDa5KgIvQ0WomE+AJUBBOIuD9fkIl
         vYutBSN/Vw0ETxrhNuO5crOX0kwONrPwlR2BuN005lpBZIQWmJay7gCVMgiAGbzlzp6d
         agCcbYboSH6oi8a6x8oxiiJPiyhV6dc7m/Vq+MjQIDceFypZv+eOqbglVj5oPKWxLXjI
         Xemc5HylFTVdeQCSNz1OI5xuxRBbTjROQtxiUdzj1bMwtfXMPaqOXS10tL1N30HMeXj/
         Ni+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131649; x=1733736449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
        b=h2j94sF7YmPSKMF5pFyQAhyOu6/Js4f3MK7bQeHX2Bgy+C6lOkAw0fNRiXqRD6T3hQ
         ygdN8z9UoU4ZKyIf6cSaYTN3gKXmtTB/weKfu1Ffan/xfe+krWvjqfn7k7Yn5UaON8Ii
         DPbgJabWYIL6noN8s6WnWaJWC7rxitr64mlsQ0+xHJB0c+J2suJdRjsUbFzeDyGHmuy1
         TglbjJawblHA7/vHjHcmW9n+InlBd05Fg7FOpmIn9FIwB87qXDyz2gO083vA69b/GG86
         5IVkRStQRxBOmWDHfRAtLdkwL4KSuY3xuTarFVzxz1RHs+bIPLa3n2Gst9vZ7IPmYQgh
         8yxA==
X-Forwarded-Encrypted: i=1; AJvYcCVvzJ0/kSaa28t7kblFJLy5T1xMRmLEKzT5gg08nM7vEheD7FFDdRDsIG4m+uF+k+Z4GiNa9LqfEEDVeTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdt1NSwxP14CqrENP+zKuCmBxpbJTa7KpGaDoj6+zmixFK9+SW
	U78tlpw8BoA9ymYk1LyimhnNxppojiq+GFgnhjK0AVnqTFJSNUDf/ZuXsgkrDuw=
X-Gm-Gg: ASbGnctv9KZ1St/PYmOoQKpYHqIrbdQukDhVLLOFKXC44JaJte9Efeliv0rWZgXKS7p
	J3bQ72orEYWqi7P8Bgpmud1JS0mMSgQbcW2aDsnTEhaFpJJsyqD9jRaSgapHJQ5xgS/AdYjD0hS
	EnCSrZiNGSZDaZdn2oQII92O5bEy6uOVFGnE4jGmMtIMbqoiB1v+/8MCbZ4TrElPICO4xtG+YHO
	n7OFwVLuWXUgWjQ/LCo8m/wLL3IT+D1mxGpxVtnCxe3+/40JPrQdRYZ4TM8lb+zfL/9YA==
X-Google-Smtp-Source: AGHT+IHJFEiwo9Lyc15w9Ds/jb9CjQsGIpHj5PkE/zOc5gjY9Jh+95fpF9pzLyoiB9rNK5ro+urwJw==
X-Received: by 2002:a17:906:329b:b0:aa5:241a:dc75 with SMTP id a640c23a62f3a-aa58103b03amr2063507466b.41.1733131647333;
        Mon, 02 Dec 2024 01:27:27 -0800 (PST)
Received: from localhost (89-24-45-172.nat.epc.tmcz.cz. [89.24.45.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df78csm492732866b.67.2024.12.02.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:27:26 -0800 (PST)
Date: Mon, 2 Dec 2024 10:27:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Strohman <andrew@andrewstrohman.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dsa: Make offloading optional on per port basis
Message-ID: <Z019fbECX6R4HHpm@nanopsycho.orion>
References: <20241201074212.2833277-1-andrew@andrewstrohman.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201074212.2833277-1-andrew@andrewstrohman.com>

Sun, Dec 01, 2024 at 08:42:11AM CET, andrew@andrewstrohman.com wrote:
>The author has a couple use cases for this:
>
>1) Creating a sniffer, or ethernet tap, by bridging two or more
>non-offloaded ports to the bridge, and tcpdump'ing the member
>ports. Along the same lines, it would be nice to have the ability
>to temporarily disable offloading to sniff all traffic for debugging.
>
>2) Work around bugs in the hardware switch or use features
>that are only available in software.
>
>DSA drivers can be modified to remove their port_bridge_join()
>dsa_switch_ops member to accomplish this. But, it would be better
>to make it this runtime configurable, and configurable on a per port
>basis.
>
>The key to signaling that a port is not offloading is by
>ensuring dp->bridge == NULL. With this, the VLAN and FDB
>operations that affect hardware (ie port_fdb_add, port_vlan_del, etc)
>will not run. dsa_user_fdb_event() will bail if !dp->bridge.
>dsa_user_port_obj_add() checks dsa_port_offloads_bridge_port(),
>and dsa_user_host_vlan_add() checks !dp->bridge.
>
>By being configurable on a per port basis (as opposed to switch-wide),
>we can have some subset of a switch's ports offloading and others not.
>
>While this approach is generic, and therefore will be available for all
>dsa switches, I have only tested this on a mt7530 switch. It may not be
>possible or feasible to disable offloading on other switches.
>
>A flags member was added to the dsa user port netdev private data structure
>in order to facilitate adding future dsa specific flags more easily.
>IFLA_VLAN_FLAGS was used as an example when implementing the flags member.
>
>Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>

Why is this DSA specific? Plus, you say you want to disable offloading
in general (DSA_FLAG_OFFLOADING_DISABLED), but you check the flag only
when joining bridge. I mean, shouldn't this be rather something exposed
by some common UAPI?

Btw, isn't NETIF_F_HW_L2FW_DOFFLOAD what you are looking for?

