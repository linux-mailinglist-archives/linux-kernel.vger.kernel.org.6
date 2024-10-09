Return-Path: <linux-kernel+bounces-356623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A2996447
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53546B2120C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6718785C;
	Wed,  9 Oct 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DzV2KEAJ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D855E53
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464348; cv=none; b=n9yLvWw6peIJhfN7rY+Cf+mms8atYfDVdZrz/QXxnPs9hBSNagbQBCPSRYZA8DJ90zFrL2VqvMahZPbnUnUGctcz1S5XYuN3Sfp58XFgmbhDQtXHehf2DVMUpV02/4NiKXlX+0kRmOwTvjsFiqqgwH5B8P/LtINwQ2KepFyaw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464348; c=relaxed/simple;
	bh=AE91uYzPex7MgSqNcEqYCVYRV0+qB+b8401HVm7HCsA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=JVLxQ5emhYCJY1HJrO0woB0ypOb4QjsUxnNY18e/Y1jRcxI6rf34Tq/Reo1qtPPFl2EOgxeFa6N19eNYaMyIhoohia0crM+xYEBJy0rted8IrkjdiUOFES1yAB/8DGpzpXVmWWLd6U/Jy2NjfXE1amYtg3wYjo4Q6ig4eo7Z+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DzV2KEAJ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241009085903euoutp02fc0b98562ff1aa862c84eaeb4901df5c~8vSml0qDL0537005370euoutp02B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241009085903euoutp02fc0b98562ff1aa862c84eaeb4901df5c~8vSml0qDL0537005370euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728464343;
	bh=Pz//2juLg2kouxxI/Hqa+ie45cXol2kYTNlz8ptRc5Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DzV2KEAJFN20LEIBuOhvMmMvgGhKp9Fublsr1FsbG/zOz4tXSQclT+1FBNUQtYYr0
	 iAWBAR3rUl1gXfFxaEbqjxdE8T4YTxzOiz1JHsJ67FZcTeoPk6ZPrcGyf+uFch6/8+
	 U9aYPXyuL43XCfpjKWZzSlU6wxrYly+iUlpYNxh0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241009085903eucas1p1a5e6eadfe4bca2166e5182765e9d1a56~8vSmH0Kvo0627606276eucas1p1F;
	Wed,  9 Oct 2024 08:59:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B5.30.09875.6D546076; Wed,  9
	Oct 2024 09:59:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009085902eucas1p122d2027d691e69dcb4e404c1b3a779ed~8vSlTlVDc2554025540eucas1p1H;
	Wed,  9 Oct 2024 08:59:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009085902eusmtrp17f127f411c13cc5ea7c86e47f553fc3b~8vSlS2DMA0231602316eusmtrp13;
	Wed,  9 Oct 2024 08:59:02 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-4b-670645d68280
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7B.C8.19096.6D546076; Wed,  9
	Oct 2024 09:59:02 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241009085901eusmtip26fee5582bc08f675b79c826da3ecacbb~8vSlGj8Zi1088210882eusmtip2L;
	Wed,  9 Oct 2024 08:59:01 +0000 (GMT)
Received: from localhost (106.110.32.107) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 9 Oct 2024 09:59:01 +0100
Date: Wed, 9 Oct 2024 10:58:59 +0200
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wen.yang@linux.dev>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>, Christian Brauner
	<brauner@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	<linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
	<joel.granados@kernel.org>
Subject: Re: [RESEND PATCH v4 5/5] sysctl: delete six_hundred_forty_kb to
 save 4 bytes
