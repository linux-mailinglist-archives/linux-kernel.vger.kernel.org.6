Return-Path: <linux-kernel+bounces-337581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD96984BED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC451F24610
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D813A256;
	Tue, 24 Sep 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJOWnu8x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PZi2mIAm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8780335C7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208658; cv=fail; b=CTLSfhHk0IB3RGXn6lh5DEfjsFyG69QqMgiiD2QLA7qpb2rJsmhQN9ipnYd/3hc8m/XWAd/GCyNQdRp1Uw18z9T5W1GJJCX9H2GtqT0lrwjSnx3OhHu5ftx8ByDNgmhmt+S8V1hPsp7SSKNVP+lgaTkW60KeLsRzGkRYPZ2IPwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208658; c=relaxed/simple;
	bh=yI0xwGI91iclju/vH+vz81RbLRfnXUiT4cXxHYxL5VY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d7CMd6Ke5aLeltd47eMtqOhHnTNXkKNPjjC2enQXwdcLH408WWphX8XJbTEk8dHrbSpesTttIuNhyGgN8EVQuvGvFwCk+a4AtYuSP2E4xxaREqg0C1Kot5aqVl9vNQZ8jeag1gohDeoCWA4D9DKavQIMXe6QBoj3CVAHjCRxTKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJOWnu8x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PZi2mIAm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHMag4006458;
	Tue, 24 Sep 2024 20:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=dgK3c4prp5J4ov
	vA6MC6NRiXlJaXBNcHXz5s9K5M7qU=; b=EJOWnu8x9AhTNQRhCmTMiJMn4TySKO
	d+G2JBq0YMbCLUj80JblaYV4gKCrUha6hr0dTj0kuWE0o/H7Z9naudTgTCP0wqrh
	0x+tiaB446drXKWIqxAJdgL03U9TSRJS2XnCHwS1j5Dmoyqr6dcId12kDi2WQfC6
	CK63Xo2iG+mOBp3eF995I0Eq1lQwUc6ru1Q5hXYohuhKwEX5gYWuDkTVm/8WCU8B
	bLsN8DPBZMitf4hRVf6Izh3gyBWg8JvByWF4XoGwPVpA+HnwB+0y3Qa3f52Ffy80
	cSEtp6N2StRv28PH2wILns0D1+mtHCydm3abJVX8tzbReXvpgltLtRzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1age4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 20:10:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OImBEF030480;
	Tue, 24 Sep 2024 20:10:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9snu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 20:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgKdEe2rV5BRH/7W4RsLpfQfOZSdePS8LxtMzSKj1SmkcvGUUo38NlMsj3I3E2YPNcMtaCUYlr1deRjimHa0b+zYB2GUJf44bDf+lirTZgP4yEyIGiVkjPCsZZRsZ2if69iWHqEMBhKyYm1iS4kLbKIbDzInzIc6P4paXG1ohIv0pzmfSOGeaZNGj1TkCCFtl8Av8joD1/ZVNK2UYCrk1sgoe3PJbMwAXgqIBTQHuGrQK54zw+bhQMSUjsxbZQwcEIFl3ul1O9+7S0jyIanvasO45xb16DzVi8XpMaVcmq4nGcPkie0SgtMWkR4BFB7Ehf3NTEZ9uw4aw02s7Dir8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgK3c4prp5J4ovvA6MC6NRiXlJaXBNcHXz5s9K5M7qU=;
 b=XV/cwdngBF7VEFkcz4XPWDc+Oarv6PDA3FYkwySUDeAk0BxZnyILrAB6CZsuGYTzBpiouKr+pae6xVio0o803CeTpPSPMriswVv7u61DWrBn8LAGaSz6Rvh3a1PrDUvmzqYcyHuVPYimlFZLDmJu3aYHhDTKp1U/VklHJkJfmi21dqfeMG8GT0HTO5jbOsZnjzjOsEd/aqbUvm0IksDSBLPdMm/XIF04Jr2NT45gWUqF8YVmgeTSyVUB9j/r0jdwDUUwPn9e+b+5FsWEtL972ANVrLZ36AfDC/XjpvNEv+I6z3+54qKenZ68jhj3OTVOHpd/9lRjdtWkrx4uFmLKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgK3c4prp5J4ovvA6MC6NRiXlJaXBNcHXz5s9K5M7qU=;
 b=PZi2mIAmK0aG3+uS4c8d838ovj9cKn7ZQPA7LMuCQbND1X1dLDJSd5hKyEAGfsH51s0slply4tiyuxxECP11bYi/4qh9YLQnMnc0MLhwqSrV8VC/THdBd23ZYxDrl6HB5xT3AoE9CRnlUC4DA+6m5Ob0p9i/Q7ALTOOcCYd3Zps=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 20:10:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 20:10:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mm: refactor mm_access() to not return NULL
