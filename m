Return-Path: <linux-kernel+bounces-380349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38BA9AECB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77691C21E33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3B1F81B9;
	Thu, 24 Oct 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiWk+83h"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4531D63E5;
	Thu, 24 Oct 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788909; cv=none; b=Qdt9vWa8piqoFBkyeZk6OFRnmSBfx4xNaFphCreAqzoZ0Ez15u2tYZ9962Jsq0OTp4iKXNFFoRQ9Uopn0nNnpw/VAuc8zBUSLzX0t/BXXnK/upQCqLx3BpmIndF5G3nnjgZpj83yRRiy8WF3zLxOfC2eoek2P95UOaFQW3Ho+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788909; c=relaxed/simple;
	bh=a8ahRRcrY594S4Mt9NvQKGbibrLN5Ofloy8eC4cJUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0EFiG8aL1ruyQQ6CvB4Xau5dvHlQGUJEhJjq24OrLC89MSu3rvjJh4ALAMECGcDWsxFVGvZaqYA5mMuMoPVaDHohzxoIdbvBx+hnYbM9PHvAInz5NZrAygUX1FLuDsl/QJz/mib7XnJzhPm6kMPLQfy0/T2kpkvF148BmmcY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiWk+83h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so896151a91.2;
        Thu, 24 Oct 2024 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788906; x=1730393706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d7PBxxlBiwJrhbNFRgnIYKYzTkgRlcrjAX2t06Ip96w=;
        b=iiWk+83hgsbjVKcIcnrf8Sasb59VNnpcbvLT78mwcq+aN+kbZu1qos07lT+wBY4omE
         LbsfH7TF71siQpiqQyauLvDBbfgP70WqRh3B8nr7PTa1kAdlXouBunJzQHMfBI8f9uDB
         Kj2OIIjFMW+6ynrtEATpAjGXaZgEyVeQQ/OTvOSWyYdwcjYrL/6jstfrVpoatnclfPud
         jPyYuWCh5fdBbnWxBbm+vDhDEl4LYy/J3rBIUNUrCFkLkGbIvtLqXf+nhq2PSxFPE4Wz
         2VbWehaOpcaJm9IvTJK5GA1Q+dzO6zzVN0zYXCN7aUw1e+sNk17CK+C+8NIV9ziaABKA
         jzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788906; x=1730393706;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7PBxxlBiwJrhbNFRgnIYKYzTkgRlcrjAX2t06Ip96w=;
        b=qZDLnMkmGNjhKEujHx/E6KtKsGUI3eBazlHvB1qKKW+w5hYBI0IUUZpsI9map3gCOS
         sHoHGpUyi13+krO4h+2XzupgQqPRNRCBLBrjynH/xh2snv5ztFv25WFdZuQxP5lHPpph
         ZqGo9iIMKnlvhWsGct5ryp75rbhTFb3VPyihsEs+XaKuR8+yYFcCRV2KJ4ZUBQhDjwXd
         F6gjOUazzrqS1cAtptJvUozw9gUa4G8W6vSYoNn5Wk/BTnbwn1vUPk+1Yomn4Jw0qvH9
         +yujKgE1mTXdeI6sYCMRmfMzLFdRr4CUCcnjj6V0kbItA7Dypwhq27OPEm60Qva+mv5c
         XM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1PCv4C/jNZbZX5UIEiVWP/s3aYQsaxvw/FEQguTM/QQacieoY472jO2f/YsBruLRleVA11uDCDeLjMA==@vger.kernel.org, AJvYcCUMsCbJQXbCLzdU70cqACPM3QzWMdtoNESB54Lkk6fl2nIFssXjuw0O9ImosAZXEyu1OtOBysV2C+wpkyNI@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhroPKBPDFWJIixJEXF/RnssT4QBQdG3/miPl/oy0b7ajO8E1
	gIshI0sAA2ap/6M2fCEj3fUhyW/6j/9Oz4n9aFGTpJzyjWpXiM76
X-Google-Smtp-Source: AGHT+IF7mz4K47c5JjT4sJY07QawDK9gtl9POxdES20/c+qKG0W0YJ1aSNy6XEBJZYGdtMcIX/XH/Q==
X-Received: by 2002:a17:90a:c7d5:b0:2e2:9e64:c481 with SMTP id 98e67ed59e1d1-2e76b60c552mr7153085a91.22.1729788906484;
        Thu, 24 Oct 2024 09:55:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48d008sm1748531a91.0.2024.10.24.09.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:55:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e028943e-2acb-4b19-b2eb-dd603855b3a8@roeck-us.net>
Date: Thu, 24 Oct 2024 09:55:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: modified ina2xx to match SY24655
To: Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
 <20241024083055.82047-1-wenliang202407@163.com>
 <20241024083055.82047-2-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241024083055.82047-2-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 01:30, Wenliang wrote:
> Adding Silergy's sy24655 as an adapter chip for Ina2xx drivers.
> 
> Because it is similar to INA226, the supply voltage and pin definitions
> are the same. It also supports IIC communication, with only two
> additional registers added for configuring and calculating average power.
> 

Again, please consult
	Documentation/process/submitting-patches.rst
for both description and subject.

"dt-bindings: Add SY24655 to ina2xx devicetree bindings" or similar
would be a much better subject, and something like

"SY24655 is similar to INA226. Its supply voltage and pin definitions
are therefore the same. Compared to INA226, SY24655 has two additional
registers for configuring and calculating average power."

would be a much better patch description.

Also, as already requested by Conor, please copy the devicetree mailing list
on devicetree patches to enable automated testing.

Thanks,
Guenter

> Signed-off-by: Wenliang <wenliang202407@163.com>
> ---
>   Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index 6ae961732e6b..05a9cb36cd82 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -20,6 +20,7 @@ description: |
>   properties:
>     compatible:
>       enum:
> +      - silergy,sy24655
>         - ti,ina209
>         - ti,ina219
>         - ti,ina220


