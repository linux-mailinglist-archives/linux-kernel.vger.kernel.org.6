Return-Path: <linux-kernel+bounces-187259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7718CCF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023ACB23384
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768141411DD;
	Thu, 23 May 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oSt/dpJP"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505913D51D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456203; cv=none; b=TEVLT6aYXucKWo+0oCnptQzeEzdDNKTPRpbbaVDtHj0iyy6XWb2wkahb7iLtPGlSBV9o072UE1r7onEoNv44hSnMAhEJZvnx6EvCPPzi+eZlDGjDgn09pHo0JXuZLO0ELcMRT05/652PKal3SXTWuU8dbPx3qZPOrl5UMF6feZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456203; c=relaxed/simple;
	bh=FxEgQ2M46ww0wpQM5t+QGhAhtJlzQZOGBgjrkSndrSo=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=r1DHCWdvo17aKBbsI53ckPKU4P12vkXRj1nvTtPboDue7XAmT89YamgdjULtrh+K1LpbexjrE/khTyetDaWNQCLMfkDe5110bzPZWQt7a9FqwGJdw71pzGJrcEqsWUbcBU+m9u5sZsNoLYDpWGikKlZsNqdDHqW27zPgGm+Kb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oSt/dpJP; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240523092318epoutp0374daa221fdfac98e6242462c92c224fa~SE9F4S18R2166421664epoutp03s
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:23:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240523092318epoutp0374daa221fdfac98e6242462c92c224fa~SE9F4S18R2166421664epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716456198;
	bh=KlOaCwQxSICkRstCpowtJ7ZRITRgzPxIIxTlCKKVUos=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=oSt/dpJPVED7UMEjG8mAzIZFkXR4eIeRvRpJeJlgvWSi2cJHZ1xmOf7la+cw/huCe
	 e5UB8gZgrWk1trLxjw4WdUVrsPQNDVImvFEStIOkd80DmVWyJeaWxEROxPLHo+D8rn
	 LgrcyVEEx8UENviJjCJmIB2GCbIarkBtW4LrN9qQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240523092317epcas1p1ac965eb311209ef51dca3b3e54679f24~SE9Ffmk7k2410824108epcas1p1y;
	Thu, 23 May 2024 09:23:17 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VlN514NVdz4x9Q1; Thu, 23 May
	2024 09:23:17 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-09-664f0b055bf6
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.12.08627.50B0F466; Thu, 23 May 2024 18:23:17 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
	=?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
CC: Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jaewon31.kim@gmail.com"
	<jaewon31.kim@gmail.com>, "tkjos@google.com" <tkjos@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240523085554.netvftdebmg5ie4a@master>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240523092317epcms1p220c5ebd665d2c7b6a8a43e884926573b@epcms1p2>
Date: Thu, 23 May 2024 18:23:17 +0900
X-CMS-MailID: 20240523092317epcms1p220c5ebd665d2c7b6a8a43e884926573b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmni4rt3+awd6jihZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eJO3ysWiyPrtzNZvJ9cbDG7sY/RgdNj56y77B4LNpV6bFrVyeax
	6dMkdo8TM36zePRtWcXocWbBEXaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
	DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
	5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnvL+6hrmgkbXi27S1TA2MP5i7GDk5JARMJF5e
	bmPqYuTiEBLYwShxaMJq1i5GDg5eAUGJvzuEQWqEBcIl5uxfxQRiCwkoSZz9cYUdIm4tsX/R
	DLA4m4ClxPabExlBbBGBIokbe76xg8xkFjjNJLHr03UWiGW8EjPan0LZ0hLbl28Fa+AUMJVY
	dQyiWUJAVOLm6rfsMPb7Y/Oh4iISrffOQh0tKPHg525GmDl/jj9ng7CLJZZ1PmCCsGskVpxb
	BRU3l2h4uxLM5hXwlZiy6DHYfBYBVYnGP1uhdrlILFjWCDaTWUBeYvvbOcygcGAW0JRYv0sf
	Iswn8e5rDyvMKzvmPYFapSbR8uwrVFxG4u+/Z1C2h8Tda7tZIGF7nFni56RVbBMY5WchgncW
	km2zELYtYGRexSiWWlCcm56abFhgCI/R5PzcTYzg1KllvIPx8vx/eocYmTgYDzFKcDArifBG
	r/RNE+JNSaysSi3Kjy8qzUktPsRoCvTnRGYp0eR8YPLOK4k3NLE0MDEzMrEwtjQ2UxLnPXOl
	LFVIID2xJDU7NbUgtQimj4mDU6qBqWmX2Omqc7ue1P37mrV4Orvxy471R1dse7FFSuL1zbZp
	Py4vKFhe6px/rUuX54Gds+qFqk//8xM8pUVzDW+0dYVU9Kz07vDgK2H3l3TxPftjfkLs0/y5
	YZ/vHfW9ZsjPuGVdmlLUdPY7ElNN5eyyXX0yJXweLdZds95FJUBG8SnPi68KhrObC9Orq6dK
	flyhJlEwNbjqY8y/gxIL7q/p/3JmqZrrLHNHls27laWP39Q5vPv0bVum+3dafU9vWd086eWH
	t3tvTDq85nSSfIqeT+2UXcfuxW7dlu8maPxduf1Girj+vt5W5xg+F67yhVuzH29fnPplWnD/
	rOZZ8mt6ns+d0+J+9dvG6rr7aVZ7A5RYijMSDbWYi4oTAZvst5ImBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240523085554.netvftdebmg5ie4a@master>
	<20240522081647.zlwenenrbrjemlp6@master> <ZkxN0yQ7Fb0X26hT@kernel.org>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<20240522084738epcms1p80845ffecee4fbab97b34fdf2ce1595a7@epcms1p8>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p2>

>[...]
>>
>>Hi
>>
>>> Maybe you can show the log difference, so that we can see how it helps you.
>>
>>For your new email, could you elaborate the difference you meant? 
>>Do you mean difference between existing debugfs membock interfaces and the one I introdued here?
>>
>
>You mentioned the difference between kernel version helps you locate the
>problem. That is the difference of your new debugfs.

Correct. Actually we get many SW release from chipset vendors. Even though
their kernel version is same, the reserved memory status varies. So we can
easily compare them.

BR

>
>
>-- 
>Wei Yang
>Help you, Help me

