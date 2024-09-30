Return-Path: <linux-kernel+bounces-344447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44398A9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CDF1F23E33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B2F19307F;
	Mon, 30 Sep 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kIjG8nyk"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68F1DA21
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713526; cv=none; b=BSoLCAmZ1jZ2M+Is1PvAVfR5uL70VjhoGIMo4glwWF+F87xfUqRFV6gec4/Hj3tfSHLBWnwM4CCBIi52M5IuUnFB9L3FcetYTHyxxg9CIJpWmLV+4sq3e3p0FbJF3o+avvcPbGOiRrzedU6cZbWzWTwsC3HGF+Qbr6CdTOY/GvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713526; c=relaxed/simple;
	bh=J4c6ww02lHVyWMgO4yK4OukWjlCltUYn0A0YgEeDjlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEqfLB05cfsu95geBauMq+bXHe0ejJuwpBSg8vSR2fMkD42y8P0YamAe4bGbaqn+I6k0iH2nT0Sb2nlpuYxl423NADCc4eUCQrYQA8xadn0asqJK7yhmx7gImg82/MJFcQHenPMnW2ZrD9g/GLJjNZgJAmtJXtNOMBuB30S8G10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kIjG8nyk; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cdada0f21so165138539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727713523; x=1728318323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omPN4w7+Ji+YlU2yam7PKuuBj5W5Hc5vkOTfbiaU3Yk=;
        b=kIjG8nykAcG8uJlox0zOPMnI1y8mtbLSE7op9Bfdgwf4XSzSBfao1Dq/ccjKar75Ri
         ixbuPhdmjArBYNdZCIL+9Aixh8YSV1nApQNhybRumMRvNeIpYN+3rkobzw4Qo9yxxAls
         +teNSOEguIiiUs7yMP/uNLYC/ZC970wGdAUvzh5RCXwYFuEhPN9b2i8sRmZp+qKLuqVM
         7apdm+1J6DRJYuL06+38sDAMdVCTyLmxojhG1a2Nx+V8SrIuEZWssSNDC0+B6yD/8PNE
         ECruAgDozhJUjgdeSV0YepCjVmo9BT4Fk0rj/8d/lAWzX7XBEJobIBJq79irn4Dm8IoH
         v+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713523; x=1728318323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omPN4w7+Ji+YlU2yam7PKuuBj5W5Hc5vkOTfbiaU3Yk=;
        b=e4fSoNJYvN0NdINPvz5HzUpn6MZsKsdFaxWDXkURt7mu9BjneWQyI3D2H/7dmsOkny
         ule1acISCmXfUxy1SWRI3wE59VfdJ8BH0rxqbAe+6n5mKYScqNNJqQJqK0ZWTo+O2zf3
         5tJxil4PykZ9VrrrhwM86am8UVc6jUlmCmvVVFaLTCxNlRLy/SxlTzbs0lvIN0gCsPEd
         FO0ozgovb2WGFP8+3fwWxURWV7uPQ9P5GQAso1wsJr7vgGkfT7fnM9GvesG7viJ3uJW6
         3mmhyiKyXeqpkWhDRAvJ7wiyLiYermKPo9FAg0nK6AYLo6ERl5O+2+IVHF0+akocEGZQ
         23ww==
X-Forwarded-Encrypted: i=1; AJvYcCVayJHDWnFEkA+wgP+VPJiMjqSrr6Pdydh3be0co0td7Aqwl886wnl8iRBhCYHewADF4g/qfgmJ129aOD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZhAdd7ERUKYKnBJseJEtODBXwVBKYpwAr3vBfOsi/SS2mtsO
	wEF1gtkOxgC4j8FiOEElLT+hhD2K1sLNqXeOht1toR0OiqdLpUnjuTXTvH/09JwonJ3Gwzi5cdB
	MDsQ=
X-Google-Smtp-Source: AGHT+IEIczCRKzK2BtvKeshh8rAOS3pL0Obj9CvhSs0zGuLWI7GKP/hfxlBfy4agzmnEwV00BQFBFg==
X-Received: by 2002:a05:6e02:1563:b0:3a0:378a:884b with SMTP id e9e14a558f8ab-3a3451458b4mr97854735ab.3.1727713523236;
        Mon, 30 Sep 2024 09:25:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d8207esm25417955ab.35.2024.09.30.09.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 09:25:22 -0700 (PDT)
Message-ID: <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
Date: Mon, 30 Sep 2024 10:25:21 -0600
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
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/24 10:16 AM, Borislav Petkov wrote:
> On September 30, 2024 2:27:03 PM GMT+02:00, Jens Axboe <axboe@kernel.dk> wrote:
>> Would it perhaps be an idea to revert the cleanup until then? I can't
>> be the only one hit by this. We obviously missed -rc1 now, but...
> 
> You're the first one I'm hearing about. Either your configuration is
> weird or something else is amiss. I've tested this patch on all AMD
> families. But sure, feel free to send a properly explained revert and
> I'll ack it.

Hmm, seems like a pretty standard cpu and updated microcode fw, no? But
if it's just me, we can just defer until it gets fixed, at least for
some more rcs. I just pruned the microcode for now to work around it, as
it's pretty annoying to forget about doing the reverts and then booting
a broken kernel. The box takes minutes to post+boot.

-- 
Jens Axboe

