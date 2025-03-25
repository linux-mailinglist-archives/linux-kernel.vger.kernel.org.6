Return-Path: <linux-kernel+bounces-574664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08492A6E83D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A618968CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257E15E5AE;
	Tue, 25 Mar 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="refjcuem"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC963CB;
	Tue, 25 Mar 2025 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868247; cv=fail; b=axaAYSymU1cgU749HAgCT9tC6j+OyknTnm9xFL+jTCVzvWLXwQJyj1EnmZJS3mpRHH8J9R/UFoQuN10/8vGwW7z5usIaUfxk5z8JBWP5/4ocbEBDRsH0QwnqJgSYGnrJ5tXYvAKtIsX7A287PRY88SpZ02XRX3FvV+RkZcBxz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868247; c=relaxed/simple;
	bh=55cDh/wjThTApO/Ny5UfdGmbQP1rAMVnGthi0dj2d48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5TmwzlcMJ1qGl3Tc/ZPkMS6/iPxUtliyPq7KvZN2GDVOkXuvGJYpmSlFT8BpdGgtbOD97m8pyLJpFJEpAFd50JyXULFZHXgR6fpOJfJyIbQQXUCB5c1BqdazhNskJMU/1iY+lCoTic9RBbOXjtHL7nuTkUkLTwGgAOyvdKrPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=refjcuem; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugtE6YHkeGOL1i++qGch+E2cKCWMFATShsSTmt8v2ULnYc8P38f8yFx3D8M5zr0TG4pVG1PRFaozhY6wG09bmFZogO4mshRMvPyaz7wyOvduboXRqPR0MGCpwnb5261Zs+FYvFEoHVfQuDche8Vd7Va70FxYXT28cZcp2JZR86AvneLfMdNcdXparyqG+YkFw3BsfsMhMKvHPAUfF/NFeKaNEGtfiopDNx5WyTMHZymI7S9nO7cUIXB3l+F2IT0VuNQ10tzcTon1EKZX7gujnujpQblygiSpsLZBKEg/UjvppuQwdoQHqm4NB5ToktV5dp8j7gb9ATPD8LAiIVEx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1NxtoDO6wxYN4skMVvlL0GEVtbRcnK4gMIc8ocACUI=;
 b=vYJRQHt8cKDbcpmWbrVD1WoyTXkJZNDbmCDyaEnAxnt1/yW95KQmYKjGl9H77VcU7mLW21G/OxUADOQsy0bF049RZpNCG/lDCIse5bWwhMZj19S6c7PgEnVw85owu2ZygLduUFo4f4fjzZOMO7g5XcFLX9qRu3ktC+89qKd+Dl5VNhdJKB/Yjr0NPtWlr4XROIkXOp708WEYGm4EyGjQYtxjJm92GBCB/9+VJ2i+OnacK5BJwnUQ7xhVAuEIgsn+MFQHRp9GD5GQlCloJtm/+ZuynLmNDC/ifssvsBL2KezlU5YFYYsuyBuKUoHEXKSWoDu/YQjt6nvMeWcempAX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1NxtoDO6wxYN4skMVvlL0GEVtbRcnK4gMIc8ocACUI=;
 b=refjcuema9Op961qrpvB9u/upzwte+NS1B+1Ko14V8BAkJkYX8b/7FxrtXy6SIASnC2UrvhWMlnAVelZCGTVIApM/pHivnZwcTEFGppEbFDidHaye4nCezflFm6r6mctLGWqx6cSRF8m8WKkEq9sMl1mtfUezb2u1VSxvaUvG/ehpVxxbGevg/GPlYDJoPGRUmg6u0D6VmpnrFAN35feZlcm0sQ+gqzPW6+BLip9X1vkmmhzh03EDKs/AKKgU1CgtYDuyLAsKOHaVYnfU/1ipQXuYoOYzs+y+u2tFpGMuCLQYycWBuO+d3aueiEFcGL6qMfszr99CUQb5UalV4AZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 02:04:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 02:04:02 +0000
