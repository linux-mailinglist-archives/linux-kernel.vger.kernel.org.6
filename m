Return-Path: <linux-kernel+bounces-527996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C6A41241
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C141892CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C023F41D;
	Sun, 23 Feb 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Nr9H4QfD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2098.outbound.protection.outlook.com [40.92.91.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158F2397A4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740353530; cv=fail; b=Pb3vwuLS5BEM/VcKoFzr1hW+G5C/60UYYj/cj/9LL0gLhsjBwAcg68rbmRZjZ4bmgHDnNpl4HlxoID4Aw8PNoBtYXVYN3VflHTCB7eTsPfHMU/sdY2uSNhIUBd3fL8VQS1s85X6wWxonhGkvYA4qCLWqNspI9edQuU76qbP5coU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740353530; c=relaxed/simple;
	bh=feYW8ZaO7cL6yvbrdWs4yhHeRaRwOquKLV2r7fsZX9Y=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=lm1mdUvXsA9fmZ2uB9x5tWg0m3Vcdafht/jGUYhM63995nfbXaDwRy9KI+MLrUPt+nx/XDHt0TAQJK8c3719KkwUIa5CtsES/bZwJ1IHLwK468kOd53E1641wjoGsA0eYOzIGJGrfpmyWGLI/TZ4UBRdBE3UoK9fdgQ1D6kSNlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Nr9H4QfD; arc=fail smtp.client-ip=40.92.91.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZs+KiTyrJhY6SdFQTamh3uDJgKsT1UC29+nk9uCGKSSe6/tH5wyEQOqQoI5ymDht4oiwA/tX5wXX0Bh/j8nfUCYYNqOdprz+8l4UiJnzO+PSGMcz88SxvsVDfDvsVj8FnfaqAb0XuzZVaHmypiZCewV9wjsw79eDjTR+YGVWSwHDqQqoC9MFoeaYoBl0/aMT57TdpcYd/qJhTMyz4Ve5xVoJeTeTXkpUJUfRLGMBN72EdbI3OZsxNzva+jwuJqjfWOs4sJHMeKzynv9GSAiVEux40pU5KosdtRfg8CSND30hb9ehm2yOmd2+sm6DCVsCYaKyKWBmHH4BwI6JnYzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+StuO6TQxrPW2N0FRbbllLnsL1q4xUsP4LIeu70Ki4=;
 b=EC9REnMROFclOFymmNurn6IliJosAK74Fb61sPIRlJnfuLP0i3bXk5JbbX6JPWNdjwYAsysgqESX3Sews54TgBeYjd9FFpc7rwPFpZrN/wZYUissuKS6159c92kcwrmpP0kO1E1b2jb+8x+mhgwmNxmy2uMUgFNQjZ23Z7l3W/Y8b0Pmyjq7bCgIDfg2VEFVxE5PPjq3/GFRTPlSAsfTHH1GIr1HncNsgRSEG+b/W13Kf6OlKWHYipIBb3S3P+zPPWwgD2DeUmyrHL2rPnIf/dnqLOZDwuwpJUiwZz+z9WuIZySdCrwmw8KE/T1j5CIMpA0MX47IK7r7V19keCcOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+StuO6TQxrPW2N0FRbbllLnsL1q4xUsP4LIeu70Ki4=;
 b=Nr9H4QfDUL2MjvyBj3QY2IY+gJQwCL6wefncSopFSAtubsAhKZQC5X3g1EXfWoLtvvxJ1HqXzEQQ1/Qc9xIwLRPW+b7cCkGQ9584u+pIqQ2g0d7XHTxqqMJUBrNkOOQk2bUTM17M3r6TLPkeMs1qlickJPasUD5xXxX1MY7qlQj0d1z1+KIphgtI1p8Fuohq8mDCja1fxg0sKNHZMbzJx4WCu3BlhUxXmgrAMIygdH0+H809eKtuKttnEgga7oBDvCY6neOIxWA8haMwZfmgFCHd5wqQifM7eS2W1HFKbqakp55Yy6xQyxO9clb7i4EGGLHthEbRDf+GX+jyI6mtMA==
Received: from DB6P195MB0389.EURP195.PROD.OUTLOOK.COM (2603:10a6:6:4f::12) by
 GV1P195MB2684.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1f1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Sun, 23 Feb 2025 23:32:05 +0000
Received: from DB6P195MB0389.EURP195.PROD.OUTLOOK.COM
 ([fe80::b1f:66eb:c66c:3bd1]) by DB6P195MB0389.EURP195.PROD.OUTLOOK.COM
 ([fe80::b1f:66eb:c66c:3bd1%5]) with mapi id 15.20.8398.018; Sun, 23 Feb 2025
 23:32:05 +0000
Message-ID:
 <DB6P195MB0389A9C52E6FFDB3ECE2ABDC93C12@DB6P195MB0389.EURP195.PROD.OUTLOOK.COM>
Date: Sun, 23 Feb 2025 23:32:04 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Albergaria_Coelho?= <andre1coelho@outlook.com>
Subject: Process address space
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR2P264CA0023.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::35)
 To DB6P195MB0389.EURP195.PROD.OUTLOOK.COM (2603:10a6:6:4f::12)
X-Microsoft-Original-Message-ID:
 <7fd33cc2-77dd-47c4-b39b-80fd3715dbf8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6P195MB0389:EE_|GV1P195MB2684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de6575b-664b-4766-8426-08dd54624815
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|5072599009|7092599003|8060799006|6090799003|5062599005|19110799003|13041999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGpscVd3dHZRL1RBbm1CQmFZMXFZOE9PNHQxMmpydUJsbFI0ejJnV0ZsM0Yx?=
 =?utf-8?B?TlZFcFZZNU9rOEFOdnYvbXdaK2xaOUlyQ2grSTEwUUpoLzNndXN5eVQyV09M?=
 =?utf-8?B?ZUVmQUI5ZGpGTHI5bHJUVUtveGRsbThNUXVqMytud2xNSlZFMFJOamlZUXNU?=
 =?utf-8?B?bDZpRytXdDZKUk8rQW12UEJpOXFSYkE2dEc5M252UlZValdmR0dKMUJnQUo4?=
 =?utf-8?B?R1dxUGtqN1lLVWRudDJEUTMyNW80ZEVOemxJcjlyMGI5YmNhdi9tb2VrdWsy?=
 =?utf-8?B?cGQ1RUF0Q2VoSm5YajBVTThLWHBqNExUZVVGaktjVmNTOU1JNy82aEpDMWZw?=
 =?utf-8?B?RFgrUm1PRFJCUUQ0WThyRzRuTE00N3FYRmpqZEhUbXNlNER5TThjcVZpeFRq?=
 =?utf-8?B?TW5pMzAzQ0VUYVJJMEFQUnRaZGdpT043S0hQSlUwanhLcGIzL3RQUkd5WkhG?=
 =?utf-8?B?c0pHY2J1NEpBdlUxaWo4WFFKRDRid2t0cWwrSW4zQmZVNi9ENnZsK1RaaHFz?=
 =?utf-8?B?cFVQaUtGYk1kOC9PdkdQNGZnNDVxcUhwaUpmT3BiRGszRExLSkVpM1hLdHNi?=
 =?utf-8?B?UUFmdjJEQmZUWTF5WXFyMGFWQmVKeittYUxDdmNoemQ5KzVldittemJtcjNK?=
 =?utf-8?B?ZXBnNm85VWZVaVQ0bjAyb1BsbWZ1Z24xUUc2b2ZxRnp4b1djQUhwdVFTa09p?=
 =?utf-8?B?ZlVmVExkN0dtcTJwNHN5bklCSjlGd0VKY0ZLY0hSZCtkRzkxb1RQL1F6Ky9O?=
 =?utf-8?B?QWNseVhFajg2UXdaN0RYcXFDa3g0dGZFVEpBaXVHY1VabkFyQXBnS0NNc3FY?=
 =?utf-8?B?VzhTb3Q1MjZlSUZWSVg1VkpCUGN1d0hHV2F3VTJ5cDJhRUpmdHFmYWluYWRr?=
 =?utf-8?B?Z0hSais1YmpmNUZtaWREazZTajZnMTlYWE5oOUN0a2hDanFGaWIvcVZtOUI5?=
 =?utf-8?B?Ry9xQkc5ZHAvQkpUQTc0a0FNcjR5VVRsUG1kVEs4MVljMVRXZ3RYWDNJaU9x?=
 =?utf-8?B?TWxCSEkrb3p5ZnRZcjZ1dmxoZlZRZTVRLzduN1VCai9LWlRYdjZDcFNOekx6?=
 =?utf-8?B?cHh3dytKNjlJVE1BVzBMS0pLT291SXZFd281ZVhtdVV0blZ4U01rU2xnNDlu?=
 =?utf-8?B?MmJNQlNoVmtvMlBkRXpVY2dxRldGMHdndU1IU3JHRkRsZnhiYTRpWXVsZHVB?=
 =?utf-8?B?ZklqVDVlUm50RGxiK1EyMWp1R0NpallqSG9HakZmcTZkcnhWV3o5VFFTM3lj?=
 =?utf-8?B?ZXJQUWprK2ZGU0Q4Znc2RGMrNWV1Um9Ma2FYeDRpQWRJQXhLNUk0cy9qYVcy?=
 =?utf-8?B?andaVDd1RHE3WHFlL3BrdjM5aDUwMW9kTktkVTVKUnNoZ2dLcm81QldYZGZv?=
 =?utf-8?B?bzVLdFoyZnZaNSt0d3ZrWWNTcUE0TmVGMXc5cmpGMUJoaXUyZjBMWHQ2cHM4?=
 =?utf-8?B?MVZPVXNTY2xZdXNxRjlUMWR5OWRsYXpIQlMrYlNzemdUT1orbmhPMjh0Sk96?=
 =?utf-8?B?SEVTeGg0SytRTHczY08yRmVGbW5WODdDcDA5RmxGd3UyNTB2RTNTSERTbWdt?=
 =?utf-8?Q?6CGkm5p8R/UhFqrAz/u5QrDK0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE45OVNSRlNuYWZ1cThFY2tuTHBTL014RXRjNUlSZ3pHcDloTlUweFpZRkw5?=
 =?utf-8?B?d3RHQnJzWHk3cDdkNzc3V3ova3RXN3lOM1RvbkphN3E5TnNPRXJYRU11SDRN?=
 =?utf-8?B?ZGp4QjJWZURCTjBUWjFrOVBoK3lDU1dGVlZMbE5nckIwd2ZjbTRHbW04azNZ?=
 =?utf-8?B?SHNoOWFhWEEraEY3RndTcUF0aUErYk94Zi8wbWNSYkZhbEt5TW56MVU1dyt6?=
 =?utf-8?B?emc4dnVnVWxMN3NrSkZPMVd2SU9NOFE2Sm1MYVQwYktoMVFHNm1XQ3FtUWZy?=
 =?utf-8?B?UFM0cTRMb2p5YzlzTVovSW1DK1Ftc2NMNnFwMzZSL3pudlFFbWp2b2ZoWjkx?=
 =?utf-8?B?emxuWVZkWXVoUW9NNGNQVVlkSXR5SVgwakN3bjI0Tnl2OGNsUk9WZEF6akwv?=
 =?utf-8?B?cHViT1hiNkxnLzM4RHVtdHpINjNoWXNRbWVEN1AweVlpcWVwSXltY2ZGaDZS?=
 =?utf-8?B?d2RGZm9hbjIvZTR3UXN2ditpaWxmaHAvUnJxTTEzSDFZOC9hTUJSMmtBdjRZ?=
 =?utf-8?B?WE1ydHowRkM5RzdwUFRRWnorbVgwaXBRL1c5WjRteG5LT1RUUjRTbFVkZU90?=
 =?utf-8?B?d3FoRk4zQnIreTB2V1ZReWxCZ0J0VFFsbnU5SVh5VmhpQzh6R04xcWxlbUlk?=
 =?utf-8?B?TVczTEw2eDBCWlZESG5NcnMzVWdsU0JjZmNISWtKVFdoZXdITzVLWllJNk85?=
 =?utf-8?B?QTM4Zllob1dBMHhPY21uMVd0dFlRSTkrZ0FvYmExVGh0V3lwQ1lMUlY5enQ3?=
 =?utf-8?B?TzFyalNzekZHMmE0MnltcHVMeG1meFppeG03Rms0Tkx0RGc5a3JsZjBHNVNZ?=
 =?utf-8?B?Q0V2QUZvZ1JCTjU0ZjhBV21xazdReWdMUFlidGlFaS9BMUlDQXBmZW9lY2hS?=
 =?utf-8?B?YkV3TG9zMnc4REVJZmJSR1Y4ejJ0K0VwdVVKbElRUXNyV0pOTGk5OUlmM2E0?=
 =?utf-8?B?U05nc0lhTWpGRDNacFRkeE40QXB2cjVmWmVTV3lhOHQ0WkYrL0ZOWDk2VnZt?=
 =?utf-8?B?YWJjQ21LTUNYM3IzejMrKzE3VUVEcHhrWXVtTy9BRWg0OEpoVVo5c1Rja3l4?=
 =?utf-8?B?TGg1YVBTL0lTWXhxWndhOGpIYlJUNXMvS3FvMllDVnRrcG9UQTJiREI5T0Jt?=
 =?utf-8?B?cUdpZXNNUndzZVpLMEdlWHdNQ1I0aGFyOXFCbkZsZGpnMTZyOUJKV1RPbUtP?=
 =?utf-8?B?VmpCc25kdG9PcE9nTEtLNmZuRVdqR3pOd2dsa2wyaEpBcTZzVWNINHhGQTVl?=
 =?utf-8?B?YVBiVlFhb1lLaUh2S3IxdEhvUXRIc0h5c2RWNnFNaGQ4Ynk3TXk5S2M0bXF5?=
 =?utf-8?B?d3I5cDZtRkFQeXh3KzRSY1BsRnVjS0hWUVlBY0s5RkZETzl5TUs0OG5OL29P?=
 =?utf-8?B?cUk2TGY1aVdhUEhmcURVa1hFZCtkT2o1N1hhbGgwSW94MU5pTy9xODZsKyt3?=
 =?utf-8?B?OGpDdWs5UGJzeG1TeVE2MnpGb3N4S09pRzVTVnJZYjJBa0NzOHpiRkdJakMw?=
 =?utf-8?B?WjNxb2laa2h5QTh3cnRBZUFicWo1SmdJVEtmQituNlJFUjg5MWVZNzZZdldQ?=
 =?utf-8?B?eExMdW9xNDVnVDFMbnFUM3V2ZlJxWHJUZk8vZmFsK2pZY3UxMXViOVBiK003?=
 =?utf-8?B?T2p3VEhGS0t3eTRpWWZMQXFGUE10eWlxeFB6OEgvdmdOY2NIdHJsYXFLMUw4?=
 =?utf-8?B?YlpiU3VZSFYwZHM2Y3FWUmF4UElFT01aUmFKQXZTamZPVEZrVmFUNTVad0NB?=
 =?utf-8?Q?r9PMR5Up5MA9yoCl1QWxx2HkkAPzEke2kfbsdmz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de6575b-664b-4766-8426-08dd54624815
X-MS-Exchange-CrossTenant-AuthSource: DB6P195MB0389.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 23:32:05.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2684

hello


What about, instead of assigning 2^32 space, assign , just whats needed? 
Say 3M , for a process


Thanks

André Coelho

-- 
André Albergaria Coelho
andrealbergaria@gmail.com


