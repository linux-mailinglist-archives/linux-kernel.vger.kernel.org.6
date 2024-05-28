Return-Path: <linux-kernel+bounces-192553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D188D1F11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3FD282755
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E40216FF47;
	Tue, 28 May 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDSsP+kw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4B16F902;
	Tue, 28 May 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907323; cv=none; b=JnwN+olYfjydvbF6dhwemFpVXuIdjl89Kwz4p445Ynoihs3MAyq0evAb5viwgi0P0wE0Pk5F5lMiDZHbyyvSWLQCpg+ItpmS0StX8H7L3O9cmC9tjRglVo7fRy53aKwkV60LQALt285FXJyJwv1yA1Ahp2KwIM5LxFaFZnnUi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907323; c=relaxed/simple;
	bh=QgJSLXZGe0qlpBeKLSw+1lC4N7RyOs/wsWEb4dnk5Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHktGgIhw7XguN+YCska4hKJsC4hLqtT5NX4Nl2qA3/7p5ClToPZHlWdNDhP3U/5INuUErTdwIhdq0GZCD9D+pUlSIddyJ9FpQTq0FZbbORdgC3VmD2o/9f4ERl3nq8fvOtZN6d0vr8jE12m45srNg55uDCwwsMFRiWUdKLOeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDSsP+kw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e21742025aso36837539f.2;
        Tue, 28 May 2024 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907321; x=1717512121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qBE/9reFq7+HeyJeefXN1kWYDIvALdK7oU2JxBzrhQo=;
        b=ZDSsP+kwkFbGOEY5OceG7jv+i8DdVAIHb8Dl6ptutAAlmY+T32epgfoGZo0B9zB4Rj
         w5ns/KG313U2w9ZCbGWk4jX4Yq2C9avB/VNxQExQ84uP18v1zBuFu7JkB5iu0yYobwV4
         pUXw6VZ+vENCXCxJiPB2s7p6ZJTMIdfvkcZPX2wDkzsOnKyv3Ax610lTFXmL1ONuaolG
         Z0qvIVPZ5koxIzZk+CeUBeUydiP66QyFu4pNn16NdzTBRJs4HI5rnVrBQVa/Fe5P4PcE
         soHhXyp4LZKZXxbJmWkXZ6K89hj/U0Yg4RnvKwr09S3tVSuUVgVTjGsH5E5RSYA87rrl
         d29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907321; x=1717512121;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBE/9reFq7+HeyJeefXN1kWYDIvALdK7oU2JxBzrhQo=;
        b=db4TB7H8oYpwIYYa07E1Sf+xpLg2A6u68egXzbXJyBVcek90OZ0BKYuV3TdL9HVjxS
         Qj7rpNz+YDo2HDZLXzS/9U10TG6U6cUlY88/F+UDjTD5mtvQgsu/iZVYzadeNlw+JASv
         FRWDuxy8KgdXzzP+1ANi+TTplS1Ub1AVVOPihtx52t4nRh3Ok4xNY2RgntcGgFlbbwVT
         mlMZZahDx5jVpJ/EJ2TIHWd2szGZr8DSatMRZBRzhee2KTZpP1XOx1wZweGqKL3y+FAh
         YdcMgEokLo3p0PKVo4xohYIp0TIpL1uYZu2fPx1JPxDBl4ahAGVPSc3N/6WKjFfDSCom
         KEuA==
X-Forwarded-Encrypted: i=1; AJvYcCUd50RgW5UucDKnfxDlE3Kx1EAd70f4Rz4uBfH6OiJcsnEmBQ2c9l3WyO492t+AQRmNMfif/JSKRpwujeB1jzHZCdJSDnUMDgtD8b/1JY8kYsR5t4LnI0+ChjmlCfpDfbUsUo4Rx1PLX7CG7JdXtfHkt7TYdRHtoCe6oWzltrZfgo2ONq1S
X-Gm-Message-State: AOJu0YwZI7WLuzYrLAMuelgb8yEdlmRm9XwaXWump7PDsq/ISIoEGxux
	pVzBjlDhtysEzdGrapyNvRHREf0B1NSwKASBI2wGQUAE2QXJgHN4PTNTiA==
X-Google-Smtp-Source: AGHT+IEDnc6oH8qUV8WZxPOPRi1MBFGakGOMq33AV9Wnc2bXtNTEb7xzlOzBi/dUWt0gm2deWfm8Fw==
X-Received: by 2002:a5e:924a:0:b0:7e7:2c84:1369 with SMTP id ca18e2360f4ac-7e8c75d35bcmr1176543939f.21.1716907321396;
        Tue, 28 May 2024 07:42:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b093e79850sm1825865173.162.2024.05.28.07.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 07:42:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c11900ec-dd03-43b7-916a-dc7315bb50b5@roeck-us.net>
Date: Tue, 28 May 2024 07:41:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: Add max6639
To: Conor Dooley <conor@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528125122.1129986-1-naresh.solanki@9elements.com>
 <20240528-frame-liqueur-7f37ecc0dad1@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240528-frame-liqueur-7f37ecc0dad1@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 07:26, Conor Dooley wrote:
> On Tue, May 28, 2024 at 06:21:21PM +0530, Naresh Solanki wrote:
>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>> monitor with PWM fan-speed controller.
> 
> Other than unneeded |s where your descriptions don't have any
> formatting, this patch looks fine. That said - where's your dts or your
> driver? A binding on its own is unusual.
> 

The driver is drivers/hwmon/max6639.c which needs other unrelated changes/
cleanups. Holding those up until the bindings are accepted would not make
sense, so my guess is that Naresh decided to pursue the other changes for now
and add devicetree support to the driver after the devicetree properties
have been approved. On the other side, adding devicetree support does depend
on the other changes, so trying to do that before the other changes are
complete would be difficult.

That is just my guess, though, and I am ok with it.

Thanks,
Guenter


