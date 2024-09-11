Return-Path: <linux-kernel+bounces-324174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 436849748E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F841F212CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDC13B58D;
	Wed, 11 Sep 2024 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m/KsiDEQ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472013A3F9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026239; cv=fail; b=bEr5TQGlvWXy7cyccTqskfXylA+r3PPR0Nt/oFZ7rmeBSaT5FwTB8DurzOVbQq3AiFt1lX41l/LKoE6nVxevd05aL8wl20ORGb/aNQ1xew9sdzeP9tsB+2vnItB0qE4/qwi5aI7s70r6TLUZDLluFIazFq29o2liGBNQhGSfjpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026239; c=relaxed/simple;
	bh=aoXKwyCkI2oMCOwFGXiDOy+bY+HgnmOcFMLwyz/nOrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiL/PD5bt9nxy3dbEOKrcV8ecRvghHWZOwSH7uo6QSyrbDruCxeAJei/bgcLW+6JDBmgEkZgeS4Ef98yWMHvdQyq+eEBhVcG1KPYrqL/IoUdncx2tzMWg9XnPvY9mdpQHPJFqDvY9+K0tcQn35bGt75U6G4AFx8C5RNtJCNkM48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m/KsiDEQ; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWYX5xi9CvIOQskeUDg2XR0LcMaGhBf/mVNvFnk4P9zjeEpLkF1RnbBVRsc9CfUKu9nRNl2QdX4eYy4yVBBepNtVKZtFMIjO+mQO9c0tL+Y8o6p1eRvlH29ipQZOWstHJwmZ7asCUeE2Q6gq0Puq0GbdGLTZwNKTdMjhlgFyROCLNWhkrgL59H9DrMWlW8n+XKcHa7oXjusb/ruSSeRK3csw6kGXQwqGasKipBcN26Dwga+U1PhBL2nrtB/JOoX8ecA+kxHAJA7JZ+NmOsMpM4faZd9wgJu1S6pN7trRCVtL2rFqhF9p9ZxH8vcaWQ6zYqudDCh3q6T6VCrvGooR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJpfXRt+D/Xi10u7fADuMjbX+4YLotlKl+Ws+v+nkzo=;
 b=LcCzD+eB35gxxOevA8wIV7xvfrXcpGT9qwSmSTVeFGSAeqjyjruhHecDs9WOubO8zXU6p9OrS7Y51MKHNKPb/uSlHBM6mDhgDsXD5gb939XrMeQoRq4K3/WiTutuLB7AOWidjwVyTXe4HyqIytVcgqPbvDHfsr5R0kb2KG9mV7rvtMMqAT1vSxDpbyPSU4c7N3RllwA+0OJmRrmNJGrDkYjnPTbCGDZ539kHA3lpkh1gTTaauMQhb5Lddp/5T4wduOMsVSBbfOEMEgn/4DVsUlELsHziLL3XT3e1TOAZuH89hcuRY3e6PUwrfY/aSEtd8gfyVoMaKVHm/bsZF8jLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJpfXRt+D/Xi10u7fADuMjbX+4YLotlKl+Ws+v+nkzo=;
 b=m/KsiDEQFaBr+X1O8eN0pMWwrQG+e0jZTe6t1vulmBbKf3zQKagZwa7ReP6dwRl78O5sV4ThIYaHYVRpWLqI6af2Avl9Wip22oFLRZygFnXDdfSdtbTUC29ZRQQ6meRIVctSjrki5HP4d38glvSGRYR2yhU0IQhUo96Y6G7JrOux982jN+Q29ScZ5RES6T77V6yQchroe4OV4gz50+QjAj2l42pO2LA0a5ZQxuaQmQ74l3lPaA5ceOTs2kK3vZfPytB+cVU26jl0jwAqFSU+w9OGsI1Aje9VRu2NWl+ktWXyy6YYPdgk+U9OvqxRSg58wWUB47siw4srihi8WypRww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:47 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:47 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 12/13] f2fs: convert inline tails to avoid potential issues
