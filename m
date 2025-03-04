Return-Path: <linux-kernel+bounces-543408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7379A4D536
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C333B05B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11401FBC94;
	Tue,  4 Mar 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W2IrArBc"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D11F9A83
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074246; cv=none; b=dOY78ywvjT9Er2aDMEdofGE2PsJ+2ZkqIBmiC+lH4dceTfmWkX7+WSkV8xNBLtY7TjMtarq/HSrXAyFaixorVY/JpXXO1WRcrwb31hl9wXtKLh6uimN9M627e7TbYH5GaMJ32lxGzsAUi/K5r+wIEs6qYK/sVoRbrL5gli50kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074246; c=relaxed/simple;
	bh=Ifd1f/ZA9V65EmuAxPpKS71DxVXs6kb9oPADaS1OdQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cZaAnjhYxI0Up3QzS9E7FJIZrLtYHhaSqhPwJUzqhluCA/xNDLawmXlTFEebDZDb6F0ng2l8XVoghdmaYxO9wRy9DgBx9NSpJf2aj05xX2wlmHJsJkYCi9Dorc0AZHx95K3WkIVcGsY6pm8stIrLAOlRZ4Vm0o5Iae4ONvRgCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W2IrArBc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250304074401euoutp0274820874442befb063e962ee6710e716~picw-JxUp0999909999euoutp02o
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:44:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250304074401euoutp0274820874442befb063e962ee6710e716~picw-JxUp0999909999euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741074241;
	bh=4BFr8Rd+AuGGA2HLx1V5tn0sMoKxIe9Ixbj1HyvfRuA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W2IrArBc9wnni4siafqd7en20enM43Cf5mC3GDVO6EjWZ8uvvjs1+XDmlkmnMycut
	 yXEyCxM122jLgA1XZo/2Km4xdBjpZ5iJDtVEoDOHVST0T2TQowjT8lEy73Mh9Uzevd
	 zwrO0fb3ReKtbN/rycYER3r4giaUoZbmYzUZkgoM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250304074400eucas1p1efde6961d5015269dd80c497f968f098~picwTkFL92735327353eucas1p19;
	Tue,  4 Mar 2025 07:44:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.7A.20397.04FA6C76; Tue,  4
	Mar 2025 07:44:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250304074359eucas1p1dff7a62b9ece707006c704ae4180c592~picvucTlh2932929329eucas1p1-;
	Tue,  4 Mar 2025 07:43:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250304074359eusmtrp2f76278813dd5971a494fdbe749d29c17~picvtvhh33203132031eusmtrp2M;
	Tue,  4 Mar 2025 07:43:59 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-f5-67c6af40cee5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.8B.19920.F3FA6C76; Tue,  4
	Mar 2025 07:43:59 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250304074358eusmtip206d631ffbee06748542ec1c8f6f073f8~picu1dvys0733307333eusmtip2N;
	Tue,  4 Mar 2025 07:43:58 +0000 (GMT)
