Return-Path: <linux-kernel+bounces-260677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D093ACE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC641C20E86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF76BFD2;
	Wed, 24 Jul 2024 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CNtYhtcD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181C175A6;
	Wed, 24 Jul 2024 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804458; cv=none; b=poKbfI7A+1YlIF29DMceEVu5xXiZZ61eNN+ByNJnsThjYEWXydXbwpENGsO4WN3OZM7lS7rNO+kr406LU5qhh5BiESTGbFS4UkvBNAGwgLE8ZGmC4GuYXVLLZ+GuGLtsqxMpZELZuBINtFH6YKRynvjfBr47Y/qsU6Kg9pXSGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804458; c=relaxed/simple;
	bh=9snLTUyGxysVTqQN72bJNsi5r1biMhQXQiU3Sz+ML3g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsMPDKkxr64KYAJGjsGRz/1YDZ8arfS8gLjLBBkyvVlXFw+OC+PbP/1B8xuikLUB/Hnk4LyGGoXNv5Os23nvVx8XHwRpGTUqddh/o3Z13T7Q1xa2c3Yi2tml9DwX0C37k2I9NbOoC4YU1cflXPLz+uqoXcgoJCGFr0ocK0KUDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CNtYhtcD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NG3HGp021030;
	Wed, 24 Jul 2024 07:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qeNhcoazaykd4Ao+HhCVndn1
	P21ht1KN/EDHqpojYrU=; b=CNtYhtcDZMTYpg7dfJP4iSQduN9sgE1M+vuvyajb
	mrb0nvlsqdZZSceR8ea0UdOCW3E0K6t/eRDpF11RPxxa3Lyer3FfYA4QslRshUL2
	9BTNYrmpNN/TYJ9L84OgJ+YGZ8cYi6MFevxFkNdMk06f2WJEGE/sMc/5XFDoHyTn
	pfEOGLtBn1g1rC4K6sTgIEeRnOCh8C3cKOQAxJLn+numLyQI9b3POAM+8zZrvyoz
	ULdMjynHdI8H2kzXzp8UMIDOhR/nQpA2JI4Msag5rMRLP0V9CjX/EM8S9wlp0Sbg
	aXWJzh2AP3GccnD2BWG3gqGccytOW80wSC6nX2DJ1ruJIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtqv6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 07:00:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O70DsE010287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 07:00:13 GMT
Received: from jiegan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Jul 2024 00:00:08 -0700
Date: Wed, 24 Jul 2024 15:00:04 +0800
From: JieGan <quic_jiegan@quicinc.com>
To: Mike Leach <mike.leach@linaro.org>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark
	<james.clark@arm.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan
	<leo.yan@linaro.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai
	<quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] Coresight: Add trace_id function to collect trace
 ID
Message-ID: <ZqCmdKmhkGOzFr0x@jiegan-gv.ap.qualcomm.com>
References: <20240705090049.1656986-1-quic_jiegan@quicinc.com>
 <20240705090049.1656986-2-quic_jiegan@quicinc.com>
 <CAJ9a7VgpKiRFOJc3ns=6zRHyv-UpXciZFMJgmSQPOm56U6BBgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgpKiRFOJc3ns=6zRHyv-UpXciZFMJgmSQPOm56U6BBgA@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RacQJ5hrL3ZtE6Ek99917jgx4emDgbqL
X-Proofpoint-ORIG-GUID: RacQJ5hrL3ZtE6Ek99917jgx4emDgbqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_04,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240051

On Tue, Jul 23, 2024 at 11:30:02AM +0100, Mike Leach wrote:
> Hi,
> 
> This patch has a number of issues:-
> 
> 1) The new dynamic trace ID patchset to use per sink ID maps makes
> this set unusable. perf supplies a trace ID map for each sink used.
>  - see https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/JEK7M7HRS57XK4B7CVTVFSHFAFBX4SFG/
> 
> 2) See etm4_enable_perf() - in the perf context a locked version of
> the read trace ID cannot be used - therefore any path that calls
> etm4_read_alloc_trace_id() (or equivalent for other sources) in perf
> mode may result in lockdep issues.
> 
> 3) on enable: given a cpu  number, the trace ID can be read from the
> id maps rather than needing a new function in ops
> 
> 4) on disable: trace id can be read directly from the source driver
> data - again removing need for a new trace_id function in ops.
> 
> Regards
> 
> Mike
Hi Mike

