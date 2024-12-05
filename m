Return-Path: <linux-kernel+bounces-433964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AE9E5F81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ED816614D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48E1BC062;
	Thu,  5 Dec 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kj3ZAhfy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9581B4132
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430886; cv=none; b=PyzzHWoYQ3ZvQbkxxSSdifeBDTXDjAnElTfLJaQ9JtVX/wpCqUGiS9S7H3ucMuuJYr2WvlBODXhFiLHJ9KWdhTaPV/eJoe/dUXMRb/RY9C+TUahurMHZSPrjNkGSIjyn36ph/rDdzJ1DmUAsXbLvnZlU2v1JM/JVsBI4etF7wWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430886; c=relaxed/simple;
	bh=DmW8YyBsd44gbuNFXAETaq1mF9ya8lpLReo1PVWLKY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXP2P8kOoMXEVCX3ABQSWjJgGP1tBPJ8kf0MN0OMCSnkWdfuxX8hddnycJ6sqhb/Td7yS9K3wDf8A7s3duS3hac9mD6c3IRf3N2Nz+wML+F6hSLwaKdI5WqRTxa6LJTgkY2VyQD9N793XBJJeLvceImQT/Gp95IfJdhw7BOdCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kj3ZAhfy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaNFG003810
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 20:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lhonhl3f0KVfqrEwEvN9gKCp13rZK3mo8Db29qGWI2A=; b=kj3ZAhfypRzfgpnN
	KO6tCY6mxpbXS4AlC5hD/3RaSK0IAG7HsKrnchao5kIcbpzRzBqpj4klLk2G1Z1V
	K/Vwi96yx3kn2XDIUspq0JV2c2I7OqWlE+pQfGLyBq15Hb4IdeNgXUg8uowNaFLF
	I20MESd2g3Tv9I4VxlLEmEjT8fIbUm0906ArdIuKfCq139TCR1+PiTvlJ/46mwl5
	20R6y/HYP/LuAVda72wUAjyTVpJEvv/smrltTBPVW1/ladSC4smBxpfjAoWd2oKK
	Vqvci9tXGzb1IaETS444IWeuVer72hb67jUYXgfys9GeINVbCI3072B6G1Tcjy2c
	9ghHsw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbqm1bkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:34:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d887d2f283so3379576d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 12:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733430882; x=1734035682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhonhl3f0KVfqrEwEvN9gKCp13rZK3mo8Db29qGWI2A=;
        b=pvKKP8z5qlLBgB9h7zTQLL9BUiNczLb2hG8jOL6bcKc3LR9l2k410q47A8YcoIb7uP
         Vx9ww3jZJ2Hs6DntCjpatc8pgYk8UKrEGawPTJzSWPzJDkaYQBmQKYbWa4MHJ/pD8Hr1
         awxx9oGbjF2fVphq1p7rSW9ZSKjXvxFgUuX4ETYcZTkG39K1yuIs8A01AUVjSwSPaC0j
         s+MvBQLHyzAttH+z6q+P5puuslCANfYaEovDeUO1flnIa4GQnoAYfdMsZaYAi8cMjMj9
         PvBCnbMhBCmJSM/RxwHv0TCkiMhyIQ8W2dt3FMthVjzmbbu19qKiMoQ5qCHHrRt3hXFj
         10Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWjFDRTalAdrL1T5P25D9ARX6eAOhQtccV9UsO/KZNyhRc1SDZOkyHDwt3UNBBid4aC3UoWj40q+Zwc2+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXK3BltrPgSpFugJxXfVxB/ltJpPX8693KOsTYlIMxNSFEX1E
	mkzVdUVT6PUfGtXS8ISOzShlgcffyFeHllgHcNP7l/RA8o53BpKwoDzT33enbExBBHzpTNgrcpk
	sOzm8vnMukeZ8uo2P7uZGBG7vPSVKI+YAYC0kv1W90YcSBGBhd3Q2oOJedccdPYV0xdO6T/o=
X-Gm-Gg: ASbGncsaCoApu5yUsV4igsNLf6v8UV9Hs98cIJYsUz42Sqe3/mARPFTLaC1H6RBu7T6
	3jPnPi86pEmeRh/hwyXLyrs37e/aO5yzPM1mvDQF/BTPQEZ9F/Ok4BaZpt/NordVkus96Q55T07
	/9nzgjMypb+TMzlTc2ivgZjgJzw5uVCnaFIr/JiLdgpuJbKoatPI11jC9mo/yPoovHQmNg2d5MA
	FN31SR4OepVFnCpahVyM4VN8DGjamGGAvzKbOeyiNM0yx8kavFqooL5NYbHLTpxLtmmw+yj4aTa
	E0iD6Aij+qMAQeD2IkoL1DCQFL3FSis=
