Return-Path: <linux-kernel+bounces-210627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5181B904661
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7446B22687
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B3153835;
	Tue, 11 Jun 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jQlQvzNU"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2B2F2C;
	Tue, 11 Jun 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142465; cv=none; b=DuPJsQDKaZsIOQrYNOyAgmle0pGE4shgOoyQD0TcQedJ48RR6BaxxdxCsF+DYsBpMoBcX5RjzZqcWRWP97MWnD43gk7t/VNjKu2A2hHAuf34TIRf7AAVxVuKH3jWq3gYidXS8QdzGEJxX5m1qLd22HMZjXLKeTGLP2qejhJ4XPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142465; c=relaxed/simple;
	bh=2I1tHmbp82p4i0lqosKETBKEgxq2gJiVR+S18NV8Cm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRsw5zdA3tBTYy6Rk2yKXcrcV02va45T9ggjjPuXRO3fpS/tcInP3weds2skw34VH8CEkC1RHKhNkHa73QZ0pu/J1sN+EwVV8Lcb04SM8z6RebcJC5l+wh/t9MR5415LOZztce0nAevNF2ZeSV+5hhgRuRvUGz35mQeCTRGoTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jQlQvzNU; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0CA8A14C1E1;
	Tue, 11 Jun 2024 23:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718141905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkG8r/ezxubJtJGFN02+piiW7O8HV16/3VEHvWIhVI4=;
	b=jQlQvzNUsGTH+DR/bkCcW0PnaMBJwKoabsSR6kw739Mo3ilOcI6cZr/cbQ4bLvsdW/gasF
	BP3GYfX+2GI6z2ws04M633S9Mvu0srnlFCDOdJ2MrtTsYISWQQ6fcn2xOd7Wrl/A5Vaz3g
	Bb3UKBm6NQtcjucNLcpfDC+vMX+HoYZ2Ae4c3GMONmxE+l28D8SkLz/AiuA+ywXF1RZbnE
	aSiAJx86N9kcGdyqQ4AW6xQrSUFRqKANxA5VwYh5Oyub8kSkCIxoZUYFtkt3orweVisTsA
	QQEQByz+fSfGSquI0iXratb0jS5HwgRjzYlXFp2/gTFNp/9WZqJxGK4LJOygwA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 18dd1f79;
	Tue, 11 Jun 2024 21:38:17 +0000 (UTC)
Date: Wed, 12 Jun 2024 06:38:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <ZmjDuv_zuhA3Xp2m@codewreck.org>
References: <ZmjBHWw-Q5hKBiwA@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmjBHWw-Q5hKBiwA@x1>

Hi,

Arnaldo Carvalho de Melo wrote on Tue, Jun 11, 2024 at 06:26:53PM -0300:
> 	The v1.27 release of pahole and its friends is out, supporting
> parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> tools such as bpftrace to enumerate the available kfuncs and obtain its
> function signatures and return types.
> 
> Main git repo:
> 
>    https://git.kernel.org/pub/scm/devel/pahole/pahole.git

It looks like the v1.27 tag has not been pushed to the git repos (either
this or github), we're using git snapshots for nixpkgs, so it'd be great
if a tag could be pushed out.
(I think some release monitoring tools left and right also use tags,
even if that's less important if you Cc other distro maintainers... I
just happened to see the mail on bpf@vger.)

Thanks,
-- 
Dominique Martinet | Asmadeus

