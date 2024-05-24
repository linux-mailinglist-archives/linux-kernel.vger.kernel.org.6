Return-Path: <linux-kernel+bounces-189065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C58CEA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402DA1F21AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25257CAA;
	Fri, 24 May 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W6ZKXOJi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9D39ADB;
	Fri, 24 May 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580746; cv=none; b=tKFScNAK7UBGhS1raGIrtCHvAl6BG9LkYlnPc69m9xKY3kRMYpb7Nh2zldc18a3QDdmrkHYinryOPhst3OA7TOdycihPDDeruhP/k4fKDBPfQ+VsTVmw2xcHNMxb+0vSYFhBLN1WjTcKKYG7/nyN6asSCjp+kqWUoiGIlQQeu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580746; c=relaxed/simple;
	bh=fuhKjdqpJDF2Myq2XD3YTrgVX+iL1gjq5yLWUdtuVkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hdCtCKqhsfE8NME/M1Cx8EqdSXkTa8NY9OOSkrLTyPSPxR3vtj/FxDZYnGBxVNCqxgL/x6Z5v+Z99DhHdod/vOWvHlacAUsMdiobi2vLIAwoVts/0XzHbOidopahXZFToGswJXr9S5uqJHW8MNUN8gNhblWQF8ixMJEj3sT16aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W6ZKXOJi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9aFRo004328;
	Fri, 24 May 2024 19:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sLZhWObGikSGDoBWQlHqXlsD+iwgEp8P5NbyjNW1yL8=; b=W6ZKXOJiVvr4g66n
	zEeN6t+qVDltGeyNQNt9WGSF8xWmkD21fi3SL2cDf1VZBhppBhKX0q0Wx9Pl76Mc
	Xu55g2jjhzIunT3UR0Be9eNWPVODtmGy6w5YENny700Xp+wzvdbeOw6drBRtI+eE
	lk6EeNsYYDAbIKSmRVR8knR4Pz4u843xmAOArIOlhD4JyKqLeAOKaBoHoxu7Esud
	noRvXdPR1oG+gaJUaekN9ZBWbZd0fcnhHbfsdNCzRNMaX20SlPWrpFWSlQ7bIYy/
	G3TxnXRIbgwbzdpaMhQhAp7IX6ZAxZO7AbIcDXcaR7Q4LnlyRPFGmiIZCyTLziCe
	sXpCXw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8kkb0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 19:58:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OJwsZ3017665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 19:58:54 GMT
