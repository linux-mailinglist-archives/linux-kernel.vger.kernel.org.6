Return-Path: <linux-kernel+bounces-393462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98599BA0FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C2281F77
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174018BB87;
	Sat,  2 Nov 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="c+gmsUSO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24878C9C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560180; cv=none; b=P22/pGw7lroRJu2ZrK0RS8Azve0iVdX917NeCb+b/X3g3Gc0KlOBwhweaZHhip/wRlBK/jydJFh2D8sOjSXR3FrqPWHVXT1/Uk9yfLN2u1wvNJUAilKjr5L+1dl1IrLMXGHTqAEGvquDs92EpMFeWgpW/gYy9bH6JbpAMMENcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560180; c=relaxed/simple;
	bh=L+Ocnh5eBjxxGrMYxyxEgEVGaSoGcibumMOipADOpEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihGOQY5aQjvT1NuN1PozI6g6S/bvk1krbufFYc/VdaDESNJNQLnBCKzeRv3EDgbQVISPtK1vlxraF5j9zgDSXGnUWTbskArmIuIhS+4z3utL5zDNr8HU8ziSMRkOZ/SIMJGlGAzxAPPQlhNs+eAnL3/3eNjddUykuomi65DYFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=c+gmsUSO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cceb8d8b4so18251005ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1730560178; x=1731164978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0leqICJyTXfsj1QTNtYhe89s48cLc/TfjqKKmksT/s0=;
        b=c+gmsUSOlByMUBNvaUvQJn/waHTAPxaVvP7cBDbCvxlAAxsYckdxsyZNu83hNJ23vI
         Ab9z+KF18H+V5a7OMZzpjDqQg69a66mpvoPq+FjwnliKziRHKmkwSo+Lpd1H9f+eTXma
         DT1YQolbUjpYQ8WWJtQulIhQK1coRpj9B1ExDM+m9Ae9BX+eK9TfRyeoVhic0qGhTqiV
         alXP7wMCgq7GYPo91+bPnnfchCP0sDBYnKiWeQU+xvPoVpfI4T+G20YEYiUl/WLJ+Jdz
         sxtQPXpyvb2TwL7THvEbV7JhmsQrTsb+BpxARY/kNMYuMZSBtEnfpofQ0ivJuo4ve6Kg
         OquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730560178; x=1731164978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0leqICJyTXfsj1QTNtYhe89s48cLc/TfjqKKmksT/s0=;
        b=VPdn7RqhVrJ0GTwNgbxcRtITIl+vtvhrHh/si+KbS9o3tp0Br4WuTJJopImllU2RWZ
         TuO9btyAODfz6mzKNio+wYhjOm9M6MUHG9siyVeFBCEal0y2mcaGuvrIsEXWLrcUMbwc
         UJNE1IyrjSlIDbo1KsCF8a4VeRDJNijnYYAdraU5KIvNNMufM8tBU5uiTLXIViRlR4yK
         3HWfYcnfj0uYfZAIYglBAM7xcT9vS35kBwbCHa1bh2HHKHoRy1SRPCdgUvm2Hwa/pAm5
         zB/KBvwLMJjOPVgtJxyAHVRhb4Jq9FVA0t3E3K+/JoQLhyigP2MFp2+47SxeG+zlEJD8
         sW7g==
X-Forwarded-Encrypted: i=1; AJvYcCW54qgtV6Sf6nO/II7o8UxCr0klZ8z/3UxXEIL1a42C4EsMFT95INzqJyoU+73cto+cBVaf/PlaGOeG96c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhN8RWcEej5RzmqCGq70KbjsuT5mO4zioKWmULJP369ODACkoM
	l4ypN0hzTE44/koJ6k4K4zYPHfFfhO7LPS5C/+JbZFobcAk+AfNiMpn08d3nDJ8=
X-Google-Smtp-Source: AGHT+IGtMCKhO/lNmhTUeMJKCu6Ot50mbF1xufreQMYqVzRQWGDn7Q9Kxh30qqU37dlU6/vepIGY0Q==
X-Received: by 2002:a17:902:ec8e:b0:211:2fb2:6a6 with SMTP id d9443c01a7336-2112fb206e3mr49239715ad.24.1730560177752;
        Sat, 02 Nov 2024 08:09:37 -0700 (PDT)
Received: from [192.168.50.161] ([180.150.112.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0ed3sm34953685ad.216.2024.11.02.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 08:09:37 -0700 (PDT)
Message-ID: <43b07db2-6856-4dd2-8616-560a24d9f09a@tweaklogic.com>
Date: Sun, 3 Nov 2024 01:39:25 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] iio: light: apds9306: simplifies if branch in
 apds9306_write_event_config
To: Julien Stephan <jstephan@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
 <20241101164118.687be624@jic23-huawei>
 <4e4e5281-d489-42b5-b358-c44958cfa4f9@tweaklogic.com>
 <CAEHHSva6+Br9rXE9n0wqXuwQqetXN=Ae5vg0rxmPRfCVdw9atA@mail.gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <CAEHHSva6+Br9rXE9n0wqXuwQqetXN=Ae5vg0rxmPRfCVdw9atA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/24 00:59, Julien Stephan wrote:
> Le sam. 2 nov. 2024 à 14:21, Subhajit Ghosh
> <subhajit.ghosh@tweaklogic.com> a écrit :
>>
>> On 2/11/24 03:11, Jonathan Cameron wrote:
>>> On Thu, 31 Oct 2024 16:27:08 +0100
>>> Julien Stephan <jstephan@baylibre.com> wrote:
>>>
>>>> Simplifies the regmap_wite if branch in apds9306_write_event_config.
>>> Applied.
>>>>
>>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>>> ---
>>>>    drivers/iio/light/apds9306.c | 5 +----
>>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
>>>> index 8adc74040db2bddf93fbb773e3519abcc726b9a6..9c08e7c3ad0c17519689a630d42fe9b90438dfe8 100644
>>>> --- a/drivers/iio/light/apds9306.c
>>>> +++ b/drivers/iio/light/apds9306.c
>>>> @@ -1125,10 +1125,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>>>>               }
>>>>       }
>>>>       case IIO_EV_TYPE_THRESH_ADAPTIVE:
>>>> -            if (state)
>>>> -                    return regmap_field_write(rf->int_thresh_var_en, 1);
>>>> -            else
>>>> -                    return regmap_field_write(rf->int_thresh_var_en, 0);
>>>> +            return regmap_field_write(rf->int_thresh_var_en, state);
>>>>       default:
>>>>               return -EINVAL;
>>>>       }
>>>>
>>>
>> Hi Julien,
>> Sorry for the delay.
>> "int_thresh_var_en" corresponds to APDS9306_INT_CFG_REG bit 3 (Datasheet: INT_CFG, Address: 0x19) which
>> is a single bit value only. If user does "echo 4 > /sys/bus/iio/devices/iio:device0/events/thresh_adaptive_either_en",
>> which trickles down to the "state" variable, do we really want to write any other value except "0" or "1"?
>> Correct me if I am wrong here.
> 
> Hi Subhajit,
> In drivers/iio/industrialio-event.c, iio_ev_state_store is actually
> using kstrtobool to check user input, then gives the converted boolean
> value to write_event_configOhh ok, that's handy.
> So state is a boolean. By the way the purpose of this series is to
> clean up code and use a bool instead of int for the state parameter.
Thank you Julien for your efforts.
> 
> So new code is equivalent to what was there before.
> Cheers
> Julien
> 
Since it is already applied, nothing much for me to do here.
Regards,
Subhajit Ghosh