Date: Tue, 24 Sep 2024 21:10:23 +0100
Message-ID: <20240924201023.193135-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc8d1c5-b0fe-42c5-5b76-08dcdcd4f5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBNfOs9V5nEm9seakOWeITQ2sUGaxD4iuIQHmCWyYEp0J1uX6hQ/1IuzywmT?=
 =?us-ascii?Q?nMbu3FWblKgD3wtkUQ8++zl7Ktq1VJgUDR3aG5MV9RgLtpRxdL+47uKd/LCx?=
 =?us-ascii?Q?5S6PmpHnFbTGwntV9hd8pe/MXMga6zbbmZESiO7l0EEQHFL3jTgfMAhRhh0X?=
 =?us-ascii?Q?X46w1NgtWTnMXtm1Um20jGqv93ji1vvbYLCwJuOJSYmYHLEcP/1Gs6fgIVdP?=
 =?us-ascii?Q?HRq89FkBCe58k//i3iyZZOKFicBAQvaKFeAFnUWomJv/eUhRP8z4gz3KpWhg?=
 =?us-ascii?Q?jRgTCzE1MmuDsYx8itkA95yb87kYz15TK7iaoBmrW0JFVIbSatp5SdDOeFXv?=
 =?us-ascii?Q?ZL6az+yCz2uEtk8TN3w5qGboCqzDOl3QdbiMKHQQgUtcWf4DjWjbvq+vCwhF?=
 =?us-ascii?Q?huWcZNQZ5I2sdKzSOKp7sBm8e/izUMAmTU9O24uyVLaNmRZZ0K5MnV4GZMDd?=
 =?us-ascii?Q?q1L47dh9waZssKQYvLOqvCp0rsTiOSh8rjNct9kn7cd6pFQXrhzH5ZQ8MJEI?=
 =?us-ascii?Q?sx5wKP8tiaeihskECfwb800hTkEm6SvX4N5EGFjNE0RrOmXq3GBzmoOCUYba?=
 =?us-ascii?Q?RnVlUR6rY9Q/C60Yy7RB2LUI7WW4vjr8NExyyOoEnx4cl3xbbXKZ4mE4cBII?=
 =?us-ascii?Q?Lgyu1WIPrNfMaYxh6uRupJ7PEpE2e1qdWFJsiJzyipfl7Bc+VPcW+VBaLZy+?=
 =?us-ascii?Q?Gg2SWHIgqpxBOIYfpzoAl7HT8TckxKKT/twsYu1xsECSwnrfl6lwLgq9YbBr?=
 =?us-ascii?Q?zCq3z7mfQTZ9KcdbyyYpnGFSysSabBsDUuOCYc/CclSzkXhG4zr2mWpeCTvS?=
 =?us-ascii?Q?u8VJZ4fI8NzL0lnPKc3pAPiLnNXaGcMEUHRAO4x67ZHeyRpVHQ+sER6lagNw?=
 =?us-ascii?Q?GfNC8klDaqP02RqjFIIMK+MqSoQrdJBVbLJKLPewX1Vp6IQNPQd+dXBNUE98?=
 =?us-ascii?Q?ywA2HA35Z4gZFTy42yc7TPrOtjnB/k5spJ2w15OqdLEm69jVUnEy7yeRIslk?=
 =?us-ascii?Q?iVQzbJHYlj9q7kx3CXcwQjCSdZR6ciyclYdqa5VJEzp+VF19ZPWTnkC9ZRe1?=
 =?us-ascii?Q?nDpDKY8c4o1gugRjKiVrrCBlkzdHH5Yb7yCaYrt0wbCpr3B30mlmZ0S1YiaT?=
 =?us-ascii?Q?MfYy4pfCZ9XF+mg9fue/AyJX0inlXIkn2mBpUeL4LO3jLS/6lZrrnPuivPBA?=
 =?us-ascii?Q?D5EtO8j/rJwtT+qVuwvplLGUqgzaDNEVs+p94OgsrNW1xFC/JSvAVN2Ifeh+?=
 =?us-ascii?Q?mPN1K7ZcRns9cH4+ozw/vHuyy0iKe8Qu7ZB1aXjTIZ/+9Y2glfGKU1dTgHTO?=
 =?us-ascii?Q?TNApCquXWQZkvKkSvAkIJG3vPa4bYG6A+LHoX1ep2m892A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lntkrLwhJE0d1YZpmYEmyIj9fxKgOPmF54kaoULv4zvhdhyIJGcoNqieM3CA?=
 =?us-ascii?Q?V/iVnZcTgUey+5BWgAez3wqTq7jNqD6H6GEoxnep7b6LR+6KqOAtLhEwJHHC?=
 =?us-ascii?Q?AhAR3bBX7m++PI01CDU8kvIXrQIc8ZH9lIppdQxY0Zdoovh7SiQ7teHBD1g7?=
 =?us-ascii?Q?ylfL4NERCRB0wFNLUyfNN6AHwrV1rMHlm0MVwNox8rVYxmpIYCcJiVphHHDI?=
 =?us-ascii?Q?wt9iNLcaxYenQFOizkC7O73HT9AEZ/7OGHDhOExHGIwGGCIDPER/ZFoGN8A/?=
 =?us-ascii?Q?3YfyH6Lz3bl034HaYcXLCgpK84RzNa8r4Jv7cbS1OF1BUcMKFTSFhx8K6Tb7?=
 =?us-ascii?Q?zKkZmiQdvuffAjZSVbdwF4IMORCrEiEeGrvu22rdflLX+LlWiDE0HB8CAc87?=
 =?us-ascii?Q?+3im4Xpswc7zdpjD9ZNnncLZsmRaro1+MBn+bwFBc8uD560z9KYZVWKNrQE2?=
 =?us-ascii?Q?9dsCZY041c9NdtoI9GDI9IshuT7vJfUIxJvDk0Ocft0f8XDSjwUqqeHCZXD+?=
 =?us-ascii?Q?GScM1DXnNnZeuPzMyCS1bQr/NbWQoMqQFcMGxDGL3HHv6h0RnxSuygyzXsDq?=
 =?us-ascii?Q?Lrmf2eaLiePI1Uop8ZvjE0HlVeAQAeCMYtz23m54l6wtVf/KAf9nTtm7Tdvq?=
 =?us-ascii?Q?ms6/Ye8bcClFb71uitfxcQK+MMJy8GPeIYrPDvUfLILlNFiuW7wS/mM00r4i?=
 =?us-ascii?Q?x2p05d17zy3NGmXF7L0t2ivxQKQZmsKyinj6QVdsdkpf5J7z8HkR51wXxQ3t?=
 =?us-ascii?Q?N7/4+J6RUe2wnjd8HqKRzNvPFpi3qGGvJyMyPnIa2zqzJbSMDvvq/Iiu1DwR?=
 =?us-ascii?Q?R36Fr0gpTH+P9apD44YYtaCIqypE7rKtxPqDW95Kw57HmYKgeodq8+7T4uye?=
 =?us-ascii?Q?rh1g0Wlbep2qtWwikG1kvKcqxsQSoDyFk50XDkdYTe5987WWBw27t8+XIxup?=
 =?us-ascii?Q?8kbtMU+z3obHUgQTcOj4re2eWK5g11D0DPoyLG9qdIHezOS8HScHZzrrSpRU?=
 =?us-ascii?Q?gKtbOZ/Pi2wAk7171PORhwm5eFkGEJnpsoTUHl9JfgJlqT0n3PNZbByT8iqy?=
 =?us-ascii?Q?4X8GUcdjc5bF/9pFASXJpRa7bbmm2B6ImeIFQU1pj44oyT4mzyDIH1D60RFZ?=
 =?us-ascii?Q?V4+P1ZfnaNhdaQjtqjVeslIOMqO9tX+tRfv7DHQqIJjS9V6ALcafme6vN7jr?=
 =?us-ascii?Q?fkwW5tiaFImvSEEvQ6bQuQMIMFTbutcnqpVvzwrhwOIb2pTA4Hyy+tZTh9YO?=
 =?us-ascii?Q?WSryquA42PIOKoSyO5Va3jpo7i0Mi00Z9ANumxyb3eMGeA3v9VsHybLCDmuh?=
 =?us-ascii?Q?yaifkuHvrUQlTzPhZCdyPKJSjJOfltbbd4uPBcXe4lELde3RvrHrPEw5ULfu?=
 =?us-ascii?Q?HQ1Vhk21uZGicEBsgnL75x/mZX9wE2gQraaskKK1b8mTGKST7CC5xu0FGU+H?=
 =?us-ascii?Q?+S9g0QYe9gl1Re7WkOClXtCLkX5UcTd1bhHhukrvYdGNIFjvs7JEWf5Gcpdi?=
 =?us-ascii?Q?F2TIBL1zEjy/GusKhx4HL3VVwYB5S/FP+JKlwxhTsMsXo6JmHR/jIIG6pA+N?=
 =?us-ascii?Q?Lmf5XfAdWSeF7uw/uzkUlRytFzCB5nuz4JWP6AUMfKtOHT4Es9pkff11rAbY?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2cylNRpPMgFkZ9pO5BF/+5q/9uZgjF4Iknbh4GpXo4U0VjFOgsa0G7jqfDI9ZcdQPq7f9t9HaXxApDYjAXdFAlS6b764XNIAGCLtOvFf95ww0alxhVO8YGszH6EdG0p/2ZaPVm7FshmB5kzwCF3veYCzIyKH2jsGy+KMab013ZnZFD+cdS8yLG9Lw5B5TVLm+fM/YQAomKezBC0E95oPa9fxpTGz/aI4jpjOUuElZn2JFeM1v5uW/T0oyo1CVEgjKe216YBi1Q1N8UyKKqjv3y7FMVQVE2jtSs1HpMFGl2LIT8SjG38GVbOSOpgvNznnmtIMS0s9jC3DPxvET6PzUVF1Ff05cYnZqad1EBBTOgjOQ48opg/6Mhu6Bs9lbzeLGzdSAhKd5Q60lAOFX2WDn6YlrKsuyQuZs+TSarmVYxXm9WOMaaxkirC53K83+hFpGWdF/Tuuu4T83xOMrVa9RCXMjmXtxkvHVL8x4s3h0qNvXzY34uNtp0X7SFMAZ5atJgJGL2aty9B7SBbT5S4kpw3+Hfv0Nlo6ul1aPHQv6d5B7biykH3oT5I5PbkyvmL4rcaJVwlUfjE/RZHdrokSOImghfTrzA5In/BpnERYXJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc8d1c5-b0fe-42c5-5b76-08dcdcd4f5cf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 20:10:39.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eR2kEDG87z7YpxgSsWt00laNhEUpILKyp4pWDWP73yNjTshX5aWdj4G/dxHS6+flqru5UolLq7RQMYiFi0x5QrnSRR4f4dmUgCWNJnr8io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240142
