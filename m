Return-Path: <linux-kernel+bounces-302970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426959605A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E41282AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2019DF48;
	Tue, 27 Aug 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uoKE0okl"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046C199EAC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751120; cv=none; b=W47U5RSaBcJgEpMIQICzf/5YqgQQb7fFvlEgueWuoKFHkHBFE2SdfaRCZxUwiNLw2XVwdPQLMpDbt/ZxKah+tY58WzaTedEhfRNlklTOy/382ZO9pGNzmQWJ4KZKp2Z4DxfaDeCISxgZR5lSZ3JvqrkKCckaRhTWf0/7d3NJruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751120; c=relaxed/simple;
	bh=do6qHWTCeCm3l9cSLUTNHKqPwqIuzgkjJyKydTBCk+Y=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qLG4rdYF6AH6KiAVLomGIiuf0OXvtfPGpxQsD/WifbjCe4iLtTKy5SExVBKVwdCFeCIXHUFFvBJgmQuStirmvaME6fsTT79Va93/mXMKPgfH0wI2wrlChCPt/gr9R0Hf583YaiSjbJyQpI/XsxK8V9ppN4nxMj+Fi+Cw3+15Rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uoKE0okl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240827093155euoutp01055dbabf293d5474ceaa45939ddf7adb~vjABzqfSS2692126921euoutp01X
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:31:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240827093155euoutp01055dbabf293d5474ceaa45939ddf7adb~vjABzqfSS2692126921euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724751115;
	bh=9hd4V5Rw29ndlgSFlRBavMhK0dYlRqcgZq2zwQ6AjW4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uoKE0okliO8s2pKvHqf+1rgvbw/nbRHXAiVP879/kil4m0Z+5bHtHifBViz0vWK63
	 RKYFB2A2Sk3HK11Lyit+RQTbBGqOEc+pnVqI37Qba51qLRfuRiBI16uBWsJhMQdMmv
	 TXbBqATXimy3CeC71zTgFJJi3SLmNTfIxON9LaQ8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240827093155eucas1p1532b47792177f1da96cf0b459ff5ec70~vjABrDMw32410324103eucas1p19;
	Tue, 27 Aug 2024 09:31:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 19.F1.09624.B0D9DC66; Tue, 27
	Aug 2024 10:31:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240827093155eucas1p1af26cb2c3a568d77ee6cc9034f775bfb~vjABWAgdn2370023700eucas1p13;
	Tue, 27 Aug 2024 09:31:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240827093155eusmtrp241b78b8d98cc4f9a2629b5f2e5d69bab~vjABVK0hA1596315963eusmtrp2E;
	Tue, 27 Aug 2024 09:31:55 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-fa-66cd9d0bac66
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.15.09010.B0D9DC66; Tue, 27
	Aug 2024 10:31:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240827093155eusmtip1a7b7f914f6921277dbed2144fce2749b~vjABJLBL40835508355eusmtip1Z;
	Tue, 27 Aug 2024 09:31:55 +0000 (GMT)
