Return-Path: <linux-kernel+bounces-371431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E603A9A3B01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7BAB2608F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60F2010E7;
	Fri, 18 Oct 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5E0K5oF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA211D63DF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246260; cv=none; b=RHwzsEoY57M36YTiA5SrecEzPTksXDya5AKJnlPivca1owXj36HJPb8vuX/jEJ53lV/lEjl7jzfGSJme6HhbJF+srbKYxJ7A16j9sB4uiSxrj/PyqlxXyFYDC0Su2UdHskR9xhYvQA/B45bMr4hVbhcaiG8+zhPAgZAdDLSjL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246260; c=relaxed/simple;
	bh=ocsqfXChWEgBHZDxan7oYRTvYYt8oUieGxp7eYZQ634=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjhgFXb64hahy9+YEkOZWtPr3qPh+2PCvoV5ckVEoczTcdWgSFPxwtbfotRnrixYBhb2ITBKb/prenognkC3FLeprLPXNNTJ1DxJTmvSISSRaxSUaRudYRCS679jt8JcaJtqFQGca37OYlAzVUtUFHhX4Vc7eiuYDkShBRhXBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5E0K5oF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I94uZo005932
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OXPIMmd9oqpiU+5EJi5igCXiHCqmSyos23ulQ9gEwq4=; b=o5E0K5oFjiSKTcOX
	9gdp3dfxDqExP6bQ31GIjBJ8hCnA1VujrvA1bwGWq90IWTWFjz8Lpmh5RxQP7rTZ
	LA5PNTE9Tae7W5tRErXWvDh+LeBRx0pnckBWd6cXDv49yzM3Zd0q7EQQRP+Fl/XM
	ah1JBG8TSD9ko1gU+yKXyijL0avJBrH5rZURXjOSBNdOYA+G+A+cbMPsKSM76MMr
	3JnWYcvm4QC6g7dvUV1JZE2wclwo5UI6ZSJyoD9wPM+e8rJ7a08sLkgbKYoWhtvS
	Cypv1KrNbkOi3dKoQCiC2ouTONSxjLoANyEuOs3C+2oaLKlotSDHf+CWQ6kBRavj
	XLBU5Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b8rr217r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:10:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbd0a3f253so3752806d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246256; x=1729851056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXPIMmd9oqpiU+5EJi5igCXiHCqmSyos23ulQ9gEwq4=;
        b=StDJdUhj8N2L28P6H+1C1tUG5nBZa81lHUjijIWs0HXSdiI66TB3VgKx4rbrelmu9Q
         miOk342WKuPTYsGRuYrYh87Ke/mtfh7ttj2lgrIQv1V01rH1tcoxWc+CBCpODdz7j3aZ
         T3XMpMzltgWXxnY4rheM3e8z/rR1vGl7xDYttS9Z8m47LeCQaV9TnLb6h4n0yPazbAeI
         DOH9KL4esKMkVh9kMh451YFRVQ0rZ/YK28GPDNxAICvy8yE9tsDm7uZEjSubgGfCJx6z
         1o888GuA04erHWQjt0GDy5gTDKCQckOsNNMqBLWJe/RuZ7EXiwtZ7ZGqrmI3465/+rXr
         DfXg==
X-Forwarded-Encrypted: i=1; AJvYcCVQkMopUQfsMbuTqVlbVeCqqdBk9oqjqLndNmFWdNHouPSNH+3ACrG2ELWgZypZNYjPdop+u93IMbT6EA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzWV/RGq5IsjNzNptJXoBKql3ZMvFipyd5JEBbjpmQeIvctem
	l3tqkixIBLNtARR3h2EKyJ5LKdSW9wjawKQFh+ppYpZd17ZMjUPGDS64usg4+PfV0UPUg/8Hcs5
	qPzcKWbk4PfhxoOU+/x1GDGJY4Jvk6odv+5vT/mvinyWxNjdflw9VE0NTHJHn7dw=
X-Received: by 2002:a05:6214:20e2:b0:6cb:c67a:efe8 with SMTP id 6a1803df08f44-6cde1669439mr9594786d6.12.1729246256666;
        Fri, 18 Oct 2024 03:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jTJw5JnqOjmxBso/awk/XKCbh2dxRKjYIFmIjcpQmKruPvbZM706UA18QnHB/2tWFCQ8IA==
X-Received: by 2002:a05:6214:20e2:b0:6cb:c67a:efe8 with SMTP id 6a1803df08f44-6cde1669439mr9594456d6.12.1729246256249;
        Fri, 18 Oct 2024 03:10:56 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf7173sm72992066b.167.2024.10.18.03.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:10:55 -0700 (PDT)
Message-ID: <bb73e6ce-537a-413e-87ea-ac8256313c46@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 12:10:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for DisplayPort on SA8775P platform
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, konradybcio@kernel.org,
        andersson@kernel.org, simona@ffwll.ch, abel.vesa@linaro.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_khsieh@quicinc.com, konrad.dybcio@linaro.org,
        quic_parellan@quicinc.com, quic_bjorande@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        quic_riteshk@quicinc.com, quic_vproddut@quicinc.com
References: <20241018070706.28980-1-quic_mukhopad@quicinc.com>
 <vtfz5vteaedwrqw5cpggmd3esi2rky3f2axubxukh74wdux4uy@zdac7miws5lu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vtfz5vteaedwrqw5cpggmd3esi2rky3f2axubxukh74wdux4uy@zdac7miws5lu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C07uGU_cp75OMgJYz0GcpHuixxlhcpTR
X-Proofpoint-ORIG-GUID: C07uGU_cp75OMgJYz0GcpHuixxlhcpTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=853 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180065

On 18.10.2024 12:08 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 18, 2024 at 12:37:01PM +0530, Soutrik Mukhopadhyay wrote:
>> This series adds support for the DisplayPort controller
>> and eDP PHY v5 found on the Qualcomm SA8775P platform.
>>
>> ---
>> v2: Fixed review comments from Dmitry and Bjorn
>> 	- Made aux_cfg array as const.
>> 	- Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.
>>
>> v3: Fixed review comments from Dmitry, Konrad and Bjorn
>> 	- Used a for loop to write the dp_phy_aux_cfg registers.
>> 	- Pre-defined the aux_cfg size to prevent any magic numbers.
>> 	- Added all the necessary DPTX controllers for this platform.
>>
>> v4: Fixed review comments from Dmitry and Krzysztof
>> 	- Removed the "reviewed by" and kept only the "acked by" for 
>> 	  patch 1.
>> 	- Updated the commit message of patch 5 to mention specifically
>> 	  about the validation of "only" MDSS0 DPTX0 and DPTX1.
>>
>> v5: Fixed review comment from Dmitry in patch 5
>> 	- Aligned the register starting address for display port as part 
>> 	  of device description with respect to other targets.
>>
>> Below patches are applied:
>>
>> [1/5] dt-bindings: phy: Add eDP PHY compatible for sa8775p
>>       commit: 7adb3d221a4d6a4f5e0793c3bd35f1168934035c
>> [2/5] phy: qcom: edp: Introduce aux_cfg array for version specific aux settings
>>       commit: 913463587d528d766a8e12c7790995e273ec84fb
>> [3/5] phy: qcom: edp: Add support for eDP PHY on SA8775P
>>       commit: 3f12bf16213c30d8e645027efd94a19c13ee0253
> 
> Please in future skip applied patches instead of including them into the
> series.  No need to resend the series just for this issue though.

(you would normally do this by rebasing your tree against -next
and having git rebase-skip the ones already present)

Konrad

