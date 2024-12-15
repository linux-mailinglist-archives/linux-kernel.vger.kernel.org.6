Return-Path: <linux-kernel+bounces-446533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09699F25D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282941654E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B51BC9E6;
	Sun, 15 Dec 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAP7FSl6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11C1B87D2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734290859; cv=none; b=Ndte46O8UHdiYRF6hQ/aIRKKbyC3kO65Ct4zsNy9Z7vTBSns2ftC6c+1kM/9a1zsHBTb1RzAjjQ5jEqUd29mpsyfVZZAUeFQdJG+7BbopSqBxlTLYBwo1MumJ+YM1dJ2oPBi07oY/4gteVxeWeEc40xKFFpUeLqcs02oQtLMqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734290859; c=relaxed/simple;
	bh=Lp3QgwN092NgYPoIq07B4SsgKiam+NuBK/RRZz64B0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ2hIOzbsjsiBkUuybd4TVf5oj5DgHNlUqmUddf7Ni/WrECPOPHLKYX0tjJn1JlVCbemMpNYDqljxISSzKz4QDjwpYlQt4vit8Rrw5SdSX7vXsWWq2zK2TS+y9kXCrPOIawOtVZ/csq/9gW8J7gflPsi7ObFjJ6y8Cp5m4oARBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAP7FSl6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so3092713f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734290855; x=1734895655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDnM1N2rNeRvgJIofwk86bRtIBtCyFmPSZDetB3QfXU=;
        b=eAP7FSl6omM2vdYs1xqcybgSns27vfC790vatsnt7pigN36ReAD+RGOHGor6IvXtN2
         GO9vMfNWrn1KruRwYiXOH34ACVSA8HmaaxNGfiJhznxkue7TmxuAlsyYAYk0QcQnZOIl
         pT88zwgDkwU3etvrOgZ8te4PSnT4258uwR199yTFQ7nkmxEtgwbspH27RHjz2xnMgRD4
         VjjuM6TT93NXOq9h6qp4aLc7rGBXkcmr6UNx89iWzSauay3J40Sxar/7tYBtEcCHYfHh
         Li5QyNxQb04VJmD/jlu9iIqZChq42VvdVgeJn9zuVYn1ueml19jHUhupTo2Z+BTc4Z3L
         BRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734290855; x=1734895655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDnM1N2rNeRvgJIofwk86bRtIBtCyFmPSZDetB3QfXU=;
        b=hb/EHYi4C7cFXgfANLgWSaYpKIIYt+ose6z30pjW2SaAOsMAOzv/nP1isuhG89zXbJ
         qlCez7mVXuMKcK5IseU/PLrLvwQa48WedxTHqpQ4wl1Bw7eVsS+ayFDxBHcDvybkMQya
         FxAu2vyDYQuIUpq5G3Alv8t/ff9old1N5F7cPi1ILMGaqtaovpmEquzRdPnlG2EwO1su
         e010h80ajNriTRtKcXuEk7SOYxdZuo8O4RFnlgwHvrzuK5o10/b28sJSUPFXbtRqiLuV
         AZMLuNIJeXxWoKMVhMeYhc3OBu4j+E7Y1ghIy126o/B8MOqaRPUVbDMTI3eTpdJigAsx
         w2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXwJj3TX5Bp/DdRk2t+V+s6P0bWk1GeWlfKwA5BnsfY2mXnMFl6pLGFpYES9peRrDodhVx2jqPOzqSjYAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBIuIaXMQwe4fvnTiUp0c/kMzK36Sd3Q9cYRRkUjJNarcPpka
	rXjTwQsJCN6lpNS+SE1z+LNC1TzZGEQqcBXK+d5vfR/7tP+DSLoTKGaotp37N90=
X-Gm-Gg: ASbGncu0a6VDwakbDhqKrzQy0t7ga86ejCp0Ps3WWqeem3029k6S0HHUsLTrEM191Sv
	y+6zhad5j6PA0y3Z1eVmzd6lCa7A2+1fe6xl0lPFMQNKM9lN4VqCVCp8QuoeOxDwRmBtREYGZFm
	YdSpdtd8BeOVPsm8w9vc8A2Rhe8YFfKyel46YA0IvwNKn/hMSSRR6v6Dbephsr8hiBrpaV65JZF
	WEOG9UDanMZJDB5jOfZROywPFhqbA785FtLTB3XRhw0J0TK+rB0ETuCqGIti2Aqcj8dAiV3Tstx
	aT3uGBtFkYF1//G0nQ==
