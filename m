Return-Path: <linux-kernel+bounces-446835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406339F29BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4016430B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B11C54B3;
	Mon, 16 Dec 2024 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aUbZRcgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87887157469
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328332; cv=none; b=XpeqDUj/9htc2BQPR7xZDtPwHydckbja90qh5jKj5m9ir1qt710elNayQf3UTPPRrsDT0S7knh64eIo9GmOmhKwGnVkXEuW5Lw32UaDTObzHkHq45gKA1m1VUxoLFpLmBL2AI2h1WSNcCIKrRZyhwu62tgjbjbh66obz8xozbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328332; c=relaxed/simple;
	bh=qjSEykgVf4DoYoTv4HjgOKXB49ktqpaprzIS7i1NVoY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ril7l4b6jA+QxB6wB19pln2c0nw1rnjeZGtYO6JsKQpIK0XF3MrOrV2j5AkG3BhYeOVHevPc4ViXilCvPXA/T9PL+snIe15yGai3+iQMqi45AQNB0yopEFfoWFQ8ro/BBIQyliEOtxg+OJDFVzCzb/DZdA6srHDQ1TEvOpQDFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aUbZRcgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA9C4CED0;
	Mon, 16 Dec 2024 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734328331;
	bh=qjSEykgVf4DoYoTv4HjgOKXB49ktqpaprzIS7i1NVoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aUbZRcgxdoVAqH6h9vsfoZHelM1Ased8dKYWhUNsaZByUY5P2ISxOLQR4MiRGmVfv
	 tw1teO74yBK80XrTn7IXxXHNdivE/sR2CMVmYv7lS2M/2bGAHmC63EJOFLj4k81+Fp
	 2iO9noEZyFq7pTy6Gg5k9GCUtwbotFFCBvxSOFNM=
Date: Sun, 15 Dec 2024 21:52:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Leo Stone <leocstone@gmail.com>
Cc: syzbot+8a3da2f1bbf59227c289@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm: huge_memory: Handle strsep not finding delimiter
Message-Id: <20241215215210.b02854acf4ca32be83aff718@linux-foundation.org>
In-Reply-To: <20241216042752.257090-2-leocstone@gmail.com>
References: <675fa124.050a0220.37aaf.0113.GAE@google.com>
	<20241216042752.257090-2-leocstone@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 20:27:51 -0800 Leo Stone <leocstone@gmail.com> wrote:

> split_huge_pages_write does not handle the case where strsep finds no
> delimiter in the given string and sets the input buffer to NULL,
> which allows this reproducer to trigger a protection fault.
> 
> ...
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4168,7 +4168,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>  		size_t input_len = strlen(input_buf);
>  
>  		tok = strsep(&buf, ",");
> -		if (tok) {
> +		if (tok && buf) {
>  			strscpy(file_path, tok);
>  		} else {
>  			ret = -EINVAL;

lgtm, thanks.

The duplicated `buf' made review of this unnecessarily annoying, so...


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/huge_memory.c: rename shadowed local
Date: Sun Dec 15 09:44:47 PM PST 2024

split_huge_pages_write() has a lccal `buf' which shadows incoming arg
`buf'.  Reviewer confusion resulted.

Cc: Leo Stone <leocstone@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/mm/huge_memory.c~mm-huge_memoryc-rename-shadowed-local
+++ a/mm/huge_memory.c
@@ -4169,20 +4169,21 @@ static ssize_t split_huge_pages_write(st
 
 	if (input_buf[0] == '/') {
 		char *tok;
-		char *buf = input_buf;
+		char *tok_buf = input_buf;
 		char file_path[MAX_INPUT_BUF_SZ];
 		pgoff_t off_start = 0, off_end = 0;
 		size_t input_len = strlen(input_buf);
 
-		tok = strsep(&buf, ",");
-		if (tok && buf) {
+		tok = strsep(&tok_buf, ",");
+		if (tok && tok_buf) {
 			strscpy(file_path, tok);
 		} else {
 			ret = -EINVAL;
 			goto out;
 		}
 
-		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
+		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d", &off_start,
+			    &off_end, &new_order);
 		if (ret != 2 && ret != 3) {
 			ret = -EINVAL;
 			goto out;
_