Received: from localhost (106.210.248.81) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 27 Aug 2024 10:31:55 +0100
Date: Tue, 27 Aug 2024 10:42:02 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] sysctl: avoid spurious permanent empty tables
Message-ID: <20240827084202.6a2efzvosdpbc5ll@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4baef4a5-6b02-4e2f-870a-810c615a59ce@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOV3uuWfTDDomq1ise3ue1eLyrjls
	Fr9/PGOyuDHhKaMDi8emVZ1sHp83yXn0dx9jD2CO4rJJSc3JLEst0rdL4MqY3nyJueAkf0Xz
	/lnMDYwreLoYOTkkBEwk/ky7wN7FyMUhJLCCUeL502VQzhdGiff95xghnM+MErNvH2ftYuQA
	a/m4sgAivpxRouvieUaQUWBF83dqQiS2MErsWDuFCaSBRUBVYsUKU5AaNgEdifNv7jCD2CIC
	NhIrv31mB7GZBdIlzr/YCFYuLOApsfu6KEiYV8BBYtHP8ywQtqDEyZlPWCDK9SRuTJ3CBlLO
	LCAtsfwfB0RYXqJ562yw6ZxA05veHWGDeFJJ4m1HFxOEXStxasstJpArJQQucEhsb2pmhUi4
	SPxqvg1lC0u8Or6FHcKWkfi/cz5Uw2RGif3/PrBDOKsZJZY1foUaay3RcuUJVIejxObfT5gg
	gcUnceOtIMR1fBKTtk1nhgjzSnS0CU1gVJmF5LVZSF6bhfDaLCSvLWBkWcUonlpanJueWmyY
	l1quV5yYW1yal66XnJ+7iRGYTk7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4ZW7fDJNiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqganS12e/gIyrZ1I77+Tg
	FWo/Z3sxfQ97cM5/M8te4dLJ61gPHLebzd809dfaA96Cr7U2fbvAttpuwe8HfKvlm/Wan2Qk
	eqz0PrJk4xNHv8lL97Fp3AhvN2v9cHPn03M+zKULav6c5gqRm1PeWPeuY4n38k7paN6QL5Z3
	JE+4uPxwz81N4W9POv688fMKfaeQg3bv7RZm3raziYj7zZtRIX/7egPDwrkfZyatns+yk6d1
	c6B6V7qA4b6blgXpgplvP3/KevPwkMK/AKfy/g1roxw32dt6hb85xu/R/core4+O6b4vdU+s
	NW8c8j/w8K1nt/iDC73HPy58K2jpmHfmmJX5rr3mgZL/GUTTp50JrVViKc5INNRiLipOBAAu
	CdewlgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7rcc8+mGTzYJWCx7u15VovLu+aw
	Wfz+8YzJ4saEp4wOLB6bVnWyeXzeJOfR332MPYA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
	yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jevMl5oKT/BXN+2cxNzCu4Oli5OCQEDCR+Liy
	oIuRi0NIYCmjxOFvu9m6GDmB4jISG79cZYWwhSX+XOtigyj6yCjRcmwRlLOFUWL/kymMIJNY
	BFQlVqwwBWlgE9CROP/mDjOILSJgI7Hy22d2EJtZIF3i/IuNTCDlwgKeEruvi4KEeQUcJBb9
	PM8CMbKXSeL66h4miISgxMmZT1ggevUkbkydwgbSyywgLbH8HwdEWF6ieetssFWcQKua3h2B
	ul9J4m1HFxOEXSvx+e8zxgmMIrOQTJ2FZOoshKmzkExdwMiyilEktbQ4Nz232EivODG3uDQv
	XS85P3cTIzDath37uWUH48pXH/UOMTJxMB5ilOBgVhLhlbt8Mk2INyWxsiq1KD++qDQntfgQ
	oykwgCYyS4km5wPjPa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gSl1XVnFDVWplZMl04J3RLzhuiA64WH0f/cyK4+Mi/eupc130+vcqVl807TkdsulSbNnNnaH
	3bJq9ra2012QKjkj7s7cjwk39q6WjzqdrOtt6njl+as/TVGhUlM3iM77dljFpTXV8+/EtNUT
	PFeLsN4RfeD2/WFR20pdyycrM+/u+BxWuMVhmnGgv59K2fErQo03FI3nqMQcSdnuH3Gnsmrp
	7vMPXngofTR40GQkuLkp8Dn3lXbpZb8OTZlhcuHfSY6I/1WPj0bX/5v1TX7m585d6ax7Hp56
	3MGxYrJ3wKOJrUVV16foGoc8cC/bwVpc97At6Oum/edz3PQeCAp+FtLJKS/7yvCE0S05W1B2
	5jklluKMREMt5qLiRAAnCDPzPwMAAA==
X-CMS-MailID: 20240827093155eucas1p1af26cb2c3a568d77ee6cc9034f775bfb
X-Msg-Generator: CA
X-RootMTR: 20240805115202eucas1p1b459b87e0b9935d83ee52232d9cb106c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240805115202eucas1p1b459b87e0b9935d83ee52232d9cb106c
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
	<20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>
	<CGME20240805115202eucas1p1b459b87e0b9935d83ee52232d9cb106c@eucas1p1.samsung.com>
	<4baef4a5-6b02-4e2f-870a-810c615a59ce@t-8ch.de>

On Mon, Aug 05, 2024 at 01:51:55PM +0200, Thomas Weißschuh wrote:
> (trimmed recipients to only sysctl maintainers)
> 
> Hi Joel,
> 
> On 2024-08-05 11:39:35+0000, Thomas Weißschuh wrote:
> > The test if a table is a permanently empty one, inspects the address of
> > the registered ctl_table argument.
> > However as sysctl_mount_point is an empty array and does not occupy and
> > space it can end up sharing an address with another object in memory.
> > If that other object itself is a "struct ctl_table" then registering
> > that table will fail as it's incorrectly recognized as permanently empty.
> > 
> > Avoid this issue by adding a dummy element to the array so that is not
> > empty anymore.
> > Explicitly register the table with zero elements as otherwise the dummy
> > element would be recognized as a sentinel element which would lead to a
> > runtime warning from the sysctl core.
> > 
> > While the issue seems not being encountered at this time, this seems
> > mostly to be due to luck.
> > Also a future change, constifying sysctl_mount_point and root_table, can
> > reliably trigger this issue on clang 18.
> > 
> > Given that empty arrays are non-standard in the first place it seems
> > prudent to avoid them if possible.
> 
> Unfortunately I forgot to include the following trailers in this patch:
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408051453.f638857e-lkp@intel.com
> 
> They will be part of v3 if it comes to that, but if you end up applying
> v2, please do also add those trailers.
> 

This is a bugfix and it should be included in the next release. Please send this
commit separately with the Reported-by tag, I'll make sure that this gets pushed
up for 6.11.

I'll add reviewing the rest of the patchset to my "coming back from PTO"
todolist. But since we are so late in the cycle, it might get bumped to the next
release.

Thx

-- 

Joel Granados

