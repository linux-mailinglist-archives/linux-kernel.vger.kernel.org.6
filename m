Return-Path: <linux-kernel+bounces-393463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095559BA101
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B27A1C21033
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1A19EEBD;
	Sat,  2 Nov 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="gxpflDR6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="vmLR1/6e"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5215A856
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560467; cv=none; b=lG4Fqohgy62od5CxapN2uWfo3zrNJV0uL9Dqe16eIrKb59OCZJ2vQpxbx/N4PYcgMrVnw94V9WcYLcM3pDXmjtBpL/se9N6IEcizEaXRsUeoBEsQdp3HJpC3GHIrbzHJ54rpPwfbjAvCfeXHjtkpR3DhJ6AdSdjX6EKrN783KYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560467; c=relaxed/simple;
	bh=zkkzTJdzGRcRrrHPKc/gPWdIAlw/bVNaB7ckmqZ8a+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK1/bQmVtcUEKytxafPh7KweGnmGdYrlM741czJjzY2ON0t5RrTmZeg9/K1HTHQhAnu0apXr27ZN+Xw1OAVxm8ELcxBEPHQPJtWfsnCg7a6CsgZgjOwwQThEUNW7mj54GXmjRnX3Dloy05xIzJm5s8x/ehFPDxT7N5Q65CJfZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=gxpflDR6; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=vmLR1/6e; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=rHFvq3C3K8b5Ly7kSgNLL32i4dVoi5OiC5dJ9ndzYqQ=;
	t=1730560463;x=1730650463; 
	b=gxpflDR6pSjudE4/hQnya5NvzvpZwSyQKO7hUHMYdzs+aZQP09Cz13/B00o4IA5jsXp/yEMVgcN8R82sF33m2zUGwRaoLjduuy0nlO4LLz2PEoPYOyzF3EFpyIZPKT8ofyrCM91KnxTu7vzlumfYYZ8x3ZQW7Q9o9qqLCK7uZ7WR1yohDzNVdlzbw0Nt3uS++yFxf97/HrbcH+rp4qBKFxMbtJVsiqV2PRRHCikXdE5yOSALmyEdbeKYBYTbpKIqR6DRgz1MpHjnwyJP7mJK5a5hJMF3DtvEyI6IqAXdt0oFtgMFvNC+6L4w0dzBgF32wuxaOUkm4iLwyJ8YKjSVBw==;
Received: from [10.113.178.94] (port=51342 helo=smtp43.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1t7Fcm-00Bd8P-9o
	for linux-kernel@vger.kernel.org; Sat, 02 Nov 2024 18:01:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=rHFvq3C3K8b5Ly7kSgNLL32i4dVoi5OiC5dJ9ndzYqQ=; t=1730559672; x=1730649672; 
	b=vmLR1/6ebU/P72BZjSds/FoY4QdwdTuAi7MWJMi+0uwJlwScusG4j9fZ2P9Q+vml/mxFjw0mxxt
	dhDkHuRjqCdXkbbaRak6tct29h+hGvzeL6itBJCrAgd6Zjjl8WoBWh7Yzb8DvedF7YRVkCRJFCSxj
	7K8J4VqA8ABV5pZg/0VZ8RZSgfJf98rRD86RWsyM83hMYRwy7NI9lbkGBvBJjLjSf6QrXBz3mdxMG
	9pDbWqIywFj0ZKSzUGWXLqSKkaNHWlWU+6Sc8Ah+OYrXV/AAsXWDroFcsPl152+LELjBbBUFk5sXu
	f+gzZLVtcg7tT5tsdQsFEUdy7kpWZqDGEkYw==;
Received: by exim-smtp-6c5957b6dd-fj2bn with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1t7FcY-00000000Gx4-0wvi; Sat, 02 Nov 2024 18:00:58 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] regmap-irq: Introduce regmap_irq_ack() helper
Date: Sat,  2 Nov 2024 18:00:42 +0300
Message-ID: <20241102150045.218510-2-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241102150045.218510-1-fido_max@inbox.ru>
References: <20241102150045.218510-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD92733C19FC6DB0C8B17DC026970B09D7B6652C6FAA5D0821F182A05F5380850406000C1E96D1244543DE06ABAFEAF6705EC1187F0080146B027B1BB2EC4D8FC05E54C7BE71C4A8023
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE721B3E54BB37EA0B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DA223B75F41C64628638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DAAF3FC68C2B67DF7E261A2D04B5FB306078AEA19A854C0120879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C04CF195F1528592878941B15DA834481FA18204E546F3947C9E541A154B51D14BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637712AAB6D9D366D8A389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B2FFDA4F57982C5F435872C767BF85DA227C277FBC8AE2E8BDAE3FA6833AEA0C275ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5CB15E64DE647BC565002B1117B3ED6961B3880754DAE5DA9B2920F75BA9A967F823CB91A9FED034534781492E4B8EEAD3C056C6FCE5AFF8EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF5829917AF0DB94F01854241A9331E8C3119D83B8F9E413B3BEA004D64B9B5203136DDA45E01CE4BE9C95337E58CA42E69FD82F6A3B1DA215B5BFE37A260F351D950B9EEBF9F23CD29F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqabVpoxyKyVmLg==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA219D12277AE50BA717CF42EB199966831C36ACE2FCDE8AB9BCC90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4BA09097AEF4FF40FFEF26A7B3500B35D268CD632C898546E68F3CF0E9FE49B692E73652B357C013F03BAE166E79EC635B21BF97F4DBAC56382169530EACEFF96
X-7FA49CB5: 0D63561A33F958A5663DE294AFA54F392C5D5929605100670C13F039F00C03A3CACD7DF95DA8FC8BD5E8D9A59859A8B6E3848AE611125D6DCC7F00164DA146DAFE8445B8C89999728AA50765F7900637093CFC3DF75F24619FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3145EAEB5DAD25052CC7F00164DA146DA6F5DAA56C3B73B23C77107234E2CFBA522CA9DD8327EE4930A3850AC1BE2E735B17145F0B7815491C4224003CC83647689D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqaahp6m9AR9hgg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

