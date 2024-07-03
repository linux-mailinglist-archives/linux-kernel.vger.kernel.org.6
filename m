Return-Path: <linux-kernel+bounces-239067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F49255B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF51F24659
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1A613B586;
	Wed,  3 Jul 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOc2j4p6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099C25760;
	Wed,  3 Jul 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996360; cv=none; b=G8zNuFm3gKFrlkTWocPdkWa5wxrIViIDiAaqeeHV1vWwE0lrAtgmibTaS0a8INUA8AmcVaqbA9DvHwHx+9UiR9cRRM/pQ5W07LfKAkOB8PYY+sitRtu4HX2XErevoqRG9MMvnE1J90vbQuMOd3/JOglqNPORn7PgcLr/5Yzlmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996360; c=relaxed/simple;
	bh=bZhEA+iG47w2bf25yT412zy1rl9nBPtfrbu/tWoKNyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jybnV4RpgZjqV8xV85tgAdIr0pmjFnpzTc1xupTZXqnJSOEo+eTBzMqj1VQx0p6B/Tr1Vmke9rnkKB3br6LPMbRg2BT7uTRaaoef4MIVWy00T7Qm1AdY6JrnLHuPuDBK9vdTcIF7AZ4l2Z0sTRcX+7zDQ48081fi/vTO22REp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOc2j4p6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638BF89004367;
	Wed, 3 Jul 2024 08:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65AdNJmaOOy1xs1euJzg4L5FklK/nivwqug56pwysDw=; b=ZOc2j4p6CygPKwuO
	6ih9pQagG5J8I2x5YUlNoovYCeS7aGXF+WKsiraTpI8RU+fcvAkyXOi9MT8T/GV0
	lyiS2KKsSrBPiW+F4VQhj1wHPTqjBB8sDmI5aw0DGXKXwXAn70Fqz+fdn7TuiW5a
	iX/J0V7M2kDcN1JxiUsrQT4TtVKnVAOidl7J+jpBLUeYuHMtu1VTkQV70G+DBhQL
	ijsep/2PGnZ5EsnycmW2QNEqfdbKAhI8TwkDJB2iojMCcopW9QQ5FHOdMQDcxx2i
	fzbAKrvVP1MCZVOs+1QkhM67myayw7OIzOQqgX+rVOhWQ1byyhDbxSoY5YHst12n
	QTkrgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxg7ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 08:45:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4638jG5v022736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 08:45:16 GMT
Received: from [10.214.67.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 01:45:11 -0700
Message-ID: <4731cfa1-60d6-4f2b-9740-88e546edbd6b@quicinc.com>
Date: Wed, 3 Jul 2024 14:14:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 3/4] soc: qcom: Introduce SCMI based Memlat (Memory
 Latency) governor
To: Sibi Sankar <quic_sibis@quicinc.com>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_rgottimu@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid
	<avajid@quicinc.com>
References: <20240702191440.2161623-1-quic_sibis@quicinc.com>
 <20240702191440.2161623-4-quic_sibis@quicinc.com>
Content-Language: en-US
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <20240702191440.2161623-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -eyxrNGuYRRBwWrOOARXzoTw5A4a5fAF
X-Proofpoint-ORIG-GUID: -eyxrNGuYRRBwWrOOARXzoTw5A4a5fAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030064



