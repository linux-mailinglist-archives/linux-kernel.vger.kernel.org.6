Return-Path: <linux-kernel+bounces-559837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28837A5FA76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F5D19C1FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87026869F;
	Thu, 13 Mar 2025 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUrQTPSQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32A145A11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881177; cv=none; b=Bu+4KD9wcF0/zVVRoXfW6DoRXrzn/zqUCgV+KZXJN/9lrSW2w68ELCJ8mc3xBWhhOJ/LQ/fUUObJqFqw7c0LbVjd63D/BgNEdMVdvtgU4Pofo9rX02HZPNkh+ZpZJJp7L7LWPrzKAUwyYLlTR6LhKUePYacO6twYNpiJk+bOHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881177; c=relaxed/simple;
	bh=BuAVugaGPUa0YOrWMOyfotBl7rFWr6L2tdgK1RgnWcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VihX3VFXM0PSxitE+k9wXXCz5r0peXZ54+Io0dVMdfiioKyg8hW7wYI0Qtm/xhiKT6cpMByCoc3l2RvxaRUE0cQ+NnYePngKgwn93fPaaKum0J4YCaOKYI8uxeOdpmxXnbWofNxpjFJkXmXyJDrPhh0XGUdDrkTtuaYXjkz/ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fUrQTPSQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAtMtd031670
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DAyFW6s9ZOdByZVdgGm+NCgHT40nuNamPjDacuh/RHM=; b=fUrQTPSQsOtzwCQg
	W1SJ0TNeVdRHn/tMF7VV4YGLgqxE3MFk3fmTgcnE55jbxfzZ6IHhubI4P/Kaz9fV
	t0YHnHLj/RX5Ykhat3+8BjJTksNp1zs9/aTxlr90O8ribK9BZXJgtCk9wQN4r6qO
	nbJ6DfQ4HpstI2XuvTB3rNikT8MqnaHw/JTXSQp8zNfytgqa0rFRqXCi0Wfuz4Y6
	bV8Od4MJXpyjlC9CGGWgy+nnq2OD0Hee8MC1T0YxrVq5IVe8XGQ8FkHEfSb6MeVg
	JlSZxJi+OPhmSy2QpW4BXa77IhM/sCh2EwUTrLJ6eozbJ0IqOfAImeDi0cE79Bye
	u2Ug/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bx1jgtjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:52:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so1913922a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881174; x=1742485974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAyFW6s9ZOdByZVdgGm+NCgHT40nuNamPjDacuh/RHM=;
        b=XSooKqBB8rNFvYO1Z3H3ITDIkn+WnqLSNGZv+MKJlIKjhmuzagy83BiGUjCvuhpjVw
         dUyeDleqIgMn6FY+882wDDjCRv6A4FIc5sRdn7uS8E4R/ZHpgk/kMogmOwyKJB7CyPdM
         MXA2JL2e2XDitFysRnljyD680LfSOQCA1Msmf1+jC7xRbWKxPyRW0pw5fhaF8gYYKjx2
         E2SYgr+zbmwpPJ4EJwHMAfF4ppAtkfJ1sjnTObKobaa2oC4ztXI/z9WvdooxrwhJQEol
         Yc63jMRiCW4707YqRw0MfpfEu2K3xiImFVqq7drxpHcmMPX1uFidHNa4OoK9XSw1iEbH
         ZgmA==
X-Forwarded-Encrypted: i=1; AJvYcCVLYh0nVSnarPaKWL+jPDzJsD9u6G3anygDcvK6yjiM7xJbh8LcHp9FiB4wXBl58QdDDZvuQZ1EK1PABCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBuYkatgyarYC7DjlLDneW2Zsrzy8K858yFRenNN8K6W1/eA7
	G1bVl0GEWkdGNJlMSXdXTL9XZNku2Oe4AgJNlIsJIcgbAILpOLdD85JePDiD9r8cVnSIBdHbrNl
	mJj8dCTUld+rLzdndh0lvhMNWZ3Rp17djouzaPQ3+XCcjbM1At1tErr9FRZs1v/I=
X-Gm-Gg: ASbGncs8rH7UOgLuYVZa3fwr/v2/isQLkiJterEw3d5qUhUYkKXAJNZJGmE82m1qDRy
	d/hvTj1pH9CKJ7hEP+zQnhY5xCu641jXaIdgnXlnEcXz7PsxbepmdHVaBwqtzrVImY4b3lfuAEg
	53WZhkxulbPL7nYOct5DwPkyEz2CJEL+OwO6zMoJhkaATWtUI3MQ+7Mh8oRLrKyhVIZwzOCuUbg
	5W7UbHbbDnw1pj4fXngdqWMm8Oy+TIXWWIK78WkhTBTgKlLCiSGNp0uw+RXZkbr1/m9vAYK8jQg
	AsZxgyEWECYIS/qQ0gRWX4eNT1fU/5HpjH9UFqHC0zCk/dpm1zLNrdn3tndWN2WukPuCm+gIMW1
	dGT9Wtc7r
X-Received: by 2002:a05:6a21:46c4:b0:1f5:839e:ecdd with SMTP id adf61e73a8af0-1f5bd77e205mr414627637.9.1741881174132;
        Thu, 13 Mar 2025 08:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxJ6KrfBFxtdVoI5JAAZUs42RAHXWqeboT7py2FAoiim99470SY7JOSvZRH0obsHEP1AtQaw==
X-Received: by 2002:a05:6a21:46c4:b0:1f5:839e:ecdd with SMTP id adf61e73a8af0-1f5bd77e205mr414583637.9.1741881173566;
        Thu, 13 Mar 2025 08:52:53 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c9e54sm1239916a12.9.2025.03.13.08.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:52:53 -0700 (PDT)
Message-ID: <1e8a650d-dd87-4ff3-ad83-da9e7f33a915@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 08:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nls: Fix utf32_to_utf8 parameter type in declaration and
 definition
To: ye.xingchen@zte.com.cn, brauner@kernel.org
Cc: jack@suse.cz, linux-kernel@vger.kernel.org
References: <202503131601265834sSbkAuqH0NUydxGXf-Fa@zte.com.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <202503131601265834sSbkAuqH0NUydxGXf-Fa@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNQqXQrD c=1 sm=1 tr=0 ts=67d2ff56 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=1RTuLK3dAAAA:8 a=RLfexGi2h6N7ieUIB9gA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: _2zQjwtVTA4_mqT3mhnUixbJ1kmT8rMN
X-Proofpoint-GUID: _2zQjwtVTA4_mqT3mhnUixbJ1kmT8rMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130123

On 3/13/2025 1:01 AM, ye.xingchen@zte.com.cn wrote:
> From: YeXingchen <ye.xingchen@zte.com.cn>
> 
> The declaration of utf32_to_utf8 in the header file uses
> bool maxlen as the parameter type, while the definition uses bool maxout.
> 
> This patch aligns the parameter name in the definition with the
> declaration,changing maxout to maxlen to ensure consistency.
> 
> Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
> ---
>  fs/nls/nls_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
> index 18d597e49a19..1dc2f8c8916e 100644
> --- a/fs/nls/nls_base.c
> +++ b/fs/nls/nls_base.c
> @@ -83,7 +83,7 @@ int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
>  }
>  EXPORT_SYMBOL(utf8_to_utf32);
> 
> -int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
> +int utf32_to_utf8(unicode_t u, u8 *s, int maxlen)
>  {
>  	unsigned long l;
>  	int c, nc;

It is obvious you didn't compile this code since the implementation still uses
maxout. Note that a less intrusive change would be to rename parameters in the
prototype.


