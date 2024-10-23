Return-Path: <linux-kernel+bounces-377179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F739ABAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55023284D52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549CA29CA;
	Wed, 23 Oct 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T4d4JAlc"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3831F94C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646059; cv=none; b=aGH1Chw6LPAld1lEV5sAN+/bzTaR4RpInWQKWJg55VB6gFTNvcJSX0yW8Fbn/iraoMtavf5ac/6/ZJ5It+Pav11iqzYfeg/ccXs+FqTg91ZHu6toToVo987nr9knL9TmWy4rmMrYf4yt30mRW8QjMs8Anzf3n0nwmIwqh34R8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646059; c=relaxed/simple;
	bh=i/fb2TGN/0hbxeCo+vsMA3TOw8xxxeaJTm/6ddVBNT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijD+uSuU2a1SQ2xYqBIJS8fRVL/AGSpP5em5zXacRgaPTBxqGOwogz+IscT5IBs1D2K6Os1QbO5HUlH52IqBJatSlQ2Re1qAM1M+lTWX7qT1QTTr1SQ6clydR2w0PFJDSfsHwL4uS7w2GgGcR2jy2JKmcvNxQS8rrQXFRai49GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T4d4JAlc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7180f2f5fb0so3184918a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729646057; x=1730250857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBMX9XSvCTqxyEsI8dGZy5i0R+AMQRgfKJfND5aCkw8=;
        b=T4d4JAlcOsrPhyPyQyRnURh9a619F86BYZHueDmqLBrnyGUCKm+SsJXl/LCA0frI66
         e5y7n6oCPfXQpFzQ+qubck7TfO89T9VBua5SJK0EJ1HdUBcJwSRFJbBSf/nuPrVSFQAB
         Ymr602jvbN+0rzaVksnaz2LB+xZ21SN6IPqDdlXfRNhvLqO76bMs9AhUWIiouSWubdAW
         FdSM257e5YIYf12JJ/4RSVinxElFIerJkNwLrlWWs1mgQFW5fWVyBdbbisES7lMbwy98
         ZTQptX0H/cTN1lkrrabW1Y+sSukdJ4MbCJIDgAOmOIiPhvRVXChQ+DyXeqz/tA/wucnf
         ZOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729646057; x=1730250857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMX9XSvCTqxyEsI8dGZy5i0R+AMQRgfKJfND5aCkw8=;
        b=snDGDXEDQHeZF8uzHIxYEqQ0akpyb4EQrWNLf7btxrDRA6YrnsrdE7Sk7dDkWO71RS
         a7vS9CmxYVglki/5b0icMprfWg0szg8KXFZ08PmY5bCDge0VtER0pwIQ58QellVzZtJ9
         CzUTECteTuOM8RJOxmx+hw5+UAkVTvklEQlxCkNBYiMcEGIToXSBlRagfgNObEQIIsry
         HiufdY+3wTAUEuS+CVfk+Lh6nYVvL9bTYxxnm1AbQnxzwQAtTM2DRjKEIAi3Ax4/AJl2
         zYhcqPVj3klgbjdXdqqgiVrrUrJZAl7c8Fj2kg+mUy0a+SCY7u43H3kNyw+kT9eV93/S
         fNGA==
X-Gm-Message-State: AOJu0YwL6sUE2+sdJhIiBDwxs+sL7cBNURoyHx7Qp7a01xLWQlRI2tCV
	SrifwfEPRC5g9w8KrB4iF63NOenPKh7fKXlzQ5b8SSED/9Acw127NfM0nn+8Bes=
X-Google-Smtp-Source: AGHT+IGzehqz1HMkN16yEyr/3tx8KtWHL5vnppeJytoAc9iw8z0cLNNK5rz78JbRhFQy3v4j1i1O4g==
X-Received: by 2002:a05:6830:3494:b0:718:1957:4b88 with SMTP id 46e09a7af769-7184b2a8017mr1021273a34.2.1729646057222;
        Tue, 22 Oct 2024 18:14:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1dc6bsm5693234a12.23.2024.10.22.18.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 18:14:16 -0700 (PDT)
Message-ID: <8d057adb-c7e4-4324-a963-7fedc40ceed5@kernel.dk>
Date: Tue, 22 Oct 2024 19:14:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To: Bart Van Assche <bvanassche@acm.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241023095914.61b9eafa@canb.auug.org.au>
 <7aaf90a8-4734-4819-b29c-42f8f8b857ac@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7aaf90a8-4734-4819-b29c-42f8f8b857ac@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/24 5:31 PM, Bart Van Assche wrote:
> On 10/22/24 3:59 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>    6fbd7e0472b7 ("blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long")
>>
>> Fixes tag
>>
>>    Fixes: commit 414dd48e882c ("blk-mq: add tagset quiesce interface")
>>
>> has these problem(s):
>>
>>    - leading word 'commit' unexpected
> 
> Jens, please let me know if you want me to post a second version of that
> patch.

I fixed it up - for future reference, I recommend adding:

[core]
	abbrev = 12
[pretty]
	fixes = Fixes: %h (\"%s\")

to ~/.gitconfig and then you can just do:

axboe@m2max ~/gi/linux (for-next)> git fixes 414dd48e882c5a39e7bd01b096ee6497eb3314b0
Fixes: 414dd48e882c ("blk-mq: add tagset quiesce interface")

and get the correctly formatted line. Whenever people try and
make them up, they always get it slightly wrong.

-- 
Jens Axboe


