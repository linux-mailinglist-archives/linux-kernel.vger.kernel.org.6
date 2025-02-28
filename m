Return-Path: <linux-kernel+bounces-539014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2451A49FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD3916CD13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B83274268;
	Fri, 28 Feb 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvaEOCPP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAE27425C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762458; cv=none; b=kCr/IMKbBJHpw7NQ1iXoWLuCFHJB2DUAUFGVd+RFEgJyzlpp4t+rA4YkjPLlvukLllhZGCgjXkLgFby2sc+HJGuilwd7n5wtG6baUtC6kkCuUFZlxqBYWK1P1i/Qy02IjmnI+andbbl+fNHTFgz9DJv9Ypie5Ez9soS7sTG74No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762458; c=relaxed/simple;
	bh=C2fZ4SBsHF3j7jycBO4AvxzSaVFIR8J5mdhIZvJyKWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBdIaMNl0AixSIV7VTRL8e2a7P0l2c5tcNHQRhmrgzJy6KjgHdtCeqglw94y/O20h7xpzBEfDMcqEc1A7RDRHDxcNKpJm1XXJY+AgCFrx8e/Tkfw3J8gjj2qgvN9e6Wt4o3twFQNi5pHEHlc0I1RYE95sHDQdOm3jVdV49dWxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvaEOCPP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXDLu001790
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w03EvNkmgGsEYw7MVxLcdlGbwxuHVUXTAOgcgpkzv4M=; b=RvaEOCPP2CqdlTEx
	YmICOPsvT8qDNLF/rY03JeVucRCUWDlDCxk7VMqdR/MKLLqCZsXsFSL8pXs/Stjb
	w5jSTiS2EyM84aqSeEzjMizz7qfRwGIeg1FmaGj7JZyuVWRX8TxniWWNJvO3RjhD
	8ElwnNl6jLWk+jaPWohPyzmyv6zBsONiYpv24Sbz6EjcZTeGBZMbx4R2fKJHyYo9
	hYidZ4SEDB37DSwiYfUsvCgS8rPQMej4jDRRKVXyBzEscxw42QyGjjf7BoeY3AgQ
	OzsV7NQq5fbl9FNt/8gIDR4JyhTDu/5rqc3aSeoT6YcxpnOHWotPJwyMdFaFrI2I
	MKSSug==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452ynwty05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fe8c697ec3so5441097a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762454; x=1741367254;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w03EvNkmgGsEYw7MVxLcdlGbwxuHVUXTAOgcgpkzv4M=;
        b=pOLdj1pj7ahWGzwg7ZCpiUJallBuEAqr4jrMSMwpocDjc5cf+IsEdpcxfX+niPPZna
         rzylwnAl5fuSZkMTtZB+eY6HJqQqDVSWgKX1ubO3+dPyHhJPCxmG1KRKc+T9F9QgVwAz
         1hUDrfD5QZJadgs/f21uHyFxNzm3Rn9JjyQMhpBaW5w4JOZ0lByI7muDOPYbl1j3qUVy
         /uxgpvfcEsiMrj9eoZGa9h+qHlw4OQNmGYSsCDy7CQknaXIRc/3cKn60MoPbR25ZDwO9
         T52DeiStbiWJ7uS7Ujee7OQfEZxONUgkkdBc/m6VlHv+RNoe6pApWF6T9rTES/QX1jzm
         GP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS8YWhI6HQmisFeGU+EgQo19WyO85DeVYMctSDRKoAZvFl/y5M0yQs+m9/NY5rKolZC8pxz3mcOOFJ1js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfqLu+XDE+re1Ppjs5O5Sx6vel3pHKYK3BqC72R8GOngAiOz+
	oyoHqKRjHosQixqcDX2RheLrQGpjHzjcemhzJ6lglG+7DxVwmb1tvqnJ9VM62mQ882QI1AJe2D/
	8H4m/p+vEEadZcopZ1bZEfqUV3uc7JQ4H0+pQxql6S5RDzw9y9XzF53rp+CMAbyg=
X-Gm-Gg: ASbGncumK8WSorwtDeKV4wzxokkIGpy1D5at24VUylD9AzVbsZOxcvzppBD79NejlZx
	OY3RbHb0QkroYp6cE/lT2daDeWgKGy2c3wdT0OSqQWLJIoul6jNJ20LeVYYMj9Vs2HfQo8usZcl
	HASJ/Ezyzpm6oIZNG98KMyKOazcV+hGsQcy+phIb1DUVLZDBlz24gG8NkWMe8uEdAyq7U3GUTCe
	ZzVPzQ3Al2D0sgSlaCx7ODMOiHhxTQM0JyauKUv2m58ei7VbymNa7xvCs7Cfol+246Nh/wOHxsf
	tJ7OUR6ppu6r0gYe8nKIVYfQac8C7Y4ahYa6bb0DSu5Suxfb+NvLgL81wm1rmThoDu0huXLLEfg
	EaD4h15cQ
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr7182351a91.14.1740762454207;
        Fri, 28 Feb 2025 09:07:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4woKH6wlCEHEAUo+YddSp5Hk9b4m/JxWUHwlF3vZcka5jmfSVtvgX0c8jPPD9KSmBmIjhjw==
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr7182301a91.14.1740762453739;
        Fri, 28 Feb 2025 09:07:33 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea679dc51sm4036250a91.21.2025.02.28.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 09:07:33 -0800 (PST)
Message-ID: <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 09:07:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
To: Johan Hovold <johan@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
 <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4IixhMrswQE2Wfpk0XHhK6lc6o0lC6-j
X-Proofpoint-GUID: 4IixhMrswQE2Wfpk0XHhK6lc6o0lC6-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=996 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280125

On 2/28/2025 4:28 AM, Johan Hovold wrote:
> Hi Jeff,
> 
> The ath11k ring-buffer corruption issue is hurting some users of the
> Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
> with you and Qualcomm.

I've escalated this with the development team.

/jeff

