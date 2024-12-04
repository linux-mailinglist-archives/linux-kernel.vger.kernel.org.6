Return-Path: <linux-kernel+bounces-431294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D309E3C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A5EB37237
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311801F471E;
	Wed,  4 Dec 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbhAeE/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A01EB9E7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319989; cv=none; b=Kmf4VUjUoGHPIXQBNKfwvIWbshel54an1cuwW5zIQKsaeocgL5TspB4A+EAlkTfVYfGck+oBUXKxDmFUrf65ZTqnqd8K3+z+plnowA/FqAastELsQAm6zJa5wArtl0I5iEKlT3vSuEXb1y/J1DD9sl9nI7ThZ8nQlhuY/QNQfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319989; c=relaxed/simple;
	bh=Cbw6URr7BpchOgGvOsnvOBm3jM/gD4ppQ0a/dAj4D/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2hYtmLobj/L/7Lun9gKFskemEBSKwKI2hMj2dC0MO2mnr56nRuQtbHyD8oQ0aZ7auWQRuJsGLCjcckgXCYZfbvTey/2rNr/FoDbwp7C9pIO7tHkn4nuSuIIGrof3LEgJ9tCP55z8GroNDDQsN3fWbaUR6X2vwUQ+Tgov4yXcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbhAeE/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQV+/reYDzQHVW2bMORUzTYkYet838A4ueVXpJ2mu0=;
	b=BbhAeE/0ashp5iFMkmIabxGvjloM2WRStsCP241H7p4yEw8ZCjK9HwXVZbpL/tG4ygCmGd
	B0DEB/ImOX2lkYkfSZnjVBC141OVzqG554V5E88Pg1bhFNPoICO/4stmHRXVgRc5ak9F5A
	+P0jqxiTPVkJgpFmXeFVNiegm1p0vx4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-Bhxs1FNPPD-Fbdp21qlsFA-1; Wed, 04 Dec 2024 08:46:25 -0500
X-MC-Unique: Bhxs1FNPPD-Fbdp21qlsFA-1
X-Mimecast-MFC-AGG-ID: Bhxs1FNPPD-Fbdp21qlsFA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa52bfbdfebso474564666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319984; x=1733924784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBQV+/reYDzQHVW2bMORUzTYkYet838A4ueVXpJ2mu0=;
        b=Z7IJaDyKzrl1lTOjyjfWRmctvy/PlbsR5Wq9t0uRCt7hbEgOPVQDI9wNr8d+QaJ8sr
         P4TEvJwpZX53ejmssilYIdJA0xLaGuaBDkfJOygw4ZwgylzxMJKysGoHylQ7EY6R7l7t
         CeNISyVCBQAwXmWrWt4duIBxSnTUOZZZqbLpwTY6udKFTpe3zFaemS2QrSYnvpVz8s5i
         D5FqxvWLeXwKx9J1NLQ7BcwFkKvnLPH6D9sTQ9rTEquiiFjluf+i+/zByYcHMPUtwLyR
         ei6bFHiSU1ilv0vdbsw74YtIyMpQxqdnL1n7s1tQL+o+soxscmjcEkQyXV479PUAT8a6
         SQOw==
X-Forwarded-Encrypted: i=1; AJvYcCXupyGPAeyq6GOFZ3BVz4yBh9pjrS2BSdSFL7QGjq/dAoVZaYbV2M9QOPXbgvfxsLu1QfoClNP/5WI8w2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUFGTtgqq5xXi/K+jmHkeAIIqDGgvZLFDZtLM45zIAh6B8qYe
	4hKIBh+ffcGzkvtp6qgrU/L9exTh8grxqJhcC/uKEn32huTBE/e/Uyu6yqsG4xHNAUWwtJVevAH
	kgU7fDrDQ6Uy3SX4AniN2JXzn1NXkheGdzZkpvEv2kVeY6zF3nocjupYwEKQqSA==
