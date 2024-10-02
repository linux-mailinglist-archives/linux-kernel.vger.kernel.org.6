Return-Path: <linux-kernel+bounces-347248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF498D010
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BE1C217F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23684A52;
	Wed,  2 Oct 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jvv5M8Bz"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4D197552
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861077; cv=none; b=J+mVe/cGwSpSGXlShQBJo5q+KUgudPSwnntXM57qAsDeZFcJYHL2AQNnwM2E7r+EvRdPMB/SGBG9sRJrL0km/myTMrMrsgzZfvQyR3Hs0aMw2jLKgDspD5xWvNnkLJHvE6sriKId3Ny6jyAM1WmTLlWRXQv/FNxbw6awd+PYpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861077; c=relaxed/simple;
	bh=5tdafRAdLK0oIBYYVT7xfiC+whm8uPYCWSy4/LdlLak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ru1rO7XhtWr/JCky+oaLs9Gq5fNY00M3sc3tBKdeyjjdvVG3uZ02u7aCuEVlfePq/uWxA/+DH622fsf/w4wzbdcP9uoF3d5hx/sC4/Hy9ZaSXoDkrg757bahcKCu2ETcsWH/J7coRs8hdmnAgmoGMIWF2YzmO9jMcFRQH9j5NyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jvv5M8Bz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241002092426euoutp01beb4c1fc81053a9af5336e8922d2a56a~6mHxQk-eu3000430004euoutp01e
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:24:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241002092426euoutp01beb4c1fc81053a9af5336e8922d2a56a~6mHxQk-eu3000430004euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727861066;
	bh=1U7egJ7LbKzZwYSY1X4bBzjJjiFlq4zkuJWtnr9dngY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jvv5M8Bz/YRXTzmaZzoGpBSumuPHyEKPh1BeaQxXPg2J7wTIuLwgUeIkgpQ8+WSLf
	 /zs0h1ayb5nmjdDd59HWk3QCg2oAn6e9FZWnRb131zlXmZ+zJnuWbd2JD1s6EHBH0D
	 GcCScStksOxZKDQJruLbvWuOW4cVDU9DBeDI5cQY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241002092426eucas1p14d411214bb4d41b0297a65ae83706ff5~6mHwsPs8o2285822858eucas1p1f;
	Wed,  2 Oct 2024 09:24:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.77.09875.9411DF66; Wed,  2
	Oct 2024 10:24:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241002092425eucas1p142aea4a8ae6b7133591806b4f6131dc6~6mHwK8miS0133601336eucas1p1P;
	Wed,  2 Oct 2024 09:24:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241002092425eusmtrp140ff75c6e072acf6300b45f776681b61~6mHwJ6AYr2678826788eusmtrp10;
	Wed,  2 Oct 2024 09:24:25 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-37-66fd11490525
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.48.19096.9411DF66; Wed,  2
	Oct 2024 10:24:25 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241002092424eusmtip2c7f6459fc39cd3ef55cf225f8b76d455~6mHvcGCYl0586105861eusmtip2F;
	Wed,  2 Oct 2024 09:24:24 +0000 (GMT)
Message-ID: <4b258df1-b4aa-45c4-8bb8-7ac014a7b470@samsung.com>
Date: Wed, 2 Oct 2024 11:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/3] dt-bindings: mailbox: Add
 thead,th1520-mailbox bindings