We have a lot of places where we do interrupt acknowledgment in regmap-irq.
This code is just copy-pasted at least 3 times.
So let's move it to the regmap_irq_ack() helper.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/base/regmap/regmap-irq.c | 88 ++++++++++++--------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 33ec28e3a802..7dcd2118b4d2 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -76,6 +76,32 @@ static void regmap_irq_lock(struct irq_data *data)
 	mutex_lock(&d->lock);
 }
 
+static int regmap_irq_ack(struct regmap_irq_chip_data *d, unsigned int ack, int bank)
+{
+	int ret = 0;
+	u32 reg;
+
+	if (d->chip->ack_base || d->chip->use_ack) {
+		reg = d->get_irq_reg(d, d->chip->ack_base, bank);
+
+		/* some chips ack by write 0 */
+		if (d->chip->ack_invert)
+			ret = regmap_write(d->map, reg, ~ack);
+		else
+			ret = regmap_write(d->map, reg, ack);
+		if (d->chip->clear_ack) {
+			if (d->chip->ack_invert && !ret)
+				ret = regmap_write(d->map, reg, UINT_MAX);
+			else if (!ret)
+				ret = regmap_write(d->map, reg, 0);
+		}
+		if (ret != 0)
+			dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
+				reg, ret);
+	}
+	return ret;
+}
+
 static void regmap_irq_sync_unlock(struct irq_data *data)
 {
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
@@ -156,24 +182,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		 * OR if there is masked interrupt which hasn't been Acked,
 		 * it'll be ignored in irq handler, then may introduce irq storm
 		 */
-		if (d->mask_buf[i] && (d->chip->ack_base || d->chip->use_ack)) {
-			reg = d->get_irq_reg(d, d->chip->ack_base, i);
-
-			/* some chips ack by write 0 */
-			if (d->chip->ack_invert)
-				ret = regmap_write(map, reg, ~d->mask_buf[i]);
-			else
-				ret = regmap_write(map, reg, d->mask_buf[i]);
-			if (d->chip->clear_ack) {
-				if (d->chip->ack_invert && !ret)
-					ret = regmap_write(map, reg, UINT_MAX);
-				else if (!ret)
-					ret = regmap_write(map, reg, 0);
-			}
-			if (ret != 0)
-				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
-					reg, ret);
-		}
+		if (d->mask_buf[i])
+			regmap_irq_ack(d, d->mask_buf[i], i);
 	}
 
 	for (i = 0; i < d->chip->num_config_bases; i++) {
@@ -469,25 +479,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	for (i = 0; i < data->chip->num_regs; i++) {
 		data->status_buf[i] &= ~data->mask_buf[i];
 
-		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = data->get_irq_reg(data, data->chip->ack_base, i);
-
-			if (chip->ack_invert)
-				ret = regmap_write(map, reg,
-						~data->status_buf[i]);
-			else
-				ret = regmap_write(map, reg,
-						data->status_buf[i]);
-			if (chip->clear_ack) {
-				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg, UINT_MAX);
-				else if (!ret)
-					ret = regmap_write(map, reg, 0);
-			}
-			if (ret != 0)
-				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
-					reg, ret);
-		}
+		if (data->status_buf[i])
+			regmap_irq_ack(data, data->status_buf[i], i);
 	}
 
 	for (i = 0; i < chip->num_irqs; i++) {
@@ -833,26 +826,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		if (chip->status_invert)
 			d->status_buf[i] = ~d->status_buf[i];
 
-		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = d->get_irq_reg(d, d->chip->ack_base, i);
-			if (chip->ack_invert)
-				ret = regmap_write(map, reg,
-					~(d->status_buf[i] & d->mask_buf[i]));
-			else
-				ret = regmap_write(map, reg,
-					d->status_buf[i] & d->mask_buf[i]);
-			if (chip->clear_ack) {
-				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg, UINT_MAX);
-				else if (!ret)
-					ret = regmap_write(map, reg, 0);
-			}
-			if (ret != 0) {
-				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
-					reg, ret);
+		if (d->status_buf[i])
+			if (regmap_irq_ack(d, d->status_buf[i] & d->mask_buf[i], i))
 				goto err_alloc;
-			}
-		}
 	}
 
 	/* Wake is disabled by default */
-- 
2.45.2


