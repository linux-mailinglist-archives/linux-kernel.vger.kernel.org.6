Return-Path: <linux-kernel+bounces-557742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B2A5DD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9C57A3ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B60242909;
	Wed, 12 Mar 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UXjPB7/H"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF623E229
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783978; cv=none; b=aupNOrXk0+AH2GygQH/58I3NXqjGD7twyrYEe3pjT6uG5wMxAnx6BWCG2Sp4pzCiEsQeljz4rDdDYUw6pAkEZloIu2PUNo15lyZbPQdO1eZqHpWwwd2YKvJ3Aysolvp6CkCJI2I0dlXZYiIqoM/yJgc+StxmXDRZoRMZifio1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783978; c=relaxed/simple;
	bh=5rdqHm/hfFwO48Z86rVwrj13dZQxv9WSdmFYfx6EHNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvRbW9mgTuWDeqrYmTXNfbuf9Gf46rBPHsen/wL7DcLWuRAOGz9S4QIC7sm+B0uxdinsX+lizmGX/+Er4/ECl1Ydt/kdFUnjfoPzgUBMhSI5DAf6G8PHpz8QtWQeoyrswv6biGXhO5/y0uyWExC1h2GL/61j8jOWrMKwgtZGmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UXjPB7/H; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1853562f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741783975; x=1742388775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nwgfY0bA7bSuiMHyspTu5vv4LRFssjPln36pp6aa5Co=;
        b=UXjPB7/HAQGr8niR7jE70o/gJ2kY3ANYQlIaiDc5Pcm9+JjjT//9XMVmnMjg1gGZPT
         /6A2RGxXoXFJ1S8Uz+e1FGkBln4gTIVpCdK0P60XgCR90FHeT4HzKpBrgwzbwtbMnJy+
         4V9r4RZK+mJ3CM9UUw1aWTSIE2w8aFBlpD7ajHTco7ZWVkSWbl2aSoDohM4SwrynNtUZ
         DZEfqJfKpNnAoT0/0EWtJPr6I1/9UJEph1AOpu7bCXS6XWMg/eUQAn0gMaxMe9QasZxl
         wgAy3//yE2+A93BH1z2WWwbEah7MRFdqsQV0Q9fRPTuuPFwLQyHLR4mMrB1xuTiACtxh
         Cklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783975; x=1742388775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwgfY0bA7bSuiMHyspTu5vv4LRFssjPln36pp6aa5Co=;
        b=bIrFvnpzVcqjKBwTbilXd9ioLGNU1vRLI53cIdayVaeR0JWJnjVFvRceCkVZZJiKEa
         Dtw+NZXtUjx0GpHluH7y+SAMzILsV01O/G2WMiWD/M+Lwp81abscL/4vBShf6Ki3zRy4
         mdRI4kPhlTn9GJ8qGxlaGAejz2KwGPpTjRD6cpVNKRXd5Cly52RVTe1MDf5TVCUtwTdv
         i82CaKbt3WLN5BtOKQr0b6xEHpghkwRjbJMPHyEIwHL3PgI6vO9BIq9iSxaxGr++Neyk
         5QDsis70JQUpEvHCL17FlL/nu79DO95dGy7AYwQfrB1lp2yOEzEht3Oz+olz4zpRe88c
         51MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8O3PSUrnHiy9+3LGKw1Bi761Y2vSBLDZAgMmXacSmPX/M8Wo8p+QF1KVcu02fb1ZSRmh6TtB8ED7dErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5ERHWfxZ0WbvJzXVmORhgl+LT4ijX7uO8gi7xbILxPuTTY2E
	lyJOI7ZQ+fujAXXNWKF9HX2Xx5ayLK5ReL65xYYvEDFOQAljZD2uAXyBHnXjf5U=