To: Rob Herring <robh@kernel.org>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20240927223227.GA152909-robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7qegn/TDJ5/tLTY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shdoNjlHmaLtln8Fv/3
	7GC3aNk/hcWBz+PNy5csHoc7vrB77Jx1l91j06pONo/NS+o9WtYeY/J4v+8qm0ffllWMHpea
	r7N7fN4kF8AVxWWTkpqTWZZapG+XwJXRO2EVa8FF3Ypj236zNjBOV+li5OSQEDCR6Jn9ja2L
	kYtDSGAFo8Sp1ZvYIZwvjBJdt+awQDifGSU+TDnF1MXIAdZy6IM8RHw5o8TBU3NZIZy3jBJH
	2qYxgczlFbCTuNq6jg2kgUVAReLTJTGIsKDEyZlPWEBsUQF5ifu3ZrCD2MICkRJrpk4Ai4sI
	KEr8bpsGNpNZYBeTxL3WPWAzmQXEJW49mQ9mswkYSTxYPp8VxOYUMJN41zudHaJGXmL72znM
	IM0SAts5JVafW8cK8aiLxLs7m9khbGGJV8e3QNkyEqcn97BA2PkSD7Z+YoawayR29hyHsq0l
	7pz7BfYMs4CmxPpd+hBhR4m2/0fZIYHCJ3HjrSDECXwSk7ZNZ4YI80p0tAlBVKtJTO3phVt6
	bsU2pgmMSrOQQmUWkidnIXlmFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQKT
	3ul/x7/sYFz+6qPeIUYmDsZDjBIczEoivPcO/UwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqua
	Ip8qJJCeWJKanZpakFoEk2Xi4JRqYJorsUPs8sd5uuLBc9+eWuv17/BP7dc3uMrWd6svUJrz
	4HXK3tCc6uoD/N5y7qKzT88zyaj4nuRn0t5+XoXNO8Jok+PWBclWfPNDnZ3Tzz5YsDvhwpLl
	02NCbb0viE6OY5vWlcnwVZ7dqI/rT5vh4TkvY96G/I3Z+fAQp0TP4w13jvotFtnko5Z2bnum
	ypuppvG7nbpdbX0Up0ptYti8qjohLUlL1eD/mWNrbpYYRG76M2tbpO1n7itNv15PEja60lTJ
	OXvWcePDmva/zxj63vVb817mw3RTMR7Ts8+/Xpq3zWJ5b/TskxM2bWTXXNz7YoWGUdrL7SzB
	py7siVXrbmVadPL+yi3RJ1scBHktLh5UYinOSDTUYi4qTgQABA6sGukDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7qegn/TDPY8kLXY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shdoNjlHmaLtln8Fv/3
	7GC3aNk/hcWBz+PNy5csHoc7vrB77Jx1l91j06pONo/NS+o9WtYeY/J4v+8qm0ffllWMHpea
	r7N7fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
	pG+XoJfRO2EVa8FF3Ypj236zNjBOV+li5OCQEDCROPRBvouRi0NIYCmjxOmDN9i6GDmB4jIS
	17pfskDYwhJ/rnWxQRS9ZpSYcWItWBGvgJ3E1dZ1bCCDWARUJD5dEoMIC0qcnPkErFdUQF7i
	/q0Z7CC2sECkxLJPl8BaRQQUJX63TWMFmckssItJ4tD3PVALvjJKvDnezwpSxSwgLnHryXwm
	EJtNwEjiwfL5YHFOATOJd73T2UEWMwuoS6yfJwRRLi+x/e0c5gmMQrOQ3DELyaRZCB2zkHQs
	YGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjl24793LKDceWrj3qHGJk4GA8xSnAwK4nw
	3jv0M02INyWxsiq1KD++qDQntfgQoykwKCYyS4km5wPTTF5JvKGZgamhiZmlgamlmbGSOC/b
	lfNpQgLpiSWp2ampBalFMH1MHJxSDUx6349Isva1cHwN2nN5T8GqwP93rfbfLWhdtZ+/T9L6
	/GSut7LRTVaZOe93Oqcf5jRp1/9dNsfGbQJfyJHpCxQW5V6tmiXItMKtkPljgFeEnGXfD5X2
	w5WXPOsFXnumC1Y1S/8/+DPXrnaCVYCfa3/HZgfFaG5t5UPuR3QPHVm359S9ENMVHQlRXYde
	bW2KSvComzDF4+khlnPLNM8oH9URXXG5++ZWgx+dYZPivj3dtLvf6Un62wUqCdns9hV7D89y
	PcH3vTBK4r9TKm/fDR7GJ3tWcHK9OLw7XPPsFS6udMfJ7fFB2Xu/d+XuZjt5t3x2Z8HVqUnz
	W/ZbnIl/eHf/g6kLzxsGzf0q7XHo6i8lluKMREMt5qLiRACykBG1ewMAAA==
X-CMS-MailID: 20241002092425eucas1p142aea4a8ae6b7133591806b4f6131dc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240927094215eucas1p1be4d58084ff19e47450dcad3e6da5f5e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240927094215eucas1p1be4d58084ff19e47450dcad3e6da5f5e
References: <20240927094207.1650085-1-m.wilczynski@samsung.com>
	<CGME20240927094215eucas1p1be4d58084ff19e47450dcad3e6da5f5e@eucas1p1.samsung.com>
	<20240927094207.1650085-3-m.wilczynski@samsung.com>
	<20240927223227.GA152909-robh@kernel.org>