X-Gm-Gg: ASbGncvMKBzkffyajahiEZUJNJ77+ATCibnnUm2sAlQmpPnnD2hpbmDc+cpSr8C8ZyJ
	iw7cvokDXcTKVryhjBlAVxhWUazB4IIJ20CJrNm/j1FnX5ytUDXsv0DtIBS4qPvb2FJSl6IviqV
	2duM5/xP/iFzzu2/z/Z7MeywMsGQ9EY4F66z2gLctqRGmmUI822YWu2cnLb9xr+YfNf8gjDiExZ
	Zi+dOSs3Q6BXTiD36MlvvwM3AXYTEbt2MwsZlaVx9SM/Lxw0OYMKdhPsos6bx9A6//J3yTtdksH
	9mKC+r/eh7QzW2nsXrXUtV1VVa5ou8Llrj9IJl5irvjsbNPrfGmHPHb782ct01roPZteoidELLX
	WqFdWS9vgeVIf/+DhrW3sVb/9
X-Received: by 2002:a17:907:7842:b0:aa5:14b3:a040 with SMTP id a640c23a62f3a-aa5f7cc2e89mr671377766b.5.1733319984313;
        Wed, 04 Dec 2024 05:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJSFHFdnQSI6RXejuptvZDyxZwz+jBIMo7QA5Sw245xohyQAA0QRuXSgUOrjTafewvvQXSsA==
X-Received: by 2002:a17:907:7842:b0:aa5:14b3:a040 with SMTP id a640c23a62f3a-aa5f7cc2e89mr671262266b.5.1733319973080;
        Wed, 04 Dec 2024 05:46:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d56eesm733692966b.81.2024.12.04.05.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:46:12 -0800 (PST)
Message-ID: <76c867e3-f13f-4afd-93be-639616dc9458@redhat.com>
Date: Wed, 4 Dec 2024 14:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241129220339.GD2652@pendragon.ideasonboard.com>
 <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
 <20241202001846.GD6105@pendragon.ideasonboard.com>
 <fb321ade-40e7-4b1e-8fcd-c6475767239d@xs4all.nl>
 <20241202081157.GB16635@pendragon.ideasonboard.com>
 <445e551c-c527-443c-8913-6999455bd366@xs4all.nl>
 <633ca07b-6795-429f-874d-474a68396f45@redhat.com>
 <CANiDSCvmRrf1vT3g9Mzkc790RUo3GuQaFzu5+_G66b3_62RuXw@mail.gmail.com>
 <839446b3-1d16-4af8-997a-f2a37eb4711e@redhat.com>
 <CANiDSCszkv=YQPJOSE8EarXWPhZxkk-KR9enLScUOV_P0nzTCg@mail.gmail.com>
 <20241203193251.GA4242@pendragon.ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203193251.GA4242@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Dec-24 8:32 PM, Laurent Pinchart wrote:
> On Mon, Dec 02, 2024 at 02:29:24PM +0100, Ricardo Ribalda wrote:
>> On Mon, 2 Dec 2024 at 13:19, Hans de Goede wrote:
>>> On 2-Dec-24 11:50 AM, Ricardo Ribalda wrote:
>>>> On Mon, 2 Dec 2024 at 11:27, Hans de Goede wrote:

<snip>

>>>>> Note that if we simply return -EBUSY on set until acked by a status
>>>>> event we also avoid the issue of ctrl->handle getting overwritten,
>>>>> but that relies on reliable status events; or requires timeout handling.
>>>>>
>>>>> 3. I agree with Ricardo that a timeout based approach for cameras which
>>>>> to not properly send status events for async ctrls is going to be
>>>>> problematic. Things like pan/tilt homing can take multiple seconds which
>>>>> is really long to use as a timeout if we plan to return -EBUSY until
>>>>> the timeout triggers. I think it would be better to just rely on
>>>>> the hardware sending a stall, or it accepting and correctly handling
>>>>> a new CUR_SET command while the previous one is still being processed.
>>>>>
>>>>> I guess we can track if the hw does send status events when async ctrls
>>>>> complete and then do the -EBUSY thing without going out to the hw after
>>>>> the first time an async ctrl has been acked by a status event.
> 
> That sounds quite complex, and wouldn't guard against the status event
> being occasionally lost. I'm more concerned about devices that only
> occasionally mess up sending the status event, not devices that never
> send it.

I did wonder if we would see devices where the status event is
occasionally lost.

I think that patches 1-4 of "[PATCH v6 0/5] media: uvcvideo: Two +1 fixes for
async controls" solves the issue at hand nicely, so lets go with that.

And I hereby withdraw my proposal for a per ctrl flag to track if
we get status events for that control, because as you say that will
not work in the case where the status events are missing some of
the time (rather then the status events simply being never send).

Regards,

Hans



