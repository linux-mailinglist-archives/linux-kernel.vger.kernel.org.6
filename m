Return-Path: <linux-kernel+bounces-241597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04704927CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798D11F23B90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7C13C823;
	Thu,  4 Jul 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZvdvvFC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PexNrpl3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AF13C67F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117676; cv=fail; b=fV/S3BIcZZbs7YWpuMjcNFOIIU//c4SY0mObNS+48bHbqGr5OVevAN4zBMtj7a9VvjPGaKZ07t/MHtIPFRhnJpn5yMNvHGXS++rmLqHh2tkseDRuASFFzyUSB7n5thtKjEDgrjSUYWYc54Qe+aFgVmMeNZR0AKChYl/NB/rMA/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117676; c=relaxed/simple;
	bh=QiA802zTVfmaJ1Sa6zUkOIrU01oWeRhuROQrUOtzoz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oScen/YnTFDbXcLWyk6ml0gQmoRqn+WPOdCWoe1B0nyRRqqejjhrGW2QWfv5iiDtI9bd0SudyhtHo5XE7/9gqxY2pYIhg0C/wUBfSdsEVGH9W1vxrzLgGMjOAw9qJ1oiJZHek8+9r1jIuCiz/v9BZI3eL6FxlKrNoC2v0K6bEbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KZvdvvFC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PexNrpl3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dro5M025896;
	Thu, 4 Jul 2024 18:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=UYtXybBvuR/E6XnNi/cBy7UHclkrQo+ecjovwhPWttU=; b=
	KZvdvvFCF7Y4CH1hX/caDfi212Wsz7D7lFk81CqU/97ZxwPUqzh3XUPRiikNQ3P0
	Gr1x0sY46HJHH1lUj4dVvLEXNoB6s/uqaJr1CRu7czjlenKCycngPiHEGZ6A5Fo2
	S9kh8PhKOBJaNrJrnC7syDoW6X7mB3rRuhdblqcYfN8ssEdFvwfQTapjxIyViA9s
	dVi+gRFqfiCrm1zzYj473PDOutvUYSS11je3wGNNqTLQ24fYaFFLBLwnUoDLto8u
	il55ssi+nt+r/9td4inhyWJAclv5CKIkhCYKQ3zEs9rUTGkkLZJB8Hun4MOysUDR
	JQPOpyt0bddTzIgQBR2jqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b2q8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464GBDdm024208;
	Thu, 4 Jul 2024 18:27:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11kmkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwNDTWzecHWL6IlNzWvDYMJVm+J3g13pb6OhQiOvVpNPumFg1H2BsuvEQnvoZKpT3lwQnDceskXIXt4fXupPSh6cnuaVWHkXRK5THP6Gq1ZGNVePztGj7rTD102A7n23sUiTHS82xn4gX3f0mwa/+QiNc6liXALkNRc+E7/3o1Ez27mHp2u66ajMjOj9SiOaBZo2XIkNIXJGSf9OmnYfRrR9B9FnFxjlioEsiSP7HxIcBlSg3S2jc0EZYm0KOwJR6U02y/I7G3x0H3JaL0RuoYHZp3sAzUSlvKqLKlXiaMJXc6ACGbEeDHZZeq33+KVxnkk5buraTRr61An+b/Ir/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYtXybBvuR/E6XnNi/cBy7UHclkrQo+ecjovwhPWttU=;
 b=VWGpPHl31Cg4CShWHT1Dzj/6R+itHlPPz5bpyqhaKF5CCR8+CShjySqW5jH7dWmPIEcfnbLi3EnCSs6iGrVOM/ZU6xGWGc+FJu9dCyiNuqUK55T7vIXzPVev7XUt3FKLRRleeUq1h+8CT10HpNfCSMt07ATULwlt2OOk/g8dUK5SPnQRl5zC10uvkN15vlTSMbnmZQfgT5YXKLGJnXC+m8+cPYMf9Gx01GXVUdrk1yY5/N8DH7yDIwk19MiGFlqlIwwET8KkaV+GIjS37OAobsstPBQ2+XWsGv77t9WkwqOVfRcHncOO8SwxiThY+vpTLlykaRVG378WLHapuNAJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYtXybBvuR/E6XnNi/cBy7UHclkrQo+ecjovwhPWttU=;
 b=PexNrpl3hQVi4/dVKWfUEcEQldrjxdeDQaCFmyW8p7kwBsLvJZaWGi8fUWs3TUYOOQHdAEhZMD0K25FmEoPo0bAuNc/Foi6nzQbfV0EU1KikJ5DHcAhFji9tDxVzedfedqcBz6NrUkXQl341gfVzozA/41Rpw90NcppY5UNw5xA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:35 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 06/16] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Thu,  4 Jul 2024 14:27:08 -0400
