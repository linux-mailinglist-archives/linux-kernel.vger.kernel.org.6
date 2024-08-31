Return-Path: <linux-kernel+bounces-309684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD3966F30
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C6FB21B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758113635D;
	Sat, 31 Aug 2024 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW7zApjy"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299808528F;
	Sat, 31 Aug 2024 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077499; cv=none; b=M2XKkwIRxwAPKBvcv9DL3Rj8nNi5E5NYvIK2vRB/GDOIK/PYZgYMWZsb8P8SG6+i2JjlMV/ussDCrvs+QL9IZStunTKKO+CX66Doa9RlZ1UH9hS+rXgPTB1xThqUvjMKoiHzJ8wImquMBs0FqJWPfOJKaRip10n7SuzYjnwyllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077499; c=relaxed/simple;
	bh=5cJOP/pm0inEcVN8TmugnTWworhyXeDseqeVL5SUMKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKeQ7+ffabZGOMGqFI8lF5/qkH5XHqBtOtn3/fNTTqJHdbSVTdKph7tMUw+0oLAvcwT+V0t4NpTDwS+tyvQpDJsbSbX9RdJx275xy/trBAZQsYCKb68kqnZK8ydK0Krirlcn+xrM3GmXznIfRRzzzdnEV2PxYbjJvjQdjH7HaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW7zApjy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso1798131a12.1;
        Fri, 30 Aug 2024 21:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725077497; x=1725682297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLXEldDkMokuiHCr3eLGh09tB9NkALUAfqLTAJVc4tI=;
        b=eW7zApjyZZWvRUjBkZqn4hGnk8gS7Qf//BQii6P+VRVy96bfOUrl6cLleIgLEGOsgr
         VDKRZhIJEW9+hB2ZXh2s/bfmOQMIf1FlwMFrSSOWXju4nnf4Ak2u2FqBfkpJMUrDQNLK
         CVLc5So/nbRj+/pUWMhHRsDch5YuGyar1oEsDaV2z1bGx4uBwRIILRLo5bvuzyyiL8wy
         GDq+/Pw2L/e3/tkY+EcLsd5kEaStopO/JLe/Hm+g0UU9Pw59fzgjLWdmdaD+T3mRY6EV
         pVxOt674bW0rUOJ6Munqp7xMKauPOMsMhKS5xiTos/Sdmgy/CiDcBnZUjFKwS7vbqNpI
         ipeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725077497; x=1725682297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLXEldDkMokuiHCr3eLGh09tB9NkALUAfqLTAJVc4tI=;
        b=dm437gpyjc7eyGNTWx/CLFNzt2tkbc4H3rHTzEVDFS2qUbpOs4y/hNM5gmsYdnheeE
         XBo8p45ysrvthqWYTGkSEcDs0zYGzolbkOJf2SG4aqRAS+ECnPKR140d5nFX28aWSdQl
         RZUffDOO3FkR+touj78ef8jMjT7y+5YPjL3lx2AZciwBReOSGlvs1LkWhDsjvyO1WbqX
         ycrVjrBqxCsRkZy+ISPUFe1QPQ1RX9+cw236qBLcWz5izvmWBlwpAbQgMpaCD8mJ7VeP
         d4A6dLc4S3QSNf6VrGIAF19CmM33WPBm8hjI94tv3UNPz2hs/zWHfB2cGFQeKghLqVM6
         p1mw==
X-Forwarded-Encrypted: i=1; AJvYcCUBoEFV9ABHKwk7VYLyCzX6VHKGHSACjXOCVFvQFDU0POGEmWJk3aqLOfs6ifK7gks2W+0kKuHkaFM=@vger.kernel.org, AJvYcCWgeMUHb2Fi5n0+R0BbBINcqADUp3GR1qZAzRuytNvMJYKqHl2LimYxFZdSKuCIr+Zt1A9bu5uiJvAnizck@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGPh+Lp7Lw0f+1tBRiDS3T5gHY9aPa7Itzz5pIGaC/k6nYbk8
	ajAg8PFNc4KJj7Qv5BaEWVnjsFGsN9tl+gLc+jDyB9IPCefxzEym
X-Google-Smtp-Source: AGHT+IFXblbmu4Q/a9DLI+JTtBfP5/DA9RPdB6hm8BDbTWlIj+AL43G8h2/gPshKHcd+PA1gFebauQ==
X-Received: by 2002:a05:6a20:2d27:b0:1c6:fb69:b44c with SMTP id adf61e73a8af0-1cce10101e0mr9129713637.12.1725077496896;
        Fri, 30 Aug 2024 21:11:36 -0700 (PDT)
Received: from [192.168.255.10] (23.105.223.42.16clouds.com. [23.105.223.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d9716sm3594406b3a.174.2024.08.30.21.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 21:11:36 -0700 (PDT)
Message-ID: <0a434542-b207-4bb6-886e-74eff6cc9f39@gmail.com>
Date: Sat, 31 Aug 2024 12:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240831034924.3729507-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240831034924.3729507-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/31/24 11:48 AM, Dongliang Mu wrote:
> +目的
> +=======
> +

there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'

Thanks
 

