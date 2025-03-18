Return-Path: <linux-kernel+bounces-565431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2407A667FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF21A7A65B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47D19F47E;
	Tue, 18 Mar 2025 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="d+GUCmqy";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="7Nyq9rTL"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1374A07
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270543; cv=none; b=Drj0ajF3yBp24/5JOPn4OZL8lGwXhKRHiPhg48A4fP00k/gs0TvuMLdU4x6drLhsXiQFcgUdG21dQ9Ep4N6KX4VYISaTUtGDAreIpOIklk4PC+CY6cdOt/z/iTcaP7Dt7ajuYFqUOWLwD9w9hhEqxT3O5Jxf3dwyo4AA5p1mbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270543; c=relaxed/simple;
	bh=R/y39Q9Bhdo0nSLVG6I1fk0qSM+fj/yueSbOZFu9QP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pi814Z8uzo7I7MqgpLbUAY+1+4fh3XwB04sf3oJdlbC45exfm/l56ShOXPIW3YLAIVq30Ci2uTrknfamJwG2L2Lw8V4I15Z7JU1IC1WeoKRNoaBenXWu2kcy9TEGvWiNO6wdHWx6IPx8j0JFdIeFVybPoj88aodmlQ+NybLvw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=d+GUCmqy; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=7Nyq9rTL; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2602F2096798;
	Tue, 18 Mar 2025 12:53:50 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1742270030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BueBURAqez/aNAPyGa01dLPcAkY52H3a00C1QIgUBQI=;
	b=d+GUCmqylx7keyNZ35s6XYc9Kek9jyY6IYrwJlUjrOUXXvzt1JQ5iQIzhiDJjQwtAKroI7
	MM6IdVrgSZzaK0ZzdcKaeGu4pFEvTp0cDK2Hnwmah3/krre6h184CkI2nw74h2ZzOCddnU
	+GHxDPr3/SX3rbKd1DwCGzRDd7ziVHyPnNY8MZwaMMp3pY1yEmr7t+eVZbEArmXPIBcCVy
	UWoc4GfcxE1g4rx8qco42wy9/GvRtUImmBCQoZBpjPRJ75vK9cqKnZc5qOZ5mWu0Z8oPZ1
	+ABeVXiWvWPfn8W17ulBJgBG/D1JIn5zwzVfuwZdkoD5o7Dzq+0ZFY7dwdH56Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1742270030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BueBURAqez/aNAPyGa01dLPcAkY52H3a00C1QIgUBQI=;
	b=7Nyq9rTL7pFuKJXgQG/lf9MKI95rDCONG+k6CHuhBxoj5ESThxst4MdfA2xA5Ew/Il+x3s
	+T3uI82EFjIgjnDA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 52I3rmGJ195195
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:53:49 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 52I3rm80471649
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:53:48 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 52I3rl2U471648;
	Tue, 18 Mar 2025 12:53:47 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] fat: Refactor fat_tolower with branchless implementation
In-Reply-To: <20250318034309.920866-1-richard120310@gmail.com>
References: <20250318034309.920866-1-richard120310@gmail.com>
Date: Tue, 18 Mar 2025 12:53:47 +0900
Message-ID: <87tt7rkn90.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I Hsin Cheng <richard120310@gmail.com> writes:

> Elimate the need of if-else branch within fat_tolower, replace it with a
> branchless bitwise operation. This can reduce the number of branch ~130
> regarding to the test script[1].
>
> Test size can also be reduced:
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-68 (-68)
> Function                                     old     new   delta
> fat_parse_short                             1901    1833     -68
> Total: Before=22471023, After=22470955, chg -0.00%
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
> [1]:
> static inline unsigned char old_tolower(unsigned char c)
> {
>     return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
> }
>
> static inline unsigned char new_tolower(unsigned char c)
> {
>     return c | 0x20;
> }

Looks like doesn't work correctly. For example, new one changes TAB to ')'.

Thanks.

> int main(void) {
>     for (unsigned char i = 0; i < 26; i++) {
>         if (old_tolower('a' + i) != old_tolower('A' + i))
>             return 1;
>     }
>
>     return 0;
> }
>
> Utilize perf to profile the difference when using old_tolower() and
> new_tolower().
>
> $ perf stat -e branches,branch-misses --repeat 100 ./old
>
>  Performance counter stats for './old':
>
>             2,6302      branches:u
>               2334      branch-misses:u
>
>        0.000754710 seconds time elapsed
>
>        0.000000000 seconds user
>        0.000804000 seconds sys
>
> $ perf stat -e branches,branch-misses --repeat 100 ./new
>
>  Performance counter stats for './main':
>
>             2,6172      branches:u
>               2338      branch-misses:u
>
>        0.000782670 seconds time elapsed
>
>        0.000853000 seconds user
>        0.000000000 seconds sys
>
> Best regards,
> I Hsin Cheng
> ---
>  fs/fat/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index acbec5bdd521..77d212b4d4db 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -35,7 +35,7 @@
>  
>  static inline unsigned char fat_tolower(unsigned char c)
>  {
> -	return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
> +	return c | 0x20;
>  }
>  
>  static inline loff_t fat_make_i_pos(struct super_block *sb,

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