Date: Mon, 24 Mar 2025 23:04:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z+IPEeg7jkjrIB+8@nvidia.com>
References: <20250321134629.GA252045@nvidia.com>
 <20250323190758.743798-1-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323190758.743798-1-changyuanl@google.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: d87366f1-fcc1-42dc-22ad-08dd6b415070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miGq+b0QQSd2qqaXDsOls4ecFJ0gUORw6mnhWaTx24ckeDf1eEUPxX0QCYvJ?=
 =?us-ascii?Q?HgC7oPynoStYDfBAjEOgDKjcq9wv5pRbCgNtYCwgK8XNpgoDwMh2SdmniQRU?=
 =?us-ascii?Q?9BGxe6u5y3IUOA8kzHPsgdu2LMyRQRdw+5mk60AcvbCPvMNX9XuHgHj6LxHH?=
 =?us-ascii?Q?Sc3WxQtkDGIK9cu2Vrj8CBCfVOxRq+fFOTeBAfUHcFB8+76nM5OGPpW0BFgy?=
 =?us-ascii?Q?E49Yvp1Br4fbTHdDCg1eM7FmIBjhZG2AqomViiCW8zKV11OqERD88e4mRSk4?=
 =?us-ascii?Q?uiWqNc95I3ylzrgk2/JmDYJvkxnMSmZ07mEC4SI7EElsHVaSgO2zCUJLCHXz?=
 =?us-ascii?Q?ZokNublPaeoBTVXBGVRHh5ISzehdbAqwWcfblqD8flXrdYerJWGiibvIKDAN?=
 =?us-ascii?Q?gfqverKq9CBAvCkiG/nNfj0M7j0e2HT70xTniyT9bPT2wZs7scq/8nPlfIHO?=
 =?us-ascii?Q?K47GZvBR3u0dvVu/nDOjnTidGS8S0iL89zMOCH4GREkGEKRBhBvcCC7cQhXE?=
 =?us-ascii?Q?0xcrCjCgsik7Yzc0B0XIyLwM8uxj77eZs3q8MEqAIvg+zV1bajqEsrMXyjSj?=
 =?us-ascii?Q?CXX/5ATUREaINmNRcyHtjDEy1BLfKbME3cTlEb8ohkoTQNylagp2w0IBTGpq?=
 =?us-ascii?Q?qSEQ5c5lSGTuuPvhlkV0zIS2ZL8cZOaTF41buA6vVQ/RuKUKjcPeK8ggHs4Q?=
 =?us-ascii?Q?H0ViekFmEo72DeTYR4ob7S/sU7w0oK4UdARPlEKurBLvOTidJlxJ3/aqOR0I?=
 =?us-ascii?Q?+QkMognJ4CXo5P99Iv63PsQiu6J7W6a429WQx4BCV36QJmi9OhDnNU78/7GC?=
 =?us-ascii?Q?gY4OdIWvGqa0doqGWNTekrrESi/6B+1cx7kE/EdiB51kZMhhIZ+IDex7RiVS?=
 =?us-ascii?Q?IIbIJW0jX4nqMgbGKeECba+lZ83zwfnXJzCE40mk+Wt2X7xTKN87+fY1gpRH?=
 =?us-ascii?Q?A8502uQSLkfJvIEZmzeYIHgcySArYGKfnwr6k1soXRFm7fFuAljIn3q86t5Q?=
 =?us-ascii?Q?yEoNDClxrJS3bzBVzLoJ4EfaMXwZaeUUCDhNchgQqpeed/uydV1oeR0BFirM?=
 =?us-ascii?Q?K/BmLrKTNC9HeAl0VcDeef6RnhJ+LFcD0+8fp12bi/ZqfSJgYTDF58wW3F/N?=
 =?us-ascii?Q?sA2O8VXpQW+QJYvDfaUUgdmtmPDb4fnhKRyKZYVIehwSsFUMXNNaVclbNCM4?=
 =?us-ascii?Q?wcb9CLOmZukbv5sRbDCOj+72iESGUtETtzsjvaL60jtxUF582yJowki+8ArY?=
 =?us-ascii?Q?rHPhXNNGpD4e2NZnEjfyfcCjHEVTOMVCNfSjkJjuL97Z413stqvsPD4f93Ef?=
 =?us-ascii?Q?l7cJTPPgJsiz61ms1wJ2i1YIV1eVPh24mGIgKXm/lbZSl4SYunbDGS8BFhGe?=
 =?us-ascii?Q?d3R8bDiYNRKRm0kSdbSJiu/bD2yn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUvxkFQ2iPEbNRUKavEnInat3+fqFOuHHaPN7EpiThm9KYUSsKjcZPmfG3Lw?=
 =?us-ascii?Q?2nr54aa/iKHgIBT82CS5DMuIW22Y6MqBUPihwuCSq0Vt8fEIPTMyCjLYlx9q?=
 =?us-ascii?Q?Tbse8uR3Vab9iPKfKMddEMWJ1Ogq8p9syBSZIxOMZn9vY0HcKfj6jt50fYgz?=
 =?us-ascii?Q?zWinJCjGXHNKGITJWJjD9mfwAeKBlrejQ4aprEAgJLHF/4hK0W0n8nS0dkTO?=
 =?us-ascii?Q?1ye/whay3BfqbFBqMHI/M/QgaTabLp+yvWZUtZ9IZ/UZqAYMqyu0KVjtJVdb?=
 =?us-ascii?Q?QqhBBHH9svExIpCqt73EP7vHP/6EEsq6Fbke7LiiJhKoUgJb6pdasFFzeWuN?=
 =?us-ascii?Q?mauzXO2APnz3dgLQFj1F8ch8UxuhFlTeRNUFDV4oyHwrZT+0qoxm6NxM6Zii?=
 =?us-ascii?Q?2KTaK/wr+C5F7PqyItehHxGJ5ZxjKw7q6RrP3umrmv4LU2I69l5b6bKByifv?=
 =?us-ascii?Q?sd45RRNGeLZtmwK29GsJEBUVRWRopJe9LF1VfJCPj1F/iNc0oTk0j7xwJovr?=
 =?us-ascii?Q?iAQR6VwhfmfUchKNXi3GP/+XdpT970XjrCs7W1DuJthwbm80ePFZIvnaEhXg?=
 =?us-ascii?Q?y6x90pRcw2xG6gQbMLCs4MPUNUhvt34Coo6rsSh00bAdLRwxio1vaGrWhhIo?=
 =?us-ascii?Q?gWF2R/wTZcTSKgHKGxw8EmCY0NUdVXqGgxz0pceWBuQVGdXcTRBI+bNdeZoq?=
 =?us-ascii?Q?Pz9Zmza9GcAY0Ctq5komFVJLY5Of1gtj3B8j/kPu0hbtm98qg/JIqV89fhVh?=
 =?us-ascii?Q?bJSBUy77m7PDzSn+ZO2XUmTxtSvD9tylH25QHuZYkqKo+GwNaEOdxgiZYezi?=
 =?us-ascii?Q?yjRNk4y1UH0JwHLgJG1dRs38ldEheZQdSEy615r8fANMQOTP0WxEiA2/T/zD?=
 =?us-ascii?Q?FBJidUFMHjOtXlfNJqgehVA3Y6xYKEECxBq9S7GWmuWrJ3eUq7VeaiBiyLKH?=
 =?us-ascii?Q?O+BOAKbdT40g3sBcFygJymn6LVq0ZKOAsbkZ91JD4Rs6csc+/n/I3qPyUlTj?=
 =?us-ascii?Q?9wDgxKYj/ZdahW3rGzUcR0C/+h9CnikJDhbgnXYF4AXk/g08uqvXGeltFyJx?=
 =?us-ascii?Q?V7yWzFnugalRmC958ZEiL0M3ObJwyIoNyAofE78pX79tRTcSSkPBA5F+lnnY?=
 =?us-ascii?Q?PndlocuBluW17zOPsWEFWu4Yj7pASX08fG42kPtavONwvwY7Enmz4lv19jGv?=
 =?us-ascii?Q?cmW/gYlzkkAVwzFfkb8GxXyc0jWeLbQTMjMRrmg7Vn9xDGNGBI9og0ddZFQU?=
 =?us-ascii?Q?VEpH4IodN9AOOF9A3eDIumQuTOsKKZpLRL+Sxyj8v04twnntzQw2NJb0HgNI?=
 =?us-ascii?Q?/3RIQNjaIaiDN+bHUD22lbvIFaXeoOFw3RwB+dgnO2aCObUx0bG5Cw2lMlQX?=
 =?us-ascii?Q?oNAQ0Gk3KZu02M39qjVUwbL0v3P93hgdYBqkWfguqXTGeYSuTx2pCwIC4+6H?=
 =?us-ascii?Q?jhNILgkYQJg5ivXwPbiO1jBBN32WM8q6dW/C5rTSFPsKT9dLK8LRPij2WGRE?=
 =?us-ascii?Q?TKXP93tmVAbXAgxcDNOXQdPDKYQ5DXDe/RLPmuB9djoomVosr6Yor418RZCB?=
 =?us-ascii?Q?nS93u4lZYS4fkYVOO9g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87366f1-fcc1-42dc-22ad-08dd6b415070
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 02:04:02.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn2EPKqHB3wmS0ncQoM10efDkbnD2UIXtLEQOXENSH/qBDgokQYvUBfeLWMCq3dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

