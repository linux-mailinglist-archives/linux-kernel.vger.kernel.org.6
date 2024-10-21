Return-Path: <linux-kernel+bounces-374804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9779A7040
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BA91F21813
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19521CBE89;
	Mon, 21 Oct 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hSjk4bqH"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71360198E71
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530031; cv=none; b=sWdeNHi4ZoukX6UwG/cC62YxVfLspm55oQ92xmMsRWkEjJ/z1DqQ9y7gqd+v090O82eVnQI0clD4vi0yG6oQluQdXFhdUzGJWu8XK2Kg1WsIstPtg8DGqHHUZUmtig0R6QqPFqjA7bwzw88ZVDgtQftYfBNE61zSzYGLl5LerGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530031; c=relaxed/simple;
	bh=mnRFS/mj+G35ASMRqM8Sj6IPy8kOKX4bsXtvWDlciDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBGBwr3VQ56lmBWx36QWs6t0lQglYj2TckVnE4Y1MxokBTrrpFYZoeYh77YMIxCjRzWwowRwkSBJaQqasdapVJwxUk5alL1Skpr891iULUfQ6aZzq75PlpbYWPAuB0rzqnF+4W6nmhl6oJVZU8fEYeMePTBlW1b3fDQNpNnnYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hSjk4bqH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83a9ca86049so179354039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729530028; x=1730134828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynAME6NN09JzWzcI2kzNPurKWJPhVAQ6z8aud0/0Fpg=;
        b=hSjk4bqHamBAo41+twgfsTtuppzN9iRerW1hDDMyOqK2oF95URxpcQgwMwrun7UCm5
         eXQL9mgnoERZDindAlMqgKKPa3dqcvInVvgyr/qbXJ0YAsUQLJptci+u/2z2V7X8xcmd
         +OPk6V55rWVtpE47gz4Lpe3RO7Pu9KvewR8ysZsP6bcnSqPQ/Syf61WiO84g9Dv7jKxM
         zlQ8DBzdLIUq6dX0ja+rOkNem3yONaxJeMHhPouw1W+kKe9ycK0dlybYlt4fyCQ3bYkK
         fPDISqt3sP/lZBSD6VvNMfMmwcyIQxLInslk7jHAuY0lTs+UaVpYkKIo05VqjhaFCQTI
         vftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530028; x=1730134828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynAME6NN09JzWzcI2kzNPurKWJPhVAQ6z8aud0/0Fpg=;
        b=OPjDaXoyCSy6TisPbvYOHdXRRb0kHApJZTvbDfpoKV4WnM4yOpi4TJD/2qt2nTZnr6
         DWP0ZpQYLQR90zv7S3DKsAdd0kf6i31oxnGWS5kOSFeq92V60LMBfFnUmobUXRME4DWG
         78fM3u2UhLJE5PETBQKwQ9xPiXJU2VEX1QsZbGOCt3eat8DQHEH39suPAGTVfIeAPLVV
         Jp9m/aKBmGFW9wvLpXZz8NpIjscHIiQvxSYtpwDZB180CsFCpwDcUkzLbivBgpCRNmoU
         r95ztPKAPfTUU2ULXeGTjiHLh8nIa9xLjjbLKEBU6kOviGYohIqxvklX9zeu//q6v7y7
         Xu1g==
X-Forwarded-Encrypted: i=1; AJvYcCXwU4R+wzO++ogMiuj12eL82FFRxytUo9saSgktU8vgFRKZEFg53hxzCJcWBZEGYQEj+VnLe0yPPR1bCE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDDbuYphDZERnk9nLmyDng2FgKSqNEsa3GieFCJvfho/IHdic
	vL6GICBNny1oBQhTag9h8u0nV8W27qdDDkdY1VoGYFfIYJtpr4EMJbLeqtljqxsOi2gk0y9DZ3/
	w
X-Google-Smtp-Source: AGHT+IGVp9T6pGjNOnVfMsOCjRFetBtb2uqMCM0VJgtnNP4wYNtnbYheNWRYc351ZZ93jN9AJRwdTw==
X-Received: by 2002:a05:6602:1584:b0:83a:b43b:da89 with SMTP id ca18e2360f4ac-83aba63ff0cmr1327422939f.10.1729530028275;
        Mon, 21 Oct 2024 10:00:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a609491sm1098928173.113.2024.10.21.10.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:00:27 -0700 (PDT)
Message-ID: <daa98312-cc66-4c2f-8e64-01358ee99305@kernel.dk>
Date: Mon, 21 Oct 2024 11:00:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
 <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
 <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>
 <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 1:31 AM, Borislav Petkov wrote:
> On Sun, Oct 20, 2024 at 06:47:25PM -0600, Jens Axboe wrote:
>> Works, outside of waiting 3 min for the serial console spewage from the
>> patch! But it boots and it's happy after that. Attached here gzip'ed as
>> it's 1.3M otherwise.
> 
> Thanks for testing.
> 
> Lemme write proper patches, run them everywhere here and give them to you for
> one final testing.

Sounds good, I'll give them a spin once posted.

>> root@r7625 ~# echo 1 > /sys/devices/system/cpu/microcode/reload
>> warning: An error occurred while redirecting file '/sys/devices/system/cpu/microcode/reload'
>> open: Permission denied
>>
>> and no output in dmesg.
> 
> Right, you need
> 
> CONFIG_MICROCODE_LATE_LOADING=y
> 
> for that.

Ah gotcha, makes sense.

-- 
Jens Axboe


