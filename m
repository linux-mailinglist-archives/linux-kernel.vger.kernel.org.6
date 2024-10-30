Return-Path: <linux-kernel+bounces-389131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE659B68EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B63B21484
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAB212F1D;
	Wed, 30 Oct 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRktTGwD"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE26433D5;
	Wed, 30 Oct 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304540; cv=none; b=ChsczyxtJLVwp8VdPeBB41rIn85iZvStYcBNX7qrJQROf6bmWChzZoWMjlX6BXUbVsJmVCoga/4FXF+zWiL4c/VCtNA9ANK2q7LDqwHf0zdQKZuHRQrlvs0tqaJyHPDz1RTcJ8H9ooP3KtlLafR8woUWdDJ6XnQPgTvZgh4lPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304540; c=relaxed/simple;
	bh=WK/PDQsVE8XxzhU2Ue02elUf0F/7IO1gPYfu79CDo28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyV8K1t67mjyBmsOnnoQsq59clJSmIChkBFMZOmP6/JTuXEN7l1g+0hewA4LTBxKieuH6jdqwt6zBJ3whlRySXGEJAaNWrNyTHtTfpWmWnmQXSkyT8DU9a/iRnjYM7Zdfds50/aLVb/U/KDDC4J4x66xju48WPPwpH2VSiznss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRktTGwD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c6f492d2dso133235ad.0;
        Wed, 30 Oct 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304537; x=1730909337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NMxmiwoonIE7zumtjOj49GJyMNEmIZcjAS1rv8/qLMU=;
        b=hRktTGwDOFWd5vhGi3+HnF+iCAdx5KxLEtsjJNVuRybwvIntnkMoSDet35b9TQoSPR
         8OM2SqprnX1mUucXFhGuElN024t3FFcAUEPVmFxB9jRjlMRPgxT7R/urfqJ93mtviq/5
         wpkkpK9LHm9WvxV+3NADvdEv3odQkt2gJbjDNG5aHhlQfhMbC0yVI2Y9VM0bKpBMGhmU
         7w9p+Ax9xbO7C9Vej4H007PtqhUUV7GAysY52yyPtv9EZ9FhtHxDQ5i2clOucxPzvdF7
         W8uYe98K4xLWdA2tv3/clRqQ8p8XcF+SgwNCy7NPv+zzHzn9UBKbRvsGCjdmJ80ONgWL
         MH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304537; x=1730909337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMxmiwoonIE7zumtjOj49GJyMNEmIZcjAS1rv8/qLMU=;
        b=ngSNxDgNN1qwFKw9pdw6q9kn9cYGIdBn/HFVlBCsiuJqk90JM6knHtdH/WM5rEmrHn
         Mdt+9zPcjQnzVV26Cd6LZhA8r1dm9Z/Ll3IttQ5FIYdJu+FEbFlTYtY8wtrb7Exv6Zu6
         JqZFxxslYwbfD40zHwwNlV5A4XHHrH5P8noT6IoRXDFo5t1+x2LymWsrjEfvji1gP+Za
         Sb2TdaSvaAterVLezUIcaihLcMWdVoiaIATjleixlXUhEw5uJhtbUfASf87ZdTp9QcT/
         Y0Tlmuw+MbQD4gkyamCn6bBNpQeHRxtK/ERr7jjjchaHVrj0dnTQs8uc5qKxz+w93V6x
         FPHw==
X-Forwarded-Encrypted: i=1; AJvYcCVYhWCSVIDgGGIdthLHlyYeMcne6nGnRCzyCRcvJEEFnKNXxoY+thoyMELDQp/Bv0R+AcRg6Tt7BADQGLqe@vger.kernel.org, AJvYcCXarFKuCl0Ylyas28PXUnpDBmUKBvjGQ5DPgXbPZDGFzV46GN6TVoRHH+zKRzcWxkUmUZ+JsWLFRAVTSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ln1QHFuodaP2v+Yc7Ql7pr6p7QqRtPNFjGCBYVwvJmmqroda
	ohzJQJvrsU571z9/npXtcklXo6/fj22albun2Y919GCaSaemg3EJht2lsw==
X-Google-Smtp-Source: AGHT+IEkaHlG9+DDF9+d53lMy+lqt886Gl5ZahBnXM+D3+IuR+S8nUne1JNB+sKOKENvoakPXB5Mzw==
X-Received: by 2002:a17:903:2283:b0:20c:8331:cb6e with SMTP id d9443c01a7336-210c68c951cmr239806965ad.19.1730304537211;
        Wed, 30 Oct 2024 09:08:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf87bcbsm82516955ad.115.2024.10.30.09.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:08:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <193d6c42-7e0b-49c9-9e95-db458d4baaa7@roeck-us.net>
Date: Wed, 30 Oct 2024 09:08:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: module nct6775 reporting wrong values after resume from suspend
To: M3 <mys3lf@protonmail.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "christian@heusel.eu" <christian@heusel.eu>
References: <H72gIiX824bcqCLZswVX0V1dfbF-tiUMcWeoPM6-EzxaqNQQNaVn9NPsuDJ0_wyOxhf3gfiIUBtR-L9fEEvpnFWMzDHHyePvTBvl1xfiCeo=@protonmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <H72gIiX824bcqCLZswVX0V1dfbF-tiUMcWeoPM6-EzxaqNQQNaVn9NPsuDJ0_wyOxhf3gfiIUBtR-L9fEEvpnFWMzDHHyePvTBvl1xfiCeo=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/24 08:36, M3 wrote:
[ ... ]

> sensors reporting before systemctl suspend
> 
> 
> $ sensors nct6798-isa-02a0
> 
> 
> nct6798-isa-02a0
> Adapter: ISA adapter
> CPU Fan:            1162 RPM  (min =    0 RPM)
> Chassis Front Fan1:  495 RPM  (min =    0 RPM)
> Chassis Rear Fan:    491 RPM  (min =    0 RPM)
> Chassis Front Fan2:  742 RPM  (min =    0 RPM)
> Motherboard: *+30.0°C*  (high = +80.0°C, hyst = +75.0°C)
>                                (crit = +100.0°C)  sensor = thermistor
> 
> ----------
> sensors reporting after resume from suspend (fan rpm's are now similar)
> 
> $ sensors nct6798-isa-02a0
> 
> 
> nct6798-isa-02a0
> Adapter: ISA adapter
> CPU Fan:            1165 RPM  (min =    0 RPM)
> Chassis Front Fan1:  494 RPM  (min =    0 RPM)
> Chassis Rear Fan:    510 RPM  (min =    0 RPM)
> Chassis Front Fan2:  716 RPM  (min =    0 RPM)
> Motherboard: *+21.0°C*  (high = +80.0°C, hyst = +75.0°C)
>                                (crit = +100.0°C)  sensor = thermistor
> 

It is impossible to say what might be wrong from this information. Any chance to provide
output from hwmon device attributes (from sys/class/hwmon/hwmonX/) from before and after
re-loading the module ?

Guenter


