Return-Path: <linux-kernel+bounces-534704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE73A46A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EBE3A115E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631A22D784;
	Wed, 26 Feb 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DnF3rouf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615C225768
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595766; cv=none; b=qpc2Udv+rnTsDi7PbNCOtWGWo1t+nRAhbalsSjJDIVA1uOc4zG0q0b323rqqmg4tg7jxIa1e1WWg5j8dtUpZqaI4yLU4hPPvJMHgpKHB3RG44iqPqqH4RdOj0xf/1Yi/urb9zZezOCKC1+brwFc6ugscvB25r0KjC6lYjwtX8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595766; c=relaxed/simple;
	bh=lT/l+oV926s1PxTIvlgci5M/fqjzVL08IOVsaaJydq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iBGPti0nDmPUNkeRDLvLxBeIgDi4s8xask5W+NerVlYOdgdjVmeU8ycQT5ypSMoxMAUgdG6LN191gwIPKwVFRaC5u9vQe80zSmOF4Z+AEWLGcDj6VEpuQV4bwfH3WL0iTg3eEpMi2y5iYhUuxRLPQfmENr8lsAhjl46cKs5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DnF3rouf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QB0i59004593
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MITHVxmcAQ6A43ETluCVH8qk
	tHM9iyaVcLEvG9Imcc0=; b=DnF3rouf+nplhh4zddEr6fKmz9N/DWigWG+ZNOVq
	v0h2EbK6YIEi9YyRZFRod5ya6bj+mxq1uAQTh2PcYNktHXF/+RtV7pg6+K9j25tL
	2mIBkb+Ldrkj9/H3+aeUo+/eI2VQ8Di9WpqrVHsWy9onkkTpTazjeDoSC/UQF0ZH
	NUI/P4HmNZucyUX5ZsMim7VGq36MpjUJyhzUZ12fz7k8IKEavvguRkkMP7ZlwxLo
	B8KjMH1jp5zZr0i5zINPpuVDTL8zcfstIW3Xm21ribnyM+uvgsSp2C5NWHpb2/k8
	85YLzIPZGYx24acms0w2dlwEIQMgCeVP5mofjoOk52v0nQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4521ph99ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:49:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2233b154004so1644205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595763; x=1741200563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MITHVxmcAQ6A43ETluCVH8qktHM9iyaVcLEvG9Imcc0=;
        b=xIqJhMt2QdMhqLfGHIn50+qr9enZxmmDJQqPNwz3o21X5IRPoGmiqtR4GJwS6/TqZ7
         pNaZ7yDX+qIABhfU//gDuEN2q7tXA5Blyh+4Io6uyDVIoVcZzG3dcWigsxf8am2TYjia
         jqT4EcbjC8CoZqQ5jGPXIzf+7/TcMv8qUFdrggf3futsx9qbgc50zESi80uw008O+Zgz
         Ogb0xlFLmYGNGjpaWG05F5pxO5vo8VXVL/ZoUa0XN9WkclvJuXw7z+CQJ2KB0XSdie7c
         QBquybeTfLu/8eRkDmCn1dlTCXfGAXBtHOeLRnJQzJ6JqpDszyu8nx5kspxmHQy3z/Aa
         XICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfUMbC2aR9hWNqNaHTubkd9g5eejT8XoODzgXyo+oB3b9LbLx6m2Dy+qnYHCYw05jYBrbZi2Uj4bbnXXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nUGudqrv7jZCZOUY3ff0neV9Hwd1TKZZ6cBMcSr3fA1aXh1z
	BIblcccUVQls13fVXjfFSjLnqJ3mtmM8dnsyKnOgX3n9le4sFTYmudIET50W5IOMptmVHGDfYVU
	WinFNxY+CQEhMrlWz+OTgCcUpOQyXL2ScDu2AB/3O8hVCY3radW2SamUzkzr8LBA=
X-Gm-Gg: ASbGncu8WkT/v81rALNCh43Z40b/Pu+sI1OyndNkDmYauChIf9BpopQUz+9cyIlujab
	cHxk7O7I4eMoowkwfSm4MCJlRPYizZ3Vin0/WOHHa+X2fwoZCAxqnHBZenph7+K6D4FZ+qK6Wc/
	IhS+C0kNhsqAHFPRq5Yfxqameur5mfO8XSBz/qsu0b2WYsj61iqvbC0eXzAuXd36PBzHbLnauoq
	F9XF9qZrlybpVzcGsRXC5wySibaQXI4brKMaJ23EJvIaITHSnMdGw3NXjsV9+geqoKdqEme8HsA
	LUn7HOd5BJA10fde7tMjRT5SwLnxeu0izY7qC7uZ8Hb8KaGB/PSRY6CW8SQOX5mE4GyPuwo=
X-Received: by 2002:a17:903:40d1:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2232020856bmr63132625ad.42.1740595762859;
        Wed, 26 Feb 2025 10:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRjzWrcltS/SmKz3Q5inlltvidwmKOdKizJT4TsTs1McdWObFowvI+RYwMenjlWzuLSoAsJA==
