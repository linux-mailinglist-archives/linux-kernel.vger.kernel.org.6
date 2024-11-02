Return-Path: <linux-kernel+bounces-393498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFAC9BA161
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA651C20ABD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57381A3A9A;
	Sat,  2 Nov 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="USFFv7ZR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="ApF3txI9"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101919CC25
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730564028; cv=none; b=KgaAzWhxsKeV3Rxkw5Idhz/mM5DyJLtR7krlmW6WjUW+KvFA4Qq/gdg5yMMwS+QFSj+GVTht9Rqv5V9uWq9IaoxdC8/vkprsd+3TrPq3h5iKOIBGamxkGQAtkvIvUpd/EX3f4Iukd97N2qdE25jdrlKGSem+9Qsb6KcCz3k1HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730564028; c=relaxed/simple;
	bh=kUsasvJVlCEwzJGmtlq+qzgmExFWVdU4/5TwLXuCOnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+TuQj8+6si9qJ/XQt3uCWOyYp+3bWBMvkDXiNfLJ1SwHu09mo+tFspu9TYr64uupdHqiLLNCVUMVAv4ivd0lnBI+jk61L9yC0wXh9Ynb367XocsrSMcKrRMCB4VU/DJl/hJKHXIY3iOH8d8Yh7WyGV1B5sTx+AxM/PXKzmwOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=USFFv7ZR; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=ApF3txI9; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=;
	t=1730564024;x=1730654024; 
	b=USFFv7ZRTTCGgoY+XZ5mCmioy/fObCMfExFWzjGwSMxsmFdOnDLzbmqBq4MQ1nZ5BdUqFKlbqVPsk+vj+ynXISN69z3ErB5cSUIgp9vbvzfTIrN+H6ESlGe0SKJYk7fzJHAKLHVYRrTzCWBow0CZ743iLkdGrXlJuDPdZ4vqi94U3FDkTX0D/B+kIakgzHwVG/YUMmZDNqleUym0A0IaXvavRIeO/driw2ESMnVjhHHQMHrxpBsr63SZ0LCjDX8AgX/dD/KImlHuLmMsxqXVtXCrftnYFwaiG+YwH2mpCRJ6DbOwn7JCdDeM2rvmGFFJls7aFQ0p/sw7OhjYGxDWyg==;
Received: from [10.113.110.214] (port=48320 helo=smtp33.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1t7Fcc-004k71-3W
	for linux-kernel@vger.kernel.org; Sat, 02 Nov 2024 18:01:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=; t=1730559662; x=1730649662; 
	b=ApF3txI94flyUBzAgNUN5k6GIkA77Q5pXVM3U788/FQq8kzP9/EvuuQQrW7v1ocd1Z26s94AIH9
	7X1gY6QxOHwXEymaD6PLOTU/nBMF3vKEMD+W/sEwBEhkmsO9BcBv6Z6wQGuAqnHCQi0ql3zMUorGn
	bvO9k3FjFF/eRzIxXLCgCuIrL2pEM9xqhovuUn7L3IicUubCcd58WcUSmPhdFrUqAmEO8RDCpemwM
	95wJhV55LfE7N7U1z01Sf+fo074TRd7CaUX/yHo+PXUA8nUsIVkWIHaSIit0294/MdoDQBcEM27uM
	fttQc00bROtClZkYBkxiV9c/Fda5mQwpuLNA==;
Received: by exim-smtp-6c5957b6dd-fj2bn with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1t7FcN-00000000Gx4-2VTd; Sat, 02 Nov 2024 18:00:48 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] Introduce ack_after_handle option for regmap-irq
Date: Sat,  2 Nov 2024 18:00:41 +0300
Message-ID: <20241102150045.218510-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F1CA29D43EE537F2DCF98E1C5C5670DCD23F73DB6E286ADF182A05F53808504093861004316DC0C93DE06ABAFEAF6705D0D8DB2145BDFAF827B1BB2EC4D8FC055E6CE7239E2C5700
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CE4525FFB91B9BBCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063790B55F3E386DB9B28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D9DB06B47A0737797E261A2D04B5FB301C0E1FE576DB3FAB20879F7C8C5043D14489FFFB0AA5F4BF1661749BA6B97735D9442B0B5983000E8941B15DA834481FA18204E546F3947CA9FF340AA05FB58CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A359038F01FFAF82389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735E4A630A5B664A4FFC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5421AB3BDFEA435F25002B1117B3ED696C9C1C38E13F527B70E58516B1639A14B823CB91A9FED034534781492E4B8EEADA757276DBF662F3EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC7F4243AD7CD7D42FE41698D65D243FBE8E4AAD5828B8C92FFD660E9975A9C79422E0C78D0E153559C95337E58CA42E65D107CFD51C630ADB5BFE37A260F351D07C2F04C7E955CFA9F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqaaO2SlaNgkueA==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA219B49E24BC68D01DD8F42EB199966831C3D35F9311129B677690DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4C55E9746AA489521B4EA2933C33FC754C6EEA5792614A1AC049FFFDB7839CE9E2138FE6B7044404AFE5E35B9F7B641736FA92FD90D482F2B3DA3B2FA281C8A7B
X-7FA49CB5: 0D63561A33F958A534727D7699B8EDE5072549F5F613C4062C563F34D3E01431CACD7DF95DA8FC8BD5E8D9A59859A8B65A3EDA775A1E0ED0CC7F00164DA146DAFE8445B8C89999728AA50765F790063794CA976D7634B470389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8AD7102AF51AFB197F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE778B471BB9634AD8A731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqabmJNoTOeTpXA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Some interrupt controllers for proper operation require acknowledgment
only after processing.
So add this option.

Maxim Kochetkov (2):
  regmap-irq: Introduce regmap_irq_ack() helper
  regmap-irq: Introduce ack_after_handle option

 drivers/base/regmap/regmap-irq.c | 94 +++++++++++++-------------------
 include/linux/regmap.h           |  2 +
 2 files changed, 40 insertions(+), 56 deletions(-)

-- 
2.45.2


