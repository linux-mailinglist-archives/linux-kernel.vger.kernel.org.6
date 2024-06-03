Return-Path: <linux-kernel+bounces-198682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327A8D7C11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B681C2162F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66038DF9;
	Mon,  3 Jun 2024 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3Ot3w7I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99C2AEE1;
	Mon,  3 Jun 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397967; cv=none; b=IRcL0VlWOrqGZ121d72jMDkecAMo1R7TXv1dItw667yx6ZnmYaakrJIQBFPbjWgQ0O33MLRGA6ushImbSLj2g8Jtdycac4XvTUruL2SI8kYzH4WK669j/vq7SoFNdTCSF9xczFMD4ydYBC91FNpCvcfqdZaUx3vtXCWoYE4ohIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397967; c=relaxed/simple;
	bh=j5apd7/os69hhPGe5biUwnQrBPXvf18T+3HZdm7Ysiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2ntpLNxPsafYhH+efwlnMrYpDhXb1iaWIOgEpQeGhTG34zyjDV/QdKs52JTgvGx9rOUKjAws34kdMvYecLS9mx6crtlLe4sD67tHrzzULtF3EihPLAF+N8M7dzTxWOmRT0TQR7ju2tkwRlJb+NJ64aEzX3Eh+0RWHL+vwcGYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3Ot3w7I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717397966; x=1748933966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5apd7/os69hhPGe5biUwnQrBPXvf18T+3HZdm7Ysiw=;
  b=X3Ot3w7I8hjE0evtFwQgi9iOSEqjsxm11B7SxMBHRn2sQne5mXqz2Y4f
   MPVFgrM0Di6bSDG+5tjHjXBPipshpwVt3RrtsgM45PbofH4DHnYZDgrV5
   4epD7UDe2GAuardZU8ffkHHBpKOT3SlPLpJBvh4yLDvrJy2k1We3Rzq3d
   izlI8BGHK4E6AK2WQ9odOvDxZJx4LttZR5CtxGkGuDGCUYcvOFi2JejMl
   sudgRog3m5ccI8ELroY8J78xSD1PgqcAd9O3cIFTy8Z6e9IzIpVarz+//
   QuRgdqvTk8ahHMZ5oyJihdooeGFO5aVh4AbvH8Xirj3AWkDsFBpnb94Bj
   Q==;
X-CSE-ConnectionGUID: +U519EnEQPizVlFzUEz5aA==
X-CSE-MsgGUID: hZWR4cvPQZ2heD90IY98jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13717666"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13717666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:59:24 -0700
X-CSE-ConnectionGUID: CVm0w2wnTV2Ff2LjY2WL2A==
X-CSE-MsgGUID: mCa0IaByRWmALq0NpWovtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36792763"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:59:20 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND 1/2] soundwire: debugfs: add interface to read/write commands
Date: Mon,  3 Jun 2024 14:58:40 +0800
Message-Id: <20240603065841.4860-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have an existing debugfs files to read standard registers
(DP0/SCP/DPn).

This patch provides a more generic interface to ANY set of read/write
contiguous registers in a peripheral device. In follow-up patches,
this interface will be extended to use BRA transfers.

The sequence is to use the following files added under the existing
debugsfs directory for each peripheral device:

command (write 0, read 1)
num_bytes
start_address
firmware_file (only for writes)
read_buffer (only for reads)

Example for a read command - this checks the 6 bytes used for
enumeration.

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 1 > command
echo 6 > num_bytes
echo 0x50 > start_address
echo 1 > go
cat read_buffer
address 0x50 val 0x30
address 0x51 val 0x02
address 0x52 val 0x5d
address 0x53 val 0x07
address 0x54 val 0x11
address 0x55 val 0x01

Example with a 2-byte firmware file written in DP0 address 0x22

od -x /lib/firmware/test_firmware
0000000 0a37
0000002

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 0 > command
echo 2 > num_bytes
echo 0x22 > start_address
echo "test_firmware" > firmware_file
echo 1 > go

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 1 > command
echo 2 > num_bytes
echo 0x22 > start_address
echo 1 > go
cat read_buffer

address 0x22 val 0x37
address 0x23 val 0x0a

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/debugfs.c | 150 ++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 67abd7e52f09..6d253d69871d 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/firmware.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -137,6 +138,145 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);
 
+#define MAX_CMD_BYTES 256
+
+static int cmd;
+static u32 start_addr;
+static size_t num_bytes;
+static u8 read_buffer[MAX_CMD_BYTES];
+static char *firmware_file;
+
+static int set_command(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	if (value > 1)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "command: %s\n", value ? "read" : "write");
+	cmd = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_command_fops, NULL,
+			 set_command, "%llu\n");
+
+static int set_start_address(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "start address %#llx\n", value);
+
+	start_addr = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_start_address_fops, NULL,
+			 set_start_address, "%llu\n");
+
+static int set_num_bytes(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	if (value == 0 || value > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "number of bytes %lld\n", value);
+
+	num_bytes = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_num_bytes_fops, NULL,
+			 set_num_bytes, "%llu\n");
+
+static int cmd_go(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+	int ret;
+
+	if (value != 1)
+		return -EINVAL;
+
+	/* one last check */
+	if (start_addr > SDW_REG_MAX ||
+	    num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
+		return ret;
+	}
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "starting command\n");
+
+	if (cmd == 0) {
+		const struct firmware *fw;
+
+		ret = request_firmware(&fw, firmware_file, &slave->dev);
+		if (ret < 0) {
+			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
+			goto out;
+		}
+
+		if (fw->size != num_bytes) {
+			dev_err(&slave->dev,
+				"firmware %s: unexpected size %zd, desired %zd\n",
+				firmware_file, fw->size, num_bytes);
+			release_firmware(fw);
+			goto out;
+		}
+
+		ret = sdw_nwrite_no_pm(slave, start_addr, num_bytes, fw->data);
+		release_firmware(fw);
+	} else {
+		ret = sdw_nread_no_pm(slave, start_addr, num_bytes, read_buffer);
+	}
+
+	dev_dbg(&slave->dev, "command completed %d\n", ret);
+
+out:
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put(&slave->dev);
+
+	return ret;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
+			 cmd_go, "%llu\n");
+
+#define MAX_LINE_LEN 128
+
+static int read_buffer_show(struct seq_file *s_file, void *data)
+{
+	char buf[MAX_LINE_LEN];
+	int i;
+
+	if (num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	for (i = 0; i < num_bytes; i++) {
+		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
+			  start_addr + i, read_buffer[i]);
+		seq_printf(s_file, "%s", buf);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(read_buffer);
+
 void sdw_slave_debugfs_init(struct sdw_slave *slave)
 {
 	struct dentry *master;
@@ -151,6 +291,16 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 
 	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);
 
+	/* interface to send arbitrary commands */
+	debugfs_create_file("command", 0200, d, slave, &set_command_fops);
+	debugfs_create_file("start_address", 0200, d, slave, &set_start_address_fops);
+	debugfs_create_file("num_bytes", 0200, d, slave, &set_num_bytes_fops);
+	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
+
+	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
+	firmware_file = NULL;
+	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+
 	slave->debugfs = d;
 }
 
-- 
2.40.1


