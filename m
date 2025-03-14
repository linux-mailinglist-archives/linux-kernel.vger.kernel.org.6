Return-Path: <linux-kernel+bounces-561262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D321A60F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629EA3BC616
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B581FCFF4;
	Fri, 14 Mar 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5vR35vU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF371FA272
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949770; cv=none; b=EiPF8ATinVZj0GXpDj4iCPVHxV6s9CAg1SAKAj59yJwO4c5ZBVFWo/DTmbyh7WfaqRAhy0siE6o4DXJANt/cB4LmmOczOs/+pTgsUcfps4Lkx4X9nBfW+0GzpbaPd3uGVItAA7ZcVpfWmGbUUTFfWtxScmTKVZPAtWuRuSpxbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949770; c=relaxed/simple;
	bh=geaY25edlEppjlbwH72/00H9n6ZbFT9PqoHcrE33y+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGjp8bpg5WbXcCqF9WguYXFJ+bF5bhTTqnEJLevSEo44qMvkpj/NSu/uXXAKirmmXHzU1wsOscS15B51FPQZiXbXKB77UlR3pQaF/qnNkHCAG6CpetK6nLzavlUyyQNR06VLpnh6SZyMl0HTqmSwNgc9XfcMfVez8B0RZOPpcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5vR35vU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DN5J0h009854
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FzjaEivNGyD1ku745kyGL7WS
	lER8CajMDsn14aZcwOY=; b=F5vR35vULAZmhebVeiVNNRz0pUtqRbCsZX/yzYX3
	BlMnE6lKJtlwsxLo+sB0p20Dn2jlL2sNbqhpXsOOMXMkN6xV9WDd3BkX73UaXlrY
	nxA1+lWKG1gsCth/Egvp8f9cfMhe2dMZP1bDq8rXTMUTk2mJ7ictyztSbmdfIfkD
	sKtFMrFpP4fbscSsUjBCQ5p4PBZ82sFnALW3YqeSGbddBS1Qya+5JsPexsVaRGaW
	1JtQmtR3BnkLE0mcShj06Fcz0qx+KWPypX31ENyDAkGiW12BKABWny4UIYiX+e4j
	o1t6RtByH7PM2giQ6XA9ttAEgRSOX7Mp0GaUPH938+tFnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2rgxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:56:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4767816a48cso55594801cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949765; x=1742554565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzjaEivNGyD1ku745kyGL7WSlER8CajMDsn14aZcwOY=;
        b=GOFnVkRKyXifAFBX4r4EEeEj1JplckSXTA/gy8Cv81c1FUZoXF6SFsI46Vp2IRw5V2
         eXPT3NE3ueyqZJkhVfg3UmeLokSo+BUEkSys3qp6MVqV08TfdxBkqbDVdvRZXshGWMXU
         u9yedBN2baqj46Te2u0jTG5y5HNEuF2tK+qnBXL+BfpEd/5BtVm4wIaSIkJoj86GwCqT
         Jnt5xDY+pulMSIPVWR1ZpJnegwA6qwvTa6uOrG7H2DyHfCAJEn0L991uz6TsJTOw+ZJj
         BoIp6KcjyfSA8OdEIV4epNjkeVm6lkz72wVAYB9ne5S10nHNRYA8mnDcNWcPXBORYpAO
         PRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1MSPa4vEt/t3t2xf6MSQqFi9uu8faTOyXHzYBpEoXKPO3KuWIrX++IIGKiBfZHg9V47xceFgSyytg/QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk8pBXpvMty47qZsmOzdg5pcOKMl3u9k5siamfXWJzo8lEwbz
	cpnLpBAwmI3Y/GiRzLpdfIOkFxtFrOthCzRpQNJm+C6QDfL+puI8UoPs7dKgS1PCZC9atbV2onq
	B0LLBuUi8cD/62toISw3ddcLynvOyzvfMpJB3Uyr2HaQHSCCMkAfrl4OhUpeRMI4=
