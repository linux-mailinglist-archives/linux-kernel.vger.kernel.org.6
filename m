Return-Path: <linux-kernel+bounces-254038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5526932B78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06608B215CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449F19E7C4;
	Tue, 16 Jul 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QnpTqYRU"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781119ADAD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144730; cv=none; b=X5rGwSiRs63SXwkzPc3nbHTRPnQfHVL/i4I8ureUuyhc9weHpvlHvkrze8C+FMCCFnWqWYHHZ3Qh7H0F6eUE96UO3G8FupuK7qFyXuNN7horCXIOK9gSkXOihVTG15RWBr6ALOwuRUd84CQskNtq+Y6e4a/wm8GBj0LWnas9eKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144730; c=relaxed/simple;
	bh=ZhJN5IeKvGaQ1BOL9qJd/KV0W2QjA/TjtAkJvonfS80=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=KAZRDsuWMxk9eUTkdxLapo4jsRc7Q+rpH2v6PgAziaTvhlE+9zURn1xV7APMlhooB6HI90qFc2ScSL85zZJV306stcFWtFZRmcNeUSS6Yp6GOT+1G0CeYXNpUkccoCVoXbvx3niqjfrE72qAnYg13lbtE1UFQRPuOzp5Nx8JhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QnpTqYRU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240716154526euoutp01dcbd8684b403043074dc766d1e602a5e~ivAKGQU5o1978019780euoutp01L
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:45:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240716154526euoutp01dcbd8684b403043074dc766d1e602a5e~ivAKGQU5o1978019780euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721144726;
	bh=DkcC53LxKYGCnJNcREJfLuVKf9XOrJMoUtHzbF47cA0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QnpTqYRUKn623qYDcTpEj8CxCrpBK8MU07h3+7RaaaTDrTdgFarfLkaFW7Oof0Y7C
	 5vMeTcT5t6zas9myGEfbwwnkRkhjI5VB9GZQWZF4Uww8mCsTdOR3mddWCcJ2tNP7bG
	 9zKTMATG4wKm+b++S8JkCzv5y3GXcJaCzmqdfZJU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240716154526eucas1p23521b4311ed80c4a3f848b45258c650d~ivAJv-0WR0863808638eucas1p2H;
	Tue, 16 Jul 2024 15:45:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.78.09875.69596966; Tue, 16
	Jul 2024 16:45:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240716154525eucas1p1153a0288f3148c1870b58156c73c30e5~ivAI9JqKc2211322113eucas1p1M;
	Tue, 16 Jul 2024 15:45:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240716154525eusmtrp223dff3add826eaca3672388d8606749a~ivAI8oRvK1133211332eusmtrp25;
	Tue, 16 Jul 2024 15:45:25 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-d5-669695966a6c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.C2.08810.59596966; Tue, 16
	Jul 2024 16:45:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240716154525eusmtip14aef047cd1edf28ede655c2ec62098e7~ivAIuo3Rv2358923589eusmtip1i;
	Tue, 16 Jul 2024 15:45:25 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Jul 2024 16:45:24 +0100
