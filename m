Return-Path: <linux-kernel+bounces-244657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22992A77A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71522282073
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05831146A77;
	Mon,  8 Jul 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iy16A2It"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146ED81751
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456760; cv=fail; b=sgp5YugKe6PXNjtODqDWEfO7v/KnSJNJ6sjyB4T7Wx/TShjhM1SpvsTTcnoi8nqF9y1lK0Gi1dW63iknd0bKW1VHZ4xPELLFWcD8MkWO04ipxE9LdWhR8BSu/O9TtyWFWRckaUufRz5O3OfClDb73K+bkv309rJdbdN9mHpOAqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456760; c=relaxed/simple;
	bh=H3YrPNMzUz5INEmzUYOLsMiqTivBc3sig2LxR0GhH3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEbplVQv83/x16+f6GMa1eVQK6VZ9a/K6s5omUdZG0v309E2+DCZ1ygtTqkdXl9/E7//fbdm/vi6IEtMnpe1c7Im6woYEmqD96q/d7nITHr2PW8V2fsxDEo1p1PmpmyDH7oGctuD7y3tCfo4QMHPCHKSMUU41B6cT0jDoxE9V00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iy16A2It; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUyEjOItLD4ptjtWIvPnkBZEsPzRY4a7Nizu8V4sNzL9anAX9A9phkU8U+5olRMLyYrJzm2l8DRvl1XiTbVMVu78ePQC0itTc5IzEkRzkjw6U4xyVDQ3E1rknCz5cVIgI1Y+TjVOh7ZrulQhG8tn18TLsCqaBglpOSsuSuAsvc5MAlvvr4tUIk7XsHUi92OM1fVdSrjCXSlJpwtQGxqk/JTY+k1+jxqlCKWhPFIZ7ghhItMNwFBdz/9X7WVqXIbR1iYibMd5J7fA8Vdzp34qX9cxC03g4sUswjwk/D85AUBfQ982O7TRdbgYCc/GUrEXYCrwra8nlGfYpjJlt3fffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+tV1HnHoTs3tB26QLZeLFq1CMYqEdq409gFJM70+0Q=;
 b=hzMUhSvPnMsBhbcwOLjHePvU7XhlHGNdpl7WVjkS2uHq3usyULR80H3Bgtuos0Ab5HAtqZoDszwqw7JpreDSbT/l+oLddL5K8D4CRXxyYyERSJhfwmB75BSL50hSa7dRnu+uqCujCokEMPniRGtP3pxmYY+T4ieblfMx9hHUdjIRHTlg+q1JBdoG+mG1Zgru4Da0McA9P01sebJuny4jBwlOAT1Rfu4xvDipzEUgd/V9/pnWFJY+qOdfWwGN+lg8TxcnJ/ALDXuHSGhoBc9bN/LyPIMfpsi96irWsP4u51U0f95+yKyr/djzjqqsOt4jZt1QN9ieDOlW/f+ZL3SMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+tV1HnHoTs3tB26QLZeLFq1CMYqEdq409gFJM70+0Q=;
 b=iy16A2ItwanivOWC/CsAYfO4p5cXrsZlJHmP10Tq71p5SyMWnATKDfEtN3KjKbI+1gusZwk6MSm/1MT+rE95Fx7fuYwLSVRXYaWDLyNac+bWgydAR3P8WYpgEiDIdLcIX4NG/MNvL34NVZmQAmkpbqhFmFCMbptdS4PaoNzJ+nsnpOoIH5Ed7LnNHx7nRC5jOEzeaESRZsnSy1MAvY3iw1Siga7kYU0ibEOJhOvLWLeWC16CrQ6k4uQT55oNEGwrMoaWlCR00HNkyq7a9LKr3t08VGHFDAES8sqdjYBjOivSXp2hfCdO0bxT5IIBPdxJlQEz91tVRZfk7NGcKY5XLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:39:14 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:39:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Huang Ying <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at
 mm/compaction.c:2761!
Date: Mon, 08 Jul 2024 12:39:10 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <BF97E908-8FC9-43FD-909B-845994FB36E8@nvidia.com>
In-Reply-To: <ZowLTDJG_i2ILmx7@x1n>
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
 <ZowLTDJG_i2ILmx7@x1n>
Content-Type: multipart/signed;
 boundary="=_MailMate_8B6BADE1-111C-4224-87FB-6264D2F5342C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3b04ae-b97c-403f-bd35-08dc9f6c7ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0o1UEPnjXhmKjQI3vVTBEg8MKOiex3axj27/sz4HZkpUIbKClxONjUdV1rGV?=
 =?us-ascii?Q?ZpNP9FZ/4pRndzYRdkbIeFGeN1A9+hxFEcMRq0JDjFOQu/xWcTFDWCa4aEDt?=
 =?us-ascii?Q?VwzL5fM3azI3PZPUxc0TxdpL03mQDtHRhCEXBUbszwE4HmmI3DsfzYpOehy0?=
 =?us-ascii?Q?fOXkUp3rccMDRVaeHTQ1Fnv9mOppFjqYSjaYpgoArBjqOWWNN8GE3EUCyTJY?=
 =?us-ascii?Q?CW55SCkP0bNcITrGCnmJst6f5pJ/JLu8qJAs7k4FNFFwsovjeI5krL3pjDrg?=
 =?us-ascii?Q?6SF5HMvszeIhGYQNvJr45YRo7V0kFpQ5xvaK/ONlaI3I/YTgwF//QPuKhc7p?=
 =?us-ascii?Q?1Ji4r29Eoz1dex2hyk+4K9UxiPw9lZG3J0NIyxfXgbbYYfJJlfDkiF+s4rpk?=
 =?us-ascii?Q?+mc1SsQbLp4RXtTKP5N6k5AdB2NOkPDq+Bx8ahKIxwrJE0YFzLqnt8zLKMir?=
 =?us-ascii?Q?xml7LAe251Tu/V/ejcmxkUdn+Jnw4hVisX7Tc2KIaDjx8tFM/5o/gbt8Bo+5?=
 =?us-ascii?Q?fgIW1J11j0ptwgmKTZSqjUc8jFReCqFsMNyAJ9p35ZRs+il75vryzC5AYTZU?=
 =?us-ascii?Q?veMzh133tQEsFOKunW/qpUtpM+4h9h+8NS6K1CM5X4AbBpE00AqHcdukrBx6?=
 =?us-ascii?Q?vaqlX+3oDK4xuT//L/oWwX/xtRHn59qLLcPDcsbyAPLSgyPGzkbzXVwZC5C/?=
 =?us-ascii?Q?KKWuaI8TQVZh8sdGpqrAHfufot0mZ23U6/uYWajCbIBOr6jzYmKSVQYgRhQZ?=
 =?us-ascii?Q?eorHX++8JWNtgQgX8mwP8AjIJtJlS66e2MOyXK+NjJwnu2WmsmouD9M0yChb?=
 =?us-ascii?Q?TuT5XNBJmMJ1ht0VPELWq2ioGwZAIwE4bLv7brpEJ4hHlAtYrnVe2lt9U8Z2?=
 =?us-ascii?Q?IinzP4ROHlwMnXkpNJp922uVmnlRCJ0/233XwI3Tfbmdqwi2lvPognJeCfbw?=
 =?us-ascii?Q?/UEmEgtjNeGj+oe1Zq6Olw8nRVhQJFDxOkcXsCz+Tl+OWZaeNgE0K5qqqnng?=
 =?us-ascii?Q?M+aszvlXSSFflMXp4unK0/qM3/lLUIvVdCcKshkg2C1rX5eaD8g6mJ3Jf3ub?=
 =?us-ascii?Q?LvVwq5MpeJnDQTd9tktYOc3ybcD2/8ho9Eq7Rz/YEEsL+iQJWBu/9N1QxDps?=
 =?us-ascii?Q?W6EpWFN5K68UiO7g3cGeVz8Uy3BsyNL/9QXYzlvETmro+RgpjsB/jZQHZS9O?=
 =?us-ascii?Q?GTCP7QEYebrNcl3rkqYSsovL4zXGoNUuo1uwOXaTpPNMYg8kxjMwEKGT3xRM?=
 =?us-ascii?Q?EMkfkaF8kKNGMi3TcHI/NP8bgG/lmju6nSUpw61DOG4dkyAomrrX+HcpDJrJ?=
 =?us-ascii?Q?pULrRco4mEybBv4Ul1Kjh5QBP0bvFuY29nAQBPmwDPIz5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Hp+GcnCJldGkiTUUNh55hZI+vhAX1aQ0sj1rFRSq7hGLUOonEe/fME9crPo?=
 =?us-ascii?Q?HVGx2mC3983Sm/v8IaguZxBaUdFQSYsNCNuDQYYNLJbNcTucE4BRG1VTn9TG?=
 =?us-ascii?Q?dCvPkDMLm9telNELf0h/ONjdvusmib+uew0gUKAHv21KWqVoWfNuYNTFKzrm?=
 =?us-ascii?Q?YPmHxf6BVBglA4ikqzN3sZOmrZDfU/baJZ+fLHIZzCU0XIu5FtccwpbHDKyL?=
 =?us-ascii?Q?zUzSy67vB4b8ATn7jvYpjGEqaXRoE1MiUtp0f4/Qkr5dKoBOPAWv8B063zd/?=
 =?us-ascii?Q?uaxYYq5Bj82m49SjsaAurMSNV+02Sc58fn7hl2IwaTPnyqFhpuOBkQiJHW0n?=
 =?us-ascii?Q?tLYP5lgS16/baM7Hba4qSAMpXIKqINTHP6U+O58d8uxJoirSqCll8X7OFFQ+?=
 =?us-ascii?Q?04ZYZQAvvjgKa8ptAzAXckWjGtxWp1Vt5sc5qjSSvjkzBjQU7FnrG3OlMTcB?=
 =?us-ascii?Q?pQFzPbHakGbz5GbM8JcS5o4BbYiMHXFUDA1fDiEGpZZSCzz/28+lXtXwmF7H?=
 =?us-ascii?Q?j0+9Ge5+Vv0lHPJL4yz0t7Xh/SI7sunmIlPDehEc9INrqqMGD/ls79CGzPii?=
 =?us-ascii?Q?kBJ9lfCYH7IR39PofMrc7IgoyupezVg1pkbll5aHXyf8h1MOrUP3F0/VZ/iE?=
 =?us-ascii?Q?FmQknzrPOPzoeWjk541TiEl17bVl74LWiIqTGig5HFoctTeWXJWtjrmURryD?=
 =?us-ascii?Q?CGN66TPB6UtL5V+qXyDjczimD1TThFx2CIAHeDx62bMeufeh4BLbNx0RGREb?=
 =?us-ascii?Q?S9/nRDZjPclPqK6/jVX0gGFhTZNlQF21wK6xg01uPw24oY4VJ9xgPNLYi0rj?=
 =?us-ascii?Q?aaC7oXXio1FOj9S1rvz6Pzh+G3VfOSJ0Ug35NUBGzN+KQHSZ8h7srh7Bxtyj?=
 =?us-ascii?Q?AeP3McqHRB8TylfeiW240WUe9fhJSekPRRWUhs2Q4SKQBUhNILFl6vy+Llst?=
 =?us-ascii?Q?zUaHxHoq21qViN2v0vx9sLO2GZxXJdw4GsGNtuklNf9jZHsaU609+KqVfFd3?=
 =?us-ascii?Q?disyRthbbo/Y/gVCfaCIznlXCMHPG5n9hj89aej+BITfvVyDu0kyUmq3XbvT?=
 =?us-ascii?Q?GBXwiP/jq35CBuxO0IQHJAL+05MQdm/4FZVRXmEkYzw1pjING0CY1BQFEyS1?=
 =?us-ascii?Q?EvXQ3cohvbW33X4i9CDHWHsJJ0H2sHPDR3FECmALxrU5kEZSfWI9YzoXuRja?=
 =?us-ascii?Q?4AZZU1OABxOVMMJ6UD4Z5Y3n+qQq4PUX3GFA4uAkc5vCAEIA7na2el7pau+6?=
 =?us-ascii?Q?B7jVoQDpnKZmXD21pqWlW+2vVpgPh9Alp+4ukO99LJxv3+fW75i/oi+gTzAM?=
 =?us-ascii?Q?Egog8iy+vtSjFlnvXm6IoEsmkLB5cn5XHC3FLU39OCnTQotLVqFwhOwYgqvn?=
 =?us-ascii?Q?Cvb0g7jYRQoLZQi/kK5N+06l1Yayly75FezM2dbahnfrZ8huMUQFAZ7mqucM?=
 =?us-ascii?Q?4MzALNh2YepgmAEuPLRcH5HeRUZ9C2jSu96fcPskV/urzIPCVdGkz7qsW8jf?=
 =?us-ascii?Q?nGvONY3VeOSkBAuKbmko8I1QQBfdKffna6sWmeJ9e3bFK4nmraXwKMmOl+qR?=
 =?us-ascii?Q?RxhfcyFrndz+hiiO7T4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3b04ae-b97c-403f-bd35-08dc9f6c7ff0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:39:13.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLphXNu7ZrmeucUhWr3xOs9ACC6piYntg2gRAEgvoQHQg0cptS2szQQENssswnt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

--=_MailMate_8B6BADE1-111C-4224-87FB-6264D2F5342C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Jul 2024, at 11:52, Peter Xu wrote:

> On Tue, Jun 11, 2024 at 10:06:20PM -0700, Hugh Dickins wrote:
>> I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();=

>> and if DEBUG_VM were off, then pages would be lost on a local list.
>>
>> Our convention is that if migrate_pages() reports complete success (0)=
,
>> then the migratepages list will be empty; but if it reports an error o=
r
>> some pages remaining, then its caller must putback_movable_pages().
>>
>> There's a new case in which migrate_pages() has been reporting complet=
e
>> success, but returning with pages left on the migratepages list: when
>> migrate_pages_batch() successfully split a folio on the deferred list,=

>> but then the "Failure isn't counted" call does not dispose of them all=
=2E
>>
>> Since that block is expecting the large folio to have been counted as =
1
>> failure already, and since the return code is later adjusted to succes=
s
>> whenever the returned list is found empty, the simple way to fix this
>> safely is to count splitting the deferred folio as "a failure".
>>
>> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on defer=
red split list")
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> ---
>> A hotfix to 6.10-rc, not needed for stable.
>>
>>  mm/migrate.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head=
 *from,
>>
>>  			/*
>>  			 * The rare folio on the deferred split list should
>> -			 * be split now. It should not count as a failure.
>> +			 * be split now. It should not count as a failure:
>> +			 * but increment nr_failed because, without doing so,
>> +			 * migrate_pages() may report success with (split but
>> +			 * unmigrated) pages still on its fromlist; whereas it
>> +			 * always reports success when its fromlist is empty.
>> +			 *
>>  			 * Only check it without removing it from the list.
>>  			 * Since the folio can be on deferred_split_scan()
>>  			 * local list and removing it can cause the local list
>> @@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head =
*from,
>>  			if (nr_pages > 2 &&
>>  			   !list_empty(&folio->_deferred_list)) {
>>  				if (try_split_folio(folio, split_folios) =3D=3D 0) {
>> +					nr_failed++;
>>  					stats->nr_thp_split +=3D is_thp;
>>  					stats->nr_split++;
>>  					continue;
>> -- =

>> 2.35.3
>>
>>
>
> We probably hit the same issue in our testbeds, but in the other
> migrate_misplaced_folio() path, which contains the BUG_ON() rather than=

> VM_BUG_ON().  Looks like this patch can also fix that.
>
> When looking at that, I wonder whether we overlooked one more spot wher=
e we
> mostly always use putback_movable_pages() for migrate failures, but did=
n't
> in migrate_misplaced_folio().  I feel like it was overlooked but want t=
o
> check with all of you here, as I do think the folio can already be spli=
t
> when reaching here too. So I wonder whether below would make sense as a=
 fix
> from that POV.
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e10d2445fbd8..20da2595527a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio,=
 struct vm_area_struct *vma,
>         nr_remaining =3D migrate_pages(&migratepages, alloc_misplaced_d=
st_folio,
>                                      NULL, node, MIGRATE_ASYNC,
>                                      MR_NUMA_MISPLACED, &nr_succeeded);=

> -       if (nr_remaining) {
> -               if (!list_empty(&migratepages)) {
> -                       list_del(&folio->lru);
> -                       node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> -                                       folio_is_file_lru(folio), -nr_p=
ages);
> -                       folio_putback_lru(folio);
> -               }
> -       }
> +       if (nr_remaining && !list_empty(&migratepages))
> +               putback_movable_pages(&migratepages);
>         if (nr_succeeded) {
>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>                 if (!node_is_toptier(folio_nid(folio)) && node_is_topti=
er(node))
> =3D=3D=3D8<=3D=3D=3D

If the original folio is large and split without migrating all subpages,
not migrated sub pages will be left on migratepages list. list_del(&folio=
->lru)
can remove the first subpage from a wrong list, if it is migrated, and lo=
ses
the rest. It is not a problem before, since MR_NUMA_MISPLACED prevents th=
e
folio from being split.

The fix looks good to me.

--
Best Regards,
Yan, Zi

--=_MailMate_8B6BADE1-111C-4224-87FB-6264D2F5342C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaMFi4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2rgP/19Oo6wwwsoY40qpbJn3mvXwpsqkr9GRXSwK
fwTNqqb5tD8nApOXkD6YaMMLoU9RyP28Cl4480eC7vs1cp4MuKU8su3ILCqKKsNw
BNwvtdBTYOGhha+200DmqEZNkYiHMZ7jVgJtameLHxTv5RVQadX76gwMLsajQ7EW
x44v+EFh5QrBB0uOBFPgRACd+xn883Jwxvzx7d3NBjFwZG6Ew+Il7ubaFiSMTcsu
FoCRV2Zd0vhmtYjn00nBxj6dh5XzbJZajCUq+HxW8EcjoIKhbkcTWopCKxA08aDo
v08MTx0v3hHRr9+MIVL69dGDBIPri3t94TAc2J287hYoUL7yPkpyxoM2u1y1tYFY
k3C9GQP7o0FpPUT5viP7OGAsAI1zYPL2/Br1O99r/c45WiQSeoac8OHz6kZzBBCn
LrzTqZ/TzGMdQFredmCLkTrEkmmsOIMrHLW+M1wdeR6bkeXdEu5BuHxI1tvaihOe
Z8oZPUT3v5IE4250FCScwHj/r+oMbWFRXWu4FJ1PGhQnTRo4GM/0Bp5iQuRQ2Qrf
YX8OOCE/qk+Nb1ChUaOZrLzn6zn1sQS7iYbk5nheRondC7fRwzVS/EpONN3ahNZW
KBVSGrbFfnqDU9ooH3B+nyxE6Zwg69NEqphgnm24TW2vi5lU0tspmE/1NJmZ/pdA
2tYtHI8F
=4gnm
-----END PGP SIGNATURE-----

--=_MailMate_8B6BADE1-111C-4224-87FB-6264D2F5342C_=--

