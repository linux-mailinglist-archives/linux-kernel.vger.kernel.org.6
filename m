Return-Path: <linux-kernel+bounces-279703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F96194C0AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F366285941
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217E18EFE8;
	Thu,  8 Aug 2024 15:13:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976318EFC8;
	Thu,  8 Aug 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130029; cv=none; b=OOVOTr8yAYGqM7ui6tXKqxetMtHp8qwTYUYZpgk9dX3lDCu0showXQfL1EX3tfTqDLdWEP0ZBtQd5tCr42fAtF4837Pa5sRhjkLLSIordAPb7ZtiMuO0JT0Aa3e35piczCFSLO0AdwbDyR0DCgDDeLGzGNwESD7Qy5VgxCS6Rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130029; c=relaxed/simple;
	bh=cOMxWabruzhnZ11PgjZtTtrU4MIs5F6+7N+r8+kcx/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtoHNQTns49YdGZabwYeJ9gGYA6ZG+NyVaocqycvX6Z4tCugCVhOOSHPRuGRHvYeHCB3GqlyBrYgZET2wDPVLY/gmTPgQVtbN0F3BU3+I4Y0OWKn90T3bZ+OgILzQu7LzEKx8CCm5bLWj2/WRh1ViRHZWFHO/I4z+pPbOc1PBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B14E91007;
	Thu,  8 Aug 2024 08:14:10 -0700 (PDT)
