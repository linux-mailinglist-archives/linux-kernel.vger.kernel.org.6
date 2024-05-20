Return-Path: <linux-kernel+bounces-183752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899458C9D83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2A71C221C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A556448;
	Mon, 20 May 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IhqlqkS6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC718535BF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208755; cv=none; b=P9oMKFqXxdwWTlBIArWOUkYVvfwWXNanx43GTlZWB6LvM+FZKUlrEPm0y7PZICASYseontUUSHixUpbyr5U3LeN731Ivkb9x1DAP8sr6YtwG0lA2z8o0MEhbtNQFiY8r/bIxR6Zcd3Bpb5EeHEBzpDsYT50EzhtXawXBjiWvHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208755; c=relaxed/simple;
	bh=hiqO6nf/twieLGm1SVLytWK3tuB7lTlsoCNchPnguGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dia4DUmy9kp1VX6zpBWvMHJSw+ytPW4QEWO+NdsLIVyTQzOburEJX4Goqng7ubWarLWAm8W0Tsxulr8QAFDqjR/fInFX8kwwPUl3DpIgZCjVmmrNrDkIj9qtJg7/fnnTQYqz+5gcaMYLtjgblfeHY5KoWico3cJ78hFaDM20vD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IhqlqkS6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f30a419500so405865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716208752; x=1716813552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6+9qvcDGnLQuaFAHT2Q0e0l4H4wa+c0ZJfQCfwsSgQ=;
        b=IhqlqkS6QvSIgnh5lQM7ljtxt/tX+NoudSd9uraOVsg7a9XN2OhxBeLW6ou9Xz8ALk
         cbCffwCGaVjXDj7lmxVytFlGHzeQeGBd90ocSudcXcMB2IaSqPT0D8barRFKOdiTOSQm
         TjBz1Hzmj2Wzdhmv9ZXG96RQo4dHROUgvvCpMNhn49An8jUfPJILC+vsMaTj2IePcSbb
         gtftKeTNXMp5ESPlmoL7SVvk1aiURNeSUFJRz/kebczx5puYVWyO5bNPkN0J7nYI/fuK
         BnBXoIklYIicjSGNSX/6NhE/NZjiEBMC3V0G1I1Vnzy0StqHrp+ZYRv8HVD5yl+Wurj6
         zuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208752; x=1716813552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6+9qvcDGnLQuaFAHT2Q0e0l4H4wa+c0ZJfQCfwsSgQ=;
        b=wIXeXVCkURD6WJ6570wKtdnOmZjV1SnpBnS6AiUx/E+7ZtXmlsowDYs5ydu+g3i9G1
         mnN0f+ZZJHcOI+xYK6e6Be5P/Ju8HXoAF5lQSSNNiYY6n4t4MZ7AvkfmkhCqAiOYNnrb
         nowOaLRSyi//YG4CpzSu5WJms0st3OVFUjkMz6bJCmCuAD79V0Wu6w5bf91JCP0Daw1D
         7YQ8+7p8/GmHywGnzMShKYl/MsNcdqy0u2JvHb8XJo7aYu7f9DFIR0SwJU/WEpCadE4p
         5/Li4SjrU4J8EmVPjAsPZvgRa7E+PlHcr7wk5ZnhgpUeVIQhZesHW2unaL5CrpW0oL3p
         f3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXPsFsyQuQUV0MqVdsbwKyF2yy6QloYZxdOIY5HLP2UPafwuCXWHPJ/6teb0glt1LNtDu942QaNzGP1X6mbKfxiXLmUU3OWLPGL6Ikh
X-Gm-Message-State: AOJu0Ywx6o0sXQT+L+Gas32h+PoI71elqMlps4QECPzaYM6QWtaPXjXw
	9YtBmW9xzjd13NhAICWbFJ5kIBJwksvrxJJAhIZAeRFwmUNWELcJPko/z25vGRk=
X-Google-Smtp-Source: AGHT+IFivsbHG0Dck0MMJAGm8ba5y8fLUVV51yB1TyTyn81YB70LrOSYRibqbo5nvALQ6RKSYbGo6Q==
X-Received: by 2002:a17:902:ea0f:b0:1f2:f12e:27f6 with SMTP id d9443c01a7336-1f2f12e3103mr60545005ad.0.1716208752241;
        Mon, 20 May 2024 05:39:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30664fe46sm11260135ad.225.2024.05.20.05.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 05:39:11 -0700 (PDT)
Message-ID: <a9ebbe74-11e3-45b8-8b40-6be78c2d9bbf@kernel.dk>
Date: Mon, 20 May 2024 06:39:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] signalfd: drop an obsolete comment
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
References: <20240520090819.76342-1-pchelkin@ispras.ru>
 <20240520090819.76342-2-pchelkin@ispras.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240520090819.76342-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 3:08 AM, Fedor Pchelkin wrote:
> Commit fbe38120eb1d ("signalfd: convert to ->read_iter()") removed the
> call to anon_inode_getfd() by splitting fd setup into two parts. Drop the
> comment referencing the internal details of that function.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



