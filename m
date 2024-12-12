Return-Path: <linux-kernel+bounces-443709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD599EFAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E04F16763F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B72222D72;
	Thu, 12 Dec 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWM6kTxK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EE1547F5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028184; cv=none; b=pqTqnvXv5VWNJp0WGe+jyuV6EBC5n4V4G+Bb3VZ5cLFY5wrKdO8seViGQMabbjSz0dYI1DD/7Fjh5NQNRR7Dk7FQRat/HFI/znbtAg7zmh0ts/LJ6KPkkBn+ITMNFEOl8w31XQuVIRK5c9iQxT/I3aonv/ZUI3nspgMYnB+pAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028184; c=relaxed/simple;
	bh=S+4qum5CNcxWxE/lBVTFDPKjohTTiLF9nNpkPi+XPJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EKmwRx9ElIviou2kqBAe8nUwit8WLgPSN4L6GKB9+llAGscujQzajLy+tHjHtE4R528gyWE95xF3Xz5jb7hed6+XVb096by1UGphWqD1UHPC8GUTO4GHFu7V2aiTBc+Bhv6ET7ZJg58YmnYxmiy+J1HVlmoPUnKmqjOSTnT67AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWM6kTxK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHYxiY029034
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzswdAFjVrqJvldlRJqWNRKWxFcLJfY7sUUkJQQ3o3A=; b=bWM6kTxKVXOehTU6
	FfKe1i4Z0YU1BN9LvjfNCQE++Q9PZkqDfL649s6AK2cIomOirdRpjI6Thr+ARhqG
	6CUxXshq4cyV7Q0bY6tVtaKjHgdFymZ9afgGHHsxMsSvS1ba+to5pJeCiZv5Mp8j
	k0YYl9orJT5uMNwjsnowMQecnKNbkIarl9QMUlVj2czE2Y/s68/9qQ0uCtN/zu9+
	88RUSWq8bYz7YTU9UIGEfUfaq3dKwBpHhSbdLKknKWlcBwgKSWruDJy/qK8QuYSg
	mGSJJ9/CihN2boGagxycVleX0YtaS6whuI6CSGvnkjcm1kemC0VWRn17Zy8hdj/X
	DiR6/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xuw92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:29:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so1277357a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028181; x=1734632981;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzswdAFjVrqJvldlRJqWNRKWxFcLJfY7sUUkJQQ3o3A=;
        b=wDaz7inPrpzfwtrkdfw1pw8OEBEOn3NodUzEWt0YsPt0nmIK1jQB4yLDRvhPjCWSBZ
         3LQ2GPTeHFVaFqsZO98AmN29Pggss0vG8efT6H+ta3uZUpLAS8r0161tzFL5dGxC1TIf
         guvWnvC82mKIdEIHwK3TNLiaVVeU8LbhNAl6Xj+AZJFsWZ3K+8hXKKGuEVI/o06n9cm/
         EmJcNhInZxUfQmxiA/++XcdmteLst+LawPs6P8ah6eeh256MdGbesbigYKOGgq8WXQsg
         1hn22p12QQ+zT6aTRFuN8xTmjLKNoANNhd4v65rZdpA1lSHlrimNSpvnoi5prPWSMrJ1
         0u0A==
X-Forwarded-Encrypted: i=1; AJvYcCUYZkrMD4rPVxyHKyZO/mHbWbZfd4vsx8uB67YnJeuS0i85HGFpbZjeEN3sFfXifTrf50sBw7KGRSeNxmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXl3Rf37nru/NSCD+/ch2UpOD6+Y3dguvxqODE/DcitNmzpfEU
	z5Y2NiS9GpexsrqZtd5WRuO1XDus627rT6Q7AktwwpXtam/40/dMMliKc6NqXXDjcGDw06VnGwu
	y22logXsKAvlj5J7mlR4oiueQqHorTxCZ1HXOD/iBL1BedTiQM7CGlJbym2A1YBw=
X-Gm-Gg: ASbGncvs09TYFmKMd5dOvSEVzCFO05OCBaBDWM7Yk8uZCNj0XSnhGqcR75lJRFpQe1j
	RUVhJR4L6U0IC5kw3//JYoShSC6RfBP5zMJWpvw9KoPZx3847YAU3KoSt1AZ5N8k8bftBIX8bMp
	G2pBM24EnxlimR+ope7cUSYRhogAI1Rl6xnVMDMkFr+SQIXiC/puW2LGseWyDVB2PavHwAve4pc
	kL2qKx+M0QE1sH4oWubML0iS1q3sa/7MXgbvIKAbL0a+eCn168VniJoDQx3MmhPn0njXYHGJXia
	aRgKU6NjyE07jljDuQ==
X-Received: by 2002:a17:90b:38c5:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2f127fc3496mr12114323a91.9.1734028180654;
        Thu, 12 Dec 2024 10:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVDA8sr7q5zN1fFeIX1o3inlsqd30324L+nbP5r2EPGB3X9jSPZoKl8YtTaB7X2YJ9Vlh0hA==
X-Received: by 2002:a17:90b:38c5:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2f127fc3496mr12114295a91.9.1734028180289;
        Thu, 12 Dec 2024 10:29:40 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178db5b435sm16480085ad.208.2024.12.12.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:29:39 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
References: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
Message-Id: <173402817940.3419904.18252047613958190039.b4-ty@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 10:29:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 5abrwN_MlyjtnJIPBqKYdh5HV2lCuoTc
X-Proofpoint-GUID: 5abrwN_MlyjtnJIPBqKYdh5HV2lCuoTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=621 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120133


On Tue, 10 Dec 2024 10:56:33 +0530, Aditya Kumar Singh wrote:
> In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
> radio, it gets deleted from that radio through a call to
> ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
> Subsequently, there is a check involving arvif, which will result in a
> read-after-free scenario.
> 
> Fix this by moving this check after arvif is again assigned via call to
> ath12k_mac_assign_link_vif().
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
      commit: 5a10971c7645a95f5d5dc23c26fbac4bf61801d0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


