Return-Path: <linux-kernel+bounces-576527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3EA71077
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D313F3BA28C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A018C337;
	Wed, 26 Mar 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWj8dig+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331918DB1F;
	Wed, 26 Mar 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969712; cv=none; b=sAbAv6WQaMPD/UKm1PMhFxYbxkb8dtBuHQawEGEyjVoAKZSLgwLts4jB4/tcmkAglQTmhwwfiLtyJfOpuyDXrpVRwx0M6hmUP6kfI0qd45huIQV9EV4F+YVgfUzzObbU8g7hN3icx5+98iuBA+j6zDipfDK0dXseDWSwe5OClUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969712; c=relaxed/simple;
	bh=GSeRjK4NcXpmWTkp+8hsV3XcE6bnjzemLGV6KNKky6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7cAKyOaKNb4Wj3JgsTRfU1G8ZxTVrDaETRjcVwiOtFSXuMsY+xgyLQpL3JamXm9r5Jigbsi9iiu+G47DF5SdwqCSn9DE2f7wC0yDTMR8Cb8CgMTiQdMGl8W9rs/rpQumEkTVYQJH/VikjypiDkyGt77KBS+vEOFkVesdMJlcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWj8dig+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so6431553e87.1;
        Tue, 25 Mar 2025 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742969709; x=1743574509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5G09pEcYe7jjM/U/eQ+1aZPEYDUfuYgQeF/Axfe18Y=;
        b=lWj8dig+GTxKQ6GETvM3TSIMdT4s49QlM9ZRnPPqXS1cnEsa8D87YPkrb77I6MBkH/
         hY6ZsFmedSD7nyLJczi7Av9IRLicN27m6mpk/yxhYCZBzSWn3aSA4addcpDDkNT1ckpX
         KXqf920zUzKX+QlOdmuNQA6F/+WWAm1ePajRzBuTp6+gC5Bebp6xf3wdPbw1VkcsThpu
         o0D99FuMmMy5KlnDm2ejFnuLLR27nZ4zXew2D1c7ewgwhBYj9gwFZu5kod5KbHizjO7n
         Nxs4LFHupbfrU/8hj2ENqSShWBE9i0NVA3bfAF2yM1FLjohzkcIUYWHQNmSXCwHTyGnX
         TYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969709; x=1743574509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5G09pEcYe7jjM/U/eQ+1aZPEYDUfuYgQeF/Axfe18Y=;
        b=GRbq5bxQ8oUzRHbYIT/c2AbMK26kzuvvnogLeKcBLIEzwkNdxiR51pPf9ul2OmiSkB
         jZZ8TgJPkquIXB5MPFwqoJpYz09HO1AX3UZBGgGtorIeaVayrutY+CN9YQPzXBNBdFF3
         d4kXex6JNoq6u8bjHGehXW0VQOpcEOtlTDJYq3fUd8VUA2mJWsscn8W6TahaJJqulTTQ
         6RgEtC96bNo2CK4WIL0nVvBp+9F2UC/tnbg+nB3Av42tGecP74TfI2rtBFLqo/nG7Y42
         fWNCrU8MfI6qG3Zl+3q7b8aYlSqt62rywKGwuyqtfu95yuab6o+30wN5xLRv3xkmRNFs
         C+DA==
X-Forwarded-Encrypted: i=1; AJvYcCUFV7kBa6RYBs1EPm3xGnncXOfhfAPw7opTrDhzTY0Cr0O03FceFWA5HnfmdrIyJ2cgApGYcpiNo14H@vger.kernel.org, AJvYcCUgCp3LkrUeqb1WEf8AwJEGW1b9STXlcrz9HDPV72sJ4Z1/op3HR9/ET3lLZ6a9yDU/BVPO1q1wZq+BYehI@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVRFkHStEgG4e+Zh+dg75FuofnnQysPrJpyuVXlEUzBPHtdJ6
	PysvTuM8fLbQTNEaHwIfU7wW+jIUDWiP7qCS9uWZVbdKqcPgpQiO
