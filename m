Return-Path: <linux-kernel+bounces-303128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10B9607CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B7A1C2216D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1D19F461;
	Tue, 27 Aug 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RTSy+TdR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44E19EEC2;
	Tue, 27 Aug 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755591; cv=fail; b=YzB0AGUaJFfIrD/WzK8ktU/BiS+0Hrtpz3Ekr+sFYxuZhN9eSp1O22/wmJM9xkDCoQlpvexLDhtuN90ySJUdP6zohr3dRFx6BF6zdD4hfOAWYoly45YQYtz+Kq/7+ha/xCRgv3uyiB3H+t2V81JfIA5uDR3p+BBBAmg7qVGL6Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755591; c=relaxed/simple;
	bh=b6YrtPlif75SWCnd2zOLb2smf/Xtx8waNl9ZyADskGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vB3OeNHAmmW0hEkkVhiMLD6uRznaScE9bwP2LqC5Cnsx/Ox+VnkGh7OWN2e0cevL7XoLnKuc4cUiWScfGnVpWPQvGyEQ9eg8P4pKRu2Ul/AiYstUfYkRyl1mXorMZEPbopRAWioCKkHoIEN8DeLca9EjjeNNz46jn4YYvhQ+ILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RTSy+TdR; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACzQZb6JEKZMeRkogH6z6L2S+jISe8IU6nyDVUfVUIInizcuduKoIuxO7GSDt3K6ERG+vdEJrF+dqlYy2m7xW9R7czIeuj1sHDjL3hUs6m2zXrTjD6BKBZXcFC/ONQb+6O0a2uwDDI8jrYJWNi2an0nOQvNrDysU3VClNmeXtuM6eZN866N5KwPaVVPX28X3k+/iyydbqj2KGcO/nzWd7XF0Ap4McZlDmJAz9u9vDnUkjETKK8lfGzeTmylVyrGIZqBxWiYvFMMFKDR9xuVpl/e4YK56j1rsPVGznFzfgaS16SF7NTE16uwXxrxzntC8lJkipEZJxf9XpYE8ztFuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Q7UwgBzXB3H60qlZZ0nduKM2G+Oq8Rjnk68kqTydM=;
 b=m/t2JpWGf4oh9p3bk6F5XN9UhIw50HHyPBIxtigR3I82gJ+GTmsfU0z/0N26BI/by9fj/0F7s+PC3kWOr9tsFtDneIPWw8xYOK5uiLGNePQowAnWJUYlImCi4kH2MI/NhC4XZV0YL2lsXDHWxV02GaEqDbqwY0/yiviOMaUzuwHIPChHuvkFV9yXvo8XwsZAoc6YZN+r7HO72JxLW18FI15EPu8lqrkEWuE83ROYtBxXSlvwvMt2/8Hjmun4ZVIhIzQzbxfDabKBBrx14/oIcsn0EPnMxTbMyH2Pd9AQUWMmGg6F3mh0X9kvloB13nIJvJkCAHMvK2/amkdspAIq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Q7UwgBzXB3H60qlZZ0nduKM2G+Oq8Rjnk68kqTydM=;
 b=RTSy+TdRUt8GQfg8R0cRZPeBppdkPEIWQs9jbaW71AYxfpG2/k86mM/CEBr4b7mYhzUWo8O1jGl9QYCcCHxm2dLrGOHBr2vBV2UlLSpUThp3kYOMWABVC/MVeLEapeH+QIfehQ9Fd5+96b83veSLbX8lOQoPI4MaapEMcS5UHz+Hwu7wzff5VdQ1MEb/b2eiGMSWVSDuygyaojewYAGteB4N/zlWW64oo5EQGOzLDrfw1sbimAVbE3MKmvw0y5wPp2a7CMsg6+AZIpJgV+OeTp7XBHAk7gvT4OT9RsXCEscSvA+8L+lDmUWsbG83FOrW8sS/LzaYUv/vVYUPd0J4cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 10:46:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:46:26 +0000
