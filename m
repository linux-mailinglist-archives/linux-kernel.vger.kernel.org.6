Return-Path: <linux-kernel+bounces-334869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2F97DDB2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158AF281F43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3441741DA;
	Sat, 21 Sep 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="nS9ZcpEc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="AX9aX2vu"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA04155CA8
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726933134; cv=none; b=izQzqAQPVKCKZ7vtv5TLe9+SreAObNi9kZOexOJVuFRv1qW75A3kFJvZfPmnPDC0AqcW0+Jd5FtYbL7t7j/L5WJcm3AuR1qDrdXKAc4/mnC6hFP5ICmFDQs5AfUt4rnTFb9jv5/M5W1WBM0h08Z47/OsNzQgBl+54Vtm+lIimPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726933134; c=relaxed/simple;
	bh=pxxmCge3/fbp/g+GpHmeh7A8aAwf0mMZVrly2uBj+B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hj4qGsXyMvYApK98ZEjWrY1t1rG0OgR/nB0mAdMTFmQDIVFNj9/m1BzHEEE0OTLiOQOWGMOY681RrOVhmaWsEuLBVmdGLn0kZLbcd6iUmtjAUbuTpLJWzNs/UoV7gq1ddvdf9Iw6s1QL7T+uGfCnhTOLljUW1XJrE7D+6uzRn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=nS9ZcpEc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=AX9aX2vu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=nS9ZcpEcaMQYl7xuGFbn/1Dbn7dwNnYa09gvcHBIVMpjEj8D3dOrpvC6FK0rcyKMCnpAalRdhfIdNMEumRDhq3iaIlywlFVRUzwCDndqufD2ja2mxu5d1q3aIfECIJ7xm5tHUXwGFE7q+KGtdyZu++92OTjC/L+fV1O+rCO+5jDdxx5ZVyrMCrm4Uh2kCfvV2QT/OnZRguaF4ZD32/NxkHCEmvNOHz3HD98s03KQe2VRMOJxL72YR3z0GGZd7MHXP93N3B5wANseIYM77XRaSMUSKkDxaeoFyHwrOKyhCvRNPvjz6vhJu2Fv7VV9NLjMk9ScFkLP7UsR/Obh9DEgOA==; s=purelymail3; d=lkcamp.dev; v=1; bh=pxxmCge3/fbp/g+GpHmeh7A8aAwf0mMZVrly2uBj+B8=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=AX9aX2vuVkXGKG4NM+fEWBG9+dKaGdWwmcnIg5WnXlRKICuCf+xtT1DkHXmj3LebfiYLyFl+ykk2gq57gDZ31dtf+oAN8gZ/CW0zxgEReeaadV6tm2+2CQEU/XfmJ7FJNqKHA8hPmRpVpIJwtpEx1r65IwPylMaAQWag6cP9296BzHIm8oFdWhBeIX7hICC0OkM4F1vhIUJ0OUDY/kFbybw9MTslg8eimR9HsyuDCRVxy1Kbbcp6ay9WNOcyfMVhoGxh3BDKIkIduNT2NOmHnmfkMcbXAdQ9ItAJCFACtK4QI+RJcaISDN4KXKjIrl+3znzDZTl/EaMwGeIMVO9+zw==; s=purelymail3; d=purelymail.com; v=1; bh=pxxmCge3/fbp/g+GpHmeh7A8aAwf0mMZVrly2uBj+B8=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1611511204;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Sep 2024 15:38:39 +0000 (UTC)
Message-ID: <bf02d1e2-c912-4e43-9396-7e056d1b92ef@lkcamp.dev>
Date: Sat, 21 Sep 2024 12:38:35 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: Rename variable
 sm750_hw_cursor_setData2
To: Fabricio Gasperin <fgasperin@lkcamp.dev>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
References: <20240921152124.11560-1-fgasperin@lkcamp.dev>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <20240921152124.11560-1-fgasperin@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fabricio,

On 9/21/24 12:21, Fabricio Gasperin wrote:
> Rename function sm750_hw_cursor_setData2 to sm_750_hw_cursor_setdata2
> 
> Change made in order to silence the camelCase warning from checkpatch.pl
> 
> Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
> ---
>   drivers/staging/sm750fb/sm750_cursor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> index eea4d1bd36ce..e95f39b51a2f 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.c
> +++ b/drivers/staging/sm750fb/sm750_cursor.c
> @@ -131,7 +131,7 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
>   	}
>   }
>   
> -void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
> +void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
>   			      const u8 *pcol, const u8 *pmsk)
I think you missed one other occurrence of this function in the header 
(drivers/staging/sm750fb/sm750_cursor.h), which causes it to fail to 
build. Please fix the function name there as well. I think those are the 
only two occurrences of it, though.

>   {
>   	int i, j, count, pitch, offset;

Thanks,
Vinicius

