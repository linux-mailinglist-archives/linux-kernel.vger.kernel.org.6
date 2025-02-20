Return-Path: <linux-kernel+bounces-523798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D86A3DB64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB75A19C1FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AF1F63FE;
	Thu, 20 Feb 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaQyaKRS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E61EEE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058474; cv=none; b=UzGxXEPnGDtGVgTIoGwsldoOugXpvnIJ65VXYcvENezjUbLf4yqHx3LHo344+KhhFqc0cJUz6EItEGeRY5iDtto6mEOYan4nUNAqpQmFxBRMzrUY0pfvoGjR3ZmLxyNGQGbvabnvETE5QcxpE2jVuAfu9RM4EZfgj7jUt/zXPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058474; c=relaxed/simple;
	bh=mbjhWxn0gIHkhae6KcA0uGmiFtPWrkCHtVNUiezRsh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhmyXuwLF66CSiXSAG87U8k1I0kRO8LCp1012ErgvJs4lWa8TCZzDXN+3K3us9a+h349L9jTmAdseAgh7H94fQlgkA3gWkLgYrIjG3NYhrMnJ5us0pRq3QY6jvfozt8uJ27UvQR5lB4dMSnzkZLXflECL0GmhZV6qMTZdjI6tis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaQyaKRS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpe9Quo1s+SP9DnKsSoyHLlxt0k91X+LXCmw4gTOOKE=;
	b=LaQyaKRSyBnOLwpPg6lzSymaSwbSPKTtTkxdcIDMzgZ/UMnBkAB/dJ5m5FXrik+DFi9g9s
	FtxXm3LPsv6FrsRMKme5D/vCHYyuQMP0a7r4UxDvh7rfAjOJBrljHfGtFGB9geBo8TT+4j
	o9wJzVYXxfjGX6jKRrglwcf8vEkXZNE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-byZAl5pDMSWg3rgzbWDKkg-1; Thu, 20 Feb 2025 08:34:30 -0500
X-MC-Unique: byZAl5pDMSWg3rgzbWDKkg-1
X-Mimecast-MFC-AGG-ID: byZAl5pDMSWg3rgzbWDKkg_1740058469
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5dc5b397109so708605a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058468; x=1740663268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpe9Quo1s+SP9DnKsSoyHLlxt0k91X+LXCmw4gTOOKE=;
        b=wVQTkXBOqiTMHLRoQGLHUk1gmYv3RBn58493FYx2hp3I95Ml+zkx1opd6+hwieJg0v
         LN9FfdmocxjPsPaN3fr1q+I4i+yL0Q8fXMZ5vmfQb7qN0vyAGRSCXHAovAioEeTTUSlU
         LKSrRnIc8bfYv3NQ1KwbBSV2CLaS7hWoI48cLJOo7nFT9fcCf4XnICbStZCZOkQoqZev
         LgczDViD7dkGFwa2kWVBvJVKCyS65bT3IbKuYseyGpQLScBo1OT6J5sjNxTUYViN16DR
         zIL/56pYAVreuwZK4zB7gRntmfnXE/68TaGFtMe9uJzVrCuSwd/tuE+LaGiD8k5LPNTm
         qJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCX1Mb5vitiShIEKBIGxShIrMlvqRXi8RCjTDp9R3G1fDel2bs4hY0DYGOJIVnPN6/gtTWaDSHez7IA9yvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s7JH4fNdFgbabPMOLlggaQUBzrl+pNd5cRckbk+e1mykssot
	QMq/ExQlEY7HLE/XmdV9xIIcUE6X3dXSLfFFRXWZUfbTVyplKSrsshgl6zSPO/d9qh34QckRYVC
	tISUa5DsTljc/pNGzy0m42zdqtPS6gaFKWEqsoQ7GXNECbHIB/MJxKneABFqrvd8gYrGdkA==
X-Gm-Gg: ASbGncuwKlZsSii63WiARekTIJvFzys5slw1kA34q0OA4NrDDbkK4C7A/kWS27JHpuz
	qPoUj3nymeSLpvZ6nw7tqu+iILLfczxArtphZe432y88mu6uRjrq9UA8cxNjMJAoa+16WLlrm+U
	A841YzgHlO+qzV/lwNo+4XyzBWT+r7SJTJTSqdlj0CrpOfALCsWrukSRug0SeMbUcsVkRR2XcEv
	IE1+vWOvRJEHX0YHKbBtZP0O1gaTIKqd6RjwwhROxW/CbdRSu7yLQCsD2SwP+dVS4NaTGPlDEYJ
	cbIqoQY1pGFM+fFQHWl3CUHbcZW7UopvlZjx3uPrHDbAvobCUY1JQODZttbS9OjugGWMbqwxkLx
	Q6m5Vm6c+iPubKa2DobmBaa7I7YH5jwsSN8LlDSGFyfCTBZVZUwGjnXw=
