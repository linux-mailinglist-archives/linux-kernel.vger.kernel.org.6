Return-Path: <linux-kernel+bounces-518763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD4A39429
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C273B93C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3011F3B93;
	Tue, 18 Feb 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pj/8DyF6"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930A1F30DE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864998; cv=none; b=CTb1ZCVnvI8TO7Y5m5tqt5c/QzxDIVY04+jLz7iULgL8pIBhqVltHaI0nlEo7VG5aallSlXEgrmfsA9YS3P2QgPTQhejy/6mmlu66YSe1Y7+p/v+2/Gozl5q2aqHl76re9K1d6S3VLC7peK90yztVxp3bj7aj7ZFU4H6wrSSYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864998; c=relaxed/simple;
	bh=dXkNKFL2t3D7LbTgced3sRUwEug5DyboKy/pcSKnSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOVkGHunFG7iJ2hhcZXBPxdfuTHiBVgqMl9kRULfNhr/1piRL+3G3g7WbLXFPpAUUh5ZfACXaCAjBdAZAjwEUYU9PNoYO7x+vmeKm7VC/nI7rGA098nbA9C+C6E8gu4BKiopsS7a+Eku8oFRH8sq/ZV4mg9HpAQThMsaDn37RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pj/8DyF6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so4994237a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739864995; x=1740469795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcxGUK4L7pik8UVdKola7OdfV2rqKCIeW+xAgR3m6ZY=;
        b=pj/8DyF66hNTljnaFr97VcCR05PI8C8DcC1UgGHlTPk1LjSYoSwDx4iz+Eez6TJVBB
         6MBG/1hrA934TQCbIbxHeLPwBzoORvVWvHpHgjaI1GQcMDjuAmxt83oFxftgiwHcRykh
         YHPUN6lD4qmMXe9gLXzItqlvbvjk5CAT40X3AZwTAoB4dXsaz/ksJQV0w0wOafoqiuK6
         01GONh2ayM9e82bN4b0kM9tiw2F7L8Hr40dMNDLgJETdXkm29mKf30AvlGgdi0Rc/cFQ
         0whsVNfyEK/IMSml01bFJ+uuL1Fzzd+uW/t8uFLKvFUb4PRHhVfluRif3dEgKbyCxh8a
         MBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864995; x=1740469795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcxGUK4L7pik8UVdKola7OdfV2rqKCIeW+xAgR3m6ZY=;
        b=Sy2k1IuWkFZOL1C7060wDn+VX6kkhZjsayK/Gnba6SodJc8FpDztbTJ8lWMIK+NoT6
         l6lmzr9vVzfLeBCyjdHjedHV4AsEqcqk43ftw1Y1XrFnQnqcDBEvUfTwGyX1t20LZCRt
         506ki/xVj6Q1fiAaqk1eKEYymS6LgyD4aQEnvqu71QTp/4hQDVsOL0rlyxE+Bw8dUlFB
         Iv1WqEFPG3h89Ifu51N200Rsn0knc/m8th74v65w6+/cSULfoFmo8BGbREr0xNTi7xz5
         KTzTUCI9nfrsw9I8qQf80VeBVsyVViLgYbyfdGksSdPj1k41Asz9XEfZFQp9/epA+MOq
         aF1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXDvLTAYQKNx8TtrAE8u532zor1vjlnRl4FgCxYoJqYztnLssU8zFF6VDCp25Yibu7pfPGYPV20eKaEXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywop2naUTgZxINoG9Ea4bTBBmbC7m0QdIM40i4Rx/wtCX5qxe+k
	XGLnzXI7CClu+GPCiOSBCee9kfVNvi9+ewdztq8xkPxISNC5P9PwNeYVOpeQ+No=
X-Gm-Gg: ASbGncvU3ngr6kasHyC6ILp9SryL2LrfYwHVBb84zreZpzBcED7a4TNX+XfMANOlNyg
	TSHK584Kdd8fH5gi2nM0WDNzvsf9PFA26x6suAhCNpRhrstLh77FrE0oXp4J9+Yj5UHwANAjffU
	VhVAl21GMBGWW8Qo3XdaJQ5mmUdywnjI6g6LLNFOIgg4uSnaCq+M99ZUVBAyodozAVMrPo84rvm
	+p/3oJOQF0yuQ9YmesEkdBt7KJS4/U+tNsOvgsn1faDdxEAQmbkbaRN1MZam4uT0hoKSH2Sc9Nk
	tSFreLhAA5zIiKtn5Yoa
X-Google-Smtp-Source: AGHT+IHCl0HkEOMoIh22Ur0zFcTAgm0hjIJ8hJ4o2yLbH52sojw2vDpWuSJYkP7wFtU/EPB5YbzdKg==
X-Received: by 2002:a05:6402:268a:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5e036236f4amr13268209a12.27.1739864994722;
        Mon, 17 Feb 2025 23:49:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbb860fc11sm80523866b.124.2025.02.17.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 23:49:54 -0800 (PST)
Date: Tue, 18 Feb 2025 10:49:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: change return type of t1_delay
 function to report errors
Message-ID: <5ee5bdfc-1e5b-4fe5-9794-a22175bd845e@stanley.mountain>
References: <20250218021804.29016-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218021804.29016-1-rodrigo.gobbi.7@gmail.com>

On Mon, Feb 17, 2025 at 11:12:54PM -0300, Rodrigo Gobbi wrote:
> The current code returns "unsigned int" and it doesn't handle errors
> correctly if it happens during ioctl call for t1 delay configuration.
> 
> The ni_usb_t1_delay(), from NI, is the only function returning -1
> at this point. The caller, t1_delay_ioctl(), doesn't check for errors
> and sets board->t1_nano_sec to -1 and returns success.
> The board->t1_nano_sec value is also used in ni_usb_setup_t1_delay()
> besides the ioctl call and a value of -1 is treated as being above 1100ns.
> It may or may not have a noticeable effect, but it's obviously not right
> considering the content of ni_usb_setup_t1_delay().
> 
> Typical delays are in the 200-2000 range, but definitely not more
> than INT_MAX so we can fix this code by changing the return type to int
> and adding a check for errors. While we're at it, lets change the error
> code in ni_usb_t1_delay() from -1 and instead propagate the error from
> ni_usb_write_registers().
> 
> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Changelog:
> v2: merge patchset into one commit; 
>     minor change at return statement;
> 	improve commit msg as suggested by Dan;
> v1: https://lore.kernel.org/linux-staging/20250212024247.176572-1-rodrigo.gobbi.7@gmail.com/

Thank you!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