X-Received: by 2002:a17:903:40d1:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2232020856bmr63132325ad.42.1740595762411;
        Wed, 26 Feb 2025 10:49:22 -0800 (PST)
Received: from hu-eberman-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0944d4sm36517005ad.140.2025.02.26.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:49:22 -0800 (PST)
Date: Wed, 26 Feb 2025 10:49:20 -0800
From: Elliot Berman <elliot.berman@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] firmware: psci: Read and use vendor reset types
Message-ID: <20250226101913390-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
 <20241107-arm-psci-system_reset2-vendor-reboots-v8-3-e8715fa65cb5@quicinc.com>
 <Z78lH/XErc7G8bL9@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78lH/XErc7G8bL9@lpieralisi>
X-Proofpoint-GUID: vU3U1CB7IJIsNvd7ZjdBS6dka20gKEiM
X-Proofpoint-ORIG-GUID: vU3U1CB7IJIsNvd7ZjdBS6dka20gKEiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260148

On Wed, Feb 26, 2025 at 03:28:47PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Nov 07, 2024 at 03:38:27PM -0800, Elliot Berman wrote:
> > SoC vendors have different types of resets and are controlled through
> > various registers. For instance, Qualcomm chipsets can reboot to a
> > "download mode" that allows a RAM dump to be collected. Another example
> > is they also support writing a cookie that can be read by bootloader
> > during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> > vendor reset types to be implemented without requiring drivers for every
> > register/cookie.
> > 
> > Add support in PSCI to statically map reboot mode commands from
> > userspace to a vendor reset and cookie value using the device tree.
> > 
> > A separate initcall is needed to parse the devicetree, instead of using
> > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > 
> > Reboot mode framework is close but doesn't quite fit with the
> > design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> > be solved but doesn't seem reasonable in sum:
> >  1. reboot mode registers against the reboot_notifier_list, which is too
> >     early to call SYSTEM_RESET2. PSCI would need to remember the reset
> >     type from the reboot-mode framework callback and use it
> >     psci_sys_reset.
> >  2. reboot mode assumes only one cookie/parameter is described in the
> >     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> >     cookie.
> >  3. psci cpuidle driver already registers a driver against the
> >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> >     cpuidle and reboot-mode driver.
> > 
> > Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  drivers/firmware/psci/psci.c | 104 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> > 
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 2328ca58bba61fdb677ac20a1a7447882cd0cf22..e60e3f8749c5a6732c51d23a2c1f453361132d9a 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -79,6 +79,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
> >  static u32 psci_cpu_suspend_feature;
> >  static bool psci_system_reset2_supported;
> >  
> > +struct psci_reset_param {
> > +	const char *mode;
> > +	u32 reset_type;
> > +	u32 cookie;
> > +};
> > +static struct psci_reset_param *psci_reset_params __ro_after_init;
> > +static size_t num_psci_reset_params __ro_after_init;
> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >  	return psci_cpu_suspend_feature &
> > @@ -305,9 +313,38 @@ static int get_set_conduit_method(const struct device_node *np)
> >  	return 0;
> >  }
> >  
> > +static void psci_vendor_system_reset2(const char *cmd)
> > +{
> > +	unsigned long ret;
> > +	size_t i;
> > +
> > +	for (i = 0; i < num_psci_reset_params; i++) {
> > +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > +					     psci_reset_params[i].reset_type,
> > +					     psci_reset_params[i].cookie, 0);
> > +			/*
> > +			 * if vendor reset fails, log it and fall back to
> > +			 * architecture reset types
> > +			 */
> > +			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
> > +			       (long)ret);
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> >  			  void *data)
> >  {
> > +	/*
> > +	 * try to do the vendor system_reset2
> > +	 * If the reset fails or there wasn't a match on the command,
> > +	 * fall back to architectural resets
> > +	 */
> > +	if (data && num_psci_reset_params)
> > +		psci_vendor_system_reset2(data);
> 
> Mulling over this. If a command (data) was provided and a PSCI vendor
> reset parsed at boot, if the vendor reset fails, isn't it correct to
> just fail reboot instead of falling back to architectural resets ?
> 

Sure! I can change the behavior here.

> What's missing is defining the "contract" between the
> LINUX_REBOOT_CMD_RESTART2 arg parameter and the kernel reboot
> type that is executed.
> 
> I do wonder whether this is an opportunity to deprecate reboot_mode
> altogether on arm64 (I think that the relationship between REBOOT_WARM
> and REBOOT_SOFT with PSCI arch warm reset is already loose - let alone
> falling back to cold reset if reboot_mode == REBOOT_GPIO - which does
> not make any sense at all simply because REBOOT_GPIO is ill-defined to
> say the least).
> 
> Thoughts ?
> 

I'm not opposed to seeing how we can deprecate the reboot_mode enum for
arm64, but I think this should be an independent effort from the vendor
resets. I'm worried this takes us down the "don't let perfect be the
enemy of good" path to support vendor resets. I haven't seen much
interest in this issue outside the two of us, and thus changing
important infrastructure like reboot seems to me to be a long shot.

Thanks,
Elliot

