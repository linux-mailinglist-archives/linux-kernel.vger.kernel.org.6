Return-Path: <linux-kernel+bounces-256413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC8D934E18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D7A1F22908
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66A13E8B9;
	Thu, 18 Jul 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0KGEbWk"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046913E3F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309064; cv=none; b=uSgjkjemV2ZZ7vid02PBLv/KxmeNjw5ESVtA/jvIvDjisLNJonr/7fhGMFyG/VDe6ZAM7WzX0G87anMkKmJYCT2v74k8AapiBpidDBh11VwgLoTrCB22ne4gUAApY7iKOnTLsPcc+6EiahuruDGkLIkEJsfC/1y3IHz/vj0B/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309064; c=relaxed/simple;
	bh=U1pfg55HdXK4V00gFnXxCsKey0b3wU/hM1pF4onls60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlygDJQi/tZxYkHUlwrpayxXvVj6VNLYmJlppDFLSOaZIKMYczstblShkm3FKrYGsK3pKr1QuDyZ1ERzMH5fLlisjhAjO0cQhwXutxpnnH+ElFJg29t/dF1E3Z/4ZX3zk7aZzQcTR9gDLgzm5UkqfHGr9Tz9T05eGHkQQoszoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0KGEbWk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso569972b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309062; x=1721913862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGPG+vOp4BPw3LipgjGZ3EtmdruCfOTUInI/23vTD28=;
        b=E0KGEbWk7bjKknKskI9A6i4umd4Hkx94FgHXEej+OBeaweVvdliRvOlr0pZbNGMAsE
         xFzNxW8ycbhJ3SAbri/szVkLt6rWYycbqTlmUDsFZEfzsQqxGOB1xIng1hRI421G7mlm
         V6jJRPkjGYD4XQhcgM2PEZccxW/EuLUX6Qnzu5s2xqmMAunhDiVWxLbvPHVVVP9S2qyu
         h3zIRYRhOCWTnvg+cbEiVp2tif2Pokx/lQVTlUVGW4CfQwg5tb5ZaXc0ZkYFwrHXiBvX
         mPdvYX52ECXTqfzSaO/OHfrqWHZ1WS3LnleFVhCcyx3kWNkwbGsuolkGOkqffjiZQKiG
         ed1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309062; x=1721913862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGPG+vOp4BPw3LipgjGZ3EtmdruCfOTUInI/23vTD28=;
        b=Fs3RxojEBCg1r/hVcacoF54h6fYB1cooHHy7YPyBOCiCB1sZu6qbJ60ungeSBRzXHO
         oIGF8d0aWVzHT0tbOixHsRRyCWKKUA3NBHEaMglG2DIMTBHXbrBQ8MYnHSK8SZGnfU6F
         leOJI8Pb0pIpf8QkEPUrHqqC8hJQZi3GykPJ3RtqPWdFUVYJHBagvD0/tOpdYkjJSCvr
         KOzNwUh/BBVStFu+2uTh+8GSk1uusF0Pzg03LVJ1Sk0W8ZoicERJqedtOttFkPGLkD3n
         FyAroN76cb4cCTsLOUPH/jIAbSfBJaU2pmbOSyOszgQvjLmJoYHwZa1ugFoZMndNDSqY
         C4+w==
X-Forwarded-Encrypted: i=1; AJvYcCWTchDWvKWdfb5X6ynyzM8gLoLjEIGcQPIrz+RZRpm5dfDMjDpRmHLuAeq/eJOFpP2Uw2sH0PY3m8R1D3HQwLBA6SkczbFH2/J79fIa
X-Gm-Message-State: AOJu0Yy/6gQuAVHdczwN/4cbAxKiD5LOiNxHqs4Ioc4NaoTf/WyjJf3a
	7+oNRAHXi+GlYcFPbQ9aV8aiAep4jb4yOuWWgDR2mkLy/yg1Bjd+cxBDnCnlmMWmp6PnGP0d4Cv
	MzZ/V8+omB5Rtxr1T0+9DLsa2kbekXSRD2hcRUQ==
