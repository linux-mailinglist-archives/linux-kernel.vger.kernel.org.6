Return-Path: <linux-kernel+bounces-288109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE2953578
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4159B1C23CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F01A01CB;
	Thu, 15 Aug 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cldTCEjk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DC3214;
	Thu, 15 Aug 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732692; cv=none; b=StQJYvnaG41K92G6z2ftGgLh0Jzz/K6vYwZYyZVHdYKO8HwwnSIucxSVl/Rv95mPGRYvltoX/YxKaH86EbD9SrNQvZW0o1A87V4Sm7NIiPrgiABzozrDs24xC2aEgEL8sE06BK84BEEuLszg5vTOQB4o3yqVSEsvZTzcW0X26Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732692; c=relaxed/simple;
	bh=9eR2eaK14h0jFdZYscJcZ9NNiF9V1Ls5CoWnxENQvp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAuf690NLq5Qwy+IX+syGdIOv1keqFxPy0RP8BAvITBxCP0MoaVcK/J+c7IYKoqebltWT9BWopk2xs6U1I8QIGSAG0IZmN5urobfbA77efNgxYK2/JJ5KkQ3neP8oZ4XpEsKXJxYfKYntoNDKtqyq++kYdp3DZ53MVdMJgPOv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cldTCEjk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530e2548dfdso1082656e87.1;
        Thu, 15 Aug 2024 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723732688; x=1724337488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpSFVkFZ+ieMC7Edi47GLFH3X8aPb2mRtfeJvBEpOWQ=;
        b=cldTCEjkPWv1fCZR0iY0M3M4/5F9F1HMYo6W/UHwoX4o/f5NLquSXxjXGyYliOkrCu
         nFpy4mM62p5FIIjzfW/WdYelnJQvuOUqPZG+Ta+LOBwEq4BC9TmmyDvPfQ9Y2Ut3lvl/
         K5QE/dTtgcLFWLQVmpOV/lFO7mdb/iYWe64496x+hsNIOWDaBREeVf2HdnYA0Vl+J7sA
         kzi1JHppn3zpG8zKNXC/FZ1ghYhWEIkgpXf3u+IIfguUIC9QcQkytPZf+Nby+SF16K49
         F/Y1TvFPGw16u1x8Gvux6Kx/XZUoULjZqdwPUi7QPnN/VuhwtZgi6X88h3PIB/0k9LGR
         m1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723732688; x=1724337488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpSFVkFZ+ieMC7Edi47GLFH3X8aPb2mRtfeJvBEpOWQ=;
        b=jmBe2nm3Op1poOv2Il5AP9Fi7N95gySajf1k+dFmXeghbRP0ykKYjrZFwSFQ5gLlB9
         3AgdKMKaPrt3n7sCVSWHm8L8pq9WY8cDihhcVOnOCrcoMdl6cJ5yN0l49kOV3zEmvb3t
         6u3Pn+aMipXAfvOb9SGtKh9fjr6xrYrQpT964h7jVpf03drs2RYZGmulgOuKyODgkVHi
         UEhDAkC4Qhot11h6OJ/U3g8lEIdxUeDd70kA1FGo/6E54BDxzU9VR2rop5rOz72HpENA
         r+vZF9FgHR/XP11Unh8bY5cosWZWR9mrQwv3GB05JOzaPz9z7ZRnGETl1vMKn1NkdjSE
         qHYg==
X-Forwarded-Encrypted: i=1; AJvYcCU1sCc87lNRS/8g74r9kFhS7cu5PrMcWGfk7rqRx7RaMs1yWtMJIWLVScrHToArvjUm6cD6+vGClA3DKTnhxFelKAEcj4YqV9ttPpJh0jrHYAt027iUxNBfWis+fg0nm7MSz2mMrr+QWw==
X-Gm-Message-State: AOJu0YyKR2aUvwx/ZxgT7IuJUi4+2jO+jguH+dFE/ki2IZtBD7RYZLqj
	OXzGJc+u/jiqaTEHDvFNzMzp1cZdskgdoRJbwFrvLFOJkeVGcIul
X-Google-Smtp-Source: AGHT+IEkwol/TJD1HBGQZksDLREN0Wsc7UJAVMs7ix8fFZCbVmUUBtgQjbld43xO/ooRsjLUH4i4fw==
X-Received: by 2002:a05:6512:2208:b0:52e:7444:162e with SMTP id 2adb3069b0e04-532edbbf094mr4442659e87.55.1723732687917;
        Thu, 15 Aug 2024 07:38:07 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471b4sm110659566b.164.2024.08.15.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:38:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:38:05 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <Zr4Sze8ea3q4d+Xk@standask-GA-A55M-S2HP>
References: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>
 <20240815140046.GA1603296-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815140046.GA1603296-robh@kernel.org>

Hi Rob,

[skip]

> > ---
> > Depends on:
> >   - eFuse YAML conversion: https://lore.kernel.org/lkml/9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
> >   - RTC YAML conversion: https://lore.kernel.org/lkml/ZrBzmQI0IAL7LI3e@standask-GA-A55M-S2HP/
> 
> These either have to be sent as 1 series for 1 maintainer to apply (Lee) 
> or you'll have to wait a cycle for the dependencies.

I've had this patch sitting on my harddrive for over a month now.
Both of the dependencies have been sitting on the mailing lists
pretty much unchanged for about a month as well...
Also, there are technically more dependencies, but they're in linux-next
already, so I didn't include them here.

Just wanted to get this out to get some feedback (and hope that it would
move the dependencies along).

[skip]
 
> The preference is one complete example here and drop any partial 
> examples of the child nodes in the child node schemas.

I can add a more complete example here, sure.
But I don't understand the point of removing the examples in child node
bindings. Seems to me like all that would do is provide less documentation.

Cheers,
Stanislav

