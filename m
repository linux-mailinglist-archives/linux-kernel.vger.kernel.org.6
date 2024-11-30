Return-Path: <linux-kernel+bounces-426201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12779DF034
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58C7280C71
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB7192D82;
	Sat, 30 Nov 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXba2dg6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EFA1885B7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966649; cv=none; b=FR3cMTPA71Rw2n2QBnKCb9Qu4Pd+c1P+IMFukQ8TOWCRDtpjq32ZTkkoShR6VxA5AAZZS3I61hY8uzIDTeQTqHFVU16HnwtuDTFk6G/nKGkq67cCEjfVmJnbpWwvCRzBwbS9PelMBwhuJHE5ZoCl85ReGUwUyzeVqzjV4EB9C80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966649; c=relaxed/simple;
	bh=Thmgg5qZ1Ayj21DY0zxPd/gKajl715z9C/UHZ6SA18Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9M8YoFjSRopIAjBgGnUBBFnrcdfo3KZOD4WfreasECLyLDAekSpngkF9P18V7wfiq2I1fHYkOQGr16uQDtp1vYowrSgEvJrd7SeM1SzpfuR1DI8KPkyBosEpuk2ZczoHbmGvtmHPXvZI+W2DG9Zkf9U2q7lUirXBhg8XHGxV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXba2dg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AU6nKmv012653
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OZvpAxmieEw473kwTlA9LztuKkMS27kGy1qIBHQ8Lng=; b=fXba2dg6B7uaj/8F
	I0Pd5UltCnJDKkvPA6mW6kOMXTA+eCTfLyJyPMZ/zsy5rJe11ZRK7GiwMYL4A8Ig
	kvSTPWpfwLbs3a0yFHyD+TAg3NJTSGhWPsLHOnHmipBhVCBbIbyuLKK2ZD9rNxRv
	KGCPB/ikg3boxGgj6yw6EhAMC1U2w3rj4uTmWefJsaHe0blB+sKyn4JabvOLhgpQ
	VMKHp9dzHBBJM9QTz7tiEkRo7B9Mm0ihC970sXN4ybiy+cTnl3P+jnxgIaNdtg06
	xcDS4HloFJwT65/sNt2Lcz+HLNssO1Lr8lu3MkgP69/0o+UWwDyWb2Ip0ISQrrhw
	OWoc9g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ta2rnr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:37:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466cbd99b11so3151531cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 03:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732966645; x=1733571445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZvpAxmieEw473kwTlA9LztuKkMS27kGy1qIBHQ8Lng=;
        b=lYs2Y+o54oOzjRTfI9Fp7SHRrpelhyCioQIfMgAgFsJV/kq2oWl/XZxbaGVG8MWGWr
         R3nKOqXwB0MdvKK0HyRIfIORn/DgYroXulQAe3xba6UfkAzL07ncxQNTJ0+ZF13OT/Z8
         CoMVW457fOxs13ev4I70jA5p0dORsLdYiWPGSafDZtXn6+GF6Nm1peWLAPUboNTOxVlf
         mF1ry1HOepLZ1vZ/5i3Tb8yT3dwuJnZOpZMyAift/DxOFdd7gSeZcCsJpKAmpWfyS8lO
         NMlXxR511s4NUoeJ7DA6hSr/8gy4YR93BxFs3XjjiZRegwu8OlS3UcuezBT4XjG6xJc1
         M0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVI/m0PScx+Si8WN8goQNR/Ejc0VWfVrRWO/ah2WMSi8yO+w0srkmYF/hF5XW4F7FL5vGyFzomM1P90fpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf03+q6ePq0vP831tTGGmfyyTZUDj4zWp6jnBOOhEzyU8YB65F
	dKEdMD72IYteWZL3Hd0wU/aEbSGmEjoURdiR03I37NCcHS20/I+OtOGoZcNqumDcP4APycpY73s
	GfVj7+I9ET+s9VIlFPbmgmThwifI4weby2S3edPW0djO+AYeVjreskljN6Bhb7UY=
X-Gm-Gg: ASbGncuXZYNXCayuedDVSLFxh/4bAmJ6hTj1DBKqZzFPwMFcjEb8CX273E3ezhCl72q
	G0BS9AUDCBkm3f2KlWXCBMKTHARQMirdPlJnjWgtYwwwUxTUyWyl+8FlLQP6P4IMLHisS6eoP1J
	ytMM+SfZVclHMfG7eh40rpIiaAISVkRMqaTAErDFlbkqyDBHNIWRLoe0gftEqJXXjM8ZCWobOYi
	IaMCXCSXmiuidminmamvm3L3ov/CsAn49xr7zMdlteXH0t8/BpqT9kErR5nJRliDl3972Ep8U+Y
	7rAD/HAH7COKj0Haew1J1799BmrWPKI=
X-Received: by 2002:a05:622a:1a02:b0:463:5517:ffdf with SMTP id d75a77b69052e-466b36d27cbmr76067621cf.16.1732966645287;
        Sat, 30 Nov 2024 03:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzT9ypsq48UF7x887wPpK3Ma8DeIIzsTE7qzn3zdK4jFniAGHsJbfgxS0eMI6V8wqi307QdQ==
X-Received: by 2002:a05:622a:1a02:b0:463:5517:ffdf with SMTP id d75a77b69052e-466b36d27cbmr76067521cf.16.1732966644925;
        Sat, 30 Nov 2024 03:37:24 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0d1de7429sm195217a12.74.2024.11.30.03.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 03:37:24 -0800 (PST)
Message-ID: <6e01c2b4-2383-4c2c-b848-da3f3760ea98@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 12:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: x1e80100-vivobook-s15: Use the
 samsung,atna33xc20 panel driver
To: maud_spierings@hotmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241125-asus_qcom_display-v4-0-61a4da162406@hotmail.com>
 <20241125-asus_qcom_display-v4-1-61a4da162406@hotmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125-asus_qcom_display-v4-1-61a4da162406@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: voxeWCsS21udOrVzbb0hBzvBnfiMgUyB
X-Proofpoint-GUID: voxeWCsS21udOrVzbb0hBzvBnfiMgUyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=786
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300096

On 25.11.2024 8:11 PM, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> The Asus vivobook s15 uses the ATNA56AC03 panel.
> This panel is controlled by the atna33xc20 driver instead of the generic
> edp-panel driver
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

