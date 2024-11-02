Return-Path: <linux-kernel+bounces-393440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0C9BA0AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6937E1F2143B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123071991BF;
	Sat,  2 Nov 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="QyqpkMGe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="d1OMqG+L"
Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D119BBA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730556308; cv=none; b=rInZvJGQlgXr9wFctDyr48CInmfZDUSmjydBLV9SrURrFmlugRtsAC8u7JR4JBNZLl304qZtCbexH4K6o5wR9nyKAOAiHWEuidva4LrKns/vUUc3M7pDCK32wQZtsTB6/JQExDPe8T1p1wjQqx1rBsgkhndFm+oCYyqZYTQ3Zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730556308; c=relaxed/simple;
	bh=kUsasvJVlCEwzJGmtlq+qzgmExFWVdU4/5TwLXuCOnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfL0UdhRk4vU9yyzRYTp9spADMRfrIBaRJsIQJ6NZCcEFQMgIw1i6CWcfW6RPP3yvLZ7QUQ4/cfCPUzJ5mwQTxOZ358Lgy06dsDbNhXkqoCvaPpX5zAQhudZcH0ywptSthgZQCqt6/mWHlVWbW/r8gMkl8o6PnqIGBkf/Sh/Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=QyqpkMGe; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=d1OMqG+L; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=;
	t=1730556304;x=1730646304; 
	b=QyqpkMGeNnc+GfmkwtcMdmOGG0dNVzk37K5QQJ2NdbbZW8a2eG/ttw3Wjqls9DVHo3V9h31Fl2yj0vgJw0Lx3HSGVVJhaT70aMssf0qOJ8MLIvf6xH71/rvEAm2RW2CxfIfK8ixydelW9FmM8L/z/wZxdq2TYZt63KBu5W5+svHSCijaDmZo9yebyy9mMnY/eNs1yPoPBf3exmD8AN+w+KmFYW/qcP8arL7nw03q+vpu54q6BzQ7Zs7tcZ8E901Hy9L9W7fDNeV0BTnO0aCB3S0wgqjR3m7fPXd1KlDCppo3Ecm8s9abNiXof5TvqLrWWFlImNIu0M2Jx6HjK59wDw==;
Received: from [10.113.77.18] (port=53470 helo=smtp16.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1t7EkJ-00HOXf-TU
	for linux-kernel@vger.kernel.org; Sat, 02 Nov 2024 17:04:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=; t=1730556295; x=1730646295; 
	b=d1OMqG+LD6sPSNDgMjxd2N+JEFI/EU/GcQLD0LIyksB56rdaORvkxLME4IjpFGwRijhAJDH8t1O
	0wVv++ihdQsAT3RJ9/EUA+KY7u+RmTihihbe6jfH1FdU4alq/LLbcDD0Wm0TbkPQ41PkRJntQI+xV
	w9ovX+aU6BQfCM6A19IPzg/DeqNArtlv7rAkeZO1zsP7MpC8an9OdkzfXfqzMa9PXmRCUgJnirEh3
	D4abYiPkJoTJmV4N/y/bJqf4n2dIZc07Btj+ZTCAGEhDf9fgK+iwfEPu1WY9rIObsy9YFAj3UPbzI
	W9S2/XdbpS5IXDyR0o8tXF3qrgV9JBydIenQ==;
Received: by exim-smtp-6c5957b6dd-62nrj with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1t7Ek5-000000009r6-2ZNl; Sat, 02 Nov 2024 17:04:41 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] Introduce ack_after_handle option for regmap-irq
Date: Sat,  2 Nov 2024 17:04:03 +0300
Message-ID: <20241102140407.214813-1-fido_max@inbox.ru>
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
X-77F55803: 4F1203BC0FB41BD92733C19FC6DB0C8B41909C66C56D5E879DADAB0A25D27B8B182A05F53808504042B746769DD4FF153DE06ABAFEAF6705F998EC22E7DE13C192DD1CC046010E3FFB9BA65748D3C19F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CE4525FFB91B9BBCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379C6642364E0E74208638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86CDEEF0B0558F8F59D3124C72D5BD28C4440400D6E748D9F20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C045A75973B56231AD8941B15DA834481FA18204E546F3947CA9FF340AA05FB58CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A359038F01FFAF82389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E73525A4AB119743A3B3C4224003CC83647689D4C264860C145E
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A54DE396CB953FAF4C5002B1117B3ED69691461D99F1EEF7D1D57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEADA757276DBF662F3EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC7F4243AD7CD7D42FE41698D65D243FBE8E4AAD5828B8C92FFD660E9975A9C79422E0C78D0E153559C95337E58CA42E6A617E0608B0690587F52A95017EAFE1DE71E4786E91A85EB9F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqaaUvGuEMYEJkA==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA219E90818B72B95A8DB39177D9F8DD0FE3C018A7AD8A6A979C690DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C55E9746AA489521B4EA2933C33FC75463D098EA4A012CDE049FFFDB7839CE9E2138FE6B7044404A9D101B3B4E5898AE25BAA723BBED2E7ADAEABD8BBD4B4BEF
X-7FA49CB5: 0D63561A33F958A5A73C8F02ABC25626230CBBAEAC5BDAFD8963803FDFEEB300CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F790063794CA976D7634B470389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8AD7102AF51AFB197F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE71FE705C1FB16C834731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg5lDvPDwqaZw3ZxZ/tb/wQ==
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