Thanks for comment. I will check James's patchset.
If possible, I will use the per sink ID maps to retrieving the trace ID.

Thanks,
Jie

> 
> 
> On Fri, 5 Jul 2024 at 10:01, Jie Gan <quic_jiegan@quicinc.com> wrote:
> >
> > Add 'trace_id' function pointer in ops. It's responsible for collect the
> > trace ID of the device.
> >
> > Add 'struct cs_sink_data' to store the data used by coresight_enable_path/
> > coresight_disable_path. The structure will be transmitted to the helper and
> > sink device.
> >
> > Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-core.c  | 53 +++++++++++++++----
> >  drivers/hwtracing/coresight/coresight-etb10.c |  3 +-
> >  .../hwtracing/coresight/coresight-etm-perf.c  | 34 ++++++++++--
> >  .../coresight/coresight-etm3x-core.c          | 14 +++++
> >  .../coresight/coresight-etm4x-core.c          | 13 +++++
> >  drivers/hwtracing/coresight/coresight-priv.h  | 12 ++++-
> >  drivers/hwtracing/coresight/coresight-stm.c   | 13 +++++
> >  drivers/hwtracing/coresight/coresight-sysfs.c | 24 +++++++--
> >  .../hwtracing/coresight/coresight-tmc-etf.c   |  3 +-
> >  .../hwtracing/coresight/coresight-tmc-etr.c   |  6 ++-
> >  drivers/hwtracing/coresight/coresight-tpda.c  | 13 +++++
> >  drivers/hwtracing/coresight/coresight-trbe.c  |  4 +-
> >  drivers/hwtracing/coresight/ultrasoc-smb.c    |  3 +-
> >  include/linux/coresight.h                     |  4 ++
> >  14 files changed, 174 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 9fc6f6b863e0..f414e66f4cda 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -297,12 +297,12 @@ static int coresight_enable_helper(struct coresight_device *csdev,
> >         return helper_ops(csdev)->enable(csdev, mode, data);
> >  }
> >
> > -static void coresight_disable_helper(struct coresight_device *csdev)
> > +static void coresight_disable_helper(struct coresight_device *csdev, void *data)
> >  {
> > -       helper_ops(csdev)->disable(csdev, NULL);
> > +       helper_ops(csdev)->disable(csdev, data);
> >  }
> >
> > -static void coresight_disable_helpers(struct coresight_device *csdev)
> > +static void coresight_disable_helpers(struct coresight_device *csdev, void *data)
> >  {
> >         int i;
> >         struct coresight_device *helper;
> > @@ -310,7 +310,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
> >         for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
> >                 helper = csdev->pdata->out_conns[i]->dest_dev;
> >                 if (helper && coresight_is_helper(helper))
> > -                       coresight_disable_helper(helper);
> > +                       coresight_disable_helper(helper, data);
> >         }
> >  }
> >
> > @@ -327,7 +327,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
> >  void coresight_disable_source(struct coresight_device *csdev, void *data)
> >  {
> >         source_ops(csdev)->disable(csdev, data);
> > -       coresight_disable_helpers(csdev);
> > +       coresight_disable_helpers(csdev, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_disable_source);
> >
> > @@ -337,7 +337,8 @@ EXPORT_SYMBOL_GPL(coresight_disable_source);
> >   * disabled.
> >   */
> >  static void coresight_disable_path_from(struct list_head *path,
> > -                                       struct coresight_node *nd)
> > +                                       struct coresight_node *nd,
> > +                                       void *sink_data)
> >  {
> >         u32 type;
> >         struct coresight_device *csdev, *parent, *child;
> > @@ -382,13 +383,13 @@ static void coresight_disable_path_from(struct list_head *path,
> >                 }
> >
> >                 /* Disable all helpers adjacent along the path last */
> > -               coresight_disable_helpers(csdev);
> > +               coresight_disable_helpers(csdev, sink_data);
> >         }
> >  }
> >
> > -void coresight_disable_path(struct list_head *path)
> > +void coresight_disable_path(struct list_head *path, void *sink_data)
> >  {
> > -       coresight_disable_path_from(path, NULL);
> > +       coresight_disable_path_from(path, NULL, sink_data);
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_disable_path);
> >
> > @@ -468,10 +469,42 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
> >  out:
> >         return ret;
> >  err:
> > -       coresight_disable_path_from(path, nd);
> > +       coresight_disable_path_from(path, nd, sink_data);
> >         goto out;
> >  }
> >
> > +int coresight_read_traceid(struct list_head *path)
> > +{
> > +       int trace_id, type;
> > +       struct coresight_device *csdev;
> > +       struct coresight_node *nd;
> > +
> > +       list_for_each_entry(nd, path, link) {
> > +               csdev = nd->csdev;
> > +               type = csdev->type;
> > +
> > +               switch(type) {
> > +                       case CORESIGHT_DEV_TYPE_SOURCE:
> > +                               if (source_ops(csdev)->trace_id != NULL) {
> > +                                       trace_id = source_ops(csdev)->trace_id(csdev);
> > +                                       if (trace_id > 0)
> > +                                               return trace_id;
> > +                               }
> > +                               break;
> > +                       case CORESIGHT_DEV_TYPE_LINK:
> > +                               if (link_ops(csdev)->trace_id != NULL) {
> > +                                       trace_id = link_ops(csdev)->trace_id(csdev);
> > +                                       if (trace_id > 0)
> > +                                               return trace_id;
> > +                               }
> > +                               break;
> > +                       default:
> > +                               break;
> > +               }
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> >  struct coresight_device *coresight_get_sink(struct list_head *path)
> >  {
> >         struct coresight_device *csdev;
> > diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> > index 7edd3f1d0d46..05e620529c14 100644
> > --- a/drivers/hwtracing/coresight/coresight-etb10.c
> > +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> > @@ -173,7 +173,8 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
> >         pid_t pid;
> >         unsigned long flags;
> >         struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct cs_buffers *buf = etm_perf_sink_config(handle);
> >
> >         spin_lock_irqsave(&drvdata->spinlock, flags);
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index c0c60e6a1703..8b155765b959 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -452,6 +452,7 @@ static void etm_event_start(struct perf_event *event, int flags)
> >         struct perf_output_handle *handle = &ctxt->handle;
> >         struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> >         struct list_head *path;
> > +       struct cs_sink_data *sink_data = NULL;
> >         u64 hw_id;
> >
> >         if (!csdev)
> > @@ -490,9 +491,18 @@ static void etm_event_start(struct perf_event *event, int flags)
> >         if (WARN_ON_ONCE(!sink))
> >                 goto fail_end_stop;
> >
> > +       sink_data = kzalloc(sizeof(*sink_data), GFP_KERNEL);
> > +       if (!sink_data)
> > +               goto fail_end_stop;
> > +
> > +       sink_data->sink = sink;
> > +       sink_data->traceid = coresight_read_traceid(path);
> > +       sink_data->handle = handle;
> >         /* Nothing will happen without a path */
> > -       if (coresight_enable_path(path, CS_MODE_PERF, handle))
> > +       if (coresight_enable_path(path, CS_MODE_PERF, sink_data)) {
> > +               kfree(sink_data);
> >                 goto fail_end_stop;
> > +       }
> >
> >         /* Finally enable the tracer */
> >         if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> > @@ -511,6 +521,7 @@ static void etm_event_start(struct perf_event *event, int flags)
> >                 perf_report_aux_output_id(event, hw_id);
> >         }
> >
> > +       kfree(sink_data);
> >  out:
> >         /* Tell the perf core the event is alive */
> >         event->hw.state = 0;
> > @@ -519,7 +530,8 @@ static void etm_event_start(struct perf_event *event, int flags)
> >         return;
> >
> >  fail_disable_path:
> > -       coresight_disable_path(path);
> > +       coresight_disable_path(path, sink_data);
> > +       kfree(sink_data);
> >  fail_end_stop:
> >         /*
> >          * Check if the handle is still associated with the event,
> > @@ -544,6 +556,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >         struct perf_output_handle *handle = &ctxt->handle;
> >         struct etm_event_data *event_data;
> >         struct list_head *path;
> > +       struct cs_sink_data *sink_data = NULL;
> >
> >         /*
> >          * If we still have access to the event_data via handle,
> > @@ -588,6 +601,10 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >         if (!sink)
> >                 return;
> >
> > +       sink_data = kzalloc(sizeof(*sink_data), GFP_KERNEL);
> > +       if (!sink_data)
> > +               return;
> > +
> >         /* stop tracer */
> >         coresight_disable_source(csdev, event);
> >
> > @@ -601,12 +618,16 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >          * have to do anything here.
> >          */
> >         if (handle->event && (mode & PERF_EF_UPDATE)) {
> > -               if (WARN_ON_ONCE(handle->event != event))
> > +               if (WARN_ON_ONCE(handle->event != event)) {
> > +                       kfree(sink_data);
> >                         return;
> > +               }
> >
> >                 /* update trace information */
> > -               if (!sink_ops(sink)->update_buffer)
> > +               if (!sink_ops(sink)->update_buffer) {
> > +                       kfree(sink_data);
> >                         return;
> > +               }
> >
> >                 size = sink_ops(sink)->update_buffer(sink, handle,
> >                                               event_data->snk_config);
> > @@ -627,8 +648,11 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >                         WARN_ON(size);
> >         }
> >
> > +       sink_data->sink = sink;
> > +       sink_data->traceid = coresight_read_traceid(path);
> >         /* Disabling the path make its elements available to other sessions */
> > -       coresight_disable_path(path);
> > +       coresight_disable_path(path, sink_data);
> > +       kfree(sink_data);
> >  }
> >
> >  static int etm_event_add(struct perf_event *event, int mode)
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index 8b362605d242..27e973749050 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > @@ -696,10 +696,24 @@ static void etm_disable(struct coresight_device *csdev,
> >                 coresight_set_mode(csdev, CS_MODE_DISABLED);
> >  }
> >
> > +static int etm_trace_id(struct coresight_device *csdev)
> > +{
> > +       struct etm_drvdata *drvdata;
> > +
> > +       if (csdev == NULL)
> > +               return -EINVAL;
> > +
> > +       drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +       return etm_read_alloc_trace_id(drvdata);
> > +}
> > +
> > +
> >  static const struct coresight_ops_source etm_source_ops = {
> >         .cpu_id         = etm_cpu_id,
> >         .enable         = etm_enable,
> >         .disable        = etm_disable,
> > +       .trace_id       = etm_trace_id,
> >  };
> >
> >  static const struct coresight_ops etm_cs_ops = {
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index bf01f01964cf..8c3e9bfb9a9c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1024,10 +1024,23 @@ static void etm4_disable(struct coresight_device *csdev,
> >                 coresight_set_mode(csdev, CS_MODE_DISABLED);
> >  }
> >
> > +static int etm4_trace_id(struct coresight_device *csdev)
> > +{
> > +       struct etmv4_drvdata *drvdata;
> > +
> > +       if (csdev == NULL)
> > +               return -EINVAL;
> > +
> > +       drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +       return etm4_read_alloc_trace_id(drvdata);
> > +}
> > +
> >  static const struct coresight_ops_source etm4_source_ops = {
> >         .cpu_id         = etm4_cpu_id,
> >         .enable         = etm4_enable,
> >         .disable        = etm4_disable,
> > +       .trace_id       = etm4_trace_id,
> >  };
> >
> >  static const struct coresight_ops etm4_cs_ops = {
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index 61a46d3bdcc8..e2576531f796 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -105,6 +105,15 @@ struct cs_buffers {
> >         void                    **data_pages;
> >  };
> >
> > +/**
> > + * struct cs_sink_data - data used by coresight_enable_path/coresight_disable_path
> > + */
> > +struct cs_sink_data {
> > +       struct perf_output_handle       *handle;
> > +       struct coresight_device         *sink;
> > +       u32                             traceid;
> > +};
> > +
> >  static inline void coresight_insert_barrier_packet(void *buf)
> >  {
> >         if (buf)
> > @@ -129,9 +138,10 @@ static inline void CS_UNLOCK(void __iomem *addr)
> >         } while (0);
> >  }
> >
> > -void coresight_disable_path(struct list_head *path);
> > +void coresight_disable_path(struct list_head *path, void *sink_data);
> >  int coresight_enable_path(struct list_head *path, enum cs_mode mode,
> >                           void *sink_data);
> > +int coresight_read_traceid(struct list_head *path);
> >  struct coresight_device *coresight_get_sink(struct list_head *path);
> >  struct coresight_device *coresight_get_sink_by_id(u32 id);
> >  struct coresight_device *
> > diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> > index 117dbb484543..3817743fc0c6 100644
> > --- a/drivers/hwtracing/coresight/coresight-stm.c
> > +++ b/drivers/hwtracing/coresight/coresight-stm.c
> > @@ -280,9 +280,22 @@ static void stm_disable(struct coresight_device *csdev,
> >         }
> >  }
> >
> > +static int stm_trace_id(struct coresight_device *csdev)
> > +{
> > +       struct stm_drvdata *drvdata;
> > +
> > +       if (csdev == NULL)
> > +               return -EINVAL;
> > +
> > +       drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +       return drvdata->traceid;
> > +}
> > +
> >  static const struct coresight_ops_source stm_source_ops = {
> >         .enable         = stm_enable,
> >         .disable        = stm_disable,
> > +       .trace_id       = stm_trace_id,
> >  };
> >
> >  static const struct coresight_ops stm_cs_ops = {
> > diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> > index 1e67cc7758d7..a95afc890587 100644
> > --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> > @@ -167,6 +167,7 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
> >         int cpu, ret = 0;
> >         struct coresight_device *sink;
> >         struct list_head *path;
> > +       struct cs_sink_data *sink_data;
> >         enum coresight_dev_subtype_source subtype;
> >         u32 hash;
> >
> > @@ -208,7 +209,14 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
> >                 goto out;
> >         }
> >
> > -       ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
> > +       sink_data = kzalloc(sizeof(*sink_data), GFP_KERNEL);
> > +       if (!sink_data) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +       sink_data->traceid = coresight_read_traceid(path);
> > +       sink_data->sink = sink;
> > +       ret = coresight_enable_path(path, CS_MODE_SYSFS, sink_data);
> >         if (ret)
> >                 goto err_path;
> >
> > @@ -245,15 +253,17 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
> >                 break;
> >         }
> >
> > +       kfree(sink_data);
> >  out:
> >         mutex_unlock(&coresight_mutex);
> >         return ret;
> >
> >  err_source:
> > -       coresight_disable_path(path);
> > +       coresight_disable_path(path, sink_data);
> >
> >  err_path:
> >         coresight_release_path(path);
> > +       kfree(sink_data);
> >         goto out;
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_enable_sysfs);
> > @@ -262,6 +272,7 @@ void coresight_disable_sysfs(struct coresight_device *csdev)
> >  {
> >         int cpu, ret;
> >         struct list_head *path = NULL;
> > +       struct cs_sink_data *sink_data = NULL;
> >         u32 hash;
> >
> >         mutex_lock(&coresight_mutex);
> > @@ -273,6 +284,10 @@ void coresight_disable_sysfs(struct coresight_device *csdev)
> >         if (!coresight_disable_source_sysfs(csdev, NULL))
> >                 goto out;
> >
> > +       sink_data = kzalloc(sizeof(*sink_data), GFP_KERNEL);
> > +       if (!sink_data)
> > +               goto out;
> > +
> >         switch (csdev->subtype.source_subtype) {
> >         case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> >                 cpu = source_ops(csdev)->cpu_id(csdev);
> > @@ -296,8 +311,11 @@ void coresight_disable_sysfs(struct coresight_device *csdev)
> >                 break;
> >         }
> >
> > -       coresight_disable_path(path);
> > +       sink_data->sink = coresight_find_activated_sysfs_sink(csdev);
> > +       sink_data->traceid = coresight_read_traceid(path);
> > +       coresight_disable_path(path, sink_data);
> >         coresight_release_path(path);
> > +       kfree(sink_data);
> >
> >  out:
> >         mutex_unlock(&coresight_mutex);
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index d4f641cd9de6..7dc536eba3e2 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -250,7 +250,8 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
> >         pid_t pid;
> >         unsigned long flags;
> >         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct cs_buffers *buf = etm_perf_sink_config(handle);
> >
> >         spin_lock_irqsave(&drvdata->spinlock, flags);
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index e75428fa1592..0c24520645e2 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -1253,7 +1253,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
> >  struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> >                                    enum cs_mode mode, void *data)
> >  {
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct etr_perf_buffer *etr_perf;
> >
> >         switch (mode) {
> > @@ -1647,7 +1648,8 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
> >         pid_t pid;
> >         unsigned long flags;
> >         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
> >
> >         spin_lock_irqsave(&drvdata->spinlock, flags);
> > diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> > index bfca103f9f84..20f0ab73159c 100644
> > --- a/drivers/hwtracing/coresight/coresight-tpda.c
> > +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> > @@ -232,9 +232,22 @@ static void tpda_disable(struct coresight_device *csdev,
> >         dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", in->dest_port);
> >  }
> >
> > +static int tpda_trace_id(struct coresight_device *csdev)
> > +{
> > +       struct tpda_drvdata *drvdata;
> > +
> > +       if (csdev == NULL)
> > +               return -EINVAL;
> > +
> > +       drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +       return drvdata->atid;
> > +}
> > +
> >  static const struct coresight_ops_link tpda_link_ops = {
> >         .enable         = tpda_enable,
> >         .disable        = tpda_disable,
> > +       .trace_id       = tpda_trace_id,
> >  };
> >
> >  static const struct coresight_ops tpda_cs_ops = {
> > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > index 96a32b213669..7f4560b067a8 100644
> > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > @@ -21,6 +21,7 @@
> >
> >  #include "coresight-self-hosted-trace.h"
> >  #include "coresight-trbe.h"
> > +#include "coresight-priv.h"
> >
> >  #define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> >
> > @@ -1012,7 +1013,8 @@ static int arm_trbe_enable(struct coresight_device *csdev, enum cs_mode mode,
> >  {
> >         struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> >         struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct trbe_buf *buf = etm_perf_sink_config(handle);
> >
> >         WARN_ON(cpudata->cpu != smp_processor_id());
> > diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> > index f9ebf20c91e6..92d8a9fb844e 100644
> > --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> > +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> > @@ -217,7 +217,8 @@ static void smb_enable_sysfs(struct coresight_device *csdev)
> >  static int smb_enable_perf(struct coresight_device *csdev, void *data)
> >  {
> >         struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -       struct perf_output_handle *handle = data;
> > +       struct cs_sink_data *sink_data = (struct cs_sink_data *)data;
> > +       struct perf_output_handle *handle = sink_data->handle;
> >         struct cs_buffers *buf = etm_perf_sink_config(handle);
> >         pid_t pid;
> >
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index f09ace92176e..fb1c225076a5 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -344,6 +344,7 @@ struct coresight_ops_sink {
> >   * Operations available for links.
> >   * @enable:    enables flow between iport and oport.
> >   * @disable:   disables flow between iport and oport.
> > + * @trace_id:  Collect the traceid.
> >   */
> >  struct coresight_ops_link {
> >         int (*enable)(struct coresight_device *csdev,
> > @@ -352,6 +353,7 @@ struct coresight_ops_link {
> >         void (*disable)(struct coresight_device *csdev,
> >                         struct coresight_connection *in,
> >                         struct coresight_connection *out);
> > +       int (*trace_id)(struct coresight_device *csdev);
> >  };
> >
> >  /**
> > @@ -361,6 +363,7 @@ struct coresight_ops_link {
> >   *             is associated to.
> >   * @enable:    enables tracing for a source.
> >   * @disable:   disables tracing for a source.
> > + * @trace_id:  collect the traceid.
> >   */
> >  struct coresight_ops_source {
> >         int (*cpu_id)(struct coresight_device *csdev);
> > @@ -368,6 +371,7 @@ struct coresight_ops_source {
> >                       enum cs_mode mode);
> >         void (*disable)(struct coresight_device *csdev,
> >                         struct perf_event *event);
> > +       int (*trace_id)(struct coresight_device *csdev);
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
> 

