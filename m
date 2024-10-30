Return-Path: <linux-kernel+bounces-388183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7F9B5BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6611F23ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376DF1D0F54;
	Wed, 30 Oct 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqzFLe40"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768691CEE9C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269569; cv=fail; b=E57CVHlt5jw24Nrx8E6WlEjf+0dyj1Zw+TuwcLn57S+AMuBLHCyoGvqmRPmrBCPRkGJNHKH5zDIln7K0OtF9pJ2/lXOX159BgVTy+PYL41oBTuYA+24ba8KuLrdU9gdVR3D09rHVUg/jawlqT9jn12x1jU/TBotiUsjJg45pzLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269569; c=relaxed/simple;
	bh=Vk6wjjtTeAf4evMJQg8/tGvCPpVO46Ew8cFGGTiujWc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=tyavOPEBmg+dDClk9jPyBDXw7z+mS5XVwA65J+7buLVb3OdBQSacW4NBmg/iJ+DVfAdzsfHGrqwOo9JZR2EJ+cCki6V01qr+26xwIu9WmKF4sMoQrI2DH6lMhJ8G1TC+WBUqoRqgl8nYVdJnKj+COviX8mcxkn96uNo50i6FiyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GqzFLe40; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9RE/K8GrMnB+HiyXZ6jy0DlESJVapt2LV4UUS7FIApkPHZsqPFSVN0yWq5PHAcD3LhW3+F7k/Hx+OL5GBnt6wu8mxKtDGGttQy+1RaM3gNl+/PFbP+Vyu0ykTG7pFKmiY/25DMxWEXSsYiWut206rU6iqRt1w4q7h1WG8jsn/mkFKju+BjyfrMNmyQ0r/S9Ow/H0DxmOF+LR7N0xWNnO4pcTgn4mcPjJ+wdYLJqNHOuYzYkuQPVBBb+DTaIQRrkMHjwMk3JfmjpS2ARc4R22+pJsZSEHm3yHfdd2fYlwkJvV3yhtfhCdEN2hVFnKZRZNkIUeIT4PrhJTPuph2Tp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwtDC1JDeRDrB1faaWwXvI4Gw7hPHMSD7X5mmsNWJTQ=;
 b=E/5CWBXapvEoj2EkJqGqnmAlYXgOW+q+J0kQJa6x5xUtUm6w5s/Gw5LqcGBxyc5Ne357j+0/al/TX9+ys/RKSic0ujQBZEiQmBBmxtRZIdvBiYxFGIuFZuEEe8zaK3H/ui5PZ4STFx2UPXUQP7LCvgAfVZJo03MuaZ5opiWb4byUmjunhQY7zFkI6NFJOmJ5lTRuRvGfTng3QzLX5GZDnEm+hH1DS3pBkYI13/1aQGN+QtjxJpP9YfRDk9oanqgzKbX4LWFNeA++SVVWSMXYwrP9Wf+aVJSIYhQgYp6Fmx6DBJWDV/yXKBZ/QH2B60aAIwVGGxyzKBnOIQtOLRSWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwtDC1JDeRDrB1faaWwXvI4Gw7hPHMSD7X5mmsNWJTQ=;
 b=GqzFLe403Rx5evt2qFjExcZ8tSfR7B+FoBVuzq4hN0vruBUhpWJRNodNUU9zqzK6+ZSbOYcM8RGk4sEYyJggWFwUNGOzmyeL0ONJoAd9uE6dS4cd4fZWD0mdC/D79gVU7YFWoTrW9mV4axdME5qM7zFzvTrR7aJuA18AxqZG8iStefN/qipoxXdtp1fXnbRWQNJiN96BI1lVp1k5Rf4toMX+qmPIGFBJCmK5YOPveSorVaqdoQKdKIlSs+11bqjKykDh/Pmb3UJLKVMND+KiuCVFrEo32KZEzCeeDS2dXdhn9IugzydhJaD3AB54vv6rYkvvLs7AhFShTWYE0lr4xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 06:26:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 06:26:00 +0000
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, linux-stable@vger.kernel.org, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, David Hildenbrand <david@redhat.com>, Dave
 Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>, Hugh
 Dickins <hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>, Mike
 Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a time
