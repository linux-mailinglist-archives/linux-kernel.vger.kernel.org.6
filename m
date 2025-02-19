Return-Path: <linux-kernel+bounces-522121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBFDA3C64E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C157A72AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F7214807;
	Wed, 19 Feb 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uez5vy9/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693241FDE39
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986601; cv=none; b=YpRMVzTguVySsPey08UXduTCwpFkfx5LJDsJsDVkODCGrQ6URXJMp/hDjWLvUa3GID2+l26gOwU77A10kg1wqSFcUvI1ck4tu5JYNVZsKAMAy7tdrQm6cw5rRi4QfTxV/Jzbslo5H4PvY2JqT/XHPVnEZjifpEumyUl+PngipKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986601; c=relaxed/simple;
	bh=cTRVC5cVHHMwudxEBc5SELgNQq75C7XYr5CxcEbuix0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc5on1mXl4hzShF4kQsh7i0RlJW/nvDCWkJ6CVd1o3+qXelBNN9lYyYKpZG2Z9I9aDJ/HBaIAKnugGnCSuwfczMQdYVw4KusW28/yWxBGHsZb9WFaZlKc8NPtkPxpbhw2EL31iT9XrHZql1Zdz3/MzWBFIPnnWsX2gFg9cx5bJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uez5vy9/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFpdtE011055
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ee6+eorvO+pF3kR9F+2d8nZr7k36mhnL8mV9SwVW8g0=; b=Uez5vy9/RyiB0tv/
	f+sAocr9hCj/X06Z3bMHTU+2ai1VgItIHof8aKzgmHvGInh5ayGKtEfnXeb8ay+A
	42eTidUs9ObQN05SdI57k7/45KJWBJRKZuAceU+KJGrJE3HYVbLjhxbDA6hLOcBC
	jenY1OhDJbmYu3n3RPlwv8rn23DJZg0QzteZ2BFAObmStL5ANhGoz3dxZtqVKtY8
	QlTkh28gT6Ar9FJgpxTvoovJ/eG/z/AabQFRSV0uKIiiyoPVlg2b+Hvp3HRTTwJv
	9YlWggH5LJlgFvV8apnkfboxrm8dYbZwu2sPVuqpm94SVbwgBWIz8U55bnXOFW7S
	cyBPXA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1uh52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:36:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so92516a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986596; x=1740591396;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee6+eorvO+pF3kR9F+2d8nZr7k36mhnL8mV9SwVW8g0=;
        b=jwufpkYLwMcFKQw8aLx3VR3pJtxijjb9pHt7mku4RaYF+2srSboSn6fcR9q+jYrj46
         avITKkB2jVGcIFqAW/JEZr33uo5Zfnxc/B/zgd3diYa5iBmgoHd/il5A96XzjwHl19ty
         bKRJ6F+S5jV/l8pB0apQAtXP+j9vXvTxRwRBy/lMyAihOKr5Sxo3ANMKB5gCUiKa1KHz
         dUNcaa70/BG/LAd0KZeu0Xxjr3onbBgYfJacKyeJnsO7vS55SaMPcOiSsDl5Q7ET54Fi
         VXzcPa1CUAbu7X5phRUoxeifRJ1irUOx/nD9fkDwKwcdqR9ygtZYxkPMpDZ96jB5NEZO
         sVJw==
X-Forwarded-Encrypted: i=1; AJvYcCU9wvWwS/YkAqy6glFrIn+fEQsL3fHyqkcHFZCIJHJ2TYPfQfkUr63jhzZDOsJvMWxxTvKq4mHd5FSAYYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMoTb9Yt+WQvALHN4xaZaZ+d6HxOdNzObZvJE7rKGntTVB3jj
	5CQbmXz84yDxlsu3tZjQgEWgSHcHXbplDXozdfsd62AlhGtSibaP5Ezv1rwOvSP1/ENjqiqvrXW
	xxCxTbTAM/OW/CKSWjKqe6UA2BnXrQfNJdiMvgM8Z7bgnhHNyrohpv2TSCu9ytzU=
X-Gm-Gg: ASbGncsSaKea0b5WJiwPI+PHNuWuMcWTao56hj75eT8XcJ/bMujFGHWmu0zsBd8O6PQ
	AIelGrJLwHHyoqwIN8HBM+RzmZVvTr0IEUGYKzdp7CsUyQWj6MO6kje6totCZT/ygTokIomavfo
	ssVUltRyaLcflvrOuHXUTtTON2lfwVxroORJjyGPv8gXXA0uP5h1E+gS0Ym1CgoB58N32hOo+gb
	1WL9Kywb8TYx8RzmUNVyJlV9Bv9nZMICK6R+v9+C+IlDW/IkJydBS3gE4ygKDSmo7oiRgD2kkfb
	ruIwkviRA1euoqMX9LSqQHSe3kszA3nAZ89M4sjXzUHPe1qm/M3iOsq2FhYo
X-Received: by 2002:a17:90b:3b92:b0:2fc:3264:365d with SMTP id 98e67ed59e1d1-2fc40f0ea25mr29237108a91.11.1739986595762;
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJWmXWsxGjClVm/zthfCXF+H+3XyeXB7GQZrRmqkGHU6xzsOjlVcHnjYZJYGEt/oE92j+xNw==
X-Received: by 2002:a17:90b:3b92:b0:2fc:3264:365d with SMTP id 98e67ed59e1d1-2fc40f0ea25mr29237070a91.11.1739986595423;
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f4f62sm14557474a91.26.2025.02.19.09.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
Message-ID: <b0027c1e-cc0b-46ff-8b46-774259f3ed0f@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 09:36:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] PCI: Make pcie_link_speed variable public & export
 pci_set_target_speed()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
 <20250217-mhi_bw_up-v1-7-9bad1e42bdb1@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250217-mhi_bw_up-v1-7-9bad1e42bdb1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NWli_-EgpDjW_55Gwqz8PzGIwXJ1orIP
X-Proofpoint-ORIG-GUID: NWli_-EgpDjW_55Gwqz8PzGIwXJ1orIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=590 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190136

On 2/16/2025 10:34 PM, Krishna Chaitanya Chundru wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 58f1de626c37..8a3b3195122d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>  
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +extern const unsigned char pcie_link_speed[];

This, and the Patch 8/8 change that uses it, make me cringe.

Should we instead have a functional interface so that the client calls a
function to perform the lookup?

/jeff

