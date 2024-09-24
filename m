Return-Path: <linux-kernel+bounces-336879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A2984205
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9136B2896C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3A16F0D0;
	Tue, 24 Sep 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GOpx3E1z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Pbc+lq5U"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD20155C96
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169907; cv=fail; b=oOyiibRJwwcAgUXKcgISlHn/gO8KuhDLyu71eKSUG7N0KgVCTGNTb8S3UCiEvgdQD9sBqtMJ3/JiWGpS8pcYRT658naybluCx2rBxBGPF3QFsaVuwmjr+6Tp1o2luifXTmHFd+jQhfwyBWswME4746HmV2cgYsmodiu0YQfqq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169907; c=relaxed/simple;
	bh=uHDwACn0oq0R87FWS7YdHeucD3CxZyAJGngfuIzYS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olwYJQgGc1UxUHoz6WkVWeUaafsr1ity/o2+SJtK6lCtCW2eBUBpv3Y6tbpCEOLaPFa/M4ZIUWcAWWYwk+1i4J7jmDX81++7bohB+RVwIAuLJNok2Ryk40eSGTpPNMrZNhPfizKFm5lhrcdS83sbLO+z0WKd5VBaTRf3JGDyfb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=GOpx3E1z; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Pbc+lq5U reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 0C474349537
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169781;
	bh=uHDwACn0oq0R87FWS7YdHeucD3CxZyAJGngfuIzYS5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOpx3E1zLMBXoq0yndwO0NEkv8bmfYKK7gP7bHjoCob3W623c5yV7c+/QI4HqjKBY
	 L4qUo7wmThGtUcMrYBpJnEZsgd3ygn/ddi1gllprRpY1i/olWW9rqSuPN5D9n68gxD
	 bbF2nKetSg5THqs/0lJvU8vVjxRgp13vEK9nlzLA=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 9DC1A34948E; Tue, 24 Sep
 2024 11:23:00 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx601.security-mail.net (Postfix) with ESMTPS id
 B7F0A34946A; Tue, 24 Sep 2024 11:22:59 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:22:58 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:22:58 +0000
X-Secumail-id: <17991.66f284f3.b4edf.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeTUZ92rMqppuXO29glCu9hGhuRg/Z4JXdCksE0f4gZn0BczjVNKDWEUcl0j2iPcDeRqIkOAFARNZvovfq+NQu6PVRoRIxQ+A+wNYjZf/aG7lbt+JPEtiGUdfB6s0ZrAR2e0Yp3qH5/S2uttif+OAEDsMlIhsbNRsc8tIXAoCOyFH4ydOyzadvc5VraZO4cqQb/eNj1L6Ji/zmZzrlnpT6UjZ7RQV7Avo8Jz7rxA2lml8fpMXTJIff0y7U2Pk1BdKBA0Dkqki3hjE2kkAs4CC/y4oJZohnx5oTjwORZhxv9XkbMiSuIe+y1z0u9muYUXoz78hC408R1IryMGDWx71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsCe7cUeho25XXzvkTKqw78HiJM39gQK+E6IL4W/sGk=;
 b=XXCqdCrNeOQy0V4zuxDU/f1dpte9b25wcdt8VO0CuXLpXUxorZbpfK3AoDnbJAIaJdkm8ygdWImxl/cHBmOC6FiKO88BTl8wofdrVgfkmv3ih9KIccvuztmLMQjSSpL3SbVYN0DZGMFihZYKp3eoM3PBlsOdc0QS5AkedXlKunCN0Bamo5Oul7tZXSfPyD0Nsv1D5enTaFuWuPEaxOPsJOG8BXlzCuSrSaLKNNOCugL+D9R+iZxA1fi+sNXuTVRFYTuvPmiyosotk8SldHArS9n6e6lVXF0OaVloxVJp/ijOLw6DnTtB07PiqRLvMaDs7fNeLXuDdZiKWnsKvI4quA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsCe7cUeho25XXzvkTKqw78HiJM39gQK+E6IL4W/sGk=;
 b=Pbc+lq5UYNq6FQMIvng7w50NIT4UaYl3UmQpfa7yenFjrnfRd0T96zTM/QhpgFXRksDic+ga9fuLnkuCoB3vdvg+dwqiTREuv/QzRgdif4JEj/VsMyNcXZ3Rx/RXluvYT5H8lOeo4A8/fzFN93kaPfN/1vxuQoJtMhjTDP8NLIv5jy17PCrJzjWY8eIxIOQI99gozafSJKlclU1Kq2NCk3ZMzAM13CfulAGBz+yvu0xSVe+SyBn0o4KuvM4IFMuz/377Vf4yvlXRvChGP5+okwqOeGplKb+DMb3AXrDjcaZL3zLOknnrJhGr437ISvK7+k/nuQ7RnwQMhE24mt+a/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v4 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Date: Tue, 24 Sep 2024 11:22:20 +0200