Date: Wed, 30 Oct 2024 17:18:17 +1100
In-reply-to: <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
Message-ID: <87r07yp0ng.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0020.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: c0024c27-c627-44b6-c455-08dcf8abb893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYM8rLkuMUMa+i6mLZMdAFJeAwsO6SekJEAKKLzx/w9SOpz56PCMqpfNc5KB?=
 =?us-ascii?Q?Mn/Psio8xaD3gSGDunNUtjWHcbFEnmmZLz6e5aNy+PzyOTM6++LqeJrkldGH?=
 =?us-ascii?Q?xeycgA/pSFqXF0MlBmz0jwCixygGaMGzHJMSyQ+fP7Y/ieYjvxvmeFuUNs0V?=
 =?us-ascii?Q?sRx4CY0U2j9IdRV3SbvrfM6fGPILK75wmqVvbWFyynigOHUH/6Nnl/q8H31j?=
 =?us-ascii?Q?T+kQv3bk1HkPz2p4IrEMzjx+Z3q35g9ps4WyMQh1rYhI9jQY3IX7deEh9TML?=
 =?us-ascii?Q?ubyVXlv53hqWdIp5gvyBaFMWvVkY+Znr5OYj02w3fwdLKLrhcpeVYsaTWYC2?=
 =?us-ascii?Q?eAqVGkSkXPptmGYwMiotHHeA7EL0PplgIPEHzV3Ax1iWnacpfdviHZcy6Adj?=
 =?us-ascii?Q?cYEgbVqjb4nixVc+0M+Uzw6lCRNsLIE0E8Z7VcKLgCAsgBP5jyyvDMlF2THf?=
 =?us-ascii?Q?kNNnRe1t8sQL7uRmRM8N9oxRTp+E23VDJSl6EUT00Lj9FAKPSnT7WaJOAtGX?=
 =?us-ascii?Q?hqO7ugekQg8F1XmOnEcYHrhIPQc7n8FV4UYwDzQSLoLbn46mLvaxtEvdxOCk?=
 =?us-ascii?Q?cYPZe20Egn6Yp00BqYcsZGgV6ESOpWtc4V+16oqXertWdFsyTmMfJYdf4Iv0?=
 =?us-ascii?Q?yZjjkhGPdH/8g30bJULrt3ZU50T/FFTwgFoD1MPK94CmyEehYc4wlwCXtJZU?=
 =?us-ascii?Q?AQU1cC5wgaUiaiRF2RE05YQ23PHf5gvBXGtDCeAW4Zigt5/n1y4urI+AM0ag?=
 =?us-ascii?Q?eAT0WvNN+Il6rXge3KPgdlLGuKAzV+N4n9A4mvBX95Lq4HufgBCt8NnMw+Vo?=
 =?us-ascii?Q?YpUMx20lxBkbT56B4ckNaxTzXbgIV74Y2pxCOOfaodm9h49XVreUhrsRUKuF?=
 =?us-ascii?Q?pw9H3SxvNkL8Z3lFeukeb5zRiry//Uo9MV6tUoFwCa5RHvqr5pf2O4qD7LpX?=
 =?us-ascii?Q?2YcJX/jDX/1JdigwI2APJYRbUz+bCEWSH2x+7Odgw6zpEAuqm6A7CVn9gtnb?=
 =?us-ascii?Q?5AEUK+TX6HpNmINk2PJ64A5m9InqO2XtcMX3d7sptq6t3yYErGQoB/pa5GSe?=
 =?us-ascii?Q?o5ED3N+zBiBPnjmlTwQtiWzU1gg7RBiFcT9HDNzJELxhcGotpIyfCvudy5CT?=
 =?us-ascii?Q?FuQ6zzRmdz+HyV6mcINg1gZwP8dPdOGqbICaRjMVjj2iMdCJ1t7Vf3plLZw7?=
 =?us-ascii?Q?4gto+6sZ2dOMoSSw/zMaoLYo1Rqy9jPFOqg9STQd13UcFmbJ+iWeyCKt9Jhv?=
 =?us-ascii?Q?KKlod2hz/n0EaTYjKFfTHSDJ6dJY/b/5pnJgmipl8yJ7XTcmlwtApjnFbuRO?=
 =?us-ascii?Q?XvldJtNqE/0SMzcH2vhZFlJ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxWHsgRDb89MNPysSx7hjN8rMt5YSFCDERNh/Uo2HFf0lAHPggZlMD7VqpUf?=
 =?us-ascii?Q?pLEzgiJvlVb7NYK8T4kvf1c7k7GZPo9xpHh6zYJWo6NPBA7MlBgJ1Qy2irPe?=
 =?us-ascii?Q?/UUtQA3UNfbgbSaAVggZTBMeIhtZR2bR2D1joRXCHTTpUtgdHamKjxqFy9PA?=
 =?us-ascii?Q?OzKr74qstynkDjMioPB7ph9+QdQcZsGzTaAkTbBCCl88C5YIaJq4Jh+Oo8+m?=
 =?us-ascii?Q?LHeCt5HakOkfXRP1tGQWZwe5MCkcdCRMZGoP/boy4fMjJDhI6Sv5Nte1xZH4?=
 =?us-ascii?Q?exqKl/juMCyHgBPOBHXPu79FGhzB20XoMa59LcdG/1Jf4WWkNLl+kjdxD4Sc?=
 =?us-ascii?Q?HluD2TCvSgynZdtyajJSwbXM5YZK+nNNVAN9lPxVIuovbeQMMqybGi4r7vEY?=
 =?us-ascii?Q?lsd3hqKJzmQCfrA3pxUqXiSsZLlrFYhfxfudPr5WRSoSfw5jkNo0fmpCPx9f?=
 =?us-ascii?Q?00fntvtcGykVf+0aLok7sZJ2ENp+rKTNs9TMWa8k6srniDHJgPU/e3vOCFWE?=
 =?us-ascii?Q?HTEo2e4xI5kExV3aAMvkR/23stWH9Y3c1LwGnhHi8B72FkmXBa1rsL6152CT?=
 =?us-ascii?Q?Trx+qMKBKl4G13+YDZuj5veWR+mNBDxkLXprn/HnIuThssQV1+gC+fQ9MC1A?=
 =?us-ascii?Q?ufg0IEPvV9deXAik/XS5N8+oi0OyHmveIQyS3cf4qE7fFJSqE7zd/rcyiEZd?=
 =?us-ascii?Q?M4AVOFe10gRNXTmdNqoKjoezNm5OnByoEXVG9pL8cxTASZLMYkusIske2WeY?=
 =?us-ascii?Q?MWJkQVCFPFOLeux0+avTvUzaKh9RMHRbKd3NekKXExlNUEB26OME4GjydktB?=
 =?us-ascii?Q?m11F9krfu3kKuj78I8sDfhW2B8dMIYEjb+ITal3UcsVrXM561A0DNlFXW9Na?=
 =?us-ascii?Q?b7o25xXirpkbrY0WNnLlbqp4cMa1kFbL2DDzKhbaUrk6yTlZywBQSXPtcA1u?=
 =?us-ascii?Q?iUq/qn84YT/LVKCQ/oh9MAqoiTM+Hcs0NhKDwAqWtcFC3riKbycxFh3Yu+58?=
 =?us-ascii?Q?TO3cYGXTLxjz2eP1DUhaA7TSgjV/8kLzo1p+baYJJeRBM+sf9OSmt7hCWEeV?=
 =?us-ascii?Q?EUs5iydbgfF13MqN8IEc4PXYkztcNkLWDDxNVEjJRXSYhWAb2bWeqDGmLGrD?=
 =?us-ascii?Q?6YahPDeBBwQ4aGvOB898k5KhAndlAh8Au5meBUf3JaybdnWmXKenaVUENkFL?=
 =?us-ascii?Q?VAJBtuwFGCG4sIsJRCrUnJTBYJbOP9E5HMoKHR3SttNUnUSznY41F7ZDReZ8?=
 =?us-ascii?Q?v4lsyC3rvUihdXeORIKdGAvtY6+sQYkxIn7AAx5A7mHKxAHIFt0gpzPpsx7i?=
 =?us-ascii?Q?DKuzTpJdusBDQxuAwOAdAtC65+UIfEdc/CbOjSj3hVngZOHEFlcKeu+nG1Dk?=
 =?us-ascii?Q?eXBqhStYAlVaj19qw5oILDNXdoda+w3WBtQzzpg/UlDD3kX7d3sX0iVPDWv0?=
 =?us-ascii?Q?sOf/Xqo1e+0Qc/98REt3IiDbSF/AD8jPEcDRix9y7+UL+Bq2CAP/AdOU6fSG?=
 =?us-ascii?Q?vp4K7Z26CX9hLG5drj72kdTsbeMSydxOP0MDpQlidCeUvlOjqQasoI+f62zL?=
 =?us-ascii?Q?+5uzoYul8GeOpDm19bGRWdyUGtL3KTiuNsn9WUjE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0024c27-c627-44b6-c455-08dcf8abb893
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:26:00.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXN9DJ4VPczO6OscU9UzM0lOr8cmJdwJkMS6n1E0Zm32fTCk5rlYZDvzlKN25BkEexMBTG3uVM/fkvEQ84dQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107


John Hubbard <jhubbard@nvidia.com> writes:

> On 10/29/24 9:42 PM, Christoph Hellwig wrote:
>> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
>>> I expect I could piece together something with Nouveau, given enough
>>> time and help from Ben Skeggs and Danillo and all...
>>>
>>> Yes, this originated with the out of tree driver. But it never occurred
>>> to me that upstream be uninterested in an obvious fix to an obvious
>>> regression.
>> Because pinning down these amounts of memoryt is completely insane.
>> I don't mind the switch to kvmalloc, but we need to put in an upper
>> bound of what can be pinned.
>
> I'm wondering though, how it is that we decide how much of the user's
> system we prevent them from using? :)  People with hardware accelerators
> do not always have page fault capability, and yet these troublesome
> users insist on stacking their system full of DRAM and then pointing
> the accelerator to it.
>
> How would we choose a value? Memory sizes keep going up...

The obvious answer is you let users decide. I did have a patch series to
do that via a cgroup[1]. However I dropped that series mostly because I
couldn't find any users of such a limit to provide feedback on how they
would use it or how they wanted it to work.

- Alistair

[1] - https://lore.kernel.org/linux-mm/cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com/

> thanks,


