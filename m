Return-Path: <linux-kernel+bounces-561129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02386A60DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3751E3BF070
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2B1F1303;
	Fri, 14 Mar 2025 09:50:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F11F03D7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945834; cv=none; b=gVmMo2EUC2/yHnMhwdAxV6g1JkuewyRpZd/EMpXEGNHLlu+IbRJ+wF42lx26JA3Sua9UrBzdzO5fHcKwZCn3GkGdHzsW41V7cvGFnOOvFE4WAMamPC5DxtaAW3VI/GO4XaX9Ni5pWLSroMBFbb/q1bAfolP1Cjihq7zfEYYUSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945834; c=relaxed/simple;
	bh=Fjh4WGy5Avl80FtyEltlDbLTV0V82itJKpilur9g2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUL4FBKhKnGjkiEcs17bM3Veh6bQOD5FxM+SQlig5rmqi72YrmdW9uXPRzGar3PZ4f/f+MFF8H5653526gC0eNHjAZxorUza5E6bH2+AS6uO5NNm6JCs4TlS0FPEnisPGcjl2LSRoepMLZsJPwCNXHH4p3EvdtfxHbC2sSSruns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2181424;
	Fri, 14 Mar 2025 02:50:41 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8585C3F5A1;
	Fri, 14 Mar 2025 02:50:30 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:50:25 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/7] coresight: Remove inlines from static function
 definitions
Message-ID: <20250314095025.GW9682@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-7-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103945.967495-7-james.clark@linaro.org>

On Tue, Feb 11, 2025 at 10:39:42AM +0000, James Clark wrote:
> 
> These are all static and in one compilation unit so the inline has no
> effect on the binary.

I read the doc coding-style.rst, the section "15) The inline disease",
my understanding is though the inline is not encouraged, I prefer we can
follow up the rule:

  A reasonable rule of thumb is to not put inline at functions that have more
  than 3 lines of code in them. An exception to this rule are the cases where
  a parameter is known to be a compile time constant, and as a result of this
  constantness you *know* the compiler will be able to optimize most of your
  function away at compile time. For a good example of this later case, see
  the kmalloc() inline function.

> Except if FTRACE is enabled, then some functions
> which were already not inlined now get the nops added which allows them
> to be traced.

I understand it is a side effect that we cannot use function tracer for
inline functions.  This is not a big issue for me, as we still can use
"perf probe" and trace_printk() for debugging.

Thanks,
Leo

> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  | 11 ++++----
>  drivers/hwtracing/coresight/coresight-core.c  | 16 ++++++------
>  drivers/hwtracing/coresight/coresight-etb10.c |  2 +-
>  .../coresight/coresight-etm4x-core.c          |  8 +++---
>  .../coresight/coresight-etm4x-sysfs.c         |  4 +--
>  .../hwtracing/coresight/coresight-platform.c  | 26 +++++++++----------
>  .../coresight/coresight-replicator.c          |  2 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |  6 ++---
>  .../coresight/coresight-syscfg-configfs.c     |  2 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |  8 +++---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 16 +++++-------
>  drivers/hwtracing/coresight/coresight-trbe.c  | 18 ++++++-------
>  12 files changed, 58 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 575c2d247a90..ffa08ea3c296 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -113,9 +113,8 @@ typedef u64 cate_t;
>   * containing the data page pointer for @offset. If @daddrp is not NULL,
>   * @daddrp points the DMA address of the beginning of the table.
>   */
> -static inline cate_t *catu_get_table(struct tmc_sg_table *catu_table,
> -                                    unsigned long offset,
> -                                    dma_addr_t *daddrp)
> +static cate_t *catu_get_table(struct tmc_sg_table *catu_table, unsigned long offset,
> +                             dma_addr_t *daddrp)
>  {
>         unsigned long buf_size = tmc_sg_table_buf_size(catu_table);
>         unsigned int table_nr, pg_idx, pg_offset;
> @@ -165,12 +164,12 @@ static void catu_dump_table(struct tmc_sg_table *catu_table)
>  }
> 
>  #else
> -static inline void catu_dump_table(struct tmc_sg_table *catu_table)
> +static void catu_dump_table(struct tmc_sg_table *catu_table)
>  {
>  }
>  #endif
> 
> -static inline cate_t catu_make_entry(dma_addr_t addr)
> +static cate_t catu_make_entry(dma_addr_t addr)
>  {
>         return addr ? CATU_VALID_ENTRY(addr) : 0;
>  }
> @@ -390,7 +389,7 @@ static const struct attribute_group *catu_groups[] = {
>  };
> 
> 
> -static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
> +static int catu_wait_for_ready(struct catu_drvdata *drvdata)
>  {
>         struct csdev_access *csa = &drvdata->csdev->access;
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 97f33ffad05e..396218819f26 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -127,20 +127,20 @@ coresight_find_out_connection(struct coresight_device *csdev,
>         return ERR_PTR(-ENODEV);
>  }
> 
> -static inline u32 coresight_read_claim_tags(struct csdev_access *csa)
> +static u32 coresight_read_claim_tags(struct csdev_access *csa)
>  {
>         return FIELD_GET(CORESIGHT_CLAIM_MASK,
>                          csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMCLR));
>  }
> 
> -static inline void coresight_set_self_claim_tag(struct csdev_access *csa)
> +static void coresight_set_self_claim_tag(struct csdev_access *csa)
>  {
>         csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>                                      CORESIGHT_CLAIMSET);
>         isb();
>  }
> 
> -static inline void coresight_clear_self_claim_tag(struct csdev_access *csa)
> +static void coresight_clear_self_claim_tag(struct csdev_access *csa)
>  {
>         csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>                                      CORESIGHT_CLAIMCLR);
> @@ -610,7 +610,7 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
>   * Return true in successful case and power up the device.
>   * Return false when failed to get reference of module.
>   */
> -static inline bool coresight_get_ref(struct coresight_device *csdev)
> +static bool coresight_get_ref(struct coresight_device *csdev)
>  {
>         struct device *dev = csdev->dev.parent;
> 
> @@ -629,7 +629,7 @@ static inline bool coresight_get_ref(struct coresight_device *csdev)
>   *
>   * @csdev: The coresight device to decrement a reference from.
>   */
> -static inline void coresight_put_ref(struct coresight_device *csdev)
> +static void coresight_put_ref(struct coresight_device *csdev)
>  {
>         struct device *dev = csdev->dev.parent;
> 
> @@ -808,7 +808,7 @@ void coresight_release_path(struct list_head *path)
>  }
> 
>  /* return true if the device is a suitable type for a default sink */
> -static inline bool coresight_is_def_sink_type(struct coresight_device *csdev)
> +static bool coresight_is_def_sink_type(struct coresight_device *csdev)
>  {
>         /* sink & correct subtype */
>         if (((csdev->type == CORESIGHT_DEV_TYPE_SINK) ||
> @@ -1362,8 +1362,8 @@ EXPORT_SYMBOL_GPL(coresight_unregister);
>   *
>   * Returns the index of the entry, when found. Otherwise, -ENOENT.
>   */
> -static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
> -                                             struct fwnode_handle *fwnode)
> +static int coresight_search_device_idx(struct coresight_dev_list *dict,
> +                                      struct fwnode_handle *fwnode)
>  {
>         int i;
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index b598b2c0c9bb..de6d3a6fb828 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -95,7 +95,7 @@ struct etb_drvdata {
>  static int etb_set_buffer(struct coresight_device *csdev,
>                           struct perf_output_handle *handle);
> 
> -static inline unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
> +static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>  {
>         return readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 3609bb74c4ec..9e7d423c1ae9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -84,7 +84,7 @@ static int etm4_probe_cpu(unsigned int cpu);
>   *             TRCIDR4.NUMPC > 0b0000 .
>   *             TRCSSCSR<n>.PC == 0b1
>   */
> -static inline bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
> +static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
>  {
>         return (n < drvdata->nr_ss_cmp) &&
>                drvdata->nr_pe &&
> @@ -185,7 +185,7 @@ static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
>         isb();
>  }
> 
> -static inline void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata,
> +static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata,
>                                       struct csdev_access *csa)
>  {
>         WARN_ON(drvdata->cpu != smp_processor_id());
> @@ -1035,7 +1035,7 @@ static const struct coresight_ops etm4_cs_ops = {
>         .source_ops     = &etm4_source_ops,
>  };
> 
> -static inline bool cpu_supports_sysreg_trace(void)
> +static bool cpu_supports_sysreg_trace(void)
>  {
>         u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> 
> @@ -1343,7 +1343,7 @@ static void etm4_init_arch_data(void *info)
>         cpu_detect_trace_filtering(drvdata);
>  }
> 
> -static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> +static u32 etm4_get_victlr_access_type(struct etmv4_config *config)
>  {
>         return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a9f19629f3f8..0465c32f7ed4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2440,7 +2440,7 @@ static u32 etmv4_cross_read(const struct etmv4_drvdata *drvdata, u32 offset)
>         return reg.data;
>  }
> 
> -static inline u32 coresight_etm4x_attr_to_offset(struct device_attribute *attr)
> +static u32 coresight_etm4x_attr_to_offset(struct device_attribute *attr)
>  {
>         struct dev_ext_attribute *eattr;
> 
> @@ -2464,7 +2464,7 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
>         return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
>  }
> 
> -static inline bool
> +static bool
>  etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
>  {
>         switch (offset) {
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 8192ba3279f0..0db64c5f4995 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -139,7 +139,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode)
>  EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
> 
>  #ifdef CONFIG_OF
> -static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
> +static bool of_coresight_legacy_ep_is_input(struct device_node *ep)
>  {
>         return of_property_read_bool(ep, "slave-mode");
>  }
> @@ -159,7 +159,7 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
>         return parent;
>  }
> 
> -static inline struct device_node *
> +static struct device_node *
>  of_coresight_get_output_ports_node(const struct device_node *node)
>  {
>         return of_get_child_by_name(node, "out-ports");
> @@ -327,14 +327,14 @@ static int of_get_coresight_platform_data(struct device *dev,
>         return 0;
>  }
>  #else
> -static inline int
> +static int
>  of_get_coresight_platform_data(struct device *dev,
>                                struct coresight_platform_data *pdata)
>  {
>         return -ENOENT;
>  }
> 
> -static inline int of_coresight_get_cpu(struct device *dev)
> +static int of_coresight_get_cpu(struct device *dev)
>  {
>         return -ENODEV;
>  }
> @@ -356,7 +356,7 @@ static const guid_t coresight_graph_uuid = GUID_INIT(0x3ecbc8b6, 0x1d0e, 0x4fb3,
>  #define ACPI_CORESIGHT_LINK_SLAVE      0
>  #define ACPI_CORESIGHT_LINK_MASTER     1
> 
> -static inline bool is_acpi_guid(const union acpi_object *obj)
> +static bool is_acpi_guid(const union acpi_object *obj)
>  {
>         return (obj->type == ACPI_TYPE_BUFFER) && (obj->buffer.length == 16);
>  }
> @@ -365,24 +365,24 @@ static inline bool is_acpi_guid(const union acpi_object *obj)
>   * acpi_guid_matches   - Checks if the given object is a GUID object and
>   * that it matches the supplied the GUID.
>   */
> -static inline bool acpi_guid_matches(const union acpi_object *obj,
> +static bool acpi_guid_matches(const union acpi_object *obj,
>                                    const guid_t *guid)
>  {
>         return is_acpi_guid(obj) &&
>                guid_equal((guid_t *)obj->buffer.pointer, guid);
>  }
> 
> -static inline bool is_acpi_dsd_graph_guid(const union acpi_object *obj)
> +static bool is_acpi_dsd_graph_guid(const union acpi_object *obj)
>  {
>         return acpi_guid_matches(obj, &acpi_graph_uuid);
>  }
> 
> -static inline bool is_acpi_coresight_graph_guid(const union acpi_object *obj)
> +static bool is_acpi_coresight_graph_guid(const union acpi_object *obj)
>  {
>         return acpi_guid_matches(obj, &coresight_graph_uuid);
>  }
> 
> -static inline bool is_acpi_coresight_graph(const union acpi_object *obj)
> +static bool is_acpi_coresight_graph(const union acpi_object *obj)
>  {
>         const union acpi_object *graphid, *guid, *links;
> 
> @@ -469,7 +469,7 @@ static inline bool is_acpi_coresight_graph(const union acpi_object *obj)
>   *     }, // End of ACPI Graph Property
>   *  })
>   */
> -static inline bool acpi_validate_dsd_graph(const union acpi_object *graph)
> +static bool acpi_validate_dsd_graph(const union acpi_object *graph)
>  {
>         int i, n;
>         const union acpi_object *rev, *nr_graphs;
> @@ -553,7 +553,7 @@ acpi_get_dsd_graph(struct acpi_device *adev, struct acpi_buffer *buf)
>         return NULL;
>  }
> 
> -static inline bool
> +static bool
>  acpi_validate_coresight_graph(const union acpi_object *cs_graph)
>  {
>         int nlinks;
> @@ -794,14 +794,14 @@ acpi_get_coresight_platform_data(struct device *dev,
> 
>  #else
> 
> -static inline int
> +static int
>  acpi_get_coresight_platform_data(struct device *dev,
>                                  struct coresight_platform_data *pdata)
>  {
>         return -ENOENT;
>  }
> 
> -static inline int acpi_coresight_get_cpu(struct device *dev)
> +static int acpi_coresight_get_cpu(struct device *dev)
>  {
>         return -ENODEV;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 679a36effbe8..9f27374f1310 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -63,7 +63,7 @@ static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
>  /*
>   * replicator_reset : Reset the replicator configuration to sane values.
>   */
> -static inline void replicator_reset(struct replicator_drvdata *drvdata)
> +static void replicator_reset(struct replicator_drvdata *drvdata)
>  {
>         if (drvdata->base)
>                 dynamic_replicator_reset(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index b581a30a1cd9..5decc87d1fba 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -290,7 +290,7 @@ static const struct coresight_ops stm_cs_ops = {
>         .source_ops     = &stm_source_ops,
>  };
> 
> -static inline bool stm_addr_unaligned(const void *addr, u8 write_bytes)
> +static bool stm_addr_unaligned(const void *addr, u8 write_bytes)
>  {
>         return ((unsigned long)addr & (write_bytes - 1));
>  }
> @@ -674,7 +674,7 @@ static int of_stm_get_stimulus_area(struct device *dev, struct resource *res)
>         return of_address_to_resource(np, index, res);
>  }
>  #else
> -static inline int of_stm_get_stimulus_area(struct device *dev,
> +static int of_stm_get_stimulus_area(struct device *dev,
>                                            struct resource *res)
>  {
>         return -ENOENT;
> @@ -718,7 +718,7 @@ static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
>         return rc;
>  }
>  #else
> -static inline int acpi_stm_get_stimulus_area(struct device *dev,
> +static int acpi_stm_get_stimulus_area(struct device *dev,
>                                              struct resource *res)
>  {
>         return -ENOENT;
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> index 213b4159b062..2b40e556be87 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> @@ -10,7 +10,7 @@
>  #include "coresight-syscfg-configfs.h"
> 
>  /* create a default ci_type. */
> -static inline struct config_item_type *cscfg_create_ci_type(void)
> +static struct config_item_type *cscfg_create_ci_type(void)
>  {
>         struct config_item_type *ci_type;
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 5ac4e3c706ac..2e3354b5c5c7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -164,8 +164,8 @@ static int tmc_open(struct inode *inode, struct file *file)
>         return 0;
>  }
> 
> -static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
> -                                         loff_t pos, size_t len, char **bufpp)
> +static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
> +                                  char **bufpp)
>  {
>         switch (drvdata->config_type) {
>         case TMC_CONFIG_TYPE_ETB:
> @@ -359,7 +359,7 @@ static const struct attribute_group *coresight_etr_groups[] = {
>         NULL,
>  };
> 
> -static inline bool tmc_etr_can_use_sg(struct device *dev)
> +static bool tmc_etr_can_use_sg(struct device *dev)
>  {
>         int ret;
>         u8 val_u8;
> @@ -389,7 +389,7 @@ static inline bool tmc_etr_can_use_sg(struct device *dev)
>         return false;
>  }
> 
> -static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
> +static bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
>  {
>         u32 auth = readl_relaxed(drvdata->base + TMC_AUTHSTATUS);
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 7ba4f79191de..0d4e3af0d4b5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -124,7 +124,7 @@ struct etr_sg_table {
>   * If we spill over to a new page for mapping 1 entry, we could as
>   * well replace the link entry of the previous page with the last entry.
>   */
> -static inline unsigned long __attribute_const__
> +static unsigned long __attribute_const__
>  tmc_etr_sg_table_entries(int nr_pages)
>  {
>         unsigned long nr_sgpages = nr_pages * ETR_SG_PAGES_PER_SYSPAGE;
> @@ -238,13 +238,13 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
>         return -ENOMEM;
>  }
> 
> -static inline long
> +static long
>  tmc_sg_get_data_page_offset(struct tmc_sg_table *sg_table, dma_addr_t addr)
>  {
>         return tmc_pages_get_offset(&sg_table->data_pages, addr);
>  }
> 
> -static inline void tmc_free_table_pages(struct tmc_sg_table *sg_table)
> +static void tmc_free_table_pages(struct tmc_sg_table *sg_table)
>  {
>         if (sg_table->table_vaddr)
>                 vunmap(sg_table->table_vaddr);
> @@ -480,7 +480,7 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
>         dev_dbg(sg_table->dev, "******* End of Table *****\n");
>  }
>  #else
> -static inline void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table) {}
> +static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table) {}
>  #endif
> 
>  /*
> @@ -815,10 +815,8 @@ void tmc_etr_remove_catu_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(tmc_etr_remove_catu_ops);
> 
> -static inline int tmc_etr_mode_alloc_buf(int mode,
> -                                        struct tmc_drvdata *drvdata,
> -                                        struct etr_buf *etr_buf, int node,
> -                                        void **pages)
> +static int tmc_etr_mode_alloc_buf(int mode, struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
> +                                 int node, void **pages)
>  {
>         int rc = -EINVAL;
> 
> @@ -936,7 +934,7 @@ static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
>         return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
>  }
> 
> -static inline s64
> +static s64
>  tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
>  {
>         ssize_t len;
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 919804b12a67..e9a19ef52359 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -159,22 +159,22 @@ static void trbe_check_errata(struct trbe_cpudata *cpudata)
>         }
>  }
> 
> -static inline bool trbe_has_erratum(struct trbe_cpudata *cpudata, int i)
> +static bool trbe_has_erratum(struct trbe_cpudata *cpudata, int i)
>  {
>         return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
>  }
> 
> -static inline bool trbe_may_overwrite_in_fill_mode(struct trbe_cpudata *cpudata)
> +static bool trbe_may_overwrite_in_fill_mode(struct trbe_cpudata *cpudata)
>  {
>         return trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE);
>  }
> 
> -static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
> +static bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
>  {
>         return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
>  }
> 
> -static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
> +static bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
>  {
>         /*
>          * Errata affected TRBE implementation will need TSB CSYNC and
> @@ -184,7 +184,7 @@ static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
>         return trbe_has_erratum(cpudata, TRBE_NEEDS_DRAIN_AFTER_DISABLE);
>  }
> 
> -static inline bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudata)
> +static bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudata)
>  {
>         /*
>          * Errata affected TRBE implementation will need an additional
> @@ -195,7 +195,7 @@ static inline bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudat
>         return trbe_has_erratum(cpudata, TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE);
>  }
> 
> -static inline bool trbe_is_broken(struct trbe_cpudata *cpudata)
> +static bool trbe_is_broken(struct trbe_cpudata *cpudata)
>  {
>         return trbe_has_erratum(cpudata, TRBE_IS_BROKEN);
>  }
> @@ -207,13 +207,13 @@ static int trbe_alloc_node(struct perf_event *event)
>         return cpu_to_node(event->cpu);
>  }
> 
> -static inline void trbe_drain_buffer(void)
> +static void trbe_drain_buffer(void)
>  {
>         tsb_csync();
>         dsb(nsh);
>  }
> 
> -static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
> +static void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
>  {
>         /*
>          * Enable the TRBE without clearing LIMITPTR which
> @@ -229,7 +229,7 @@ static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
>                 isb();
>  }
> 
> -static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
> +static void set_trbe_disabled(struct trbe_cpudata *cpudata)
>  {
>         u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
> 
> --
> 2.34.1
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