Date: Tue, 10 Sep 2024 21:57:25 -0600
Message-Id: <fbecda7cba8a51a8b685f6d3138a04a99b93e46d.1726024117.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: b70cfb3f-8389-442f-b9d7-08dcd213f12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3IOuxKljOkAkHnxeIQ0pnX80Zvs5Ra4LQc92DrRhqVISIGFBPU4AYeouJ/01?=
 =?us-ascii?Q?3v2ZYIOgtP+SSDzokOB+oJQJCdUmAF2yD3jSCz8+wrADD3tt+1gOSNFzHCVN?=
 =?us-ascii?Q?P8aZi+qOdQ8iXBxQvhlTG8NlSf7jK6qefiemq8yHVJB15jN6rmiDtbw5fQpd?=
 =?us-ascii?Q?OWAlzduDK1n2bOrs7/64dp0ox9h4EjMnlGRh3uwYPW3swUKCOXF4TJSmdY/p?=
 =?us-ascii?Q?v0ZoW36NLTCkDarqe02nkpcwx2R8hPXtwIOIyhFrOo6Yly/FjofY5LTYX5TI?=
 =?us-ascii?Q?aYpVqX8kO8XXY6OZnywVestmVasMhHjS565vNcprozw/k1WSaygObnY1gxj1?=
 =?us-ascii?Q?uK4mGQ8P0/MpTpXgvJmVpeY12HO9wtbRjlkJlidyOJ1ypdAvYyBHX+lB2lSi?=
 =?us-ascii?Q?M2NZ/lzQuHo7xNUzoHOoPk+OeBcN1ZIggDdcgCXNSakLqSjk7S4UPYqIxMmb?=
 =?us-ascii?Q?e/XH0Qo01bp0jjngzuyGQbtts3HmBlBRW5iO77EG2a37JkIl8AEGaHDa5zSU?=
 =?us-ascii?Q?RR0VwB1EkoNLanNOC8L6Dueeeld+SYgT6AkjGq7Y920pHtpktpsM92aOdpPf?=
 =?us-ascii?Q?ociYQthOEH+7FJvTYmVX0w3l0NaRae/udQbX7ca7+SeAcPvWHLZN2SyoAsX6?=
 =?us-ascii?Q?zL4fNBoSsMOAzLu0rg5dV+Ig0p386UJf0Y7FweVkE6W4MqzagCy7AI73adcb?=
 =?us-ascii?Q?PrUIF7J6zcbjFBAZbitDYDz6Z/uzuBzQ/9d4f1hbu6Jv0Oot8MlBVOZWW0D4?=
 =?us-ascii?Q?1PE7bWwRyO/WOIwI4Wy/bKKzVRaRbhU5W3Y18O+YofRLVMBHQgghEkwrMaFD?=
 =?us-ascii?Q?O59SaQK+wI58KOUot7JrGPobwBvaNLF0jbMZFciFUK3rIAGHLXaZ/66VpQ9m?=
 =?us-ascii?Q?4420QNie44TI5XMKVzcqg98K9mFLq7sz3i42oGYP3shUB6Jxkb8kcyrLLjZp?=
 =?us-ascii?Q?cvDaGBDgz7R+pT+eJ0f3hK/YJjvLiuhO63u2/nyoMhkSQ7kSMrPkr1wxDNWV?=
 =?us-ascii?Q?8Hm5HlMH4De4QilmAzCx0QuhtaCD1BFPqPhhtW23CnNvDVT3G42pOqESbrjU?=
 =?us-ascii?Q?5cEO8CQgkAisrRmGqT1S8u/KFPQviBIRnmi9iwkx/y/g8aumBQdnVUdT/h8a?=
 =?us-ascii?Q?i/r9M+mhFELzUdi8mERuHHgUeEByzBxw6DnD1XFABhMqVDXZinvoG6BIxcIi?=
 =?us-ascii?Q?vf9xODn1uw6e0vv+13v9Jp1PXe/VdroGpwDTPK7x07v6iiek/uNTCiOgJzls?=
 =?us-ascii?Q?rpDFVVF5KKTHyrMh4Sut75xvtUeGLZ6JmfnV6ckQNumJ5cJLaXm7YbPk3Z9m?=
 =?us-ascii?Q?SO8YfMxo7z48nGVwb3yG6inbD8HHfNe9NtuoZQaTsrkwSnRTy1BGDtPYwiSl?=
 =?us-ascii?Q?PhCmmJ3dcowbNxCTF0GVNisAtAdOovjjkw+hIUeVDVPJ3U4e2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1XDYL6cG533Aflir+q+xbd4PIwAHpkMM7dcLzSB/ML9gKyVNjMSaiPfeSGMD?=
 =?us-ascii?Q?nVWhj4iaWfmPL7PmnB+PkuX/+VUqlmgqtU8FE3mLzY6M50G5lRiPWA+N9ijL?=
 =?us-ascii?Q?jN/zhMqtIAmpcUbJe7lu+rYjmMuiIK6joEb4YuVNDEXg9xxwbnR42qe1z8W5?=
 =?us-ascii?Q?RvEOM/yXV7lSfOUfTMYtqAL2UtPy0bKR/pwf843JClY/BwPuM8um9T+h2v/l?=
 =?us-ascii?Q?jZWGepD8CTKrMjjp1V3NJRW9JItF0aHmc4DoEFfm7Zr5soNZZJw+qmllixNJ?=
 =?us-ascii?Q?BtXiUW+uWAiX+ndoJXZNw1YOwE2Tq6l+tuCBt5vgwGxaG4aAMOkI4hPEc5c3?=
 =?us-ascii?Q?5T5txGBAUtfPayli2Gj2owKpCJ1cinTY8PbXNH15h5sIoEK6ybx6NLXm3W8e?=
 =?us-ascii?Q?BPCOmbUJjlVVPYnD1KFBoQGL3x7+ST/56VdHwHUnamm+LzhEgcEqKuT+5i1k?=
 =?us-ascii?Q?+zSNet2ajwRhgmzZqGky1RrTOvlU8IuC26EBYRo4Dms7DIeKeHuR9H0AMASk?=
 =?us-ascii?Q?4sIFFkY/L+vBPr/SFp1O67mQWTbyVuWtMn7QJBsBpKO69/pPfhJYdfjIFhX7?=
 =?us-ascii?Q?/fl4vhMKNQ5kk+NYgrFRihfNQyP9oN5iJCpfH5RiYbUbYZJfRmc4gl9ODquK?=
 =?us-ascii?Q?01fU+Cdhf8qHmnKJpetQVqBwEc53PrzBj6cvHeFvUGX5iMaKQCly6jt2aMWj?=
 =?us-ascii?Q?xOrhT/UN4ozGxe+Qk8uxPsRs1he8CwPvOciIurRZEnTEpqFhSQtu5g/oCswP?=
 =?us-ascii?Q?45qHSycvmxcBxQoENReCYT14auMtqPKSCG5l+p5u+dbjP4vB3/7MUOaJa/gk?=
 =?us-ascii?Q?AjlHUCTDddqQWuaKQHh4Pa4CtUJcDFpRuogW/slu3pv+GdVZyxXjDeMYTEj9?=
 =?us-ascii?Q?2/Pbl3C80wpogTtVDuXLwJ37MMx5WCC/Q1sRhSqNPY6FoMofrfQLdLz4V0GP?=
 =?us-ascii?Q?IFo9b5lyzs8eQqwnYtDoaZcmX58fkE6Atnf/5Kda3QPfEdcamoCAi4+hOeUw?=
 =?us-ascii?Q?dWvBbKsmZbM+pgPpxgqwUhyZBDHoHHW3CGtCaBdYupxsVsAd5bt1wB1EsaU9?=
 =?us-ascii?Q?TevHEvNiDZHKcRLQdb/A5zc1paZG733wsY+NL0obSE2IbKffcKWGRlUXSmZu?=
 =?us-ascii?Q?/jimTbA8OkJNJdYsoK63rhVJYm3VFimgSOz5B1lbmHN3YwiFwAI7lVtvhfXi?=
 =?us-ascii?Q?FT3k+lnoafRgBATCbUA9T6eI6Le42EH4RtL8nOiL4VssufLS2rR0X4kVLzOT?=
 =?us-ascii?Q?umYBxucgNUMEqrocLFxMdTynpixGlamAMA/9MEVGvQAPJkGFgboeGKimlt4d?=
 =?us-ascii?Q?HdvU/IuXLjXVL0SLtzteYqL3czlbfBmFK80aVrSeXkZeRk/ocRXoIotTapBW?=
 =?us-ascii?Q?GneK3RA/5diT1BQjNYvcYu4Q7MeT5SNhcg6mTV6GFK+l9bgFJasF/ryaH4+h?=
 =?us-ascii?Q?6FyGfVuoqrezuKV+MyXrcEUMXr9DZKy86CW2BQ22K7mPbCHxhVkZ5VckGs6h?=
 =?us-ascii?Q?gRmgYiNXUImlDgLfqUN3OWulMUr2CY+qFoicLO+rKk3I6peg7nazFckGLlXa?=
 =?us-ascii?Q?6pIHyv23IX02GsRrVR1wanOIeHuo3RTGaTq43KVM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70cfb3f-8389-442f-b9d7-08dcd213f12b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:47.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paU7Bzf2AWWyd15bVgVrrIXwJGtDqpXh3KLIdNEXcEDctMUMZE8CabBNhA6LJaZK5Sc1J7bfcp6ouzZJN4qFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

