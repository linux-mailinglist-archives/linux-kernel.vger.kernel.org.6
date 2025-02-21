Return-Path: <linux-kernel+bounces-526810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFBA40399
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69863B1FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713A20B207;
	Fri, 21 Feb 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Wate1kkN"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DC18DB0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181261; cv=none; b=nss650nlcshELUWtWX5qrx8T0NR4NJeGW3x8z4R2bs3syZOAziOZhndXZlUw2QhvujrQkl1v1MxNRnhNdf31uKdCBAlcjroT5S4KKCrXYheSLLfZungw4Yvv33Ar5RxkAfrBId6hY3jU4ASjxEJI2ro4I/eRim9uTx6pwTld32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181261; c=relaxed/simple;
	bh=pwS0rRZAeo4K85b7BRAT0mUN789PYdreea+ymjVv7PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcRb9ETZeQ0/3rrBrNLfemk7Xn2jbntyYMkgwiO2p/wmaiDwPQZIJfrv5fRbElz2jEJfiJ8Cisb1d5+sK3axfIN1eH/Y2ndxqzpBVCjLD9L9JFj+aISH1Yr9qksHXLrv8eoLbMpSQ9FKjYUSiYKSFfwk+mPA8FI3Go5FRH8Wq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Wate1kkN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4721aede532so24900871cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1740181259; x=1740786059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f93o7FAG90qaVAfzA0geJ/uDU/bxaCxWXA35kHGThZA=;
        b=Wate1kkN0JjhDmqJNYzTg4ONZzu4FBUhwnCk4Y2FY3926GdYyQWYFsQz04xIlxdxlY
         EY6BiP3bpz5P78thX3kWa0xqij0elX8MZH3bhADIceM/pIJZNJgC2gp9q3+aM5mujOMg
         Uh8mMvDAumPg9tzsKTnM3T0WDJe+kmz3IxB4+NO3N/HOBBuEg8ojUEysFFWmUNDCBC3P
         WsCHMFSW3AA7p7PDZSARJNlI/OU19JjcBUXPVs/IqbQo3OgggLRGUocFLdIpVNf7cX1P
         zC2TY4uDPfP2g/MwHrKMWeEgisGCKPrubfLujD+kRrHfC8kYs0ZfoSUBew0DoiEtpUU9
         4IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740181259; x=1740786059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f93o7FAG90qaVAfzA0geJ/uDU/bxaCxWXA35kHGThZA=;
        b=HE3Nv6Ps5+eWWh+s67pyMm8FlkT7OugVHvw6Qm227Cv7cr6gzd8h3Yen2K0PVFapV6
         D2nsuDWF7pNcsAfFm7hwA5OJAp6PNEaPzqdQWAznpEu8jtj6XE3n2cE2gRC0sFGz26Mx
         Qe3s/fV6GmkR5mqHflkyZOcdIkFMoWDW2hzLmX3xiYVjXT1YWdbu6etz7XWO553nm9tw
         1Pc6/HA6ixFM0h3zNpVsKDdL7OBqSHFYzmieuhItElYYhCaVrm4NqeuWTWq8hEF94Wyu
         iFpKExWOOUwYPHen0CSQE5Q993bOrad1vHDS/bTFVqET3Z51kDsZ66g7gTKH3HDNfiK5
         bWvA==
X-Forwarded-Encrypted: i=1; AJvYcCXvD0d4t/klh7LVbRedaJ+f6ZpE5pgssSuYLiXNpLWVDY+VBhGpV2kdbwCwAx90f/0hDSJx0x0wuA0VoZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYiNCIWrsk0CC7hTMAch8o4+Ospseqzkj1slfGsgdToqi1ELS
	gc0cIvwY1vcoP6vpLkp0ZL4yfDyJViCl/lAQpefRWqgwycqxc+cD3Yrnv1GvD9o=
X-Gm-Gg: ASbGncu6TnU11uhulGeike8EGgoyDuQ1Cx5hSuSG05qbsri1oxQxwvAswD6tq+qUPMi
	u1NOMeu+q8LGIwVNWOZx5I2xz4mrgby4WDM0NwBFuf2yP65HAlss0ZDQMvomcXmCgqe/Wl81Ch8
	lkQNXOp6A+FFQTW2jMY49VItfTeKDnLm/k/vYvo5Ng1hxeMcA8Apg6aevbfqqPPL6200wBxTSfD
	v+FCAu0EyMq2DDAXPG18U7n3bmF6oP9ZSWi3OVzLXezB43NoQIMtfvcm3pKQ8/xkGul43CaeKcn
	s7eQ9Kl4P9fcKSk+aBDimcTc2FxZViQM3iKbPUvW0+WAzkcspC0izEBM6FFqlFq5cg==
X-Google-Smtp-Source: AGHT+IF09Y2l1WyaNQYoNtRessBI+9y7Evefa+3aJzpT7BdL6xOrBu5WGp0qzs26a1CPzjXqQ1pKmw==
X-Received: by 2002:a05:622a:44f:b0:472:13e8:47a0 with SMTP id d75a77b69052e-4722473dd50mr66754041cf.21.1740181258850;
        Fri, 21 Feb 2025 15:40:58 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f506f819sm58485811cf.62.2025.02.21.15.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:40:58 -0800 (PST)