On 7/3/2024 12:44 AM, Sibi Sankar wrote:
> Introduce a client driver that uses the memlat algorithm string hosted
> on ARM SCMI QCOM Vendor Protocol to detect memory latency workloads and
> control frequency/level of the various memory buses (DDR/LLCC/DDR_QOS).
> 
> Co-developed-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> Co-developed-by: Amir Vajid <avajid@quicinc.com>
> Signed-off-by: Amir Vajid <avajid@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> V2:
> * Make driver changes to the accommodate bindings changes. [Rob]
> * Replace explicit of_node_put with _free.
> 
>   drivers/soc/qcom/Kconfig            |  12 +
>   drivers/soc/qcom/Makefile           |   1 +
>   drivers/soc/qcom/qcom_scmi_client.c | 583 ++++++++++++++++++++++++++++
>   3 files changed, 596 insertions(+)
>   create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 432c85bd8ad4..b253504bd386 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -294,4 +294,16 @@ config QCOM_PBS
>   	  This module provides the APIs to the client drivers that wants to send the
>   	  PBS trigger event to the PBS RAM.
>   
> +config QCOM_SCMI_CLIENT
> +	tristate "Qualcomm Technologies Inc. SCMI client driver"
> +	depends on ARM_SCMI_PROTOCOL_VENDOR_QCOM || COMPILE_TEST
> +	default n
> +	help
> +	  This driver uses the memlat algorithm string hosted on QCOM SCMI
> +	  Vendor Protocol to detect memory latency workloads and control
> +	  frequency/level of the various memory buses (DDR/LLCC/DDR_QOS).
> +
> +	  This driver defines/documents the parameter IDs used while configuring
> +	  the memory buses.
> +
>   endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index d3560f861085..8a2e832d1d5d 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_QCOM_APR) += apr.o
>   obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>   obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> +obj-$(CONFIG_QCOM_SCMI_CLIENT)	+= qcom_scmi_client.o
>   qcom_ice-objs			+= ice.o
>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>   obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
> diff --git a/drivers/soc/qcom/qcom_scmi_client.c b/drivers/soc/qcom/qcom_scmi_client.c
> new file mode 100644
> index 000000000000..8369b415c0ab
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_scmi_client.c
> @@ -0,0 +1,583 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/qcom_scmi_vendor.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/units.h>
> +#include <dt-bindings/soc/qcom,scmi-vendor.h>
> +
> +#define MEMLAT_ALGO_STR				0x4D454D4C4154 /* MEMLAT */
> +#define INVALID_IDX				0xff
> +#define MAX_MEMORY_TYPES			3
> +#define MAX_MONITOR_CNT				4
> +#define MAX_NAME_LEN				20
> +#define MAX_MAP_ENTRIES				7
> +#define CPUCP_DEFAULT_SAMPLING_PERIOD_MS	4
> +#define CPUCP_DEFAULT_FREQ_METHOD		1
> +
> +/**
> + * scmi_memlat_protocol_cmd - parameter_ids supported by the "MEMLAT" algo_str hosted
> + *                            by the Qualcomm SCMI Vendor Protocol on the SCMI controller.
> + *
> + * MEMLAT (Memory Latency) monitors the counters to detect memory latency bound workloads
> + * and scales the frequency/levels of the memory buses accordingly.
> + *
> + * @MEMLAT_SET_MEM_GROUP: initializes the frequency/level scaling functions for the memory bus.
> + * @MEMLAT_SET_MONITOR: configures the monitor to work on a specific memory bus.
> + * @MEMLAT_SET_COMMON_EV_MAP: set up common counters used to monitor the cpu frequency.
> + * @MEMLAT_SET_GRP_EV_MAP: set up any specific counters used to monitor the memory bus.
> + * @MEMLAT_IPM_CEIL: set the IPM (Instruction Per Misses) ceiling per monitor.
> + * @MEMLAT_SAMPLE_MS: set the sampling period for all the monitors.
> + * MEMLAT_MON_FREQ_MAP: setup the cpufreq to memfreq map.
> + * MEMLAT_SET_MIN_FREQ: set the max frequency of the memory bus.
> + * MEMLAT_SET_MAX_FREQ: set the min frequency of the memory bus.
> + * MEMLAT_START_TIMER: start all the monitors with the requested sampling period.
> + * MEMLAT_START_TIMER: stop all the running monitors.

Typo above, it should be MEMLAT_STOP_TIMER

> + * MEMLAT_SET_EFFECTIVE_FREQ_METHOD: set the method used to determine cpu frequency.
> + */
> +enum scmi_memlat_protocol_cmd {
> +	MEMLAT_SET_MEM_GROUP = 16,
> +	MEMLAT_SET_MONITOR,
> +	MEMLAT_SET_COMMON_EV_MAP,
> +	MEMLAT_SET_GRP_EV_MAP,
> +	MEMLAT_IPM_CEIL = 23,
> +	MEMLAT_SAMPLE_MS = 31,
> +	MEMLAT_MON_FREQ_MAP,
> +	MEMLAT_SET_MIN_FREQ,
> +	MEMLAT_SET_MAX_FREQ,
> +	MEMLAT_START_TIMER = 36,
> +	MEMLAT_STOP_TIMER,
> +	MEMLAT_SET_EFFECTIVE_FREQ_METHOD = 39,
> +};
> +
> +struct map_table {
> +	u16 v1;
> +	u16 v2;
> +};
> +
> +struct map_param_msg {
> +	u32 hw_type;
> +	u32 mon_idx;
> +	u32 nr_rows;
> +	struct map_table tbl[MAX_MAP_ENTRIES];
> +} __packed;
> +
> +struct node_msg {
> +	u32 cpumask;
> +	u32 hw_type;
> +	u32 mon_type;
> +	u32 mon_idx;
> +	char mon_name[MAX_NAME_LEN];
> +};
> +
> +struct scalar_param_msg {
> +	u32 hw_type;
> +	u32 mon_idx;
> +	u32 val;
> +};
> +
> +enum common_ev_idx {
> +	INST_IDX,
> +	CYC_IDX,
> +	CONST_CYC_IDX,
> +	FE_STALL_IDX,
> +	BE_STALL_IDX,
> +	NUM_COMMON_EVS
> +};
> +
> +enum grp_ev_idx {
> +	MISS_IDX,
> +	WB_IDX,
> +	ACC_IDX,
> +	NUM_GRP_EVS
> +};
> +
> +#define EV_CPU_CYCLES		0
> +#define EV_INST_RETIRED		2
> +#define EV_L2_D_RFILL		5
> +
> +struct ev_map_msg {
> +	u32 num_evs;
> +	u32 hw_type;
> +	u32 cid[NUM_COMMON_EVS];
> +};
> +
> +struct cpufreq_memfreq_map {
> +	unsigned int cpufreq_mhz;
> +	unsigned int memfreq_khz;
> +};
> +
> +struct scmi_monitor_info {
> +	struct cpufreq_memfreq_map *freq_map;
> +	char mon_name[MAX_NAME_LEN];
> +	u32 mon_idx;
> +	u32 mon_type;
> +	u32 ipm_ceil;
> +	u32 mask;
> +	u32 freq_map_len;
> +};
> +
> +struct scmi_memory_info {
> +	struct scmi_monitor_info *monitor[MAX_MONITOR_CNT];
> +	u32 hw_type;
> +	int monitor_cnt;
> +	u32 min_freq;
> +	u32 max_freq;
> +};
> +
> +struct scmi_memlat_info {
> +	struct scmi_protocol_handle *ph;
> +	const struct qcom_scmi_vendor_ops *ops;
> +	struct scmi_memory_info *memory[MAX_MEMORY_TYPES];
> +	u32 cluster_info[NR_CPUS];
> +	int memory_cnt;
> +};
> +
> +static int populate_cluster_info(u32 *cluster_info)
> +{
> +	char name[MAX_NAME_LEN];
> +	int i = 0;
> +
> +	struct device_node *cn __free(device_node) = of_find_node_by_path("/cpus");
> +	if (!cn)
> +		return -ENODEV;
> +
> +	struct device_node *map __free(device_node) = of_get_child_by_name(cn, "cpu-map");
> +	if (!map)
> +		return -ENODEV;
> +
> +	do {
> +		snprintf(name, sizeof(name), "cluster%d", i);
> +		struct device_node *c __free(device_node) = of_get_child_by_name(map, name);
> +		if (!c)
> +			break;
> +
> +		*(cluster_info + i) = of_get_child_count(c);
> +		i++;
> +	} while (1);
> +
> +	return 0;
> +}
> +
> +static int populate_physical_mask(struct device_node *np, u32 *mask, u32 *cluster_info)
> +{
> +	struct device_node *dev_phandle;
> +	int cpu, i = 0, physical_id;
> +
> +	do {
> +		dev_phandle = of_parse_phandle(np, "cpus", i++);
> +		cpu = of_cpu_node_to_id(dev_phandle);
> +		if (cpu != -ENODEV) {
> +			physical_id = topology_core_id(cpu);
> +			for (int j = 0; j < topology_cluster_id(cpu); j++)
> +				physical_id += *(cluster_info + j);
> +			*mask |= BIT(physical_id);
> +		}
> +	} while (dev_phandle);
> +
> +	return 0;
> +}
> +
> +static struct cpufreq_memfreq_map *init_cpufreq_memfreq_map(struct device *dev,
> +							    struct scmi_memory_info *memory,
> +							    struct device_node *of_node,
> +							    u32 *cnt)
> +{
> +	struct device_node *tbl_np, *opp_np;
> +	struct cpufreq_memfreq_map *tbl;
> +	int ret, i = 0;
> +	u32 level, len;
> +	u64 rate;
> +
> +	tbl_np = of_parse_phandle(of_node, "operating-points-v2", 0);
> +	if (!tbl_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	len = min(of_get_available_child_count(tbl_np), MAX_MAP_ENTRIES);
> +	if (len == 0)
> +		return ERR_PTR(-ENODEV);
> +
> +	tbl = devm_kzalloc(dev, (len + 1) * sizeof(struct cpufreq_memfreq_map),
> +			   GFP_KERNEL);
> +	if (!tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for_each_available_child_of_node(tbl_np, opp_np) {
> +		ret = of_property_read_u64_index(opp_np, "opp-hz", 0, &rate);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		tbl[i].cpufreq_mhz = rate / HZ_PER_MHZ;
> +
> +		if (memory->hw_type != QCOM_MEM_TYPE_DDR_QOS) {
> +			ret = of_property_read_u64_index(opp_np, "opp-hz", 1, &rate);
> +			if (ret < 0)
> +				return ERR_PTR(ret);
> +
> +			tbl[i].memfreq_khz = rate / HZ_PER_KHZ;
> +		} else {
> +			ret = of_property_read_u32(opp_np, "opp-level", &level);
> +			if (ret < 0)
> +				return ERR_PTR(ret);
> +
> +			tbl[i].memfreq_khz = level;
> +		}
> +
> +		dev_dbg(dev, "Entry%d CPU:%u, Mem:%u\n", i, tbl[i].cpufreq_mhz, tbl[i].memfreq_khz);
> +		i++;
> +	}
> +	*cnt = len;
> +	tbl[i].cpufreq_mhz = 0;

This is not needed as for allocating memory, devm_kzalloc is used.

> +
> +	return tbl;
> +}
> +
> +static int process_scmi_memlat_of_node(struct scmi_device *sdev, struct scmi_memlat_info *info)
> +{
> +	struct scmi_monitor_info *monitor;
> +	struct scmi_memory_info *memory;
> +	char name[MAX_NAME_LEN];
> +	u64 memfreq[2];
> +	int ret;
> +
> +	ret = populate_cluster_info(info->cluster_info);
> +	if (ret < 0) {
> +		dev_err_probe(&sdev->dev, ret, "failed to populate cluster info\n");
> +		goto err;
> +	}
> +
> +	of_node_get(sdev->handle->dev->of_node);
> +	do {
> +		snprintf(name, sizeof(name), "memory-%d", info->memory_cnt);
> +		struct device_node *memory_np __free(device_node) =
> +			of_find_node_by_name(sdev->handle->dev->of_node, name);
> +
> +		if (!memory_np)
> +			break;
> +
> +		memory = devm_kzalloc(&sdev->dev, sizeof(*memory), GFP_KERNEL);
> +		if (!memory) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = of_property_read_u32(memory_np, "qcom,memory-type", &memory->hw_type);
> +		if (ret) {
> +			dev_err_probe(&sdev->dev, ret, "failed to read memory type\n");
> +			goto err;
> +		}
> +
> +		ret = of_property_read_u64_array(memory_np, "freq-table-hz", memfreq, 2);
> +		if (ret && (ret != -EINVAL)) {
> +			dev_err_probe(&sdev->dev, ret, "failed to read min/max freq\n");
> +			goto err;
> +		}
> +
> +		if (memory->hw_type != QCOM_MEM_TYPE_DDR_QOS) {
> +			memory->min_freq = memfreq[0] / HZ_PER_KHZ;
> +			memory->max_freq = memfreq[1] / HZ_PER_KHZ;
> +		} else {
> +			memory->min_freq = memfreq[0];
> +			memory->max_freq = memfreq[1];
> +		}
> +		info->memory[info->memory_cnt++] = memory;
> +
> +		do {
> +			snprintf(name, sizeof(name), "monitor-%d", memory->monitor_cnt);
> +			struct device_node *monitor_np __free(device_node) =
> +				of_get_child_by_name(memory_np, name);
> +
> +			if (!monitor_np)
> +				break;
> +
> +			monitor = devm_kzalloc(&sdev->dev, sizeof(*monitor), GFP_KERNEL);
> +			if (!monitor) {
> +				ret = -ENOMEM;
> +				goto err;
> +			}
> +
> +			monitor->mon_type = of_property_read_bool(monitor_np, "qcom,compute-type");
> +			if (!monitor->mon_type) {
> +				ret = of_property_read_u32(monitor_np, "qcom,ipm-ceil",
> +							   &monitor->ipm_ceil);
> +				if (ret) {
> +					dev_err_probe(&sdev->dev, ret,
> +						      "failed to read IPM ceiling\n");
> +					goto err;
> +				}
> +			}
> +
> +			/*
> +			 * Variants of the SoC having reduced number of cpus operate
> +			 * with the same number of logical cpus but the physical
> +			 * cpu disabled will differ between parts. Calculate the
> +			 * physical cpu number using cluster information instead.
> +			 */
> +			ret = populate_physical_mask(monitor_np, &monitor->mask,
> +						     info->cluster_info);
> +			if (ret < 0) {
> +				dev_err_probe(&sdev->dev, ret, "failed to populate cpu mask\n");
> +				goto err;
> +			}
> +

Above error check is not needed as populate_physical_mask always return 0.


> +			monitor->freq_map = init_cpufreq_memfreq_map(&sdev->dev, memory, monitor_np,
> +								     &monitor->freq_map_len);
> +			if (IS_ERR(monitor->freq_map)) {
> +				dev_err_probe(&sdev->dev, PTR_ERR(monitor->freq_map),
> +					      "failed to populate cpufreq-memfreq map\n");
> +				goto err;
> +			}
> +
> +			strscpy(monitor->mon_name, name, sizeof(monitor->mon_name));
> +			monitor->mon_idx = memory->monitor_cnt;
> +
> +			memory->monitor[memory->monitor_cnt++] = monitor;

If from dt, more than 4 monitor are passed then this may lead to 
overflow, adding a check and giving warning in case number of monitor 
exceeds MAX_MONITOR_CNT will be better idea.


> +		} while (1);
> +
> +		if (!memory->monitor_cnt) {
> +			ret = -EINVAL;
> +			dev_err_probe(&sdev->dev, ret, "failed to find monitor nodes\n");
> +			goto err;
> +		}
> +	} while (1);
> +
> +	if (!info->memory_cnt) {
> +		ret = -EINVAL;
> +		dev_err_probe(&sdev->dev, ret, "failed to find memory nodes\n");
> +	}
> +
> +err:
> +	of_node_put(sdev->handle->dev->of_node);
> +
> +	return ret;
> +}
> +
> +static int configure_cpucp_common_events(struct scmi_memlat_info *info)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	u8 ev_map[NUM_COMMON_EVS];
> +	struct ev_map_msg msg;
> +	int ret;
> +
> +	memset(ev_map, 0xFF, NUM_COMMON_EVS);
> +
> +	msg.num_evs = NUM_COMMON_EVS;
> +	msg.hw_type = INVALID_IDX;
> +	msg.cid[INST_IDX] = EV_INST_RETIRED;
> +	msg.cid[CYC_IDX] = EV_CPU_CYCLES;
> +	msg.cid[CONST_CYC_IDX] = INVALID_IDX;
> +	msg.cid[FE_STALL_IDX] = INVALID_IDX;
> +	msg.cid[BE_STALL_IDX] = INVALID_IDX;
> +
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_COMMON_EV_MAP,
> +			     sizeof(msg));
> +	return ret;
> +}
> +
> +static int configure_cpucp_grp(struct device *dev, struct scmi_memlat_info *info, int memory_index)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	struct scmi_memory_info *memory = info->memory[memory_index];
> +	struct ev_map_msg ev_msg;
> +	u8 ev_map[NUM_GRP_EVS];
> +	struct node_msg msg;
> +	int ret;
> +
> +	msg.cpumask = 0;
> +	msg.hw_type = memory->hw_type;
> +	msg.mon_type = 0;
> +	msg.mon_idx = 0;
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MEM_GROUP, sizeof(msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to configure mem type %d\n", memory->hw_type);
> +		return ret;
> +	}
> +
> +	memset(ev_map, 0xFF, NUM_GRP_EVS);
> +	ev_msg.num_evs = NUM_GRP_EVS;
> +	ev_msg.hw_type = memory->hw_type;
> +	ev_msg.cid[MISS_IDX] = EV_L2_D_RFILL;
> +	ev_msg.cid[WB_IDX] = INVALID_IDX;
> +	ev_msg.cid[ACC_IDX] = INVALID_IDX;
> +	ret = ops->set_param(info->ph, &ev_msg, MEMLAT_ALGO_STR, MEMLAT_SET_GRP_EV_MAP,
> +			     sizeof(ev_msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret,
> +			      "failed to configure event map for mem type %d\n", memory->hw_type);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int configure_cpucp_mon(struct device *dev, struct scmi_memlat_info *info,
> +			       int memory_index, int monitor_index)
> +{
> +	const struct qcom_scmi_vendor_ops *ops = info->ops;
> +	struct scmi_memory_info *memory = info->memory[memory_index];
> +	struct scmi_monitor_info *monitor = memory->monitor[monitor_index];
> +	struct scalar_param_msg scalar_msg;
> +	struct map_param_msg map_msg;
> +	struct node_msg msg;
> +	int ret;
> +	int i;
> +
> +	msg.cpumask = monitor->mask;
> +	msg.hw_type = memory->hw_type;
> +	msg.mon_type = monitor->mon_type;
> +	msg.mon_idx = monitor->mon_idx;
> +	strscpy(msg.mon_name, monitor->mon_name, sizeof(msg.mon_name));
> +	ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MONITOR, sizeof(msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to configure monitor %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = monitor->ipm_ceil;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_IPM_CEIL,
> +			     sizeof(scalar_msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to set ipm ceil for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	map_msg.hw_type = memory->hw_type;
> +	map_msg.mon_idx = monitor->mon_idx;
> +	map_msg.nr_rows = monitor->freq_map_len;
> +	for (i = 0; i < monitor->freq_map_len; i++) {
> +		map_msg.tbl[i].v1 = monitor->freq_map[i].cpufreq_mhz;
> +		map_msg.tbl[i].v2 = monitor->freq_map[i].memfreq_khz;
> +	}
> +	ret = ops->set_param(info->ph, &map_msg, MEMLAT_ALGO_STR, MEMLAT_MON_FREQ_MAP,
> +			     sizeof(map_msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to configure freq_map for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = memory->min_freq;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MIN_FREQ,
> +			     sizeof(scalar_msg));
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to set min_freq for %s\n", monitor->mon_name);
> +		return ret;
> +	}
> +
> +	scalar_msg.hw_type = memory->hw_type;
> +	scalar_msg.mon_idx = monitor->mon_idx;
> +	scalar_msg.val = memory->max_freq;
> +	ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MAX_FREQ,
> +			     sizeof(scalar_msg));
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "failed to set max_freq for %s\n", monitor->mon_name);
> +
> +	return ret;
> +}
> +
> +static int cpucp_memlat_init(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	const struct qcom_scmi_vendor_ops *ops;
> +	struct scmi_protocol_handle *ph;
> +	struct scmi_memlat_info *info;
> +	u32 cpucp_freq_method = CPUCP_DEFAULT_FREQ_METHOD;
> +	u32 cpucp_sample_ms = CPUCP_DEFAULT_SAMPLING_PERIOD_MS;
> +	int ret, i, j;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	ops = handle->devm_protocol_get(sdev, QCOM_SCMI_VENDOR_PROTOCOL, &ph);
> +	if (IS_ERR(ops))
> +		return PTR_ERR(ops);
> +
> +	info = devm_kzalloc(&sdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret = process_scmi_memlat_of_node(sdev, info);
> +	if (ret)
> +		return ret;
> +
> +	info->ph = ph;
> +	info->ops = ops;
> +
> +	/* Configure common events ids */
> +	ret = configure_cpucp_common_events(info);
> +	if (ret < 0) {
> +		dev_err_probe(&sdev->dev, ret, "failed to configure common events\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < info->memory_cnt; i++) {
> +		/* Configure per group parameters */
> +		ret = configure_cpucp_grp(&sdev->dev, info, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (j = 0; j < info->memory[i]->monitor_cnt; j++) {
> +			/* Configure per monitor parameters */
> +			ret = configure_cpucp_mon(&sdev->dev, info, i, j);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	/* Set loop sampling time */
> +	ret = ops->set_param(ph, &cpucp_sample_ms, MEMLAT_ALGO_STR, MEMLAT_SAMPLE_MS,
> +			     sizeof(cpucp_sample_ms));
> +	if (ret < 0) {
> +		dev_err_probe(&sdev->dev, ret, "failed to set sample_ms\n");
> +		return ret;
> +	}
> +
> +	/* Set the effective cpu frequency calculation method */
> +	ret = ops->set_param(ph, &cpucp_freq_method, MEMLAT_ALGO_STR,
> +			     MEMLAT_SET_EFFECTIVE_FREQ_METHOD, sizeof(cpucp_freq_method));
> +	if (ret < 0) {
> +		dev_err_probe(&sdev->dev, ret, "failed to set effective frequency calc method\n");
> +		return ret;
> +	}
> +
> +	/* Start sampling and voting timer */
> +	ret = ops->start_activity(ph, NULL, MEMLAT_ALGO_STR, MEMLAT_START_TIMER, 0);
> +	if (ret < 0)
> +		dev_err_probe(&sdev->dev, ret, "failed to start memory group timer\n");
> +
> +	return ret;
> +}
> +
> +static int scmi_client_probe(struct scmi_device *sdev)
> +{
> +	return cpucp_memlat_init(sdev);
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ .protocol_id = QCOM_SCMI_VENDOR_PROTOCOL, .name = "qcom_scmi_vendor_protocol" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver qcom_scmi_client_drv = {
> +	.name		= "qcom-scmi-driver",
> +	.probe		= scmi_client_probe,
> +	.id_table	= scmi_id_table,
> +};
> +module_scmi_driver(qcom_scmi_client_drv);
> +
> +MODULE_DESCRIPTION("QTI SCMI client driver");
> +MODULE_LICENSE("GPL");

