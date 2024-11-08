Return-Path: <linux-kernel+bounces-401320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08F9C18CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5430128432B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311881D356C;
	Fri,  8 Nov 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gly8UZth"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595F1E0DB8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056941; cv=none; b=Cx8VahnPEuqNP9zsj0ex6WCYlgkne3mjhfhGgO/3ynDbE+sQbWtRpZcOTEsw/h7mdz/1ebxPAFrZN3zfN6Fj51mXAn8cSxNNBDgS3bp2A0p3G+vL/Sz6C96arihKnPOdNM4x5sKUTn2EMWZHbqZOdCtRr3F8A71ckdh8xffkYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056941; c=relaxed/simple;
	bh=laY4jmILB60Wr/uxaLiRZB/pYgNerksyLegXeZz4yUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRFnyiJbnjtgx5PoY+athyWT4BG1S2R6N52nl1YatNCw26HUW/izbiMAwp241CnI52LvV7JysSX+hL2gYdHbfkendaoqcZHVuH6nR5SEYdYT3kK4QcAyzqEQ7zW5gAExqIvIRyFtsSFvjgn7bSFEzb+TsWCDDVy/XeV1OQyEKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gly8UZth; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43169902057so15731075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731056938; x=1731661738; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xb1ICVWGXTFGmatTZgXGllwwlFmHy4GJOLy05oi7CQ=;
        b=gly8UZthrjvE0RdHBWv6/nfZVoopNmV3XQOe7RKQnajzaeWtGpfVgwtcZU8b/lN+ho
         SpxnhwsPp+v3mOsAcoE101qrng9zAZL+RFolqP9B8Bh/d3B6bDqh6uXvkondcpWNZg/I
         gkhy8J5L3EMxqphXGYOSvd72Fb0LtPAXIM3hzNXGV++Scdf/Vodu3iaX4KBNNlOvF6Ma
         h28NW87vNOZZGu60x0mURqshMRepj53xZy0SB/QHznU7PliPywH4jP+9usWHC2M9Y3Bq
         MayC0I+BZ9mgqWj7X9+6jsmikxJoahllti0uUWTUfLKjxweY6EeUPYgp2Mqtp/NWhGrx
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056938; x=1731661738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xb1ICVWGXTFGmatTZgXGllwwlFmHy4GJOLy05oi7CQ=;
        b=DqT0xzVeaQOO/89JOolob/mbXhn2Q3ApJAHamHl+48l0fVFmr68p7KaXo0Y9xR4GRe
         kz///nD5xY1ObUt/5FK41u8sBrbsZFLG++IByHk2PX4xnq89HZW6JXbKujZE6H/A/DJK
         nXd6AaZBNhr4jDNuyjPXw/5Fi02ujSNCXamhB59GrYswsdHhg0QdXm3xiSmAKEcoe0mG
         zbRnOvyXV3NNUOaOeWET7eeejzDHaNL1JVPu0AvkDxHtq2jx7zuUnhoyUOqWfeIOGAhB
         k/5LQM8nbFrweiFeNOyzr6AkZLGgLrlkheka+icr+aVGXuqWHmvh73gUPREwDczMwufS
         e60Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOzoRN2m7O72CZ4y4+fOP3nELPJ4xWhFb50Ro7to5v4YAM4dWGiJfVy1pyr3MrfO0s2/HjJM7X0FeXTVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEHn9p5VNs9fFVOLa8yS73Xjt5A281T+xfKGQbV/t8WEFfm6Z
	0dNU18OCDP2cNKQylFrzlPeFMRiAEe5eA3JLhsIarHPhZwjTR3YdPHnMFHZGDy8rkKVmsBQzkuA
	a
X-Google-Smtp-Source: AGHT+IGc7WSbgcJgemjnmfyYnFD0FFxFhnTDoVt/WUlBEoBVWkIM08bwENgbaktsObOHDzFoXT7w6Q==
X-Received: by 2002:a5d:598b:0:b0:374:c84d:1cfe with SMTP id ffacd0b85a97d-381f182e898mr1747898f8f.21.1731056937952;
        Fri, 08 Nov 2024 01:08:57 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:ecfd:9f8d:62a3:6ba8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04049sm3948176f8f.93.2024.11.08.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:08:57 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Stephen Boyd <sboyd@kernel.org>
Cc: Mike Turquette <mturquette@baylibre.com>,  Chuan Liu
 <chuan.liu@amlogic.com>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
In-Reply-To: <20241108080914.65a7a03a@canb.auug.org.au> (Stephen Rothwell's
	message of "Fri, 8 Nov 2024 08:09:14 +1100")
References: <20241108080914.65a7a03a@canb.auug.org.au>
Date: Fri, 08 Nov 2024 10:08:56 +0100
Message-ID: <1jh68i2itz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 08 Nov 2024 at 08:09, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> In commit
>
>   5e052ef3c400 ("clk: meson: s4: pll: fix frac maximum value for hifi_pll")
>
> Fixes tag
>
>   Fixes: 80344f4c1a1e ("clk: meson: s4: pll: hifi_pll support fractional multiplier")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: eb61a1264990 ("clk: meson: s4: pll: hifi_pll support fractional multiplier")

Indeed, I missed this. Thanks for pointing it out Stephen.

Stephen (Boyd), how do you want to handle this ? The commit will need
amending and it's something you've already pulled unfortunately. I'm
happy to redo amlogic clock update tag, if that's easier for you.

Stephen (Rothwell), I suppose (and hope) you are not checking all those
commit tags manually. Is there something available somewhere I should have
added to my routine checks for this type mistake ? A checkpatch.pl flag
I missed maybe ?

-- 
Jerome