X-Gm-Gg: ASbGncsTqRejJmutGk18IKTzbuz9g8tuN8RYZm9QFAKaMqHhSCLBJESg37h3XhI9pve
	09GAVDxiwrzAiYl7OdMPSonSRwRFf+eDEMG8MG0wMTra+96JxRUcyY2dQd6uYaGySfMo4uCxGmB
	+uZpIy76xtXCmSU259iaby2WO8kMXWNFQRDjOkxTumDETKy5dX0fVQwOCIkQLUFY+hbhNhRFR01
	ZgpL/t79VTmEU93OCdQETfH+toWKFUfechs3fcUAtoakkjCGjO9NQDANnyWHejnGwnBdwYr4j6o
	koqSfvs2AVRw9IGuINr0oIzTLRpi2teBcKqRD1u7Fu92HLk3fMxnAAR67mbObGWP2ySZcN7Gk5b
	T
X-Google-Smtp-Source: AGHT+IFoNwU6jrRyqYUKTwKTf0luECKdhiR/vKm+lodvkimjAahJBv9bVwtF43mm4/BByxpK4rSIQw==
X-Received: by 2002:a5d:47a7:0:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-39132da905cmr14902396f8f.49.1741783974656;
        Wed, 12 Mar 2025 05:52:54 -0700 (PDT)
Received: from [192.168.0.19] (81.172.62.104.dyn.user.ono.com. [81.172.62.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015a29sm20599776f8f.42.2025.03.12.05.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:52:54 -0700 (PDT)
Message-ID: <31f8a6a7-7f12-43ca-a4cd-4fef1ab9f0fc@suse.com>
Date: Wed, 12 Mar 2025 13:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550
 board
To: Conor Dooley <conor@kernel.org>,
 Matthias Brugger <matthias.bgg@kernel.org>
Cc: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Min Lin <linmin@eswincomputing.com>,
 Pritesh Patel <pritesh.patel@einfochips.com>, Yangyu Chen
 <cyy@cyyself.name>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Kanak Shilledar <kanakshilledar@gmail.com>,
 Darshan Prajapati <darshan.prajapati@einfochips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner
 <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>, rafal@milecki.pl,
 Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
 <Z9F3_Zb4RvHLvgSd@ziggy.stardust>
 <20250312-unloving-shamrock-babbedab8cbe@spud>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250312-unloving-shamrock-babbedab8cbe@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/2025 13:50, Conor Dooley wrote:
> On Wed, Mar 12, 2025 at 01:03:09PM +0100, Matthias Brugger wrote:
>> On Tue, Mar 11, 2025 at 01:04:26PM +0530, Pinkesh Vaghela wrote:
>>> From: Pritesh Patel <pritesh.patel@einfochips.com>
>>>
>>> Add DT binding documentation for the ESWIN EIC7700 SoC and
>>> HiFive Premier P550 Board
>>>
>>> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
>>> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>>> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
>>> ---
>>>   .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
>>>   MAINTAINERS                                   |  6 ++++
>>>   2 files changed, 35 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/eswin.yaml b/Documentation/devicetree/bindings/riscv/eswin.yaml
>>> new file mode 100644
>>> index 000000000000..c603c45eef22
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/eswin.yaml
>>> @@ -0,0 +1,29 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/riscv/eswin.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ESWIN SoC-based boards
>>> +
>>> +maintainers:
>>> +  - Min Lin <linmin@eswincomputing.com>
>>> +  - Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
>>> +  - Pritesh Patel <pritesh.patel@einfochips.com>
>>> +
>>> +description:
>>> +  ESWIN SoC-based boards
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - sifive,hifive-premier-p550
>>> +          - const: eswin,eic7700
>>
>> That should be the other way around. You could have, let's say eic7701
>> with different peripherals but smae p550 IP core. I don't expect a new
>> eic7700 with a CPU IP other then p550.
> 
> No, this is correct. The SoC is made by Eswin (eic7700) and the board
> (hifive premier) by SiFive. None of the compatibles listed here are for
> the IP core.
> 
> If there's another SoC with different peripherals and the same p550 IP
> core, I would expect a new SoC compatible /and/ a new board compatible.
> 

Right I mixed up CPU IP core and SoC, so:

Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>

