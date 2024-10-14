Return-Path: <linux-kernel+bounces-364071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B199CAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C65B20FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBF1AA7AE;
	Mon, 14 Oct 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7avgCd2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069C1A727D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910426; cv=none; b=TIzrsa9psuWwN+nw9i8YE/gMfBEKmo/peKXkzis9tvEhbmtLgvEbh0iiEyHY/xhHScKGQDl2hhmQRvkNOpFDZyaMJsbStAizgt/PVapQTsJFecsmZjCDm81EyrZ78hASz8dLz5Cf63iYmyA4rxTMmrR0gA17N/r5f8YMz2kDLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910426; c=relaxed/simple;
	bh=+pcu92eMqg+NHXSehZfy3gPTkISBMTAQR/PVez1N+qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFWZ43UdC6dDQMT2V40qkIyA+6AehzuY26asacsnb8uGHredm1LnbkLy+D+J8Y1LJPRQ7yTkIYejo4Kut0aetnlRm3ITQwIPntlE87XFtVgMAuAN1YaT9PsSHSgNnl4fC3eu/cUSk8U0veuG2Eg1rzdEOHl47U3DeHPAW46j4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7avgCd2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0084f703so229576266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728910423; x=1729515223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SyCHsuV/E8d70gfcK9ip53tgwN234YxCxe5zH8xLMPY=;
        b=U7avgCd2Kq1XxkEYlk4PupuY4CHxpsGoPm4vKOF28tPALoNUKrgikVf5GGJ+wx5Nef
         QtEA7ezPL+11HILyzfSu04/bPDphbjGhGLO6sBINBPdulB5rxnC9/Lt5xX3TDAIr/G3R
         3b0iYAfgibyIYxkfJHDz21fztzlUeniDmMkTY8VOw6LYxRmAw2BcGMTFGtIFaSyW80TX
         dqmg9VM/kliZkHjzW7mVfzpbsr9DVNDS5flwgBNMGrkgxlTCnjZxe7FJ+GmO5W0ynO3n
         Kt1UmcV6GzF/zgslKdCfTpf5+0wzHlLcYlcKTCWZu7XOHIEwqIKnMqQbHyA2qTRb58cO
         RWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910423; x=1729515223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyCHsuV/E8d70gfcK9ip53tgwN234YxCxe5zH8xLMPY=;
        b=Z807UraKBetM4Hm2pusMp91q2Rm8Kmu3IqOrFApgqFqT70wyh6J2zWLKlKwBCMsK35
         uZdPPvKNo8HqGdXBMiEoa7q4/jzCCstmXDDUmi142fK+E6pxxKxOThy8Mrz8aOQRMxI8
         QEnsmGcVQSV/79LM2B3HX58jqD1y8OjVJQ1HXDQkzXO8eWnW/o3Wk2bcj27ldXlHymG4
         fm3TP1SRyeXkVDHB0bpBByRwT2VudLnh6BzTo8GuChkF3kHxEibIxqGPoFo5KH8D1H6A
         sWAGpkfXSWQNxLYVfPhIZkzM48/vkTkuUllnh1bET2XEbF/mSB1o4seDWHcwurSpC32N
         qF1w==
X-Forwarded-Encrypted: i=1; AJvYcCUFKErBvt4ZqGoSThxYIeqT93A+vVHJWI5QlDdVXcmfl6hZ7zDWjyxcxQPyV2McmHyGjOEPxixRjJeHXoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNus6vGR/s2ty1FksS3rIkEGqa2fD3JGhM4Z7oe0YfCcQ0bU7
	YQJ5mn3Iig5wj+IFJtPyJEBMGQJYxIii3REV7/+UrdSJJjNHOS22hTKs9NvkFbE=
X-Google-Smtp-Source: AGHT+IHqHcsA+FZtp+v7kI5pgeIQE8uQgQTumNO5wX6KZkk6/bkHGwus6vrXYrx9c73EQIuXhgDQGA==
X-Received: by 2002:a17:906:c14c:b0:a99:6163:d4f8 with SMTP id a640c23a62f3a-a99b966b148mr1069583166b.58.1728910422787;
        Mon, 14 Oct 2024 05:53:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f375db53sm303654866b.113.2024.10.14.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:53:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:53:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, stfrench@microsoft.com, tom@talpey.com,
	bharathsm@microsoft.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix possible double free in smb2_set_ea()
Message-ID: <8bd0fae3-82fe-41c4-a4e8-3c28aa2b1826@stanley.mountain>
References: <20241014113416.2280986-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014113416.2280986-1-suhui@nfschina.com>

On Mon, Oct 14, 2024 at 07:34:17PM +0800, Su Hui wrote:
> Clang static checker(scan-build) warning：
> fs/smb/client/smb2ops.c:1304:2: Attempt to free released memory.
>  1304 |         kfree(ea);
>       |         ^~~~~~~~~
> 
> There is a double free in such case:
> 'ea is initialized to NULL' -> 'first successful memory allocation for
> ea' -> 'something failed, goto sea_exit' -> 'first memory release for ea'
> -> 'goto replay_again' -> 'second goto sea_exit before allocate memory
> for ea' -> 'second memory release for ea resulted in double free'.
> 
> Assign NULL value to 'ea' after 'kfree(ea)', it can fix this double free
> problem.
> 
> Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/smb/client/smb2ops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 6b385fce3f2a..5b42b352b703 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1302,6 +1302,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
>  
>   sea_exit:
>  	kfree(ea);
> +	ea = NULL;

That's very clever.  But I think that it would be better to do the "ea = NULL"
near to the replay_again label.  There are some lines where we re-initialize
resp_buftype[], utf16_path and vars etc.

	ea = NULL;
	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;

regards,
dan carpenter


