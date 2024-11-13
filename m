Return-Path: <linux-kernel+bounces-407694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D431B9C7132
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E571F21C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F72010ED;
	Wed, 13 Nov 2024 13:39:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE81EF928;
	Wed, 13 Nov 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505191; cv=none; b=T6Xn71MH2Fp6e810gYHNSmWjMJJKh2xMBqdlgOPIvY0rxMFSxEg6Zso3skELWbzaHYkXuMh5EZJaIfwh7UXsyanCgOKNYimxjVmjFjznuv17AW/NMltz1szIOBBYbYrd/VjIMu3AfKQ8LaZqVsDrsKHYRYM/IyXX81cVm7qmO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505191; c=relaxed/simple;
	bh=G21VfQ3dypg5rSWh5jpjw0azkpdBpYoiY2TqjUvJwGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIHsfstgJXnD1dw2gBE3tZ/xxYqAeRUksOzo+SJULozBshFQBUsRS4zShFpj1CTF8PQ28CZRtwORtEaLyBmJej3EAigk0q8RlrSEzS8NlTAogC+wI0zORE5kYz9wX6QOlFkrQiTrfl14buRTXco/VaDYEtYzdw0qUeWIHnGnyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF29D1655;
	Wed, 13 Nov 2024 05:40:17 -0800 (PST)
