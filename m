Return-Path: <linux-kernel+bounces-554766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED00A59C25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3729C16DD31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE3230D2B;
	Mon, 10 Mar 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GZM3LX80"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3B2309B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626571; cv=none; b=VuP1h4XY5NHZg1yl0aG27xCZ7/EmS6FATfSMxxumVDGyNyaQS6+CcjOH6goPNdIlX4IdQi9VFCegQPK5oVLmZAqT49OWuzhB+e+EYG3cXzx1yYYBSIYJHYApFEnqFf5/6SJXPhoUP/iruZ8QVP0aMFTjEoltle2F8Bckmwxg16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626571; c=relaxed/simple;
	bh=vwwFEjCbBHP1TP6cNYmasyrSWTNU63nZlMAjN3MDtDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee+ZZMNZehdwHYPdeqIGxfY+5JwbSQ2taJQc4hnb0UskKOS4lFz+KmdUN0QHuoyowZeqVPQMpkLCK+cGNk/Ghi5fL09Ja/dDWPcjzh/lzPyPGfEpXzYWlES3vPRuBYuTnpJ0r3vMZmL62Jf0IoPtF0tVO86AVtveTlFC9Wz/rLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZM3LX80; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AA9TnZ030400
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kiESE3wnTdm5MieLpe83ZPyzj9dW/TZ+6Up49ZLOMzc=; b=GZM3LX801WeCDYMT
	cbDeQKWmHzZ3zyuO/fFPoM1zHm2nQpcQq8kFfvWGjZLUso1WgITgI7rcx2ZUdRh3
	YfB0KH3gt/SHvgGZTtQBAy+ReEffpJtPrIWA9hwAmkrau07slfDyDr/x4AgC2/Rr
	b/oQTdgXG9dC27LGPSqA8HaJxgbUXFdedxHQKYz+0qG51q9mVIAON3Ro+tkz3Cmb
	rRGmRjtR1T5eCPHL4+/NVMWU38fTHIUTOVf5bTkxt05WWWVpOk14bwXwNO9G8i4e
	VgmDOS8S55YbO0TPrSkf+3e3otZlYuVfpmbbowKkPAFXrGrb5wB6ltdBMpBucRS5
	OOPyLA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f1jwj1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:09:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso6314282a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626567; x=1742231367;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiESE3wnTdm5MieLpe83ZPyzj9dW/TZ+6Up49ZLOMzc=;
        b=BrYWSyZCbyjQSInBR9tjhvnHVzyXvuKZ65ku2WDZ2WRg0Cf68TXuPjCBEf9Y0XgS6+
         WrbT/GuG7UcYQrKQH/srf9v5nZ1SKFhFBo6vh5sBAlDUjShqz8g4fv8nWS451fbFhxrl
         MrxR6tCc72+sUmeBAXhfMEuL+PQgxPq1ikSVxbjN0jR/M9w0V2Xpm+4eWDJMLvyRiDxE
         4I1Az2VjkK10x05Wx0MOqFNG4J9H81Ea+iAWov6rWbkCvhjTCDGVtwkaXptqfNWxk1CD
         2RCFbJIZIF2TlAvrNU+RSXmVihl5ffw8v0f+9NkFlDT0F4aqNLjfB/pBoDcbuYOLiMRz
         rspw==
X-Forwarded-Encrypted: i=1; AJvYcCUWKqeryIehAovmwa2c7BHJz4M9tvs+Huaywd6Hibv0t77ewtgjraooHepUKHLxX3VS9UG4IbY/N7phhYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8RI3GK5Cv8KTKJmEItmGXvM2zbDWCsf8Cp7Vu2vTnBqTWIZ6
	v11EvkpBBKrOlnpE7IedXbtVUto1kt27PgvuWC8cw9meDUVeOPw9SYdpIwdczfo3yYhHypQFv08
	3lQ3bhtOKkzz1QYjRhaYuSUuESUfwNvb29Rp+muYjFpbiMOtq+i05F3HpX4xhqOQ=
