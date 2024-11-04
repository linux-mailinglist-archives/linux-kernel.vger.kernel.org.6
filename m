Return-Path: <linux-kernel+bounces-395492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F939BBEB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE32282D88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089461E2607;
	Mon,  4 Nov 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMzEf9z3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735C1E2009;
	Mon,  4 Nov 2024 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751604; cv=none; b=d/wBYeqeG7uGyAEnRdijD9O+nDHzJBwiF3ni9xnrYG1yxtuC549wF3LibMQTOTb80B5FZQi3FGLy7Gtq7o0oJjsPubOnANFqVFZT4PY+jo7lDCoZ+bf3Hj+/0Yx+HZjwN0qyT3FKcFP2t9czymoYPNaXV5KgnJGrm1HcpU0R134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751604; c=relaxed/simple;
	bh=6Jp9yG5p7UiSdTlXFk9u6GiJfG9huE/XkPl6MVC9k/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zh+3BSg/ps7vEWV+vAfe/ijaQoE5sf+1Tb6bUbEek74aOg6VHs3b+bOpUJwxgWfKxUq3aOUizzUU8eucm5nssCIT8CozKj7RKvcjc1u8j9LJopNJagWFBnzUQSYEJ5ibNWpKKid+GhCSJN50tXUYbJj6MdRiqMlfYcIWSpGrjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMzEf9z3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso5651692a12.0;
        Mon, 04 Nov 2024 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730751600; x=1731356400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PL5KkaHYcHYSWz5JR4tNjnJI/ZRJgGAc7HAWIuIWV80=;
        b=XMzEf9z3IpqccXe17yLvMgH4uK40A0F2Y9gRpA16CqiBR7DYbCx/Qie3cNLbz+n+NT
         41p3XiY9E6zDXcIpC27S9oNcpWW84mVFZIkNFBLnJptnzkSL+tGHUWpzhIvz1tNzXt5X
         1lURZqI5+D0HV34XxBKYJac+PRnh5og1F23HuwpRsone8HgrlXyhA2Y3ua8TQXbj8RtH
         FEG2C93ZgfVWiIM1TbDn4MRqo8c6W9foa92ldC/Yj1vwCL9bcWIRjpVYtbr7ADuWKX6J
         ZeWBAtJl8HKjhX5MRd0YQvhjYnPnkEdHou0GXKDJhf3RqS1OZdGdtxVGvUqtD093wJkA
         s55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730751600; x=1731356400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PL5KkaHYcHYSWz5JR4tNjnJI/ZRJgGAc7HAWIuIWV80=;
        b=Lzx5jV+Vnfx9dhZ+klVHRUKfNkQHE1CxeJkZupFhfoTyQ3tL9W+2JyJT1DDiSECNsj
         hdgpmnbIQBR9IQCddXGRnq2LgQVbAujYyOSwsmeY8IuRAvvSeAhoYXUhXZzUOGEkuiEC
         gFKpAthWDztmO/Eku6Fvf4hrlBAA9vgb1IPlB1AgdjEIyVKATT56y7rmhddIVt0AhRYn
         tpTWIMTB0qs9gglKM7N5Pmq/VvalWP0dTENxNxvW2QuVMy/4unKeF/iBUZxYk4WNkwLP
         17D93cx9K8L7CP4HBSc0Qi8ROaXZqON5kCevfIXgG5uFgkPoMoUdkGUwad2bkNpJOreQ
         TSKA==
X-Forwarded-Encrypted: i=1; AJvYcCULm/Moc1G80ftxE8nmrPCHjgxZDJX03n/ts9iang8W368IrykK4YfB8gr0qAjXcEfVJeCzDVoxvvyqWSHQ@vger.kernel.org, AJvYcCVQF7XI7sJEV/tqCf+5bI6YuQTjd/gkN3OjkO2oW58XlOVHlgezXAfyTyLp4q1YmSbdMtYCD0h8LRzb@vger.kernel.org, AJvYcCWQjEkc0uugVdF8sVhqfxIwTq/kWD4N7W/G32mGXXQily/MQGxbhesl7hN/kSYmEWw00vC1P5Bpbv14@vger.kernel.org
X-Gm-Message-State: AOJu0YykQ7eoGhNF+uQzu154Ms4bqTVriG2BsdfXagbNNb510rSJoFUZ
	P9Dkhk0KpW9enQFGbDoIG20aOLInJs42V15lGK+tQXSNLRpLKz3z0loAfw==
X-Google-Smtp-Source: AGHT+IHXtRvhD5B7CEvemZJBPO8ju1v/PqOpVbjDT5dKTYG9+66K5/OIGPeiwGURsAWbNapVtBB1DQ==
X-Received: by 2002:a05:6402:2753:b0:5c9:62c3:e7fd with SMTP id 4fb4d7f45d1cf-5cbbf8b1d2emr28411216a12.16.1730751599818;
        Mon, 04 Nov 2024 12:19:59 -0800 (PST)
Received: from [192.168.1.102] (miroral.stz.ddns.bulsat.com. [91.139.249.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ac08c9sm259291a12.42.2024.11.04.12.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 12:19:59 -0800 (PST)
Message-ID: <0198082e-19a2-48e8-ada1-a7edaeddb73c@gmail.com>
Date: Mon, 4 Nov 2024 22:19:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: clock: actions,owl-cmu: convert to YAML
To: Conor Dooley <conor@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241104153108.3053932-1-ivo.ivanov.ivanov1@gmail.com>
 <20241104-lend-lark-ab46a268213a@spud>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20241104-lend-lark-ab46a268213a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




On 11/4/24 21:03, Conor Dooley wrote:
> On Mon, Nov 04, 2024 at 05:31:08PM +0200, Ivaylo Ivanov wrote:
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
> FWIW, you could drop these two if...

I see, although the point of this was to keep it the example as close
to the original usage in s900.dtsi as possible. Anyways, if a v2 is
needed, I can do that.

Thanks for the review!
Best regards, Ivo.

>
>> +        cmu: clock-controller@e0160000 {
>> +          compatible = "actions,s900-cmu";
>> +          reg = <0x0 0xe0160000 0x0 0x1000>;
> ...you dropped the 0x0s from here.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.