Received: from [10.57.68.17] (unknown [10.57.68.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04C23F766;
	Thu,  8 Aug 2024 08:13:42 -0700 (PDT)
Message-ID: <7c8e1b60-461d-456f-bc4a-85cc1f5ce4a5@arm.com>
Date: Thu, 8 Aug 2024 16:13:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] coresight: Add source filtering for multi-port
 output
Content-Language: en-GB
To: Tao Zhang <quic_taozha@quicinc.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Leo Yan <leo.yan@linux.dev>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240711081750.21792-1-quic_taozha@quicinc.com>
 <20240711081750.21792-3-quic_taozha@quicinc.com>
 <d63cdd7e-69db-4fc4-b98a-d4555a843e05@arm.com>
 <a1ae3a0c-5a58-4ed5-94c1-d64c512cc87c@quicinc.com>
 <aacf3c7c-8a47-4d9f-95ce-58dcbc94a66c@arm.com>
 <bba1e776-76fb-4ec6-9cad-ec4880472683@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <bba1e776-76fb-4ec6-9cad-ec4880472683@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2024 15:43, Tao Zhang wrote:
> 
> On 8/7/2024 10:59 PM, Suzuki K Poulose wrote:
>> On 18/07/2024 03:22, Tao Zhang wrote:
>>>
>>> On 7/11/2024 9:05 PM, Suzuki K Poulose wrote:
>>>> On 11/07/2024 09:17, Tao Zhang wrote:
>>>>> In order to enable the output ports of multi-port output devices,
>>>>
>>>> This has nothing to do with multi-port. You wanted to pain the picture
>>>> of a multi-port device, while the reality is different.
>>>>
>>>>> such as static replicator, to correspond to designated sources,
>>>>> a mechanism for filtering data sources is introduced for the
>>>>> output ports.
>>>>>
>>>>> The specified source will be marked like below in the Devicetree.
>>>>> test-replicator {
>>>>>      ... ... ... ...
>>>>>      out-ports {
>>>>>          ... ... ... ...
>>>>>          port@0 {
>>>>>              reg = <0>;
>>>>>              xxx: endpoint {
>>>>>                  remote-endpoint = <&xxx>;
>>>>>                  filter_src = <&xxx>; <-- To specify the source to
>>>>>              };                           be filtered out here.
>>>>>          };
>>>>>
>>>>>          port@1 {
>>>>>              reg = <1>;
>>>>>              yyy: endpoint {
>>>>>                  remote-endpoint = <&yyy>;
>>>>>                  filter_src = <&yyy>; <-- To specify the source to
>>>>>              };                           be filtered out here.
>>>>>          };
>>>>>      };
>>>>> };
>>>>>
>>>>> Then driver will find the expected source marked in the Devicetree, 
>>>>> and
>>>>> save it to the coresight path. When the function needs to filter the
>>>>> source, it could obtain it from coresight path parameter. Finally,
>>>>> the output port knows which source it corresponds to, and it also 
>>>>> knows
>>>>> which input port it corresponds to.
>>>>
>>>> Minor nit: I think the commit description is full of "How" you are 
>>>> doing something, while it must rather be: "What and Why?"
>>>>
>>>> I would prefer something like :
>>>>
>>>> Subject: coresight: Add support for trace filtering by source
>>>>
>>>> Some replicators have hard coded filtering of "trace" data, based on 
>>>> the
>>>> source device. This is different from the trace filtering based on
>>>> TraceID, available in the standard programmable replicators. e.g.,
>>>> Qualcomm replicators have filtering based on custom trace protocol
>>>> format and is not programmable.
>>>>
>>>> The source device could be connected to the replicator via intermediate
>>>> components (e.g., a funnel). Thus we need platform information from
>>>> the firmware tables to decide the source device corresponding to a
>>>> given output port from the replicator. Given this affects "trace
>>>> path building" and traversing the path back from the sink to source,
>>>> add the concept of "filtering by source" to the generic coresight
>>>> connection.
>>>>
>>> I will update according to your comments to the next version.
>>>>
>>>>>
>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>> ---
>>>>>   drivers/hwtracing/coresight/coresight-core.c  | 125 
>>>>> ++++++++++++++++--
>>>>>   .../hwtracing/coresight/coresight-platform.c  |  18 +++
>>>>>   include/linux/coresight.h                     |   5 +
>>>>>   3 files changed, 135 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>>> index 9fc6f6b863e0..3f02a31b9328 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>>> @@ -75,15 +75,60 @@ struct coresight_device 
>>>>> *coresight_get_percpu_sink(int cpu)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>>>>>   +static struct coresight_device *coresight_get_source(struct 
>>>>> list_head *path)
>>>>> +{
>>>>> +    struct coresight_device *csdev;
>>>>> +
>>>>> +    if (!path)
>>>>> +        return NULL;
>>>>> +
>>>>> +    csdev = list_first_entry(path, struct coresight_node, 
>>>>> link)->csdev;
>>>>> +    if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
>>>>> +        return NULL;
>>>>> +
>>>>> +    return csdev;
>>>>> +}
>>>>> +
>>>>
>>>> Why is this still here ? Didn't agree to remove this and pass the 
>>>> source
>>>> directly ?
>>>
>>> I agree pass the source directly, but how can we get the source 
>>> device of the path
>>>
>>> without this function? The solution I can think of is to pass source 
>>> directly from
>>>
>>> "coresight_enable"like below.
>>>
>>> coresight_enable ---pass source---> coresight_enable_path -> 
>>> coresight_enable_link
>>>
>>> -> coresight_find_out_connection -> coresight_blocks_source
>>>
>>> Does this solution meet your expectations? Or do you have a better 
>>> suggestion?
>>>
>>>>
>>>>> +/**
>>>>> + * coresight_source_filter - checks whether the connection matches 
>>>>> the source
>>>>> + * of path if connection is binded to specific source.
>>>>> + * @trace_source: The source device of the trace path
>>>>> + * @conn:      The connection of one outport
>>>>> + *
>>>>> + * Return zero if the connection doesn't have a source binded or 
>>>>> source of the
>>>>> + * path matches the source binds to connection.
>>>>> + */
>>>>> +static int coresight_source_filter(struct coresight_device 
>>>>> *trace_source,
>>>>> +            struct coresight_connection *conn)
>>>>
>>>> This name is a bit confusing. It doesn't tell you, whether it
>>>> allows the trace or blocks it.
>>>>
>>>>> +{
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    if (!conn->filter_src_dev)
>>>>> +        return ret;
>>>>
>>>> This is not the correct check. It must be :
>>>>
>>>> if (!conn->filter_src_fwnode)
>>>>
>>>> Because, the device could have disappeared (or not appeared yet). 
>>>> e.g., (TPDM) driver module unloaded/not - loaded.
>>>>
>>>>> +
>>>>> +    if (!trace_source)
>>>>
>>>> Is that possible ?
>>>>
>>>>> +        return -1;
>>>>> +
>>>>> +    if (conn->filter_src_dev == trace_source)
>>>>> +        ret = 0;
>>>>> +    else
>>>>> +        ret = -1;
>>>>
>>>> Couldn't this simply be :
>>>>
>>>> /*
>>>>  * Returns true, if the trace path is not possible through @conn
>>>>  * for trace originating from @src
>>>>  */
>>>> static bool coresight_blocks_source(src, conn)
>>>> {
>>>>     return conn->filter_src_fwnode &&
>>>>         (conn->filter_src_dev != src);
>>>> }
>>> I will update to the next version.
>>>>
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>   static struct coresight_connection *
>>>>>   coresight_find_out_connection(struct coresight_device *src_dev,
>>>>> -                  struct coresight_device *dest_dev)
>>>>> +                  struct coresight_device *dest_dev,
>>>>> +                  struct coresight_device *trace_source)
>>>>
>>>> Please could you rename :
>>>>
>>>>     src_dev => csdev
>>>>     dest_dev => out_dev
>>>>     trace_source => trace_src ?
>>>>
>>>> Having src_dev and trace_source in the same list is confusing.
>>> I will update to the next version.
>>>>
>>>>>   {
>>>>>       int i;
>>>>>       struct coresight_connection *conn;
>>>>>         for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
>>>>>           conn = src_dev->pdata->out_conns[i];
>>>>> +        if (coresight_source_filter(trace_source, conn))
>>>>
>>>>         if (coresight_blocks_source(trace_source, conn))
>>>>             continue;
>>>>
>>>>> +            continue;
>>>>>           if (conn->dest_dev == dest_dev)
>>>>>               return conn;
>>>>>       }
>>>>> @@ -251,7 +296,8 @@ static void coresight_disable_sink(struct 
>>>>> coresight_device *csdev)
>>>>>     static int coresight_enable_link(struct coresight_device *csdev,
>>>>>                    struct coresight_device *parent,
>>>>> -                 struct coresight_device *child)
>>>>> +                 struct coresight_device *child,
>>>>> +                 struct coresight_device *trace_source)
>>>>>   {
>>>>>       int link_subtype;
>>>>>       struct coresight_connection *inconn, *outconn;
>>>>> @@ -259,8 +305,8 @@ static int coresight_enable_link(struct 
>>>>> coresight_device *csdev,
>>>>>       if (!parent || !child)
>>>>>           return -EINVAL;
>>>>>   -    inconn = coresight_find_out_connection(parent, csdev);
>>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>>> +    inconn = coresight_find_out_connection(parent, csdev, 
>>>>> trace_source);
>>>>> +    outconn = coresight_find_out_connection(csdev, child, 
>>>>> trace_source);
>>>>>       link_subtype = csdev->subtype.link_subtype;
>>>>>         if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && 
>>>>> IS_ERR(inconn))
>>>>> @@ -273,15 +319,16 @@ static int coresight_enable_link(struct 
>>>>> coresight_device *csdev,
>>>>>     static void coresight_disable_link(struct coresight_device *csdev,
>>>>>                      struct coresight_device *parent,
>>>>> -                   struct coresight_device *child)
>>>>> +                   struct coresight_device *child,
>>>>> +                   struct coresight_device *trace_source)
>>>>>   {
>>>>>       struct coresight_connection *inconn, *outconn;
>>>>>         if (!parent || !child)
>>>>>           return;
>>>>>   -    inconn = coresight_find_out_connection(parent, csdev);
>>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>>> +    inconn = coresight_find_out_connection(parent, csdev, 
>>>>> trace_source);
>>>>> +    outconn = coresight_find_out_connection(csdev, child, 
>>>>> trace_source);
>>>>>         link_ops(csdev)->disable(csdev, inconn, outconn);
>>>>>   }
>>>>> @@ -341,6 +388,9 @@ static void coresight_disable_path_from(struct 
>>>>> list_head *path,
>>>>>   {
>>>>>       u32 type;
>>>>>       struct coresight_device *csdev, *parent, *child;
>>>>> +    struct coresight_device *source;
>>>>> +
>>>>> +    source = coresight_get_source(path);
>>>>
>>>> Grr! This must come from the "caller of the 
>>>> coresight_disable_path_from()", which was my comment. Please go back
>>>> and double check the comment on previous version.
>>>
>>> How about if I pass the source to " coresight_disable_path_from" 
>>> directly from
>>>
>>> "coresight_enable" or "coresight_disable" like below?
>>>
>>> coresight_enable ----|                             |---> 
>>> coresight_disable_patch_from
>>>
>>>                                       |---pass source---|
>>>
>>> coresight_disable----|                             |---> 
>>> coresight_disable_path -> coresight_disable_patch_from
>>>
>>> This can ensure that the source passed into 
>>> coresight_disable_patch_from is
>>>
>>> the correct source.
>>
>> coresight_disable_path_from() must be given the "source" separately,
>> as the "path" could be "partial". Rest could stay as it is in your
>> patch.
> In what scenario is this "path" "partial"?
> 
> There are two place where "coresight_disable_path_from" will be called 
> in coresight driver.
> 
> 1. coresight_disable_path -> coresight_disable_path_from
> 
> In this case, I see all "coresight_disable_path" will be called after 
> building path successfully. The "path" should
> 
> be "complete", right?
> 
> 2. coresight_enable_path return with error and call 
> coresight_disable_path_from to disable the "path" from
> 
> "nd". But in this case, it is called after building path completely, 
> right? So this "path" should be complete as well?
> 
> Please let me know if there is any mistake in my understanding. If my 
> understanding is correct, then there is no
> 
> need to pass "source" to "coresight_disable_path_from". Because the 
> "source" can be collected from the "path"\

Apologies. You are right. We are passing the full path in both cases.
Instead "nd" is specified for partial path operations.

> 
> directly.
> 
>>
>>
>>>
>>>>
>>>>
>>>>>         if (!nd)
>>>>>           nd = list_first_entry(path, struct coresight_node, link);
>>>>> @@ -375,7 +425,7 @@ static void coresight_disable_path_from(struct 
>>>>> list_head *path,
>>>>>           case CORESIGHT_DEV_TYPE_LINK:
>>>>>               parent = list_prev_entry(nd, link)->csdev;
>>>>>               child = list_next_entry(nd, link)->csdev;
>>>>> -            coresight_disable_link(csdev, parent, child);
>>>>> +            coresight_disable_link(csdev, parent, child, source);
>>>>>               break;
>>>>>           default:
>>>>>               break;
>>>>> @@ -418,6 +468,9 @@ int coresight_enable_path(struct list_head 
>>>>> *path, enum cs_mode mode,
>>>>>       u32 type;
>>>>>       struct coresight_node *nd;
>>>>>       struct coresight_device *csdev, *parent, *child;
>>>>> +    struct coresight_device *source;
>>>>> +
>>>>> +    source = coresight_get_source(path);
>>>>>         list_for_each_entry_reverse(nd, path, link) {
>>>>>           csdev = nd->csdev;
>>>>> @@ -456,7 +509,7 @@ int coresight_enable_path(struct list_head 
>>>>> *path, enum cs_mode mode,
>>>>>           case CORESIGHT_DEV_TYPE_LINK:
>>>>>               parent = list_prev_entry(nd, link)->csdev;
>>>>>               child = list_next_entry(nd, link)->csdev;
>>>>> -            ret = coresight_enable_link(csdev, parent, child);
>>>>> +            ret = coresight_enable_link(csdev, parent, child, 
>>>>> source);
>>>>>               if (ret)
>>>>>                   goto err;
>>>>>               break;
>>>>> @@ -619,6 +672,7 @@ static void coresight_drop_device(struct 
>>>>> coresight_device *csdev)
>>>>>    * @csdev:    The device to start from.
>>>>>    * @sink:    The final sink we want in this path.
>>>>>    * @path:    The list to add devices to.
>>>>> + * @trace_source: The trace source device of the path.
>>>>>    *
>>>>>    * The tree of Coresight device is traversed until @sink is found.
>>>>>    * From there the sink is added to the list along with all the 
>>>>> devices that led
>>>>> @@ -627,7 +681,8 @@ static void coresight_drop_device(struct 
>>>>> coresight_device *csdev)
>>>>>    */
>>>>>   static int _coresight_build_path(struct coresight_device *csdev,
>>>>>                    struct coresight_device *sink,
>>>>> -                 struct list_head *path)
>>>>> +                 struct list_head *path,
>>>>> +                 struct coresight_device *trace_source)
>>>>>   {
>>>>>       int i, ret;
>>>>>       bool found = false;
>>>>> @@ -639,7 +694,7 @@ static int _coresight_build_path(struct 
>>>>> coresight_device *csdev,
>>>>>         if (coresight_is_percpu_source(csdev) && 
>>>>> coresight_is_percpu_sink(sink) &&
>>>>>           sink == per_cpu(csdev_sink, 
>>>>> source_ops(csdev)->cpu_id(csdev))) {
>>>>> -        if (_coresight_build_path(sink, sink, path) == 0) {
>>>>> +        if (_coresight_build_path(sink, sink, path, trace_source) 
>>>>> == 0) {
>>>>>               found = true;
>>>>>               goto out;
>>>>>           }
>>>>> @@ -650,8 +705,13 @@ static int _coresight_build_path(struct 
>>>>> coresight_device *csdev,
>>>>>           struct coresight_device *child_dev;
>>>>>             child_dev = csdev->pdata->out_conns[i]->dest_dev;
>>>>> +
>>>>> +        if (csdev->pdata->out_conns[i]->filter_src_dev
>>>>> +            && (csdev->pdata->out_conns[i]->filter_src_dev != 
>>>>> trace_source))
>>>>> +            continue;
>>>>> +
>>>>>           if (child_dev &&
>>>>> -            _coresight_build_path(child_dev, sink, path) == 0) {
>>>>> +            _coresight_build_path(child_dev, sink, path, 
>>>>> trace_source) == 0) {
>>>>>               found = true;
>>>>>               break;
>>>>>           }
>>>>> @@ -696,7 +756,7 @@ struct list_head *coresight_build_path(struct 
>>>>> coresight_device *source,
>>>>>         INIT_LIST_HEAD(path);
>>>>>   -    rc = _coresight_build_path(source, sink, path);
>>>>> +    rc = _coresight_build_path(source, sink, path, source);
>>>>>       if (rc) {
>>>>>           kfree(path);
>>>>>           return ERR_PTR(rc);
>>>>> @@ -957,6 +1017,14 @@ static int coresight_orphan_match(struct 
>>>>> device *dev, void *data)
>>>>>               /* This component still has an orphan */
>>>>>               still_orphan = true;
>>>>>           }
>>>>
>>>>
>>>>> +        if ((conn->filter_src_fwnode) && dst_csdev
>>>>> +            && (conn->filter_src_fwnode == dst_csdev->dev.fwnode)) {
>>>>> +            conn->filter_src_dev = dst_csdev;
>>>>> +            if (conn->filter_src_dev->type
>>>>> +                != CORESIGHT_DEV_TYPE_SOURCE)
>>>>> + dev_warn(&conn->filter_src_dev->dev,
>>>>> +                  "Filter source is not a source device\n");
>>>>> +        }
>>>>
>>>> Have you tested your code with the following order :
>>>>
>>>> 1) Build everything as module
>>>> 2) Load the replicator driver.
>>>> 3) Load the TPDM driver
>>>>
>>>> And are you able to get the trace working ? I suspect it doesn't 
>>>> work. The csdev->orphan must be used to track if there is any 
>>>> missing link
>>>> with unresolved "filter_src_dev".
>>>
>>> I really didn't consider this test case in my testing. There was a 
>>> problem with
>>>
>>> the logic of the code I modified. If it is modified to the following, 
>>> can it solve the
>>>
>>> test case you proposed?
>>>
>>> static int coresight_orphan_match(struct device *dev, void *data)
>>> {
>>>      ... ... ...
>>>      for (i = 0; i < src_csdev->pdata->nr_outconns; i++) {
>>>          conn = src_csdev->pdata->out_conns[i];
>>>
>>>          /*Add the following code to fix filter source device before 
>>> skip the port*/
>>> +        if ((conn->filter_src_fwnode) && dst_csdev
>>> +            && (conn->filter_src_fwnode == dst_csdev->dev.fwnode)) {
>>> +             conn->filter_src_dev = dst_csdev;
>>> +             if (conn->filter_src_dev->type
>>> +                 != CORESIGHT_DEV_TYPE_SOURCE)
>>> +                 dev_warn(&conn->filter_src_dev->dev,
>>> +                   "Filter source is not a source device\n");
>>
>> And we should not set the device as the filter_src_dev in this case.
> 
> Sure, I will update the code as the following.
> 
> +        if ((conn->filter_src_fwnode) && dst_csdev
> +            && (conn->filter_src_fwnode == dst_csdev->dev.fwnode)) {
> +             if (dst_csdev->type == CORESIGHT_DEV_TYPE_SOURCE)
> +                 conn->filter_src_dev = dst_csdev;
> +             else
> +                 dev_warn(&dst_csdev->dev,
> +                   "Filter source is not a source device\n");
>>
>>> +        }
>>>
>>>          /* Skip the port if it's already connected. */
>>>          if (conn->dest_dev)
>>>              continue;
>>>      ... ... ...
>>>              ret = coresight_add_in_conn(conn);
>>>              if (ret)
>>>                  return ret;
>>>
>>>                /* Add the following code to make sure the device 
>>> still orphan if there is a
>>>
>>>                  * filter source firmware node but the filter source 
>>> is null.*/
>>>
>>> +            if (conn->filter_src_fwnode && !conn->filter_src_dev)
>>> +                still_orphan = true;
>>>          } else {
>>>              /* This component still has an orphan */
>>>              still_orphan = true;
>>>          }
>>>      }
>>>
>>>      src_csdev->orphan = still_orphan;
>>>      ... ... ...
>>> }
>>>
>>>>
>>>>
>>>>>       }
>>>>>         src_csdev->orphan = still_orphan;
>>>>> @@ -974,6 +1042,30 @@ static int 
>>>>> coresight_fixup_orphan_conns(struct coresight_device *csdev)
>>>>>                csdev, coresight_orphan_match);
>>>>>   }
>>>>>   +/* reset_filter_src - Reset the filter source if the source is 
>>>>> being removed */
>>>>> +static int reset_filter_src(struct coresight_device *trace_source,
>>>>> +                struct coresight_connection *conn)
>>>>> +{
>>>>> +    int i;
>>>>> +    int ret = -1;
>>>>> +    struct coresight_device *csdev;
>>>>> +    struct coresight_connection *output_conn;
>>>>
>>>> I don't think this is sufficient. I would rather walk through the 
>>>> entire coresight bus and fixup the filter_src_dev, rather than 
>>>> traversing the
>>>> paths. e.g., one of the devices in the path could have been removed.
>>>> See coresight_clear_default_sink() for e.g. You should have something
>>>> similar :
>>>>
>>>> coresight_clear_filter_source();
>>>
>>> That's right. My current understanding is that there are two cases 
>>> that need to be considered.
>>>
>>> #1 Unregister the source device
>>>
>>> In this case, we need to walk through the entire coresight bus and 
>>> fixup the filter_src_dev
>>>
>>> #2 Unregister the replicator
>>>
>>> Iterate over all output connections to set filter_src_dev and 
>>> filter_src_fwnode to NULL.
>>>
>>> Is this logically correct? I have attached my sample code below, 
>>> please help review it.
>>>
>>> +static void coresight_clear_filter_source(struct device *dev, void 
>>> *data)
>>> +{
>>> +    int i;
>>> +    struct coresight_device *source = data;
>>> +    struct coresight_device *csdev = to_coresight_device(dev);
>>> +
>>> +    for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
>>> +        if (csdev->pdata->out_conns[i]->filter_src_dev == source)
>>> +            csdev->pdata->out_conns[i]->filter_src_dev = NULL;
>>> +    }
>>>
>>> +}
>>
>> That looks good to me.
>>
>>>
>>> /* coresight_remove_conns - Remove other device's references to this 
>>> device */
>>> static void coresight_remove_conns(struct coresight_device *csdev)
>>> {
>>>      int i, j;
>>>      struct coresight_connection *conn;
>>>
>>> +    if (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) //walk through the 
>>> entire coresight bus and fixup the filter_src_dev
>>> +        bus_for_each_dev(&coresight_bustype, NULL, csdev,
>>> +                 coresight_clear_filter_source);
>>>
>>>      /*
>>>       * Remove the input connection references from the destination 
>>> device
>>>       * for each output connection.
>>>       */
>>>      for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>>>          conn = csdev->pdata->out_conns[i];
>>> +        if (conn->filter_src_fwnode) { //Iterate over all output 
>>> connections to set filter_src_dev and filter_src_fwnode to NULL.
>>> +            conn->filter_src_dev = NULL;
>>> +            conn->filter_src_fwnode = NULL;
>>
>> We may need to "drop" the refcount for this one ?
> 
> I'm not clear why need to "drop" the refcount here. I didn't add 
> refcount to this patch series before.

Whenever we save a fwnode in a structure, we do : fwnode_handle_get()
and drop them via while releasing it via fwnode_handle_put().

e.g. : of_coresight_parse_endpoint() / acpi_coresight_parse_link() for
connection and dropped in coresight_release_platform_data().

You should do that whenever you save the filter_src_fwnode in 
coresight-platform.c and drop ot when the device "using the fwnode" goes 
away (in
this case the replicator).

Suzuki


> 
> Could you show me your sample code so I can understand what you mean?
> 
> 
> Best,
> 
> Tao
> 
>>
>> Suzuki
>>
>>
>>> +        }
>>>
>>>          if (!conn->dest_dev)
>>>              continue;
>>>
>>>         ... ... ...
>>> }
>>>
>>>
>>> Best,
>>>
>>> Tao
>>>
>>>>
>>>>
>>>> Suzuki
>>>>
>>>>
>>>>
>>>>> +
>>>>> +    csdev = conn->dest_dev;
>>>>> +    for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>>>>> +        output_conn = csdev->pdata->out_conns[i];
>>>>> +        if (output_conn->filter_src_dev
>>>>> +            && (output_conn->filter_src_dev == trace_source)) {
>>>>> +            output_conn->filter_src_dev = NULL;
>>>>> +            return 0;
>>>>> +        }
>>>>> +        ret = reset_filter_src(trace_source, output_conn);
>>>>> +        if (!ret)
>>>>> +            return ret;
>>>>> +    }
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>   /* coresight_remove_conns - Remove other device's references to 
>>>>> this device */
>>>>>   static void coresight_remove_conns(struct coresight_device *csdev)
>>>>>   {
>>>>> @@ -986,6 +1078,13 @@ static void coresight_remove_conns(struct 
>>>>> coresight_device *csdev)
>>>>>        */
>>>>
>>>>
>>>>>       for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>>>>>           conn = csdev->pdata->out_conns[i];
>>>>> +        if (csdev->type == CORESIGHT_DEV_TYPE_SOURCE)
>>>>> +            reset_filter_src(csdev, conn);
>>>>> +        if (conn->filter_src_fwnode) {
>>>>> +            conn->filter_src_dev = NULL;
>>>>> +            conn->filter_src_fwnode = NULL;
>>>>> +        }
>>>>> +
>>>>>           if (!conn->dest_dev)
>>>>>               continue;
>>>>>   diff --git a/drivers/hwtracing/coresight/coresight-platform.c 
>>>>> b/drivers/hwtracing/coresight/coresight-platform.c
>>>>> index 64e171eaad82..b3c3e2361d07 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>>>> @@ -243,6 +243,24 @@ static int of_coresight_parse_endpoint(struct 
>>>>> device *dev,
>>>>>           conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
>>>>>           conn.dest_port = rendpoint.port;
>>>>>   +        /*
>>>>> +         * Get the firmware node of the filter source through the
>>>>> +         * reference. This could be used to filter the source in
>>>>> +         * building path.
>>>>> +         */
>>>>> +        conn.filter_src_fwnode =
>>>>> +            fwnode_find_reference(&ep->fwnode, "filter-src", 0);
>>>>> +        if (IS_ERR(conn.filter_src_fwnode))
>>>>> +            conn.filter_src_fwnode = NULL;
>>>>> +        else {
>>>>> +            conn.filter_src_dev =
>>>>> + coresight_find_csdev_by_fwnode(conn.filter_src_fwnode);
>>>>> +            if (conn.filter_src_dev && (conn.filter_src_dev->type
>>>>> +                != CORESIGHT_DEV_TYPE_SOURCE))
>>>>> +                dev_warn(&conn.filter_src_dev->dev,
>>>>> +                  "Filter source %s is not a source device\n");
>>>>> +        }
>>>>> +
>>>>>           new_conn = coresight_add_out_conn(dev, pdata, &conn);
>>>>>           if (IS_ERR_VALUE(new_conn)) {
>>>>>               fwnode_handle_put(conn.dest_fwnode);
>>>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>>>> index f09ace92176e..91a689b4514b 100644
>>>>> --- a/include/linux/coresight.h
>>>>> +++ b/include/linux/coresight.h
>>>>> @@ -172,6 +172,9 @@ struct coresight_desc {
>>>>>    * @dest_dev:    a @coresight_device representation of the component
>>>>>           connected to @src_port. NULL until the device is created
>>>>>    * @link: Representation of the connection as a sysfs link.
>>>>> + * @filter_src_fwnode: filter source component's fwnode handle.
>>>>> + * @filter_src_dev: a @coresight_device representation of the 
>>>>> component that
>>>>> +        needs to be filtered.
>>>>>    *
>>>>>    * The full connection structure looks like this, where in_conns 
>>>>> store
>>>>>    * references to same connection as the source device's out_conns.
>>>>> @@ -200,6 +203,8 @@ struct coresight_connection {
>>>>>       struct coresight_device *dest_dev;
>>>>>       struct coresight_sysfs_link *link;
>>>>>       struct coresight_device *src_dev;
>>>>> +    struct fwnode_handle *filter_src_fwnode;
>>>>> +    struct coresight_device *filter_src_dev;
>>>>>       atomic_t src_refcnt;
>>>>>       atomic_t dest_refcnt;
>>>>>   };
>>>>
>>