Date: Tue, 16 Jul 2024 17:45:20 +0200
From: Joel Granados <j.granados@samsung.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<arjan@linux.intel.com>
Subject: Re: [PATCH] latencytop: Use seq_putc() in lstats_show()
Message-ID: <20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned1pU6elGXS8Zrf4/mABu8XWW9IW
	l3fNYbP4P+s5qwOLx7yTgR6fN8l53H62jSWAOYrLJiU1J7MstUjfLoErY/rVz+wFK9kqzr55
	xNzA+I+li5GTQ0LARGLp31b2LkYuDiGBFYwSzZuXM0E4XxglVm3sgsp8ZpQ4t7qbCaZlYtth
	NojEckaJxY+6EapeHf7BCuFsZZS49vg6WAuLgKrEw33zGEFsNgEdifNv7jB3MXJwiAhoSTx9
	bAJiMgukSnQsdwSpEBZwkOhZ+h6smhfI3v/kOzOELShxcuYTFohyTYn1u/QhTGmJ5f84QCqY
	BeQlmrfOBqvmFLCS6P56nx3iZGWJ9w/2QX1cK7H22BmwiyUEznBIbPrwlRUi4SKx4O01qCJh
	iVfHt0A1y0j83zmfCaJhMqPE/n8foLpXM0osa/wKDRVriZYrT9hBLpIQcJSYuy8CwuSTuPFW
	EOI4PolJ26YzQ4R5JTrahCYwqsxC8tgshMdmITw2C8ljCxhZVjGKp5YW56anFhvlpZbrFSfm
	Fpfmpesl5+duYgQmktP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeCcwTksT4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYNIrlP3mUD3pQ7h+2Z159wTux/Lw
	tfHXMheHr7s7/bZMpGHN/P7zM9X4tsu2sasKeai++Ga+tvD9p92aGTtWu9zcV2rzonTVzctv
	WCdN4GFeetpWi5lZUdHu1s7ON/OUxDiswncZWW9wCA66sqan9jBLsx1vU7mKX6b4pw/Vl7s+
	fXqYN+3LN58LU8T0Fip+11wg6falZcJSUb2PxzIDD6su0881+hzFfXmzFOvhJGaxV6/Wruxs
	W77a1WPdko6NFy7ePJRVa9qqpjqxqeFVyIqrb+L1j9/+uJSd+dKOl/tu3ipfqfgjsNVkZ8z8
	NVzfnNw3FOZsmDk5Q77xkghz+qZdkjG6Pj7beGalZ9WXXVZiKc5INNRiLipOBACpPeuPkwMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7pTp05LM9i5WcDi+4MF7BZbb0lb
	XN41h83i/6znrA4sHvNOBnp83iTncfvZNpYA5ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
	Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOlXP7MXrGSrOPvmEXMD4z+WLkZODgkBE4mJbYfZ
	QGwhgaWMEm17UiHiMhIbv1xlhbCFJf5c6wKq4QKq+cgo8WDfGnYIZyujxM1ZW5hAqlgEVCUe
	7pvHCGKzCehInH9zh7mLkYNDREBL4uljExCTWSBVomO5I0iFsICDRM/S92DVvED2/iffmSFG
	9jJK7P/XxgKREJQ4OfMJC0SvpsT6XfoQprTE8n8cIBXMAvISzVtnM4PYnAJWEt1f77NDnKws
	8f7BPqgXayVe3d/NOIFRZBaSobMQhs5CGDoLydAFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
	czcxAqNs27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeCYzT0oR4UxIrq1KL8uOLSnNSiw8xmgKD
	ZyKzlGhyPjDO80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamIIu
	tAj/mNh+xPOdRsLJwMuzCxzYD23NTTywOnCv+R///6ZpYlM0Ji7g6uJUcF/KufFc+guRBd+d
	J094E/vI2lhFV/zLlre5YgXbPM+e9rp5JfN1063L5lNfGLhKT5o879++LdtUvt5Yrf1ba9dR
	fv2y+b0CLUWmu09Hc/EY6+j28EZxCTK2K8hXsk9/fmej/LMj3DNc/U4JTvjQmHDquIOqpdGE
	ZcKM2xuufHydnrMkaPalRc8O/e40/DR3967Hxx22TpOWeaHccbrm+6rQyuK1fqm5tj9sOP7p
	sTmd2OZUeH7/jPw6xts1F4VqXLKZo02PhGlLy+vVa5Q/KtBV3H7294tug/SkM8lRZmdXGSmx
	FGckGmoxFxUnAgDPIKjIOwMAAA==
X-CMS-MailID: 20240716154525eucas1p1153a0288f3148c1870b58156c73c30e5
X-Msg-Generator: CA
X-RootMTR: 20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759
References: <CGME20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759@eucas1p1.samsung.com>
	<19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>

On Sun, Jul 14, 2024 at 12:00:23PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 14 Jul 2024 11:52:13 +0200

Not sure why this got forwarded to me. ccing arjan@linux.intel.com
as he seems to be the author of the file.
> 
> A single line break should be put into a sequence.
> Thus use the corresponding function “seq_putc”.
> 
> This issue was transformed by using the Coccinelle software.

A couple of comments while I'm here:
* The "why" is not clear; please clarify why a single line break should
  be put into a sequence.
* I don't think that a one liner merits the "coccinelle" comment.
  However, if you *really* think it should be there, please add more
  information, like the conccinell script.

Best

-- 

Joel Granados