X-Gm-Gg: ASbGncsYdQNouAKRHGb0IfZsSAr1kqHn2bLKTATpzgGeRPQuAOG7iR4Rr8jWrd6oZAD
	68IO2bBJinPvzqmTs2WMnFjU5KLAyae84AJWhYtmUMRwg4NRW1Dkm8BZ22tRpbI4E4cCqg7SgtJ
	AmGIFrsGwxQw77Mi78UWmtRmfPEsoiSxNlxI1G1wOouq1+gK038UcW/Y8aY3jvN9Q/NnYUJOz3w
	f/6XdiJ1xeiSwLp1InHKgD/PeJ0Ch3fpIH9coa6Se4lhm4OqylRESvntOkZ9ASBOKK0Wyyid+YR
	LB02nhz/N7tbLhq7xgOI6PS56MAt0Feydg+0Efh/Ht8FkrhXVzVwXRvngmP9GNNuXoLGjCGwIF+
	Flxs=
X-Received: by 2002:a05:622a:180d:b0:476:6215:eaf7 with SMTP id d75a77b69052e-476c813f762mr29693661cf.19.1741949765145;
        Fri, 14 Mar 2025 03:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+yV16Zmgi1A70mwBZ9PcdiO6z5Tv5gkisCoi1r0ajg/e3I2j7Vl0jSm2ed6kcC/PKpZmF6Q==
X-Received: by 2002:a05:622a:180d:b0:476:6215:eaf7 with SMTP id d75a77b69052e-476c813f762mr29693331cf.19.1741949764770;
        Fri, 14 Mar 2025 03:56:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8944sm495547e87.14.2025.03.14.03.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:56:03 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:56:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH v2 09/10] drm/bridge: anx7625: update bridge_ops and sink
 detect logic
Message-ID: <odaup4s2j7uzjmucdsio2y5umfwwtmn5l6rotu3xwjatgwsahn@sgfpdv56mny4>
References: <20250311122445.3597100-1-quic_amakhija@quicinc.com>
 <20250311122445.3597100-10-quic_amakhija@quicinc.com>
 <6gdd6p3ca6w2gb2nbl6ydw4j7y2j5eflelbwntpc6ljztjuwzt@dqwafrtod5m5>
 <da9f80e6-bb4e-4568-aa2c-d70383b12e3a@quicinc.com>
 <CALT56yP+UDF1YeotceqOevr_NTeGjDVw92NwtPDgRK6GvvkyHw@mail.gmail.com>
 <2c10d5d2-a0bd-440d-b385-28ce3fea7d7c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c10d5d2-a0bd-440d-b385-28ce3fea7d7c@quicinc.com>
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d40b45 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=JjDlP3kZNfNiCSxIk8gA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZcPwC7iOsGJ_GXojbfIjWNxa1ab2UpMt
X-Proofpoint-ORIG-GUID: ZcPwC7iOsGJ_GXojbfIjWNxa1ab2UpMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140085

