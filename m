Return-Path: <linux-kernel+bounces-362227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42099B266
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732731C20F07
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BEE1494AB;
	Sat, 12 Oct 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hghkMiVs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5614C8E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728723744; cv=none; b=AW3NhzAB6xVmPby1stQxY77FcYZgerfATsMZH3wQk/e+WVXt9/8zrdwhIYLtKjLWr1m97x92gjji8IZ22AlkL2kDs2RyxyQ/ZtuJtdbNRzN8LXXk8X9SviYhXKFC80hD7TQDclq62khnZZwO/kZF+VrkDRFN6GL+5kvnLIVt+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728723744; c=relaxed/simple;
	bh=rZh6vfa9FM/sP0FJ+fphIVYs0b3z9acSZjbQU+/mNbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ii4jxm78NMlh+PjAwfVJ7l3soXZR4V3cj/cRvk6Ld+Y4ZMjvTtGshfatH5XEGT//diHVO8jDRIHQUytYzksfR+JIUbEqHXd2vUT9T41Z4jora3zI2O9R6OK6GvIZzqJnlcnTBi9SVVR9Ko40h6wVK/cbV0EKmmhwQCx6IYjAOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hghkMiVs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9963e47b69so415670766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728723741; x=1729328541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/kcGfRfPlVt/tclzZkb2ivkl8163plsBDXpWRzmtQQ=;
        b=hghkMiVsm2DYnv0rKqi4MmDI5fFapePyZ6HeLdGs3fGUOup7hxLtOrZziETBhbpqxS
         qiBtpZY36oTkp4SoTjcRxeeRKvI0c9/wNDNdjP0vqPnZMk5VcXvI968o6Ky2vP1H0+ih
         VwAe31DnKxmy4qP3WGAdqmLJnLNgDH2Dv65vTf1gTyav2Nfz1HYxcB+r1q0JbU/+a52L
         eQ9iTyvlm0TO4rmzjIGsCj96dcnPhfm8fbD3Gk5u6JIjILbpWyH9m2+nqefKWKc0QTh7
         UFipwQhael+0Jf/H1uv319DLnK/ZcKKuLJtWqDtryfe5264si1S4HqkqrkL4TmuyyGqz
         KWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728723741; x=1729328541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/kcGfRfPlVt/tclzZkb2ivkl8163plsBDXpWRzmtQQ=;
        b=cesqwF0N6eq4N1DW94t78fVYrtdo6iMvuxEK+yTSc/2W2JCCmelcWGStuCzxhbUHt7
         rx+U7J/npmLHRCajQf+BGgGu3PKnsY7nCGLEbC2T7SdgPYNhHzxad8+eQ4+L4jSaUJae
         3+iXDOClGh0bznh1nI6mvpwkzNb5AbzaVBnEJDs25RNcB14J0YtMyWAM2w2h9uhPPiMs
         GA29BaDxxmJFbsPCUtbiSnjVsfnpCkBddvapEx8g+CObACMxmUaXmK2NN224nsTpjg2Z
         RntBNbm+2J7Rx20XO2sQNi8wrbI+ga3XEL0xWv4TBBAxIVYLHW0syGJ5a2v941OmQwPL
         DVDg==
X-Forwarded-Encrypted: i=1; AJvYcCViCfEUq7mxd3qwoHSiaFQZo+W7PpotZnzmIIDSSpSe+VrmzpkbC+oT+8Jxid52a2m+uf4VFhvT7FC8sSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKMuwj/Yv5EqNbYFH+r8z98/lBkfygA+jkpWb0HrVFWMurFss
	CQiDJQdHiZUnzJrM/zCN6x7mFzVQs42r7JtAUa2fzPQyPeGx8b3V
X-Google-Smtp-Source: AGHT+IH0qErR1If6QreOu5RpvGcEJkncxp3wyOu0m/11kXBgN0QvqW+OW8oN5bGN1LFc2JgCGmA98g==
X-Received: by 2002:a17:906:c14c:b0:a99:435c:89f2 with SMTP id a640c23a62f3a-a99b95f5f72mr518372066b.63.1728723740742;
        Sat, 12 Oct 2024 02:02:20 -0700 (PDT)
Received: from [192.168.96.164] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0aasm302481066b.92.2024.10.12.02.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 02:02:20 -0700 (PDT)
Message-ID: <b2ac0a21-989b-4f36-9bb4-923221a77fb1@gmail.com>
Date: Sat, 12 Oct 2024 10:02:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] staging: vt6656: Proposal to delete driver vt6656_stage
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Straube <straube.linux@gmail.com>,
 Sathish Kumar <skumark1902@gmail.com>,
 Florian Ziegler <florian.ziegler@posteo.de>,
 Pritthijit Nath <pritthijit.nath@icloud.com>, Arnd Bergmann <arnd@arndb.de>,
 tdavies@darkphysics.net, m.omerfarukbulut@gmail.com,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>
References: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>
Content-Language: en-US
From: Malcolm Priestley <tvboxspy@gmail.com>
In-Reply-To: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Dear Sirs,
> 
> Forest Bond contributed this driver in 2009.
> 
> The following points let me propose to delete the driver:
> - This driver generates maintenance workload
> - This driver has a maximum 54MBit/s as it supports only 802.11 b/g. Peak throughput is 3MBytes/s.
> - ping times can be 17ms are often above 500ms and worst case 22 seconds.
> 
> I suggest deleting the driver as it no longer meets current expectations.
> 
> Former Maintainer Forest Bond <forest@alittletooquiet.net> is unreachable.
> 
> The staging subsystem needs to focus on drivers that support usable hardware that is available. Newbies can then get the hardware and play around which is fun.
> 
> Please consider that support will remain for years in the longterm kernels.
> 
> Thanks for any response about your thoughts.
> 
> No response will result in a patch for removal in 14 days. 

Hi Philipp

The vt6656_stage USB driver is still widely in use, I still use one on my raspberry pi and usually get me out of trouble when main wireless device fails.

I do not see the connection issues that you describe and generally the driver reforms well,

Any b/g devices devices in the wireless/staging tree when used with or sharing with newer ones will have connection problems due to the considerable interference.

I have not problems with deleting the PCI vt6655_stage driver.

Regards


Malcolm