Message-ID: <da47dd71-18fe-4474-adec-d4f1571c02f2@siemens.com>
Date: Tue, 27 Aug 2024 12:46:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
 <6c28d580-9961-4bac-adcd-1724de68c9fb@siemens.com>
 <0ca0fc20-421e-4bbc-bcda-9e5c2ea3b1b4@kernel.org>
 <2bb6b337-d83b-4cbe-aff2-bbd0c7d17c2b@siemens.com>
 <ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: a59be197-0ea9-49fe-b036-08dcc6857fec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFJjU3JBUnBvN0ZiRUZmc3VtSGdVeTBZK2JyUVpkVHA5RW1GUHVHWGVLc3hr?=
 =?utf-8?B?UGh1L2YwWDZSYjBPYmtpZkE2Z0FMUWt3NDZIYURiOEd2MmRVN3BQUXJtMlVP?=
 =?utf-8?B?ak5qbk1iR0NuRHZQRW4zRmkrMW4yK3pLdlNpRm55WlR2a29zRFBrb1c4VzJR?=
 =?utf-8?B?T2N1bDdPa1J3TFN5Vmg1Um5GY1F0QzVQbXcxYzVnR3JBeVEyYkZaa0N1TzFr?=
 =?utf-8?B?SFFPbkgrMmNxUGRQWkxxZWpYTVQ4ZFhHU3JSOUlpK1hZTFJKQzQxTStIdXBi?=
 =?utf-8?B?VXd4YXQ3ZVhZNm9nU2E1RnJGNU5PZFphUW04cmJIZyt4aU50endKTFlLaXR6?=
 =?utf-8?B?di9TNm84TnFxckpzWkNvNHFNNDNQNTR4S1pwQk5vZnlaNXVudmVSQ2dCa00x?=
 =?utf-8?B?QjhRUy85L2l1YUNBei9aWTYrSk1NZWpRcjFEQjR6T3Z5eHNNTDkrU0hxTHFK?=
 =?utf-8?B?OWJrM1I1WjBZR3UyTWo1RWF6NHNXU2ltTXgzaDdOZ3Q1ZEJYcWY4NDBIbGRu?=
 =?utf-8?B?UU9NWjc4dEVuZGFrR1lzL2M1OE9uVXppWExxdmdDWUhhZjZMOVB0NXEwYWdT?=
 =?utf-8?B?YTBIRFdqVlJOaG1nNjFMdnhpZ0NMN0VySU9lVHhZMjBwN0dzdFpoaEI2c29B?=
 =?utf-8?B?bEI3WkV0TDFUalUzZ05TamFaUHFrSzcwZFRZd0tvU0l2RXluenpBQUZkTzk4?=
 =?utf-8?B?VlhPZUNMTnYrZnZOMFFSdGFBajBMaXBXVTR6dkFZOW9hUXFDdW04NGhhWUpy?=
 =?utf-8?B?UXd2NXRhSzlIM2JRRmJFbUU5MVo0aHJERmxrekJEeEE0WXcyWWtkWVV4WU9k?=
 =?utf-8?B?VGwxY2ozTE5Vemo1VHB4L3d0cjUwdXRydUVDVHZXOXlkOWxlVFRxR3MvZkEz?=
 =?utf-8?B?UGRWUjQ4U1ZBbmlVZHlOY1JNbEUxMVdoc0xsQkpueVY5ay9sWE1LRTgrUjhE?=
 =?utf-8?B?eHovWXJ2cG1rMDc3UUxtcklPR3VXT3MwLzlIcWRWSkFSTXJyTXEzKy9TQ21S?=
 =?utf-8?B?V29pNE0xVm1jTk9TaDhOeHRsUWhqTFFXeGI2cThsTWhaRkRTRkIwa2JRbVQ4?=
 =?utf-8?B?VGNKQSt6SEh4SWpBdEc2OWE1NkExU2hkVzNwRWtJMjZsVEFnZ0tKaW1FREFJ?=
 =?utf-8?B?SHlIRGxZVXp3ZUFHWExmUmd0blNQMWpNVW03V0V4TW1TcFNzQmpGeXZJUjFj?=
 =?utf-8?B?cStjdTVNa1N4bDk2em5qOVNBQUYxVkNrQi8xOUFKTlVrRFZzTE52MnAza1Rw?=
 =?utf-8?B?bU9yWFNrY3dMc2EwZ2dzaEdrZWpNV2l3bmFBSlBVMkN0b2J3RHVxYUh2ZDJH?=
 =?utf-8?B?OTZvQURXWHZHcExMV2pVMklGak05a010SWdlMG9yQmcyY0FvUFozZVAyZlps?=
 =?utf-8?B?b1J0R21GdmJ1aENEeE1ZUXpMeGRsVWZMWFFpdmIreUJOR05CbG04Z3p3MFdT?=
 =?utf-8?B?S1gwL0V5UDdtcHpNWmpLVk5Uc2Rzd2tyby8ra2RvNnVOeGliQUxUQndMcW5w?=
 =?utf-8?B?Q0ZXM3cyZ1VYQW9HeDh5TkdIaDArZEFDOEtBSUk1VXB0elBlS1lSRlB5aDZp?=
 =?utf-8?B?MkdtcnBSNHNjOFU1QmJmelVnbm93eVdkblNUMG0yeEpUNWtsMjNBWnoyTGFQ?=
 =?utf-8?B?K2RMTVFDVWxkWnF6RXBGMU1ZOTFUcURxZDdoYXZyR2pab3hNOC9WNkVCTlln?=
 =?utf-8?B?ZUdsZnd0RW04dW80NmhrVXNZUGthcWtCdkw5ejJVa3dUK2hBMFdCVzVxZEFS?=
 =?utf-8?B?RHgxOVZ2bHZtemdsN01ZZkxENzVoMFV6bVBVa1E5cWU1dWhrcDZKR25nM3BY?=
 =?utf-8?B?M1d0cG0vcGNCeDJ0T2JKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJIZU50SnFBVzBFT2NJWWY1U2JKZFNDaWk3YkVpNXVySXRwdms5a3M5L2Nk?=
 =?utf-8?B?U2xiVyt6QWNNQmJRd24yWU42Q25YUk8zMHd2Y25SZnJMU3BzYVRWVmlSKzFO?=
 =?utf-8?B?dG9zQllvWW96NktUMEJYQXVRbjROY08vczNGVWxiNW9HSWtUaWw4TEFwb0dU?=
 =?utf-8?B?WkNBblVLdFVwazhuSWk1OGdqNUVpZUM4eDc4cUh2Z3BwQWNlUXp5VHpDMDBx?=
 =?utf-8?B?TEp3RkNFb3dyS0JYSmM5QmoxbDlNOTFpbTVhRjZSbTl6U0NFektkdldnNk41?=
 =?utf-8?B?QXF2U2tUaXE5Z2plV1U4V3NlaFppTW9ZZ1hCREJiaXBuRFFISEorbFhSVEhv?=
 =?utf-8?B?OXFzNUxtTlM0ejRreXd5VDhxbjI4Mm1FQ3JLSUVPazNPWkEzMTd1T3dEWkdq?=
 =?utf-8?B?bU1oR1YvY0xUeDhxTndweDRJcnBBeDNwUmR0NFZSZnlWc0l2ZGh6ZGkxSEN3?=
 =?utf-8?B?bmhlYk1hczRKQjdtOXJlZEg5OEJKcS9PZEloQzVqcnN0aVROMlQ1WFI0eWs1?=
 =?utf-8?B?bzNNazkzTkJ2c2NIY2NiRVRsRy9HU05neW9OOWVmVFQ1YjA5dVc1MWxRdEkr?=
 =?utf-8?B?S0o3dmlsWS9GUklHL1ZBWDViZE1JOVRMK3g4Sms0a3V2UUxtOWpqSFdEQzJ5?=
 =?utf-8?B?ODF3aGJHdENTaG1nbFVBVUZ4blBHekZWdWJ0b0l0MktraW5wR3RUNGFJR09m?=
 =?utf-8?B?K2YvTnlZQ05oRzlmUTFnbktIUStGRm5KS01aODVPTlRJS21xdTJoUDV5SFRU?=
 =?utf-8?B?MUZiLy8vNmlXQkgxYWZCaUxRTFNLWFNnRWJNdjBLazhpVEdwQnNGbnVXVmFm?=
 =?utf-8?B?SlhyOVdZRzhNNnVsakdwTGxaS01xKzZqSElON0sxb1ZJbklkT2hYSEpSMi9r?=
 =?utf-8?B?SjJpRUlQbkRka0lRZzJONEYyS3FxUFFhMm5SL3dQTE8rQnAxdUd4NlhpWGpG?=
 =?utf-8?B?cUhLZFhDbi84UVFwcnR3WktteFM4TTMxdEcyc1EzTGJaVmdmWUxBMlVQY2RC?=
 =?utf-8?B?ck84a0t5d2tGREhQUU1INXhpR1JlZEhhSFk5Um1HTHJKZFU5RXZ1U2Yrb3VX?=
 =?utf-8?B?MFBqc3paWVdnNEFHaEpuYUpraEVuNVFMeDVMSFJyMUlGVkNCS2RPM0JobGRZ?=
 =?utf-8?B?Q3h1WnFuNXBreisvczYwOVZjRGkzNi9QKzZZSDEyVmZLUVJpK3crdmE2ZUZU?=
 =?utf-8?B?RXNpYlFDM0hJeGVkL3lIREMzUHQ1UGVXMnNPdkFnVlU5TEovQlVjS0RybDNw?=
 =?utf-8?B?YWE3UXd4WjJ6TDZJUUkwNnp5YmVCVHg3L0FvWGVKRUVEc2JyOGlSZDJuYTdK?=
 =?utf-8?B?NEliMWNrOU43bXRLVUZmNzkrdktYeFQycnprSnJIM1djbi9jS0VZK0RlMmly?=
 =?utf-8?B?RVI3SHUrTDhlc1N3L3d6UERETzdLbVFOMms5SmdNOTZYM0dUU2Rob0xPTHRu?=
 =?utf-8?B?M29Rb2hySFhodFczdmZRTVdOWERJSmc1bEx2RTN4elpaaVMxcmZuaEpYRHZ1?=
 =?utf-8?B?dzExRytoWXNpQ2YyQ3FwMFp1UzA5Tlp0dnJXbXZMcGQ4bzFtU3I2b3JIMitM?=
 =?utf-8?B?MWlKVE9ia2F5eE9CeFJsUU4xOFptNzRZZStpQVM4VVRPT1hDNDh0c0lQRWpj?=
 =?utf-8?B?QzNPdDFFVHV4VGxyVWNsVGhGdFZLSFp6TnovTlppSnZ6Z2Q4RjM1RUsyMU5T?=
 =?utf-8?B?QThkNlltc2U4ajdIa0V1SXRweitrTkUzeVpqUVRjV1VrS09DekFZOFVaamYx?=
 =?utf-8?B?ckxKZGVHTXQ3RlhaMGh0OHRVL1BEaXlFS3owZzV5U2djeHBuRDgvWGdEdXJX?=
 =?utf-8?B?VEpuQW9ZbURsRUhrRmFZdHFFa2NoWkJyRUdMQ205M0xldDhYbUVVVFJuWWlp?=
 =?utf-8?B?MVZaQ2k4dUt3MnN2WklPbUQxZE9CMWNYOHdGQWZJdlkra2ZCWFQ5QmR1ZEFF?=
 =?utf-8?B?SVFJZlo0WWF5cDVIRHBQLzdmTTBPWUtDUVduVmUrQ1pHTVlNZlhTQ1lJR0FZ?=
 =?utf-8?B?OHE1bEtLalo1YzQyN3hRbS9KK3VpYTc3d2lBYmMrYktXUE5jVGxIcmtETWV4?=
 =?utf-8?B?TEVjSVBsaGM2aTdYNGVrb1gzL2g5dmZsZlZGcktGem9yTXg1WkxaNFVrL0Vp?=
 =?utf-8?B?QlJ3Tzh3U015aG9JTW8zaXJRSC9IUEk1UFdDYU92NmhVV3dIZU1CSmxsb2gr?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59be197-0ea9-49fe-b036-08dcc6857fec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 10:46:25.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6nO6FZkWvSmptDSZ0+2dDrWs/RsNDAe3IgDwnRlmzW5b0H3K88cb/SNupBFpelJD0CUU2YNnctRp1f33mZQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5977