Message-ID: <20240924092223.534040-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924092223.534040-1-jvetter@kalrayinc.com>
References: <20240924092223.534040-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3073:EE_
X-MS-Office365-Filtering-Correlation-Id: 07867b9e-32f5-419b-d3c1-08dcdc7a7adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: kfe7wXRonbDz2+mezFc4rHKWjTZjjrLkVRRhCGUc357i0Zdrm3qt48x+uk6phQgkU/bxBwjRErFTkE3giFgUxLbT74SnQL7CGu8Ldy3G0PmYj72LFwelGAAdg5Ij4cISL5SWtPOrcKGWdZ8Ebm7iwVpg5Zrz1hucSMSuqnCUooFGfpxOVlboiUzp6MlheQl6ZyxUNh+dxZ/Mk2sIi3JMG9idM5BGMt4TeK+HzP4HhBlHumtC+YNKK7cNS06plilkAlrNAnzubrHn4LWmJEFELL1kWMr0D0s32j3BMudI3tqulDKzgOzcpZQaLJyCTfKs7cDXZ04J9f0PwoNi4Ghuj/FdpIDYMjnt3wUmum+LzrETeufP47P2ADxFAKEc2VXdtjxsrrCV4wUFC31dwwzUnHf3IrkRDvrSa5TuHF900yVOJCidtgHTikKLhdBjDPX54azjZjDtDN65GLtdEunRPc3tdfotwN5ji3Njt+zrlrsoYG9Fg90hmWnOAnOO1lphMp/nbhB3TGXV1pB7OD1PZ+USlB5xMs4/RCW7DqqIp6Ep0wo4wnJDmBSUqy1gAtx+uSP8jvg8dQBhQABgM+ox69lzjRyFMAMKu3OKlpTbOSrmyo+9Rm3zyhhiQAdD+34Upuut5A1Y1txEy7eroY2VM7h0nh71Zk+VROwQuvQ2T9efNbZXdJmhi4GVJAaiSLJnlXABYK5vlfIaizoBnfLTgTo2HXva3inzXLZr4DBdwDLsfgNis6qMlORBlzPlvcbIazUhnJ4JOFrFJs4JgLhjgUdmVOfL65u4hyu3TftK9kPPkGJyDTGls2vWu4IUi9e2fD8YBir1jUfQ+vZRP08Q/zjz3ehkt/Ng4MtfTtZCD2+8bXqqaAD8FWd3Q1Wb/QlNVVS0U4XxnrSZpGOwTzDtGXzKxyhJzRQ36UKvDTsBssUf8XoQvntxKPV3i5c8emqVt+3
 gYsIux389BPpERHqBSuEBH/8Jmti3QsbLioXSTeFDTqguW9/KAu3ewa9EqRdEV2MtTdvqYVbDtKA5raPrQphm16xJNp/+B7yBBY1puiNR+9JUWqwbpiByNs9/Jkyt7qld/irUOy0FZHG7s99t9COrkeuv0eqQeycPdDllSMlHEoZXZOE595m/vO4ToqQ6mLKCrbFY4shox3SLp4Mz8xWCO77L+rYSJZ2T8WPOgWySR3PXfyRTydjs1PeHrxz9vZBoy0BOgfloDm/pHnPKdQlyL3SRCOBKuNGLdgsoOmY8xZUu5WHcKHXsnmjTohc6SISHQFcmAuh+/gpEcRDeidzp+TNbUryh1wnSBg4/3lE4KT9fA/+Tk0fY7PAgW8yTsQo42cMWd9uRogqL3Wj+Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oiKq4H9htI6IJPVWNp9DcvEX7gekG47MpRCuvjg+WyDb/YvNSCC1whUbOR3bKYJ284bRJC1aCubTcpRZVRgxQ0h6cli5qdBE5bQu4lPPiCaWSXAUMHOGdBsRJcjfy1fAts8CiJJqnd/+45fowgD48Y8BlmJXRwK2R7KUNJ6+YcCp58eBeSvBJzUVp22D6LJ89l9+ODCZlNOC2jbpnKCWy9X1gzch1VuDhASqx5HgHcF3FGpHAA2aIq3Vbm97FMZ1qLqlF2ZJHAUiWKkGF60F4/O33f6Jt9VNfgC06or5jMFyIOX89q9LxSObSCIHRX3EKe7jbCoa6cyJNTOq4escGSpBeAEJ+7hWIrwudX8Tk6QRAdGN/YtC7K4xUggdn+bbk2Fcr6kY8sBhttkyESiI7hEgskzm0NV4zdZNVJLABFthrf+SyVuIoSCbYCNWfc7DC+/qvpXMq1Wsmzgt4nlnUr/FXFbU4Y0K4ltcNV1CJ2jdmataKSMNLhZ3I4CNOgVngEgub+V/y/eyL01YqbD0Bl22e0meuNLENvHltahbgjt6JeIIag7fXBO6dSSTmd4t1oKi3gWdZHFZAJ3ueFx4o84ERaS0Om0/6xe16qATNGRiVNw7owVqdPYOIrswSUJvXdiX2CEEeUIpa8SW5xsY7gMVAjuu/9k1IJBwaQEJszX1XxYpRN+Hu0xzJf0i2aPX94d214XcHyJiXLqPIZP8Jhpx+sMMLCVPoOmV7t68qpHAn/r0oJZVAA/wW5MATdtTFGbGFS9XfUspEQvdDLVQ54ppNBSzLyss+XlRF7/vNw7MJe6uKP6+E/0gV3C6V/CfAEPCkX+e7JDFXh9IPAJYpAB0Ij9drhUS87IHvMFRGZsTgV2u0rE2PbwR+hK1t2D9ZdbucCo+dU8wUR6Bq6MY9YSVjoP+rXL+KLLdyuCcHLVZWuy+kU5WUzquIs3m5I4T
 TvsWoxDJ+Geb6/K1QJcvU6SSFxkoFSeV4PBFOvftYKkFFt4mn5lw1wTb7z/Y7pq0e0q9ckvP8w9E5ub38QhCAz3AElUb0OYVH30ejxjrtimtiDP62EZY2BYe0oNVMYG7esSRfMTpMIDgdMonxkCvBAd8Y0w4s4JujC3TnatHMTdRClskasPYeZbwAGQtVpE4dHxEoqfAKtlmWzg1blWHlOOPPaM7KnYbiz/WbB4mB7J6Lgls6gp40xgnRDFcoRBiez7hNOQbI70xOtxODNr8fHreIrcVxV4aAFlfXJbo3Sb02uBoro4SZ0mGhPNgDl6OjNBTQ+TPx2mkGuRD8BAuWP1J1zt+fqkUa31Tf7d15qmcK0xexctyE5lXUPWIZ3Ps0M6JGD/C8vtINBv+Q5QvlkQ3xWXrNHZa+a77lZC4Md96SONoi2q6eW3lpMP3QlCt6u5g+8ly3gMMNmBXaV+YlzMhfSMKZ1miFZbVbWFMERcSfFmCSuwrh/nEhrlCwEfA3p2w2aJ9GA1IbI8z5E5V4ebyuNfh7/LYjsnJI+3aAhKTHZmBFvoEzC7wCqbsUj5mdHt+r8M7sz+kFkxm1OorCuVAnB8h3/9qRv51QQ7+Yu3z9ZDznHxg4AQEb3oS5Mom
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07867b9e-32f5-419b-d3c1-08dcdc7a7adb
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:22:58.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwTPX9vtj7+PkmmXi7Tp3CjwDLaVrAa9sQU1Icx2W9KeGfPmzMxzIFiZgfMdz7igDm1y2fWqVFHySp0KL93U2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Some architectures implement their own memcpy_{to,from}io and memset_io
functions, because the generic memcpy_{to,from}io and memset_io just use
memcpy/memset.This commit replaces the generic memcpy/memset functions
by IO memcpy/memset functions that respect the given architectures
alignment constraints. So, later we can get rid of the individual
implementations and use the generic ones.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 include/asm-generic/io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..0f05d2399938 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1163,7 +1163,7 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 static inline void memset_io(volatile void __iomem *addr, int value,
 			     size_t size)
 {
-	memset(__io_virt(addr), value, size);
+	__memset_io(__io_virt(addr), value, size);
 }
 #endif
 
@@ -1181,7 +1181,7 @@ static inline void memcpy_fromio(void *buffer,
 				 const volatile void __iomem *addr,
 				 size_t size)
 {
-	memcpy(buffer, __io_virt(addr), size);
+	__memcpy_fromio(buffer, __io_virt(addr), size);
 }
 #endif
 
@@ -1198,7 +1198,7 @@ static inline void memcpy_fromio(void *buffer,
 static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 			       size_t size)
 {
-	memcpy(__io_virt(addr), buffer, size);
+	__memcpy_toio(__io_virt(addr), buffer, size);
 }
 #endif
 
-- 
2.34.1






