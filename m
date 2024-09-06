Return-Path: <linux-kernel+bounces-318801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8496F38D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22881F21CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6D1CBEBD;
	Fri,  6 Sep 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="VaCD4eKR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="BIcByiI4"
Received: from smtpout149.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880321C9EB7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623406; cv=fail; b=DOpGla+XphAVA5zFkfsBu75V68ZBgQPJ8RmEzowj1d9LlttGnT4ixTdDk+XwlB0DsX22799PGctfP30nfDQpuEnqrpsDnO93YprG2Dct/ZkfCNFma3g2hfLcep+DSpTSb3mJwT4/mEROspUEc9wPYBQpH1kRqeDg15oSyzVygw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623406; c=relaxed/simple;
	bh=EG4HiiP692ZZmlqeUGqIU7eU6XWTDQxHJUQszA7oXPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN+mQ4cXZGWVOsTeCON8dMlR9iBfFBxYoYid67fBJr1DZP/a2MnXFApghFpXG0zsHMJL8sWhRnpMmV+Wka66nRu7UqkARpeCh/viA/SfUUmcyc2oRMNCYq11wMoLwnlkGue1IDAHT9ISobGWZiChPH+BiGXp0yLAoJw0x7DaWRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=VaCD4eKR; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=BIcByiI4 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id A9B81349638
	for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725623249;
	bh=EG4HiiP692ZZmlqeUGqIU7eU6XWTDQxHJUQszA7oXPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaCD4eKRKdulwYnx73yvztjXmGEb7eBS+GN24/yBhS8E808mYvm4gaeuOXDqjvMDw
	 ObZjsjtcncYgyvwyONtaGfPYSksTq2/UZAMFdgwpjYayKbm69TirlfB91hb59H12r4
	 p9V4eJ5UEMfofn1uJkimEEGXpL7zyzOnwHkze52M=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 5AC913494C2; Fri, 06 Sep
 2024 13:47:29 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011024.outbound.protection.outlook.com
 [40.93.76.24]) by fx409.security-mail.net (Postfix) with ESMTPS id
 7790634948C; Fri, 06 Sep 2024 13:47:28 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Fri, 6 Sep
 2024 11:47:27 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:47:27 +0000
