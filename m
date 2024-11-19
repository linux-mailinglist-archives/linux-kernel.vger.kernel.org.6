Return-Path: <linux-kernel+bounces-413868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50119D1FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1675B2207F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4B155A25;
	Tue, 19 Nov 2024 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="nSOP4PA+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="jCPwslte"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB62A1B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996074; cv=none; b=GHEivPQOmSZurZCrAIPD28rHr4wSep/b0UCRSRuhutBF1XEHw6NDifSHaOOzSk1fF5MUUzcFmiaDYHY0iS2KdvKHrfaMel77CPqNuZ+Ydu52vjyWJPFpUa6EFK04DkdxlfulgrtylR/Nvs6eSvY8xtuvWOpdUMuRYZj3iQiz2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996074; c=relaxed/simple;
	bh=apHKcHLqJmogJMFjudimgNMs4nVygEUyT5DslF4yG0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ47k9Jgje1LTWCsvYcyrBO3yIhMa/kUHKOs4D4OSbn9GsYM4fWDdkJahK+8CgsaXXs8Nb8m8krWcZeWJoK0EHYUHwMO+hdZUyxcF4hRfC0+X04iofOUPaoHtqGakAD7hyPGS0P9/VqMzNhOhH4jEup6LhWvxsyYS9rdDBSdSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=nSOP4PA+; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=jCPwslte; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8GFBmCRcLXvy29RCAcJD3cZiaenC8Oz8zUDcl1SnLWc=;
	t=1731996072;x=1732086072; 
	b=nSOP4PA+qhQsiFVe7WfKc9uVb5VfQMIRASs1+ejKpYND08VDiGuZlrMQx3yY/tO9+1/qNPpPFFskSeC/ZnMmwX3ZiOljza7AG2+je+neEy/jhKlHz6u0t5HWxl5DMD8sIUS00kASmWjIlg7X1Bfg4u+cDYqwqGESsW+h1DuTH4F4VBnxxMs85rJdOI7Smp7dFLra6Wm3oYN17kfXXYKfyJADNjI97NM7Zk075IKa/ZwkApKnGto3ipYGBdDRFWwQOoXrxfH7QezYw0GLg/rHPlieXDafy6JDUpeer8m8BTVZHoPLMPtWPpdX/ujHtTHCydG7XThUUahPberVvblckA==;
Received: from [10.113.232.98] (port=53430 helo=smtp50.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tDHIO-00444f-4c
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 09:01:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8GFBmCRcLXvy29RCAcJD3cZiaenC8Oz8zUDcl1SnLWc=; t=1731996064; x=1732086064; 
	b=jCPwslteYor3Ge8Tp75b9Ff1G0UVAFiV7buuRyzYzgsIOWFe6WWHYJbygE74hYd4UfnYFNWkU5Y
	jRe4hT53h9dqVYMYdBljpMfINYQ5XTGGIYl/YzHzWM2SSEpcCxmVXy7VMxNgEVf/ueqSvfNrQbdt+
	Z/jmpDyqtO6iHZX/r29NgU0xWeUMD9RzzKqINqRjnegEMB8Tk+wDjGIrMWGwPg9isuUkazsy1/ue3
	lpwBoTB4ski1unPSM7DRuDNVcRMe1eecigod7SZWltvL/Ql/X9V8WIfGagchDYRoUp7LbtpywDhph
	L4Z8Z5p1heBaZau2sBmGXsdKWpuWCN0VNs3w==;
Received: by exim-smtp-5b7bfccf9f-rgnt4 with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tDHI8-00000000JMW-2WB5; Tue, 19 Nov 2024 09:00:49 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 2/2] regmap-irq: Introduce ack_after_handle option
Date: Tue, 19 Nov 2024 08:59:39 +0300
Message-ID: <20241119055944.363498-3-fido_max@inbox.ru>
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
X-77F55803: 4F1203BC0FB41BD95367647A2C12583FC84D6A7BCBB95E87B061537DBE0350A1182A05F53808504001BDAB3D342F957C3DE06ABAFEAF67057FF8EBAF34905F90041C3D1E536A63B80C8629FDE0E8EB2A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76C0A440987CA342DC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7C4A7E4C0BFE8628DEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C905F0383CB38F85E33F9B4888072D33C4E2FD8A3412BDB16DE1DF9E95F17B0083B26EA987F6312C9EC9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B5278DA827A17800CE786A06C54C89EF27D9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C309F854029C6BD0DA117882F4460429728AD0CFFFB425014E868A13BD56FB6657E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637AD0424077D726551EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5CED44A98B12954F45002B1117B3ED6961718D8BD22F31902FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFBCC6794485A61604B4FFD266A4A2F56480BE3F46EC6EEC2A1DC63FBA5A6EA287BC84317DE62561530C86AA3C630759CE19B7BBB39BAD0A049ED4AC555409C695C326C42D854A91EC9F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy8pOZdwT8l+uw==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA219A821A83ADB0E90270F923AB1F9121893B9D65CFEDD0211D490DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B454E1DAF28AA7D56D7BEFEAADD8CAC7AC47343892CD1EF229049FFFDB7839CE9EBEC99E045F5977055A40751BE1FB3B6EF1B73C6108DC0E2FD34AB8955D39148F
X-7FA49CB5: 0D63561A33F958A59C7989A328CFE985A52536C415C2E329ADD7CDBF86DB1811CACD7DF95DA8FC8BD5E8D9A59859A8B6836F5ADB0B4F9314CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F8E7BBE36542B4C0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC802A3942546F0CC5EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7D699F3A2029486C7731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy+mBaJ0AL64rw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Some interrupt controllers may have simple level interrupt detection
without enable/disable functionality. Mask/unmask simply disables
interrupt signaling to the upstream chip. If we try to ack these
interrupts before handling, we will get a false interrupt with empty
status. So the only one possible way to handle this interrupts is
to ack them after handling.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/base/regmap/regmap-irq.c | 8 +++++++-
 include/linux/regmap.h           | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c097f8ca17b7..2400d2efb1e9 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -479,7 +479,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	for (i = 0; i < data->chip->num_regs; i++) {
 		data->status_buf[i] &= ~data->mask_buf[i];
 
-		if (data->status_buf[i])
+		if (!chip->ack_after_handle && data->status_buf[i])
 			regmap_irq_ack(data, data->status_buf[i], i);
 	}
 
@@ -491,6 +491,12 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		}
 	}
 
+	if (chip->ack_after_handle)
+		for (i = 0; i < data->chip->num_regs; i++) {
+			if (data->status_buf[i])
+				regmap_irq_ack(data, data->status_buf[i], i);
+		}
+
 exit:
 	if (chip->handle_post_irq)
 		chip->handle_post_irq(chip->irq_drv_data);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index fd41baccbf3e..1d31e066ae59 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1581,6 +1581,7 @@ struct regmap_irq_chip_data;
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
+ * @ack_after_handle: Use this to ack interrupts after handling.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
@@ -1644,6 +1645,7 @@ struct regmap_irq_chip {
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
+	unsigned int ack_after_handle:1;
 	unsigned int status_invert:1;
 	unsigned int wake_invert:1;
 	unsigned int type_in_mask:1;
-- 
2.45.2


