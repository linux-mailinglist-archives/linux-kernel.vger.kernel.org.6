Return-Path: <linux-kernel+bounces-254026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C7932A65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC4B20427
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29319DFB8;
	Tue, 16 Jul 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JssnHVGB"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C720198E80
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143637; cv=none; b=UgUyT/Vy2SS++TgUmk0rACl63lwTIZfZ0HMb+GGknRbnioDjH8WU9la/iFSF6f3+HNNtLQWevZkFGM+PsNhB/4pG5Zw7ZqkKcyEBZWcMUG8KXtV4nxwBzq7JqZKn11UBVN6jXCaPvukzUewDg2R45xqK6MGPNWFEzKKWGsoGxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143637; c=relaxed/simple;
	bh=KQLvrhyDyRu6Jkq/SEXoQ79OhFpYmddajTZWF7dJIsU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TGFL0NMIJ199/9k/eTRfuCNuHvVzGs8Y1OnXTllQDZcg4kD8mOZdSfDa9yu8M+RCbwQtoOl3C5QHrRnOk/kYxqOi6672J0Tg4+ahsLgHKiqzDqB39yo+VMqskdryWZg1ArG9bo+rgq3BPO4QnAlRFCYi3PDnG+dqj7QGZ3LqXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JssnHVGB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240716152712euoutp022764c03bd4b13c46ea5512bc4b74a725~iuwO7HK4y1326913269euoutp02p
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:27:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240716152712euoutp022764c03bd4b13c46ea5512bc4b74a725~iuwO7HK4y1326913269euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721143632;
	bh=We47i0v0+lEJOslEyH8BH76TcdwBxLs+mzDvnBOyK9o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JssnHVGBjkGUKsueyIXZERU0c1mAgau1wBvB89zYmB26SfkcIkEsb74PdSN7lcTc+
	 VWeYJH7I5AAh8ev+m6uwS2GVeniYlQUm+If0navhuZkxsq3z0KyZPCixL/zsHARhq4
	 Z5o9xYEuZA31IzrN6QvmWfxnKzuDhoM20jnYlCkM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240716152712eucas1p1cc6de578f794ae66e6b77620f7c2f0cf~iuwOswhBB0802808028eucas1p1L;
	Tue, 16 Jul 2024 15:27:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.37.09624.F4196966; Tue, 16
	Jul 2024 16:27:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240716152711eucas1p29ed61f9f5ab7f2dde7205caedf7477c4~iuwObQ3iP1537515375eucas1p2c;
	Tue, 16 Jul 2024 15:27:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240716152711eusmtrp14cbf827f81a53bbbf0097bd17905a505~iuwOaxUUM1693716937eusmtrp10;
	Tue, 16 Jul 2024 15:27:11 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-a7-6696914f5d3e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.EA.09010.F4196966; Tue, 16
	Jul 2024 16:27:11 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240716152711eusmtip2294dcb2fb6c5eb8c17a5d82e42698cdb~iuwOM8iye0554305543eusmtip2P;
	Tue, 16 Jul 2024 15:27:11 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Jul 2024 16:27:11 +0100
