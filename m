Return-Path: <linux-kernel+bounces-563118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7284A63729
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521533AE1E1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058A1C84B1;
	Sun, 16 Mar 2025 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="p1TUYhix"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F01448E0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742152764; cv=none; b=DoJRF6rMxCQwYdvfhp5H7Fv/6BgACCXyWNDI9wUndGrd+VIUK7kWqGFfwxUNDQsTgtFwtcxCpf5QcnDaAUj1ny8wb+siqMT9gqVB+PTf+mXThbN+Zrnm8XWbhfIKRNiEHjvwOu7BH844evKwlW9xEDN2Jgc6kvUhnh18C3x4InU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742152764; c=relaxed/simple;
	bh=KaiyJ1AyKDQKx6Fxx0En5UnEuH4YiUWhxm3tULyQ05A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcsfFWTNO9b9wgJ/NDMn3k0tvfpZ+a38Bn7VXOriEK/3CuHO2j4x19HcFyRQRLTevgDONC89GeOXMzt06Vzq4TipMp/jNR5UYxWORv7eTkgy1Me3I5555QAyyJxNi08qhhK3frTcOhb3vCR4h/s0vG7czNYQbAdfSQqsyVOkqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=p1TUYhix; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1742152750;
 bh=KKiT+5efbIUlHhEE1qhOdYjXJu1nfrYjC1bFfsz31As=;
 b=p1TUYhix1nEhQM9KVp7509FWe5H+WI8E87xUwQ9VKeYdM7l9yhfcdPe7shgZN0MjyJMsr4ebn
 K6+KjhXhvpxBZQUcnEmqIQmwgFTjzXVKAkUXSEbGhqxGK6bSvOB+vYbKqcB+NZFnXpD3I0249z5
 iIofSp1Z0u5qGmi3PfQoqYwENu+KP2jXkRrKkTtg4lYZY2wxclF8qiXwBH4Q4WXNwSnB2QOG2ZC
 dQZi2PAtNwms4ernf2evGzFnZ/IL2jiX3CbruSX0ZaLYL50TK4eTEySZypncSgliko34q987km6
 Io3pqOC69ZUWZ2pRrLfMuiIftj7oAoKDOUVspJ0UPsaA==
X-Forward-Email-ID: 67d7242a63cc912a5bbae3ed
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: rockchip-otp: Handle internal word_size in main reg_read op
Date: Sun, 16 Mar 2025 19:18:58 +0000
Message-ID: <20250316191900.1858944-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip SoCs RK3576 and RK3588 read data from the OTP using 32-bit
words instead of normal 8-bit bytes. Similar RK3506, RK3528, RK3562 and
RK3568 will read data from OTP using 16-bit words.

The nvmem core stride and word_size cannot fully be used as cells is not
always aligned. Continue to report a stride=1 and word_size=1 in
nvmem_config and instead handle use of SoC specific word_size internally
in the driver.

Move current SoC specific word_size handling from the RK3588 read_reg
operation to the main read_reg operation to help simplify the SoC
specific read_reg operation and allow code reuse in a future RK3568
reg_read operation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This closely matches how I refactored the Rockchip eFUSE and OTP driver
in mainline U-Boot to handle word/block reads back in 2023, see [1].

[1] http://lore.kernel.org/r/20230222224436.1570224-3-jonas@kwiboo.se/
---
 drivers/nvmem/rockchip-otp.c | 72 ++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index d88f12c53242..45bbb6147fb7 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -59,7 +59,6 @@
 #define RK3588_OTPC_AUTO_EN		0x08
 #define RK3588_OTPC_INT_ST		0x84
 #define RK3588_OTPC_DOUT0		0x20
-#define RK3588_NBYTES			4
 #define RK3588_BURST_NUM		1
 #define RK3588_BURST_SHIFT		8
 #define RK3588_ADDR_SHIFT		16
