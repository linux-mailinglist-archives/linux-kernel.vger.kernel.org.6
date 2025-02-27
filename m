Return-Path: <linux-kernel+bounces-536525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E0A480AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E73A83D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75153241122;
	Thu, 27 Feb 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPf++0cB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EF23956C;
	Thu, 27 Feb 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665226; cv=none; b=sxOgOR0MssMRd/1deSyBtm7DfoLF7fTVyIEtKfVIu2gUPU+JcTRc5ANwbjwTNk+c1HKENRAwQgqHTMH614Y1ssoyo1dNQC4NPJ+9YP+sJRqOxSJEE6v5YO8f7Snx5ScFyktunNV9psh1rtGBNw+dAmuf7VDgOdFpPnnPmCZZcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665226; c=relaxed/simple;
	bh=aZ/wfYW40kf39dWziDGQBG+eoTRMMGe67G2StdFSFlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eppxl+4aML6dvF417IsX8ByskCO6sdXrXxVt1S8zfrYKJWo9HxZb2WJJR3IouPmPuPAZyNt+oK02ezGxyKHBobhWmf0fbfOxXStL7nWc6EJYw6sIPT157Mvcef11m132wIKWOkBnwtO2LWg+ZvO0KKTOMKL3pYrRW2EPSzfzHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPf++0cB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665223; x=1772201223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZ/wfYW40kf39dWziDGQBG+eoTRMMGe67G2StdFSFlc=;
  b=VPf++0cB+z3p9VvcIviG08x02AUq+lYoEh2OBk/E94uTToeFapk0GzkA
   A+avT13knhK/xZADcn4kzCr164ZLvcmyb2TK/sbl6joZCDtefXMG87Zz6
   aIhoShejU2+wNoAwB8kSpkn7LUZ9osdZonx78YsO4832T++m3kOl/8zN5
   YLpLXiu4x9gWbdLLxihmhDkFn+kwsSoJNNx+YWBT5jfkslC1JRaBTqgyc
   mHc2h6NSoQv+wtjmqjTpBcou2T1bJHS4QtxkTSsMhdZ2qiXgLLyFDbTTT
   B+jRPtr/5xWXtYIL4seJZhhgIkk1ZOCYyycye/qOH5IAz4QdwOCkEcryo
   g==;
X-CSE-ConnectionGUID: Z52cBBkoRuGUweiDl3TrRA==
X-CSE-MsgGUID: KBpS3td3TWa5UjDCEVdCug==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438068"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438068"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:47 -0800
X-CSE-ConnectionGUID: zFsvM03XTzyevXLYwuOjNA==
X-CSE-MsgGUID: QKStvFEVRxCfKdmmup0qfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831654"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:44 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 09/16] soundwire: cadence: add BTP/BRA helpers to format data
Date: Thu, 27 Feb 2025 22:06:08 +0800
Message-ID: <20250227140615.8147-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

The Cadence IP expects a specific format (detailed in the
Documentation). Add helpers to copy the data into the DMA buffer.

The crc8 table is for now only used by the Cadence driver. This table
might be moved to a common module at a later point if needed by other
controller implementations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/Kconfig          |   1 +
 drivers/soundwire/cadence_master.c | 634 +++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  20 +
 3 files changed, 655 insertions(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index f66f869dff2e..ad56393e4c93 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -31,6 +31,7 @@ config SOUNDWIRE_AMD
 
 config SOUNDWIRE_CADENCE
 	tristate
+	select CRC8
 
 config SOUNDWIRE_INTEL
 	tristate "Intel SoundWire Master driver"
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index b29929b59510..21bb491d026b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/cleanup.h>
+#include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
@@ -1976,5 +1977,638 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 }
 EXPORT_SYMBOL(sdw_cdns_alloc_pdi);
 
