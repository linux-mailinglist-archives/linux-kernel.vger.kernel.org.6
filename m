Return-Path: <linux-kernel+bounces-446807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD099F295A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F733165526
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D311BC08B;
	Mon, 16 Dec 2024 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="nBqrHoJc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="MaJic+4/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Mb0luOlz"
Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD941119A;
	Mon, 16 Dec 2024 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324717; cv=none; b=iogACbKmfHRJlrWbCJAFn2HOVCa8Pj5CbQT0upErtZ3ZdWAF6J6AQ2j9n/BOgg4JxUxutL9VK2zrG40bDD7nOua8EkcfLI4oK/jeHAJM7JFCcmqDsDTovLBGO0LU0j0QibuZUVxomB+1Nk3+TDmYZXI7cKPJ6+xYbQyB5kH1KFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324717; c=relaxed/simple;
	bh=shcYUX5vatJQfnkia/P3R1pz3y5Ht8q6TdvZ6WAQp64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKwz+g1HqK6Lz4YdjE37EAHAp07iGcpL0/FKgDY6pHBFLlsJ93jCHzdc06QpPRSJfMxvPzTb73fT1sj0cmKGFBZUBRO7ClhLmkDKCPnxyNCRey4vfn/CqL+HuKRWGCXQ1pM7cKCUGCWWu5WtBDQgSueBN7tI4dknBTXozdr8mLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=nBqrHoJc; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=MaJic+4/; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=Mb0luOlz; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=pO4yI+snYhKbzwmv/rXlMitVU8ULe1kTb375+LWuOG8=;
	t=1734324711;x=1734414711; 
	b=nBqrHoJcqb3FKpQAGVaub7v5XuzaudNCPkJ9/3yFFF1mlgdy0l/IZt7Xuq3BGlf64Q62F3yhbpJTVabB7U992FcnCq2zz49qTTlJU0TO3uxwiELWaGtg9p6S5UAWcESYKTOes+NlIUHp7eZAbghlqyX1YyHBCynajzMg6fEUXw5XWYGFhM4QYnTp3M9QzQdJKLYVZb0wIRawI/P/M5TIbFX1dWHj+QSej8zqD5VgWv0ye0SirBScgw7kK+T5dVcSVE+gTbgVfDCKFN7s8dlttzO/uFNA2d1bfO9buNa11PAI4vTx6c+C96J2xvrZcD5UfjHUA6oZwQHmUW2nS/MKzA==;
Received: from [10.113.163.86] (port=50316 helo=send55.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tN2tN-00Dz87-Rv; Mon, 16 Dec 2024 07:39:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=pO4yI+snYhKbzwmv/rXlMitVU8ULe1kTb375+LWuOG8=; t=1734323977; x=1734413977; 
	b=MaJic+4/mzqWMe4ZXHuFnQMrKkVnxiz8e0LZ6hXDwLudoOHa1sqynsVacsDBpbVraBBLjeYv+5s
	0pxL+e5U944hOODkLoCpegKiPpiBWRBDVnhbq5qB4JswgDqMkq/u2Hrsxn0nl+IgCw6xHQ0Yoll9r
	ErKjlHqlv2vJfEx7szxQxvgkTT5U0Nu4EWkZY8l3ss0JL/4pGt6pPujJ0nm6lhHYMMTOu8Bch81Ur
	31cHr0VVJpqZe43t2yExmWN3q+b3WUWaNAIOxkfKsXdncCN1XoGY6IwAKu4h8AFWEVcKCqQU5kNjZ
	7ZU8TR0sKusE/0OLdvJeaBfuDwefpOiompLg==;
Received: from [10.113.249.94] (port=39006 helo=send197.i.mail.ru)
	by exim-fallback-5b68796bc4-d4c2d with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tN2tF-00000000SF7-44sZ; Mon, 16 Dec 2024 07:39:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=pO4yI+snYhKbzwmv/rXlMitVU8ULe1kTb375+LWuOG8=; t=1734323969; x=1734413969; 
	b=Mb0luOlzpxgY/PS2u1QlOgpjoMnm24R2XvljbsW3syI6zlnEZ3G4Zlzv59G9i5mcukf0HBvExcZ
	iSSwfhiKIeRmKcmLP8HC98t07ZXga1yAoiMlcm7Harm26XnzHoG30M8DX0XgDnZGPq/Ex+txvB+74
	vUfA1yA+D6xvZsK/nmOgiDZ6q2LHB5IyWcBSmc23fX2dVUuCL0Jxf+hoZhxz34LbCVWjlaBHYNSim
	3VCJzk3zg+WFfj1r/DfpcouOlUGaMEQUaYNTr60b7nSGi9L1xEWZwqnKTFEZCqy5Rjx+RzPCnQCwx
	G7/0WU+FGeqbFh6v78IbUjnACqzx8G1lpQfw==;
Received: by exim-smtp-76d484c77c-sh75f with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tN2sz-00000000GrS-24Cb; Mon, 16 Dec 2024 07:39:13 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: linux-sound@vger.kernel.org
Cc: andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	tiwai@suse.com,
	perex@perex.cz,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] ASoC: codecs: nau8824: fix max volume for Speaker output
