Return-Path: <linux-kernel+bounces-568939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8338AA69C46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5A67AD8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283021D5AB;
	Wed, 19 Mar 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="Xif70kGY"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2131.outbound.protection.outlook.com [40.107.100.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D731D5AB7;
	Wed, 19 Mar 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424507; cv=fail; b=fSSlnu0MO8C6E7JoLCl/ODBJqP8uIoiTbeJwnhxChU5rLgJfntw4LeXP3KTpX1OBskvChRMJ1GzG0f7AvTwVILvVUvSx0gBRhVkk5pWSjDJhwfeffS1+qLeRbKI6cWFxLFmYmm8ZjwQOMA+d2znKe8ZYH33kvSmiRU+nY8iCbIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424507; c=relaxed/simple;
	bh=0AvWOBPGHmI5GmKPD1CNTT5Li95VFvub4NYChWuR2og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+UH5y0FpE6OgbKvds3ZSaTsnSl25gwOguJ2wC6EUlervsOo+xEpB82XacY7mC0D06i6e6+uJbeZES2EJZxbbBqUdyk479pv4iGGCUFmkaTq/eW07jdAC0If2nTpz6ry7c0ncgikpNFOfsfmdT10BQvMKVBYIjDsXD9NG2048rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=Xif70kGY; arc=fail smtp.client-ip=40.107.100.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3tkJm9gHK+abkUtDLIK6f1fIQuxplMnWInbbp23DiAes0lUkU5ZGnySNb8nAi86HU3x9A7gKCX03IfDhMr0gg8vPYgP3qSJVWOcO1tvCZJXMiAfmaMkAFWrQ1LDcmJ26giFGUV13GJ1Ob/FYoESY2ZMRcLTeJfLrekjfDy16NYEhjzFN9AB6fHr8lfkQhA/N16zWc3NTxWX64RlwdBB8zCdMMaCdHPs/eW2FuSih9PmWsTYuazBTQxqKTJxFbONlAAcTQVgDmj6ttDkGoq18A4/bg4ve92xq235WC8OaRVwF9mMWNsLRWriHIwlaIYAJrRy/LjslbiH9uJ/gJZBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJUkkURFwKsguX/NYHXVQ7vAXfJBA0d6EeAikIrFg1w=;
 b=wDZrhmClb3EWhDwIm6fDSyDjh2SgrLGNMy5IwFsTKYdBbAZI6qYo/tdaOBKeCrJGYasu8RQUHU2dEKzuQdrpRQNkOV2uXR8tBxC3swP+9fzWEyJ+MNwyAaSZ4IRPr3R9cJSd6ztt7FGQQD4uVF1yV1g4yjlq23egmrTSE49eLvA602zFhYUtVNzmfuVH4L/YeRNz/+Fd0I68hMQ9wbOqFoW/XiyhfhVTq9JTpEVXUpEIr9B6t8Q0CQ82Odzt3VF0FAgk/CHGPs5I5IYAwOq+MWdRfx/NFqH0aNq2ipLMPA0NDJ+N9PveF0xoBcwthYBa5vvAqb8Vil/a5xeVRUXFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJUkkURFwKsguX/NYHXVQ7vAXfJBA0d6EeAikIrFg1w=;
 b=Xif70kGY98DT51bd5oEClmzu9RZqNGnZCn4IIoydBx4ySU81tcZvgQW0+qjxYqQmdAn1I3wFVvX00gfa0iOwgmkdFLI/j/7pAkeyks0UZX51QycN8Q0kVZTBxJHoUi3CN5cnWslHiJutbZlpPyrbJUP56dKsiTESNSovNadAwA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DS0PR10MB8007.namprd10.prod.outlook.com (2603:10b6:8:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:48:22 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:48:22 +0000
Date: Wed, 19 Mar 2025 17:48:19 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 6/8] mfd: ocelot: correct Kconfig dependency
Message-ID: <Z9tJs-sDvvCDFIan@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-7-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319123058.452202-7-ravi@prevas.dk>
X-ClientProxiedBy: CH2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:610:38::14) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DS0PR10MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 003390b9-6b7f-4822-7937-08dd673826a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++y/1mMSnzKVrSCDET7mNllHqb5ChDQxleSwEcSeIcRiG3DI4IhyGkrisr+C?=
 =?us-ascii?Q?JdKDvg+HXFYfIctvMzryTjEDT6+nWSjVwt5UmRIQlbXm4l1IlFIoVa6ju3sv?=
 =?us-ascii?Q?hsiec9/oBXLmtWU5O3D/EfnQ7ZsQY3J9S5drvJvSS9vmWY6csCcOFsOz8VEB?=
 =?us-ascii?Q?zAR2RU5YIzRVp8lfYjIXyWbaIy+V8NmwrPSr/cCkwGiP7tKM2pKI7nDdyhyp?=
 =?us-ascii?Q?ond7uaEIV0a7eOaWGKagW3eZHHxX8K462JAi1rT4WUdvqt7fGZ7TSBkQMEPL?=
 =?us-ascii?Q?hXzY/euJZwRu62WBNz5m6Wq9QcG+Tdf3DBH8OmdF4pQZwzBdkQnL2M3ylea4?=
 =?us-ascii?Q?r5WrHk2ZhStnBXRi691D9L9+Bp2FM7vjdUlT3Nh/2FmePLnzv+/czxd+nahk?=
 =?us-ascii?Q?h8Gr164X/g7PGvuFm9QnzJn9vxuZOpSfrE5/USp8L20eObqUQeqQX5vcKCvl?=
 =?us-ascii?Q?YTqfs2i9AP83tpJ84jGY93uh7vFSpVicvo75HsiUb7bmv3Q48Ab7RBqQoVei?=
 =?us-ascii?Q?K/EhJ9AWU3NYWb2pDYoIlCVH9JO5DLiQ+4xdMMmWOFOBBtogy536ly/REKzM?=
 =?us-ascii?Q?fBartZV2nRXSd2fYGa/IgTycTLlDMS6CXVAQVKCSJjrNt4/+N7qFlBx3IdlM?=
 =?us-ascii?Q?tNLidoxq/99JJPNRcUXrg6A8e6JC3Byb7rX9CRFZo2hk7JceMmlV+PuMnGW7?=
 =?us-ascii?Q?Ks5qT2BQFGcG1P0LjBy9xwYEllyFDh17Y4t1dm3Y99wpFpQYq8JTmsp7EQDn?=
 =?us-ascii?Q?aswe+DLkfkPOhWw/e6+5SuTleLZv4zGwcZmh84GFGHuUMcyPPl0vMI2EiS/t?=
 =?us-ascii?Q?JA+aclXaShWGsfTxSS5l7Yj3ZvYywhS/uFRFa0Eyz5ES3TsmJ8r81CwDghql?=
 =?us-ascii?Q?w5aBYw0k7y2keIiRQTRO2i/LC+XKvzSgzI1Hn0I/U7XkGOztubzo6Q2SRzYR?=
 =?us-ascii?Q?gQxVE2gRtQIZCb6rhavrBU6zhE6Tpfhq32UI0NYDakRxKolEyqt0q7aDkmZT?=
 =?us-ascii?Q?Go338C4QvOSf/I9CtiUKcigr9MqyG2FYI/GvCs78s86LRoAIAe/WcuYlWZt4?=
 =?us-ascii?Q?CHexR3STKOLxpD70LQf+XCA37si/ZyJpoAJZMjV1e0T1iMISjMROyemoW1Uy?=
 =?us-ascii?Q?yR1hNA1eeEgbyorswHYQuj7h6gaX82iWME3pdC9oQq91+hoZpOhmBmXj0wd5?=
 =?us-ascii?Q?DawK/B/jyc8zZ0c3UaI278UgR4WAUzJXTEE3r0Dl8BjaXUDEi1wbz2P4KuVo?=
 =?us-ascii?Q?XfaHWMPVhcnBzsjhaer6aYZAE70IHwftIHhkuB6divuW8YMjzFAbmFIlCfCd?=
 =?us-ascii?Q?ypbMXwdmhmqsiXYtc9yL7ukSHc8cy8K/GSCe1j5hFnVimWPgApK5r+8HwHS2?=
 =?us-ascii?Q?/6fCbIUDji6+OgsVdvUrikttzhxL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8E+i+eJz4M3w6ELFyXicMbW6pyO4Av43bv8HNypKThOVdMge1NaR1kqxUgGj?=
 =?us-ascii?Q?wdkUzMinbt1FWL14phNJJVU2NeMZAp8WdD4zrJDgSiICAeI6B42ylmPWCShp?=
 =?us-ascii?Q?CdUW8dCuZIXUNhKjW+PO/U4PcFz+c5Aof9Kr5dBTQ2U4+L2DXYkZo4zDRe2P?=
 =?us-ascii?Q?pnu05zUlKsR+h4g9yISSxwGJz9fhi5MrKK8qZKKVEW/0gnFhBjl1fx7neZLk?=
 =?us-ascii?Q?MlFFlAxMX4halyo8mYr04+b3uPhERVqCE2pm2j3pOJ7fs6S5gaySxfpiED8p?=
 =?us-ascii?Q?LlKIAeBndtnjSpPJY/r9mc41lzSjsQwmKzY9LcNC7Jm5D3BlGNwG0e/U3RnQ?=
 =?us-ascii?Q?It83PF//Vpy+3IV7pT8KiAKDz13FpCcWLMLaIGax7m7n8WUymJNa/2p+/lm2?=
 =?us-ascii?Q?xoZxSLYEKkO4NhkA8ibbt6LidXxwmNX2PngtqAtm2oqyGzDLQ4DAMo5txddi?=
 =?us-ascii?Q?TlnLvM7aW2D7ghjBxNVtbsP8n1UI0JTPFwKE3Cxp3c9r75jymu+oL4axZYwf?=
 =?us-ascii?Q?HcVBWHGiipdfhe36s3ckI7l4gTgz0oCgmlmlmCUcLjnYgQgpA0I2Jc5/Gc6c?=
 =?us-ascii?Q?t9DhD/oDekDTDaZS8bPbTi74hJhr3+SUaOMnF417/jfKddf5i+3cYf9BAEjK?=
 =?us-ascii?Q?6WhQD/RapoqSb2wf/U5xMbRqite3uHINuxknbR7vhf5g93K1vO2mShOSjkoB?=
 =?us-ascii?Q?hbYWaag1YqnNNsOAJgrEClVqAkOwYul3l2sZgFV/5kGbgvUsjixqFDxO/MNN?=
 =?us-ascii?Q?OF0oFtp8OkkKKRARRbtnU3q0w2DKB/94ZLVbobSWCoUYFSik2hwM5ctF7vkJ?=
 =?us-ascii?Q?NAGVpyNF9X51d35Q2NxBf0r6TpNAO2imwXiljPdx03j/ozpAXu8DSgetwLZg?=
 =?us-ascii?Q?g2RMVhLUCp/n3qS7tmaJNLLxNhzI5WLzmTWHIfMkuSJ50ocdfwIkQKP5+A3O?=
 =?us-ascii?Q?hwxSdXmWY2oklSr9yDTgZRG/BzZux2AKzHI4gTCj/erKxjLhCiJeXQgOdnAU?=
 =?us-ascii?Q?7pXFK2aSrWKym6/DypP3gqNIjGm0kAYReIaZZEzFSTKicEaUNDwCwcY9bRL0?=
 =?us-ascii?Q?KVIwPUpI8KmowSqv31Xqtw3+BimA0jouv5CfMqkjnsImMnXLyNpSD8i8DLn6?=
 =?us-ascii?Q?d82mIYCaETxmyMGWjkxp0LHW/HP/m2iIkxOZynqCUjBmtrtGGqIqvPG4c/0u?=
 =?us-ascii?Q?EiwC7wD8kVKPNmJ+EORXKz6rXcjmwP8O4Iu/x4PYTot3tjl74l5nlh4DoUsA?=
 =?us-ascii?Q?+l5V2LHCMGqe25Wo4SZRyDdOFYhzdZrZyrxg2pbsrG5rV+xRH4OvPwa3jTzY?=
 =?us-ascii?Q?UBbA/cjar6pFk0BTnSzGOIlF6g7HQrtZmAX7qHPbauUUoMSLA9rW4plbS71U?=
 =?us-ascii?Q?UYo+1rvtc0+10Xc2798VS87mTG2STDWB6q9hhuBLf22ZA+xTlrvUUCBk+SSk?=
 =?us-ascii?Q?5pPCIqiHlwt/LuZqNafvsxKVb0+gmj5C4KRuqPjoaHBLFZWhDXydNXz5mIxb?=
 =?us-ascii?Q?kNQAEMtbsxVsZy+E4RpgigdPOBe6X8pPza/kDbtp2zGeN/yHStDb6Om97052?=
 =?us-ascii?Q?HYsbsUCeG65Rwz3u/xn4XAST5PAIGjR0Xbk81g26Zs6+AhlPvrBLTDW4pv7Q?=
 =?us-ascii?Q?nH1FdAwTF4kAKA2zA8NHGQA=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003390b9-6b7f-4822-7937-08dd673826a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 22:48:22.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOK7+JLff+eKD08iCbQIAaUEDPqgxYobeuWcQ7YzXj1QTV9mAe9tPCWCHHFDq4xC2VHH9/Qw1MKq3hV7HJq39BmoatJEszXFq9v66BQ4LkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8007

On Wed, Mar 19, 2025 at 01:30:56PM +0100, Rasmus Villemoes wrote:
> The ocelot-spi.c file does not actually use the generic spi regmap
> support (i.e., it does not call any variant of regmap_init_spi), but
> instead implements its own specialized regmap (though of course with
> spi as the underlying bus). So it should simply 'select REGMAP'.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

This might have gone back and forth a few times during development. Good
find!

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