Like the commit:
commit b3d208f96d6b ("f2fs: revisit inline_data to avoid data races and potential bugs")

Due to the limitations of inline data, there are many scenarios where
inline isn't supported well, such as move file range.

Therefore, in these scenarios, convert the inline tail file to a regular
file.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c   |  4 ++++
 fs/f2fs/file.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/verity.c |  4 ++++
 3 files changed, 55 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f52834c1cacd..a59758e1c878 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4141,6 +4141,10 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		return ret;
+
 	if (!f2fs_disable_compressed_file(inode))
 		return -EINVAL;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 64ea0bfc2e1e..3dcc5e363c13 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -84,6 +84,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (err)
 		goto out;
 
+	err = f2fs_convert_inline_tail(inode);
+	if (err)
+		goto out;
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
 		int ret = f2fs_is_compressed_cluster(inode, page->index);
@@ -1070,6 +1074,12 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				return err;
 		}
 
+		if (attr->ia_size > MAX_INLINE_TAIL(inode)) {
+			err = f2fs_convert_inline_tail(inode);
+			if (err)
+				return err;
+		}
+
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1191,6 +1201,10 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		return ret;
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1501,6 +1515,10 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		return ret;
+
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
@@ -1591,6 +1609,10 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		return ret;
+
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
 		return ret;
@@ -1705,6 +1727,10 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		return ret;
+
 	f2fs_balance_fs(sbi, true);
 
 	filemap_invalidate_lock(mapping);
@@ -2010,6 +2036,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		} else {
 			/* try to convert inline_data to support compression */
 			int err = f2fs_convert_inline_inode(inode);
+			if (err)
+				return err;
+			err = f2fs_convert_inline_tail(inode);
 			if (err)
 				return err;
 
@@ -2172,6 +2201,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	if (ret)
 		goto out;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		goto out;
+
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 
 	/*
@@ -2964,10 +2997,16 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 
 	ret = f2fs_convert_inline_inode(src);
+	if (ret)
+		goto out_unlock;
+	ret = f2fs_convert_inline_tail(src);
 	if (ret)
 		goto out_unlock;
 
 	ret = f2fs_convert_inline_inode(dst);
+	if (ret)
+		goto out_unlock;
+	ret = f2fs_convert_inline_tail(dst);
 	if (ret)
 		goto out_unlock;
 
@@ -3353,6 +3392,10 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		goto out;
+
 	if (!f2fs_disable_compressed_file(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
@@ -3998,6 +4041,10 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	if (ret)
 		goto err;
 
+	ret = f2fs_convert_inline_tail(inode);
+	if (ret)
+		goto err;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f7bb0c54502c..aaf3e754140a 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -139,6 +139,10 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	if (err)
 		return err;
 
+	err = f2fs_convert_inline_tail(inode);
+	if (err)
+		return err;
+
 	set_inode_flag(inode, FI_VERITY_IN_PROGRESS);
 	return 0;
 }
-- 
2.35.3