Date: Mon, 16 Dec 2024 07:39:10 +0300
Message-ID: <20241216043910.11875-1-fido_max@inbox.ru>
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
X-77F55803: 4F1203BC0FB41BD977EAE61095F37AC56DA83E944C60B7F01FF5E58BE572B7FA182A05F538085040BD0C86E1AD3B7D063DE06ABAFEAF6705D5F0C2CF49B4B19F649E9C764B8BC09689BD80B6B4489A2D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BF0A1B3B6C8FCECEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637835928C62272F24E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D814F084CC3E29204B67B90F39F78F66207F9F65796329D85D20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F790063773DCDF0198120BE8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8062BEEFFB5F8EA3EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA7E827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE4930A3850AC1BE2E735F43AACC0BCEB2632C4224003CC83647689D4C264860C145E
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5A96BCD13058A94565002B1117B3ED696FDA76B72DE525F0B361FAC1196A180DE823CB91A9FED034534781492E4B8EEAD85CCBA673D36D1A4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFA05FE97CB63ACDC69ABF3B9D12608F7DD31D766767CBC9D7D845F9C07C9BEAD9486D6DC23143AA0E0B0B9839AE4C716C9D5EDB214F0EF656FD90C06316E45D4A4921331E214CB506034D55ECCE8C67C6913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojaQ2NfKPcDQOjSG1gZoFBuQ==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA2194A6B45A044EF17C899FEC6F5DCFEC16E0A3D3B0499CDA6B490DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A782122C14CBA0FEDEC285AF2326562DB2E68F3CF0E9FE49B69C79DC6EF635AF45EBD69C7A33469ECE14F250E37782E405A2040BC5B843AEA0B1EBAC62B62E91FCC
X-7FA49CB5: 0D63561A33F958A51A978F18596FDABA5002B1117B3ED696B11B950DF3EC314CA92FD30A1C74D94802ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpcfWZm7knnmrJdENjvzQK2
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A7890507F2CB992334917BBBC01B0F98AF368F3CF0E9FE49B69C79DC6EF635AF45EE00D1C991AB71C4A522FCA9EF5D3FCB0AC3C8A24A179AFC5
X-7FA49CB5: 0D63561A33F958A541589099BEE628C387D2EFFC610A908BA7FA9F57725F2948CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpcfWZm7knnmgD/ql6jfy+t
X-Mailru-MI: 20000000000000800
X-Mras: Ok

There is no audio output if Speaker volume is set above 25.
According to datasheet maximum allowed value for the Speaker
output is 0b11001 (25).
So adjust this value with datasheet.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/codecs/nau8824.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 12540397fd4d..5aaf8c496300 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -368,13 +368,13 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 	SOC_ENUM("DAC Oversampling Rate", nau8824_dac_oversampl_enum),
 
 	SOC_SINGLE_TLV("Speaker Right DACR Volume",
-		NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),
+		NAU8824_REG_CLASSD_GAIN_1, 8, 0x19, 0, spk_vol_tlv),
 	SOC_SINGLE_TLV("Speaker Left DACL Volume",
-		NAU8824_REG_CLASSD_GAIN_2, 0, 0x1f, 0, spk_vol_tlv),
+		NAU8824_REG_CLASSD_GAIN_2, 0, 0x19, 0, spk_vol_tlv),
 	SOC_SINGLE_TLV("Speaker Left DACR Volume",
-		NAU8824_REG_CLASSD_GAIN_1, 0, 0x1f, 0, spk_vol_tlv),
+		NAU8824_REG_CLASSD_GAIN_1, 0, 0x19, 0, spk_vol_tlv),
 	SOC_SINGLE_TLV("Speaker Right DACL Volume",
-		NAU8824_REG_CLASSD_GAIN_2, 8, 0x1f, 0, spk_vol_tlv),
+		NAU8824_REG_CLASSD_GAIN_2, 8, 0x19, 0, spk_vol_tlv),
 
 	SOC_SINGLE_TLV("Headphone Right DACR Volume",
 		NAU8824_REG_ATT_PORT0, 8, 0x1f, 0, hp_vol_tlv),
-- 
2.45.2