On 27.08.24 12:06, Siddharth Vadapalli wrote:
> On Tue, Aug 27, 2024 at 11:32:02AM +0200, Jan Kiszka wrote:
>> On 27.08.24 11:29, Krzysztof Kozlowski wrote:
>>> On 27/08/2024 11:22, Jan Kiszka wrote:
>>>> On 27.08.24 08:37, Krzysztof Kozlowski wrote:
>>>>> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Describe also the VMAP registers which are needed in order to make use
>>>>>> of the PVU with this PCI host. Furthermore, permit to specify a
>>>>>> restricted DMA pool by phandle.
>>>>>
>>>>> That's an ABI break without explanation why it is necessary.
>>>>>
>>>>
>>>> It is needed in order to support the PVU, as written above.
>>>
>>> Above say only that you want a new feature and that's not really
>>> suitable explanation for ABI break, because answer to this is: add new
>>> feature without breaking existing users. But maybe there is a bug or
>>> something does not work or never work or there are no users, don't know.
>>>
>>>>
>>>> Previous versions of this binding likely didn't consider this use case
>>>> and therefore didn't describe all registers associated with the hardware.
>>>>
>>>> BTW, if you see a way to add the required registers without breaking
>>>> more than needed, I'm all ears. At least the kernel driver will continue
>>>> to work with older DTs when you disable PVU support or do not add a DMA
>>>> pool to the DT.
>>>
>>> If there is no ABI break, because driver still handles correctly old
>>> DTB, then mention it in the commit msg.
>>
>> Well, this is strictly spoken not a topic for this commit because this
>> one should have no clue about what drivers do with DTs according to this
>> binding. But I can put a hint and go into details in the driver patch.
> 
> Based on the Techincal Reference Manual for AM654 and the driver
> implementation in patch 5/6, I think that the following might be one way
> of hinting that ABI won't break:
> 
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices to
> specific regions of host memory. Add the optional property "memory-regions"
> to point to such regions of memory when PVU is used. Since the PVU deals
> with system physical addresses, utilizing the PVU with PCIe devices also
> requires setting up the VMAP registers to map the Requester ID of the
> PCIe device to the CBA Virtual ID, which in turn is mapped to the system
> physical address. Hence, describe the VMAP registers which are optionally
> configured whenever PVU is used for PCIe.

Thanks, will reuse this!

Additionally, we should then likely do

  reg:
    minItems: 4
    maxItems: 6

to underline that the old form is still fine. Do I need to do anything
to reg-names then as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