On Sun, Mar 23, 2025 at 12:07:58PM -0700, Changyuan Lyu wrote:

> > > +	down_read(&kho_out.tree_lock);
> > > +	if (kho_out.fdt) {
> >
> > What is the lock and fdt test for?
> 
> It is to avoid the competition between the following 2 operations,
> - converting the hashtables and mem traker to FDT,
> - adding new data to hashtable/mem tracker.

I think you should strive to prevent this by code construction at a
higher level.

Do not lock each preserve but lock entire object serializations, operations.

For instance if we do recursive FDT then you'd lock the call that
builds a single FDT page for a single object.

> In most cases we only need read lock. Different KHO users can adding
> data into their own subnodes in parallel.

read locks like this are still quite slow in parallel systems, there
is alot of slow cacheline bouncing as taking a read lock still has to
write to the lock memory.

> > What do you imagine this is used for? I'm not sure what value there is
> > in returning a void *? How does the caller "free" this?
> 
> This function is also from Mike :)
> 
> I suppose some KHO users may still
> preserve memory using memory ranges (instead of folio).

I don't know what that would be, but the folio scheme is all about
preserving memory from the page buddy allocator, I don't know what
this is for or how it would be used.

IMHO split this to its own patch and include it in the series that
would use it.

> I guess the caller can free the ranges by free_pages()?

The folios were not setup right, so no.. And if this is the case then
you'd just get the struct page and convert it to a void * with some
helper function, not implement a whole new function...

> > There should be yaml files just like in the normal DT case defining
> > all of this. This level of documentation and stability was one of the
> > selling reasons why FDT is being used here!
> 
> YAML files were dropped because we think it may take a while for our
> schema to be near stable. So we start from some simple plain text. We
> can add some prop and node docs (that are considered stable at this point)
> back to YAML in the next version.

You need to do something to document what is going on here and show
the full schema with some explanation. It is hard to grasp the full
intention just from the C code.

Jason

