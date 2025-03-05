Return-Path: <linux-kernel+bounces-546280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06418A4F8B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE418923B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50031F7089;
	Wed,  5 Mar 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nyhwhmn5"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF811F560B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163043; cv=none; b=GBdNxtCL5PFrQy6oNz9uVWZElCWtXYtXm8yUb5DAV5ilvZmi47Rn2RaUMLC4LSPlAkp85kKD07J48cc62tGxdK3w9gqrejTUgLCPeSGHJenSbMntY28ECKRfWi3VTn1s84kzQwOaEi77AVsn4pgWVTnv4VxQ1NUgudIexezqP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163043; c=relaxed/simple;
	bh=5oioArqckWK7P85itc8aO9C5fWyeb++QRtIHYUaaxAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Qznj2IK8XSso5OnEhqjspLIlPlED6RXoBNf72Wl/deQBkephr2LPgt7XCjn3B0c7DiBfFr3KLN1DhQo1ZDQAfdHPb2k5gvjYF2S9HlV9bQZ3GSF+FGWPVxlPUSw0AzvzpaO76mKxx5wSqExCkyacBozj6UCXMgQ01gAwRFPLEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nyhwhmn5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250305082357euoutp0217be9fda77dc9b11693b59b1a730b82f~p2o61_HN91049010490euoutp02n
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:23:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250305082357euoutp0217be9fda77dc9b11693b59b1a730b82f~p2o61_HN91049010490euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741163037;
	bh=PGt1CSGjFMabgTf1srY6MXwWrrLW0AjKIgfy5jsvIPg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Nyhwhmn5VD91sXGi5UMQjRA4Ske6yzrWzPKD12OL275S7L62PmNaWKyR0quNGvRxl
	 yBJ36KO7X9sSOwbFzfEOrdflPFWdpJotgv1swt/ZiOot3biyE0NVa5qEuDVjhj16Ll
	 t3leF0vpOmUaXFcswMPAhiF8AZ+llEW9cJXV8YBY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250305082357eucas1p174954be8e28b7c00ffd1668d010ff52e~p2o6hZ4E21049710497eucas1p18;
	Wed,  5 Mar 2025 08:23:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 65.64.20821.C1A08C76; Wed,  5
	Mar 2025 08:23:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250305082356eucas1p2d936fbea7bdd26ab959db4b218062adb~p2o6KxHWu1585915859eucas1p2w;
	Wed,  5 Mar 2025 08:23:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305082356eusmtrp153d1eba5e52d6132a1e3c51fa69fd828~p2o6J-EcS0898508985eusmtrp1z;
	Wed,  5 Mar 2025 08:23:56 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-40-67c80a1c7667
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.64.19920.C1A08C76; Wed,  5
	Mar 2025 08:23:56 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250305082356eusmtip12d7cf33847491aed6d0a0fb5155f381a~p2o5mcXqn3232132321eusmtip1I;
	Wed,  5 Mar 2025 08:23:56 +0000 (GMT)