Received: from [10.1.29.78] (Suzukis-MBP.cambridge.arm.com [10.1.29.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79E353F66E;
	Wed, 13 Nov 2024 05:39:45 -0800 (PST)
Message-ID: <c39a844e-d0a8-46ac-ab52-530dae741751@arm.com>
Date: Wed, 13 Nov 2024 13:39:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] coresight: Add support for trace filtering by
 source
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
References: <20241030093255.26915-1-quic_taozha@quicinc.com>
 <20241030093255.26915-4-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241030093255.26915-4-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2024 09:32, Tao Zhang wrote:
> Some replicators have hard coded filtering of "trace" data, based on the
> source device. This is different from the trace filtering based on
> TraceID, available in the standard programmable replicators. e.g.,
> Qualcomm replicators have filtering based on custom trace protocol
> format and is not programmable.
> 
> The source device could be connected to the replicator via intermediate
> components (e.g., a funnel). Thus we need platform information from
> the firmware tables to decide the source device corresponding to a
> given output port from the replicator. Given this affects "trace
> path building" and traversing the path back from the sink to source,
> add the concept of "filtering by source" to the generic coresight
> connection.
> 
> The specified source will be marked like below in the Devicetree.
> test-replicator {
>      ... ... ... ...
>      out-ports {
>          ... ... ... ...
>          port@0 {
>              reg = <0>;
>              xyz: endpoint {
>                  remote-endpoint = <&zyx>;
>                  filter-source = <&source_1>; <-- To specify the source to
>              };                           be filtered out here.
>          };
> 
>          port@1 {
>              reg = <1>;
>              abc: endpoint {
>                  remote-endpoint = <&cba>;
>                  filter-source = <&source_2>; <-- To specify the source to
>              };                           be filtered out here.
>          };
>      };
> };
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 113 +++++++++++++++---
>   .../hwtracing/coresight/coresight-platform.c  |  18 +++
>   include/linux/coresight.h                     |   5 +
>   3 files changed, 117 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ea38ecf26fcb..0a9380350fb5 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -75,22 +75,54 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
>   }
>   EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>   
> +static struct coresight_device *coresight_get_source(struct list_head *path)
> +{
> +	struct coresight_device *csdev;
> +
> +	if (!path)
> +		return NULL;
> +
> +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> +	if (!coresight_is_device_source(csdev))
> +		return NULL;
> +
> +	return csdev;
> +}
> +
> +/**
> + * coresight_blocks_source - checks whether the connection matches the source
> + * of path if connection is bound to specific source.
> + * @src:	The source device of the trace path
> + * @conn:	The connection of one outport
> + *
> + * Return false if the connection doesn't have a source binded or source of the
> + * path matches the source binds to connection.
> + */
> +static bool coresight_blocks_source(struct coresight_device *src,
> +				    struct coresight_connection *conn)
> +{
> +	return conn->filter_src_fwnode && (conn->filter_src_dev != src);
> +}
> +
>   static struct coresight_connection *
> -coresight_find_out_connection(struct coresight_device *src_dev,
> -			      struct coresight_device *dest_dev)
> +coresight_find_out_connection(struct coresight_device *csdev,
> +			      struct coresight_device *out_dev,
> +			      struct coresight_device *trace_src)
>   {
>   	int i;
>   	struct coresight_connection *conn;
>   
> -	for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
> -		conn = src_dev->pdata->out_conns[i];
> -		if (conn->dest_dev == dest_dev)
> +	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> +		conn = csdev->pdata->out_conns[i];
> +		if (coresight_blocks_source(trace_src, conn))
> +			continue;
> +		if (conn->dest_dev == out_dev)
>   			return conn;
>   	}
>   
> -	dev_err(&src_dev->dev,
> -		"couldn't find output connection, src_dev: %s, dest_dev: %s\n",
> -		dev_name(&src_dev->dev), dev_name(&dest_dev->dev));
> +	dev_err(&csdev->dev,
> +		"couldn't find output connection, csdev: %s, out_dev: %s\n",
> +		dev_name(&csdev->dev), dev_name(&out_dev->dev));
>   
>   	return ERR_PTR(-ENODEV);
>   }
> @@ -251,7 +283,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>   
>   static int coresight_enable_link(struct coresight_device *csdev,
>   				 struct coresight_device *parent,
> -				 struct coresight_device *child)
> +				 struct coresight_device *child,
> +				 struct coresight_device *source)
>   {
>   	int link_subtype;
>   	struct coresight_connection *inconn, *outconn;
> @@ -259,8 +292,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   	if (!parent || !child)
>   		return -EINVAL;
>   
> -	inconn = coresight_find_out_connection(parent, csdev);
> -	outconn = coresight_find_out_connection(csdev, child);
> +	inconn = coresight_find_out_connection(parent, csdev, source);
> +	outconn = coresight_find_out_connection(csdev, child, source);
>   	link_subtype = csdev->subtype.link_subtype;
>   
>   	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && IS_ERR(inconn))
> @@ -273,15 +306,16 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   
>   static void coresight_disable_link(struct coresight_device *csdev,
>   				   struct coresight_device *parent,
> -				   struct coresight_device *child)
> +				   struct coresight_device *child,
> +				   struct coresight_device *source)
>   {
>   	struct coresight_connection *inconn, *outconn;
>   
>   	if (!parent || !child)
>   		return;
>   
> -	inconn = coresight_find_out_connection(parent, csdev);
> -	outconn = coresight_find_out_connection(csdev, child);
> +	inconn = coresight_find_out_connection(parent, csdev, source);
> +	outconn = coresight_find_out_connection(csdev, child, source);
>   
>   	link_ops(csdev)->disable(csdev, inconn, outconn);
>   }
> @@ -375,7 +409,8 @@ static void coresight_disable_path_from(struct list_head *path,
>   		case CORESIGHT_DEV_TYPE_LINK:
>   			parent = list_prev_entry(nd, link)->csdev;
>   			child = list_next_entry(nd, link)->csdev;
> -			coresight_disable_link(csdev, parent, child);
> +			coresight_disable_link(csdev, parent, child,
> +					       coresight_get_source(path));
>   			break;
>   		default:
>   			break;
> @@ -418,7 +453,9 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
>   	u32 type;
>   	struct coresight_node *nd;
>   	struct coresight_device *csdev, *parent, *child;
> +	struct coresight_device *source;
>   
> +	source = coresight_get_source(path);
>   	list_for_each_entry_reverse(nd, path, link) {
>   		csdev = nd->csdev;
>   		type = csdev->type;
> @@ -456,7 +493,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
>   		case CORESIGHT_DEV_TYPE_LINK:
>   			parent = list_prev_entry(nd, link)->csdev;
>   			child = list_next_entry(nd, link)->csdev;
> -			ret = coresight_enable_link(csdev, parent, child);
> +			ret = coresight_enable_link(csdev, parent, child, source);
>   			if (ret)
>   				goto err;
>   			break;
> @@ -619,6 +656,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
>   /**
>    * _coresight_build_path - recursively build a path from a @csdev to a sink.
>    * @csdev:	The device to start from.
> + * @source:	The trace source device of the path.
>    * @sink:	The final sink we want in this path.
>    * @path:	The list to add devices to.
>    *
> @@ -628,6 +666,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
>    * the source is the first device and the sink the last one.
>    */
>   static int _coresight_build_path(struct coresight_device *csdev,
> +				 struct coresight_device *source,
>   				 struct coresight_device *sink,
>   				 struct list_head *path)
>   {
> @@ -641,7 +680,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   
>   	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
>   	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> -		if (_coresight_build_path(sink, sink, path) == 0) {
> +		if (_coresight_build_path(sink, source, sink, path) == 0) {
>   			found = true;
>   			goto out;
>   		}
> @@ -652,8 +691,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   		struct coresight_device *child_dev;
>   
>   		child_dev = csdev->pdata->out_conns[i]->dest_dev;
> +
> +		if (coresight_blocks_source(source, csdev->pdata->out_conns[i]))
> +			continue;
> +
>   		if (child_dev &&
> -		    _coresight_build_path(child_dev, sink, path) == 0) {
> +		    _coresight_build_path(child_dev, source, sink, path) == 0) {
>   			found = true;
>   			break;
>   		}
> @@ -698,7 +741,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
>   
>   	INIT_LIST_HEAD(path);
>   
> -	rc = _coresight_build_path(source, sink, path);
> +	rc = _coresight_build_path(source, source, sink, path);
>   	if (rc) {
>   		kfree(path);
>   		return ERR_PTR(rc);
> @@ -927,6 +970,16 @@ static int coresight_orphan_match(struct device *dev, void *data)
>   	for (i = 0; i < src_csdev->pdata->nr_outconns; i++) {
>   		conn = src_csdev->pdata->out_conns[i];
>   
> +		/* Fix filter source device before skip the port */
> +		if (conn->filter_src_fwnode && !conn->filter_src_dev) {
> +			if (dst_csdev &&
> +			    (conn->filter_src_fwnode == dst_csdev->dev.fwnode) &&
> +			    !WARN_ON_ONCE(!coresight_is_device_source(dst_csdev)))
> +				conn->filter_src_dev = dst_csdev;
> +			else
> +				still_orphan = true;
> +		}
> +
>   		/* Skip the port if it's already connected. */
>   		if (conn->dest_dev)
>   			continue;
> @@ -977,18 +1030,40 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>   			 csdev, coresight_orphan_match);
>   }
>   
> +static int coresight_clear_filter_source(struct device *dev, void *data)
> +{
> +	int i;
> +	struct coresight_device *source = data;
> +	struct coresight_device *csdev = to_coresight_device(dev);
> +
> +	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
> +		if (csdev->pdata->out_conns[i]->filter_src_dev == source)
> +			csdev->pdata->out_conns[i]->filter_src_dev = NULL;
> +	}
> +	return 0;
> +}
> +
>   /* coresight_remove_conns - Remove other device's references to this device */
>   static void coresight_remove_conns(struct coresight_device *csdev)
>   {
>   	int i, j;
>   	struct coresight_connection *conn;
>   
> +	if (coresight_is_device_source(csdev))
> +		bus_for_each_dev(&coresight_bustype, NULL, csdev,
> +				 coresight_clear_filter_source);
> +
>   	/*
>   	 * Remove the input connection references from the destination device
>   	 * for each output connection.
>   	 */
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>   		conn = csdev->pdata->out_conns[i];
> +		if (conn->filter_src_fwnode) {
> +			conn->filter_src_dev = NULL;
> +			fwnode_handle_put(conn->filter_src_fwnode);
> +		}
> +
>   		if (!conn->dest_dev)
>   			continue;
>   
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 64e171eaad82..d5532caa9e92 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -243,6 +243,24 @@ static int of_coresight_parse_endpoint(struct device *dev,
>   		conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
>   		conn.dest_port = rendpoint.port;
>   
> +		/*
> +		 * Get the firmware node of the filter source through the
> +		 * reference. This could be used to filter the source in
> +		 * building path.
> +		 */
> +		conn.filter_src_fwnode =
> +			fwnode_find_reference(&ep->fwnode, "filter-source", 0);
> +		if (IS_ERR(conn.filter_src_fwnode)) {
> +			conn.filter_src_fwnode = NULL;
> +		} else {
> +			conn.filter_src_dev =
> +			 coresight_find_csdev_by_fwnode(conn.filter_src_fwnode);
> +			if (conn.filter_src_dev &&
> +			    !coresight_is_device_source(conn.filter_src_dev))
> +				dev_warn(&conn.filter_src_dev->dev,
> +				  "Filter source is not a source device\n");

Do we need to reset the conn.filter_src_fwnode ? Otherwise, we can warn 
from other places too.

Suzuki

> +		}
> +
>   		new_conn = coresight_add_out_conn(dev, pdata, &conn);
>   		if (IS_ERR_VALUE(new_conn)) {
>   			fwnode_handle_put(conn.dest_fwnode);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 9311df8538fc..f372c01ae2fc 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -172,6 +172,9 @@ struct coresight_desc {
>    * @dest_dev:	a @coresight_device representation of the component
>   		connected to @src_port. NULL until the device is created
>    * @link: Representation of the connection as a sysfs link.
> + * @filter_src_fwnode: filter source component's fwnode handle.
> + * @filter_src_dev: a @coresight_device representation of the component that
> +		needs to be filtered.
>    *
>    * The full connection structure looks like this, where in_conns store
>    * references to same connection as the source device's out_conns.
> @@ -200,6 +203,8 @@ struct coresight_connection {
>   	struct coresight_device *dest_dev;
>   	struct coresight_sysfs_link *link;
>   	struct coresight_device *src_dev;
> +	struct fwnode_handle *filter_src_fwnode;
> +	struct coresight_device *filter_src_dev;
>   	atomic_t src_refcnt;
>   	atomic_t dest_refcnt;
>   };