X-Google-Smtp-Source: AGHT+IGYv+YjJBOd9gePDmOf/2CBPRN6WjHZKIPJkn5O8OueV58hVZDki7Fq3l9lgtHvOIEBVCZumQ==
X-Received: by 2002:a5d:6d8b:0:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-3888dcd460amr8574033f8f.16.1734290855621;
        Sun, 15 Dec 2024 11:27:35 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-388c8012170sm5998227f8f.14.2024.12.15.11.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 11:27:35 -0800 (PST)
Message-ID: <f3bf44a5-c0db-4970-b03f-c2ea553de7d3@linaro.org>
Date: Sun, 15 Dec 2024 20:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/thresholds: Fix boundaries and detection routine
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
 <3a8685b4-c18e-e3ca-60f2-893e3a9e0ecd@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3a8685b4-c18e-e3ca-60f2-893e3a9e0ecd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Manaf,

On 12/15/24 20:02, Manaf Meethalavalappu Pallikunhi wrote:
> 
> Hi Daniel,

[ ... ]

>> -static bool thermal_thresholds_handle_raising(struct list_head 
>> *thresholds, int temperature,
>> -                          int last_temperature, int *low, int *high)
>> +static bool thermal_thresholds_handle_dropping(struct list_head 
>> *thresholds, int temperature,
>> +                           int last_temperature)
>>   {
>>       struct user_threshold *t;
>> -    list_for_each_entry(t, thresholds, list_node) {
>> -        if (__thermal_threshold_is_crossed(t, temperature, 
>> last_temperature,
>> -                           THERMAL_THRESHOLD_WAY_UP, low, high))
>> +    list_for_each_entry_reverse(t, thresholds, list_node) {
>> +
>> +        if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
>> +            continue;
>> +
>> +        if (temperature < t->temperature &&
>> +            last_temperature >= t->temperature)
>>               return true;
> 
> Currently WAY_UP notification triggers if temperature is greater than or 
> equal to t-> temperature, but for WAY_DOWN
> 
> it is only checking temperature is less than t->temperature. Why don't 
> we include temperature = t->temperature
> 
> for WAY_DOWN threshold ? In that case it will be consistent for both 
> WAY_UP and WAY_DOWN notification for userspace.
> 
> If we are not considering 'equal to' for WAY_DOWN, there is a 
> possibility of missing WAY_DOWN notification if a sensor
> 
> is violated with same WAY_DOWN threshold temperature and only interrupt 
> mode is enabled for that sensor.

You are right, we should detect when the temperature is lesser or equal 
to the threshold to be crossed the way down.

I'll send a V2 with this condition fixed.

Thanks for reporting this

>>       }
>>       return false;
>>   }
>> -static bool thermal_thresholds_handle_dropping(struct list_head 
>> *thresholds, int temperature,
>> -                           int last_temperature, int *low, int *high)
>> +static void thermal_threshold_find_boundaries(struct list_head 
>> *thresholds, int temperature,
>> +                          int *low, int *high)
>>   {
>>       struct user_threshold *t;
>> -    list_for_each_entry_reverse(t, thresholds, list_node) {
>> -        if (__thermal_threshold_is_crossed(t, temperature, 
>> last_temperature,
>> -                           THERMAL_THRESHOLD_WAY_DOWN, low, high))
>> -            return true;
>> +    list_for_each_entry(t, thresholds, list_node) {
>> +        if (temperature < t->temperature &&
>> +            (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
>> +            *high > t->temperature)
>> +            *high = t->temperature;
>>       }
>> -    return false;
>> +    list_for_each_entry_reverse(t, thresholds, list_node) {
>> +        if (temperature > t->temperature &&
>> +            (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
>> +            *low < t->temperature)
>> +            *low = t->temperature;
>> +    }
>>   }
>>   void thermal_thresholds_handle(struct thermal_zone_device *tz, int 
>> *low, int *high)
>> @@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct 
>> thermal_zone_device *tz, int *low, int *hi
>>       lockdep_assert_held(&tz->lock);
>> +    thermal_threshold_find_boundaries(thresholds, temperature, low, 
>> high);
>> +
>>       /*
>>        * We need a second update in order to detect a threshold being 
>> crossed
>>        */
>> @@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct 
>> thermal_zone_device *tz, int *low, int *hi
>>        * - decreased : thresholds are crossed the way down
>>        */
>>       if (temperature > last_temperature) {
>> -        if (thermal_thresholds_handle_raising(thresholds, temperature,
>> -                              last_temperature, low, high))
>> +        if (thermal_thresholds_handle_raising(thresholds,
>> +                              temperature, last_temperature))
>>               thermal_notify_threshold_up(tz);
>>       } else {
>> -        if (thermal_thresholds_handle_dropping(thresholds, temperature,
>> -                               last_temperature, low, high))
>> +        if (thermal_thresholds_handle_dropping(thresholds,
>> +                               temperature, last_temperature))
>>               thermal_notify_threshold_down(tz);
>>       }
>>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

