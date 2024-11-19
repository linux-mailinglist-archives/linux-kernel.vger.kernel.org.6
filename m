Return-Path: <linux-kernel+bounces-413867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED89D1FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D823AB21C32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC015278E;
	Tue, 19 Nov 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="SM6cs1c3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="V7KMHKtU"
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A332563
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996072; cv=none; b=BiErp3ATFqYk1lD4xHqzczFuv1qrF0DRJlXkKgXzPdHC2GKNFuqO3xKU+mWMV3G4ttvgwQwa3hCEzemzLi6QTZstXqcplAB0JLEC3rNCpKcL4uWXkpqZIbxuz4y6HPc9LrhpYCYgpeExsvb0Gt6v6UTqVao/zaIOrFUhdjXJ+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996072; c=relaxed/simple;
	bh=kUsasvJVlCEwzJGmtlq+qzgmExFWVdU4/5TwLXuCOnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhHHSLbBeGKqYdOfrhHf3F63Cp8d7DQsnZHzR8f9jo+6COyPeM7OkxikVWwMhsOfuWqP+S60fFEQ3RkLDjMYKI0K2IgNmiPTZ4Oun0nmipmbcyKB/qVhjR3hAm4kK4UNDYN1oGkPQFoJZLCHRYESFtPLqmNvb5Q6R3bxlaiLJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=SM6cs1c3; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=V7KMHKtU; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=;
	t=1731996069;x=1732086069; 
	b=SM6cs1c34wQZzIfP8OWmU3TuIyZj1Uz7kGGyJGWi5XN98U8Zj/vTox9XDiCxRaZxX0+850ZxVOvCiG2YoFlwbX+SfXJI6O926xd0JuTKbSF3zzcfuD+X3KqD38f2PpsP/+Dio9ffGUSNzTob2Zi+/f2CZx+91SMRJN1FxgYb8r7AANHfSXThNU2SVvfF99nlMFGmkCpustLn4tbj9EicbbFGue5Jjlt219h9gOnLBWwrN95swNdqPy37RUrnbQvVt437r4LY8G+hDyP7DkiWxDdyF78ULJQXlSUdZ/ND9OJY8rquF0bxmhE+/fNj+OkG6ajIQG1cFnsUng9Xh4BN9w==;
Received: from [10.113.70.138] (port=33216 helo=smtp46.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tDHIL-006GYw-GG
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 09:01:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9Ir51VUvnIJzd5JQOpezctLW26R234HjRtB5K862ICA=; t=1731996061; x=1732086061; 
	b=V7KMHKtUynNMbOvQK/I9nGOkwq3aZ6QVk1kZYD04e5vS65SU2rlZlcPyhrKoYCALmwXX1LVH99s
	Zp/o50qWLCZ7UZcGFbvOO0BYyZ0n+12Eyn/PSiCCf8zKpzfJdeFEfmfnQ24Z0rA6Hds2RaM+ktItJ
	5jVh59DzwE+VPq3ix2vSe37hdW5DZTCWUas6SHMMwVx2ogEimWBmn5gac38ZqKNFmgRy6e0efpB5V
	8VtrNQ+2jcpAkKK7wLcM4X2a9Kjl9ac4tLQ3fQmVDidIbV2CH02eRbmrm2xdJGV/pVyHjUise2Xqs
	nCP0rvKD6YGXczPnHGrtw3g5w8TGDkrqczDQ==;
Received: by exim-smtp-5b7bfccf9f-rgnt4 with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tDHI7-00000000JMW-0NCi; Tue, 19 Nov 2024 09:00:47 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 0/2] Introduce ack_after_handle option for regmap-irq
Date: Tue, 19 Nov 2024 08:59:37 +0300
Message-ID: <20241119055944.363498-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95367647A2C12583F2A29A81555A635B5E0D4B3896C44A3D3182A05F538085040C3BECA2E62DB8D6C3DE06ABAFEAF6705A3A03ADC77D07BA1041C3D1E536A63B8A39B5B018D1B5ADE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7484B509D84968742EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C90DC8285596FAF18CBF9B4888072D33C4E7041136F9BAA1ED71DF9E95F17B0083B26EA987F6312C9EC26055571C92BF10FE5D25F19253116ADD2E47CDBA5A96583C09775C1D3CA48CF53FA85A707D24CADCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C068077CCD40B79AC98941B15DA834481F9449624AB7ADAF372E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C309A7649CC036878F35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5F89C270203F026835002B1117B3ED696660645391A8FACB9B2920F75BA9A967F823CB91A9FED034534781492E4B8EEAD5E26F3260102D3FBC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF08296464EED05D3102317A4E4ED47164C87E7D087712DB5D885FEF58051EAB30C7C5EACBE3BE5B470C86AA3C630759CE1BD3C7B64CC616FC9ED4AC555409C695FEC876B75C1AE32A9F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy8eZuKLLdgPmA==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA2191638FFDBE392D4E30F923AB1F91218939FF71088B6058C4090DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B454E1DAF28AA7D56D7BEFEAADD8CAC7ACA38354C56C475FE7049FFFDB7839CE9EBEC99E045F597705A141AA30A3D7C79039C155866404E287E81F9D23DF9B6D6C
X-7FA49CB5: 0D63561A33F958A5E12F27D328AB63C0F1F551FBAB60074478073B57FA419E47CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F790063794CA976D7634B470389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8AD7102AF51AFB197F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7D699F3A2029486C7731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojeF9RWNEuWy+Bticod3kwgw==
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