X-Proofpoint-ORIG-GUID: 57bMz3Radvx3qw8shJg7ZNDBmC-n1IKl
X-Proofpoint-GUID: 57bMz3Radvx3qw8shJg7ZNDBmC-n1IKl

The mm_access() function can return NULL if the mm is not found, but this
is handled the same as an error in all callers, with some translating this
into an -ESRCH error.

Only proc_mem_open() returns NULL if no mm is found, however in this case
it is clearer and makes more sense to explicitly handle the
error. Additionally we take the opportunity to refactor the function to
eliminate unnecessary nesting.

Simplify things by simply returning -ESRCH if no mm is found - this both
eliminates confusing use of the IS_ERR_OR_NULL() macro, and simplifies
callers which would return -ESRCH by returning this error directly.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/base.c         | 26 ++++++++++++++------------
 kernel/fork.c          |  5 +++--
 mm/madvise.c           |  4 ++--
 mm/process_vm_access.c |  4 ++--
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..fe31decc12b5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -832,19 +832,21 @@ static const struct file_operations proc_single_file_operations = {
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
-	struct mm_struct *mm = ERR_PTR(-ESRCH);
+	struct mm_struct *mm;

-	if (task) {
-		mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
-		put_task_struct(task);
+	if (!task)
+		return ERR_PTR(-ESRCH);

-		if (!IS_ERR_OR_NULL(mm)) {
-			/* ensure this mm_struct can't be freed */
-			mmgrab(mm);
-			/* but do not pin its memory */
-			mmput(mm);
-		}
-	}
+	mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
+	put_task_struct(task);
+
+	if (IS_ERR(mm))
+		return PTR_ERR(mm) == -ESRCH ? NULL : mm;
+
+	/* ensure this mm_struct can't be freed */
+	mmgrab(mm);
+	/* but do not pin its memory */
+	mmput(mm);

 	return mm;
 }
@@ -2208,7 +2210,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_notask;

 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm))
+	if (IS_ERR(mm))
 		goto out;

 	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
diff --git a/kernel/fork.c b/kernel/fork.c
index cbdaca45d0c1..841f60630c58 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1545,8 +1545,9 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 		return ERR_PTR(err);

 	mm = get_task_mm(task);
-	if (mm && mm != current->mm &&
-			!ptrace_may_access(task, mode)) {
+	if (!mm) {
+		mm = ERR_PTR(-ESRCH);
+	} else if (mm != current->mm && !ptrace_may_access(task, mode)) {
 		mmput(mm);
 		mm = ERR_PTR(-EACCES);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index ff139e57cca2..50d223ab3894 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1511,8 +1511,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,

 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm)) {
-		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
 		goto release_task;
 	}

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index b308e96cd05a..656d3e88755b 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -201,8 +201,8 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 	}

 	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
-	if (!mm || IS_ERR(mm)) {
-		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		rc = PTR_ERR(mm);
 		/*
 		 * Explicitly map EACCES to EPERM as EPERM is a more
 		 * appropriate error code for process_vw_readv/writev
--
2.46.0

