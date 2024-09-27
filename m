Return-Path: <linux-kernel+bounces-341365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDD987F10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E628108A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C817B4E1;
	Fri, 27 Sep 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW4CN03d"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12560EAC6;
	Fri, 27 Sep 2024 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420493; cv=none; b=ao5OyEt3Sv+Iie4Z4f0ckb58l/V9jf2M3aF7DtMokhUXag9O1K6QMlAfn7zRdboA//Mt5KRjLbxVWelVYIU6KDyExYw2K67bYpubTlRp/wQHUMZF/0ge4fMyj2iPrPzuZINZg/wCcJQfUfc1f2Qvdlo7sQ8EXtRrz8edfxVQZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420493; c=relaxed/simple;
	bh=pC+SZ7IuPOXYKEhnkVTG5Yc/eakcEmyueegWfdV4+UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnWCWDKkLf2GsttHt3566rgAyqZjgwuemf6gF3yP3fBdTgWI+r5LOhn7zv2HYFsE6w7/SyUT7uYPVo75TdxDF5ut6Z9J8MNvAJJTt8Co5+wmN/xZr/SXGUdiixqTRl1A9q2m/xHGLGYTMGVynslmmKZm5cpd3ZyM3DWZL6wesaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW4CN03d; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b3e1a27f7so199135ad.1;
        Fri, 27 Sep 2024 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727420491; x=1728025291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+D9+o7G/ymDOGKu4SCSQIvGmuHtAwpUMqlXkM3YB6M=;
        b=jW4CN03dMYwZ4Bn8SZv+DoJ7KfiWsofhm181bybJqda3DSGQSgMmMPedToVrv6XKcd
         xRST7V09p4zjusXAnUqPhuDiqSMTxNHyo1Y3O7X4joPOU0pp3veHxyIQe4OHfaIodHbR
         LMZwP/P2aMCB3E8bwGSMphNrsMDYxeM9KYwI30h/U9wOfH+l4tduylHstUL8IXWKk7vI
         +Bzj8yr52578PawD3yZgPippS0Ps4xDkLFChUS4d3N3GU4i1lQjJinNwR08l21QI4tdi
         nHAlv+q2Zso+fsKfC7mbUHGnJqmbELpwvuWiuo9WacmROkGe59IGeCuvFSKb0jx3Ue93
         kPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420491; x=1728025291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+D9+o7G/ymDOGKu4SCSQIvGmuHtAwpUMqlXkM3YB6M=;
        b=gPPEqYqNw8WsPSQmQThJ/3N0l95b0r52wkTBoZOeZ/hwmLL75txX5/qQqR6Ui7Ycj4
         tph+TGxvj+PWuGeR+Tp2UdCD/yc2emG740gfQ2Zf38mDFDz8VR5Z5KhKMqkeJE0OVoDt
         QwMg4f1G0+6KASQy0vVCbmSHbcuVdVCCjqUEIKWX7emtu9n6JUZ4fhvYtwl9tOO+Jw75
         aC4n9WhgjPSz4k/65eJbX5QQYq1RhQmgjBs6oVllGDjLcIpX5ZDjhpk//R2anrG+4kv3
         vJAADEWhYFb6H//4Ym7v1sSd8QEptcqDRAEO0Bbm5bkmZ0svelW1d3y+2UdfJMOJCQ+a
         4Q3w==
X-Forwarded-Encrypted: i=1; AJvYcCVO05mcNmM55ALSigEB9AG32mqCN6iy+9WVi/lfRWjYOfnvT/f9sBBTUZg2ztVv5B4ekoOv+OTcWpTsYHkx@vger.kernel.org, AJvYcCWjoFlToYmvGBudgp+CoXhzDXHyIoomyARxQ1yNfVOQTEuduFs4Il1kSp4LV5y1H3uXPPt1NU97YV+k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+RvcQmYu1s20lVHx4unYS2JNOFQ+VH+VMYyVwRupkYirOOfH
	5GegKoJfiWgODXsDjAGEUENqoKyP878ToqRit8BI79aXUlWO4Md+
X-Google-Smtp-Source: AGHT+IGkAxYW8GNPQCEuaiab18J3qC/gbPLDVKzyTDXDfndAX4vGC/veXCZ5MM/mKbk8GhIbnrPXGA==
X-Received: by 2002:a05:6a00:3d0d:b0:717:9406:c1be with SMTP id d2e1a72fcca58-71b25f0b1efmr1655641b3a.1.1727420491214;
        Fri, 27 Sep 2024 00:01:31 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b7decsm939078b3a.47.2024.09.27.00.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:01:30 -0700 (PDT)
Message-ID: <7944f4dd-96f0-40df-8c91-523409e3cb20@gmail.com>
Date: Fri, 27 Sep 2024 15:01:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240926103223.29538-1-frawang.cn@gmail.com>
 <ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 2024/9/26 22:19, Krzysztof Kozlowski wrote:
> On 26/09/2024 12:32, Frank Wang wrote:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rockchip,rk3576-usb2phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
> Read one more time the example I gave you. Top-level constraints are
> saying max one clock.
>
> Best regards,
> Krzysztof
>

Sorry for overlooking this, I will set both "clocks" and "clock-names" 
to true, and add the else case below the above codes for the "old" SoCs.
Just like the below.

-  clocks:
-    maxItems: 1
+  clocks: true

-  clock-names:
-    const: phyclk
+  clock-names: true

    assigned-clocks:
      description:
@@ -189,6 +187,13 @@ allOf:
              - const: phyclk
              - const: aclk
              - const: aclk_slv
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: phyclk
+


Best regards,
Frank

