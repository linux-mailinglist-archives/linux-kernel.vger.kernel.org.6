Return-Path: <linux-kernel+bounces-373152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C159A5305
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC111F214B9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65128689;
	Sun, 20 Oct 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MdeLOVNd"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FCFBF0
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729409584; cv=none; b=aj86y42Ln3K/7xYjhsijGQgU4Ol2I7VeuLHdr0CwIT/nlgdFnqcXKHjgrPkU9GF437Ebq7PrGcnOyr9inicvAVQdsIfrONoToyolJjo+8a+3nQQbliXmV9v7I4gCPCybvtoScyihGP1zbCvw+inO2Vg6QBKkUkZv5Ap//bEoRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729409584; c=relaxed/simple;
	bh=jIxR2yaiEyWljtRv915608tHnxnYKTt7YZASx+HlT4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jA3LIkmgeDmk31EjXD8T4yR2GoqUvL1HY9otbKNYgTR3OEWgw7TkiyDmCtDVXbpAz/0KFfo8WIcTx09Mg6fhW3L/QvDJBZ5ejQ7WqG8WJhcF76NU9zXbxLp0Nda9LkNYEfcrp1qkojUJ6bj33skenMRTkhAlIHWxfhhP1J0qfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MdeLOVNd; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241020073254euoutp022211bf20b40e7b59f8459740489de002~AGNhr104o2204622046euoutp02d
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:32:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241020073254euoutp022211bf20b40e7b59f8459740489de002~AGNhr104o2204622046euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729409574;
	bh=Xt9eRXbiKHfuofQrQEnr1oCw438o/WGpb2oUH6mhKcM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MdeLOVNdNb24ImRfOMI+VFInSjpJBH+EluCYif0wOUQD55u7KmRtprGTznA4ko5RA
	 Cujffc/MSXm3TYfs1P6z6B1mgErChg19UKFkJxGPtQqqirOb4luXF41WhSXJa8vkuV
	 vkrz5mW9ZU4+ayc1ln0HDxtQySDGfH/wwsCxTNas=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241020073253eucas1p2f4493ae60f61259b3444f8dc4d664619~AGNg9G6O80808008080eucas1p29;
	Sun, 20 Oct 2024 07:32:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 09.24.20821.522B4176; Sun, 20
	Oct 2024 08:32:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241020073252eucas1p26f85a05022f8e471fe858f8cdece8bac~AGNfzmnA22432024320eucas1p2K;
	Sun, 20 Oct 2024 07:32:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241020073252eusmtrp239577aa8f199dead2e9bd0bac20db4fb~AGNfy4chg1126911269eusmtrp2e;
	Sun, 20 Oct 2024 07:32:52 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-ea-6714b225d869
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.C2.19654.422B4176; Sun, 20
	Oct 2024 08:32:52 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241020073251eusmtip285d33bdd94a788e4c94a375d329ddf0f~AGNe-3l7C2853928539eusmtip2G;
	Sun, 20 Oct 2024 07:32:51 +0000 (GMT)
