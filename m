Return-Path: <linux-kernel+bounces-373151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF29A5303
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E426283416
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6329CE7;
	Sun, 20 Oct 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kM67r00b"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A217C79
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729409520; cv=none; b=HUP7CpZb2BKp61yrn47e6u5zOTCYyrsUQn5VhQsuIHOfdlSB5hsnnxUzuZfOAXIiRjNzKyfD6gRoe6vOrcYdRuds4mFme6PZv24Vtxa5IfCz1EQ/hZRDsAfSD6rr8s9nmvuYcz7gX8xRP0L2uGgTlrCT17Zl6R3bp29qs65+zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729409520; c=relaxed/simple;
	bh=Q2ZHJ+LxYU+m24rQTEZbeaEfG1wT+aXZzzXlRxde4uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=iXaQUzUWy3vnqxecRbz/dUZRbeC0Mucp3+jkBlJC3lPj5XDJpmdRsEc4SvY3sr6Cj+9lAHkHWUDjko8pMoYnP6R0Q7tYSn9cqZulDSpLEUSBYm3v55FgWZx57cZkB1u0YvAR/RkT+etKcmInJlZOkJ4OiE0+DnM8GyWSeWSiqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kM67r00b; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241020073150euoutp0144c62d0a059f5da62975b93825b0188b~AGMldu3Gy3126231262euoutp01J
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:31:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241020073150euoutp0144c62d0a059f5da62975b93825b0188b~AGMldu3Gy3126231262euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729409510;
	bh=e5elJH5IxGZkyMMY5cfuk2jRIIiMmB1HblIjxtL2Frg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kM67r00bGviGMufjiLPEidEXiWUNAqeWhLbLv1zFIO4Q0rHkQ/0z+57fv0skaOmWk
	 ca1cfAukL2ltwHeSjUJ4SIMYuhw2bFGgSnpRLh/PMHCZfcjJiCS+Bddc3nJp0X4Cbn
	 FuVyjZFava55ElUUH+pblqYHmpzmR4j76DQ2RFnY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241020073149eucas1p2f0b8fa13c4dc4155d90dbd8484bf71bb~AGMlBpaJS2431224312eucas1p2t;
	Sun, 20 Oct 2024 07:31:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B8.DD.20397.5E1B4176; Sun, 20
	Oct 2024 08:31:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241020073148eucas1p1bf6fef28932441e8a1bcfbe68b027e55~AGMkc94J82949829498eucas1p1a;
	Sun, 20 Oct 2024 07:31:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241020073148eusmtrp2649b6ceada66985c0ec9bba0e291c678~AGMkcUaHA1126911269eusmtrp2M;
	Sun, 20 Oct 2024 07:31:48 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-23-6714b1e5c322
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.13.19920.4E1B4176; Sun, 20
	Oct 2024 08:31:48 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241020073148eusmtip14289d6ab273e0e1766691c11a5519299~AGMjlU89j2150321503eusmtip1b;
	Sun, 20 Oct 2024 07:31:47 +0000 (GMT)
