Return-Path: <linux-kernel+bounces-413866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C999D1FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8378BB21D63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676FA1534FB;
	Tue, 19 Nov 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="TT4Au4De";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="oPSW/1uZ"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AEE571
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996072; cv=none; b=Q1vZClb++Ye9jRVryPFSwBzuq/KmbK20QX4AFP3v2SKfnuNMDMr7EOVACDEWThBQXiXBlZpbSoeX0gbvPYGTBS+QPJCM1Gv++XZxgNf2TeTlamsgXt7z/uv7V+PpaIkz1CzzwqXGpwIbwZcKDhtV9uAptUd2U9xMd58kdbwsdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996072; c=relaxed/simple;
	bh=Wd/o3Eg8v6Lf0ZY/iNBPYwroe2Z7LT7/DxVhswkRojc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cweKcaiDwJGSL6I0cjRXrpQ0SmYfaEAe9mN6vmhGfnG8QJaww0aKFa0X2DeZlKRJV+RUOK3tPwNCyGm6B9/YR4eYaST+07UIW/4tfoo3ODKU3o3bPR1M4Luzk3YVf/M/NL5OG6/uLvVQIim8tTaWrcedYMWfXP0BCNZK5K+ktek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=TT4Au4De; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=oPSW/1uZ; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=rjcP5sJke5Bx8/jRJViVnXrJKZoYgTkbBFdx99efjns=;
	t=1731996069;x=1732086069; 
	b=TT4Au4De1Iw8S7ZkMqbP6oB8+MArIHFf55NBwg57BfTNGy1DxnxYf+Z2xrXAjmXHZUp8P0aX8kCEmB+6HznynEaQKz4xwL6ETrdHdDSJTyO4zk2JOFf+jLdQit5xjIMMsE2vAneZQEYnheOhhgE3kxYNFsi3SuyZR2xlkLZchFzh6DjG7j8jCGWJL4CSdxhnlASBtb+pbAZ0U4SGjyYdEH3mx/lzEezYrpRvXNdQ7q10j+A46gTz+T0zCmwH8dnipKkG7ef6/aZ3R/osq32++GMVieWdaX8DL1CeYGGZnDqWpkOC0ZVsoxivDI4SqzPVM/iAwwzxZD9IVeh+hTJ4Mg==;
Received: from [10.113.163.34] (port=41098 helo=smtp33.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tDHIM-008D6N-71
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 09:01:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=rjcP5sJke5Bx8/jRJViVnXrJKZoYgTkbBFdx99efjns=; t=1731996062; x=1732086062; 
	b=oPSW/1uZjkGhGIOotUiURu+wbQSds9r3NBNDA+y0kZZD/ZSjVIGDWcP0GzEUGbP1vSTc7471THv
	P+36ed1bD7n/FCDGGjc34api+adTD6QzHX+Uf4tpdt1T6Hjqt71hzs6QGB/+pah+AB3Z9+8TwR8lq
	4dZS/XuOIui56eQdZ370WNXNP9kAIfvx1+jsZPjLrIpsPnkVJoT3FvFTw8Rp17gLivSkmFdgV8piI
	CBKeNWRVmwgUNf4O9ySKCfhxPauKyd0ngaaGiZwvNIWzkzb7gLhgnsiS7GM1Wn1KhJBtuAftBjdcv
	80NUv2SdjVbxwtwMXT/o3qB3HwNpzKhbDnSA==;
Received: by exim-smtp-5b7bfccf9f-rgnt4 with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tDHI7-00000000JMW-429F; Tue, 19 Nov 2024 09:00:48 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/2] regmap-irq: Introduce regmap_irq_ack() helper
Date: Tue, 19 Nov 2024 08:59:38 +0300
Message-ID: <20241119055944.363498-2-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119055944.363498-1-fido_max@inbox.ru>
References: <20241119055944.363498-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95367647A2C12583F2C8F5ECE26118F812B5164FFEEF29B9C182A05F538085040C3BECA2E62DB8D6C3DE06ABAFEAF670597F0BB7027BAB7F2041C3D1E536A63B8B242013FB95F71DC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE75CCA5FD4E6ACD987EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C90DC8285596FAF18CBF9B4888072D33C4E62A5583CAADFA6AB1DF9E95F17B0083B26EA987F6312C9EC33AC447995A7AD18618001F51B5FD3F9D2E47CDBA5A96583C09775C1D3CA48CFF7ED4D6813B5CA04117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE729FBA39629FC1B7C9FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F7900637F9425D8FA97DB4396D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637AD0424077D726551EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5F89C270203F026835002B1117B3ED6961852474EDB0F8EA3ED71F038FC046993823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF151B457848D89130C4327175A013C49FA4C771D07D42070DC4505476F26ACC28B469278E65BD125A0C86AA3C630759CE1BD3C7B64CC616FC9ED4AC555409C695E0C3823DA75A7CD49F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy9RVtTuDDWa8w==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA2191638FFDBE392D4E30F923AB1F912189395F16D66E40174C790DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B454E1DAF28AA7D56D7BEFEAADD8CAC7ACF3140A44FEE55A3C049FFFDB7839CE9EBEC99E045F597705D777186230FAA12E73E8F311200A813C9939EE44C735EA39
X-7FA49CB5: 0D63561A33F958A5B00FA66E97D01679A2A51FEB30ABE44C475967446E671DAECACD7DF95DA8FC8BD5E8D9A59859A8B64A2C4B6BA9DFC510CC7F00164DA146DAFE8445B8C89999728AA50765F7900637093CFC3DF75F24619FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3145EAEB5DAD25052CC7F00164DA146DA6F5DAA56C3B73B23C77107234E2CFBA522CA9DD8327EE4930A3850AC1BE2E735B58781B77DE60D36C4224003CC83647689D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy+Y6l25xiwYOg==
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
index 0bcd81389a29..c097f8ca17b7 100644
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
@@ -837,26 +830,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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