Message-ID: <4205b786-fb65-468c-a3d8-bce807dd829a@samsung.com>
Date: Wed, 5 Mar 2025 09:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] TH1520 SoC: Add Reset Controller Support
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250303152511.494405-1-m.wilczynski@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7qyXCfSDd7OY7RYs/cck8X8I+dY
	Le5d2sJk8WJvI4vFy1n32Cwu75rDZrH2yF12i7v3TrBY/N+zg92iZf8UFgcuj02rOtk8WtYe
	Y/Lo/2vg8X7fVTaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyjj9+QZrwUTBimOXlrE1MM7m
	7WLk5JAQMJHY93IFYxcjF4eQwApGifuH1kI5Xxglzjy6yALhfGaUeHByDVMXIwdYy6R7iRDx
	5YwSG6dfYIZw3jJKdM1ZxwYyl1fATuLh1/1MIDaLgIrE5L0tjBBxQYmTM5+wgNiiAvIS92/N
	YAexhQVcJKZMPQC2WkRgKdAdnb+YQRLMAjYSN9ZeZoSwxSVuPZkPNpRNwEjiwfL5rCA2p4C9
	xNZn/9kgauQltr+dA3aRhMAPDomrP7axQJztIrH2VjDE08ISr45vYYewZSROT+5hgbDzJR5s
	/cQMYddI7Ow5DmVbS9w594sNZAyzgKbE+l36EGFHiXP3fjNCTOeTuPFWEOICPolJ26YzQ4R5
	JTrahCCq1SSm9vTCLT23YhvTBEalWUiBMgvJj7OQ/DILYe8CRpZVjOKppcW56anFhnmp5XrF
	ibnFpXnpesn5uZsYgWnq9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe16eOpwvxpiRWVqUW5ccX
	leakFh9ilOZgURLnXbS/NV1IID2xJDU7NbUgtQgmy8TBKdXA5HTS789N999CN6MaZovLG76I
	5cp52jVfW+nhsexnJyRuFz+9L2/PZzV7j1yVTpqtgsW2Wwxpu1km1Dn8m3i1eVdCq3Ts1aLO
	g8LHKr3zMt/pf5jBq5R1snWucLhqZLjqpea4rvwfP7YwfnKrORzZr+7cru0hFdi38rfhaa5z
	NZErjM4FBoQGN+4qiH4sffbe5wkF6VMlFJd/YjMRdTsQWMT8y7vNKt7+WuP/C+k9fQeWtVQL
	pW4+6K26smyX2M45D5PCa7Zm+EZdX71s6pGnU2zfnTH1d05tnB53RkZls/hZYQ0+8+q02I6Q
	L7/frtm+THq5sfHD2uVxUpHS+qI2YV+jLx+teiCh9FV+VrQSS3FGoqEWc1FxIgDQ40YtwgMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7oyXCfSDbbPVbNYs/cck8X8I+dY
	Le5d2sJk8WJvI4vFy1n32Cwu75rDZrH2yF12i7v3TrBY/N+zg92iZf8UFgcuj02rOtk8WtYe
	Y/Lo/2vg8X7fVTaPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
	tTIyVdK3s0lJzcksSy3St0vQyzj9+QZrwUTBimOXlrE1MM7m7WLk4JAQMJGYdC+xi5GLQ0hg
	KaPE0ZVrmLsYOYHiMhLXul+yQNjCEn+udbFBFL1mlGj9c5wRJMErYCfx8Ot+JhCbRUBFYvLe
	Fqi4oMTJmU/AmkUF5CXu35rBDmILC7hITJl6gBFkkAjItnsfprGCJJgFbCRurL3MCLFhEqNE
	c+dSRoiEuMStJ/PBNrAJGEk8WD4frIFTwF5i67P/bCAvMAuoS6yfJwRRLi+x/e0c5gmMQrOQ
	3DELyaRZCB2zkHQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERiZ24793LyDcd6rj3qH
	GJk4GA8xSnAwK4nwvj51PF2INyWxsiq1KD++qDQntfgQoykwLCYyS4km5wNTQ15JvKGZgamh
	iZmlgamlmbGSOK/b5fNpQgLpiSWp2ampBalFMH1MHJxSDUytIvMS5aQrH92J/sLKd6XwdnDV
	ro+nt0Tk27uml3y/4Dz7sAVT42pePYePq257m9t6zDiz8YdlhTrXyxkWXp9e5BXFHRKx+ME1
	9e5ShbAJ/kwd0Xfv8mqYnklan+5+WuaIz5+uK9qXAq06L09Lzd982OLlz27PjJf/y9u3eyXz
	Ncx4ZM/F581azhZnK/n28vlnn6849D15y8zMs/rrlcg7C8zbJp0L/v3wEE+abXd9/AFPYzXR
	yix+Sfln+2+LNAjOXO+n1tjjck2kfMbSq1y7Vybllf5d6Lq0Y1rJJk62/ANiDTNOXHb+xlf0
	zsdI29BCUfntwZ2Bytbq+zd766ZvrljWdua4vSBPAMveEiWW4oxEQy3mouJEAH1Gj61VAwAA
X-CMS-MailID: 20250305082356eucas1p2d936fbea7bdd26ab959db4b218062adb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c
References: <CGME20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c@eucas1p2.samsung.com>
	<20250303152511.494405-1-m.wilczynski@samsung.com>



On 3/3/25 16:25, Michal Wilczynski wrote:
> This patch series adds reset controller support for the T-Head TH1520 SoC,
> which is used in boards like the LicheePi 4A. While part of a broader effort to
> enable the Imagination BXM-4-64 GPU upstream, these patches focus on providing
> a dedicated reset controller driver and the corresponding Device Tree
> nodes/bindings.
> 
> Bigger series cover letter:
> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/


This series should be versioned as v6, to maintain continuity with the
bigger patchset it is a subseries of. Please find below a changelog for
the reset sub-series:

v6:
 - split the reset part into sub-series, add the Reviewed-by from
   Philipp

v5:
 - Moved the reset de-assertion from the reset driver to the clock driver. The
   reset is now only de-asserted once the sys and core clocks have been enabled
 - Added and exported the GPU_CLKGEN reset, allowing the clock driver to reset
   the GPU clock circuit

v4:
 - reverted reset-cells configuration to single cell as in v2
 - maintained reset definitions in device tree bindings while deferring
   implementation of watchdog timer (WDT) reset functionality

v3:
 - refactored reset driver to use zero cells

v2:
 - developed a reset controller driver for the TH1520 to manage reset
   sequences
 - added new dt-bindings for reset

> 
> Michal Wilczynski (2):
>   dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller
>   reset: thead: Add TH1520 reset controller driver
> 
>  .../bindings/reset/thead,th1520-reset.yaml    |  44 ++++++
>  MAINTAINERS                                   |   3 +
>  drivers/reset/Kconfig                         |  10 ++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-th1520.c                  | 135 ++++++++++++++++++
>  .../dt-bindings/reset/thead,th1520-reset.h    |  16 +++
>  6 files changed, 209 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  create mode 100644 drivers/reset/reset-th1520.c
>  create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h
> 

