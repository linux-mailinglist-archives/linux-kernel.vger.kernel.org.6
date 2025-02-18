Return-Path: <linux-kernel+bounces-520013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41FA3A4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B78D18894BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E871270ED0;
	Tue, 18 Feb 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maBnwhyN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5D270EB3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901378; cv=none; b=Xaua9YQbkfWsbxVB8wHHJSFbH2XOCUKvvrbLFH7o+0npUfzoBEd+gAB3LagXxH+Lglpt9o9GzBBrcM0nfZGZG4R/4qXmmO8+FXSbz153M0Kmxk2bZf4tc8jf3AtarPzdTZDCh1QsLPO8Mk7xfxKAuQ0IkLfttp/5lh1T3GvcJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901378; c=relaxed/simple;
	bh=oTjuUiXvhzJTYfdkErAeQEBerMb8kTrvk9je9AIL49A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CguRQqmigvGvsDv/GJNgAY0eJKSi/jwZ8LtzmHWUgqYq7esPP2iN75kE2PIjx3iQ9xk75A7K64SXd7aZfUTx8mQvGnYvgzRyOeHwdoaBkIeCOTmXZTihgrvwkALve7VnO8F3ZplPuVJ8//EZStPJ0zoLm864/IG2C5lF0aFd8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maBnwhyN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBUkgL007902
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=; b=maBnwhyNo4vyavOI
	3qYJlKMw4oixT5ZXQ12wvrrJ8n48BTX4bMntxD7JOvvb3DQrVnPiuCHb5Bhskv+7
	c3QB1jED8ltc3AQeBNJagJpsLjNj9/TikfnKQVMD7Y5ZEpsIHfzezgks76us3eZ5
	vtjkZ0lfXIuPUHDpnYI/LN964F27tQzJ9XlRMgCO2wPegvmraveJR1Kg8vVMs+Rv
	Cqa4VX6HiR4vMAuHb5seMEOaBtfx5y8hpRCcN4rrFU7pxWNlBSUFHLHXrs8SviTE
	N7fR07kLTvXIyRzmLYhs2LSgpQMyIb3+0aTvhh3V6aZFE5x2nA4wYmZeF1hdZ835
	os4w9Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7wwpbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc4dc34291so5693396a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901374; x=1740506174;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=;
        b=qw3pqDqSCVk/XovCh9j167X7gpb4bui7BnW6en/65j8m0Vb8FHDMzkqAMpK8xqdnFk
         iIyDZs1JUmFmQKmdcbc099AX04n6zY3ZHk9J8cCK8tz6YBl0+Tr74d0UA8mboengMAi+
         tUS1zZ6cVz3fIlGwIXPudiN7wJWhStREJXSz+5H3Tnqc+CO8CqRZaGu8pjuNkF6Bfgz/
         kvvCnC41JRmVNrNJHLM3fU+a4TrIhwtqkaNkNU4MgxpzXkkkeCW1/nxXIgNDVQ0ZCWtt
         CTwkIbCsBCeTGgv1pTjQkcoWCKxPVPny4E23DcSbK09MBOX8BNwR7zarvddwuXmJ1KFP
         qHsA==
X-Forwarded-Encrypted: i=1; AJvYcCV3+jqbrVCZwc85SfODUm4gm1yJnXo0adOEFykTExnbcCjJfwHrBEFL4bITe1DOPN5Ts7WHzYf7wy2wLaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1WlP9icPN87teQqsQCVmUeuoM0jJKFZQFNn27rSMs4YYFUIS
	LPu2ACiUEp6IhCmI5F04lvEp6awRoiqYfeRrR5hf+XM2k9P2Vm3Sjw8vHEMGSMUSVUo6AwBWbPU
	loAhk0cr4L+pqg3CPHk1Pd9XxJeAeZFMwXQeqUfDxwZ/r01Rtouw0p1gPxtjTUAM=
X-Gm-Gg: ASbGncvxOCLV0g0bc/01G85BqEsEOmuuNEOYtsgHctva+MKfG6kNndifGgkgL8TfEYK
	20rECQIt/OEjrNWaBUhqDfjyyATX9TENicIUnebqrEOiOlFkKXNIdR/OkrV6YQZl9HT01ZjVRZX
	OX/jt5fS/k/cIF36ehdYv+YhCp4THuaUAIIYJBlEyyZEY2bUa9xH0HuvMTFPY6as83MmF6MZ/Op
	T+6K2tfVmrXOAfBeDkTuGWWW5qOfzthezt8uP0FW2Q4wteK0x/TEvec2L8VYfNbT97zzqFdruGj
	3+w9JXUqWyY6LDYr7wXLT+psdfF/0shESsCPAfOGbA==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652823a91.30.1739901374468;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHRnoQUBRepGyq2OMwaJX32opGFnz5QDIQdI91vfH8K801jeMK8U9QrNGbTTdrdnvAPHaa+w==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652787a91.30.1739901374048;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f698dsm12342252a91.28.2025.02.18.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:56:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
Message-Id: <173990137296.1304166.12952412255986592297.b4-ty@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 09:56:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: nowLT7q68QoxDXmBA6Fcydn2lzMaO91r
X-Proofpoint-ORIG-GUID: nowLT7q68QoxDXmBA6Fcydn2lzMaO91r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=451 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180126


On Mon, 10 Feb 2025 21:49:41 -0500, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned *ret* and simply returns in place.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
      commit: ceb3b35f5ef4a0c490f54eb8b53075fd83a97d11

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


