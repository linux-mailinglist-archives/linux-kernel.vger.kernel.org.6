Return-Path: <linux-kernel+bounces-364832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AE99D9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5931C215E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295961CBE8B;
	Mon, 14 Oct 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZyN7ZsG"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FF158D79
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947395; cv=none; b=IHX0OGi715w4+KXiR5JsLQcWojJK0Wg5zyIeAVoCsdZk6zO1aTLTKy0QRX4ps/LA4/QOkphuZlegStH3D2VUinJ/7Vu8NYkiRnMwtAjcVuX1eoqDaO0xqSWdTulb2AEQXnbEvIFZxpZAyWs2xLuLBwj0WPogWxUfbyxKWLFuJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947395; c=relaxed/simple;
	bh=2W9U51HFCbv7j87Iuu5EH4EN9DG+WFYTYJDe/09T/Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxWIz/ofAzkG/yi4ezdJcFtqS+9+EpOeZf/CsGhm7F8fNHtu1Crt+KzUQXb0X7OpCfl0ejTQjMwF5isSIVXQxZlaN/RuoNe+3WXLIrG9LJuOThQROwbD3xqA3b835VnEYjnhfOyxztoVEeAy2ZNCv3d6OQfNkBvY6gqwM5Xr7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZyN7ZsG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8354d853f91so183878839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728947392; x=1729552192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpXjF7UCLh0jKlSUonkPW30j+SOb0QTOKoVf80FL/mU=;
        b=fZyN7ZsGn+kSFiAGe8V6veih4bkpkVJCb7krdCaM/1R+C0ELeGaNPXzRC8GcYVMCp2
         PaDviC9nZWOzDegyHjP5+VKbIWMTQDK5cberiN6FTiBynnXqREZRA7nTPfeDwz4OdNab
         xBkRSQCw2qobleShJZt4kDeuZE/Lv68rTNWSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728947392; x=1729552192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpXjF7UCLh0jKlSUonkPW30j+SOb0QTOKoVf80FL/mU=;
        b=iXyJOpHtPuC4f2tZfafrOyMTeptKSl4+T5rzvA/58C+EZnyrQm1eZ3y+JsydxmGNAr
         81ARk9DbszEw9c5l+FcHMel7wgg2e1KfoXVs2wzY9oqS0NoLOevIoXlgTQo4W4eNtPrC
         zOOutMjwbZn7lvL1pjwIhq0a47mLmJuxeVe1lziaSNZW2BQwMvc5nM/UkEjIy7u1Xl6i
         bFZa1NE44IgPJkglU9ydrxu3PBaKYdevMlkU3MMx1ksQLbH7sqNalowL3yIJRHZBzaXe
         Tlgr+CM962x8Xx2Irq8qJA6Oy1sOjtBeQ6sJi9Lvkcafm7cvXR/gTNvTP7t3GEGK/zus
         U42Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuwQdhWwuNCz0FIWoIRIbWWFC/ukgmcXUQDiItyOxyTPTqF3yiU94eSyL+Inru69LYJ6tomqF4Aw4MyYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXULCUkkQnx/MKQuyxHIHuWEuaJjTa2Qs1fcl4SsvImW7RGKcB
	HNiP2zCHoxUCaJvVJ+mciNzNnykkVq85ddczwVAKHqwI2AGBIa0stI7nl7tKxAk=
X-Google-Smtp-Source: AGHT+IFyst77YQycrhwr+AWjoTAU3OPwbRAlI53NQc0Q2J1nk0Q9X9K3CFRSn81FdTsHv6oZeL5JoQ==
X-Received: by 2002:a05:6e02:138a:b0:3a1:a163:ba58 with SMTP id e9e14a558f8ab-3a3b5fcaac6mr100716465ab.26.1728947392619;
        Mon, 14 Oct 2024 16:09:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb3a424sm29943173.101.2024.10.14.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:09:52 -0700 (PDT)
Message-ID: <9e75fba9-08aa-439c-9c26-a4f50a9a8372@linuxfoundation.org>
Date: Mon, 14 Oct 2024 17:09:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs:process:changes: fix version command for btrfs-progs
To: Nihar Chaithanya <niharchaithanya@gmail.com>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241012141425.11852-1-niharchaithanya@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241012141425.11852-1-niharchaithanya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 08:14, Nihar Chaithanya wrote:
> The command given in the changes.rst document to check the version of
> btrfs-progs is:
> -> btrfsck

Just use spaces - remove ->

> which does not output the version, and according to manual page of the
> btrfs-progs the command to check the version of btrfs-progs is:
> -> btrfs --version

Same here

You can simply the change log to say the following:

btrfs is the right command to check btrfs-progs version.
Change the command to check btrfs-progs version in the
changes.rst document

> 
> Add a fix changing the command to check the version of btrfs-progs.

> 
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
>   Documentation/process/changes.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 00f1ed7c59c3..82b5e378eebf 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -46,7 +46,7 @@ jfsutils               1.1.3            fsck.jfs -V
>   reiserfsprogs          3.6.3            reiserfsck -V
>   xfsprogs               2.6.0            xfs_db -V
>   squashfs-tools         4.0              mksquashfs -version
> -btrfs-progs            0.18             btrfsck
> +btrfs-progs            0.18             btrfs --version
>   pcmciautils            004              pccardctl -V
>   quota-tools            3.09             quota -V
>   PPP                    2.4.0            pppd --version

thanks,
-- Shuah