X-Received: by 2002:a05:620a:45a4:b0:7a9:aa70:1cea with SMTP id af79cd13be357-7b6bcadba57mr36640485a.5.1733430882197;
        Thu, 05 Dec 2024 12:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoQNFpq0a9qMSUr93HSZrZQJ/cvywQ6beoPoUJWV+eA6Tq4C/Pu7PVHFFrF0k1p0C00Rq2gw==
X-Received: by 2002:a05:620a:45a4:b0:7a9:aa70:1cea with SMTP id af79cd13be357-7b6bcadba57mr36637985a.5.1733430881826;
        Thu, 05 Dec 2024 12:34:41 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e5c5d4sm137138066b.7.2024.12.05.12.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 12:34:41 -0800 (PST)
Message-ID: <72add0ff-db2a-44f8-b4af-0b5fe5f65f20@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 21:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on pre-SYSTEM_SUSPEND
 PSCI impls
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <CAPDyKFpGrw+vOs=-TxfChBeORjzkpaL_iVB08MtmaC4sFNKzcg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPDyKFpGrw+vOs=-TxfChBeORjzkpaL_iVB08MtmaC4sFNKzcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W_l6m7KTn2jkBx7aRTvr2hkE2XX9qaGh
X-Proofpoint-ORIG-GUID: W_l6m7KTn2jkBx7aRTvr2hkE2XX9qaGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050153

On 14.11.2024 4:30 PM, Ulf Hansson wrote:
> On Mon, 28 Oct 2024 at 15:24, Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
>> CPU_SUSPEND instead. Inform Linux about that.
>> Please see the commit messages for a more detailed explanation.
>>
>> This is effectively a more educated follow-up to [1].
>>
>> The ultimate goal is to stop making Linux think that certain states
>> only concern cores/clusters, and consequently setting
>> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
>> NVMe, see related discussion over at [2]) can make informed decisions
>> about assuming the power state of the device they govern.
> 
> In my opinion, this is not really the correct way to do it. Using
> pm_set_suspend/resume_via_firmware() works fine for x86/ACPI, but not
> for PSCI like this. Let me elaborate. If the NVMe storage device is
> sharing the same power-rail as the CPU cluster, then yes we should use
> PSCI to control it. But is that really the case? If so, there are in
> principle two ways forward to deal with this correctly.
> 
> 1) If PSCI OSI mode is being used, the corresponding NVMe storage
> device should be hooked up to the CPU PM cluster domain via genpd and
> controlled as any other devices sharing the cluster-rail. In this way,
> genpd together with the cpuidle-psci-domain can decide whether it's
> okay to turn off the cluster. I believe this is the preferred way, but
> 2) would work fine too.
> 
> 2) If PSCI PC mode is being used, a separate channel/interface to the
> FW (like SCMI or rpmh in the QC case), should inform the FW whether
> NVMe needs the power to it. This information should then be taken into
> account by the PSCI FW when it decides what low-power-state to enter,
> which ultimately means whether the cluster-rail can be turned off or
> not.

This assumes PSCI only governs the CPU power rail. But what I'd
guesstimate is that in most implementations if system-level suspend is
there at all (no matter through which call), as per the spec, it at
least also projects onto the DDR power state (like in this i.mx
impl here [1]), or some uncore peripherals (like in Tegra's case with
some secure element being toggled at [2])

> Assuming PSCI OSI mode is used here. Then if 1) doesn't work for you,
> please elaborate on why, so we can help to make it work, as it should.

On Qualcomm platforms, RPMh is the central authority when it comes
to power governance, but by design, the CPUs must be off (and with a
specific magic cookie) for the RPMh hardware to consider powering off
very power hungry parts of the system, such as general i/o rails.

So again, PSCI must be fed a specific value for the rest of the hw
to react. The "S2RAM state" isn't really a cpuidle state, because
it doesn't differ from many shallower states as far as the cpu/cluster
are concerned. If that all isn't in place, the platform never actually
enters any "real" sleep state, other than "CPU and some controllable
IP blocks are runtime-suspended".

This effectively is very close to what ACPI+x86 do - there's a
co-processor/firmware that does a lot of things behind your back and
all you can do is *ask* it to change some handwavily-defined P/Cstate
that affects a huge chunk of silicon.

Konrad

[1] https://github.com/nxp-imx/imx-atf/blob/lf_v2.6/plat/imx/imx8m/imx8mp/imx8mp_lpa_psci.c#L474
[2] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/nvidia/tegra/soc/t210/plat_psci_handlers.c#L214


