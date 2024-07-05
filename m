Return-Path: <linux-kernel+bounces-241928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2521928167
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB78B22171
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604AF12FF96;
	Fri,  5 Jul 2024 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j36W5uTH"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4838DD4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157279; cv=none; b=PA+pI2lqUzIBns87Sd7N7jobSVdZsERodmnz/8DsI/YFz532I8/fkNp7uu0nK50Rtc/w5VSgDqPXwLeIMqnn+U3EKvJ61hjZWbVNqsRgGGtqRtzShMCGhdGCub/ijoH4WOSdWKRhAod8BEqzxQWCiFHz7FMF3fjG/LT+UEwTlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157279; c=relaxed/simple;
	bh=IuWAwgCeUBkfjP6km09ctIwl+81nu6Pfao0/ZhGBw1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUakpK5Keq9QC6nbmPFVtznHD5dwaza8+olQ0EuWTgtTZYzanjbN2u90eikVKsgfWN5U5jiixKl6nstxOv+IJzM03HTI0reMkf85qkr005v2ap26CyQpvj1LJTOib23OB0PVx4PNgId8dZ2ueLSlDzZQqRRaaxFJwFcrVbarwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j36W5uTH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c98db7a10cso839633a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 22:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720157277; x=1720762077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cE/VrsMliLS4UQF71x1J0DRE8YW0wHhjEBi4FtG/ij4=;
        b=j36W5uTHGd2Nx7AWoLbkmPBFbCbyLWcqCg3JMs/CxsOaAeKgP+WiOmsgEp22kUX30g
         KPEzzpAa1pAvFP2DaOFkIUhAgP3+YWyv3c5SGFgiQXr6sfi8ZDDDFXOtYfQtqTfz43ce
         ujtK3ttUtKh86bZcQaPjc/f/wWJoXUboErngM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720157277; x=1720762077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cE/VrsMliLS4UQF71x1J0DRE8YW0wHhjEBi4FtG/ij4=;
        b=imczULa00pwqnfn8nlG4UMsg/2VGW2GOQsU0TpEU8mANJfJ2VfLGlKJFSPHo3cJaCW
         6f31wywXOha6rcAOD/28QgEqSLM0+IDymYJDiBhoPKMRRPcVAvzM0cQw1M3klwUdiKPs
         8mY4roEsOEX8M9DbAE1P0luIksr6hTqp/1qw8cXJf3p/+ep+1ZSU2kaLc91xcKxdEumv
         1NhaBuOeSd7Ni2b72lGdT7w5w/PSB3iFT7QTqn7Mti1EFyrWugepEmpTpJ5JANx5nrdM
         BeQuCQjGVo8jg8SdlktvnPAbtC45YPmb/LLpJxC/MEqnPDh/OB0R9Aq/IcjxXDeiVz5f
         d1nw==
X-Forwarded-Encrypted: i=1; AJvYcCXEeZlQm2+Qp9CYuaWstIjC4sZbMN6A8NWD8rpRC2AVYXGL9mF58IxeOlaN1gB9Zk2edOEufWp3ck0NxXBBGhUxnjGM+xezUt9Bo+3S
X-Gm-Message-State: AOJu0Yx2YynGb/KdqBvEUHkTmDKjz38o3pmbu4JvFAwfkujwuBzYORT5
	goyDVaFZWdfMeG5NDu1UaVuhfRXONErc/QhLNk1EV9GAx73d5Od6NaWaznSlIg==
X-Google-Smtp-Source: AGHT+IGC+qm/pcTF4bcmuL7sgtnOCCmzDDrXkjKPmvUq3AAMMNrl5im0HLdaM4e8ra3lqSDxXXYNnQ==
X-Received: by 2002:a17:90b:81:b0:2c9:371c:ea9 with SMTP id 98e67ed59e1d1-2c99c56abb6mr2645253a91.21.1720157277588;
        Thu, 04 Jul 2024 22:27:57 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:cd34:f8a3:9ee6:ca3? ([2401:fa00:8f:203:cd34:f8a3:9ee6:ca3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a980663sm2469296a91.28.2024.07.04.22.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 22:27:57 -0700 (PDT)
Message-ID: <f3b86a0f-54ea-4a41-869e-643cbbad8192@chromium.org>
Date: Fri, 5 Jul 2024 14:27:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] staging: media: ipu3: Stop streaming in inverse
 order of starting
Content-Language: en-US
To: Bingbu Cao <bingbu.cao@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20240620145820.3910239-1-mstaudt@chromium.org>
 <20240620145820.3910239-4-mstaudt@chromium.org>
 <e6ff8ad5-933d-fbbb-0c4b-ae19c65e8439@linux.intel.com>
 <4e01aa78-497e-477e-a5c1-951cfb1df907@chromium.org>
 <594c28e3-67f6-bb80-4751-ae6dc9f34c7c@linux.intel.com>
From: Max Staudt <mstaudt@chromium.org>
In-Reply-To: <594c28e3-67f6-bb80-4751-ae6dc9f34c7c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/24 1:03 PM, Bingbu Cao wrote:
> I guess the real problem is the subdev s_stream cannot be called multiple
> times, please correct me if I am wrong as I have not touch IPU3 for long
> time. :)
> 
> You can ignore my previous comment - 's_stream' is fine here.

Yes, indeed the multiple calls were what the newer V4L2 versions are 
screaming about, and what made me write this patch...


> Just a nit, stop_stream and s_stream only happen after imgu_s_stream(), so I
> think they can be together and no need 'stop_streaming'. I think the mutex
> is mainly for imgu_s_stream, subdev stream on/off should work without it.
> It depends on you. :)
> 
> It'll be better that others who is still working on IPU3 devices can review.

Okay, let's wait for their feedback then before I send a v2.


> Besides,
> Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

Appreciated! Let's do a v2, when other Intel folks have had a chance to 
chime in.

Max


