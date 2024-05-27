Return-Path: <linux-kernel+bounces-190673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1198D013E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912C51C21932
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E415ECF1;
	Mon, 27 May 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mflf9vpD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B543AC1;
	Mon, 27 May 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816110; cv=none; b=MB4GEmxUJNuQrTfX+8QDPfP1zRzIfkyle8dvIFVZc2T5gOR2dm6zj4M+u52aXuM1pui72ecoqwZ5H2k/UgPkZMPNgn0Sh7Qs8sabX2WHLJTuk3UHi6iCOIAs8WEI/IfNM8udcYdt2Ae6aLEcy9tD9KRPPkTsFJRz3VBzsdqgfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816110; c=relaxed/simple;
	bh=LhIMyM7Q1PMo3Lw0qt2I3zHR0JcJLpGAUAcCqpa58+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUg7xQQONgV7P5ptz1ReQra1eXcgtQ5gDDldLi1v5lkYnKKFQp+nVwEmrZ0zvCF2JHekVDl/QVajCW8Sss1Q+/b2yw78MUNcCIihQpNFRG7T/U+DnLpLCcIon5jUpl4w91LVzkEjHUihGEGQxS/R7FurmYO5EM6uoPA0JsY4D3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mflf9vpD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a52b94c3so6605365ad.3;
        Mon, 27 May 2024 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716816108; x=1717420908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csiiP32o7V0QfgwfDEwBkwjUhpQOhY+JNgQcN0UEYPc=;
        b=Mflf9vpDisabKDkLXB6aV1fKf/HCkn9jLK/fRXe8FcoUEsOVhU2bVmm/F2PkA0iXx1
         sSdEZNrm/pFJcSG2RDARUsoICPchEmk0fA4PCa4d/o9lGU+6dwpNFbuRkOjpAxh/xAvE
         ZZ0mjyGdhc1QfsbXZWeHvI5HEoKBZFdhGBxb0aNpKEoOTC7btCdcObwLx4LVGGIa0LBG
         Rv58lpol2d2xd6kC6IRYiSsFoOzKzHB27LgT/TUbm5NauQqnjV0Ny4aw15yAXQerwKsV
         OK8mSAkWCWyBBE9ph3v5ogIUHXcBXXNrK+nO7SXbKsnoyaOOxlwNK9OIOu9s3XtybuMh
         gHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816108; x=1717420908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csiiP32o7V0QfgwfDEwBkwjUhpQOhY+JNgQcN0UEYPc=;
        b=B3K/ZA6JKBl+zOxL1ZMdn2wzAQiu7FqzneLALd3Hjg1RcN5x7YijsvvvcvZzZ4GbXs
         C0dQQSgWU/BYAuPkUxQyRupxIoA0ZEgHnu6Dd9JQf/L5d4ba5A3NeXKyofYDstIYeIU5
         xgc36Ak2J7P7Hu/Eqb9vYhPZMKMVOeLhtKRK3cLoUd3pqZJTvooHaKOw1eFoJn3ntOdN
         XSq8r6U+6Fy3+zxScOX7YLV29v6P2/pKefDSiLyXOK4T4eD0DLHhDHk4v9saREmxnsLp
         dAmh8tSjcZl+Bmxn3s2G9FJZBzDKS7kqpLiE5pMX4BK/52ux51RGi9PRsFNhUEOnUaZI
         i07Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXctR2kxuzaLOmZD1vH5yYGRYiPl6WeJojRZkoImKbDyqsK7UZ4fyMgCP1jhNmtGyE6yB3Onle7DLHT/sujyRuDUJz+9P4iHzLDitle0G8Yw91Ed1gRdSGpN1KwI5WS7mfFXyIdEbjsZA3MMGSlOY1Iz1sl5m09neJzNxluTvR9aGD
X-Gm-Message-State: AOJu0YxI0+pNPLV7ZXujecGJBUND89SCdVzqCCaHmg9d5s+GFPNxp+PN
	ib6zm13ESQKahynCS6O4adoFZ/7ou1KmL6qxMeP6NuJtSUqy+5qd
X-Google-Smtp-Source: AGHT+IECc6I+wxeOCmvUlz/sds6+InCkcpa/gLRp/BqLxWTt9sf2LZk9n0dHEAlhEO+pxx48Q3Wirw==
X-Received: by 2002:a17:902:cec1:b0:1f4:8e6d:6efc with SMTP id d9443c01a7336-1f48e6d7307mr44291085ad.5.1716816108025;
        Mon, 27 May 2024 06:21:48 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967925sm60465375ad.168.2024.05.27.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:21:47 -0700 (PDT)
Message-ID: <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
Date: Mon, 27 May 2024 22:21:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: cve Korean translation
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Jinwoo Park <pmnxis@gmail.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527103003.29318-1-yskelg@gmail.com>
 <87ikyzpgqz.fsf@meer.lwn.net>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <87ikyzpgqz.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/24 9:43 오후, Jonathan Corbet wrote:
> yskelg@gmail.com writes:
> 
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> This is a Documentation/process/cve korean version.
> 
> Thank you for working to improve our documentation.  A couple of
> questions, though:

Hi Jonathan, Thank you for the review.

>> Reviewed-by: Jinwoo Park <pmnxis@gmail.com>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> 
> 1) Why do I have three versions of it in my mailbox, sent over a period
>    of 13 minutes?  What changed between the versions?

Sorry, I forgot the name of the reviewer when I first sent the
documentation content related patch version 2.

>    Normally, you want to wait for reviews to come in on one version
>    before posting the next, and you should put a comment after the "---"
>    line saying what changed.
> 
> 2) When did this review from Jinwoo Park happen?  I was not copied on
>    that.
> Thanks,
> 
> jon

Thank you for your comment.

I have updated the content from version 2 to version 1 from
Jinwoo's review.

In version 3, I added the name of the reviewer I forgot in version 2.

> ---
>  .../translations/ko_KR/process/cve.rst        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
>
> diff --git a/Documentation/translations/ko_KR/process/cve.rst
b/Documentation/translations/ko_KR/process/cve.rst
> new file mode 100644
> index 000000000000..9daacba8d445
> --- /dev/null
> +++ b/Documentation/translations/ko_KR/process/cve.rst
> @@ -0,0 +1,108 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:원문: Documentation/process/cve.rst
> +:역자: 김윤성 <yskelg@gmail.com>

I added Jinwoo's name here on version 3.

> +:감수: 박진우 <pmnxis@gmail.com>

Warm Regards,

Yunseong Kim