X-Gm-Gg: ASbGncu0BzF9AnuPoE9UWBzp6Oyp7QyqiMICZF+xkXdixK+Lviiex/0aVxWqgGBPvxd
	FndwxgjLPGCfrvjyVFVWL6MZC7iePLESLo7tEux7V/RkF0xo9IXEr1Uaoi7SjW6MnXiee7xA8wU
	KL6oZ1NkYua6wNZd7SPkpc7OijRGevH0yAjSS+ps9hM/fiQgfVfOtix9M4gTRqpvZ4c7HqL5xTa
	1kQCMHvsyQ8H4RhSwC9vidqhGe9maMb0ofa+rv09joDSdrG96xENCWvSp/mN8iv69yk3MXYXtMt
	RkOGC1QolgjZZZlF5WVz0S5V3lNvvX4VFGd7HtoC6tzdfgm34mHA1Ltm3h0R7smoL9ZILxE=
X-Received: by 2002:a17:90b:264e:b0:2fe:8c08:88c6 with SMTP id 98e67ed59e1d1-300ff0a9d81mr874136a91.7.1741626567185;
        Mon, 10 Mar 2025 10:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGie2r7pmEwPgFFRIKxDe/DLR1ohRqxh9WveqVZp6iwrGPPw2SED4Us9MSYwIgkXhOSXnJwmA==
X-Received: by 2002:a17:90b:264e:b0:2fe:8c08:88c6 with SMTP id 98e67ed59e1d1-300ff0a9d81mr874102a91.7.1741626566810;
        Mon, 10 Mar 2025 10:09:26 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4d457cd0sm10153453a91.0.2025.03.10.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 10:09:26 -0700 (PDT)
Message-ID: <0b9d4a5d-326c-4281-b9fe-c8e1b1e4a026@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 10:09:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Null pointer dereferences in net/mac80211/parse.c
To: Brahmajit <brahmajit.xyz@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org, johannes.berg@intel.com,
        ilan.peer@intel.com, miriam.rachel.korenblit@intel.com
References: <qriquzbudggauxqm5oz55zvkh3uhpk5icx6icnacyzzijdtivr@m37pbcwiqblb>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <qriquzbudggauxqm5oz55zvkh3uhpk5icx6icnacyzzijdtivr@m37pbcwiqblb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ctthk04i c=1 sm=1 tr=0 ts=67cf1cc8 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=b4LDLZbEAAAA:8 a=5Nd08vw50q0olsJ1Gb0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=20T61YgZp4ItGotXEy2O:22
X-Proofpoint-ORIG-GUID: NTvWjJqZZnAxsAXIcFr2bYGWnD1zXzbj
X-Proofpoint-GUID: NTvWjJqZZnAxsAXIcFr2bYGWnD1zXzbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100134

On 3/10/2025 7:16 AM, Brahmajit wrote:
> Coverity Scan reports that there might be a possible NULL pointer
> dereferences in net/mac80211/parse.c: 1061 in
> ieee802_11_parse_elems_full(). I understand that these reports are not
> always correct.
> 
> I'm not sure whether the syntax
> struct ieee80211_elems_parse_params sub = {};
> is correct or falls under C11 standard[0].

{} initializers are extensions supported by both gcc and clang/LLVM which
AFAIK are the only two compilers currently used by Linux.

> 
> initializer:
>          assignment-expression
>          { initializer-list }
>          { initializer-list , }
> initializer-list:
>          designation(opt) initializer
>          initializer-list , designation(opt) initializer
> 
> I'm aware that C23 allows empty initialization[1].
> 
> braced-initializer:
>                     { }
>                     { initializer-list }
>                     { initializer-list , }
> 
> Considering [0], if we do something like
> 
> --- a/net/mac80211/parse.c
> +++ b/net/mac80211/parse.c
> @@ -997,7 +997,7 @@ ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
>  struct ieee802_11_elems *
>  ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
>  {
> -       struct ieee80211_elems_parse_params sub = {};
> +       struct ieee80211_elems_parse_params sub = { 0 };

using one of the supported compilers, these are identical for this struct.

note that {} is usually preferable to {0} since {} works even when the first
member is not a scalar.

and the coverity report indicates the issue is that sub.start can be NULL,
which will initially be true with either of these initializers.

so the question is can sub.start really be NULL at the point where it is
passed to cfg80211_find_elem(), or does every path initialize it?

that is the question you should try to answer

>         struct ieee80211_elems_parse *elems_parse;
>         const struct element *non_inherit = NULL;
>         struct ieee802_11_elems *elems;
> 
> Would it be incorrect? Would appreciate some feedback.
> 
> [0]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
> [1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf


