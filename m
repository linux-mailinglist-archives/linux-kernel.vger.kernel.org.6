Return-Path: <linux-kernel+bounces-566589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06048A67A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01F87A8DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE020FA85;
	Tue, 18 Mar 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7vyPiqP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA020F069
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317225; cv=none; b=mzopqwQmPEOtXTTBkAeGyDMHpndYNyFPBJbyh8+PgSDa5C9NGrGiqqBc8mBgC5L8hOiLcalF80ROUwWTe+lnlCoCijfyYhAQIyfKTQmLVL2FXA3ejCFygqKEoQXs3YdDUT6+4XM6Cxri/rcfWOGIXuU/R6pTqlqUIziiwYTtWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317225; c=relaxed/simple;
	bh=TrT4pcT0Nk45/FMqtOQP+25VVWNlmXSxKH+tPfIqAF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvxSqmtPwx+gZ1EskcKvTAAyr2O2iPjSUVn2wmHWIXKpUCeSjARgehlgeAJiZ/VY2c6UyFzKlLNYl4CEwXWCfnzSm25lLgqOBOZsV+2dD7iiPCqc4uNdXKvIM7KgkiV3D0L+DG/QiFfMU4X7Exl4alZqe50G41rBliPLQ5TaJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7vyPiqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAClLL000505
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y2+oGra/6n3RT/E0bgcmLmlGUUYmT3cDQKHxKgoP1X4=; b=n7vyPiqPP60GKUYv
	KyfgoZ2dbZ8ANP+gZK1C5EO2s4O3Yh1c902e3ABut/HPE7R29LgTax5h9SKuP8nj
	WHCDUFa3HlT4bX1Ok3fkcUZitncfT0p484zTSnXk07mp3l1Mxqf5K97bOJbaC6Dm
	5nRzlqwt81lP8NW6ygPfLFn4p9+nrTMOCX1kCf+uj3VihIyuIu2tQlv7droXxU1O
	If3hNaaOqB5KcDzloZmRTI5+N0JHsplNzq7RhCpJ4mbkP0BKWjYR8XGBuASNvZLn
	fpBtMephPn0qMURAvldMQ6I5ll8xGatjVzlcAPscTmJAFnMxCmlaVKfg3ECGJeXb
	WJ6vTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sy0y1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:00:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso8550019a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317216; x=1742922016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2+oGra/6n3RT/E0bgcmLmlGUUYmT3cDQKHxKgoP1X4=;
        b=qWI5jno0Uos5aHYQt/T1SO/gie2MWYseLtvpoJ2qn9TzOzQUO6LsXrDm1offdNVJS4
         i1ggIt+WYQ85Urj8d6Xl5taAaduBRi0/jyjxHQ30CTGZV/00D4YAJ4w91S7OkphVTAUC
         oHpUqJzpJXrjoFtpwde4SaL9VPK5abYm60WB4YDzKUKXps+mgJS3PYFJxipACPIKhYXX
         M7+CKaPCKiQuebFHdxF3ZKq/4v9wNs/NXj/4xCrLx/ZgFysSmpRHmLWer/IK19+RLa9M
         ms2GGg2r4V5Z262pGtZCbMIJ1w/DJlEEedWYxymwsep0BBlDBE9zyRE+Xzd3Dd6pDOgi
         Ad8g==
X-Forwarded-Encrypted: i=1; AJvYcCVj/5ruEWE7yIGYhFcn5Njn3hsOQwsznm369han/6bMFC+2YWsNrqtECmqNn6hGTzgn6T7aM0q5WDZHdbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmad4fJH63Ixg7BYns9L4/QNVlkNNENtqYbqFPKq+LwQafCcg
	zwN2X4sbMb4RW/Zyz5QY0RvKfDB3tSGCIQOqSHbwRn/HSIOQCremAxx+l4g7nFkPpGudUNr3K6m
	OxuzB36TrqhECRU0T03NsH3htH/D0wp5P1F63capg4/22363Q04RfQGv0UHUB78x7WY7quyvHhX
	hES0XYHrnG13VkOF7LxGNGjzA/z+j3W0NzXEyWmg==
X-Gm-Gg: ASbGncsoPgSv19Lqkgh+VQAQvUaQY+wQaQM4kyQLHaXz8wUYA8vIu1saBsG4+gbxgmx
	4Z0HV02szqI0y9G9A1KHcRb6Adw3+m7LesOl9g7++FA4VzmHwHDWAt+gmrCdWbHzKuZjO43tD41
	mN4LEufmoRRJAHCiuPkj32Pxd8KQE=
X-Received: by 2002:a17:90b:4c:b0:2ff:64c3:3bd4 with SMTP id 98e67ed59e1d1-301a5bff158mr4199684a91.31.1742317214682;
        Tue, 18 Mar 2025 10:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7orlCcOTzKv9495d2zLbaIYhSzdkmmHIEtE7pvmf6UIGCyN7EII36oOZjnWb5Dtj/qMO2TMbq6kymi9NSXHQ=
X-Received: by 2002:a17:90b:4c:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-301a5bff158mr4199631a91.31.1742317214205; Tue, 18 Mar 2025
 10:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-b4-panel-ls043t1le01-v1-1-ee38371b0ba0@redhat.com>
 <zs4tt57ur6hbesipab3kuiost4gokfu6tmfsicfwtdwri2wwli@fylnnpu3xoen> <CAN9Xe3SkXCK3FJx6c=EDigBxdXeGh9NYEf-wcR0_jFwraFGeDg@mail.gmail.com>
In-Reply-To: <CAN9Xe3SkXCK3FJx6c=EDigBxdXeGh9NYEf-wcR0_jFwraFGeDg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 19:00:02 +0200
X-Gm-Features: AQ5f1JozRfWE2AvU7W4G4CRnLtgMIlzRwdXAGIgnHgomtxzwNu4xMver5VaZXj4
Message-ID: <CAO9ioeXyJKGxXXanFHraspvquwWmMEKUdw_eN=wjV81VeMo43w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel/sharp-ls043t1le01: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tejas Vipin <tejasvipin76@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 6RVJjpr558mrQfSdFS7sA31cdswcyyO-
X-Proofpoint-ORIG-GUID: 6RVJjpr558mrQfSdFS7sA31cdswcyyO-
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d9a6a1 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=68VyVwYxJFAdjPYCXN8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180125

On Tue, 18 Mar 2025 at 18:55, Anusha Srivatsa <asrivats@redhat.com> wrote:
>
> On Sun, Mar 16, 2025 at 7:32=E2=80=AFPM Dmitry Baryshkov <dmitry.baryshko=
v@oss.qualcomm.com> wrote:
>>
>> On Sun, Mar 16, 2025 at 02:58:22PM -0400, Anusha Srivatsa wrote:

>> > ---
>> >  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 36 ++++++++++------=
---------
>> >  1 file changed, 14 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers=
/gpu/drm/panel/panel-sharp-ls043t1le01.c
>> > index 729cbb0d8403ff7c0c4b9d21774909cc298904a2..9803eaf18e95d70742ece8=
8e82932751476fdda8 100644
>> > --- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
>> > +++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
>> > @@ -36,15 +36,14 @@ static inline struct sharp_nt_panel *to_sharp_nt_p=
anel(struct drm_panel *panel)
>> >  static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
>> >  {
>> >       struct mipi_dsi_device *dsi =3D sharp_nt->dsi;
>> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>> >       int ret;
>> >
>> >       dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>> >
>> > -     ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>> > -     if (ret < 0)
>> > -             return ret;
>> > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> >
>> > -     msleep(120);
>> > +     mipi_dsi_msleep(&dsi_ctx, 120);
>> >
>> >       /* Novatek two-lane operation */
>> >       ret =3D mipi_dsi_dcs_write(dsi, 0xae, (u8[]){ 0x03 }, 1);
>>
>> Anusha. Please. Start reviewing your patches before you send them. This
>> is a MIPI DSI call. And it wasn't switched to _multi / context. You
>> should have cought this. I don't know why you didn't. Please review and
>> check your code before sending it upstream.
>
>
> Actually , mipi_dsi_dcs_write() doesnt have a _multi() variant. There are=
 _multi() variants for other writes: mipi_dsi_dcs_write_buffer() has mipi_d=
si_dcs_write_buffer_multi(), mipi_dsi_generic_write() has mipi_dsi_generic_=
write_multi() but not the one used above.

That doesn't mean that it can be left unconverted. You can use
mipi_dsi_dcs_write_buffer_multi().

P.S. Please wrap your replies ont some useful boundary (72-75 chars is
the recommended value).

--=20
With best wishes
Dmitry

