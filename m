Return-Path: <linux-kernel+bounces-389983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864C9B7412
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0B1C217C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B613C3C2;
	Thu, 31 Oct 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2T3f2DD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523110E0;
	Thu, 31 Oct 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351568; cv=none; b=LxYyUKm2VaaF1RzPqNQUPIepD4+m1jizE72FwQak7zk46do8kBDfZnJMJsEMJJzBhUj5BV/Xz3gnGRFnDXBC95b3DSXnDAg9zzZYg8krCv/Tnm6gzzbhzjcAhhJgk6T1geJYdugkjteBWzFftmMhMua/RXTIQbqjFXZ/GlM0nOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351568; c=relaxed/simple;
	bh=rKRs4RMaV7ZYdPAxsh3Y35b83oPr0CxoawlcmXBgjH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHARYNOCNS3Wm33dow3bw8vTX+TIbx4UUOxUGVNet3V0VPIHYgA6pI2G5ZYWXlYhyBONOdfQFfT9G36sVu92R3GuyYsSQi62GULlcj4+9BYPB7ddwsn/9Aa3nTFWdjh+QFnS6l13qerQ9ECzUqK8Moe7aG9viwHWCwD2Tk0HgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2T3f2DD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20caea61132so4874165ad.2;
        Wed, 30 Oct 2024 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730351566; x=1730956366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+IKijJ8th6Jf7L6fRWOc3OMVlfJfb6IC9neZnlBTKHE=;
        b=V2T3f2DDrVabWV2VXnR7jzNquwe40wDdr+NXIbXI7FYqvzg5YtIX1ju9+DZ8ej5r/h
         7IJOhqo89Yx5A3bJyM0yCvf0uHIlGfN/NjrpcYe7xLkB9mSL/RbWxDsHx7nWnNG7lwX3
         53YJ1THXyCbhCXJ9hO7cpIwubl7AodDX5jHZ0ArupgZRyt2P9FOcQvpaUaI9B24l9ETQ
         j1/mjlXwMhPT6wNKM/wXlW0KdMQPHbd+WOtH9EKeBDfMSQGaTXzv3Ufp+QT9Jl4CCO0v
         ofAoCL78e3XK53OsahRMwIom7z8MxLMm33rFmNBWXEBPZOJPNV8tH0iLhx4CkKx6pase
         CSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730351566; x=1730956366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IKijJ8th6Jf7L6fRWOc3OMVlfJfb6IC9neZnlBTKHE=;
        b=DVFr2pfJ1x3CzuJbxDZ3zI6RK5UINsnzZvHdHNEFY7LEQ7+WS8L+niCE+d+8oIpfW9
         bNa65fnyARkuw1hOke8bVLlzhELc9qxTzuSrrPyvAseT1rJR36adpCMNk2vUT1HrPQ96
         qVnIm5M1/VqbvjFKMYhT/eur/Xg1CFja/dy9m1QIG9+Pwz4NkqClbbBr6RH/ZWfEJSqv
         zjqTbyqOa28VwI7KiXjhM4anvFsMLVi7txu0gScfSzQ6EUi5+Nh3CPsZUVoGa9Y4aqgh
         znCrOVbRETJPvUi50ga6bOfxkVFejYOiAmumNwRLHJ+a90WaMRcqITa48iptcGWPFs9M
         kzHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEyCquy7bqhO/1KQGJKKfe8x1rAHpO4EjK+HJtRgoHlAhtsHF3QG7fEXtEYmY3loR5Dg4EC3oyC9Cj9Q==@vger.kernel.org, AJvYcCWQSk7A4XElZcremBoLX/18YU07lbGubpwvXGVYJywB2VTDyWTr5HV1tVu5U8pn+gidOjs8mdr8kzlyklcF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5k+7B1mWFKZrLTITpzjlWgMQqdzy0GMT/uGIlZQNccxpqTawY
	7X/ZX6NY+LSh2foevyKOTUdmt2QpgOodLRVekp6f2R4fcuL+6v+YINy2wQ==
X-Google-Smtp-Source: AGHT+IELcMV4CyJLwtSXsF5Wzp7AocaD5YvxOfq4pp9qyimDeemJgC6UeUD94mySln9LA7AQRiNerg==
X-Received: by 2002:a17:902:f685:b0:206:c486:4c4c with SMTP id d9443c01a7336-210c6ccc4fcmr253424305ad.57.1730351565754;
        Wed, 30 Oct 2024 22:12:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed995sm3685805ad.39.2024.10.30.22.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 22:12:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bdfab2dd-5273-4a9b-aa11-209ad7c5676e@roeck-us.net>
Date: Wed, 30 Oct 2024 22:12:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: module nct6775 reporting wrong values after resume from suspend
To: M3 <mys3lf@protonmail.com>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "christian@heusel.eu" <christian@heusel.eu>
References: <H72gIiX824bcqCLZswVX0V1dfbF-tiUMcWeoPM6-EzxaqNQQNaVn9NPsuDJ0_wyOxhf3gfiIUBtR-L9fEEvpnFWMzDHHyePvTBvl1xfiCeo=@protonmail.com>
 <193d6c42-7e0b-49c9-9e95-db458d4baaa7@roeck-us.net>
 <4HSarOaep_et3LczEcUF4Lh9A_pdubxt7V6hoFo6p58U1g122wUcZkg0qZ-_mCgWOntT1KpU3n1nRSGEaNTt2WfWiuMUo61rfkxQAB36OTc=@protonmail.com>
 <f7deecc7-cb88-4de9-942d-5db9fa903707@roeck-us.net>
 <Z5-0Xhu6ktFbb5Qqlw0q2sShCgCm2SPAZvnyReOZI3jZ7HbCZmFXgiI4kzVDABv9E5B-KkvgQpf6OEyHkaSHq3AEG6NsyU7rGKtbd7GVY7Q=@protonmail.com>
 <8c86b8b1-55db-43e1-a1ab-4b65905f7f05@roeck-us.net>
 <f37xE-WxXY0daAFO1Mi_Q_7IxzSWn2u29oqeJ2v7io0Gt_Ta6HS4P6P-bps1aendiUo6ivNsbPKvl38f7uaSeNrhE_6ZFj56PcYSI572L9E=@protonmail.com>
 <8d4f8eb5-e74f-4fe2-a103-2093939b3662@roeck-us.net>
 <mnheUmdqjrbjzj_b0GKn0aEWPg2bcHoTaIfMuzpeLYS1skS3zXlJ-zfeFlCLg5k94y4U49t-m9LqXsJEcIwjU9-XWKUhOsJo9na_KI_kYkY=@protonmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <mnheUmdqjrbjzj_b0GKn0aEWPg2bcHoTaIfMuzpeLYS1skS3zXlJ-zfeFlCLg5k94y4U49t-m9LqXsJEcIwjU9-XWKUhOsJo9na_KI_kYkY=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 21:47, M3 wrote:
> I cannot offer insight to an impact. Actual or possible.
> When I reported the issue to archlinux forum (https://bbs.archlinux.org/viewtopic.php?id=300507) the fan rpm had also dropped by ~20% but it is not reproducible every time.
> If you take a look at the link you will immediately observe the rpm differences. It is not what you asked (grep) but the fans are revving slower.
> 
> So my concern is whether this leads to an overheating of the box?
> 
> If you think it is of minor importance, I guess we can drop it.
> By no means do I want to occupy your valuable time.
> 

Based on the data you provided, I don't think there is any danger of overheating.
The fan speed differences are minor. Hard to say for sure, though, since you'd
need to run a test under load and see how the temperatures and fan speeds change.

Guenter