X-Secumail-id: <a301.66daebd0.757dd.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZnMoDXoITMbBTiBtPFVXwrnYaLNilVMUSg1Cps/r/P+hV6nKOE6U3RchYnGWhxkjP4eYeXSDkSYEjb+hQ2awB09vK/X64bxHje+YJXzeEQ0DQirWMBCWyeXKfAARSy+kgx49KhqAiLqB4Kavvp1aXoJAdG/2CMtMl7qGjeFaO9GpHeTIJ3JdgETcz6uYCZ+iwqrPKDdoWDVq9gnreYbR1o/JnnwhF+tAiKpy5T6iO2asaViFmPBtmXYYmdCcbmqux6v6c2a6iPv195damo+tax1cGy/Q4ok/HigLGDNBSHK82eTFiKrmGKrMred6lvrU2vEiyFkP+22d3mx9MEBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZwwYglyrTx1lEXqvosLDhicGEulwOlV5lTFb70/X5Q=;
 b=FVzbpJJ4NiGsotqd3p2i47ltU1PB5KKgv5aT0D7Sd/T/5iB+2hqDtQgixS4CyR8JYpX2VeMQPBG2a+sBeIVnoCNldsp+AluT1cle2J3PZqlo0DE9PSlW+aq/nV0Gej+RlSaskWg/HvFqqdZfIwtTHZLKA0UYHvUOpLbz3yh9UERk5NHJVmalBgQTm9zxLHHVMj5OQYudDervR4/n2A6B8HdqNTpkGteTI0SBmV6UxGr9QHuhraSt1jXoudElpY0qF1orktLIuh45GbagNZI9vfftwC+/C8L4i+DfCzSrTfGtMTdNP1kUMZGSrU7WJ+VzNxkpkTq9IbkSiS+glNORbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZwwYglyrTx1lEXqvosLDhicGEulwOlV5lTFb70/X5Q=;
 b=BIcByiI4XG5VxeG/2j3cs4mDokKUUF+2Xr7aedAoQWlBOGz9VNWy2Ww8HmiM89FBEnWKNs0yGiFiYb5HZgyWjcufJ2SEpbn/ES2/4X5zhe0Yid3J8AaCoqXC6KH8UohWDAA2mFENe/QmLFT9s6y5WC0ZlOQzgtf7sRDz+CjBP8YAd2wMd1n/MRoYpofxffN8AUaVfstcamkkiNuD7Dc774/FDJTC1amczE8oo+tTCCRbKx5KNi/cvsd4qqw56lbIP6KzPIUe3LH1D8Mlgpep9HYeNOD1QP+T8DyfSst6TGxOdhZpoaCKmRY8rGuDOqzAFQAhMJzQf2+ZNFhoOQO3ag==
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
Subject: [PATCH 2/4] Activate GENERIC_IO for the arm64 architecture
Date: Fri,  6 Sep 2024 13:41:49 +0200
Message-ID: <20240906114151.519028-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906114151.519028-1-jvetter@kalrayinc.com>
References: <20240906114151.519028-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB3466:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb174bc-4785-4006-3e94-08dcce69ae92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 1STJgIdO7vL7ELnRRAoG5hT+OPzFmhU2OaWPBgCdoqvsnHBF/xob8XsZEDedDZ8HGtu784zpKsY6fJ1AKOMxbnPtAmZhGwDVwXcuwJNBE3QGvnwYHkEo4uQc1UiFXY74KaIMImLjA+II1InfqUzvWArtjdXIxI+mDkdPLqFbzIB7K/eWRiggqiJ+N+4tWA5MJpjhTQ2VVKEp4ulnoMuQUgH+QMPwkpezgdrgsSDd2aeyRod3o5qG9m7k7/d3Wb5eU1F6yZjHghOevm6MLw/SZEFtNtyi7VoyyLvTrE/5Zjn/jBuELuSmF5eQTyJhJSULajUQq0Jx1ycJGDb+FA689CNGeA1BnCP2mAol6tO1NECBzicO3ZuMqiHReL6jLGqER4tHdgnG/xi+VS3FtghQruTE2plYm+ao99Nq+DU3Vrg6QbL3BftsSP2Jswg5sCXG1t/ZFAO5ygChqG0d9W5U5Fih2eWxMVSOQ9vLmydbMP96rYvlmMH9E73Tu2bZbREyrKEuzaa1Qrne1Y8hdrVGMkXjly6/6MInccZ+7BaHJXwfqAsbntZ2R0JeHCLz+JN5N7vvl6glvNUG68BfhA4zrd+Frnk5c13uQM3CeNeckV4Gb9cWPZ5VlRUrys3ux9AxSgkeobuXyaPxt9Zi6KwNSEYtISO6cPszTvstQyBoIkeDgReyZ1lhfZnJp2I56wgqbck9C0TFzVFpxd1akM+pTS1821E9iHSUMUahG70gp6MTEy6O7hQd6x1SEphgWQhLl5ih3wkzg98ba4UdVQBOyn9hLPdyrDpTkDOWzr/6kgGdoadOy5p4DdgArX+bHqAyrwrvOPyZ3l9eQIHuYPSwo5URhbvgKRs8CknyzuU1399QExGDCmPyCXO7oPkhvAeQjXTAgwhH5TquCYUG7Ta6jj6acKsCXtI0zaA6+aUr2pnmZY956uQKb8wV4gl+DDxIRW3
 oaSJA4KQBAPgnkvvPoI5k8UR7oPcQ3qN1Qq9VGkD2V4R4mL5t7Y6OiKaUe7XBDL6SU7zqMqHL2qVXTFNs8dkRENVO23SXE/DRBdpoPz0n9lLcS44nN8ZSaPH9kenxbrdI5fh5ACg7guEIuMSqlnGPBvXEYL1VYopDOFnxiRM27b6QJkU0uxYqwDzSyyWwbRm9WzHs4Pl5YO9HDkDLiljBx8apzZ7Ukby91Jfn4pAejn4UcTyQaVvLh5+fw73CpfGrImY0j6NRfBpqbV5/kheqrTJs/jAKeIOuVjgYwO+DeZ2uVQcg1Y9ZEQE0VHirGpoz051vw8GmWuo4Zy2y9rLjqFkAvp0PAgsk9uKjcjFQNCTTNE6Dm0GVwxS5Y8rc+Aw6geJ/Q0Ex2y7OM6Ii+m20iPTDjjSarEvonJME4jsdP9vCYoHLTmxolyk0VoTxAtyJY3qKE7k+lTPCGsEMxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c/xnib0RErbGpa31mYkUrrsv+iefpQ6n0rwqL8snrMYuSOvi0w50ZhhKvJFeHauE57BdZW/JgNELtb6caEBAjscOTWMywRq5rMWBlVnECwOw1/cWBjl9ezj/IH/I2oWAgCpUXX+d2oxams9Ukb1QPqm5qhC9eyqAkcaGIm4ckQ4bXHfNcM/R00qvLBjXJTlbAhszRrqrtL/L8UvTdJxBYDcTuL98+zJkRrLZB3mvdZ3nWn9NKt+eo4/RSVRPKz6PFkOnT7IJPAZSB21Oy8vsGwkRBcHYPNnQ9m/x+5naxz+7eQmS1R/GX2YtP+YBSwepkh/ELUPKZNQe/9pbX2U6brKAzkGwGF293AN/tVxrsF2pzphIfnDkA/MCCMbMSRhHSpxV9u8D5BQ0Pjm+xJmaM2BDT2+l+iFGkgU6aNBlFT3zYzUadVP49LXyuOrBd4hLT8Z5ygOiGp5u8drojt5L/VrEoRNUfoVGMpdtWIDt+3xL06VvZfrorsDgdFXm0QUNrY1VVe79k7Wi/C6hDsYDyTVp1SP+L3ZaDtoo9wR6D+fhwLGMJ/9IujhNMtxStZoX8Q5P1XAfmJbXvWLcZMhfyWj5SxzYk2xnAtXH5BbPPQkhtEKi+HDKjB0GAXSR5pCAGEvFQ9rrDTqxxoWxpFau4Vd6eo6dvrt0rDFxqLVcbKkUMwFLovMuzeSgzTLTspwJ8JC62KPt4EjzjTeUwGijT9TFO5HT8sU7KTj7ObNKcb++5S+wj5+XPYpZVszTp79pV0xzmK3g3j2HoFjTEsu5GMroih7jGnme1g1I2I9x9mM+a4uEgDEx5ekGKRpxft2Lii7k/UVvfO/6b4Gocs9VQ2b19GIvgVORWFdldYebxV+v27LYZzzwLbKeMCc/xvI96H2eRZopgkiTerPxRf86f+9KOXi9dRkdWb4tXFjeOe5GyaEj3nPqp+d24HdKdAJA
 HiK8EgJzk0FI/ChV2J2NK4PZl51wElwnQKRL+O5xwu8uigbfHVIW9w8LEnMlzqjtw5+PHl5wIE+TtGcFcw8uSAx+VJHSBcOPFLZfHgknwudYQjE0vHfGjsMEu8bpXWG3nWrOBSuadCfOn503lstP4pI9vsbKomMN7tzneHNE4poc9C2jwIO2PyPLtc5y9hCfP2/Gqpoims7V3jQYvvK20PG3OU5t3r53RNYPtecUG3YBDOsa1FUhgrbzFxxKRVb5omPUKhZ7d6Po1L2D4rFyX08P8wgAGq8Aj7Y7DvoKgtaHz5n49FwB70F+VKrg/GW7f4UryLedvxqMwzj9HsQciRyCeIT5B5MNJR8T8N0eSUooNzgu8MzocmEHriDH6mRepYx6IJJNEFNeO3GSseMJ6jiZwiiVL01CFdYcDPYu4hCMtL0ihIE3jbGmgtp1ryG5WtJU6Hn08zFS60Z3m5NTcROENO9AKglg6GzREQIEJsx6SOoRBpuTQyLS+hLgTxIOLcTko5hlhIOaw++HBF0WoiDxZILnoc1gXIZF5uIk8W87wKzrTNAXohvfM0zof0NDs4bM129RZsO8ZuJMCWs73h1XoqRKNmGin8A8K4zBFHSzyUbAtQGcDtoZ9pnmheRxrAxPSWblrWUpFLbsiUWK/w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb174bc-4785-4006-3e94-08dcce69ae92
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:27.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS6H4sPhjpgucxumoWqaCnmdN6+eePGQE9X43kJCfsomzHujyQY77jQTQEVB96Xeb89fd8O2qadA4ajo+M9d+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3466
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io for the arm64
processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/arm64/Kconfig     |  1 +
 arch/arm64/kernel/io.c | 87 ------------------------------------------
 2 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..3e5647597a03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,6 +140,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IO
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index ef48089fbfe1..fe86ada23c7d 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -9,34 +9,6 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
 /*
  * This generates a memcpy that works on a from/to address which is aligned to
  * bits. Count is in terms of the number of bits sized quantities to copy. It
@@ -78,62 +50,3 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
 	dgh();
 }
 EXPORT_SYMBOL(__iowrite32_copy_full);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