X-Google-Smtp-Source: AGHT+IFd+JX6ZLPuS0KpSTlG4UR0DFCqzczzE59CIZa2jVUt4ZSzDHk4uZ2+ebMWQarCvIuklOI86bqZp0LcCPIu9ko=
X-Received: by 2002:a05:6a00:3e0c:b0:705:d755:69b0 with SMTP id
 d2e1a72fcca58-70ce4e6d0b0mr5379375b3a.6.1721309061690; Thu, 18 Jul 2024
 06:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-4-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-4-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:24:10 +0100
Message-ID: <CAJ9a7ViqhtRuddnnX0wijqBjsp42L+uz-z21cFXMc0YvO6EROw@mail.gmail.com>
Subject: Re: [PATCH v5 03/17] perf: cs-etm: Move traceid_list to each queue
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> The global list won't work for per-sink trace ID allocations, so put a
> list in each queue where the IDs will be unique to that queue.
>
> To keep the same behavior as before, for version 0 of the HW_ID packets,
> copy all the HW_ID mappings into all queues.
>
> This change doesn't effect the decoders, only trace ID lookups on the
> Perf side. The decoders are still created with global mappings which
> will be fixed in a later commit.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 ++-
>  tools/perf/util/cs-etm.c                      | 215 +++++++++++-------
>  tools/perf/util/cs-etm.h                      |   2 +-
>  3 files changed, 147 insertions(+), 98 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index e917985bbbe6..0c9c48cedbf1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -388,7 +388,8 @@ cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
>  }
>
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
> +cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
> +                             struct cs_etm_packet_queue *packet_queue,
>                               const u8 trace_chan_id,
>                               enum cs_etm_sample_type sample_type)
>  {
> @@ -398,7 +399,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
>         if (packet_queue->packet_count >= CS_ETM_PACKET_MAX_BUFFER - 1)
>                 return OCSD_RESP_FATAL_SYS_ERR;
>
> -       if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
> +       if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
>                 return OCSD_RESP_FATAL_SYS_ERR;
>
>         et = packet_queue->tail;
> @@ -436,7 +437,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
>         int ret = 0;
>         struct cs_etm_packet *packet;
>
> -       ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
> +       ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
>                                             CS_ETM_RANGE);
>         if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
>                 return ret;
> @@ -496,7 +497,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
>  }
>
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
> +cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
> +                                    struct cs_etm_packet_queue *queue,
>                                      const uint8_t trace_chan_id)
>  {
>         /*
> @@ -504,18 +506,19 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
>          * reset time statistics.
>          */
>         cs_etm_decoder__reset_timestamp(queue);
> -       return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
> +       return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
>                                              CS_ETM_DISCONTINUITY);
>  }
>
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
> +cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
> +                                struct cs_etm_packet_queue *queue,
>                                  const ocsd_generic_trace_elem *elem,
>                                  const uint8_t trace_chan_id)
>  {      int ret = 0;
>         struct cs_etm_packet *packet;
>
> -       ret = cs_etm_decoder__buffer_packet(queue, trace_chan_id,
> +       ret = cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
>                                             CS_ETM_EXCEPTION);
>         if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
>                 return ret;
> @@ -527,10 +530,11 @@ cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
>  }
>
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
> +cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
> +                                    struct cs_etm_packet_queue *queue,
>                                      const uint8_t trace_chan_id)
>  {
> -       return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
> +       return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
>                                              CS_ETM_EXCEPTION_RET);
>  }
>
> @@ -599,7 +603,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>         case OCSD_GEN_TRC_ELEM_EO_TRACE:
>         case OCSD_GEN_TRC_ELEM_NO_SYNC:
>         case OCSD_GEN_TRC_ELEM_TRACE_ON:
> -               resp = cs_etm_decoder__buffer_discontinuity(packet_queue,
> +               resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
>                                                             trace_chan_id);
>                 break;
>         case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
> @@ -607,11 +611,11 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>                                                     trace_chan_id);
>                 break;
>         case OCSD_GEN_TRC_ELEM_EXCEPTION:
> -               resp = cs_etm_decoder__buffer_exception(packet_queue, elem,
> +               resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
>                                                         trace_chan_id);
>                 break;
>         case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> -               resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
> +               resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
>                                                             trace_chan_id);
>                 break;
>         case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1a95c4bb898f..0cd7d3843411 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -116,16 +116,18 @@ struct cs_etm_queue {
>         /* Conversion between traceID and index in traceid_queues array */
>         struct intlist *traceid_queues_list;
>         struct cs_etm_traceid_queue **traceid_queues;
> +       /* Conversion between traceID and metadata pointers */
> +       struct intlist *traceid_list;
>  };
>
> -/* RB tree for quick conversion between traceID and metadata pointers */
> -static struct intlist *traceid_list;
> -
>  static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>                                            pid_t tid);
>  static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
>  static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
> +static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
> +static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
> +static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
>
>  /* PTMs ETMIDR [11:8] set to b0011 */
>  #define ETMIDR_PTM_VERSION 0x00000300
> @@ -151,12 +153,12 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>         return CS_ETM_PROTO_ETMV3;
>  }
>
> -static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
> +static int cs_etm__get_magic(struct cs_etm_queue *etmq, u8 trace_chan_id, u64 *magic)
>  {
>         struct int_node *inode;
>         u64 *metadata;
>
> -       inode = intlist__find(traceid_list, trace_chan_id);
> +       inode = intlist__find(etmq->traceid_list, trace_chan_id);
>         if (!inode)
>                 return -EINVAL;
>
> @@ -165,12 +167,12 @@ static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
>         return 0;
>  }
>
> -int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
> +int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
>  {
>         struct int_node *inode;
>         u64 *metadata;
>
> -       inode = intlist__find(traceid_list, trace_chan_id);
> +       inode = intlist__find(etmq->traceid_list, trace_chan_id);
>         if (!inode)
>                 return -EINVAL;
>
> @@ -222,30 +224,108 @@ enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq)
>         return etmq->etm->pid_fmt;
>  }
>
> -static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
> +static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
> +                                       u8 trace_chan_id, u64 *cpu_metadata)
>  {
> -       struct int_node *inode;
> -
>         /* Get an RB node for this CPU */
> -       inode = intlist__findnew(traceid_list, trace_chan_id);
> +       struct int_node *inode = intlist__findnew(etmq->traceid_list, trace_chan_id);
>
>         /* Something went wrong, no need to continue */
>         if (!inode)
>                 return -ENOMEM;
>
> +       /* Disallow re-mapping a different traceID to metadata pair. */
> +       if (inode->priv) {
> +               u64 *curr_cpu_data = inode->priv;
> +               u8 curr_chan_id;
> +               int err;
> +
> +               if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
> +                       pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
> +                       return -EINVAL;
> +               }
> +
> +               /* check that the mapped ID matches */
> +               err = cs_etm__metadata_get_trace_id(&curr_chan_id, curr_cpu_data);
> +               if (err)
> +                       return err;
> +
> +               if (curr_chan_id != trace_chan_id) {
> +                       pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
> +                       return -EINVAL;
> +               }
> +
> +               /* Skip re-adding the same mappings if everything matched */
> +               return 0;
> +       }
> +
> +       /* Not one we've seen before, associate the traceID with the metadata pointer */
> +       inode->priv = cpu_metadata;
> +
> +       return 0;
> +}
> +
> +static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
> +{
> +       if (etm->per_thread_decoding)
> +               return etm->queues.queue_array[0].priv;
> +       else
> +               return etm->queues.queue_array[cpu].priv;
> +}
> +
> +static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id,
> +                                  u64 *cpu_metadata)
> +{
> +       struct cs_etm_queue *etmq;
> +
>         /*
> -        * The node for that CPU should not be taken.
> -        * Back out if that's the case.
> +        * If the queue is unformatted then only save one mapping in the
> +        * queue associated with that CPU so only one decoder is made.
>          */
> -       if (inode->priv)
> -               return -EINVAL;
> +       etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
> +       if (etmq->format == UNFORMATTED)
> +               return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
> +                                                   cpu_metadata);
>
> -       /* All good, associate the traceID with the metadata pointer */
> -       inode->priv = cpu_metadata;
> +       /*
> +        * Otherwise, version 0 trace IDs are global so save them into every
> +        * queue.
> +        */
> +       for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
> +               int ret;
> +
> +               etmq = etm->queues.queue_array[i].priv;
> +               ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
> +                                                  cpu_metadata);
> +               if (ret)
> +                       return ret;
> +       }
>
>         return 0;
>  }
>
> +static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
> +                                      u64 hw_id)
> +{
> +       int err;
> +       u64 *cpu_data;
> +       u8 trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
> +
> +       cpu_data = get_cpu_data(etm, cpu);
> +       if (cpu_data == NULL)
> +               return -EINVAL;
> +
> +       err = cs_etm__map_trace_id_v0(etm, trace_chan_id, cpu_data);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * if we are picking up the association from the packet, need to plug
> +        * the correct trace ID into the metadata for setting up decoders later.
> +        */
> +       return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
> +}
> +
>  static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
>  {
>         u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
> @@ -329,17 +409,13 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>  {
>         struct cs_etm_auxtrace *etm;
>         struct perf_sample sample;
> -       struct int_node *inode;
>         struct evsel *evsel;
> -       u64 *cpu_data;
>         u64 hw_id;
>         int cpu, version, err;
> -       u8 trace_chan_id, curr_chan_id;
>
>         /* extract and parse the HW ID */
>         hw_id = event->aux_output_hw_id.hw_id;
>         version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
> -       trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
>
>         /* check that we can handle this version */
>         if (version > CS_AUX_HW_ID_CURR_VERSION) {
> @@ -367,43 +443,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>                 return -EINVAL;
>         }
>
> -       /* See if the ID is mapped to a CPU, and it matches the current CPU */
> -       inode = intlist__find(traceid_list, trace_chan_id);
> -       if (inode) {
> -               cpu_data = inode->priv;
> -               if ((int)cpu_data[CS_ETM_CPU] != cpu) {
> -                       pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
> -                       return -EINVAL;
> -               }
> -
> -               /* check that the mapped ID matches */
> -               err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
> -               if (err)
> -                       return err;
> -               if (curr_chan_id != trace_chan_id) {
> -                       pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
> -                       return -EINVAL;
> -               }
> -
> -               /* mapped and matched - return OK */
> -               return 0;
> -       }
> -
> -       cpu_data = get_cpu_data(etm, cpu);
> -       if (cpu_data == NULL)
> -               return err;
> -
> -       /* not one we've seen before - lets map it */
> -       err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
> -       if (err)
> -               return err;
> -
> -       /*
> -        * if we are picking up the association from the packet, need to plug
> -        * the correct trace ID into the metadata for setting up decoders later.
> -        */
> -       err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
> -       return err;
> +       return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
>  }
>
>  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> @@ -856,6 +896,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>
>  static void cs_etm__free_queue(void *priv)
>  {
> +       struct int_node *inode, *tmp;
>         struct cs_etm_queue *etmq = priv;
>
>         if (!etmq)
> @@ -863,6 +904,14 @@ static void cs_etm__free_queue(void *priv)
>
>         cs_etm_decoder__free(etmq->decoder);
>         cs_etm__free_traceid_queues(etmq);
> +
> +       /* First remove all traceID/metadata nodes for the RB tree */
> +       intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
> +               intlist__remove(etmq->traceid_list, inode);
> +
> +       /* Then the RB tree itself */
> +       intlist__delete(etmq->traceid_list);
> +
>         free(etmq);
>  }
>
> @@ -885,19 +934,12 @@ static void cs_etm__free_events(struct perf_session *session)
>  static void cs_etm__free(struct perf_session *session)
>  {
>         int i;
> -       struct int_node *inode, *tmp;
>         struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
>                                                    struct cs_etm_auxtrace,
>                                                    auxtrace);
>         cs_etm__free_events(session);
>         session->auxtrace = NULL;
>
> -       /* First remove all traceID/metadata nodes for the RB tree */
> -       intlist__for_each_entry_safe(inode, tmp, traceid_list)
> -               intlist__remove(traceid_list, inode);
> -       /* Then the RB tree itself */
> -       intlist__delete(traceid_list);
> -
>         for (i = 0; i < aux->num_cpu; i++)
>                 zfree(&aux->metadata[i]);
>
> @@ -1055,9 +1097,24 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
>
>         etmq->traceid_queues_list = intlist__new(NULL);
>         if (!etmq->traceid_queues_list)
> -               free(etmq);
> +               goto out_free;
> +
> +       /*
> +        * Create an RB tree for traceID-metadata tuple.  Since the conversion
> +        * has to be made for each packet that gets decoded, optimizing access
> +        * in anything other than a sequential array is worth doing.
> +        */
> +       etmq->traceid_list = intlist__new(NULL);
> +       if (!etmq->traceid_list)
> +               goto out_free;
>
>         return etmq;
> +
> +out_free:
> +       intlist__delete(etmq->traceid_queues_list);
> +       free(etmq);
> +
> +       return NULL;
>  }
>
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> @@ -2207,7 +2264,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
>                                               PERF_IP_FLAG_TRACE_END;
>                 break;
>         case CS_ETM_EXCEPTION:
> -               ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
> +               ret = cs_etm__get_magic(etmq, packet->trace_chan_id, &magic);
>                 if (ret)
>                         return ret;
>
> @@ -3124,7 +3181,8 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>  }
>
>  /* map trace ids to correct metadata block, from information in metadata */
> -static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
> +static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_cpu,
> +                                         u64 **metadata)
>  {
>         u64 cs_etm_magic;
>         u8 trace_chan_id;
> @@ -3146,7 +3204,7 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
>                         /* unknown magic number */
>                         return -EINVAL;
>                 }
> -               err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
> +               err = cs_etm__map_trace_id_v0(etm, trace_chan_id, metadata[i]);
>                 if (err)
>                         return err;
>         }
> @@ -3277,23 +3335,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         u64 *ptr = NULL;
>         u64 **metadata = NULL;
>
> -       /*
> -        * Create an RB tree for traceID-metadata tuple.  Since the conversion
> -        * has to be made for each packet that gets decoded, optimizing access
> -        * in anything other than a sequential array is worth doing.
> -        */
> -       traceid_list = intlist__new(NULL);
> -       if (!traceid_list)
> -               return -ENOMEM;
> -
>         /* First the global part */
>         ptr = (u64 *) auxtrace_info->priv;
>         num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>         metadata = zalloc(sizeof(*metadata) * num_cpu);
> -       if (!metadata) {
> -               err = -ENOMEM;
> -               goto err_free_traceid_list;
> -       }
> +       if (!metadata)
> +               return -ENOMEM;
>
>         /* Start parsing after the common part of the header */
>         i = CS_HEADER_VERSION_MAX;
> @@ -3472,7 +3519,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>                 err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
>         /* otherwise, this is a file with metadata values only, map from metadata */
>         else
> -               err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
> +               err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
>
>         if (err)
>                 goto err_free_queues;
> @@ -3494,7 +3541,5 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         for (int j = 0; j < num_cpu; j++)
>                 zfree(&metadata[j]);
>         zfree(&metadata);
> -err_free_traceid_list:
> -       intlist__delete(traceid_list);
>         return err;
>  }
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 4696267a32f0..f4f69f7cc0f3 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -252,7 +252,7 @@ enum cs_etm_pid_fmt {
>
>  #ifdef HAVE_CSTRACE_SUPPORT
>  #include <opencsd/ocsd_if_types.h>
> -int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
> +int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
>  enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
>  int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
>                             u8 trace_chan_id, ocsd_ex_level el);
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