On Thu, Mar 13, 2025 at 12:14:04PM +0530, Ayushi Makhija wrote:
> 
> 
> On 3/12/2025 4:33 PM, Dmitry Baryshkov wrote:
> > On Wed, 12 Mar 2025 at 11:47, Ayushi Makhija <quic_amakhija@quicinc.com> wrote:
> >>
> >> On 3/11/2025 9:11 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Mar 11, 2025 at 05:54:44PM +0530, Ayushi Makhija wrote:
> >>>> The anx7625_link_bridge() checks if a device is not a panel
> >>>> bridge and add DRM_BRIDGE_OP_HPD and DRM_BRIDGE_OP_DETECT to
> >>>> the bridge operations. However, on port 1 of the anx7625
> >>>> bridge, any device added is always treated as a panel
> >>>> bridge, preventing connector_detect function from being
> >>>> called. To resolve this, instead of just checking if it is a
> >>>> panel bridge, verify the type of panel bridge
> >>>> whether it is a DisplayPort or eDP panel. If the panel
> >>>> bridge is not of the eDP type, add DRM_BRIDGE_OP_HPD and
> >>>> DRM_BRIDGE_OP_DETECT to the bridge operations.
> >>>
> >>> Are/were there any devices using anx7625, eDP panel _and_ not using the
> >>> AUX bus? It would be better to use the precence of the 'aux' node to
> >>> determine whether it is an eDP or a DP configuration.
> >>>
> >>>>
> >>>> In the anx7625_sink_detect(), the device is checked to see
> >>>> if it is a panel bridge, and it always sends a "connected"
> >>>> status to the connector. When adding the DP port on port 1 of the
> >>>> anx7625, it incorrectly treats it as a panel bridge and sends an
> >>>> always "connected" status. Instead of checking the status on the
> >>>> panel bridge, it's better to check the hpd_status for connectors
> >>>> like DisplayPort. This way, it verifies the hpd_status variable
> >>>> before sending the status to the connector.
> >>>>
> >>>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >>>> ---
> >>>>  drivers/gpu/drm/bridge/analogix/anx7625.c | 10 ++++------
> >>>>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>>> index 764da1c1dc11..ad99ad19653f 100644
> >>>> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>>> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>>> @@ -1814,9 +1814,6 @@ static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
> >>>>
> >>>>      DRM_DEV_DEBUG_DRIVER(dev, "sink detect\n");
> >>>>
> >>>> -    if (ctx->pdata.panel_bridge)
> >>>> -            return connector_status_connected;
> >>>> -
> >>>>      return ctx->hpd_status ? connector_status_connected :
> >>>>                                   connector_status_disconnected;
> >>>>  }
> >>>> @@ -2608,9 +2605,10 @@ static int anx7625_link_bridge(struct drm_dp_aux *aux)
> >>>>      platform->bridge.of_node = dev->of_node;
> >>>>      if (!anx7625_of_panel_on_aux_bus(dev))
> >>>>              platform->bridge.ops |= DRM_BRIDGE_OP_EDID;
> >>>> -    if (!platform->pdata.panel_bridge)
> >>>> -            platform->bridge.ops |= DRM_BRIDGE_OP_HPD |
> >>>> -                                    DRM_BRIDGE_OP_DETECT;
> >>>> +    if (!platform->pdata.panel_bridge ||
> >>>> +        platform->pdata.panel_bridge->type != DRM_MODE_CONNECTOR_eDP) {
> >>>> +            platform->bridge.ops |= DRM_BRIDGE_OP_HPD | DRM_BRIDGE_OP_DETECT;
> >>>> +    }
> >>
> >> Hi Dmitry,
> >>
> >> Thanks, for the review.
> >>
> >> Yes, it is better to check the presence of the 'aux' node for eDP or DP configuration.
> >> Will change it in next patch.
> >>
> >> -       if (!platform->pdata.panel_bridge)
> >> -               platform->bridge.ops |= DRM_BRIDGE_OP_HPD |
> >> -                                       DRM_BRIDGE_OP_DETECT;
> >> +       if (!platform->pdata.panel_bridge || !anx7625_of_panel_on_aux_bus(dev)) {
> > 
> > This is incorrect, if I'm not mistaken, please doublecheck it. I'd
> > suggest following msm_dp_display_get_connector_type() (feel free to
> > extract that to a helper function).
> > 
> 
> Hi Dmirty,
> 
> Thanks, for the review.
> 
> If we see definition of anx7625_of_panel_on_aux_bus() it is doing the same
> thing as msm_dp_display_get_connector_type().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Please excuse my confusion.

> 
> static bool anx7625_of_panel_on_aux_bus(struct device *dev)
> {
>         struct device_node *bus, *panel;
> 
>         bus = of_get_child_by_name(dev->of_node, "aux-bus");
> 
>         // if aux-bus is not there it will return the false.
>         if (!bus)
>                 return false;
> 
>         panel = of_get_child_by_name(bus, "panel");
>         of_node_put(bus);
> 
>         // if panel is not there it will return the false.
>         if (!panel)
>                 return false;
>         of_node_put(panel);
> 
>         return true;
> }
> 
> Above function will return true in case of eDP and false in case of DP.
> So we can use anx7625_of_panel_on_aux_bus() to check whether it
> is DP or eDP configuration based on aux.
> 
> I don't think so we need extract msm_dp_display_get_connector_type() to check the eDP or DP configuration based on aux.
> Let me know, if I am missing anything.
> 
> Thanks,
> Ayushi
> 

-- 
With best wishes
Dmitry