X-Gm-Gg: ASbGnct0WrHMNqITHU4DWoOEcOEaSXYUCHXhMwPPUixpbxtJFmsv1XQZNRHrck7hB0L
	Il804t9zyhWYJYdxILAZFht4LffRbrhYJlDAFuTgGCJkKzM9XrQqsDmZFxNRqg7MO2xb44B++Na
	rJGMWrV/RYKer/FNWYFRY7ejCT+ZiDM/raQgyEbKBZTEzH4yTuQ+L5pt83CP0xKY0mK/SHIk2O9
	lP76c5KUZORWHqecYj9EAognYvsQ7n4gwje6ut1L3W1CEoWE/T4WXAzMQTGSXDkUfO+n3PXJmNy
	OERa1B61KpMpYvnVCqhKu+ifhdwT4T2Q+DlU/ZKgW8HzFl4PvgCnwz+ZfO70TXnNqu5H6SIXSqk
	/kBAlMeRkv2SlrvfXSJG1tfR4lg==
X-Google-Smtp-Source: AGHT+IGgOeKXTv0dECYLW0Ci0Ftj19836lNGNZSo+8tjtne5kWhfChjdK46NnPAtITMub2+/mKZZew==
X-Received: by 2002:a05:6512:1152:b0:545:2f9f:5f6a with SMTP id 2adb3069b0e04-54ad647e35cmr6415218e87.14.1742969708783;
        Tue, 25 Mar 2025 23:15:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6508374sm1736802e87.191.2025.03.25.23.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 23:15:08 -0700 (PDT)
Message-ID: <f8b0553d-d74d-47c5-89f1-6c61ed0951bc@gmail.com>
Date: Wed, 26 Mar 2025 08:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] dt-bindings: regulator: Add ROHM BD96802 PMIC
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <2cb4d103d011f0d4293f6ef9307cef57709263d9.1742802856.git.mazziesaccount@gmail.com>
 <20250325-universe-jigsaw-61da10ad3f77@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250325-universe-jigsaw-61da10ad3f77@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

Thanks for taking a look at this :)

On 25/03/2025 19:23, Conor Dooley wrote:
> On Mon, Mar 24, 2025 at 10:54:44AM +0200, Matti Vaittinen wrote:
>> BD96802Qxx-C is an automotive grade configurable Power Management
>> Integrated Circuit supporting Functional Safety features for application
>> processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides two
>> interrupt lines and has two controllable buck regulators.
>>
>> The BD96802 belongs to the family of ROHM Scalable PMICs and is intended
>> to be used as a companion PMIC for the BD96801.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v1 => :
>>    - No changes
>> ---
>>   .../regulator/rohm,bd96802-regulator.yaml     | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.yaml
>> new file mode 100644
>> index 000000000000..671eaf1096d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/rohm,bd96802-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BD96802 Power Management Integrated Circuit regulators
>> +
>> +maintainers:
>> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>> +
>> +description:
>> +  This module is part of the ROHM BD96802 MFD device. For more details
>> +  see Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml.
>> +
>> +  The regulator controller is represented as a sub-node of the PMIC node
>> +  on the device tree.
>> +
>> +  Regulator nodes should be named to buck1 and buck2.
> 
> Is it really needed to add a new binding for this, rather than including
> it in the mfd binding,

A valid question. I did this because that's what I've used with all the 
other PMIC's regulator bindings. All of these have MFD counterpart:

rohm,bd71815-regulator.yaml
rohm,bd71828-regulator.yaml
rohm,bd71837-regulator.yaml
rohm,bd71847-regulator.yaml
rohm,bd9576-regulator.yaml
rohm,bd96801-regulator.yaml

Basically, none of the MFD bindings I've written for ROHM PMICs contain 
the regulator descriptions.

The thing is that users might be used to look for the regulator bindings 
from the regulator folder. I'd like to keep this consistent, especially 
with the BD96801 because the BD96802 is intended to be used together 
with it. (BD96802 is used as a companion PMIC for the BD96801 to extend 
it's capabilities).

> particularly when this isn't actually a binding
> for the regulator but the pattern section applies to the mfd.

Hmmm? I am not sure I understand what you mean here. I know I am really 
bad with the YAML and bindings, but if I read correctly what I've copied 
- the pattern section describes what is inside the 'regulators' node. I 
think this is similar to what we have with the rest of the ROHM PMIC 
bindings. Should they all be somehow modified?

Yours,
	-- Matti