X-Received: by 2002:a05:6402:50c8:b0:5dc:a44d:36bd with SMTP id 4fb4d7f45d1cf-5e089521896mr6687203a12.8.1740058468228;
        Thu, 20 Feb 2025 05:34:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrMMvpdIYDE0hc305IFelUzPFSffEQITX4Pg3cxW3iLkAuxxVeDMxJdbM0acd4ZLXs4W5Idg==
X-Received: by 2002:a05:6402:50c8:b0:5dc:a44d:36bd with SMTP id 4fb4d7f45d1cf-5e089521896mr6687181a12.8.1740058467789;
        Thu, 20 Feb 2025 05:34:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm12058464a12.58.2025.02.20.05.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:34:26 -0800 (PST)
Message-ID: <80041ba8-0791-488e-a2d6-f66ac6c51393@redhat.com>
Date: Thu, 20 Feb 2025 14:34:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] leds: Fix LED_OFF brightness race
To: Remi Pommarel <repk@triplefau.lt>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <19c81177059dab7b656c42063958011a8e4d1a66.1740050412.git.repk@triplefau.lt>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <19c81177059dab7b656c42063958011a8e4d1a66.1740050412.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20-Feb-25 12:23 PM, Remi Pommarel wrote:
> While commit fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
> successfully forces led_set_brightness() to be called with LED_OFF at
> least once when switching from blinking to LED on state so that
> hw-blinking can be disabled, another race remains. Indeed in
> led_set_brightness(LED_OFF) followed by led_set_brightness(any)
> scenario the following CPU scheduling can happen:
> 
>     CPU0                                     CPU1
>     ----                                     ----
>  set_brightness_delayed() {
>    test_and_clear_bit(BRIGHTNESS_OFF)
>                                          led_set_brightness(LED_OFF) {
>                                            set_bit(BRIGHTNESS_OFF)
> 					   queue_work()
>                                          }
>                                          led_set_brightness(any) {
>                                            set_bit(BRIGHTNESS)
> 					   queue_work() //already queued
>                                          }
>    test_and_clear_bit(BRIGHTNESS)
>      /* LED set with brightness any */
>  }
> 
>  /* From previous CPU1 queue_work() */
>  set_brightness_delayed() {
>    test_and_clear_bit(BRIGHTNESS_OFF)
>      /* LED turned off */
>    test_and_clear_bit(BRIGHTNESS)
>      /* Clear from previous run, LED remains off */
> 
> In that case the led_set_brightness(LED_OFF)/led_set_brightness(any)
> sequence will be effectively executed in reverse order and LED will
> remain off.
> 
> With the introduction of commit 32360bf6a5d4 ("leds: Introduce ordered
> workqueue for LEDs events instead of system_wq") the race is easier to
> trigger as sysfs brightness configuration does not wait for
> set_brightness_delayed() work to finish (flush_work() removal).
> 
> Use delayed_set_value to optionnally re-configure brightness after a
> LED_OFF. That way a LED state could be configured more that once but
> final state will always be as expected. Ensure that delayed_set_value
> modification is seen before set_bit() using smp_mb__before_atomic().
> 
> Fixes: fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> Changes for v1 to v2:
>   - Use smp_mb__before_atomic().

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/leds/led-core.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index f6c46d2e5276..e3d8ddcff567 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -159,8 +159,19 @@ static void set_brightness_delayed(struct work_struct *ws)
>  	 * before this work item runs once. To make sure this works properly
>  	 * handle LED_SET_BRIGHTNESS_OFF first.
>  	 */
> -	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags))
> +	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags)) {
>  		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
> +		/*
> +		 * The consecutives led_set_brightness(LED_OFF),
> +		 * led_set_brightness(LED_FULL) could have been executed out of
> +		 * order (LED_FULL first), if the work_flags has been set
> +		 * between LED_SET_BRIGHTNESS_OFF and LED_SET_BRIGHTNESS of this
> +		 * work. To avoid ending with the LED turned off, turn the LED
> +		 * on again.
> +		 */
> +		if (led_cdev->delayed_set_value != LED_OFF)
> +			set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
> +	}
>  
>  	if (test_and_clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags))
>  		set_brightness_delayed_set_brightness(led_cdev, led_cdev->delayed_set_value);
> @@ -331,10 +342,13 @@ void led_set_brightness_nopm(struct led_classdev *led_cdev, unsigned int value)
>  	 * change is done immediately afterwards (before the work runs),
>  	 * it uses a separate work_flag.
>  	 */
> -	if (value) {
> -		led_cdev->delayed_set_value = value;
> +	led_cdev->delayed_set_value = value;
> +	/* Ensure delayed_set_value is seen before work_flags modification */
> +	smp_mb__before_atomic();
> +
> +	if (value)
>  		set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
> -	} else {
> +	else {
>  		clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
>  		clear_bit(LED_SET_BLINK, &led_cdev->work_flags);
>  		set_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags);


