Return-Path: <linux-kernel+bounces-232481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B078C91A970
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CACC1F25762
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AD197531;
	Thu, 27 Jun 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWi2bS8q"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D3DDA6;
	Thu, 27 Jun 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499441; cv=none; b=SIoI+8O7CgkXLRDQR5zYOZqmod79bvEH47YTUwT/bI/iEIKQLeX/vQJcnfFdJv4GnfVIL24vKkCNh/6y+LyxgnMdjD4rOsD82EGcZFxcKYZhaR9dLsSOvChOxJruTxLYdn4jr4FHbO0xk8Y/ISysdMhjSOUH73mBFzWKrinTNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499441; c=relaxed/simple;
	bh=2j5ewpA+bl3SsvxcvjWbaW/7z8gPzqWlMwplnkWgOcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tb3fCAYIdBpxGbE+d5Yu1//Ci1Ubb3JNXTGMKZUveUJMdVZhBVtwRiA53j86QcqrUNdT04IJJi1vmqFX1aWgAHxdLA6aXL6HDy+0jhHGP2FOvq3dk+NFQIQxggLdTUevuEVzKzHTJaYN0YUlZMvHc78FznuOuGINUPQ0P8hw5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWi2bS8q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7245453319so335179266b.1;
        Thu, 27 Jun 2024 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719499438; x=1720104238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiRJLr+671KjFbO/fLfuPGF8D0WkstZAuqRnzfAw4gI=;
        b=KWi2bS8qGbuvu8d/uyo3O5ZMR8UO7tQsb02ooX2VNBc3KaQGhCg4ZLRSkwQWMiUBSn
         fVfguVNG/pb3VF+BoCQ7VeGAmrHaz9uJwb6dIKQ6Kn/eY7gtqaHdx8j4EZKREglmDjpU
         jgGIScylwSwKKDt5XFX0iWEUhRehRwXW3m/CwauAMmtNTdfj15diQZP9KtU21XesWt71
         35WuwM1xSyC74PVr7hmxHLTwZYqP7UieO/i/17qMX8xJUb1vY3CuaDdtahGofpwOGENt
         rWc2K3VO3J3nL6RqZ8iP/oqtE6desK6h3wkNYQoUvlaRLjCf7hgxPf9tfcAgtD7hFjVo
         9pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499438; x=1720104238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiRJLr+671KjFbO/fLfuPGF8D0WkstZAuqRnzfAw4gI=;
        b=UtuNGekCIitszsBMef6Fh895SUzmQvCsER382OmV1E6YjUX8FB7OvYCXF2gLHlc2ZF
         HMQsSZfm+/W1ien2OlcQ6pVpTaLQmwPV5/s0E8Mu+usCH7hsVI4Fe1RZiBf5gj1ZarQa
         zMdQogeM8yY/CooLJQQI4d1t3pSKN0beIZqwTEEHuls9/hxmpPwmjM/coKOV377cC8ra
         wCtliisJjq4l85F6AEt3RR2y2LZ/QstQveA21UvBP46Tc0SR4iLERmSOre9NKGfNxMjE
         uGEWnOaIBGmv29C58bCJGtoUzNmBQDlTSK1gEBaCGcb4pJZOlc3is3hwcdpEcW6Eiins
         DuSw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+Tcrw/Zk/7nqwxMDG3mS9kBdafi7P7hzgzyV9XaoWgQGqVW6RRb03iEn/UTdlK63uK9FhIf1f4Yrsa29xJI4ATe6Q1Rgjv0G7tHk5Tii5NELesfOwA0LMZNzpdkEGgqe8zKhJY9B
X-Gm-Message-State: AOJu0Yzg4ToVZBAkMejUaMB0G4Osxl6A195nyV9St40sLPDUkz0ag7pS
	p+PW/lu5rGBnLzLBkGuR+/UsC/dwjkgC0OtqAmQgNn6HQX7YllLyHRhHHg==
X-Google-Smtp-Source: AGHT+IGSl3iX/ymezvptfxHesPJP48fV6oxK4w1BKJtGZDusmoKNjfMGWxkP2qihcYhe8Qaeffj9ag==
X-Received: by 2002:a17:906:f812:b0:a6f:e3e4:e0b6 with SMTP id a640c23a62f3a-a729b9029bemr172150066b.27.1719499437449;
        Thu, 27 Jun 2024 07:43:57 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fe52dsm67177966b.16.2024.06.27.07.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 07:43:57 -0700 (PDT)
Message-ID: <a9c93cd0-e0e9-44d4-a22c-948f5d01754b@gmail.com>
Date: Thu, 27 Jun 2024 16:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>
 <2024062735-railway-stoning-566a@gregkh>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <2024062735-railway-stoning-566a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 16:11, Greg Kroah-Hartman wrote:
> On Sun, Jun 23, 2024 at 12:35:11PM +0200, Javier Carrasco wrote:
>> Use the scoped variant of `device_for_each_child_node()` to
>> automatically handle early exits.
>>
>> This prevents memory leaks if new error paths are introduced,
>> as no explicit refcount decrement via `fwnode_handle_put()` is needed.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> This patch is a follow-up to the recently introduced commit c68942624e25
>> ("usb: typec: ucsi: glink: fix child node release in probe function")
>> to account for a safer approach to iterating over child nodes.
> 
> What branch/tree is this against?  It fails to apply to my usb-testing
> branch at all :(
> 
> Can you rebase and resubmit?
> 
> thanks,
> 
> greg k-h


Hi, for this to apply you need the commit c68942624e25 ("usb: typec:
ucsi: glink: fix child node release in probe function"), which still
uses a non-scoped macro to account for stable kernels. I mentioned it
under the --- separator, but maybe that is not the way to go.

This patch is a follow-up to use the scoped variant and avoid more bugs
when new early exits are added.

I thought the other patch had already been applied, but apparently not
to usb-testing (I used linux-next as basis, the base-commit can be found
below the patch).

Could you please apply the other patch first? If for whatever reason
that is not desired, I could resend both patches as a series to avoid
that one goes unnoticed, but as I said, the first one is already in
linux-next.

Best regards,
Javier Carrasco

