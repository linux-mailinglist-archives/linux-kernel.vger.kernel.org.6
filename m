Return-Path: <linux-kernel+bounces-326257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259B976597
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167AE288647
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C719E980;
	Thu, 12 Sep 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a9y9nv9N"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C819CC16
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133446; cv=none; b=kk/jDltByIRcd7ylPGE7i2jHm/rKLPe8nVNHCrn5F723C1x4Uw3qCjEuh1MOGRUyAvsF8vovEPXsXjbVj/x1CtD2hFOpYRxc8Mb6NlhP1AXPHC2uyhsOHIQpSyira4EKcNVhAY/iKtCkt2QAvfcde5kPBTTZr0LeUM+xst8IuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133446; c=relaxed/simple;
	bh=kIskcl+cEgPa5aOW8KFz0H+4vDyJJxE4xQKfindfVE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX0F8f1yHKDUCBjVu/72PwrRVfzbW43imJQOJBC1i9mEY6iGqVgnqAmxq9ltrHYu5Ymlcc/Cf8CsAN7Fak9TiAmnUS54L3o0WRKjcE37PIvYl4tj1w9PQnSns/Bz3bfgXtJB1h9b45KLWQrNSDQSTPbJb38e9+Lr7cd+grJSgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a9y9nv9N; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a90188ae58eso82510666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726133442; x=1726738242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tehr3Mtj48VR2KLQ5YViiHbq049BmJKRG0Xv+xURro=;
        b=a9y9nv9Ndk311ezdPxvKVfd6wriza/G/oKMayiBpLs3th6CMFI82PSH0SoVhXsOshN
         dlt/IXhUFIVsosvXq502tT2ReCZk+Jv4iHCJ5Ew18yENiWMigVfvu+yboDg2QLaYKW2a
         q/uDQixv47epgqaHXyLlUBdQ3x59G6uGF3WIhlNDVqFvApnIDtCIhvamwIByghz1qx3G
         JgjcXrf5VTJFG4jq0mo1eo8fVRXPa8IxH9sZS6uIQaklaNmF73tyrCc8UkXYqRSRf7Ij
         vITjwoSXPI7YRssoKu8SzKruQNW2UktbHKCQ2XS0JoIYVcT8BFF3uKpKaisPAc8YjYwq
         4hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133442; x=1726738242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tehr3Mtj48VR2KLQ5YViiHbq049BmJKRG0Xv+xURro=;
        b=pw73dicgsPWUFZhPUKylpXjwmIOVueBmmgB9vDgTmMDuDp/Y1kPZ3uPvZkNZ3oUIr3
         GT+8Y6z7k4/wnKWJH13RHy/8qWJOXzhHjKOueAcqc3cfSV2mN85Ur841wrBdLPAGHSCz
         Rwk3rPwA1aBDk1N0QxTSLckIagKNW9ZlnEnOgmisGs5j7txQ0rH6oo8nIXTbg1Dwvlg9
         YUcZ9xdQWIfGn3ohGMwP0uk7dH1movPuDaLZuDC+lyCaZsjUIndcO1SrjZOwsFCNS0Bf
         Z+Mgl2hUsHoYFAUcfqDuYp6omGTi1Sm8wwmUw5RO7hOs1dhsqaa4yiQWF+nA+Q6QMwLG
         oljQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEgiIt8NYWSm3Em19QygCqZ3y1xOznijPkVHW7tGfq1OCelym+s8ZW5YOZC15+9ZetJrW+3BPaq+2iBxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Thz27Z/23OXAKMliwNdAe/VRYiw6NCGjnOrDWhQYpX/Vurpr
	3rI+4XpLhbHkHkkLsOaEGRBawstfHA34CA37DeDil5cHYzCb1yn9tfuMzEfVgPE=
X-Google-Smtp-Source: AGHT+IFk61q1QaMhES8++jv0G4QK+ddVK/i63wtjh2HBapnGeR6O1fso9P71UpK7pdr8aia6GB6nVg==
X-Received: by 2002:a17:907:f7a0:b0:a8d:6648:813f with SMTP id a640c23a62f3a-a90293f9ec4mr197574166b.3.1726133441942;
        Thu, 12 Sep 2024 02:30:41 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ca:eb01:f47c:2f3f:7fd9:e714? ([2001:a61:13ca:eb01:f47c:2f3f:7fd9:e714])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65742sm719928066b.216.2024.09.12.02.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 02:30:41 -0700 (PDT)
Message-ID: <3ff7c85f-95f9-427f-a496-370f2e56d1fe@suse.com>
Date: Thu, 12 Sep 2024 11:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: fix cyclical race on disconnect with work
 queue
To: Paolo Abeni <pabeni@redhat.com>, Oliver Neukum <oneukum@suse.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240905134811.35963-1-oneukum@suse.com>
 <ff23bcb5-d2e8-4b1b-a669-feab4a97994a@redhat.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ff23bcb5-d2e8-4b1b-a669-feab4a97994a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.09.24 11:58, Paolo Abeni wrote:

> I guess you do the shutdown twice because a running tasklet or timer could re-schedule the others? If so, what prevent the rescheduling to happen in the 2nd iteration? why can't you add usbnet_going_away() checks on tasklet and timer reschedule point?

Hi,

I am not sure I fully understand the question. Technically
the flag prevents it in cooperation with del_timer_sync(),
which will wait for the timer handler to run to completion.

Hence if the timer handler has passed the the check the first
time, it will see the flag the second time.
I am not sure that answers the question, because AFAICT I have
added the checks, but there is an inevitable window between
the check and acting upon it.

	Regards
		Oliver