Received: from [10.110.54.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 12:58:53 -0700
Message-ID: <d9a502a2-9ad3-3b95-670a-3a67887ef54b@quicinc.com>
Date: Fri, 24 May 2024 12:58:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Revert "drm/msm/dpu: drop
 dpu_encoder_phys_ops.atomic_mode_set"
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240522-dpu-revert-ams-v2-1-b37825d708e1@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240522-dpu-revert-ams-v2-1-b37825d708e1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yc36WqyVPFfytIwhAY8WcWeeB_HI0dAj
X-Proofpoint-GUID: Yc36WqyVPFfytIwhAY8WcWeeB_HI0dAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_06,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240142



On 5/22/2024 3:24 AM, Dmitry Baryshkov wrote:
> In the DPU driver blank IRQ handling is called from a vblank worker and
> can happen outside of the irq_enable / irq_disable pair. Using the
> worker makes that completely asynchronous with the rest of the code.
> Revert commit d13f638c9b88 ("drm/msm/dpu: drop
> dpu_encoder_phys_ops.atomic_mode_set") to fix vblank IRQ assignment for
> CMD DSI panels.
> 
> Call trace:
>   dpu_encoder_phys_cmd_control_vblank_irq+0x218/0x294
>    dpu_encoder_toggle_vblank_for_crtc+0x160/0x194
>    dpu_crtc_vblank+0xbc/0x228
>    dpu_kms_enable_vblank+0x18/0x24
>    vblank_ctrl_worker+0x34/0x6c
>    process_one_work+0x218/0x620
>    worker_thread+0x1ac/0x37c
>    kthread+0x114/0x118
>    ret_from_fork+0x10/0x20
>

Thanks for the stack.

Agreed that vblank can be controlled asynchronously through the worker.

And I am guessing that the worker thread ran and printed this error 
message because phys_enc->irq[INTR_IDX_VSYNC] was not valid as modeset 
had not happened by then?

272 end:
273 	if (ret) {
274 		DRM_ERROR("vblank irq err id:%u pp:%d ret:%d, enable %s/%d\n",
275 			  DRMID(phys_enc->parent),
276 			  phys_enc->hw_pp->idx - PINGPONG_0, ret,
277 			  enable ? "true" : "false", refcount);
278 	}

But how come this did not happen even with this revert.

IOW, I am still missing how moving the irq assignment back to modeset 
from enable is fixing this?

> Fixes: d13f638c9b88 ("drm/msm/dpu: drop dpu_encoder_phys_ops.atomic_mode_set")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Expanded commit message to describe the reason for revert and added a
>    call trace (Abhinav)
> - Link to v1: https://lore.kernel.org/r/20240514-dpu-revert-ams-v1-1-b13623d6cd5f@linaro.org
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |  5 ++++
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   | 32 ++++++++++++----------
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 13 +++++++--
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    | 11 +++++++-
>   5 files changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 119f3ea50a7c..a7d8ecf3f5be 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1200,6 +1200,8 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   		phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[i]);
>   
>   		phys->cached_mode = crtc_state->adjusted_mode;
> +		if (phys->ops.atomic_mode_set)
> +			phys->ops.atomic_mode_set(phys, crtc_state, conn_state);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 002e89cc1705..30470cd15a48 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -69,6 +69,8 @@ struct dpu_encoder_phys;
>    * @is_master:			Whether this phys_enc is the current master
>    *				encoder. Can be switched at enable time. Based
>    *				on split_role and current mode (CMD/VID).
> + * @atomic_mode_set:		DRM Call. Set a DRM mode.
> + *				This likely caches the mode, for use at enable.
>    * @enable:			DRM Call. Enable a DRM mode.
>    * @disable:			DRM Call. Disable mode.
>    * @control_vblank_irq		Register/Deregister for VBLANK IRQ
> @@ -93,6 +95,9 @@ struct dpu_encoder_phys;
>   struct dpu_encoder_phys_ops {
>   	void (*prepare_commit)(struct dpu_encoder_phys *encoder);
>   	bool (*is_master)(struct dpu_encoder_phys *encoder);
> +	void (*atomic_mode_set)(struct dpu_encoder_phys *encoder,
> +			struct drm_crtc_state *crtc_state,
> +			struct drm_connector_state *conn_state);
>   	void (*enable)(struct dpu_encoder_phys *encoder);
>   	void (*disable)(struct dpu_encoder_phys *encoder);
>   	int (*control_vblank_irq)(struct dpu_encoder_phys *enc, bool enable);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 489be1c0c704..95cd39b49668 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -142,6 +142,23 @@ static void dpu_encoder_phys_cmd_underrun_irq(void *arg)
>   	dpu_encoder_underrun_callback(phys_enc->parent, phys_enc);
>   }
>   
> +static void dpu_encoder_phys_cmd_atomic_mode_set(
> +		struct dpu_encoder_phys *phys_enc,
> +		struct drm_crtc_state *crtc_state,
> +		struct drm_connector_state *conn_state)
> +{
> +	phys_enc->irq[INTR_IDX_CTL_START] = phys_enc->hw_ctl->caps->intr_start;
> +
> +	phys_enc->irq[INTR_IDX_PINGPONG] = phys_enc->hw_pp->caps->intr_done;
> +
> +	if (phys_enc->has_intf_te)
> +		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_intf->cap->intr_tear_rd_ptr;
> +	else
> +		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_pp->caps->intr_rdptr;
> +
> +	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
> +}
> +
>   static int _dpu_encoder_phys_cmd_handle_ppdone_timeout(
>   		struct dpu_encoder_phys *phys_enc)
>   {
> @@ -280,14 +297,6 @@ static void dpu_encoder_phys_cmd_irq_enable(struct dpu_encoder_phys *phys_enc)
>   					  phys_enc->hw_pp->idx - PINGPONG_0,
>   					  phys_enc->vblank_refcount);
>   
> -	phys_enc->irq[INTR_IDX_CTL_START] = phys_enc->hw_ctl->caps->intr_start;
> -	phys_enc->irq[INTR_IDX_PINGPONG] = phys_enc->hw_pp->caps->intr_done;
> -
> -	if (phys_enc->has_intf_te)
> -		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_intf->cap->intr_tear_rd_ptr;
> -	else
> -		phys_enc->irq[INTR_IDX_RDPTR] = phys_enc->hw_pp->caps->intr_rdptr;
> -
>   	dpu_core_irq_register_callback(phys_enc->dpu_kms,
>   				       phys_enc->irq[INTR_IDX_PINGPONG],
>   				       dpu_encoder_phys_cmd_pp_tx_done_irq,
> @@ -318,10 +327,6 @@ static void dpu_encoder_phys_cmd_irq_disable(struct dpu_encoder_phys *phys_enc)
>   	dpu_core_irq_unregister_callback(phys_enc->dpu_kms, phys_enc->irq[INTR_IDX_UNDERRUN]);
>   	dpu_encoder_phys_cmd_control_vblank_irq(phys_enc, false);
>   	dpu_core_irq_unregister_callback(phys_enc->dpu_kms, phys_enc->irq[INTR_IDX_PINGPONG]);
> -
> -	phys_enc->irq[INTR_IDX_CTL_START] = 0;
> -	phys_enc->irq[INTR_IDX_PINGPONG] = 0;
> -	phys_enc->irq[INTR_IDX_RDPTR] = 0;
>   }
>   
>   static void dpu_encoder_phys_cmd_tearcheck_config(
> @@ -698,6 +703,7 @@ static void dpu_encoder_phys_cmd_init_ops(
>   		struct dpu_encoder_phys_ops *ops)
>   {
>   	ops->is_master = dpu_encoder_phys_cmd_is_master;
> +	ops->atomic_mode_set = dpu_encoder_phys_cmd_atomic_mode_set;
>   	ops->enable = dpu_encoder_phys_cmd_enable;
>   	ops->disable = dpu_encoder_phys_cmd_disable;
>   	ops->control_vblank_irq = dpu_encoder_phys_cmd_control_vblank_irq;
> @@ -736,8 +742,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_cmd_init(struct drm_device *dev,
>   
>   	dpu_encoder_phys_cmd_init_ops(&phys_enc->ops);
>   	phys_enc->intf_mode = INTF_MODE_CMD;
> -	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
> -
>   	cmd_enc->stream_sel = 0;
>   
>   	if (!phys_enc->hw_intf) {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ef69c2f408c3..636a97432d51 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -356,6 +356,16 @@ static bool dpu_encoder_phys_vid_needs_single_flush(
>   	return phys_enc->split_role != ENC_ROLE_SOLO;
>   }
>   
> +static void dpu_encoder_phys_vid_atomic_mode_set(
> +		struct dpu_encoder_phys *phys_enc,
> +		struct drm_crtc_state *crtc_state,
> +		struct drm_connector_state *conn_state)
> +{
> +	phys_enc->irq[INTR_IDX_VSYNC] = phys_enc->hw_intf->cap->intr_vsync;
> +
> +	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
> +}
> +
>   static int dpu_encoder_phys_vid_control_vblank_irq(
>   		struct dpu_encoder_phys *phys_enc,
>   		bool enable)
> @@ -699,6 +709,7 @@ static int dpu_encoder_phys_vid_get_frame_count(
>   static void dpu_encoder_phys_vid_init_ops(struct dpu_encoder_phys_ops *ops)
>   {
>   	ops->is_master = dpu_encoder_phys_vid_is_master;
> +	ops->atomic_mode_set = dpu_encoder_phys_vid_atomic_mode_set;
>   	ops->enable = dpu_encoder_phys_vid_enable;
>   	ops->disable = dpu_encoder_phys_vid_disable;
>   	ops->control_vblank_irq = dpu_encoder_phys_vid_control_vblank_irq;
> @@ -737,8 +748,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(struct drm_device *dev,
>   
>   	dpu_encoder_phys_vid_init_ops(&phys_enc->ops);
>   	phys_enc->intf_mode = INTF_MODE_VIDEO;
> -	phys_enc->irq[INTR_IDX_VSYNC] = phys_enc->hw_intf->cap->intr_vsync;
> -	phys_enc->irq[INTR_IDX_UNDERRUN] = phys_enc->hw_intf->cap->intr_underrun;
>   
>   	DPU_DEBUG_VIDENC(phys_enc, "created intf idx:%d\n", p->hw_intf->idx);
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index d3ea91c1d7d2..356dca5e5ea9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -404,6 +404,15 @@ static void dpu_encoder_phys_wb_irq_disable(struct dpu_encoder_phys *phys)
>   		dpu_core_irq_unregister_callback(phys->dpu_kms, phys->irq[INTR_IDX_WB_DONE]);
>   }
>   
> +static void dpu_encoder_phys_wb_atomic_mode_set(
> +		struct dpu_encoder_phys *phys_enc,
> +		struct drm_crtc_state *crtc_state,
> +		struct drm_connector_state *conn_state)
> +{
> +
> +	phys_enc->irq[INTR_IDX_WB_DONE] = phys_enc->hw_wb->caps->intr_wb_done;
> +}
> +
>   static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
>   		struct dpu_encoder_phys *phys_enc)
>   {
> @@ -640,6 +649,7 @@ static bool dpu_encoder_phys_wb_is_valid_for_commit(struct dpu_encoder_phys *phy
>   static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
>   {
>   	ops->is_master = dpu_encoder_phys_wb_is_master;
> +	ops->atomic_mode_set = dpu_encoder_phys_wb_atomic_mode_set;
>   	ops->enable = dpu_encoder_phys_wb_enable;
>   	ops->disable = dpu_encoder_phys_wb_disable;
>   	ops->wait_for_commit_done = dpu_encoder_phys_wb_wait_for_commit_done;
> @@ -685,7 +695,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_wb_init(struct drm_device *dev,
>   
>   	dpu_encoder_phys_wb_init_ops(&phys_enc->ops);
>   	phys_enc->intf_mode = INTF_MODE_WB_LINE;
> -	phys_enc->irq[INTR_IDX_WB_DONE] = phys_enc->hw_wb->caps->intr_wb_done;
>   
>   	atomic_set(&wb_enc->wbirq_refcount, 0);
>   
> 
> ---
> base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
> change-id: 20240514-dpu-revert-ams-9410abc1ee48
> 
> Best regards,

