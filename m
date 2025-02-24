Return-Path: <linux-kernel+bounces-528280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D9A415AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69BF16815B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0924BC07;
	Mon, 24 Feb 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kj3dxMFB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255724BBE8;
	Mon, 24 Feb 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379545; cv=none; b=b8FSgqX9grVJ2IzZb32qo74y4OYUpWDuMtvewgU3QUi02+hGGg6iSvnXthFOm8+1Ywpr/37EpDLxd0EQOjvrorqKJWweuGmIkUSiNCYDBDMYQJeYLzKJXWYKaiTHmuIKyPSRIwRZBbkgdQMoTT7w7zkGAXvKBLeA4EDcHzklcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379545; c=relaxed/simple;
	bh=dIHzKvs/CLNsdZuAwNYXUG9aLPMbUkYW5XbTPXy1O0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJjsP0mS7PHCyYnHvpiqkRnJRsU4qHmIUJby7mUHROqgXv5Ef+eNn9h2tbPFQVXi4+doR6MWSxCzWKXCDQ+90oct5lFa+eRmYuxlYp6Q6AAImDZAW6DtwQZqhu/Saf0od+SCI4AfAiAx3tk7BMbLAt9vj6IeeBsXSuHrW+A1lYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kj3dxMFB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379543; x=1771915543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIHzKvs/CLNsdZuAwNYXUG9aLPMbUkYW5XbTPXy1O0E=;
  b=Kj3dxMFB/NZ9a8UmOyqBpdY1kaNL6N2pNvaAqL3dhnrg69cPZra9q4PX
   Cy82Y9zqt3H6ACSng7XJsCBDCHQgOdl2BcNxfOXJ28vw5Hb710auU1Qmu
   73/mzSuO/RAUvQzlh2ltduic9p98LHmnumADPXpjKBl3E7SbOGW+TS0Zt
   vDUcXnDj6/OSnlBCbGL4Xbj5bYsPATqynzg2se5eYQibAha4wFn7vYbwr
   VXU6Uebu6YUkb6DBFafdh75QO8VnfgnbIpjb15+5Xq6w4+Jozoc4pAhKx
   pXl1d4upXFgnxbsWiplz7aik/oOZ2ukbPR482H9kIOArgRG0OdLkIJ68+
   w==;
X-CSE-ConnectionGUID: OA4wJd/UR8OeZYIK8sej2A==
X-CSE-MsgGUID: 1S6saUiLTl+xdGi4/hucXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538999"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538999"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:43 -0800
X-CSE-ConnectionGUID: F5PQ6SgQQOGbn9zzlL93vA==
X-CSE-MsgGUID: kzeSSQORTMOUG5fQ7Y4ZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597757"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:41 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 15/16] soundwire: debugfs: add interface for BPT/BRA transfers
Date: Mon, 24 Feb 2025 14:44:49 +0800
Message-ID: <20250224064451.33772-16-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

Add code to show what codec drivers will need to do to enable BPT/BRA
transfers. The only difference is to set the 'command_type' file to
'1'. A zero-value will rely on regular read/write commands in Column0.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/debugfs.c | 84 ++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 5bf0d9552433..3099ea074f10 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -136,9 +136,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);
 
-#define MAX_CMD_BYTES 256
+#define MAX_CMD_BYTES (1024 * 1024)
 
 static int cmd;
+static int cmd_type;
 static u32 start_addr;
 static size_t num_bytes;
 static u8 read_buffer[MAX_CMD_BYTES];
@@ -162,6 +163,25 @@ static int set_command(void *data, u64 value)
 DEFINE_DEBUGFS_ATTRIBUTE(set_command_fops, NULL,
 			 set_command, "%llu\n");
 
+static int set_command_type(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	if (value > 1)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "command type: %s\n", value ? "BRA" : "Column0");
+
+	cmd_type = (int)value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_command_type_fops, NULL,
+			 set_command_type, "%llu\n");
+
 static int set_start_address(void *data, u64 value)
 {
 	struct sdw_slave *slave = data;
@@ -197,9 +217,28 @@ static int set_num_bytes(void *data, u64 value)
 DEFINE_DEBUGFS_ATTRIBUTE(set_num_bytes_fops, NULL,
 			 set_num_bytes, "%llu\n");
 
+static int do_bpt_sequence(struct sdw_slave *slave, bool write, u8 *buffer)
+{
+	struct sdw_bpt_msg msg = {0};
+
+	msg.addr = start_addr;
+	msg.len = num_bytes;
+	msg.dev_num = slave->dev_num;
+	if (write)
+		msg.flags = SDW_MSG_FLAG_WRITE;
+	else
+		msg.flags = SDW_MSG_FLAG_READ;
+	msg.buf = buffer;
+
+	return sdw_bpt_send_sync(slave->bus, slave, &msg);
+}
+
 static int cmd_go(void *data, u64 value)
 {
+	const struct firmware *fw = NULL;
 	struct sdw_slave *slave = data;
+	ktime_t start_t;
+	ktime_t finish_t;
 	int ret;
 
 	if (value != 1)
@@ -216,40 +255,52 @@ static int cmd_go(void *data, u64 value)
 		return ret;
 	}
 
-	/* Userspace changed the hardware state behind the kernel's back */
-	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
-
-	dev_dbg(&slave->dev, "starting command\n");
-
 	if (cmd == 0) {
-		const struct firmware *fw;
-
 		ret = request_firmware(&fw, firmware_file, &slave->dev);
 		if (ret < 0) {
 			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
 			goto out;
 		}
-
-		if (fw->size != num_bytes) {
+		if (fw->size < num_bytes) {
 			dev_err(&slave->dev,
-				"firmware %s: unexpected size %zd, desired %zd\n",
+				"firmware %s: firmware size %zd, desired %zd\n",
 				firmware_file, fw->size, num_bytes);
-			release_firmware(fw);
 			goto out;
 		}
+	}
 
-		ret = sdw_nwrite_no_pm(slave, start_addr, num_bytes, fw->data);
-		release_firmware(fw);
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "starting command\n");
+	start_t = ktime_get();
+
+	if (cmd == 0) {
+		if (cmd_type)
+			ret = do_bpt_sequence(slave, true, (u8 *)fw->data);
+		else
+			ret = sdw_nwrite_no_pm(slave, start_addr, num_bytes, fw->data);
 	} else {
-		ret = sdw_nread_no_pm(slave, start_addr, num_bytes, read_buffer);
+		memset(read_buffer, 0, sizeof(read_buffer));
+
+		if (cmd_type)
+			ret = do_bpt_sequence(slave, false, read_buffer);
+		else
+			ret = sdw_nread_no_pm(slave, start_addr, num_bytes, read_buffer);
 	}
 
-	dev_dbg(&slave->dev, "command completed %d\n", ret);
+	finish_t = ktime_get();
 
 out:
+	if (fw)
+		release_firmware(fw);
+
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put(&slave->dev);
 
+	dev_dbg(&slave->dev, "command completed, num_byte %zu status %d, time %lld ms\n",
+		num_bytes, ret, div_u64(finish_t - start_t, NSEC_PER_MSEC));
+
 	return ret;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
@@ -291,6 +342,7 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 
 	/* interface to send arbitrary commands */
 	debugfs_create_file("command", 0200, d, slave, &set_command_fops);
+	debugfs_create_file("command_type", 0200, d, slave, &set_command_type_fops);
 	debugfs_create_file("start_address", 0200, d, slave, &set_start_address_fops);
 	debugfs_create_file("num_bytes", 0200, d, slave, &set_num_bytes_fops);
 	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
-- 
2.43.0