Message-ID: <99fcf36f-7fed-43e8-a94f-47563ab00fc6@samsung.com>
Date: Tue, 4 Mar 2025 08:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: firmware: thead,th1520: Add support
 for firmware node
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <8dcdd2ec-e4b6-4fc0-be50-12fe187cd5e0@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7djPc7oO64+lG7zbLm3x7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZnD+/gd1i7+ut7BaXd81hs/jce4TR
	YtvnFjaLtUfuslu8vNzDbNE2i9/i/54d7BbH14ZbtOyfwuIg7PHm5UsWj8MdX9g97p2Yxuqx
	aVUnm8eda3vYPDYvqfdoWXuMyeP9vqtsHn1bVjF6XGq+zu7xeZNcAHcUl01Kak5mWWqRvl0C
	V8blfauYCx6wVWyft4+5gfEwaxcjJ4eEgInEtZ+rmboYuTiEBFYwSsz6/BcsISTwhVGi7Wku
	ROIzo8TxgxPhOrbt3skCkVjOKLHhzh42COcto0Tjsl42kCpeATuJH1+PMoLYLAIqEjOXn4CK
	C0qcnPmEBcQWFZCXuH9rBjuILSyQIHH7fBMzyCARgR1MElfe7AFzmAU2MkqsO/oarINZQFzi
	1pP5TCA2m4CRxIPl88Fu4gTa1rDmFitEjbzE9rdzwJolBB5xSpxfvBXoDA4gx0Xi4roiiB+E
	JV4d38IOYctI/N8JMVNCIF/iwdZPzBB2jcTOnuNQtrXEnXO/2EDGMAtoSqzfpQ8RdpSY8LqN
	CWI6n8SNt4IQF/BJTNo2nRkizCvR0SYEUa0mMbWnF27puRXbmCYwKs1CCpVZSH6cheSXWQh7
	FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMmKf/Hf+6g3HFq496hxiZOBgPMUpw
	MCuJ8N5qP5ouxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfR/tZ0IYH0xJLU7NTUgtQimCwTB6dU
	AxPHk+JZW9NdErk3f7Dfab/xe1YL6y3Nq9MLNAJena+Idbn4o9SueSrfr1KO9OAZS37+WFnv
	sqHfgv07c7Xt2VMLajjXW7KcdZ5hNe336/uq+eeUVuiszejYwZqiVP3u39S67Cl+IX81VSob
	6m5uW/UlZMr6a3M+cRsFBa19dEKwfcuVn8udkmqtFb9tr/3W6yHmIb3C/E/M7IMrhNjTFVrY
	l2784errIHDn47L/a7v6+fRSPizbU9t05PpZ1yml96/OjpnRky3rePLnw/st93RfHOObEqn3
	9Mm95rsWC2KDFr/TWrjg/+bXi3iDOlg/Fk53T9oza2bz5Zdi3+fyL5EOf9m1reC2wJPMGf16
	PhoKSizFGYmGWsxFxYkA9SDlBwcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42I5/e/4PV379cfSDVofGFo8u/OV1WLr71ns
	Fmv2nmOymH/kHKvFvUtbmCxe7G1ksWg+tp7N4uWse2wW589vYLfY+3oru8XlXXPYLD73HmG0
	2Pa5hc1i7ZG77BYvL/cwW7TN4rf4v2cHu8XxteEWLfunsDgIe7x5+ZLF43DHF3aPeyemsXps
	WtXJ5nHn2h42j81L6j1a1h5j8ni/7yqbR9+WVYwel5qvs3t83iQXwB2lZ1OUX1qSqpCRX1xi
	qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F53yrmggdsFdvn7WNuYDzM
	2sXIySEhYCKxbfdOli5GLg4hgaWMEoePTWSCSMhIXOt+yQJhC0v8udbFBlH0mlFi1+db7CAJ
	XgE7iR9fjzKC2CwCKhIzl59gg4gLSpyc+QSsWVRAXuL+rRlg9cICCRK3zzcxgwwSEdjBJHG0
	bwfYVGaBjYwSC7/vYodYsZ5JYu+OP8wgLcwC4hK3nswHu4lNwEjiwfL5YIdzAq1uWHMLyOYA
	qlGXWD9PCKJcXmL72znMExiFZiE5ZBaSSbMQOmYh6VjAyLKKUSS1tDg3PbfYUK84Mbe4NC9d
	Lzk/dxMjMElsO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJ7q/1ouhBvSmJlVWpRfnxRaU5q8SFG
	U2BgTGSWEk3OB6apvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OEBNITS1KzU1MLUotg+pg4OKUa
	mKyD2jP6xaTvh0cv3cXzqeh9vsfNx/ozTCY6+LCXOR7+VHt09hSH1d8X/t5SLvR4ynmO0m6r
	L1M3G21SLNdI32yUqLL7E89snolm7gq6PqIhIoFyL0Mavrf5GxXNOe5/d8WpTZLZZnFBZd+j
	prByvw9LvGrpeGP2OhUFDYl335JdNtzKicxSvWAotGP/pxuNPQe42W/7ykWnSLRvmHT/1Op1
	mRtsP1UIvTnK0vqn3292a73HOfOcHRK5bx5lXQv+lHrzUVTEdLb0lq6W+i7X2Y9FWjQ+1nYp
	dF9w2lSfcfjdv3unlr8KmPh+/bNzUzsqLPY9TWN6psyx/uz9mBuKtfZ7lmSIckbXuGhNX6zY
	psRSnJFoqMVcVJwIAPqFG5CbAwAA
X-CMS-MailID: 20250304074359eucas1p1dff7a62b9ece707006c704ae4180c592
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f@eucas1p1.samsung.com>
	<20250303145901.446791-2-m.wilczynski@samsung.com>
	<edb3dd6e-8b56-42b3-8bb2-8ed7ad186b75@kernel.org>
	<8dcdd2ec-e4b6-4fc0-be50-12fe187cd5e0@kernel.org>



On 3/3/25 18:46, Krzysztof Kozlowski wrote:
> On 03/03/2025 18:42, Krzysztof Kozlowski wrote:
>> On 03/03/2025 15:58, Michal Wilczynski wrote:
>>> The kernel communicates with the E902 core through the mailbox
>>> transport using AON firmware protocol. Add dt-bindings to document it
>>> the dt node.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>>
>> How is this possible? That's v1 and I never review outside of mailing list.
>>
> OK, I found v5:
> https://lore.kernel.org/all/20250219140239.1378758-4-m.wilczynski@samsung.com/
> 
> so is this the same?

Yeah, I thought by splitting the patchset and creating new sub-series I
should start versioning from v1 again, and leave that bigger patchset as
a reference, I've linked it in each cover letter for each sub-series.

> 
> Best regards,
> Krzysztof
> 