@@ -69,6 +68,7 @@
 struct rockchip_data {
 	int size;
 	int read_offset;
+	int word_size;
 	const char * const *clks;
 	int num_clks;
 	nvmem_reg_read_t reg_read;
@@ -185,48 +185,28 @@ static int px30_otp_read(void *context, unsigned int offset,
 }
 
 static int rk3588_otp_read(void *context, unsigned int offset,
-			   void *val, size_t bytes)
+			   void *val, size_t count)
 {
 	struct rockchip_otp *otp = context;
-	unsigned int addr_start, addr_end, addr_len;
-	int ret, i = 0;
-	u32 data;
-	u8 *buf;
-
-	addr_start = round_down(offset, RK3588_NBYTES) / RK3588_NBYTES;
-	addr_end = round_up(offset + bytes, RK3588_NBYTES) / RK3588_NBYTES;
-	addr_len = addr_end - addr_start;
-	addr_start += otp->data->read_offset / RK3588_NBYTES;
-
-	buf = kzalloc(array_size(addr_len, RK3588_NBYTES), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	u32 *buf = val;
+	int ret;
 
-	while (addr_len--) {
-		writel((addr_start << RK3588_ADDR_SHIFT) |
+	while (count--) {
+		writel((offset++ << RK3588_ADDR_SHIFT) |
 		       (RK3588_BURST_NUM << RK3588_BURST_SHIFT),
 		       otp->base + RK3588_OTPC_AUTO_CTRL);
 		writel(RK3588_AUTO_EN, otp->base + RK3588_OTPC_AUTO_EN);
 
 		ret = rockchip_otp_wait_status(otp, RK3588_OTPC_INT_ST,
 					       RK3588_RD_DONE);
-		if (ret < 0) {
+		if (ret) {
 			dev_err(otp->dev, "timeout during read setup\n");
-			goto read_end;
+			return ret;
 		}
 
-		data = readl(otp->base + RK3588_OTPC_DOUT0);
-		memcpy(&buf[i], &data, RK3588_NBYTES);
-
-		i += RK3588_NBYTES;
-		addr_start++;
+		*buf++ = readl(otp->base + RK3588_OTPC_DOUT0);
 	}
 
-	memcpy(val, buf + offset % RK3588_NBYTES, bytes);
-
-read_end:
-	kfree(buf);
-
 	return ret;
 }
 
@@ -234,7 +214,7 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
-	int ret;
+	int ret, word_size;
 
 	if (!otp->data || !otp->data->reg_read)
 		return -EINVAL;
@@ -245,8 +225,34 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 		return ret;
 	}
 
-	ret = otp->data->reg_read(context, offset, val, bytes);
+	offset += otp->data->read_offset;
+	word_size = otp->data->word_size;
+
+	if (word_size > 1) {
+		unsigned int addr_start, addr_end;
+		size_t count;
+		u8 *buf;
+
+		addr_start = offset / word_size;
+		addr_end = DIV_ROUND_UP(offset + bytes, word_size);
+		count = addr_end - addr_start;
+
+		buf = kzalloc(array_size(count, word_size), GFP_KERNEL);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = otp->data->reg_read(context, addr_start, buf, count);
+		if (!ret)
+			memcpy(val, buf + (offset % word_size), bytes);
+
+		kfree(buf);
+	} else {
+		ret = otp->data->reg_read(context, offset, val, bytes);
+	}
 
+err:
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
 	return ret;
@@ -259,7 +265,7 @@ static struct nvmem_config otp_config = {
 	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.stride = 1,
-	.word_size = 1,
+	.word_size = sizeof(u8),
 	.reg_read = rockchip_otp_read,
 };
 
@@ -277,6 +283,7 @@ static const struct rockchip_data px30_data = {
 static const struct rockchip_data rk3576_data = {
 	.size = 0x100,
 	.read_offset = 0x700,
+	.word_size = sizeof(u32),
 	.clks = px30_otp_clocks,
 	.num_clks = ARRAY_SIZE(px30_otp_clocks),
 	.reg_read = rk3588_otp_read,
@@ -289,6 +296,7 @@ static const char * const rk3588_otp_clocks[] = {
 static const struct rockchip_data rk3588_data = {
 	.size = 0x400,
 	.read_offset = 0xc00,
+	.word_size = sizeof(u32),
 	.clks = rk3588_otp_clocks,
 	.num_clks = ARRAY_SIZE(rk3588_otp_clocks),
 	.reg_read = rk3588_otp_read,
-- 
2.48.1


