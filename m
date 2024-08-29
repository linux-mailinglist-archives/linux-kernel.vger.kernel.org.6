Return-Path: <linux-kernel+bounces-306264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC8963C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2481C22199
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00416B753;
	Thu, 29 Aug 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi7qM7bD"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0F4C70
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915313; cv=none; b=PrteStXYQAMX+abuVE27JoJa2++Dae7jwq1QEVyDkr1QU1aOptLQm0bPxHrEH15EEN0YK2jsxmiaENhRr04xbUlPEIfqd0I2jzc8Uurm3Z5WJsqFIsKNeCQX4a1j+S006KWUw3YQ2hxmLQtX+Sn2+CvVXBnMnIq884HV60j8nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915313; c=relaxed/simple;
	bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGRoaPiE9awtG5/9ba2xTI6dfH4KxSX+9YlvUKszSPy2xESPc6ENPKy5L94Aygg+qp/AErQrPgvQuNoAlXW8s9C4oL88roMg2eakSgDfpUB4gpUp1uuHNZRFeh5TczDds2NhhLwA6/yNv6ndh9iFFPkpraKmtKE7qkb+tIRod9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi7qM7bD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6bada443ffeso2599627b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724915311; x=1725520111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
        b=Oi7qM7bDWBcThvLTy75nlir7tps2Hoyx0RxpTjcF5+UIeX/oIPAZT40vEzkbLIRrHY
         0SwDZdfS1oCuQQio412iIVkDD+kk2Oy2tTWB7FcAlvzOkhynu3ly8zGl/9vVqJRSGT1e
         58Cebt0451lZTMb2V1Lidqi1IhAosA/AIVXFxjTA7o3tvrzb02Sco8z1XXy3LGyb00mF
         /oZLWvHkgQQs/MR2s2ZGbfVzQ1MOc/fb8G3kDr7oAPPuG64SFwAVZqxcyJlCFcLN4Fbf
         pUSdVhTDG4jpOughXiNflx0Q5faNwsV3Rid3WZZikvSeFESlxp4nwbfiQ9u+TpxxZgn5
         HTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915311; x=1725520111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
        b=j65ltay7CXcw4ZSF1cUd07mxLJk2vuIi4NojZyKs0cW8y7i0Ny3xSO25rhAABKcMb/
         7vttssm3qAJQfk6PPekbhC5gohLI0EC9SuinajrBeCTAla1bVUspw5Z1M66PPRpHqQ0J
         sXsB6Nge8uTdgrhQG+cVuJLPD6PfFC6zqP1aQer7h0dwX4Rrt0NJfEG6sD0XoxVlN/35
         YQ0ayOm+5EICgOnazPPVJvpHg5e1v/iMHeOpkebPnRPJPFm9Y5+I/g7QULYrEn/fes7E
         bBFrhR9eeLusITxvnHKKoghIMwVH1LV1Exhvwa5vxaIMr6z169AK8PyNxZJGdcMdiq+A
         bfzw==
X-Forwarded-Encrypted: i=1; AJvYcCWoCNtdwMKp1TAVGKLRxxRo23yX4UFNqYIDq3JhRL29+UdoL+n1TqWzMlaY56KZLOQJocOeloWvVgiXteI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJAw6GYi8g/7Bs31HBsCdRosXWVbpumRrJHhmyCHa9UDC+mnm
	NS6NUvZlI1is6lvgdjfYPpPA8GK1xJIebanaTJ+SA0xSg0UXdtarlUM/vfwgMJp8mgGh+mSnsnc
	1tig6dcULEjac8+oyiMnKCHffFYU=
X-Google-Smtp-Source: AGHT+IHBG54kcyJNao2S8e3RZf5s1k+UvHDbQfTQZBYaZtFW8uvd8xnYVaG4KN2Krr/p0slYw316fyXauQdT/GHO33s=
X-Received: by 2002:a05:690c:d83:b0:640:aec2:101c with SMTP id
 00721157ae682-6d2ed2992b6mr3916147b3.2.1724915310875; Thu, 29 Aug 2024
 00:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
In-Reply-To: <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:08:18 +0200
Message-ID: <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I did a git reset to 2b989ab9bc89b29dd4b5509408b8fa42337eda56
Build and tested the kernel.

This seems to be a good commit.

So, the first bad commit on my side seems to be
f90584f4beb84211c4d21b319cc13f391fe9f3c2