Message-ID: <ebhtelo7eoonscepify6wbvca6s2zvnpyookcwzo3jzbqg44ke@5j4psffltsbl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008151700.12588-1-wen.yang@linux.dev>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7rXXNnSDZ7NsLJ4ffgTo0XDxAYW
	i//bWtgtziy+w2JxpjvX4vKuOWwWNyY8ZbQ49HY6m8X7NfdZHTg9ZjdcZPHYtKqTzWNhw1Rm
	j/f7rrJ5zF5yg8Xj8yY5jymH2lkC2KO4bFJSczLLUov07RK4Mv7sWspW8JC/YvPvz4wNjCd5
	uhg5OSQETCServvN0sXIxSEksIJR4tTpN1DOF0aJSxO62CCcz4wSP68tZIFpmX7uPJgtJLCc
	UeLR2kq4ou2PV0K1b2aUOH11IjtIFYuAikT73n4mEJtNQEfi/Js7zCC2iICixNy9i5hAGpgF
	djFJLP3xGywhLBAh8e31TrAVvAK+Ep+mzmWEsAUlTs58AhZnBhq0YPcnoPs4gGxpieX/OEBM
	TgELib7jkhCHKklcnXAX6uhaiVNbboGtkhBo5pQ4/+orG0TCReL8rVdQRcISr45vYYewZSRO
	T+5hgWiYzCix/98HdghnNaPEssavTBBV1hItV55AdThK/H3exg5yhYQAn8SNt4IQd/JJTNo2
	nRkizCvR0SYEUa0msfreG5YJjMqzkHw2C8lnsxA+W8DIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0
	L10vOT93EyMwKZ3+d/zLDsblrz7qHWJk4mA8xCjBwawkwqu7kDVdiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgUmuU+bP3ST3Mv3+A54S/165KezbeGPr
	jo1fbd+7lC2wZntdKv+8fbt91N5b1mtm9p6xY9P9Hv49bO4bF+997up/HyzOPVXrlSRozrGs
	7KOv8jc9nmMbnnJp6Bw06lz95WHGCo7YO4t1/Y/+Pto4Raho7vtbplNv3Gb0jZVY+Dh6SbCz
	SXNE3I3ZUXdyLxzKY64MF3+Wo7n8mS5zWkXEkzXh5o8WRSxdcveJTIpv3+Mdyeem5m/yfKYX
	oM2/47qKF8cKx5bVv3+rmZzdcTDc8fudqXLadScUMxQPWtdbp1xfy7aXq3Jy9V71OUYrf1Y+
	+m1QeU4k7saGl2afU9Y8+S3E2nm4Mqmkw0EvXXam1E4lluKMREMt5qLiRAAKlrnGuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7rXXNnSDR4cZbN4ffgTo0XDxAYW
	i//bWtgtziy+w2JxpjvX4vKuOWwWNyY8ZbQ49HY6m8X7NfdZHTg9ZjdcZPHYtKqTzWNhw1Rm
	j/f7rrJ5zF5yg8Xj8yY5jymH2lkC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
	rYxMlfTtbFJSczLLUov07RL0Mv7sWspW8JC/YvPvz4wNjCd5uhg5OSQETCSmnzvP0sXIxSEk
	sJRRovv6I3aIhIzExi9XWSFsYYk/17rYIIo+Mkr87N4MViQksJlRonULJ4jNIqAi0b63nwnE
	ZhPQkTj/5g4ziC0ioCgxd+8iJpBmZoFdTBJLf/wGSwgLREh8e72TBcTmFfCV+DR1LiPEhm5G
	ibvr2pkhEoISJ2c+AStiBpq6YPcnoDM4gGxpieX/OEBMTgELib7jkhCHKklcnXCXBcKulfj8
	9xnjBEbhWUgGzUIyaBbCoAWMzKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3PbsZ9bdjCu
	fPVR7xAjEwfjIUYJDmYlEV7dhazpQrwpiZVVqUX58UWlOanFhxhNgUExkVlKNDkfmBrySuIN
	zQxMDU3MLA1MLc2MlcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpgamVjlg6rr9Tnll9W33BS
	baXPmrtMVQJcqXrtrHNmCPj8mjK1gSOD1e3v8u7GW08m/ulbzM5wvkrMTeHozpCjd+6afSyL
	VJgTvnvj3RWnKxaZsHMdYjre/KDxKkvGQff7mWfa1tx7ezQi9vK0Nx28vSefzvu73vBuez+f
	1qEzHomr51aYO8p8vnfjR0T4dmvHE7Y8smGfL/wNv7AicPtKY9XmTQ9YTl3zfzs1VCr4plDm
	Hgd+A9kaiX/bbXYE1ni/U+BIYBPpWZ3v9PGF/Jf8tqKWi9dq5xn38xz61dzPLdTcKaSVePBg
	3hG9G2wnKtiuBKT+4ox5/LZVyDPa5ouN1OoNVkt1pcQqVi5Y8FJIiaU4I9FQi7moOBEAwlMi
	2VUDAAA=
X-CMS-MailID: 20241009085902eucas1p122d2027d691e69dcb4e404c1b3a779ed
X-Msg-Generator: CA
X-RootMTR: 20241008151741eucas1p15a64c181565d210e6fdf23df870ee7c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008151741eucas1p15a64c181565d210e6fdf23df870ee7c9
References: <CGME20241008151741eucas1p15a64c181565d210e6fdf23df870ee7c9@eucas1p1.samsung.com>
	<20241008151700.12588-1-wen.yang@linux.dev>

Hey 

I have the last version in line for review this week. I'll ignore this
"resend" as it is the same as the previous email.
FYI: I have moved to joel.granados@kernel.org. please send all sysctl
related stuff there, I might miss it if it lands here.

Best


On Tue, Oct 08, 2024 at 11:17:00PM +0800, Wen Yang wrote:
> By directly encoding specific numbers into the min/max field,
> unnecessary global variable six_hundred_forty_kb can be removed,
> saving 4 bytes
> 
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sysctl.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 05197d46007d..c8460b5e0605 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -90,13 +90,6 @@ EXPORT_SYMBOL_GPL(sysctl_long_vals);
>  
>  #if defined(CONFIG_SYSCTL)
>  
> -/* Constants used for minimum and maximum */
> -
> -#ifdef CONFIG_PERF_EVENTS
> -static const int six_hundred_forty_kb = 640 * 1024;
> -#endif
> -
> -
>  static const int ngroups_max = NGROUPS_MAX;
>  static const int cap_last_cap = CAP_LAST_CAP;
>  
> @@ -1964,10 +1957,10 @@ static struct ctl_table kern_table[] = {
>  		.procname	= "perf_event_max_stack",
>  		.data		= &sysctl_perf_event_max_stack,
>  		.maxlen		= sizeof(sysctl_perf_event_max_stack),
> -		.mode		= 0644,
> +		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
>  		.proc_handler	= perf_event_max_stack_handler,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= (void *)&six_hundred_forty_kb,
> +		.min		= 0,
> +		.max		= 640 * 1024,
>  	},
>  	{
>  		.procname	= "perf_event_max_contexts_per_stack",
> -- 
> 2.25.1
> 

-- 

Joel Granados

