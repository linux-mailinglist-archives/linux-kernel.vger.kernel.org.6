Return-Path: <linux-kernel+bounces-575519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A96A703AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3413B80C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AC25A320;
	Tue, 25 Mar 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TO/ZQV6Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714E259CA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912522; cv=none; b=WMxx5vtQwaPKX49TzpYuXA3LQ2utN6hmIIYsJN+1CRWz80fwgFEQZH5c8Ypr9SVxdOt5prnNtquUiZqlYQ7XVrZAhCzo8APg5OZzmdx1UebqdU0lZK8QR0sf/AxqxFaQyU8rjh7IBshVRYx8zrdZmjVZeNg6cdlV5Qm48uqjw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912522; c=relaxed/simple;
	bh=B2b0gdsxPlJ0aPkDZGIODju9MnfkVruUd7LTAIJth4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wbxij3dIUvXN9EuLh8rMf1jrSv/WxnJr6jmz/pE+DO+4WwhRiqIM979uQOIzR6rlJu5fZOUzIZtTyfNzG8Rrsldt0n138sB3MthH/FxlPyEluDWNyJ/RGzHt/PvUSBg5NplIgQhl1tCAHmXdEn3011i7V8zc/2OZ38aaI7mdhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TO/ZQV6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PA6PWo006292
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kp3yGWdT4AV6kkrdyjO2FJdT8nOV4kJcKTIpcQc7Pgs=; b=TO/ZQV6ZSOOIQO6/
	EtuY3avalnKyKRDIYJ5L4diQO64ei0GCwfEGLTRLRfVAUZ/dzhogZfZsGwr9LOfG
	6TsfxYd6uqNSrVZNUlLTFuv07jCOec/l3ioo50XpUDWxWIYIRkN7L3dr850X+yIj
	HNHk3Gu+WKCv8y5y1u+nxfPs/LGlnGX5jev1//5a2WihdrtiE8NxMe1Blu7DCzR1
	am8P3+vZrj7jB6YzVh40dx/1uVJIwXjjB4hDQKb5Dx190G4OrLdmfaSNIRlfSgM8
	7HORa5z9tbLv2cqroJ8L3F7PUPAVoqWOGQp3NkI4MSprpbK3KVzwcDLasnSUFOLz
	ygOT8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kten8r49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:21:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c5e92d41so945588585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912518; x=1743517318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp3yGWdT4AV6kkrdyjO2FJdT8nOV4kJcKTIpcQc7Pgs=;
        b=vs9hPhHwcq37RdM/qgsxJPJlx9SMvHDJvimqlp5uBFBv8mspIekoAfVEXtjLuVYN8N
         v17BuXZfwSlR2IdoLyGnfSC8uU2wwCUoGuSzqAEs7eV2Jtly0MV82XIH7PMxN1HBYUS3
         UQ6HC4ekZ29op+6aXZOFLo4zJE1z2rxvI9RLImQneLPkNX6DxbKQot1uKZgSHGTa+cmQ
         Jq0MtQ677VBUbYUcUY5QJKu6sLObdYQjeWu+xkm0bg+oshgwdbPIL5SUjxK7L8OjiWO+
         BtjCH5cMYnRoR6W+iiFQt+9/oopLOjRpZcmaElfb8vlvZevfMyvl8xq03BRnfK8T4C9E
         eGBg==
X-Forwarded-Encrypted: i=1; AJvYcCVzjvsKwQMLUVnlIozGzIAj2SzVIhlg4EOoFHGARi9MP2afujo0tBxfS1KTsLRFFM3ENyx03LqF2D4t8A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybrLhRRzxGDQM27kYxp3V8DwjgQas/LkCeZ65uUn+bbv6d3fLz
	8WshAhydK+tbbPGgLkBrTWNpRAOz7X/gjdfVRohF7sF1YpbtYAqQNeV72eHKYPFPHx8DzOasYp1
	fRdkWgA7gAFIYT+Jr4P2IBlhkXgAoUKRIyMcaISGqwJCdYMd8TSLHXLDad9hkrqU=
X-Gm-Gg: ASbGnctkpr+48n7fc5WyjlwIbRb9Vf6QlCGDnMxUvUxbL38AkOuM/9Vgsmt1+RGNYgS
	dSqtmAemPs7kYA4yh2wG+MUoBSEEZjeql64ZbCEgHnkif3hxMgUE40ERA8QNzxk45tL/ctlPWvl
	jcfmMGiqxxINn/22SPRH0gDgNasRksKYDbVAGkUl5y4+3YqlS0+znHycWSIqQm0Ldcl5+e57tdx
	PMZ+fVkCUWF2wi2uQDePJ3xmfeCFzLLxriMfnYZneWfYdUSe4+xiwyIAZ9MBj+eYvfHxEQMCuFo
	QY8PmFIKlsic0Y7zIDhEY9RHJsP1EI+MQb6c8zmv1gD4VH1eXl3d0Y/xwihMTcQJ4R8=
X-Received: by 2002:a05:620a:4082:b0:7c5:4194:bbcc with SMTP id af79cd13be357-7c5ba1a5851mr2078811585a.29.1742912518286;
        Tue, 25 Mar 2025 07:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3gf2K5kIjZtYjJH4qhQtLNFCQgnGxwMyKEgZu4Q/N9eWpJ5iD6eXdGIpzuGP7y89fDMGrg==
X-Received: by 2002:a05:620a:4082:b0:7c5:4194:bbcc with SMTP id af79cd13be357-7c5ba1a5851mr2078805785a.29.1742912517757;
        Tue, 25 Mar 2025 07:21:57 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65083e4sm1508348e87.171.2025.03.25.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:21:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC PATCH RESEND v4 0/6] drm/display: dp: add new DPCD access functions
Date: Tue, 25 Mar 2025 16:21:55 +0200
Message-ID: <174291251084.2000243.209850835590674876.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
References: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e2bc07 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=DZoDOQWOqP-ft6bgs5oA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: WiMioqrG7C5lDq25esUu0wz2Ofu-fVTC
X-Proofpoint-ORIG-GUID: WiMioqrG7C5lDq25esUu0wz2Ofu-fVTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250100

On Mon, 24 Mar 2025 13:51:18 +0200, Dmitry Baryshkov wrote:
> Existing DPCD access functions return an error code or the number of
> bytes being read / write in case of partial access. However a lot of
> drivers either (incorrectly) ignore partial access or mishandle error
> codes. In other cases this results in a boilerplate code which compares
> returned value with the size.
> 
> As suggested by Jani implement new set of DPCD access helpers, which
> ignore partial access, always return 0 or an error code. Implement
> new helpers using existing functions to ensure backwards compatibility
> and to assess necessity to handle incomplete reads on a global scale.
> Currently only one possible place has been identified, dp-aux-dev, which
> needs to handle possible holes in DPCD.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/6] drm/display: dp: implement new access helpers
      commit: d8343e115658fb35115e0720f4761ffa0147329a
[2/6] drm/display: dp: change drm_dp_dpcd_read_link_status() return value
      commit: fcbb93f1e48a150159534a1e6ec19e6fdf9196df
[3/6] drm/display: dp: use new DCPD access helpers
      commit: af67978ee37e543e62d6d3f7eba58f8f259423a7
[4/6] drm/display: dp-cec: use new DCPD access helpers
      commit: 97f37939881327e118d6252289973c186377a075
[5/6] drm/display: dp-mst-topology: use new DCPD access helpers
      commit: 2554da0de3e8312c7149d03d702ddc6c1ff5e3de
[6/6] drm/display: dp-tunnel: use new DCPD access helpers
      commit: 95c4ea2e0329b370a53a041a19227f8da3f47481

Best regards,
-- 
With best wishes
Dmitry