Message-ID: <20240704182718.2653918-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e28b3b9-9628-4b0c-c1da-08dc9c56f9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QKeCHV/wez80tEs0HTVmwxODDyEik+SsqKOReyJXwjSKKx/+UUiX59iHTifQ?=
 =?us-ascii?Q?a0T7FcFw57CdodHkZWKXVKznmt0RnF/l03cAfflTgd+PO/jg4+F6aG8/DSFG?=
 =?us-ascii?Q?MewYT7qmj0DGutoInC4HYcrmikHTQXQ2uRNBxS+HdX6wtz7hEjgrVAkeSjWl?=
 =?us-ascii?Q?x+HnongTDN4caj/uukFx0gPyHcfRQP3lr5J82WkXEVGVLoOGP8jrsiy7sv0b?=
 =?us-ascii?Q?dqbRF/YfBSFu2uVPHFaOa9vdx3rkkOUzDfA7uowX5/bwmwIJ6qT+mtBebB/s?=
 =?us-ascii?Q?h4TqIHGuWwlhRGubMyS0J04wGf4XI8z8oOk/PazrPk8nHrTeGJEQjyzRVK8R?=
 =?us-ascii?Q?ddwOF5q7c5LfYFsF4kzU7nvVFc46eZtUrndwv+bzOys5LuFWeSMo/g5Qlz+f?=
 =?us-ascii?Q?zwSeRfNKlWEjuB2l63zZQws+1/B09hDpvh4flWwnYX/GnPOJKyNNAPtQXElr?=
 =?us-ascii?Q?yyja6rfpn1/6QyZwmE/97avXAYm12kZkRCuR3+hPISpyusKbS+9ZC5VwSuGq?=
 =?us-ascii?Q?xEnXzM5DMYKAHTIBJxWireWT5Y9CKv+EH8tK/knywBsICsorM1ovfwnESmy1?=
 =?us-ascii?Q?pAmUJDzbdhk0txCUPmkx+XgUz3lJ02qZLDnTTGQ76Husz344sUVQn4VLDdlH?=
 =?us-ascii?Q?19rY7jykjDYdac+6FJnSKBZNxNznCKVStnH+Q+otTKLhrOUUzyEvWAtWxoUl?=
 =?us-ascii?Q?4UEDcby9Iq4kFAFf9+mUc0qw2b5Ewo1Y0nof8mll+Og7qg/FK5ZCp3RU6Q90?=
 =?us-ascii?Q?qJgEy8VdsnHseIU3uLGx+U41J3mTVryyOLXkW//WmOu5/B6MtlAG2Oeh4k7V?=
 =?us-ascii?Q?Fq1UQLRrF34GDVJ7Uji2snJa1meW3AgLB2fhkh7ubMlrYbZoYbS6sAOi0QOv?=
 =?us-ascii?Q?9+W7fO9S5Nv9iKJQslmWf9gUHQlh5OFa5yj1s7FM+edGqYJWvepBYaIvVsvh?=
 =?us-ascii?Q?ilhAtwV+wXYv1T4XYee+OzwSxIDfsLFCwX4AMHfoinopsxCpLxMakNznCZSl?=
 =?us-ascii?Q?/WczfV6h0L23m1mY1idJy5Gi3NsldXKVPybGajH1nQElkzRfZRGwzkAgdFjl?=
 =?us-ascii?Q?oj6S3FuATRbHt7vfdNIrHuMOkuw7aJahWplWjqEQX2GhV7I/yVPQ+z07q8Gb?=
 =?us-ascii?Q?dGMynsaS2wVI9ArGTqttHxP0zfbRwqCBcQWvo8JYFyBjVnRzt7lV3c04tWeK?=
 =?us-ascii?Q?j+MidsqMDPU1yspFmnJVq3yoNHP0yhnHL9TVv53lOzmTynMoU+0g4sY458vw?=
 =?us-ascii?Q?ODVIkwkBIBvbQCgphfiE7JbYkCE0cKeXTS87DtHna0XWDmewfuhAgyUEHbZ7?=
 =?us-ascii?Q?yxOk3iERpVsNNkG29+0KAEFnnla+qq0dVPTMU6+FUCF2lg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j9wcy0XsBQ7U21DxIfaYD85tLGwvdnBwr95B3PwNQzw2zrnT26QztKSj27Qo?=
 =?us-ascii?Q?cUuUKnMSbQtE0qgCqKLKpBkWuMclbf7bT+G27WxLeCE8FQZRu27mJiFa+UMT?=
 =?us-ascii?Q?awxha7y+EBCxwChHmt/wl+A00xvOv8/Dqrr0LrL07GeWG036Wrd4RBHRmj++?=
 =?us-ascii?Q?oWblC6dMa9KqYQ2BO73yLjRxH9aLvm8k+VR/jdMfx5PpqhhugqOyFcnalyUv?=
 =?us-ascii?Q?pYMxu0dAJ2esKO8vXa2RhoUYgOn8Uc0Y5uCyYlh/Fi6b/YKkQdZc7Q7L90FK?=
 =?us-ascii?Q?TLZMdrjO/K9yDDxhy10Vg8tnWVJv+ry/S7asuUEc/ueELMBMeyCHB8LXjOJS?=
 =?us-ascii?Q?JTY9e2KIxnOE6hx2tVFc9bIhR882USB1tSzbCNFnKxoc7Wku0jH0WVrnI07H?=
 =?us-ascii?Q?xkC+7XuA8HZSNnB0W8FLfz2GZoSNspQRPJDmTSEZZ5dQbDei+CwmBHu8vWX5?=
 =?us-ascii?Q?xkI9o/TxiEl5VFlK40V0gmUBAnWNxCRmVvmeJnPvu+ittn7U6NVTPGdOR67b?=
 =?us-ascii?Q?b9JXj9BvrzeviAZeTHGBFBMBFyMckeaxUoXrWPyS3ocApto5Utz5q5cQTgXQ?=
 =?us-ascii?Q?xWkoOlyAk1Kksf5POzPG9IWwuFhZSMyxotPs8WJa5ku7osq1Dc8lTTWVNQKe?=
 =?us-ascii?Q?aZCWKaD5JUG10B/bl6Iy4Bxv/aR33fjYm8uy9H9NZ0hIt3cIiiEbZl873Mlz?=
 =?us-ascii?Q?J+WHYZ9DegHqFijaW1fE5bd9ZHaRrz5Dk1ynGZEbrSWHBR6jDz7nBU+GB+gE?=
 =?us-ascii?Q?oClWHwLFvlA9LALmSL/qVZg7F4t3CFoLS6IbRNu6xyq4+HtzOMovmRTlhXWy?=
 =?us-ascii?Q?m11pA6newXUqDnHPQtFH8J2IWQ7OT8p+3LofBR4YtubP+/Tif5SRVEq87a+Y?=
 =?us-ascii?Q?9vAqUteOFXwCpa/k2tW+v23ZnTIn9WaQcSGtHl0Q53d2+yVZeGxj9hYIm4PR?=
 =?us-ascii?Q?4CTCe7sb8+HVQYYaXo9UGCunywG5bgCp+9V2N/5AJD95k3iZfGsqTz2XQpZo?=
 =?us-ascii?Q?YW4iwWX763bubd1s1EEbckUzoL1HWy1/wiqDKzkdew68tjfxjcLc0gEhqePG?=
 =?us-ascii?Q?k8txgRJRj8bFFD/Ay0MtwVmARlS4wx5+0sz/IwZBtyEsuPM5KA+lkfXDLy9X?=
 =?us-ascii?Q?pBloQb4tn3Tlyj3ui/Tmp8+lRBA6fzfOw79RrbFGHFCX8JoYqOW871ZvsNru?=
 =?us-ascii?Q?4n0YA6Hj2AL3Rpewr+x4SSQ2h+3EAQtAIzG4rrnUM8EpLGuT7YMlKvCZ7KBg?=
 =?us-ascii?Q?2XhaAjBs/eOWA7Fda1ND4J6yNEziY8Yqo1wOOAUbACxKV2QZz2pxUFW5fo8b?=
 =?us-ascii?Q?cskzvZTbTXsU9eqXPPamjccpCHDi8Zh7aw81kEBMOQHUXAfH5piIaaSJ/DjB?=
 =?us-ascii?Q?MUAuAd6bRs5UH5b386Qe/XrDxA4EoVYJRk4y8J9wDJLozYNlVot3NnmitGby?=
 =?us-ascii?Q?CkEXme4fnPrjgM3LpRA+oYeaWGtKwi+BsfYLr7I0FHL0nh4k+Pf7ytdYWbK4?=
 =?us-ascii?Q?JdQP67NmD5eYwV0gR074gDdrr7/WG4CZeIhYf7vqwUgL+0besaTNToGbfkRa?=
 =?us-ascii?Q?Y0M731O4B8SG3OaIZgON+jOSf4ragF86whlFraNW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	InH4DDtQ/SU4LRDJ7hXPiyE2RWj75KXAU7ek8uBxRXLa+uhvsEEBGpZZzY/kFzaZ2j42DuNqBcVmBVToNnLtxlHu5cvnzTFwb8buSC4SCKzQQlRjpcNxjOplpc+DcUpqC9ZgGsw/9jS+rGLr/BXVd3Na/RwoC03v9ZgCVTKAilENg0PjoV/LYPf0efi4fyDI1c825O2l46CVvJ3U9hDB6uuU4X6/S+azbQXvqnxdHlmoUoTELxtbn9L/qQXxMKfsYH7esz2PPUeyJSy8kb9jEdKLzgwYj6gStEg3b5S9PNcelPhNt94O7MQpb1RRqmysl0k4/bvIHFN9ydAUGELVsPa+XmesbSYNieN++18e0uxTY7d2S1rS5Vdw5f1A/Xh8jPbsxiSS3RsDmxmRWXIMrUGJlosQyn/6w1QGhof27JaR/o0OyElzESkNGY1T73EwVINNw74cfhQYIRJN3fKxWL8pES91Ivv/gisPd6DiWMfkbR+zZC9DHjUtB9gugTgsDyMNYMbv5C+XsmLdervxnXuMGhRb7tSpmO2fkzg1FsMunzKPrcc8C5U+vvUEFtapTS/loIEpz9JxclIQwMFVKX4ZF5hXNiJwffvOf3Rhg7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e28b3b9-9628-4b0c-c1da-08dc9c56f9f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:35.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiKLy6SSTFDCdVTmjuB9QX9j0jRhbTsWbG88FR/Ig6ov3dSdzG8cLeElKNV5SF97gjsJAjvBNMogE6WRvGSXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: k4iyov5CtiV4t3pG6rB3uVXpnd4FPTaW
X-Proofpoint-ORIG-GUID: k4iyov5CtiV4t3pG6rB3uVXpnd4FPTaW

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduce to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 81 ++++++++++++++++++++++++++-------------------------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f1e6dea2efcf..8cbbbe7d40f3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *next;	/* vma after the munmap area */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr */
 	unsigned long end;		/* Aligned end addr */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 76e93146ee9d..2a1a49f98fa3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -523,7 +523,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -2388,30 +2389,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -2634,12 +2611,15 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
  */
-
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2648,21 +2628,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -2710,13 +2695,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2725,8 +2711,21 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 		vma_start_write(next);
 		mas_set(mas_detach, vms->vma_count++);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
 		if (next->vm_flags & VM_LOCKED)
-			vms->locked_vm += vma_pages(next);
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
@@ -2752,7 +2751,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


