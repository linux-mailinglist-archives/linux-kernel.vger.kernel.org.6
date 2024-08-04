Return-Path: <linux-kernel+bounces-273977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E3947049
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5515C1F21448
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD2770E9;
	Sun,  4 Aug 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYV30Aej"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FC2FB6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798150; cv=none; b=cJfVFxaRLjpLadfGDxXNxkOnQpID9BB14CLJu3jst0awPZOdQ+s3LYKCWJpCpzIW1gw27Bw6L2TEe9fOULHotjhCf0NV17VcvUHmZyGZ7hPlvjAMvz4l7vkKOa4nL/1G5fnRPHrmX0UhIIEPANAlv0I0YYwonX1cGDWc53qOLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798150; c=relaxed/simple;
	bh=Ic83cIw3LZSk1lL+KI/T3gj6nn83gCmNiOvNt/JKofM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NR2asnB8pwe5+bqh0DckLxJsmtoocZGPQUt41VjwE4NzOTo/jeQsoxELCZX2okTVr1lfCAUbVu0p+DLndaX8ypxRfxRHCF8x9jGFTwtbRfV8HbKzrigfDP9CbBCcdDX9vNFMgB1mFhHlPsQQnFjCyTrl7jgCmpyIEqMyoO3qRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYV30Aej; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52fcdc2f1b6so1804633e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722798146; x=1723402946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0LY+LrUU4sorQ2vC2ZQPJhM+w3LyncwHBAPScP+Lek=;
        b=NYV30Aej1I2iUc+8x3ZVYrIcY5FXMBZGWJvOjfx6KIEmkmC/koAw5QndllVp9xQ97b
         vy2F1p6ciDc5/oBQVCjNfF9QVPTIOwCf4AQaI/K66XV6dXUMIiaHPRt5s6n3SFwx2vDD
         IZ8QJsQwtD44NGs5S4cWPuV78Cy/swn8hbvq8GHp6LvQWWyZtwyPCwkZUv/yTL3JHLBC
         hP3QN9ywPtssgZfwq/ncA7v9qmpGa4ShywwUkcJ+OwsZXwD0qzjgai5EkJWOfV51z9lT
         mfmNDogD2UOjJphhlAQ2eBkAoXA7GjNkuv4KR9uik53cmGpYl0pb4oUgyLmHtlVYudlO
         l6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722798146; x=1723402946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0LY+LrUU4sorQ2vC2ZQPJhM+w3LyncwHBAPScP+Lek=;
        b=ngS9mz2H69PmNYXEGMb54GS/0ajfsY5pHaAnYG8hRHvdBZB5AxokixdViiso69I4Fn
         OL0qX2isZr/VCng7/LicHepQDzp5LCSAwXtZbuRNIZKrQ9X9XtwxUtDChNFSqHKACDPF
         5VmfbVXJ6WbBlZvfm2Y/SWQvVT6+kQ/H3/mrqXJSfwajomayZvVbrg6V+LSAJLC3RJK4
         /Brr2lNE+WtEhVDUWkPhCpHAdNGO7kYZ2IZPEtiBji0dLr9PtDpOPqmdLrht9cZroG5e
         vt/6IAUH+qEqzwJEmr30TvsQRd0JHPOoeCoEvQcf6I471orjU8pna/oKQuw5bLfA4bSR
         LvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTDvEXsiwg3SkzrchVDKI3uyJRKu8Wd57fhoLQWloEJqScs6QbbC/SqxGdwx+VRj+khqP//gi2CfROsqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyupb+oogb0gbCQSJWMZ/IPgCqaKW5dQEX6z5GS6fgNfEduv/RM
	6b3fLmaEJY+l7DBAYVSCXqK0lbb/4sqOVYqK7PyoPl/XULGzkQXOr63CYgz0
X-Google-Smtp-Source: AGHT+IFSDZ2DPGUgfGkBrjHXRHxEAgseLumjghtbsTvTtxOpuxqtMuqcnqp0Qsa7uFe7ywiaDeKtdA==
X-Received: by 2002:a05:6512:3e0f:b0:52f:c142:6530 with SMTP id 2adb3069b0e04-530bb39b3famr3475784e87.6.1722798145182;
        Sun, 04 Aug 2024 12:02:25 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8571:6636:3ef:7fc1:f163? (p200300c78f2a8571663603ef7fc1f163.dip0.t-ipconnect.de. [2003:c7:8f2a:8571:6636:3ef:7fc1:f163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c58esm358837466b.86.2024.08.04.12.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 12:02:24 -0700 (PDT)
Message-ID: <a4cb6e95-3a61-4e2c-b401-916794a4ed02@gmail.com>
Date: Sun, 4 Aug 2024 21:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] staging: rtl8723bs: Delete unnecessary braces
 for single statement blocks in xmit_linux.c
To: jiwonaid0@gmail.com, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240804113249.10257-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240804113249.10257-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/24 13:32, jiwonaid0@gmail.com wrote:
> From: Jiwon Kim <jiwonaid0@gmail.com>
please remove the above line. It is not needed
> 
> Delete braces {} for single statement blocks to shorten code.
> 
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
> v2: Fix commit message
You changed the description and the subject.
> ---
>   drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index 1eeabfffd6d2..e0736707a211 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -144,9 +144,8 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
>   		psta = list_entry(plist, struct sta_info, asoc_list);
>   
>   		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
> -		if (stainfo_offset_valid(stainfo_offset)) {
> +		if (stainfo_offset_valid(stainfo_offset))
>   			chk_alive_list[chk_alive_num++] = stainfo_offset;
> -		}
>   	}
>   	spin_unlock_bh(&pstapriv->asoc_list_lock);
>   

Hi Jiwon,

sorry for bothering again. Please fix above comments.

Please also remove the "net-next" in the subject. Sorry I missed to 
mention this earlier.

If you send in a third version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp



