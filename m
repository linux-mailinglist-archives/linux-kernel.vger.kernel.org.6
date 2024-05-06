Return-Path: <linux-kernel+bounces-169343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4907F8BC759
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFE1C211C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4BA487A5;
	Mon,  6 May 2024 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="sD+wtRD4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697514879B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975521; cv=fail; b=XDnBmFd/aUtCi043aBuZ0Ztbi1LWIVP/UCHGuZZ87UfAjXZwFEvEx/+Vo4KTgehp7N1+2ycu3CaLX9d2sEJgQeJVI6bPhYuxqMXXc06wx+kzVgzZD25vee8wnno8Xc+NMRJg6shfvaCalwkn+zqKa9rvoqyqVOpEXbB61A2Kxv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975521; c=relaxed/simple;
	bh=tRORoS9Mz73nnJS61hBk7RFN+0V7+fq1Dfh2Q+iv9dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kLaWlf3uQk8wDUGkMYHEh3Ah9lvR1ZmJ4LYZYtIVyxEnygubqzN0U3MsF+m5i0NStSd2d0pCJozy5XKKSxiC2rfeLuePRPtgvP3i4dAPCikzwPuwCvglx1zBnAcPI6k2FzYMasGZkDAkvulxxUnmUHb2svhWy8prwEKhcgO9HLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=sD+wtRD4; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahJz1A+PeJ64q95MTjnDXfFNBADDS1iUEpO6+vNM3J8varQW7R2d2qIOCt9QWx4Rk1JN3aMK+QGjgytuVcFVJxpZ8lLmDq7mT5jTD3qdES6FBjzziQvG+HKD7JSC/wr34pHc5szJ9KbmhA8A0TAds/4kTuTugMkufNRyBQBCz197us0rVPO7Zol4rGYxNv5xSEN04xmdESaWotvMPe9Qji1i4zyP/GNds0EFkpx63aMy4sHhbOr14yrmEEzij/3IcOGrLtSvXvNPiczPgkQ9CXLoaSbaglYQGtyPIhB1O/YhNmL9Ayq1W5Z2p8IBisbmRXJydPM7D41JympgVoQHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ygtQkXcgmIDDCerFKfrHC2cqMB+flsKZGBy9dwQsDs=;
 b=AI0j2YG/QFfJh92vmK9rJ/ysvP52ynb3gfrVVOms7Rg+9d/xZvD+573KaslEr4qHx264mV9IrtdmJtYcHWE8gbbFUpvPodJnbfjeTxFf/rKj3UQ0aI3VawUoBPd6NqdfW8SFuTXuvDQJiLhiyJEccalRSoipq0y9XZksVrMfej5PJCA99FZIzidtxGrbllb9HEaDLQJ8BcgyntGyWeNHHdiDSIPAMIftXOxPX04oUGPMmsvcA3WQRttXqE3Rixy4n6LEkySpmnqwPDQTkc2RIj2KiQIbvu1vg+dTBNjjsI/1WgTCr3GSX8rU7S7hqPbjJbdlbLR34R1z+q3tSYaatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ygtQkXcgmIDDCerFKfrHC2cqMB+flsKZGBy9dwQsDs=;
 b=sD+wtRD4AMixoWHr3fR1nrB7yF9RxpMuCtVvnErMwPXMRsJEZfFYNQGt4x1EMNb3IteAhzoA8PITmXUcX6D62a5VAL8f+kuwlPTkkx8VUOYszgB4eboJ+F5eWtKAMP36UwGJfOGUaRlz9D8eSDNoV+qXMO/2m/hK5G3/O8FKPIdS8k/VK44vJuuoIriwFd8WsDBBLaAWWoFwyYCjUrZczivgRcjqHAOeWP8wB1IVgFURXg4POZ2fjsVRp6Pw/YxbAcMorBavRbHSTb0JzLqzI4YJDRHoBYuDhR8q7vA/RAcNSwtoWqDo0nP9Djwex2f/iNl8XBcryVH4ou2VpQ3QXQ==
Received: from DUZPR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::29) by GVXPR10MB8274.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:11d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 06:05:12 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::23) by DUZPR01CA0147.outlook.office365.com
 (2603:10a6:10:4bd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Mon, 6 May 2024 06:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 06:05:12 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 08:05:11 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Mon, 6 May
 2024 08:05:11 +0200
Message-ID: <479de772-7f12-46ff-a3ad-cde9e125bc12@de.bosch.com>
Date: Mon, 6 May 2024 08:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Rafael J Wysocki <rafael@kernel.org>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Eugeniu Rosca
	<eugeniu.rosca@bosch.com>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
 <eadf2812-85c8-4458-b504-10a60a16d1ea@de.bosch.com>
 <2024043041-arrange-defy-30de@gregkh>
 <4f197ed9-e0d2-478b-b236-bea682303e91@de.bosch.com>
 <2024043005-crusher-repaint-e02b@gregkh>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <2024043005-crusher-repaint-e02b@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|GVXPR10MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: a800215a-bf85-44ad-bf51-08dc6d927df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxTV01ja3ZINDhzbjFWVEkvU0NJRWphSnV6V3pibC9kTlFrR2dEY1RCSzdY?=
 =?utf-8?B?bUlOYnBHRG1MVXBZdFBGY0xwNjRBR014Y1VZZ2tlZlRGVmh4K0xZdWwxZ2U1?=
 =?utf-8?B?WnI2alZoZ29KVjJISlhMQ29HNENUYVZyempyNHhEZHhkRGxPZ3R5V1pHc3NU?=
 =?utf-8?B?ZlMyNmljangzMGJjQWF0Sys2bzA4Ny9HbWhCZm9zU1hJSXRuZzdQeUswQlpG?=
 =?utf-8?B?WmxtZGRuZFJYanlrUkRGdCs5MzNlU3FNWjBxeTlXM3lseGYrNzU4RW9tY0Y5?=
 =?utf-8?B?SVR6ampBQXV5STROK1ltNFNaR1JvWUpZOWdBQ2VrSVh0WFZqZkFFTW5jZE0y?=
 =?utf-8?B?dHFQWEhwSU53Vk5xYjZwYVF4aFErR3JWVnRBYVRyNXN4QzlzR3RlcHZzeDkv?=
 =?utf-8?B?NTZkK3ZGWTU2b25uYjVLMTFRa0VrQ1V1bkhnL0tIb2lQUm5SUm1kbWZibXpQ?=
 =?utf-8?B?amRndWY2Q1Fra0ZkcVMwaURwTGgxbFkwcDhManlBZ0dxL2pJSlB3Y0dwU21a?=
 =?utf-8?B?ZHhma2ZDVEo1cUFsTlAzMHBuUnBnK0N4VU5FY244WXRzL2dxNjVHRGZhcExN?=
 =?utf-8?B?OThCZHVuN3hrS2twWVk1NTUwUGJMNHEyNlRLejFyc3EzVjZMZXdzQ3c3MFFQ?=
 =?utf-8?B?bHRvV25RV2FFcWV6MEJsU0lCK01JOGptcU9FSFIveUpEN3NtRU1MRWJUUVoz?=
 =?utf-8?B?bVQ4MUh5V0llYS80TlFBOWx6L3pHazNiQVdoaWg2UFg5UVJKUXhCS2JsWWYr?=
 =?utf-8?B?NjJPUEI3OEdhUjdHTXFlMmhTOG1tYnIzdHJZSVVFRFMyUW92S0xWTFVFMmxk?=
 =?utf-8?B?QWhBV0wyK2JMVjBNMHJXeFJ1TG42dmIrTkV4cmw3S3dBQVZjd081dlo4eVdV?=
 =?utf-8?B?U0V3cW9uUmJ1NmcwejNOMkNHNEpYdFFtQ2cwK2xRWnlGVk5iQThJMlBCZWJL?=
 =?utf-8?B?WHlBZDFydSs5TGVabEI0TTAxL3F0VkYwTHNaT2RVRXBaWGkvbWF2bGM3UEdl?=
 =?utf-8?B?cjZKbkluZXRudDZUSGN3Sm9QTzkzeXprTUNIQzlXVjNNYXFoakZCSld4cFNo?=
 =?utf-8?B?eCtya3RraXo3RWFib1dQeW1iTXVVZHJOT1hMaGhJaHF1c3NTQW13TEdOVUhT?=
 =?utf-8?B?ZEJ3dlhobG5KbWYwYSswbXpmVXdoQ2dJREdTcnJSZXRFMlRJVXFLNit6MWNk?=
 =?utf-8?B?MGNXRnlNUE1nby80NVZDMnZSSHVFa3phMHc1TjdXd3hqT3Y4ZnM1VVFNaFBw?=
 =?utf-8?B?YzNNWldWVFhIWk1OZG5RT2RBRHBlQjJmM2RmWm9WSCtoZGtZQU1jNDBVYXhs?=
 =?utf-8?B?UnVrQjc2YXREWTJxUSt4Q0I5RVZ0dHBKcHg5ZDZ5QTBLdFBXVUx6ZnY0dkNG?=
 =?utf-8?B?ZDdva0NNV01va2lJTVdJMGpRU1ZIZWVIbXJVTjNQWlNqdVk3UzlaMUVlczBN?=
 =?utf-8?B?enU3d1hLSTZLZURMWWhLSEh4c2tnNisvbHQzYi9aQ3Q5VnpOQTlVWnRJQzBa?=
 =?utf-8?B?QXA1VTZ4N21lc3V0cVBkS0crN3VEVmVRckd3MzQvcEI0RzNBcnM5a0RUUTl6?=
 =?utf-8?B?VEFMR1lsR0FZaU4xclJjTEk2ZXgxZEZpTjdKWGNuQkh1WWxDVkxhZDc2dE1T?=
 =?utf-8?B?TERyWjlPNmJlbzJ1YUZ2c1hNdGVNbWxYaXFlbXViMTBXa0tOVTFwY1d1TDV6?=
 =?utf-8?B?bEMzVHV1bkNGOTRjWWdzekRzcUtQUVZudlhueDJibTdrWEowb0J0UkdOTmpw?=
 =?utf-8?Q?bO9DM59W70l9UTUeEKRej2eZLxMySo45D/quos3?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:05:12.4740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a800215a-bf85-44ad-bf51-08dc6d927df5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8274

On 30.04.2024 10:57, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2024 at 10:50:52AM +0200, Dirk Behme wrote:
>> On 30.04.2024 10:41, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 30, 2024 at 10:23:36AM +0200, Dirk Behme wrote:
>>>> Hi Greg,
>>>>
>>>> On 30.04.2024 09:20, Greg Kroah-Hartman wrote:
>>>>> On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
>>>>>> Inspired by the function dev_driver_string() in the same file make sure
>>>>>> in case of uninitialization dev->driver is used safely in dev_uevent(),
>>>>>> as well.
>>>>>
>>>>> I think you are racing and just getting "lucky" with your change here,
>>>>> just like dev_driver_string() is doing there (that READ_ONCE() really
>>>>> isn't doing much to protect you...)
>>>>>
>>>>>> This change is based on the observation of the following race condition:
>>>>>>
>>>>>> Thread #1:
>>>>>> ==========
>>>>>>
>>>>>> really_probe() {
>>>>>> ...
>>>>>> probe_failed:
>>>>>> ...
>>>>>> device_unbind_cleanup(dev) {
>>>>>>          ...
>>>>>>          dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
>>>>>>          ...
>>>>>>          }
>>>>>> ...
>>>>>> }
>>>>>>
>>>>>> Thread #2:
>>>>>> ==========
>>>>>>
>>>>>> dev_uevent() {
>>>>>
>>>>> Wait, how can dev_uevent() be called if probe fails?  Who is calling
>>>>> that?
>>>>>
>>>>>> ...
>>>>>> if (dev->driver)
>>>>>>          // If dev->driver is NULLed from really_probe() from here on,
>>>>>>          // after above check, the system crashes
>>>>>>          add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>>>>>>
>>>>>> dev_driver_string() can't be used here because we want NULL and not
>>>>>> anything else in the non-init case.
>>>>>>
>>>>>> Similar cases are reported by syzkaller in
>>>>>>
>>>>>> https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
>>>>>>
>>>>>> But these are regarding the *initialization* of dev->driver
>>>>>>
>>>>>> dev->driver = drv;
>>>>>>
>>>>>> As this switches dev->driver to non-NULL these reports can be considered
>>>>>> to be false-positives (which should be "fixed" by this commit, as well,
>>>>>> though).
>>>>>>
>>>>>> Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
>>>>>> Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
>>>>>> Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>>>>>> Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>>>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>>>> ---
>>>>>>     drivers/base/core.c | 9 +++++++--
>>>>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>>> index 5f4e03336e68..99ead727c08f 100644
>>>>>> --- a/drivers/base/core.c
>>>>>> +++ b/drivers/base/core.c
>>>>>> @@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>>>>>>     static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>>>>>     {
>>>>>>     	const struct device *dev = kobj_to_dev(kobj);
>>>>>> +	struct device_driver *drv;
>>>>>>     	int retval = 0;
>>>>>>     	/* add device node properties if present */
>>>>>> @@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>>>>>     	if (dev->type && dev->type->name)
>>>>>>     		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>>>>>> -	if (dev->driver)
>>>>>> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>>>>>> +	/* dev->driver can change to NULL underneath us because of unbinding
>>>>>> +	 * or failing probe(), so be careful about accessing it.
>>>>>> +	 */
>>>>>> +	drv = READ_ONCE(dev->driver);
>>>>>> +	if (drv)
>>>>>> +		add_uevent_var(env, "DRIVER=%s", drv->name);
>>>>>
>>>>> Again, you are just reducing the window here.  Maybe a bit, but not all
>>>>> that much overall as there is no real lock present.
>>>>>
>>>>> So how is this actually solving anything?
>>>>
>>>>
>>>> Looking at dev_driver_string() I hoped that it just reads *once*. I.e. we
>>>> don't care if we read NULL or any valid pointer, as long as this pointer
>>>> read is done only once ("atomically"?). If READ_ONCE() doesn't do that, I
>>>> agree, it's not the (race) fix we are looking for.
>>>
>>> Yes, what if you read it, and then it is unloaded from the system before
>>> you attempt to access drv->name?  not good.
>>>
>>>> Initially, I was thinking about anything like [1] below. I.e. adding a mutex
>>>> lock.  But not sure if that is better (acceptable?).
>>>
>>> a proper lock is the only way to correctly solve this.
>>
>>
>> Would using device_lock()/unlock() for locking like done below [1]
>> acceptable?
> 
> Why not test it out and see!  :)
We tested

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b93f3c5716ae..e2a1dd015074 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2723,8 +2723,11 @@ static ssize_t uevent_show(struct device *dev, 
struct device_attribute *attr,
         if (!env)
                 return -ENOMEM;

+       /* Synchronize with really_probe() */
+       device_lock(dev);
         /* let the kset specific function add its keys */
         retval = kset->uevent_ops->uevent(&dev->kobj, env);
+       device_unlock(dev);
         if (retval)
                 goto out;


and it seems it fixes the issue at least for us in our tests.

It looks like really_probe() does run with device_lock() taken, already. 
So we don't need to care about that.

And depending on the call stack dev_uevent() itself is used with 
device_lock() taken sometimes, already, too. What means that it should 
be safe to call the whole function under that lock (but can't place the 
lock there).

So this patch goes one level up in the call stack of [1]:

  dev_uevent+0x235/0x380 drivers/base/core.c:2670
  uevent_show+0x10c/0x1f0 drivers/base/core.c:2742  <== lock here
  dev_attr_show+0x3a/0xa0 drivers/base/core.c:2445
  sysfs_kf_seq_show+0x17c/0x250 fs/sysfs/file.c:59
  kernfs_seq_show+0x7c/0x90 fs/kernfs/file.c:205
..

However, we can't prove that uevent_show() is never called with 
device_lock() held, already. And that uevent_ops->uevent() never calls 
anything what might break with device_lock() taken.

Best regards

Dirk

[1] https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a


P.S.: It looks like this issue was discussed back in 2015 already ;)

https://lore.kernel.org/lkml/1421259054-2574-1-git-send-email-a.sangwan@samsung.com/