Message-ID: <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
Date: Fri, 21 Feb 2025 17:40:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
To: Haylen Chu <heylenay@4d2.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-4-heylenay@4d2.org>
 <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup> <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup> <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <Z7BTVu10EKHMqOnJ@ketchup>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a general proposal on how to represent this, but I'd
like to know whether it makes sense.  It might be what Krzysztof
is suggesting, but in any case, I hope this representation would
work, because it could simplify the code, and compartmentalizes
things.

Part of what motivates this is that I've been looking at the
downstream reset code this week.  It contains a large number of
register offset definitions identical to what's used for the
clock driver.  The reset driver uses exactly the same registers
as the clock driver does.  Downstream they are separate drivers,
but the clock driver exports a shared spinlock for both drivers
to use.

These really need to be incorporated into the same driver for
upstream.

The clock code defines four distinct "units" (a term I'll use
from here on; there might be a better name):
   MPMU  Main Power Management Unit
   APMU  Application Power Management Unit
   APBC  APB Clock
   APBS  APB Spare

The reset code defines some of those, but doesn't use APBS.
It also defines three more:
   APBC2 Another APB Clock
   RCPU  Real-time CPU?
   RCPU2 Another Real-time CPU

Each of these "units" has a distinct I/O memory region that
contains registers that manage the clocks and reset signals.

I suggest a single "k1-clocks" device be created, which has
access to all of the I/O address ranges.  And then within
the DT node for that device there is a sub-node for the
clocks, and another sub-node for the resets.  Each of these
uses 2 cells for addressing.  The first indicates which
"unit" contains the clock or reset registers, and the
second indicates the clock or reset line implemented by
that unit.

I might not have this exactly right, but below I show some
DTS code that I hope demonstrates what I mean.

Could this approach, or something close, work?

					-Alex

/* SpacemiT clock/reset unit numbers */
#define SPACEMIT_CRST_RCPU      0
#define SPACEMIT_CRST_RCPU2     1
#define SPACEMIT_CRST_APBC      2
         /* . . . */
#define SPACEMIT_CRST_APBC2     6

/* SpacemiT RCPU unit reset IDs */
#define SPACEMIT_RCPU_HDMIAUDIO 0
#define SPACEMIT_RCPU_CAN       1
         /* . . . */
#define SPACEMIT_RCPU_UART1     6

/* SpacemiT RCPU2 unit reset IDs */
#define SPACEMIT_RCPU2_PWM0     0
#define SPACEMIT_RCPU2_PWM1     1
         /* . . . */
#define SPACEMIT_RCPU2_PWM9     9

/* SpacemiT APBC unit reset/clock IDs */
#define SPACEMIT_APBC_UART1     0
#define SPACEMIT_APBC_UART2     1
#define SPACEMIT_APBC_GPIO      2
         /* . . . */
#define SPACEMIT_APBC_TWSI0     27

/* APBC reset/clock IDs */
#define SPACEMIT_APBC_UART1     0
#define SPACEMIT_APBC_UART2     1
#define SPACEMIT_APBC_GPIO      2
/* . . . */

     clocks {
         compatible = "spacemit,k1-clocks";

         reg = <0x0 0xc0880000 0x0 0x2050>,
               <0x0 0xc0888000 0x0 0x30>,
               <0x0 0xd4015000 0x0 0x1000>,
               <0x0 0xd4050000 0x0 0x209c>,
               <0x0 0xd4090000 0x0 0x1000>,
               <0x0 0xd4282800 0x0 0x400>,
               <0x0 0xf0610000 0x0 0x20>;
         reg-names = "rcpu",
                     "rcpu2",
                     "apbc",
                     "mpmu",
                     "apbs",
                     "apmu",
                     "apbc2";

         /*
          * The two reset cells indicate:
          *     unit number (e.g. SPACEMIT_CRST_RCPU)
          *     reset within that unit (e.g. SPACEMIT_RCPU_CAN)
          */
         k1_reset: spacemit-k1-reset {
             #reset-cells = <2>;
         };

         /*
          * The two clock cells indicate:
          *     unit number (e.g. SPACEMIT_CRST_APBC)
          *     clock within that unit (e.g. SPACEMIT_APBC_UART1)
          */
         k1_clock: spacemit-k1-clock {
             #clock-cells = <2>;
         };
         /* . . . */
     };

     /* . . . */

     uart8: serial@d4017700 {
         compatible = "spacemit,k1-uart",
                      "intel,xscale-uart";
         reg = <0x0 0xd4017700 0x0 0x100>;
         interrupts = <50>;
         clocks = <&k1_clock SPACEMIT_CRST_APBC SPACEMIT_APBC_UART8>;
                  <&k1_clock SPACEMIT_CRST_APBC SPACEMIT_APBC_UART8_BUS>;
         clock-names = "core",
                       "bus";
         reg-shift = <2>;
         reg-io-width = <4>;

         resets = <&k1_reset SPACEMIT_CRST_APBC SPACEMIT_APBC_UART8>;

         status = "disabled";
     };