+/*
+ * the MIPI SoundWire CRC8 polynomial is X^8 + X^6 + X^3 + X^2 + 1, MSB first
+ * The value is (1)01001101 = 0x4D
+ *
+ * the table below was generated with
+ *
+ *	u8 crc8_lookup_table[CRC8_TABLE_SIZE];
+ *	crc8_populate_msb(crc8_lookup_table, SDW_CRC8_POLY);
+ *
+ */
+#define SDW_CRC8_SEED 0xFF
+#define SDW_CRC8_POLY 0x4D
+
+static const u8 sdw_crc8_lookup_msb[CRC8_TABLE_SIZE] = {
+	0x00, 0x4d, 0x9a, 0xd7, 0x79, 0x34, 0xe3, 0xae, /* 0 - 7 */
+	0xf2, 0xbf, 0x68, 0x25, 0x8b, 0xc6, 0x11, 0x5c, /* 8 -15 */
+	0xa9, 0xe4, 0x33, 0x7e, 0xd0, 0x9d, 0x4a, 0x07, /* 16 - 23 */
+	0x5b, 0x16, 0xc1, 0x8c, 0x22, 0x6f, 0xb8, 0xf5, /* 24 - 31 */
+	0x1f, 0x52, 0x85, 0xc8, 0x66, 0x2b, 0xfc, 0xb1, /* 32 - 39 */
+	0xed, 0xa0, 0x77, 0x3a, 0x94, 0xd9, 0x0e, 0x43, /* 40 - 47 */
+	0xb6, 0xfb, 0x2c, 0x61, 0xcf, 0x82, 0x55, 0x18, /* 48 - 55 */
+	0x44, 0x09, 0xde, 0x93, 0x3d, 0x70, 0xa7, 0xea, /* 56 - 63 */
+	0x3e, 0x73, 0xa4, 0xe9, 0x47, 0x0a, 0xdd, 0x90, /* 64 - 71 */
+	0xcc, 0x81, 0x56, 0x1b, 0xb5, 0xf8, 0x2f, 0x62, /* 72 - 79 */
+	0x97, 0xda, 0x0d, 0x40, 0xee, 0xa3, 0x74, 0x39, /* 80 - 87 */
+	0x65, 0x28, 0xff, 0xb2, 0x1c, 0x51, 0x86, 0xcb, /* 88 - 95 */
+	0x21, 0x6c, 0xbb, 0xf6, 0x58, 0x15, 0xc2, 0x8f, /* 96 - 103 */
+	0xd3, 0x9e, 0x49, 0x04, 0xaa, 0xe7, 0x30, 0x7d, /* 104 - 111 */
+	0x88, 0xc5, 0x12, 0x5f, 0xf1, 0xbc, 0x6b, 0x26, /* 112 - 119 */
+	0x7a, 0x37, 0xe0, 0xad, 0x03, 0x4e, 0x99, 0xd4, /* 120 - 127 */
+	0x7c, 0x31, 0xe6, 0xab, 0x05, 0x48, 0x9f, 0xd2, /* 128 - 135 */
+	0x8e, 0xc3, 0x14, 0x59, 0xf7, 0xba, 0x6d, 0x20, /* 136 - 143 */
+	0xd5, 0x98, 0x4f, 0x02, 0xac, 0xe1, 0x36, 0x7b, /* 144 - 151 */
+	0x27, 0x6a, 0xbd, 0xf0, 0x5e, 0x13, 0xc4, 0x89, /* 152 - 159 */
+	0x63, 0x2e, 0xf9, 0xb4, 0x1a, 0x57, 0x80, 0xcd, /* 160 - 167 */
+	0x91, 0xdc, 0x0b, 0x46, 0xe8, 0xa5, 0x72, 0x3f, /* 168 - 175 */
+	0xca, 0x87, 0x50, 0x1d, 0xb3, 0xfe, 0x29, 0x64, /* 176 - 183 */
+	0x38, 0x75, 0xa2, 0xef, 0x41, 0x0c, 0xdb, 0x96, /* 184 - 191 */
+	0x42, 0x0f, 0xd8, 0x95, 0x3b, 0x76, 0xa1, 0xec, /* 192 - 199 */
+	0xb0, 0xfd, 0x2a, 0x67, 0xc9, 0x84, 0x53, 0x1e, /* 200 - 207 */
+	0xeb, 0xa6, 0x71, 0x3c, 0x92, 0xdf, 0x08, 0x45, /* 208 - 215 */
+	0x19, 0x54, 0x83, 0xce, 0x60, 0x2d, 0xfa, 0xb7, /* 216 - 223 */
+	0x5d, 0x10, 0xc7, 0x8a, 0x24, 0x69, 0xbe, 0xf3, /* 224 - 231 */
+	0xaf, 0xe2, 0x35, 0x78, 0xd6, 0x9b, 0x4c, 0x01, /* 232 - 239 */
+	0xf4, 0xb9, 0x6e, 0x23, 0x8d, 0xc0, 0x17, 0x5a, /* 240 - 247 */
+	0x06, 0x4b, 0x9c, 0xd1, 0x7f, 0x32, 0xe5, 0xa8  /* 248 - 255 */
+};
+
+/* BPT/BRA helpers */
+
+#define SDW_CDNS_BRA_HDR			6 /* defined by MIPI */
+#define SDW_CDNS_BRA_HDR_CRC			1 /* defined by MIPI */
+#define SDW_CDNS_BRA_HDR_CRC_PAD		1 /* Cadence only */
+#define SDW_CDNS_BRA_HDR_RESP			1 /* defined by MIPI */
+#define SDW_CDNS_BRA_HDR_RESP_PAD		1 /* Cadence only */
+
+#define SDW_CDNS_BRA_DATA_PAD			1 /* Cadence only */
+#define SDW_CDNS_BRA_DATA_CRC			1 /* defined by MIPI */
+#define SDW_CDNS_BRA_DATA_CRC_PAD		1 /* Cadence only */
+
+#define SDW_CDNS_BRA_FOOTER_RESP		1 /* defined by MIPI */
+#define SDW_CDNS_BRA_FOOTER_RESP_PAD		1 /* Cadence only */
+
+#define SDW_CDNS_WRITE_PDI1_BUFFER_SIZE							\
+	((SDW_CDNS_BRA_HDR_RESP + SDW_CDNS_BRA_HDR_RESP_PAD +				\
+	 SDW_CDNS_BRA_FOOTER_RESP + SDW_CDNS_BRA_FOOTER_RESP_PAD) * 2)
+
+#define SDW_CDNS_READ_PDI0_BUFFER_SIZE							\
+	((SDW_CDNS_BRA_HDR + SDW_CDNS_BRA_HDR_CRC + SDW_CDNS_BRA_HDR_CRC_PAD) * 2)
+
+static unsigned int sdw_cdns_bra_actual_data_size(unsigned int allocated_bytes_per_frame)
+{
+	unsigned int total;
+
+	if (allocated_bytes_per_frame < (SDW_CDNS_BRA_HDR + SDW_CDNS_BRA_HDR_CRC +
+					 SDW_CDNS_BRA_HDR_RESP + SDW_CDNS_BRA_DATA_CRC +
+					 SDW_CDNS_BRA_FOOTER_RESP))
+		return 0;
+
+	total = allocated_bytes_per_frame - SDW_CDNS_BRA_HDR - SDW_CDNS_BRA_HDR_CRC -
+		SDW_CDNS_BRA_HDR_RESP - SDW_CDNS_BRA_DATA_CRC - SDW_CDNS_BRA_FOOTER_RESP;
+
+	return total;
+}
+
+static unsigned int sdw_cdns_write_pdi0_buffer_size(unsigned int actual_data_size)
+{
+	unsigned int total;
+
+	total = SDW_CDNS_BRA_HDR + SDW_CDNS_BRA_HDR_CRC + SDW_CDNS_BRA_HDR_CRC_PAD;
+
+	total += actual_data_size;
+	if (actual_data_size & 1)
+		total += SDW_CDNS_BRA_DATA_PAD;
+
+	total += SDW_CDNS_BRA_DATA_CRC + SDW_CDNS_BRA_DATA_CRC_PAD;
+
+	return total * 2;
+}
+
+static unsigned int sdw_cdns_read_pdi1_buffer_size(unsigned int actual_data_size)
+{
+	unsigned int total;
+
+	total = SDW_CDNS_BRA_HDR_RESP + SDW_CDNS_BRA_HDR_RESP_PAD;
+
+	total += actual_data_size;
+	if (actual_data_size & 1)
+		total += SDW_CDNS_BRA_DATA_PAD;
+
+	total += SDW_CDNS_BRA_HDR_CRC +	SDW_CDNS_BRA_HDR_CRC_PAD;
+
+	total += SDW_CDNS_BRA_FOOTER_RESP + SDW_CDNS_BRA_FOOTER_RESP_PAD;
+
+	return total * 2;
+}
+
+int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
+				   int row, int col, unsigned int data_bytes,
+				   unsigned int requested_bytes_per_frame,
+				   unsigned int *data_per_frame, unsigned int *pdi0_buffer_size,
+				   unsigned int *pdi1_buffer_size, unsigned int *num_frames)
+{
+	unsigned int bpt_bits = row * (col - 1);
+	unsigned int bpt_bytes = bpt_bits >> 3;
+	unsigned int actual_bpt_bytes;
+	unsigned int pdi0_tx_size;
+	unsigned int pdi1_rx_size;
+	unsigned int remainder;
+
+	if (!data_bytes)
+		return -EINVAL;
+
+	actual_bpt_bytes = sdw_cdns_bra_actual_data_size(bpt_bytes);
+	if (!actual_bpt_bytes)
+		return -EINVAL;
+
+	if (data_bytes < actual_bpt_bytes)
+		actual_bpt_bytes = data_bytes;
+
+	/*
+	 * the caller may want to set the number of bytes per frame,
+	 * allow when possible
+	 */
+	if (requested_bytes_per_frame < actual_bpt_bytes)
+		actual_bpt_bytes = requested_bytes_per_frame;
+
+	*data_per_frame = actual_bpt_bytes;
+
+	if (command == 0) {
+		/*
+		 * for writes we need to send all the data_bytes per frame,
+		 * even for the last frame which may only transport fewer bytes
+		 */
+
+		*num_frames = DIV_ROUND_UP(data_bytes, actual_bpt_bytes);
+
+		pdi0_tx_size = sdw_cdns_write_pdi0_buffer_size(actual_bpt_bytes);
+		pdi1_rx_size = SDW_CDNS_WRITE_PDI1_BUFFER_SIZE;
+
+		*pdi0_buffer_size = pdi0_tx_size * *num_frames;
+		*pdi1_buffer_size = pdi1_rx_size * *num_frames;
+	} else {
+		/*
+		 * for reads we need to retrieve only what is requested in the BPT
+		 * header, so the last frame needs to be special-cased
+		 */
+		*num_frames = data_bytes / actual_bpt_bytes;
+
+		pdi0_tx_size = SDW_CDNS_READ_PDI0_BUFFER_SIZE;
+		pdi1_rx_size = sdw_cdns_read_pdi1_buffer_size(actual_bpt_bytes);
+
+		*pdi0_buffer_size = pdi0_tx_size * *num_frames;
+		*pdi1_buffer_size = pdi1_rx_size * *num_frames;
+
+		remainder = data_bytes % actual_bpt_bytes;
+		if (remainder) {
+			pdi0_tx_size = SDW_CDNS_READ_PDI0_BUFFER_SIZE;
+			pdi1_rx_size = sdw_cdns_read_pdi1_buffer_size(remainder);
+
+			*num_frames = *num_frames + 1;
+			*pdi0_buffer_size += pdi0_tx_size;
+			*pdi1_buffer_size += pdi1_rx_size;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_bpt_find_buffer_sizes);
+
+static int sdw_cdns_copy_write_data(u8 *data, int data_size, u8 *dma_buffer, int dma_buffer_size)
+{
+	/*
+	 * the implementation copies the data one byte at a time. Experiments with
+	 * two bytes at a time did not seem to improve the performance
+	 */
+	int i, j;
+
+	/* size check to prevent out of bounds access */
+	i = data_size - 1;
+	j = (2 * i) - (i & 1);
+	if (data_size & 1)
+		j++;
+	j += 2;
+	if (j >= dma_buffer_size)
+		return -EINVAL;
+
+	/* copy data */
+	for (i = 0; i < data_size; i++) {
+		j = (2 * i) - (i & 1);
+		dma_buffer[j] = data[i];
+	}
+	/* add required pad */
+	if (data_size & 1)
+		dma_buffer[++j] = 0;
+	/* skip last two bytes */
+	j += 2;
+
+	/* offset and data are off-by-one */
+	return j + 1;
+}
+
+static int sdw_cdns_prepare_write_pd0_buffer(u8 *header, unsigned int header_size,
+					     u8 *data, unsigned int data_size,
+					     u8 *dma_buffer, unsigned int dma_buffer_size,
+					     unsigned int *dma_data_written,
+					     unsigned int frame_counter)
+{
+	int data_written;
+	u8 *last_byte;
+	u8 crc;
+
+	*dma_data_written = 0;
+
+	data_written = sdw_cdns_copy_write_data(header, header_size, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer[3] = BIT(7);
+	dma_buffer[3] |= frame_counter & GENMASK(3, 0);
+
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	crc = SDW_CRC8_SEED;
+	crc = crc8(sdw_crc8_lookup_msb, header, header_size, crc);
+
+	data_written = sdw_cdns_copy_write_data(&crc, 1, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	data_written = sdw_cdns_copy_write_data(data, data_size, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	crc = SDW_CRC8_SEED;
+	crc = crc8(sdw_crc8_lookup_msb, data, data_size, crc);
+	data_written = sdw_cdns_copy_write_data(&crc, 1, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	/* tag last byte */
+	last_byte = dma_buffer - 1;
+	last_byte[0] = BIT(6);
+
+	return 0;
+}
+
+static int sdw_cdns_prepare_read_pd0_buffer(u8 *header, unsigned int header_size,
+					    u8 *dma_buffer, unsigned int dma_buffer_size,
+					    unsigned int *dma_data_written,
+					    unsigned int frame_counter)
+{
+	int data_written;
+	u8 *last_byte;
+	u8 crc;
+
+	*dma_data_written = 0;
+
+	data_written = sdw_cdns_copy_write_data(header, header_size, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer[3] = BIT(7);
+	dma_buffer[3] |= frame_counter & GENMASK(3, 0);
+
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	crc = SDW_CRC8_SEED;
+	crc = crc8(sdw_crc8_lookup_msb, header, header_size, crc);
+
+	data_written = sdw_cdns_copy_write_data(&crc, 1, dma_buffer, dma_buffer_size);
+	if (data_written < 0)
+		return data_written;
+	dma_buffer += data_written;
+	dma_buffer_size -= data_written;
+	*dma_data_written += data_written;
+
+	/* tag last byte */
+	last_byte = dma_buffer - 1;
+	last_byte[0] = BIT(6);
+
+	return 0;
+}
+
+#define CDNS_BPT_ROLLING_COUNTER_START 1
+
+int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data, int data_size,
+				      int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
+				      int *dma_buffer_total_bytes)
+{
+	int total_dma_data_written = 0;
+	u8 *p_dma_buffer = dma_buffer;
+	u8 header[SDW_CDNS_BRA_HDR];
+	int dma_data_written;
+	u8 *p_data = data;
+	u8 counter;
+	int ret;
+
+	counter = CDNS_BPT_ROLLING_COUNTER_START;
+
+	header[0] = BIT(1);		/* write command: BIT(1) set */
+	header[0] |= GENMASK(7, 6);	/* header is active */
+	header[0] |= (dev_num << 2);
+
+	while (data_size >= data_per_frame) {
+		header[1] = data_per_frame;
+		header[2] = start_register >> 24 & 0xFF;
+		header[3] = start_register >> 16 & 0xFF;
+		header[4] = start_register >> 8 & 0xFF;
+		header[5] = start_register >> 0 & 0xFF;
+
+		ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+							p_data, data_per_frame,
+							p_dma_buffer, dma_buffer_size,
+							&dma_data_written, counter);
+		if (ret < 0)
+			return ret;
+
+		counter++;
+
+		p_data += data_per_frame;
+		data_size -= data_per_frame;
+
+		p_dma_buffer += dma_data_written;
+		dma_buffer_size -= dma_data_written;
+		total_dma_data_written += dma_data_written;
+
+		start_register += data_per_frame;
+	}
+
+	if (data_size) {
+		header[1] = data_size;
+		header[2] = start_register >> 24 & 0xFF;
+		header[3] = start_register >> 16 & 0xFF;
+		header[4] = start_register >> 8 & 0xFF;
+		header[5] = start_register >> 0 & 0xFF;
+
+		ret = sdw_cdns_prepare_write_pd0_buffer(header, SDW_CDNS_BRA_HDR,
+							p_data, data_size,
+							p_dma_buffer, dma_buffer_size,
+							&dma_data_written, counter);
+		if (ret < 0)
+			return ret;
+
+		total_dma_data_written += dma_data_written;
+	}
+
+	*dma_buffer_total_bytes = total_dma_data_written;
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_prepare_write_dma_buffer);
+
+int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
+				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
+				     int *dma_buffer_total_bytes)
+{
+	int total_dma_data_written = 0;
+	u8 *p_dma_buffer = dma_buffer;
+	u8 header[SDW_CDNS_BRA_HDR];
+	int dma_data_written;
+	u8 counter;
+	int ret;
+
+	counter = CDNS_BPT_ROLLING_COUNTER_START;
+
+	header[0] = 0;			/* read command: BIT(1) cleared */
+	header[0] |= GENMASK(7, 6);	/* header is active */
+	header[0] |= (dev_num << 2);
+
+	while (data_size >= data_per_frame) {
+		header[1] = data_per_frame;
+		header[2] = start_register >> 24 & 0xFF;
+		header[3] = start_register >> 16 & 0xFF;
+		header[4] = start_register >> 8 & 0xFF;
+		header[5] = start_register >> 0 & 0xFF;
+
+		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
+						       dma_buffer_size, &dma_data_written,
+						       counter);
+		if (ret < 0)
+			return ret;
+
+		counter++;
+
+		data_size -= data_per_frame;
+
+		p_dma_buffer += dma_data_written;
+		dma_buffer_size -= dma_data_written;
+		total_dma_data_written += dma_data_written;
+
+		start_register += data_per_frame;
+	}
+
+	if (data_size) {
+		header[1] = data_size;
+		header[2] = start_register >> 24 & 0xFF;
+		header[3] = start_register >> 16 & 0xFF;
+		header[4] = start_register >> 8 & 0xFF;
+		header[5] = start_register >> 0 & 0xFF;
+
+		ret = sdw_cdns_prepare_read_pd0_buffer(header, SDW_CDNS_BRA_HDR, p_dma_buffer,
+						       dma_buffer_size, &dma_data_written,
+						       counter);
+		if (ret < 0)
+			return ret;
+
+		total_dma_data_written += dma_data_written;
+	}
+
+	*dma_buffer_total_bytes = total_dma_data_written;
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_prepare_read_dma_buffer);
+
+static int check_counter(u32 val, u8 counter)
+{
+	u8 frame;
+
+	frame = (val >> 24) & GENMASK(3, 0);
+	if (counter != frame)
+		return -EIO;
+	return 0;
+}
+
+static int check_response(u32 val)
+{
+	u8 response;
+
+	response = (val >> 3) & GENMASK(1, 0);
+	if (response == 0) /* Ignored */
+		return -ENODATA;
+	if (response != 1) /* ACK */
+		return -EIO;
+
+	return 0;
+}
+
+static int check_frame_start(u32 header, u8 counter)
+{
+	int ret;
+
+	/* check frame_start marker */
+	if (!(header & BIT(31)))
+		return -EIO;
+
+	ret = check_counter(header, counter);
+	if (ret < 0)
+		return ret;
+
+	return check_response(header);
+}
+
+static int check_frame_end(u32 footer)
+{
+	/* check frame_end marker */
+	if (!(footer & BIT(30)))
+		return -EIO;
+
+	return check_response(footer);
+}
+
+int sdw_cdns_check_write_response(struct device *dev, u8 *dma_buffer,
+				  int dma_buffer_size, int num_frames)
+{
+	u32 *p_data;
+	int counter;
+	u32 header;
+	u32 footer;
+	int ret;
+	int i;
+
+	/* paranoia check on buffer size */
+	if (dma_buffer_size != num_frames * 8)
+		return -EINVAL;
+
+	counter = CDNS_BPT_ROLLING_COUNTER_START;
+	p_data = (u32 *)dma_buffer;
+
+	for (i = 0; i < num_frames; i++) {
+		header = *p_data++;
+		footer = *p_data++;
+
+		ret = check_frame_start(header, counter);
+		if (ret < 0) {
+			dev_err(dev, "%s: bad frame %d/%d start header %x\n",
+				__func__, i, num_frames, header);
+			return ret;
+		}
+
+		ret = check_frame_end(footer);
+		if (ret < 0) {
+			dev_err(dev, "%s: bad frame %d/%d end footer %x\n",
+				__func__, i, num_frames, footer);
+			return ret;
+		}
+
+		counter++;
+		counter &= GENMASK(3, 0);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_check_write_response);
+
+static u8 extract_read_data(u32 *data, int num_bytes, u8 *buffer)
+{
+	u32 val;
+	int i;
+	u8 crc;
+	u8 b0;
+	u8 b1;
+
+	crc = SDW_CRC8_SEED;
+
+	/* process two bytes at a time */
+	for (i = 0; i < num_bytes / 2; i++) {
+		val = *data++;
+
+		b0 = val & 0xff;
+		b1 = (val >> 8) & 0xff;
+
+		*buffer++ = b0;
+		crc = crc8(sdw_crc8_lookup_msb, &b0, 1, crc);
+
+		*buffer++ = b1;
+		crc = crc8(sdw_crc8_lookup_msb, &b1, 1, crc);
+	}
+	/* handle remaining byte if it exists */
+	if (num_bytes & 1) {
+		val = *data;
+
+		b0 = val & 0xff;
+
+		*buffer++ = b0;
+		crc = crc8(sdw_crc8_lookup_msb, &b0, 1, crc);
+	}
+	return crc;
+}
+
+int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buffer_size,
+				 u8 *buffer, int buffer_size, int num_frames, int data_per_frame)
+{
+	int total_num_bytes = 0;
+	u32 *p_data;
+	u8 *p_buf;
+	int counter;
+	u32 header;
+	u32 footer;
+	u8 expected_crc;
+	u8 crc;
+	int len;
+	int ret;
+	int i;
+
+	counter = CDNS_BPT_ROLLING_COUNTER_START;
+	p_data = (u32 *)dma_buffer;
+	p_buf = buffer;
+
+	for (i = 0; i < num_frames; i++) {
+		header = *p_data++;
+
+		ret = check_frame_start(header, counter);
+		if (ret < 0) {
+			dev_err(dev, "%s: bad frame %d/%d start header %x\n",
+				__func__, i, num_frames, header);
+			return ret;
+		}
+
+		len = data_per_frame;
+		if (total_num_bytes + data_per_frame > buffer_size)
+			len = buffer_size - total_num_bytes;
+
+		crc = extract_read_data(p_data, len, p_buf);
+
+		p_data += (len + 1) / 2;
+		expected_crc = *p_data++ & 0xff;
+
+		if (crc != expected_crc) {
+			dev_err(dev, "%s: bad frame %d/%d crc %#x expected %#x\n",
+				__func__, i, num_frames, crc, expected_crc);
+			return -EIO;
+		}
+
+		p_buf += len;
+		total_num_bytes += len;
+
+		footer = *p_data++;
+		ret = check_frame_end(footer);
+		if (ret < 0) {
+			dev_err(dev, "%s: bad frame %d/%d end footer %x\n",
+				__func__, i, num_frames, footer);
+			return ret;
+		}
+
+		counter++;
+		counter &= GENMASK(3, 0);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_check_read_response);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Cadence Soundwire Library");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index c34fb050fe4f..9373426c7f63 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -208,4 +208,24 @@ void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string
 void sdw_cdns_config_update(struct sdw_cdns *cdns);
 int sdw_cdns_config_update_set_wait(struct sdw_cdns *cdns);
 
+/* SoundWire BPT/BRA helpers to format data */
+int sdw_cdns_bpt_find_buffer_sizes(int command, /* 0: write, 1: read */
+				   int row, int col, unsigned int data_bytes,
+				   unsigned int requested_bytes_per_frame,
+				   unsigned int *data_per_frame, unsigned int *pdi0_buffer_size,
+				   unsigned int *pdi1_buffer_size, unsigned int *num_frames);
+
+int sdw_cdns_prepare_write_dma_buffer(u8 dev_num, u32 start_register, u8 *data, int data_size,
+				      int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
+				      int *dma_buffer_total_bytes);
+
+int sdw_cdns_prepare_read_dma_buffer(u8 dev_num, u32 start_register, int data_size,
+				     int data_per_frame, u8 *dma_buffer, int dma_buffer_size,
+				     int *dma_buffer_total_bytes);
+
+int sdw_cdns_check_write_response(struct device *dev, u8 *dma_buffer,
+				  int dma_buffer_size, int num_frames);
+
+int sdw_cdns_check_read_response(struct device *dev, u8 *dma_buffer, int dma_buffer_size,
+				 u8 *buffer, int buffer_size, int num_frames, int data_per_frame);
 #endif /* __SDW_CADENCE_H */
-- 
2.43.0