Message-ID: <c586a0e9-2bd1-4580-8bf4-bc59f1af0c51@samsung.com>
Date: Sun, 20 Oct 2024 09:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: mailbox: Add thead,th1520-mailbox
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <54fd467b-8077-454f-ae6c-14bb782cbe3a@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djPc7pPN4qkG7y+LWmx9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFufPb2C32Pt6K7vF5V1z2Cy2fW5hs1h75C5Q
	9nIPs0XbLH6L/3t2sFusPneFxaJl/xQWB0GPNy9fsngc7vjC7rFz1l12j02rOtk87lzbw+ax
	eUm9R8vaY0we7/ddZfPo27KK0eNS83V2j8+b5AK4o7hsUlJzMstSi/TtErgy2t7GFfwXqHjZ
	/JSxgXEhTxcjJ4eEgInEi3sb2LoYuTiEBFYwSnxc0QjlfGGUWPBpNyOE85lRYvPXBiaYll8v
	uphBbCGB5YwSOw+YQxS9ZZRYO2E1WIJXwE6i48ZqRhCbRUBVYv/u01BxQYmTM5+wgNiiAvIS
	92/NYAexhQVCJQ6ceAJmiwiES8y98IgFZCizQDOzxMk7X9hAEswC4hK3nswHu4JNwEjiwfL5
	rCA2J9Cy+b8WQtXISzRvnc0M0iwhcI5T4u3LXjaIs10kms9MZIGwhSVeHd/CDmHLSPzfOR/q
	tXyJB1s/MUPYNRI7e45D2dYSd879AprDAbRAU2L9Ln2IsKPEnuaLjCBhCQE+iRtvBSFO4JOY
	tG06M0SYV6KjTQiiWk1iak8v3NJzK7YxTWBUmoUUKrOQPDkLyTOzEPYuYGRZxSieWlqcm55a
	bJyXWq5XnJhbXJqXrpecn7uJEZgcT/87/nUH44pXH/UOMTJxMB5ilOBgVhLhTaoXTBfiTUms
	rEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpg0v7E+q3pMMedFYZs
	Qv2dC7cyJmX+nM5gE7y5/OP3EwU/9tm6bdw6+dn+0mVh+c9Fl6/+KVeYO90sPq8pcZ/S3bQD
	7Ds+mdjtf9Ll47rn93OjB0smsqzp7o34EJPGwc/4+NOlWccP3JplePHp3IYeAd/o3aG2n7Y0
	P/59rmbT1vUmaRdtKtlfWlYsvxT0iXmZZZms8q2nfXc2qXw877Vi4gMmt7SUCo4j9y0k/1xc
	I7Js30WFy5ZnW2Ju3r6onljOMJstb25cM6vEc4s90ZtT2BnV68s3Tvyc2rdm4/P8yrauVWvk
	eJoM9CZvDfSqmb5/WqWLg1O+38TuZveu/yFzOed7iYRZnLzeyNEzk69qjxJLcUaioRZzUXEi
	AA+FiJL9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7pPNoqkG3y4ZGix9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFufPb2C32Pt6K7vF5V1z2Cy2fW5hs1h75C5Q
	9nIPs0XbLH6L/3t2sFusPneFxaJl/xQWB0GPNy9fsngc7vjC7rFz1l12j02rOtk87lzbw+ax
	eUm9R8vaY0we7/ddZfPo27KK0eNS83V2j8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30
	jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy2t7GFfwXqHjZ/JSxgXEhTxcjJ4eEgInErxdd
	zF2MXBxCAksZJVqefmWBSMhIXOt+CWULS/y51sUGUfSaUaJ54lJGkASvgJ1Ex43VYDaLgKrE
	/t2nmSHighInZz4BaxYVkJe4f2sGO4gtLBAqceDEEzBbRCBc4tKijWC9zAKtzBL3J8tDLNjI
	JDFn0jNmiIS4xK0n85lAbDYBI4kHy+ezgticQIvn/1oIdBEHUI26xPp5QhDl8hLNW2czT2AU
	moXkjFlIJs1C6JiFpGMBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwGSw7djPzTsY5736
	qHeIkYmD8RCjBAezkghvUr1guhBvSmJlVWpRfnxRaU5q8SFGU2BQTGSWEk3OB6ajvJJ4QzMD
	U0MTM0sDU0szYyVxXrfL59OEBNITS1KzU1MLUotg+pg4OKUamEQOpyh1fzzZP/1FlkSS5tXH
	aZ8uXL27IX7VugMyMzabrxRYGLbAcMab6G+9SaxGsx9eeHClte9E1Ao/v/x7GcbXN051MfVi
	yTsjeyVxybwZMwIcXNacnNr7l7GpSKdg4ueDApvzmKy+B3Xv3fn7m0N06pb7UR7/vc9m1utx
	ic76N2/CLWFfg9cm37cUXTvmZf862O35EdWrkysnXr+zuX1i7H5Rfm+nb8YpxUcMd6T8mRG7
	mKO1s3Yb948NSjU8oq0z3u0tK+pkud+Ut8C45PoBiSkm/Zd73itlrj99+EGI09Ife5Y/mBL3
	Z72Fsuqq6Gf/eXh+7S5xmx0eE7hjTYGFj2dx9cX7PMm2S5RnmiopsRRnJBpqMRcVJwIAZw4t
	X48DAAA=
X-CMS-MailID: 20241020073148eucas1p1bf6fef28932441e8a1bcfbe68b027e55
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
	<54fd467b-8077-454f-ae6c-14bb782cbe3a@kernel.org>



On 10/16/24 08:31, Krzysztof Kozlowski wrote:
> On 16/10/2024 01:14, Samuel Holland wrote:
>>> +  reg-names:
>>> +    items:
>>> +      - const: local
>>> +      - const: remote-icu0
>>> +      - const: remote-icu1
>>> +      - const: remote-icu2
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  '#mbox-cells':
>>> +    const: 2
>>> +    description: |
>>> +      Specifies the number of cells needed to encode the mailbox specifier.
>>> +      The mailbox specifier consists of two cells:
>>> +        - Destination CPU ID.
>>> +        - Type, which can be one of the following:
>>> +            - 0:
>>> +                - TX & RX channels share the same channel.
>>> +                - Equipped with 7 info registers to facilitate data sharing.
>>> +                - Supports IRQ for signaling.
>>> +            - 1:
>>> +                - TX & RX operate as doorbell channels.
>>> +                - Does not have dedicated info registers.
>>> +                - Lacks ACK support.
>>
>> It appears that these types are not describing hardware, but the protocol used
>> by the Linux driver to glue two unidirectional hardware channels together to
>> make a virtual bidirectional channel. This is really the responsibility of the
>> mailbox client to know what protocol it needs, not the devicetree.
>>
> 
> Hm, where is the DTS with consumers of this mailbox provider?

The DTS with consumers of this mailbox provider is not included in this
series. Since the mailbox users depend on this driver being upstreamed,
I decided to submit this driver first to gather feedback on whether it
can be accepted upstream. If successful, I will follow up with another
series for the aon driver, which will use this mailbox to send commands
to the E902 core, such as powering the GPU on or off.

The consumer DTS would look something like this:

aon: aon {
	compatible = "thead,th1520-aon";
	mbox-names = "aon";
	mboxes = <&mbox_910t 1 0>;
	status = "okay";

	pd: light-aon-pd {
		compatible = "thead,light-aon-pd";
		#power-domain-cells = <1>;
	};
};

Thanks,
Michał

> 
> Best regards,
> Krzysztof
> 
> 