Message-ID: <5707ef09-c447-40ec-ba3a-44630d165f63@samsung.com>
Date: Sun, 20 Oct 2024 09:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: mailbox: Add thead,th1520-mailbox
 bindings
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <f1c1af8c-18e0-433d-a61c-90080919378f@sifive.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87qqm0TSDfYdMrHY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i72vt7JbXN41h81i2+cWNou1R+4CJS73MFu0
	zeK3+L9nB7vF6nNXWCxa9k9hcRDwePPyJYvH4Y4v7B47Z91l99i0qpPN4861PWwem5fUe7Ss
	Pcbk8X7fVTaPvi2rGD0uNV9n9/i8SS6AO4rLJiU1J7MstUjfLoEr4/3DO6wFR20rLr45ytLA
	ONewi5GTQ0LAROLCx2vMXYxcHEICKxgl/v6Ecb4wSly4sp4ZpEpI4DOjxMwr3DAd66/chCpa
	zijRvn0SlPOWUWLJ753sIFW8AnYSU2ZuAbNZBFQlep5/ZoSIC0qcnPmEBcQWFZCXuH9rBliN
	sECoxIETT8BsEQE9iQvrv7CCDGUWaGaWOHnnCxtIgllAXOLWk/lMIDabgJHEg+XzWUFsTqBl
	jSteMEHUyEs0b50NdpGEwGFOiYMX/zFB3O0i0dx7mR3CFpZ4dXwLlC0j8X/nfKiafIkHWz8x
	Q9g1Ejt7jkPZ1hJ3zv0COoIDaIGmxPpd+hBhR4k9zRcZQcISAnwSN94KQpzAJzFp23RmiDCv
	REebEES1msTUnl64pedWbGOawKg0CylUZiF5chaSZ2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84
	Mbe4NC9dLzk/dxMjMCme/nf80w7Gua8+6h1iZOJgPMQowcGsJMKbVC+YLsSbklhZlVqUH19U
	mpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cAk8a/72V0ZoShrofU6U0u/vXU/
	pcfke8fVoWTPPYaSVXu1VDzKroV8FJWvOPPdS+jKy8uZfaKvnaZY7w7t8asqtVM+JPawPTGS
	rU2aN48xpoRrkw+7SPuhO/maOibW8pdypupbC/XEdnz+zcFeUn6F58GE8Op1hssX5qlqNH3t
	2lXP/X/Poogq55/L9xyc+f+IvvmkQHbHmOdlnKFS4bM4NutZeIUUtC9Zz2y/0edax4tNdfLL
	J824GFzIsmh9SHeyhpBWmflRzjorUZM8y/svXq5eZuR/yMb59nvv+FmXtxlvNdCyPVOScMb+
	dv+7pHdzv3Pxyu+bmrZEk+Ouwd4rB71FBer3zt+pOPFgkRJLcUaioRZzUXEiAGHQ09n5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7oqm0TSDX48VLTY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i72vt7JbXN41h81i2+cWNou1R+4CJS73MFu0
	zeK3+L9nB7vF6nNXWCxa9k9hcRDwePPyJYvH4Y4v7B47Z91l99i0qpPN4861PWwem5fUe7Ss
	Pcbk8X7fVTaPvi2rGD0uNV9n9/i8SS6AO0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q
	2DzWyshUSd/OJiU1J7MstUjfLkEv4/3DO6wFR20rLr45ytLAONewi5GTQ0LARGL9lZvMXYxc
	HEICSxklXk88zQSRkJG41v2SBcIWlvhzrYsNoug1o0TP5C1gCV4BO4kpM7ewg9gsAqoSPc8/
	M0LEBSVOznwCViMqIC9x/9YMsBphgVCJAyeegNkiAnoSF9Z/YQWxmQVamSXuT5aHWPCXUaL9
	xWt2iIS4xK0n88EuYhMwkniwfD5YAyfQ4sYVL4DiHEA16hLr5wlBlMtLNG+dzTyBUWgWkjNm
	IZk0C6FjFpKOBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKTwLZjP7fsYFz56qPeIUYm
	DsZDjBIczEoivEn1gulCvCmJlVWpRfnxRaU5qcWHGE2BQTGRWUo0OR+YhvJK4g3NDEwNTcws
	DUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCUamCadfR99EPVL5d89trOSDzPbqPW0Ze+
	yH/HFP8J/or6UUuPH1t/woC5+dScrWKHv0974Kk5f59v8PbGvp0nQ8503uTP+9MXMzlIRMJk
	lvXR4zzO+flaEf6cjh28t2V/acULmIkytuqb6S+ZP2Ff0MR/2yt6Wf2mzTZaMiWzONSp4Oz1
	QN3KL+3L2PikP0VdeO4p+CAgtcFFf/21met5ZQLZ9zuU/v64892rK5vlXEol42JU1iibB0ga
	lD9/cTRsMaOe896d/DbeCl6xDDkPXX4ufR4s3Nc987b0Zqc9mvqfvbTE+mdGN4QZLZgXxf/3
	WcAmqZVPDs/Wsax/N+uuc1KjxIMNb7g/Lvk5+Z5yvr0SS3FGoqEWc1FxIgAy2tM0iwMAAA==
X-CMS-MailID: 20241020073252eucas1p26f85a05022f8e471fe858f8cdece8bac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123411eucas1p1f93d64ac9db9a6f77982500d4a0157f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123411eucas1p1f93d64ac9db9a6f77982500d4a0157f7
References: <20241014123314.1231517-1-m.wilczynski@samsung.com>
	<CGME20241014123411eucas1p1f93d64ac9db9a6f77982500d4a0157f7@eucas1p1.samsung.com>
	<20241014123314.1231517-3-m.wilczynski@samsung.com>
	<f1c1af8c-18e0-433d-a61c-90080919378f@sifive.com>