Date: Tue, 16 Jul 2024 17:27:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240716152705.juet6srejwq5o6je@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87r+E6elGTxbY20xZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInisklJzcksSy3St0vg
	ypg/5zJjwXXuime7n7E1MC7l7GLk4JAQMJHYfFK/i5GLQ0hgBaPEkYnzGCGcL4wS3W8/sUA4
	nxklGhacB8pwgnVse9bLBJFYzigx6f9lRriqwy83MEM4Wxkl/ry7zwzSwiKgKvGsfx+YzSag
	I3H+zR0wW0TARmLlt8/sIA3MApMYJTacv8YKkhAWiJE4378FrIhXwEFi0vJzTBC2oMTJmU9Y
	QGxmAT2JG1OnsIF8wSwgLbH8HwdEWF6ieetsZpAwJ9D8CQcNIK5Wlnj/YB8LhF0rsfbYGbC1
	EgIPOCRe7J3JBJFwkZi3+CxUkbDEq+Nb2CFsGYnTk3tYIBomM0rs//cBqns1o8Syxq9Q3dYS
	LVeeQHU4Siy+0cYOCWI+iRtvBSGO45OYtG06M0SYV6KjTWgCo8osJJ/NQvLZLITPZiH5bAEj
	yypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzARHP63/FPOxjnvvqod4iRiYPxEKMEB7OS
	CO8ExmlpQrwpiZVVqUX58UWlOanFhxilOViUxHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUy6
	x9hflsxddKiP4aFX8ILzSqbqdz3LI97We4sq7E/VsY+JlpnF5PPz6aUFold+7v4s29H+Jrvx
	zMlva/o+TXi7kPP8mZr7Tgq+VR8ufavsYevVOvwq4drdd/XhSq9zc7Vuvvlf/+bd7ZTt+sd3
	h2z6+vj/lG0+DUv/rbyisnD/9O/rDCszvnvM75tgdfrZvov3b7y948D6/86fzvW31klyeina
	xiwK2yb4WK+7yCJemm0u26lmLe1ojvtpBRIcBTtW/PFZ8XqrStbMVivZe8IheXULlSQl3Mt+
	PA/9cSC18OBlW2bZFPVNX9ITPyVala1j9t301E9Win2BltgCpbadezqilZoE9s350Tcz44+B
	EktxRqKhFnNRcSIAfZPsv6MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7r+E6elGfzYo24xZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInSsynKLy1JVcjILy6x
	VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5g/5zJjwXXuime7n7E1MC7l
	7GLk5JAQMJHY9qyXqYuRi0NIYCmjxNPGr6wQCRmJjV+uQtnCEn+udbFBFH1klDj0/TAbSEJI
	YCujRNPCSBCbRUBV4ln/PmYQm01AR+L8mztgtoiAjcTKb5/ZQZqZBSYxSkw7c5gRJCEsECNx
	vn8LWBGvgIPEpOXnmCCGdjJJPLlbDBEXlDg58wkLiM0soCdxY+oUoMUcQLa0xPJ/HBBheYnm
	rbOZQcKcQLsmHDSAuFlZ4v2DfSwQdq3Eq/u7GScwisxCMnQWkqGzEIbOQjJ0ASPLKkaR1NLi
	3PTcYiO94sTc4tK8dL3k/NxNjMAY3Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmEdwLjtDQh3pTE
	yqrUovz4otKc1OJDjKbAEJrILCWanA9MAnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
	2ampBalFMH1MHJxSDUzRR5OM7txnU3ohcbe8Qs9D6Oe6ifcnOLyoOu0XNcFD8sS7qk6pPv3n
	WoyLbjAp/QrcsXQOm57mwSzH+vN/U+e3bV515E/jR4HeiSvf6cavcdkcLnrl6rXw2ijn9/f/
	qrtu7rv/xaZdfj+3XNIfqUMNx1sSZlz4zbaDO7Q4g7Na40AiR/4ebvY2pkor3yPN1a0PbRlq
	v5/kfylsX/Dx6CudDYYZ+vtc/sy9kjDlkOSmL2JiV7yWzNosG7hi/vHDyyoSr3+YXvv4cN6/
	u8+FQlIsrcKOPpi84Xzzw7frFkXLP82W4Mzpm/VJzzBpRW2fahLXzozHgnemuFj6/Fv49X7I
	K7ZYT05v8SubV7pOmZSmxFKckWioxVxUnAgA49rQZUoDAAA=
X-CMS-MailID: 20240716152711eucas1p29ed61f9f5ab7f2dde7205caedf7477c4
X-Msg-Generator: CA
X-RootMTR: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
References: <CGME20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0@eucas1p2.samsung.com>
	<20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
	<20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
	<f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>

On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> On 2024-07-15 22:23:19+0000, Joel Granados wrote:
...
> > The merge window is now open. I want to send this patch on the Wednesday
> > of next week (jul 24).
> 
> Sounds good.
> 
> > @Thomas: Some questions
> > 
> > 1. Are there any updates?
> 
> No.
> 
> > 2. Does it still apply cleanly against the latest master branch?
> 
> Not against mainline master, but against next-20240715.
> To apply cleanly (and compile) on mainline master it still requires the
> net/ and sysctl trees to be merged.
> Otherwise some modified functions are missing, leading to (trivial) merge
> conflicts or the preparation commits are missing, leading to compilation
> errors.

Understood. I have just sent Linus the changes for sysctl-next, so those
should land in master soon (baring any issues with the pull request).

These [1] and [2] are the two series in net-dev that are the deps for
the constification treewide patch. Once these two go into mainline, then
we are good to go. Right?
> 
> > 3. Are you able to do the last update at the beginning of next week (Jul
> >    22)?
> 
> Sure.
Thx


[1] net: constify ctl_table arguments of utility functions
    https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
[2] bpf: constify member bpf_sysctl_kern::table
    https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*


-- 

Joel Granados

