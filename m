Return-Path: <linux-kernel+bounces-338394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F66985740
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4772840CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E42B15C12F;
	Wed, 25 Sep 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Lh6fCk0W"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144E1304AB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260727; cv=none; b=Sum9aNVmoQhItde3AIaLLtlh1HswBlqCkdtcn3+E/PjlkYysmk0i5F7PcF9EGP1DajUQ3HjNGhTQHbmp6XPuSMySGH/XTByZtU4C7xDhFBux6wqQWILlubrZWAsX7AEd67PybpqeuOpkn4JOreKOGnVKW7RCPEpaQzVMdRz7Mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260727; c=relaxed/simple;
	bh=CtkBB7iSZKLwqUtdCNWdXOgr902amQjJ7qoSSMaq/ls=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Lt7GCcYskS9tEpu02h7t82RWBBGYfr7J8L6LLnU9PlXLIVJM0VIrdRVo3LSGnXBUQbA4N7LHuzfDzgCSK1+LTvc7okVPwsUIy5C7s/bWLPSrNXi7hAq8TAY024xVOsMgxEcYo6Uu0Tk3PCvlbAFKydzxDnl0mh+ZPmuLI4KAkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Lh6fCk0W; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.10.2.52] (unknown [10.10.2.52])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8F3944076175;
	Wed, 25 Sep 2024 10:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8F3944076175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727260720;
	bh=QA2W00UTct8IwOfot8FLWZuYzEf/7eHlnAikYCPfKaw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Lh6fCk0WN6tDrZyOiUZcmq7PpaywwRqJqD3ZxNGlXVyy61BxCprLgzyAjMMePy4CW
	 543L7E1TwF2J2goi3mxGkO1DL4L9VwUufOWYYoqO8gsMpexyrEDMNsJXDkwxoSQ49d
	 amrYrZBnvdUm9/nt6aWOl2wkuG5Z+lzpJei1VFS0=
Subject: Re: [lvc-project] [PATCH] mtd: partitions: redboot: Added conversion
 of operands to a larger type
To: Denis Arefev <arefev@swemel.ru>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: lvc-project@linuxtesting.org, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
References: <20240910101133.18020-1-arefev@swemel.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <396dc03f-b4dd-0644-f50a-18613730845c@ispras.ru>
Date: Wed, 25 Sep 2024 13:38:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240910101133.18020-1-arefev@swemel.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit

On 10.09.2024 13:11, Denis Arefev wrote:
> The value of an arithmetic expression directory * master->erasesize is
> subject to overflow due to a failure to cast operands to a larger data
> type before perfroming arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/mtd/parsers/redboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
> index 3b55b676ca6b..c8f7e7b351d7 100644
> --- a/drivers/mtd/parsers/redboot.c
> +++ b/drivers/mtd/parsers/redboot.c
> @@ -92,7 +92,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
>  	parse_redboot_of(master);
>  
>  	if (directory < 0) {
> -		offset = master->size + directory * master->erasesize;
> +		offset = master->size + (unsigned long) directory * master->erasesize;
>  		while (mtd_block_isbad(master, offset)) {
>  			if (!offset) {
>  nogood:
> 

I guess the message has been sent by a mistake, the patch is already
upstream 1162bc2f8f5de7da23d18aa4b7fbd4e93c369c50

