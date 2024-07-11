Return-Path: <linux-kernel+bounces-249917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674F92F19E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AD6B229EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721631A08A3;
	Thu, 11 Jul 2024 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O4mDbKjm"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020120.outbound.protection.outlook.com [52.101.56.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B621A071C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735246; cv=fail; b=C8yCAO9oh0K413e4Er99VkHnGk94vXcMI09rEm0OqJBBErzphuIAaPn8kEqZkBaeg0QVyLx8W5zxGnwGYA1rkNWC5wC3rVzsSKMqpouDa71f5wuQzVmE0GQn11zEA/XSGYOYmBv/uT1gKHxqLMsnoqo7/TYBKWhskmDznBs24G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735246; c=relaxed/simple;
	bh=R5OR02Lhj41Wz3mJqdMz5pSZ8HPa20ACHFziSnHX8RU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=CssSSc0oz61UYZT9dAHBpc3EylyHOfi+7a9ZaovddMV5+7b4R26RDeKvCl5OzCVJBsS+jNPmYjc+MI9ARZtetRp4E+wO/e/nQ7fNMk5ctL+PFyT9cCEywB5+ADusFS0qNonYtfPATzAD5weWygy0kDexx8pt3lKut0TApSGdzsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O4mDbKjm; arc=fail smtp.client-ip=52.101.56.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg0aHwqTVA8CPV82/ZafGhq39I9jWyUtTG+00Yi5RttvK03igNk3g23B8jPDooO872aR0dT5/GcuA2mvrO7U5kDI+MY4HFVtYdYv0yJJNyGiJe3ytYchhRg9JYT2RbGOWV6eoX+zubalQrJVu63ECvERexM4p2+SPm4uHEl+Lb7AfMR+j0ZtqROfUioR2Mzkce2l9cMmh8LGI4F7xQEXN9QNCS0YykMZTtxJtmk4Yv0KXu8yErdQkrKEWr/j/k1OkVpb8W2OZuBg949OXAbklxUimMbCGMDFb6+WaprIe4A6AebuiHuYvgoiJjI92myVGBSxz/F3xYlZVp7BnI2iBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5OR02Lhj41Wz3mJqdMz5pSZ8HPa20ACHFziSnHX8RU=;
 b=wXsw1iblxlHdVkqFEvLJxlF49pGBbKk1qY5Pw8Hd2gHiaH2YW3sP+hyBM5a97e3m6v2KuLEVTN1k/m/L7taVXuEpsGqMpx3csvqNrPn30u6O7mcPLnQQ+l2kBz8lp+m6uaEBa6b9F6n4S9d3rbM7lOeRt7jh68tQaPfNUhEHDwa6AaYWgBwPVbUDiYFIJH9xGnDM+HSEA/GU16kiTNLqRTtddUUVRGLoeWDsq3halid3AmFXVU/7PsSB4/azp3007IJbFz+7JvZ/KCk0hoTeObU6siHksPE/MLTLCIMxaJ16jIkxKeQvsSvvOz2Xn71IUmbIhApkuSBlSmMRExGBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5OR02Lhj41Wz3mJqdMz5pSZ8HPa20ACHFziSnHX8RU=;
 b=O4mDbKjmo1HUsQbwM6M5OhIfXST+3Uz2QEMfPEcmA7RT7W8exh/uG3nIE6GY4PGDTbv2bt70tzihRiBugI7REhJA5OVuxpBrE7GFs0s+GHu3L38Ly/GANrCCBoH5oyqN6gdr2V37p/LmX4dWXxT+Ezil7Ax2zm/n8xvQv7zVRYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 PH7PR01MB7824.prod.exchangelabs.com (2603:10b6:510:1dc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Thu, 11 Jul 2024 22:00:35 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 22:00:35 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
 <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>, James Morse
 <james.morse@arm.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, Xin
 Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com, David Hildenbrand
 <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin
 <dave.martin@arm.com>
Subject: Re: [PATCH v3 00/38] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
Date: Thu, 11 Jul 2024 15:00:27 -0700
Message-ID: <87bk33d1xg.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|PH7PR01MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aed34ef-a69e-4277-89f5-08dca1f4e437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jYPhVoZpsS2Hk7BfcuoMi3gwkraUk2e6RPrhez4gsSNV5HC+cB5ZNWeSSWA?=
 =?us-ascii?Q?iUXGQ2tJIxjJaJirC6EZ4hQJisYMp3wSJI0YNrGqTzTK9HjqIkD2AffWq5Qq?=
 =?us-ascii?Q?Rl78QMURCYJ/t9vpLK4sg8moABBj8/iXUIO7/ujvfNo0k0LbG/xRxs4ccTuJ?=
 =?us-ascii?Q?6ZoucvwYEWMWA7X2nj22WZJIwm3YkWmWzIh7ZoUHOmp5GTaKwKU3gqts2KEK?=
 =?us-ascii?Q?jEcVwY8pZjfzcID3PmMGDrEpvXw5r8CV47Ye5PX22wXNJMUTI1e50l4Pjgut?=
 =?us-ascii?Q?LudcUag+A6wFDyC33sDN+MbQVg0hD2TwG5kstO7yhXrBEitI49/ewpH+WfXt?=
 =?us-ascii?Q?aQBfODvMhOneBPQkx0+HaiwvuANL4zfldOmTIQlGMbwLQeQ0FX8riWO2XcqY?=
 =?us-ascii?Q?9fK3xn8uhZHWpniuay0dXL1wb/o/XqiWdLwz+csw/77gu5XIzlo29AtlOVzJ?=
 =?us-ascii?Q?YqukfTa3o3ayghVexrIqsUkEPqleolIp4J/UE/drR/WroS1WoxZ2uABd/FZ+?=
 =?us-ascii?Q?Vxya1e+mq/+Ajn6E41ZFaYIfY1+vdTsfuilamrsdcSDJoWvEGF+0mW6O+m7K?=
 =?us-ascii?Q?sIaFS0LKaeM3F86D3Aj21sO7CcxLx1MmZZuW82FFT2zeEoMt1vyWd6s8/FrZ?=
 =?us-ascii?Q?FSDolQRqI1ciZLjTct+CbPBMPYn4UuvmoNKwU02AH97ei4orWlCtyBbdFpRT?=
 =?us-ascii?Q?CBN/MIyDIK4NWrhmEVG6aiu6xffafiLVY5dl1XSEKh6vNEghGJQfnlKh9ECg?=
 =?us-ascii?Q?gi43PGR9mtyzIS8OH6e9fzym0JoPlC3+lS9Q8bnuyAoan1nnbqJQvj8nBf7a?=
 =?us-ascii?Q?KTjFbndDDIucGSwEISswFrTM9rHWCJBMFW9T9+HOe+XhslF3ZGLnhBcKWdWw?=
 =?us-ascii?Q?2hR4nIBBF/9CUtV+bW1Cn9jIJtdZwUxzAI+0zGGPWk7K7SpeUuJ+4v2vo7LF?=
 =?us-ascii?Q?LSaHnhzJCzoji+RaVQf4iJ7G7RRu/+S0sERqalht6CIMn7tCGCKUtgvFElSV?=
 =?us-ascii?Q?pVMaSmJhQQyP3Rac13LYH0o3VGQ4Stt879duowT2tqX9gClAkD34PEijFvkK?=
 =?us-ascii?Q?N54LTIMJhuwUD/fb7zrxkiPrR7XV3QbENK7Lmq/lxvjgJ9bn8KgU+T1MbicE?=
 =?us-ascii?Q?3UNjczIvMLz11Rfkj9eDNA0OO3zrl3ry1arS1DoHIVD+SrGehPY1p0+52MSB?=
 =?us-ascii?Q?8xAsRrGPEjRQAfo+K5BW6CSmt0iBCsGeL1nEOoksT7P/t3xhEbs5ZVkn9v55?=
 =?us-ascii?Q?KZLra0gYIGo8lfIkdP2n5qdn6/3XHG9HM5UM9rACYpnzFMXdCkFOwxn6Azeo?=
 =?us-ascii?Q?fv28b6ofuSqUu9UT+p2gRd9murQco1m0BTmk6L5OiIcZ8gwDq0NNTxuP5k+3?=
 =?us-ascii?Q?eV+9cSGObOmktIUip3cWBNnBm1eeSI1b/czTCZwwDhSsvar2Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GthScPsmsz0AXTjcy2eP14HPkREuDgluCk4SFc+7PDEvDdPt6Adpx1vsmkuo?=
 =?us-ascii?Q?G2gTJ13bFwBbdDYO7CsfeFQHQV46Dw7zLy/6sDuPYQgf6DzTzFm29A870AEs?=
 =?us-ascii?Q?0tDpftT7SCrI1o4RxrAE51Q17EBGJLOHvKvubu+7qcq6oV/sM2JoLJHL3ZiQ?=
 =?us-ascii?Q?P0MTBk51JWHgutulu4FW6QroLABa0J+T2JeOYyZSQjpb447vH6oqOFbuoTd0?=
 =?us-ascii?Q?+AcqrL1ItWf95bfWOqX1fPzTqQSGRiwU8QLRdmU4QmwRKmdHGjfRZYjNaJTc?=
 =?us-ascii?Q?TN71QBa85ztYjHtLzE5WUXEe+JwvHNtaKb7H+E/YKsTAYiHqIIsk6+bHCU0S?=
 =?us-ascii?Q?PE9ZrMy1noc1nG+uGB3I7dVY/rgP8n/yxzZO/fz+5hUe0OaR7l4geHy0ox2x?=
 =?us-ascii?Q?j84lgGyT0lsRtDh73T/SrPjEPb2o94CXDK99GeaKp8fJ9/XQBLr1u4/kMugT?=
 =?us-ascii?Q?oIR213X66XdM9ppX1Ng+GBQj+XMLvNcntSs4K+Q2Xz1Xi8XsnSFVjdLuGAmz?=
 =?us-ascii?Q?TuE8SQBdu6uPGoHPkm+dTzP0R0oEDsvZdSewVRlrJALxYWTIN2sPUJu4Cp7F?=
 =?us-ascii?Q?XiOopUE2hBh2+fttNEH1jCuOGtT3bXLL4EorrRKsr7icoh3xOHQCdm4rjspP?=
 =?us-ascii?Q?U2/qfA6XWi6AIVBuuaQl0VXkYw7GAuhfFJVO+WL1hT+HrlF0OrDUul287OGP?=
 =?us-ascii?Q?6kcTz8t15FEEc/MWUolB4MxM3B8xNzSC4wmkV8mxZTCB7SUcW9tQBiUm76id?=
 =?us-ascii?Q?pFMV6m6dSojwSkpfDC/0vLJfGY5YAfN2sH3cPKSCutKLW6IO49ReqhTaEntg?=
 =?us-ascii?Q?atjilVL1eRa0MaozK42MtSeLA36lB6hkP5+vROauek2K+kD9csxom+8axr79?=
 =?us-ascii?Q?gYcohSLaqzfNGNeJ560RizOK/NHIzQJzO9yD/CQc+zzc+Y0An4qNrE/GQfXb?=
 =?us-ascii?Q?dxbh5gOIpvAeQ7075e2Tjl1JXdbmCegVuSE8LRHE/QrhasA/bW0OX2ZccRdy?=
 =?us-ascii?Q?3bsWIbrteAXCQmH571UkVbUP0UlS+O+J6kkE+Ll2yAuLwduyHd3We1j2ZJxp?=
 =?us-ascii?Q?p3VduzxXK6DaOaZcpJ0KjE/Kg7eOI0uv3Ce4IOywoLU2EQlQVt/klVK6V0qa?=
 =?us-ascii?Q?STt7g+CJdG5cMjaWQoo2AKfr8YPpVI7Hx3VDDI0XannzlFgDsDLKaPmkCENf?=
 =?us-ascii?Q?2gfFM5PzX8U/dqOEvjHzDg3LF+9RwuDS/HKE7M0WnhsOZRZ0K/lXs5LFTD1j?=
 =?us-ascii?Q?b0aHHYH8FlsSHnzsK04PPaxr17jgW4/5uNhKDI4bykgogAfQXIqNkBx+CdMb?=
 =?us-ascii?Q?mB/uQwfXQBZOflpKYlqGG7R71iRR33nozswbOTODBVaM16Oslq53v36zq//2?=
 =?us-ascii?Q?JP5A0QQqKqkRf42w5Gbj/Jyte5kcoO+2NkZdRuBGkJ4pYhXg1ztF+rguylJX?=
 =?us-ascii?Q?NOLytHGUHoDSN5c+YT7vDd8VIpy68ljLsAc4a72p28nhyKLxP+mkGqtY3+mv?=
 =?us-ascii?Q?YZZjeq6PVUzuLm/wEJGf+q6v9sb8U2bU7Ri8mcAdfhCujbAim0uV+I9+ZBNl?=
 =?us-ascii?Q?ELVPKwjfRpRpKsrs4ra/9nJRYG1T1Zh9ioGPfA7zNfzduN48LsktKM1X6Q1+?=
 =?us-ascii?Q?4THt+Jqb3pz3EnSTDOImFJc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aed34ef-a69e-4277-89f5-08dca1f4e437
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 22:00:35.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah2x+z0FH9LzMnsKnzwKyreMN9vAu5zv5+Hyk0a+LpqJuruO2mGwbYPsIaxpMVSwVbShM5jDjgjzZnwlM0sYEUjzX6+yrr8vE7L5bZCX6HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7824

James Morse <james.morse@arm.com> writes:
> This is the final series that allows other architectures to implement resctrl.
> The final patch to move the code has been ommited, but can be generated using
> the python script at the end of the series.
> The final move is a bit of a monster. I don't expect that to get merged as part
> of this series - we should wait for it to make less impact on other
> series.

Thanks, again, James.

As with previous versions, I've tested this code (along with additional
MPAM code from you and other code we've written), to test MPAM
functionality on an Ampere implementation.

I replied to the in the series which introduces
CONFIG_RESCTRL_FS_PSEUDO_LOCK to point out how that commit will actually
break compilation if that option is not selected, (and I described the
minor change needed to fix that).

With that fixed, for the series:

Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64

-Carl

