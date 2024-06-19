Return-Path: <linux-kernel+bounces-221500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA390F47C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB591F22649
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568415531B;
	Wed, 19 Jun 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBYQH8nn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B738152792
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815972; cv=none; b=Tg6qARq3XToaQAoUI1CKIxeqsm7EPwlMYLdKlzmNrT8w5rOzNuF9qVg8OXFxoKgzfjePeLgGi3B8BzkY9G1Hoj/VCUnSaNqkAut1QaJiq9ASRmx30Pw5c135U2HPbURXYtPogi5Kkh7bxmAzxiZ1Zj4z6ABgEdKig5fVMFvAR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815972; c=relaxed/simple;
	bh=saUTJdbjvScd4ObFi1sGHb5ITwLyYc3iFqSEIUp/NHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdUwfw0kqBo47HAtEg/mIG3uLHTkxNOCRUqJa+B0GxWicNmjoyGigHRtugvTTDyc1XjK5N6bnVZblbM+k0/odSUDeAMCFtpR39/DcKA2+5L61oxwiAw13vjbZlNQQafvRdhOH0bND8UDNzOYteHXSoJYQYM9hh24pSVsMTTzMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBYQH8nn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so814920466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718815969; x=1719420769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sg8iq1YbugOa9R8IB28lqgdNNm+1gAxq/vOOtZ57ZOo=;
        b=SBYQH8nnjFPYYvZIsratRXkXpnSqrHWyxUKJCLzSTKaMom76I+jbKKHj2bXKGOk44u
         5cWgFxYjnGg0oIFU/z63dP3DagEhkGfFjm/rAYE2h+FB1GW3Vrjo3MhhMRkoGWw6uTaR
         yzZNMeo49vSCFzB+w0RqHJEA8TBKFoqgTf6XySH12ZACZ8YK4j4ZYcdydS1BzqlAPX7U
         nsk3LRsb1HFejiOhm9pvhq+YJyy0byJONBdkM6EW3K88hV0nnbeDQBn4yqrym2mEkYfs
         UgFOY2foLLT8L+JSuFTK4nnFdPFH7AZ18Cqavrq5RrQf8blnrdAVLm3JUX2sa7gYi1Ov
         wi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815969; x=1719420769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg8iq1YbugOa9R8IB28lqgdNNm+1gAxq/vOOtZ57ZOo=;
        b=CffFGpngxMza2emNO6id3+GkgBs+VbG5OcE95C/PahdyruFIVmoyaNTwN/Aj0UcB/b
         MzqwZmRccHxCkir2txNBFNSiIMH/l6tF7s4R3OtmwslcYVMAjxt0EyvaHnGoYhqxkJt1
         B4OSUxmSE2KbjD7Rba/hC/kC7DB0sqB7gEvIM0tvxj/o+l2TUCoJTJ9X0w3hwJuI93oN
         g6bPJLd5CpObrax2frMpEveyKeEbHG3tj+1dAZGtqy5QkmtMFvZ3loycOuhB8IoYnuWA
         VHszM9TafnNaj1JZ7NO9VNYi2ed3NtkTEiH1SeSMsuzKjktleJzJSm/6RrNlk0zEhDwF
         /ohg==
X-Forwarded-Encrypted: i=1; AJvYcCWHD4hz1/Ow+odyBXWVR8X1SG/lGGRqxTW8HoazKbyMQzwqIqS/RNsiHNKTPHRM+zu6ZQ9YVOlZGKLdqEnKx8TMk0gPpJrZ4NDffl8X
X-Gm-Message-State: AOJu0YxZuJyeKUhk0Ujv4SeD+4JyZ+U2u+tL/Cmcg2gZMAjhkBKqyr1S
	FTE6D4s55VTxW+IZDPFDiC4drX2qOtv76t2fmlv5bjWnwn6dNZII
X-Google-Smtp-Source: AGHT+IGLVc6V9yHvLlBwOaTLXlaBqSki7ZZ318wMOiFw3bNvll5UDbTnoOeAaDrDMurVE4s7u5vDlA==
X-Received: by 2002:a17:907:808:b0:a6f:586b:6c1 with SMTP id a640c23a62f3a-a6fab7756d5mr237803466b.56.1718815968691;
        Wed, 19 Jun 2024 09:52:48 -0700 (PDT)
Received: from ?IPV6:2001:871:22c:6af9:d5cb:1d01:917c:4b48? ([2001:871:22c:6af9:d5cb:1d01:917c:4b48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8f934346sm196331366b.94.2024.06.19.09.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 09:52:48 -0700 (PDT)
Message-ID: <63f10133-311e-4c4c-8192-978b01b41247@gmail.com>
Date: Wed, 19 Jun 2024 18:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.10-rc1
Content-Language: en-US
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@gmail.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rafael Wysocki <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
 <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
 <ZnABbKrIzmmEoFEV@duo.ucw.cz> <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
From: Gerhard Stoiber <stoiber.gerhard@gmail.com>
Autocrypt: addr=stoiber.gerhard@gmail.com; keydata=
 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
In-Reply-To: <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello!
>                              
> Ideas welcome, especially some way to see what graphics is doing.

I'm unsure about the distro you are using but try package intel_gpu_top. 
It displays irqs/s and a bunch of other utilization statistics.


Hope this helps.

--
BR,
Gerhard


