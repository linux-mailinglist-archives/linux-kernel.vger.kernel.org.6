Return-Path: <linux-kernel+bounces-334925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1B97DE62
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CC6281AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9244CE13;
	Sat, 21 Sep 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZTm9SwR"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B71F957
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726944749; cv=none; b=o+2ImCEDxvqz1O0DYYrJWm/u+T7WXAWEbHRVnHJALvpBtHzsceOzZIguHM2eD+PchsaLSXfxU5d0nM0Lw/Cu9boO4coQEXMfE5aUH86LH731ZuAgBxymIHDmlj7Q0khZkTOTMu87BzXsxXxwFI6e02UoBqY+7Z9/laHS+qZWWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726944749; c=relaxed/simple;
	bh=y0vAhj+gJuLQudmeoh9YJwu94U8sUi5+oxqlubJ7LKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzpv+6biDbnHdcYMxsj5NJbsFkE5pPCLW38VktyIugYfwOutz+I1eq7KSXDFClKeXyZBhXEB6MV5611sfVAnTUFLgjiIwY9SbasmoRhPXAzwZmCsXZsRxEVYA2RrKn/FJjn/xmzk4rU58s4BDPLTc0ZtoTluuIRq+/0aZgqO0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZTm9SwR; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 14:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726944745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIx0jmfjYu+XHxpUO64KOWWTIAZrIVAT4metLc5p5p4=;
	b=qZTm9SwRiG24At1Xtl/MMXuVAyIRFnMOyOZtNugsXy8H1E5bHTs1K0VPEangX/9URaLNCj
	uC5imfNVOycp20CSzhsM/eMJhWQaKSOUsmZxq6hh7r04YGiJiHS1qf4NpqYi5iXDzu6cni
	uo1MZNWW3JMCHC6twt4/srN7krk0Z/w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Fix NULL pointer dereference in
 bch2_opt_to_text
Message-ID: <vhgla2z2s2mlsjiniqs6no5d6p7ksq5ipgogd2covx3wejeys7@ha32mumxipi3>
References: <20240916210310.14014-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916210310.14014-1-pvmohammedanees2003@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 16, 2024 at 09:03:10PM GMT, Mohammed Anees wrote:
> syzbot has found an general protection fault in prt_str [1].
> 
> In the prt_str function, a NULL pointer dereference occurs when the
> parameter str is NULL, which is called in bch2_opt_to_text when
> opt->type is BCH_OPT_STR. If an invalid index v or incorrect
> flag is passed to ptr_str, then this could lead to this issue.

this fix looks wrong; if opt->choices[v] is NULL it's almost definitely
because of a missing bounds check - I don't believe there are any string
lists where we have gaps in the options.

Can you add a proper bounds check?

> 
> [1] https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
> 
> Reported-and-tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>  fs/bcachefs/opts.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index e10fc1da7..72b87251c 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -420,8 +420,12 @@ void bch2_opt_to_text(struct printbuf *out,
>  	case BCH_OPT_STR:
>  		if (flags & OPT_SHOW_FULL_LIST)
>  			prt_string_option(out, opt->choices, v);
> -		else
> -			prt_str(out, opt->choices[v]);
> +		else {
> +			if (opt->choices[v] == NULL)
> +				pr_err("Invalid flags or index v passed to the function\n");

Also, don't use pr_err(); just do prt_printf(out, "(invalid option %u)", v);

> +			else
> +				prt_str(out, opt->choices[v]);
> +		}
>  		break;
>  	case BCH_OPT_FN:
>  		opt->fn.to_text(out, c, sb, v);
> -- 
> 2.46.0
> 