On 9/28/24 00:32, Rob Herring wrote:
> On Fri, Sep 27, 2024 at 11:42:06AM +0200, Michal Wilczynski wrote:
>> Add bindings for the mailbox controller. This work is based on the vendor
>> kernel. [1]
>>
>> Link: https://protect2.fireeye.com/v1/url?k=5f89eff9-3e02facf-5f8864b6-74fe485cbff1-fe45b64bcc1d1a7f&q=1&e=ed6b721a-b6ae-4d7a-b1bf-4e0a7691061d&u=https%3A%2F%2Fgithub.com%2Frevyos%2Fthead-kernel.git [1]
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../bindings/mailbox/thead,th1520-mbox.yaml   | 84 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 85 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>> new file mode 100644
>> index 000000000000..b517d0c6eb12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=b15f6a95-d0d47fa3-b15ee1da-74fe485cbff1-a74b5ef04b0a5478&q=1&e=ed6b721a-b6ae-4d7a-b1bf-4e0a7691061d&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fmailbox%2Fthead%2Cth1520-mbox.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=8bf885f9-ea7390cf-8bf90eb6-74fe485cbff1-894b0d9aad275d0d&q=1&e=ed6b721a-b6ae-4d7a-b1bf-4e0a7691061d&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: T-head TH1520 Mailbox Controller
>> +
>> +description:
>> +  The T-head mailbox controller enables communication and coordination between
>> +  cores within the SoC by passing messages (e.g., data, status, and control)
>> +  through mailbox channels. It also allows one core to signal another processor
>> +  using interrupts via the Interrupt Controller Unit (ICU).
>> +
>> +maintainers:
>> +  - Michal Wilczynski <m.wilczynski@samsung.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: thead,th1520-mbox
>> +
>> +  reg:
>> +    items:
>> +      - description: Mailbox local base address
>> +      - description: Remote ICU 0 base address
>> +      - description: Remote ICU 1 base address
>> +      - description: Remote ICU 2 base address
>> +
>> +  reg-names:
>> +    items:
>> +      - const: local
>> +      - const: remote-icu0
>> +      - const: remote-icu1
>> +      - const: remote-icu2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  thead,icu-cpu-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
> 
> Don't need '|' if no formatting.
> 
>> +      CPU ID associated with the Interrupt Controller Unit (ICU). This ID should
>> +      correspond to a valid CPU core in the system. The value must be between 0
>> +      and (N - 1), where N is the total number of CPU cores in the SoC.
>> +    minimum: 0
>> +    maximum: 3
> 
> The normal way we associate a node with some subset of CPUs is the 
> 'cpus' property linking to the CPU node.
> 
> Or is this CPUs which are not part of what Linux is running on (i.e. the 
> SMP cores).

Well, for now, the only use case is talking to the processors which are not
managed by the Linux kernel, specifically to the E902 core, which helps with
power management and is able to power up the GPU power island.

The T-head manual states: "For the four CPU cores of C910T, E902, C906, and
C910R in this chip, there are four MBOX units whose corresponding CPU_IDX
are 0, 1, 2, and 3 respectively."

But on my system - the LicheePi 4A there are four C910T SMP cores on which
Linux is running, and those all share the same CPU_IDX of 0.

So using the cpu or cpus property wouldn't be correct here. I could drop the
thead,icu-cpu-id property altogether, as for now the only viable value of it
would be 0, and just hard-code the 0 in the driver as well.

> 
>> +
>> +  '#mbox-cells':
>> +    const: 2
>> +    description: |
>> +      Specifies the number of cells needed to encode the mailbox specifier.
>> +      The mailbox specifier consists of two cells:
>> +        - The first cell is the destination CPU ID.
>> +        - The second cell is the mailbox channel ID.
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - thead,icu-cpu-id
>> +  - '#mbox-cells'
>> +
>> +examples:
>> +  - |
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +      mailbox@ffffc38000 {
>> +        compatible = "thead,th1520-mbox";
>> +        reg = <0xff 0xffc38000 0x0 0x4000>,
>> +              <0xff 0xffc44000 0x0 0x1000>,
>> +              <0xff 0xffc4c000 0x0 0x1000>,
>> +              <0xff 0xffc54000 0x0 0x1000>;
>> +        reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
>> +        interrupts = <28>;
>> +        thead,icu-cpu-id = <0>;
>> +        #mbox-cells = <2>;
>> +      };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index df4d7be6cf35..a6028f850a25 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19943,6 +19943,7 @@ L:	linux-riscv@lists.infradead.org
>>  S:	Maintained
>>  T:	git https://protect2.fireeye.com/v1/url?k=b8a28277-d9299741-b8a30938-74fe485cbff1-54d1d6ede07254ed&q=1&e=ed6b721a-b6ae-4d7a-b1bf-4e0a7691061d&u=https%3A%2F%2Fgithub.com%2Fpdp7%2Flinux.git
>>  F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>> +F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>>  F:	arch/riscv/boot/dts/thead/
>>  F:	drivers/clk/thead/clk-th1520-ap.c
>>  F:	drivers/mailbox/mailbox-th1520.c
>> -- 
>> 2.34.1
>>
> 