On 10/16/24 01:14, Samuel Holland wrote:
> Hi Michal,
> 
> On 2024-10-14 7:33 AM, Michal Wilczynski wrote:
>> Add bindings for the mailbox controller. This work is based on the vendor
>> kernel. [1]
>>
>> Link: https://protect2.fireeye.com/v1/url?k=deccc9a8-815707cc-decd42e7-000babda0201-ff79d4aaff73f36c&q=1&e=7028c1ef-1c3d-4e17-b7ed-76d362b80caf&u=https%3A%2F%2Fgithub.com%2Frevyos%2Fthead-kernel.git [1]
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/mailbox/thead,th1520-mbox.yaml   | 80 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 81 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>> new file mode 100644
>> index 000000000000..12507c426691
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=7fcda92a-2056674e-7fcc2265-000babda0201-c5d541bdd4cc5f35&q=1&e=7028c1ef-1c3d-4e17-b7ed-76d362b80caf&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fmailbox%2Fthead%2Cth1520-mbox.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=068c7881-5917b6e5-068df3ce-000babda0201-b045bd7290e64f0e&q=1&e=7028c1ef-1c3d-4e17-b7ed-76d362b80caf&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
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
> 
>>From the SoC documentation, it looks like these are four different instances of
> the same IP block, each containing 4 unidirectional mailbox channels and an
> interrupt output. So these should be four separate nodes, no? The C910 would
> receive on channels 1-3 of instance 0, and send on channel 0 of instances 1-3.
> 

Hi, and thank you for your review.

I wanted to take some time to familiarize myself with the device tree
documentation and review best practices for mailbox drivers before
responding.

Upon reviewing the Linux device tree documentation, I couldn’t find any
specific rule that mandates having one device node per IP block in the
hardware. The T-Head manual is more focused on the hardware from a
programmer’s perspective rather than describing how exaclty the ICU's
are implemented in the HW. The device tree documentation provides
guidelines for how hardware blocks should be represented, but it doesn't
impose a strict requirement for separate device nodes per hardware
block, especially when it comes to devices like mailbox controllers.

Technically, your suggestion to create separate nodes for each ICU
instance is possible. However, doing so would require additional
complexity in the driver, as it would need to handle each node
individually. For instance, the driver would need to request interrupts
only in the case of mailbox910_t_0, while handling other device nodes
like mailbox910_t_1, mailbox910_t_2, and mailbox910_t_3 separately.

In my opinion, this approach would add unnecessary complexity to the
driver code. The current approach — using a single device node for the
mailbox controller and utilizing channels to steer messages seems to
align better with existing best practices for mailbox drivers. Many
mailbox drivers create a single mailbox controller and leverage multiple
channels for different communication paths, which simplifies both the
device tree and the driver implementation.

I hope this explanation clarifies my perspective, and I’d like to
propose keeping the current design as it stands.

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
>> +  '#mbox-cells':
>> +    const: 2
>> +    description: |
>> +      Specifies the number of cells needed to encode the mailbox specifier.
>> +      The mailbox specifier consists of two cells:
>> +        - Destination CPU ID.
>> +        - Type, which can be one of the following:
>> +            - 0:
>> +                - TX & RX channels share the same channel.
>> +                - Equipped with 7 info registers to facilitate data sharing.
>> +                - Supports IRQ for signaling.
>> +            - 1:
>> +                - TX & RX operate as doorbell channels.
>> +                - Does not have dedicated info registers.
>> +                - Lacks ACK support.
> 
> It appears that these types are not describing hardware, but the protocol used
> by the Linux driver to glue two unidirectional hardware channels together to
> make a virtual bidirectional channel. This is really the responsibility of the
> mailbox client to know what protocol it needs, not the devicetree.
> 

The protocols in question are actually handled by the firmware running
on the other cores, like the E902. I couldn’t find the firmware source
code, as it’s distributed as binary blobs. For example, the firmware
binary [1] gets loaded by U-Boot at specific addresses.

For the current case — communicating with the E902 core — the Type ‘0’
protocol is all we need. So, I don’t see any issue in removing the
second cell, since we’re only using one protocol here. 

[1] -
https://git.beagleboard.org/beaglev-ahead/xuantie-ubuntu/-/blob/48bc51286483257f153ba58813bb601267d0f087/bins/light_aon_fpga.bin

Thanks,
Michał

> Regards,
> Samuel
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - '#mbox-cells'
>> +
>> +additionalProperties: false
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
>> +        #mbox-cells = <2>;
>> +      };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0655c6ba5435..7401c7cb6533 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19951,6 +19951,7 @@ L:	linux-riscv@lists.infradead.org
>>  S:	Maintained
>>  T:	git https://protect2.fireeye.com/v1/url?k=9b23b6b0-c4b878d4-9b223dff-000babda0201-68366f7c65442b8f&q=1&e=7028c1ef-1c3d-4e17-b7ed-76d362b80caf&u=https%3A%2F%2Fgithub.com%2Fpdp7%2Flinux.git
>>  F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>> +F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>>  F:	arch/riscv/boot/dts/thead/
>>  F:	drivers/clk/thead/clk-th1520-ap.c
>>  F:	drivers/mailbox/mailbox-th1520.c
> 
> 

