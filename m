Return-Path: <linux-kernel+bounces-431583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837439E3F26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D44169755
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016320C462;
	Wed,  4 Dec 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M8h450oy"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022096.outbound.protection.outlook.com [52.101.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808920C032
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328027; cv=fail; b=eatxvUO8FSkItYoDsXetDww4ahym/dw3P9+IDnOwJ6PQ7QIRMZa2TLy1ZJ0+kGLOU/ht7Xdqt0GrT9VfxnBRKuubc+ZDmJ64uJ6CV9Z5qG3jSQrrUkg8guHhb/2qGDO/6TSQXG98sSZTKHfXpcOkRkoqx0x92a+rJijrVysaz6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328027; c=relaxed/simple;
	bh=0IQZl6PepbWBRhLl/J1JtrIUmS3xFRSvEDlFAyPudqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifiC/ejQxWwrtN3QvefcB77miboBP2C5vZK2EyX9Z+hM6bpodg2irELz9LVucaGislgco4dWw6mwMXUVFid8bWlHCQWx9XB/KR6dHFeWS8rDq6v3/qtaTi5LZBtPfVU65sO5/4xo7RZb4pQApPjpdTFvF6kmoj4Nt/69CjwTxp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M8h450oy; arc=fail smtp.client-ip=52.101.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3+cd+dxX0u/nDgVZOySoRRwmUaaljS+Zn3ur8haDf6DnHTMCeu6MtilNCIkSpJ4DpYTDhLZsbyb8Dr4gOwdNUy2LDwjsYJy+9HibSpP6vZlmbBmeED1R5FyCsaO0a6lyax1wmOGIO9A7u1Yuno4B4KZ3bMlgNou7Urlun9c/6Xh06fkJcKuhGQYOOFTqps+RhUiOu6Am9zCQ8F4v8nptGDqzFTpA+SWDGESJdAOZFpQ71OIoPKDfGNREqopZwKLgCnplEVFk34yRK4MlujzygskaawnCsggk8ewyxlaVnp+p66cRw38OthxfVFOtFzOfM+vMnCgiqzOXHVd83yBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dekx4KL+QoChivisrLJX7qW9l76kKESFHiTeOu9u7A=;
 b=kbhvG5TK77cf++WPHfy/JmwviNAsWzUKB3hYV5li71KLdi2wkcvJZ0ZvifrC5ZB5iGrggmNJjndsJBIeu68cahYa24pmFWdGS276Fk8fp2tDWYhQAsjp/bAuxDhFSMro4pUqYkt5ONFjcWoPbDD3dkichmnm5JxWCs26BuDUNeCaD0tlYq0B+2sXvM/ItZ0WiZhEy1d4kyk1kF4cVudOtL3ZaB+UinCUWBGqMas6idSqasodmFbbs8hFsfugKQFEafdePu4L2dsT3W71k7yrA6LSWLcjIQgHsgMlbZhJAhPDph4UQarb7eOhXoojuWx0zhfWv1WXqfe4CQhHPPO26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dekx4KL+QoChivisrLJX7qW9l76kKESFHiTeOu9u7A=;
 b=M8h450oypiLaa5j4Zhohv6QD7xbxoEAi0mg+syBOG/wCHPndXgsEuoWtfjHBdxeSzk5xPB716jmXO9vqCFV6ROIzOtlijhK677xI2y9xyLaXbyhyvMEfwMbdfLVdt3+/FyruikVeX5oTD+O5nTPhRLrdY9E48kZmUYfMnDZKsHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7383.prod.exchangelabs.com (2603:10b6:510:104::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Wed, 4 Dec 2024 16:00:21 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 16:00:21 +0000
Message-ID: <5f99ff7d-67dc-41da-8a90-a1a5e76b8daa@os.amperecomputing.com>
Date: Wed, 4 Dec 2024 08:00:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
 <6aec1d44-4a89-4acf-a16b-4493626b93bb@os.amperecomputing.com>
 <Z1B1VS8PayXsXDzl@arm.com> <4919faec-3e35-459f-a7d3-b5b3f188bd9c@redhat.com>
 <Z1B6OMqEZitgBVEx@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z1B6OMqEZitgBVEx@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: a320eb12-78b8-4dcb-096a-08dd147cc0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENqa1VsVncwK1NFcGFkU0Q4ZjREOFFhL1k0dlA1TFU3Q0xaSmZtK240d3Nv?=
 =?utf-8?B?djlydnpJckJNUlRUeHY1WmVhdlFJUStxZzZaaUJ6ZjhXYUlTQUpkdGFvTWNQ?=
 =?utf-8?B?MGJhc1pRVDA2ZXdMazg4c0licldxSWVVVlZwdEVCRDZNY1VBK1pjY1ZrOEJI?=
 =?utf-8?B?dTBKZG8yMFZuMktOQ2xrNHdaQ2FHQkx6THN6YUtvbGpUbTZYUytqRU42QXN2?=
 =?utf-8?B?QWxmL1EwWncvUE9tWnQ2STFRekl2UHpnRit2SWhpWjRhdS9Ib3ZOMml3S3lI?=
 =?utf-8?B?cGJOWGd4OWxsZWFKMmMwYzdDUXFhcmY0Z1ZJNU0xQ2dXaDBiMEpwa01DWG5x?=
 =?utf-8?B?dG1rNisxS0ZmYUtIblF4MTNxeDBSTk5NaUxXYVgxVU44N2swTWlSMytVWk80?=
 =?utf-8?B?allnWFNyb3hDVEtrV01Sb01SQlFnRlNJaEo2ais4bENSdjdYZkNqQlUzY1lF?=
 =?utf-8?B?cVkvU1lkNVM1YWJqcDhNZFAxY05TNEdRZ3c5VHdUcTlDREt1U0YrMVk3Nll2?=
 =?utf-8?B?VEpXSmFJdHdSQ1hra0JGdmo1T2d4Rm5TMlgwNVUySDROb0Z4WWhJRWg2QVNu?=
 =?utf-8?B?aU9TY1lGYVIrNmxqLzFRMXM2dCtYOXVqbzNnZkZVSmE4NW9IQU1hM2hOaE1S?=
 =?utf-8?B?RFVCWjlEN3I4WXI1RHRsUVZrS0F5aitZSnQvZ2szaVFyNlNncEJsYlMxR21q?=
 =?utf-8?B?OGRTcGhxMi9iUUxteDVKZDhzSDUxTGZuSlEwa0xvaEw3TnBvUEVFV3lQejNu?=
 =?utf-8?B?MHNMTlQvUktsVXlQK0FjbU1mMkoxbDl0K25CRWxYc1dzY0lFV0JnVVE2dStM?=
 =?utf-8?B?UkNMNHhQWHdVODlBZktRUm1aWjArb0xad2gyc2o1WjVwTXZpMnRBdXhPcXVp?=
 =?utf-8?B?ZFZDTG9IblhGUHk3cmVFanR3ampET1JwakZnRDExU0YwcnJlNnJhdFlIM1Ur?=
 =?utf-8?B?UWhNRHFacEt1OHdlM0Vza2ZETEtpRXRYamxUNnE2YWZmSTcwd1YrbnhnMEFW?=
 =?utf-8?B?RlVLalprYXp1NnN6Tit4bk1XU09UZGxsc3AwWGNSQkZVaExNK2ZVU0JhMHdw?=
 =?utf-8?B?VmtaU2NoUm5sVzVJdURxeEMwRnNZb3JDNi9ZZzRDYVdHR2lYWmtHVFRDOUZF?=
 =?utf-8?B?RWtnNzUvZnIwL1kyNGJqRFlIODlWUGFBcjl0dWNJaHBKNFQ4cVJGWnZ5Rjdq?=
 =?utf-8?B?OENiWjBPSjFvNU4xaGRvbVNyaE9pTnFZWGU5UHpDaSs4UzVpK2VoNit2Nnd1?=
 =?utf-8?B?LzVhaWFqdjFKSkt5RTR4T1ZQdGdwZEw5OFhKMGxYY2tlMjBIR0NienBHbjhS?=
 =?utf-8?B?b211a0h5SXJjWkhjVVNXbXRxdS9SbGw2YWF1QXdoQWtkclg2VW80WmZ5TkhX?=
 =?utf-8?B?ZTVjQkhvUXhRc0VGeUhGcjZ3bnZ4MTdFQTkyN2JDVUk1alR5Z2IxTHk0blhM?=
 =?utf-8?B?S2xPNzBRZDdOeFBERG41bEppMXhuNkxHZ0EvZlg3MkNCZE53cFhIditDK2hP?=
 =?utf-8?B?QTRFTUE3K0tUZ1BRajBkRGVlVkFVR1VsekF1VVo5elJ3TWhQd282d3lSZGxN?=
 =?utf-8?B?bE1oVmFsYWI5YzYzM2VISXZjRnVTUUYzbWdMTlBwaVBVZlRqNTNUQ3AxRk5R?=
 =?utf-8?B?VHh0YnpPZmJlUUZEM2NrQUdJd0puSldUelpaQ01OL1lzTExBYXNaMVM0Q0l5?=
 =?utf-8?B?V0QyaXlwMHdrcVZSRHZZeEozS08zTDN1RmZBRXUrOVZ1SVFWZ3NHMjJ0L3dW?=
 =?utf-8?B?U214ZXZjYVBWMmdWSWQ2M1Y0NWhzQXhteTQ3SmQwUmdYZTZMcGtOUFFZZjVj?=
 =?utf-8?B?bGZWU1NoTG1BRlFTOEMzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjJoS0NDdWRLWWJmREhUUWNZUGJZbGxnbksyK21OUnVxOXovNGZkbkNPWUY1?=
 =?utf-8?B?aTkrQXlrOEN2Y1dPNkdsZisrdE1lSDRjK3FUT0lramdOVVdtQlI5SlJLUmRF?=
 =?utf-8?B?QzliYXJxc1QrS1ZZV3YzWWEwaS9YRElrcFRzZXBwQzNoVSs5Sm5jWjdXNjJ3?=
 =?utf-8?B?bWs2dFBtdXhCV1gzall6dVdlOUd1NmV3TEs0QzZPZ2JRQi9ad0dxWTZKcnlY?=
 =?utf-8?B?QmtrNlpKUUhtYWVjWVN4SkFhOFpnMERGZ1FmUkF1dktaVDl2UTNBMkxId2xW?=
 =?utf-8?B?UUFqci9hOEF5NnNIeHJLdEZSZUduSlc1MCtQUEF5UFJoYloxbUJkQitGdEYz?=
 =?utf-8?B?c2l1ZkwvWE12bzhaVlZDSXMzOFhBZ2RKa0xnb3JQODREcXc2RitEMEk2WWhI?=
 =?utf-8?B?UmtIVzRENldqcEVpZVVMUm5VTHZCcDR4QldpdE1XWXJNTHZNSVJaV21TMDll?=
 =?utf-8?B?K1BORENUajBaYkpnUHhGM2JveHBJQVQ0OUp0eS9Ba1NzQ3Qwc01nQXdxN3Ru?=
 =?utf-8?B?ZTFkUk9lemUrU0FyMm4wb1VpZTdjbEFxaSswSTVLOVNqNkFuakU5MTdkZVdW?=
 =?utf-8?B?TmVvK1o1eVMrdGxZLzdXSGdwSzZza050THBYLzl2VThhaVlRUkpCQlpnOGtw?=
 =?utf-8?B?SUNRZE9xZUg1QVpndTRTQytKSGREOEpJbnlQV2FCb0Zia081UDFNZzJVZ2dj?=
 =?utf-8?B?OTI0YkQ5bDF0V3ZjN3ZZRTFzWkVpOWpadGFFa2Y2THV0OEU2TE9PRXBtVmY3?=
 =?utf-8?B?K0xacEJGaFRTakQ3M3IvMWp5VFBqMW9tOEsrVnNjODNSZDFSckRaUzcxaC9S?=
 =?utf-8?B?VjF5OFBjbkhmMGtKOWg4UUJONjJULzhMeUlGL2pWemovNmxkenJRNElFRG1v?=
 =?utf-8?B?OW8wWjh6MjdvQ1BUZXhENG12RzZ3UUlSa1NrWlFzTFc1WTdocHRDNE94SzhP?=
 =?utf-8?B?UjRmbGp0VGpNWnhLQTJ1MGhRcDFZYVhwd1BYSHRRbS9EREFtcTRoRHQyMFY1?=
 =?utf-8?B?amtjMDB5Um14RUg4UDFzakNzdlp6c1oxNEErWUFPeHVQNlY5MjRXc1dYQmw2?=
 =?utf-8?B?eTdlVm9WcTcvUERiQ0ZPcGRHZFFVWDVyc1N3WC93Y1JJNWlMWnpjZGxMcjMx?=
 =?utf-8?B?Z0dKSlpFSGt2d3VQU084QzZFY1cxOUV5UmxSSEdraW5ORkQ2UDRKV2kyWW1G?=
 =?utf-8?B?czA0bFNTUHc3YjhrSG4wVDNMMVMvUzcrcC9NbmlVdmFmTE1yS0dtN3dqRHY2?=
 =?utf-8?B?VXJQU0paMGE2dDMyOVJGM1d0QlNoY0JVbzNnVTVlVHczNTVRSVJWV2Fwc2sr?=
 =?utf-8?B?SFNQZ1JpdU43ajZha3JMSW5mVkN4WkVoSkdoZ1ZaOWtrem1Ka1BCTHJEaUFh?=
 =?utf-8?B?eVg0V1M5UjU1WWpFeThCZndqdHNUVXZjemdTNUZFbzdrdGJpQU5vTU54T2ov?=
 =?utf-8?B?QWdNQ211MkR6UjJaY1lhQS9VdFZXSERldVBRNUhIaVh1Tit3TTNublZYSHlj?=
 =?utf-8?B?TUtCSGtoYnRpRlFTbE9FallHVnV5TEJHcWx6bWRJeUlVZEprZ0J6UVFCSXlD?=
 =?utf-8?B?ZFErTS9GOHBIbkhwREg3VGNtTjhpV2pwQlozSlhHYTNTSjNXNVN1RWtSOVlQ?=
 =?utf-8?B?TmQ0dzR1b1JNV1BaWXhqWmZ2bGdYWHdOeTgrdmdoRHdiYy84TW4za1VLOTVM?=
 =?utf-8?B?bEFLdFNJMHVSQ0E4SkZsM2lCMEs1Y2o3SlJvMHllOHJLaDh0cVhOamVrQnFk?=
 =?utf-8?B?UURhbEYrYWtURVBxckdZVVprVStsUUo5Yks2NHErUFNsbUhQdnJ0Q0ZURmZi?=
 =?utf-8?B?VDFZKzBNNUdFNU5nOUJmNmhlU3FsVUhrU1FweXhsZUxxc2dCeGkvQTBwdDV6?=
 =?utf-8?B?cjAwV0haSy9BMmpCeFNyaUk0SUh6TnRhQlRtdWhCenkyN3ZVWW0vVmxEVjhl?=
 =?utf-8?B?UjBxVlEyQ0hTc3k0bVhEOTk4YmNJR1AxZVNZcmtkcHU5RXhocXFlYk5sSmxH?=
 =?utf-8?B?czN2U3NkZHoweTlDVXEzUXRrYWxMQkFnTWZZNC80S2gvUDJVbXdLa0VZNlNs?=
 =?utf-8?B?SjN2NStDM2Rud09lU0FtVE1LVWcxR2JaQlhWR015b2tHSE5xUDN5R1h1VDdw?=
 =?utf-8?B?THIyMDBtM1MySnQxN1hyVDRJRlZWZW1VVWM4V2dXYjlXRVJmVVpLdlcrTGlR?=
 =?utf-8?Q?WE3ocLu4XUBnz/u0OjJTRXI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a320eb12-78b8-4dcb-096a-08dd147cc0b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:00:20.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtucez1Qg4gMElwLapA0YthHM5Eqv8iMSdh/v+a9pWKV1a6AOjSbVPSe2/l5bB7Os9bgnplIZgeEtcvMrbL+bQp2m1394/J4qjGFMhRnE+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7383



On 12/4/24 7:50 AM, Catalin Marinas wrote:
> On Wed, Dec 04, 2024 at 04:32:11PM +0100, David Hildenbrand wrote:
>> On 04.12.24 16:29, Catalin Marinas wrote:
>>> On Mon, Dec 02, 2024 at 08:22:57AM -0800, Yang Shi wrote:
>>>> On 11/28/24 1:56 AM, David Hildenbrand wrote:
>>>>> On 28.11.24 02:21, Yang Shi wrote:
>>>>>>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>>>>>>> index 87b3f1a25535..ef303a2262c5 100644
>>>>>>>> --- a/arch/arm64/mm/copypage.c
>>>>>>>> +++ b/arch/arm64/mm/copypage.c
>>>>>>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct
>>>>>>>> page *from)
>>>>>>>>           if (!system_supports_mte())
>>>>>>>>               return;
>>>>>>>> -    if (folio_test_hugetlb(src) &&
>>>>>>>> -        folio_test_hugetlb_mte_tagged(src)) {
>>>>>>>> -        if (!folio_try_hugetlb_mte_tagging(dst))
>>>>>>>> +    if (folio_test_hugetlb(src)) {
>>>>>>>> +        if (!folio_test_hugetlb_mte_tagged(src) ||
>>>>>>>> +            !folio_try_hugetlb_mte_tagging(dst))
>>>>>>>>                   return;
>>>>>>>>               /*
>>>>>>> I wonder why we had a 'return' here originally rather than a
>>>>>>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>>>>>>> issue with the hunk below? Destination should be a new folio and not
>>>>>>> tagged yet:
>>>>>> Yes, I did see problem. Because we copy tags for all sub pages then set
>>>>>> folio mte tagged when copying the data for the first subpage. The
>>>>>> warning will be triggered when we copy the second subpage.
>>>>> It's rather weird, though. We're instructed to copy a single page, yet
>>>>> copy tags for all pages.
>>>>>
>>>>> This really only makes sense when called from folio_copy(), where we are
>>>>> guaranteed to copy all pages.
>>>>>
>>>>> I'm starting to wonder if we should be able to hook into / overload
>>>>> folio_copy() instead, to just handle the complete hugetlb copy ourselves
>>>>> in one shot, and assume that copy_highpage() will never be called for
>>>>> hugetlb pages (WARN and don't copy tags).
>>>> Actually folio_copy() is just called by migration. Copy huge page in CoW is
>>>> more complicated and uses copy_user_highpage()->copy_highpage() instead of
>>>> folio_copy(). It may start the page copy from any subpage. For example, if
>>>> the CoW is triggered by accessing to the address in the middle of 2M. Kernel
>>>> may copy the second half first then the first half to guarantee the accessed
>>>> data in cache.
>>> Still trying to understand the possible call paths here. If we get a
>>> write fault on a large folio, does the core code allocate a folio of the
>>> same size for CoW or it starts with smaller ones? wp_page_copy()
>>> allocates order 0 AFAICT, though if it was a pmd fault, it takes a
>>> different path in handle_mm_fault(). But we also have huge pages using
>>> contiguous ptes.
>>>
>>> Unless the source and destinations folios are exactly the same size, it
>>> will break many assumptions in the code above. Going the other way
>>> around is also wrong, dst larger than src, we are not initialising the
>>> whole dst folio.
>>>
>>> Maybe going back to per-page PG_mte_tagged flag rather than per-folio
>>> would keep things simple, less risk of wrong assumptions.
>> I think the magic bit here is that for hugetlb, we only get hugetlb folios
>> of the same size, and no mixtures.

Yes, hugetlb always allocates the same order folio for CoW. And hugetlb 
CoW path is:

handle_mm_fault() ->
   hugetlb_fault() ->
     hugetlb_wp()

> Ah, ok, we do check for this and only do the advance copy for hugetlb
> folios. I'd add a check for folio size just in case, something like
> below (I'll add some description and post it properly):
>
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..c3a83db46ec6 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,11 +30,14 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>   
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {
> +		if (!folio_test_hugetlb_mte_tagged(src) ||
> +		    from != folio_page(src, 0) ||
> +		    WARN_ON_ONCE(folio_nr_pages(src) != folio_nr_pages(dst)))

The check is ok, but TBH I don't see too much benefit. The same order is 
guaranteed by hugetlb fault handler. And I don't think we will support 
mixed order for hugetlb in foreseeable future.

>   			return;
>   
> +		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
> +
>   		/*
>   		 * Populate tags for all subpages.
>   		 *
>


