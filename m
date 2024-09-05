Return-Path: <linux-kernel+bounces-316207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B301996CC94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F351C22B61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C852131E38;
	Thu,  5 Sep 2024 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="gE7XxYl3";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="oKSu0/Wc"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098EF9D4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503006; cv=none; b=Q4eNpmF9CHVJESrDvgml2rkpUS6eaKLpToTLJ6rxOgYNcqUbtK2hfu+hr6Rj15BabpGvPdi4bE44v7//8WGpwQcWbvNx4JyKtM/sWdaabjNJIYJUiIc9rKyaonZthRpm6CfthzgO6qetpVKHWa5+DXEXt4u7khYLzIBVfjdq9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503006; c=relaxed/simple;
	bh=lhw3OBQuK7/2O1QLDwTTdW8+9of6164bBZpADs1sncY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSL/lz2PtQGpb8hIk1YoT3iQFFNaGaMDZYqAeo65XCqj66zIg2fRckblqDrJijm4IZ+zaqFnG3kxmmENMQOgplLr74M3pmEzUNdBAYK9MCchqsMj58BHNF7F3n7/Yrg+QDTjmc7qJaafjk0Vavh2oiviRoKXEeH0w99pHmqcYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=gE7XxYl3; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=oKSu0/Wc; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725503005; x=1757039005;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=lhw3OBQuK7/2O1QLDwTTdW8+9of6164bBZpADs1sncY=;
  b=gE7XxYl3Kfj7LOy/Sa+8MTvyE3kCZ3TFhdLmW5zqW0W/T5MYUvGqcfTG
   zC6e8d6lV4NG+ytgegbywMBBSc01mB9P6nNddakDZYsYntWcFrXnI/oj0
   ouGpL1roGkhbe+k/VGNb60YMYwME2jhFX3ZD70dwiUyJJqYj+fv4d2QZX
   5i+7q/yalvANnuKW8ubkXIBeUs//b6NbWG0f88SngY4n33t7iX2McbrVD
   4O2h3oBaVrKNz1aVrdIxqVPj1s9bzLJrnPD3anTpxSJKuaF69hkIiCuWW
   NaCGAGoIjFmASBfojqFDAIfDfMFOaqR+HQc9Vu7G2nr2BDIJG19syivwg
   g==;
X-CSE-ConnectionGUID: 1dhjRRVmQ06mdCDCdus9Eg==
X-CSE-MsgGUID: Q7GtxrSmQQ611dD3tCReUA==
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 19:23:18 -0700
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7d50ac2e42dso204088a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725502997; x=1726107797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYDHcfMjZvkDiDOXakZvxVe+vma0YTXAPDxxJz3Bl3o=;
        b=oKSu0/Wc2OuvYB++yXFEYEMiL1GyiLPQdpUzmmpfxmk+Wx1B3ZW6RCKOHzmiwumUiO
         YZZChimUIjAQ+UU7LAl81frXRpGRptz2rgyjaIUQPE1e5cgU94/5REfa5jEJp5P+cqug
         RX4QxgfUWRh9uLxPGPsFaRncIa3K/1UKs9Bts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502997; x=1726107797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYDHcfMjZvkDiDOXakZvxVe+vma0YTXAPDxxJz3Bl3o=;
        b=c1pqHvN5Bxhz+vdwqg4n4+YWsLWHua455UZUnsLLzl9DGCcUMeqMHUfTunn/h9pUUZ
         VzAgzqqdQr2cAF5/B04wDqT0pbfcuTWW6sdYfAR1XZIqG7NHX1wx+V7ubRl62D/FE/kg
         7xUu9SlPZfkwaCyoYYhYAJnMzOdZFF0PGv9bNn3B6rwLwyYQJIZBPW0pk4mIxzzyNxfj
         NSNvojVRpBVotUsl9AAaP/ylbYU+zzbt1bZvtsrIIeCV5CMx1kYUHHt375sMPcZHWp8U
         RAf4KcQz1Pm7MbmKNj/CIl/5M97zRDcojHnHNtmcwuQi58IxxBnet4QYHQrom34Ks5mW
         //Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWVoDPi7nvACNUa+bwgoM79ICHxj7QYPxcWFFtyWHULoKnO7ouLUGOPxUpr0C+yn32emfl9AQzkAorQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdBwKrkPb5nWf1cLLOpXP2OufA2kshWkFczQkUMyjkMNW9qW5
	S9LOmD+9CIOPNt1X59NwKHbXa+eGU3plmLd4dcK00S3/f92XbXP7oD3tz2YW9fgQzqDlJBVmPD1
	bGXJ3PqKEXnhwpUaJW7XUw3nbI9UxZcleHqky9GEex+NmbFxBHdzOBp/orUpLPzbN/ocjr/F+YF
	5aU1CjeV5MLetSf5U/7rZsoKlz6hi4zAC36y7Y7A==
X-Received: by 2002:a05:6a21:3213:b0:1ce:d9a2:66ed with SMTP id adf61e73a8af0-1ced9a26870mr14829837637.48.1725502997471;
        Wed, 04 Sep 2024 19:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU8EZ271k5Z+ERiwyouSa4tPgCyjiar3qkx+0DIkWhii/uNad7/cCyb/VjsF4omGSKnp7GAtYK9v4CGZR3FAE=
X-Received: by 2002:a05:6a21:3213:b0:1ce:d9a2:66ed with SMTP id
 adf61e73a8af0-1ced9a26870mr14829823637.48.1725502997040; Wed, 04 Sep 2024
 19:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636> <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
 <ZtieQFsSiALVVGld@pc636>
In-Reply-To: <ZtieQFsSiALVVGld@pc636>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 4 Sep 2024 19:23:04 -0700
Message-ID: <CALAgD-7WAY6FwTNGdt0BQ2S99Nr+yJ5XyWhA_L_SsbkKsHBrFw@mail.gmail.com>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
To: Uladzislau Rezki <urezki@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is to set up the reproducing environment:
https://github.com/TomAPU/Linux610BugReort
We tested it, and it can reproduce.

On Wed, Sep 4, 2024 at 10:52=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello!
>
> >
> > Here is the config file:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> >
> Thank you. I was not able to boot my box using your config file. But i
> enabled all needed configs in to run your reproduce so it does not
> complain on below warnings:
>
> <snip>
> urezki@pc638:~$ sudo ./a.out
> the reproducer may not work as expected: USB injection setup failed: fail=
ed to chmod /dev/raw-gadget
> the reproducer may not work as expected: 802154 injection setup failed: n=
etlink_query_family_id failed
> <snip>
>
> sudo modprobe raw_gadget
> sudo modprobe ieee802154
> sudo modprobe ieee802154_socket
> sudo modprobe hci
> sudo modprobe hci_vhci
> sudo modprobe mac802154
> sudo modprobe ieee802154
> sudo modprobe ieee802154_socket
> sudo modprobe mac802154_hwsim
> sudo modprobe adf7242
> sudo modprobe atusb
> sudo modprobe at86rf230
> sudo modprobe fakelb
> sudo modprobe mrf24j40
> sudo modprobe cc2520
>
> and even after that i am not able to get any "WARNING in kvfree_rcu_bulk"=
.
>
> urezki@pc638:~$ uname -a
> Linux pc638 6.11.0-rc2+ #3827 SMP PREEMPT_DYNAMIC Wed Sep  4 19:37:22 CES=
T 2024 x86_64 GNU/Linux
> urezki@pc638:~$
>
> is it easy to reproduce? Am i missing something in my setup?
>
> --
> Uladzislau Rezki



--=20
Yours sincerely,
Xingyu

