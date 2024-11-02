Return-Path: <linux-kernel+bounces-393486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2F9BA137
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0104E2822E3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826B1A0B07;
	Sat,  2 Nov 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="EfzqPLcc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="g2u6xzv1"
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395356446
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561529; cv=none; b=E2nn3cySWs7avinCf0W02VOLEtw3WIXr1kRYHUeup8g7n6XGN8pqvm1zSivgHAGRdntoJgNja5A5WjQze7vYG4UduaGK00DCHJUl50o+vyu+NUoUYDepc/djt3SDjDgIj4q7hohlLOpLVGUItKxmbCRvTRtcPwE/QHhP8mojGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561529; c=relaxed/simple;
	bh=6/p+9rmin3dK9Rw+Uy4Bz2zs+Rzr/5zFfgz/XxyUxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THgdnhhw1Lye9CXq7OD015k1JaTt7WSCuVqEJmaOo0rAwZjGELVnfDSeDBrnGoAMgxP3tHElKos2967GCH44wyWKv+zCS40HPP6a5QPI0pI3ezZ9bUtyDqUsGNVlyFudRv/BRdfNARMmZVAOkb5PVP7Bk1Eh2Y7E2WeBDZQpP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=EfzqPLcc; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=g2u6xzv1; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=vdeBe/DLmHjw2+s+J7CLyp7iFITTEXmMLErhQRjCenY=;
	t=1730561526;x=1730651526; 
	b=EfzqPLcckuSu8DFSqBsS+WtpM0Jekzpt5OV1LD8XzFF6zzrN99miqLSL0bJWj9Ddvr14oK9mtHwwdmQlWd9RqaKgSZaSjoKCaliGhqDesLjKH7JVWiHknhViQi6nT9qsYRH+ncPDzsnUKO64ZiZgvqpuXbM7seJ38HwfEfB7a9DKkA3dk6jz/XEGYflGtB5i0tf477q7nLBrBvY2LQm89v2xIobOhy8GdkkIjGOwlFaCWftZ4GHzJDx4FIF9T3YbWrahD4vwUlJMKuAg1+HXny4Wv+1Bjf82/qXIuhPEzDdAMFkhm7D2ttVu00zUqEVqQbAAbDXMQ3dh2iHeKxq/CA==;
Received: from [10.113.128.120] (port=55852 helo=smtp54.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1t7Fcn-001bwE-AD
	for linux-kernel@vger.kernel.org; Sat, 02 Nov 2024 18:01:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=vdeBe/DLmHjw2+s+J7CLyp7iFITTEXmMLErhQRjCenY=; t=1730559673; x=1730649673; 
	b=g2u6xzv1dPa3vYFBptHw44tWAmjSgELE6ZwQd1aJGUPHyLQbu16tbZN0WhM1JmtnhNwDfwUHOBN
	3UaoSJ4tXTqDawnF0qUl0bZ+4TO//gxd4fyf1miSywYJsojEKF3Zn0bGEAolirBhYRVqezBig4XlM
	TIcSJefQRhQn9wzGGLvlC41WIm3LyI0+hLlHT0GIZRSpV07Zvqx02bWPFZ1brwnqC8NYng2Ogy2Aw
	gZaePB3HTiw5nFSoHPcQEvhTeQ7ders7WpRmbbkhd6XebRjhNzsMI6dYk9QBvs9gW8Jfxx7tApw3E
	SaHeMFHbGOJdvGBsqUZmbywkABamhGWvhpUg==;
Received: by exim-smtp-6c5957b6dd-fj2bn with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1t7Fca-00000000Gx4-2s4z; Sat, 02 Nov 2024 18:01:01 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] regmap-irq: Introduce ack_after_handle option
Date: Sat,  2 Nov 2024 18:00:43 +0300
Message-ID: <20241102150045.218510-3-fido_max@inbox.ru>
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
X-77F55803: 4F1203BC0FB41BD92733C19FC6DB0C8B17DC026970B09D7B6652C6FAA5D0821F182A05F5380850406A0E455650B572753DE06ABAFEAF670510E7222FC75DA9EC27B1BB2EC4D8FC0564783DCF1A4C2DEE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE795530B80AF2ADB7BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637129C704593A46970EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C901C98D639A26E7B448780B6AF7099949BB3149EF453A61B3C1DF9E95F17B0083B26EA987F6312C9EC140C956E756FBB7AC26CFBAC0749D213D2E47CDBA5A96583C09775C1D3CA48CFB73CFAAED92B6E13117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7089B44B3323BCBA59FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F7900637AD0424077D726551EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A534F5B92D0C6DD6BA5002B1117B3ED69694671BEF450A2A95F5FEB6EB1EB183FD823CB91A9FED034534781492E4B8EEADABF80F987DAEDACBC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF037D97CAAD28268801668E415732833E44D49D983F1D5A0CA820EFF7E4C0528FB2CCF8B0FF448A899C95337E58CA42E6FA90C9952981856BB5BFE37A260F351D0722081BCD10184E9F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqabgpcOVNa8pDA==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA21948B07ACB158FCA24F42EB199966831C3F70DA7B1A36253CF90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4C55E9746AA489521B4EA2933C33FC754F2A151E3DCFF867F049FFFDB7839CE9E2138FE6B7044404A0D7291E2F0B4CCD5B6D8191D57E75AC60C1B06175A9203F5
X-7FA49CB5: 0D63561A33F958A5B094B508445E66DFF9419C3C9E0D9342F77DAFE12C088A7ACACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637F8E7BBE36542B4C0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC802A3942546F0CC5EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE70BB89B22BF4660DC731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqaagAUS6yQ+cwA==
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
index 7dcd2118b4d2..8ad6486fc3bd 100644
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
index 570aa9d797b4..a6c94d2ba548 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1572,6 +1572,7 @@ struct regmap_irq_chip_data;
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
+ * @ack_after_handle: Use this to ack interrupts after handling.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
@@ -1635,6 +1636,7 @@ struct regmap_irq_chip {
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
+	unsigned int ack_after_handle:1;
 	unsigned int status_invert:1;
 	unsigned int wake_invert:1;
 	unsigned int type_in_mask:1;
-- 
2.45.2


