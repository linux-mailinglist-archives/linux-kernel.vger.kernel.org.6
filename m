Return-Path: <linux-kernel+bounces-574328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7351A6E3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817E518917DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C431B3F3D;
	Mon, 24 Mar 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tuomKyp+"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4D157A46;
	Mon, 24 Mar 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846861; cv=fail; b=XguUUiKPN3SNkoJAoVPgKk59D1J5LVUAntDgkvm3zMMKRckVakqT4CeCT89rD4Is0VVJrgyxMX/NUS+33mhwqyGYLYAZNEE2Bl4cYRoK58HRl60y4CwRxZh7cej2kACfH+XbLFdF0phZKB18KD2ByjlTSoBsuJ/U9caP8cZQzao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846861; c=relaxed/simple;
	bh=ge17yJDCtEP39SFVowWyys6a+P31XwFDR3MnLRzGuz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtDAtqA01WML6govfnz46TOcg5VskP2yW57wTeUtGnGOUrwN8zU5GcoW1BbNYJzHJ7JY7mREKFTMsA14Wsf+J+Hk8T2OuUs+AFCBmp7cy55Y0mM9waBMy9wWisBYBXA0CMpik8zlaugNDdzLGci6H0JashHsXOgwX7p2RhZqJrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tuomKyp+; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1B6y1nqIM1U4Lp4RqcATwpuAh9EWpl0D+7zNIxakY712sQ/kRqUlbTCzH0yEJLJ8cCjaDnNutu7UX/2jVZO+BD3zKytWV7C5nsm/jLfNQxxTD+4LyZywvJ4dA8NpcYwIV8x4EwcvP9wxwgBwo7bJlNkvBd0ie0ZRGR09qBCQWEIoRlYclOp0fNfZMabUXU4T3XSdvXQ7vSvMKokZX5hUlTcN/Y1beZijP79Bt+tG/X7yeWu84PaVvxioOsE3qOJxPmzEZIafRIfpd+uC2hHIw9t1r9psOeC09UfkYhUIutLZDKd0LqdtQ56PfjqJ+8Mr44vuLyqQNxkodY64RmvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOhvNRs1cQBxj4Duaz7jm9zqkl0lxkwbkoD90i78CHI=;
 b=nXSToNj50xNXwpyohOkdzdQWXDZVr0rH3GtOG0H/Vubr0e3i/jtFGUTCX+HzZbZ8F1H3674p3vkke0UCpPEpMy/zI+zPq+5h6EIz++KQtC8U+aKE03XER+Oi0lLfJyh7T7E6r02Ruw3mczoZPhxwWN+WNUsax1tPPR3oKbk/MGDMgAIr5GKwUCBGr+uKJa32NEov2v33ym//xxS06ocWpPhvGiB2PG3IxQBLur9YbFCDQhoWcOn3iCEztxt4rkrarnbYztQPFv6dTM+Ycw3Vb/t/+7g8rX9/r6dfkMWuGTxt4WFf1NugKhtijAshy32nmZGdsjVrBkxBu/LrWL4EHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOhvNRs1cQBxj4Duaz7jm9zqkl0lxkwbkoD90i78CHI=;
 b=tuomKyp+xq+EhL7Z2/5X00+dLQ7ovohZOp2HG+Pp4Z9sBYwGVOjTXh5eksufojbIjd8z6w0RsMu0hq0kCLAwI+OKjSycXGnjWVE54pE8qQTshQ3D/tgXb8V55GYlBRxutOEG9zFweXxzVAUIUJXb6/bL/gXyTr5u2Ej52oMpvnJwEfmT47uz/OrJjf+IYIcoy2FDzHq+kn0ewCe7KOG1g92L5hw2A7wAdBcRHx2HtqqsmDhGaa45GqF84GEPsBI0l+IhYZ4UmwiO2GoYxh9wNapq3Qoz0WbQ2DLnApjSY0Sr/jv58VFwtoY9JZN/o7jMJJoDMdWNp5TqUFrDtop7Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 20:07:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 20:07:38 +0000
Date: Mon, 24 Mar 2025 17:07:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z+G7iHUdRZGv1Ose@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
 <Z+BZOKSpyPA1Pyu+@nvidia.com>
 <Z-Gh-t9xB21UNGU2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Gh-t9xB21UNGU2@kernel.org>
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 903f5702-5797-4b7e-e2eb-08dd6b0f8655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFrC7RFB20Cihx2LPgXU6uPD+8gbWqiLkR08ELkwYXAMA1iBjyBUUr+1cv94?=
 =?us-ascii?Q?c08rjswbo2xc1jaUb0+5ijVCk/a2jEs6olW22hxkfO4kQsuFpG5S5ZT4e9gq?=
 =?us-ascii?Q?gq+Z3XYuKXwNvGWtY1T2jbR+EH5CDqinqI7jEVO5rkMz1usw6wxl7oW2dg8y?=
 =?us-ascii?Q?OS7znlk7u+GNirKqELutTisRsFAjVOYOPRvOYjU3KSrW+2xGsZ8sv6xdPwPO?=
 =?us-ascii?Q?FPu/zJ91XDD8sQc+0vYABmnPKLyEgpvAw1d7oylxQkWjGj0pWMdi24HXeqNk?=
 =?us-ascii?Q?E4+f3WTsUyqWlxXeLZmsz9BgfCc3BFYF2KAttrJybfNhWMjNivnlneu9REIL?=
 =?us-ascii?Q?kGyb78PPUulRXUQ3jQTstZP0dqYEurpyUxpsqva+tuGYkAV9sli4EMbwjl2i?=
 =?us-ascii?Q?u7HJbSCwsZGxDdNldAYT7fmyclYUcdEBgfvdHU8x79FHWMQBkmzZMIfNdE1+?=
 =?us-ascii?Q?nG4m0uBPZ70TmDT0SzMjpgZGoLYVKnB7HKwAUkRRzuhx2+kqnVfRDP+4JXji?=
 =?us-ascii?Q?M8p4QdjZZXWYKVULJt2pvTn1bvmuS28LGXztN1hvvhi97UBHdCiHa2t3Qc5V?=
 =?us-ascii?Q?/QiTrm3o2r1Bak+WAdtxWu5IR4Q+lfLa/3L6Oyf8BBHVwbHIO3dZxBapniwt?=
 =?us-ascii?Q?Xg+2qVb14KfEY34YqKz/KGi4rLfKwyQ4lxhDxww7LMPYGC5tXHUoirDqrtx5?=
 =?us-ascii?Q?k7KT2XLOhwVIy5/A5yKJ5yhVXD9LZ3koG2MqhkZuVrQLCGHT9qfeJ2+X6KAw?=
 =?us-ascii?Q?y0kC2pEIVDA2i982gH4taaPma3X1DaDK68928nbjZXHF4SELFquXCi2JjFVw?=
 =?us-ascii?Q?Xzifwr48hx+jnRCwk5pszp5YkSvPDX6PKG9kufqWGO3ARBJq/r4Wsi+mz8mw?=
 =?us-ascii?Q?75D+Ha+cAIhnT3CS4Barzdi30u/i8oAG86i38b04F8eDkNQXXC2xZDvB4u77?=
 =?us-ascii?Q?U6Z117v9AX4NsyAGTR49OjOzdubJQu4x1S7rZPkSDt1GsGgHnE/zWyVCDehW?=
 =?us-ascii?Q?uKeLF6i9dp9OqqmaEzSugfzIax8f2ZEfagLQFJRQLaZteiiJEHcmQqzNkY8s?=
 =?us-ascii?Q?3O+rRABldSFuRZP/c09ow9IrljvCwahTJJtDycAPk3ZT9Y9Qf1s6jKdt6Gp/?=
 =?us-ascii?Q?Ei6lu2GBqKNcaxq//hEGFw3YxfAJ1tbfjOjHAl0Jmk4nq9WUG3ffFOZYaWjJ?=
 =?us-ascii?Q?12/HIBh/MMtpzhDxamwKJyk1DdutsJtajNb6UOQ80uv+70nxY+6Q0ntHzVvg?=
 =?us-ascii?Q?s7640j7KfVNedyF1k8L8sst7+hb4fziz87WWkaZ1qnLFIMw5cuaUHq4UThpJ?=
 =?us-ascii?Q?nXTOx5YW3n12wG6El15fqd8C5oRkkLwsqp7S9ft3umumDWjoiwQV7MASeOCo?=
 =?us-ascii?Q?U26J7F1+flZjy9E8dFHBtEJO0BDu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmCIb++7kKDtOUi7963AEfv/EQ47ORnK09214iBzXnRMKMYtnb6GK3hjbqTc?=
 =?us-ascii?Q?RQ3DzjvsSK0koCil+/mgzLWiIe6uYXmachKCcqd7rm+Tx5XzHUAJIxfCFOzR?=
 =?us-ascii?Q?5W/f5daZpwzMikebAZio6qtJFyqUc5rkQcndWM1VrgiUHPlzKDkEqyE9HgV6?=
 =?us-ascii?Q?0VzhpOdVaa/+NWMXwB90bjhEZS/W2JZ+SYrohdCUVU6uRkmTy1bwBpLAdFUa?=
 =?us-ascii?Q?2zg8VnrSjIUkayIdz4GsPY1yFKko4B8kBkPU3Kx1Fk1CK56yfcbGUEmqY4i2?=
 =?us-ascii?Q?AEEaEeeiIyYyAldUaBep93eqN+kKv7ckZKJ/4+pr1KnZ6G8KqBT4pajB01Td?=
 =?us-ascii?Q?iaS8xzLamsjjXfMe6IgRQ8cKKwwSuJgS6B9q6/5BXO5ist669hc1ZJ61IS0I?=
 =?us-ascii?Q?3mpppcvzxU/v7oHuTt2XFkvTdRwaWOX0BVun5IM7IdwoPN7kP9yBnkpq1hxj?=
 =?us-ascii?Q?Soq/RUx1OcTOOeGxL7j98+OJ8w27tdMFTkZDvbx6/AJZQBPWupDtQ7pEGOTQ?=
 =?us-ascii?Q?2V7Fs6v5npXxu7jQzWvEINd81bamaIObkvm8WUOiBsEoe3p8fog+CYM5gF1p?=
 =?us-ascii?Q?PXWLnKej32DQb3DhYDF+upMtYD/juDpf3h4WZAkrkWSebt5tDILoYScro0MH?=
 =?us-ascii?Q?Oka7si3hbojlxZ4yiYKFcuNkEGkoiVooyC4LvaV2JqZ9PNMF+qge53XIC+k/?=
 =?us-ascii?Q?0UNZzO/Jig/0NlKGP6hzPuOkbJsW67R3fZ8vBaxqVnauQlrsWx+PnWaC1nOx?=
 =?us-ascii?Q?Ubfdr0hWGRWcnzI+ClHvwToeJmsWLNhsP4Q9AiR98iBc2BF90JrF8mDtKC4S?=
 =?us-ascii?Q?R+XuMath4ZofmhlmTYOeOymRMwmCovDghBcZQiODZ1in/cwW5qqTIR7BNeyn?=
 =?us-ascii?Q?/MPpWuFnLpiDqoQ6BGW5LCZQrPj3fSdp5BuVlr1jf/YGdV+j72ullMF8u/3c?=
 =?us-ascii?Q?Ch9U5JZZJAqr+iNPQMsS1SuRx6fQSaUr5/d0tBjqUAPCb4WjayYQOwz6pY1/?=
 =?us-ascii?Q?ZZZW8rl9YPdgFLJRURdEppOfKPyhDieWGRlGv/j1vAPRLi9icWH+TnV9L5p1?=
 =?us-ascii?Q?O5b1+eQxrCTANO476aUz/QzzP3LrseWDPse7XBqoMIYnW8YLf1mOtFF+XN3r?=
 =?us-ascii?Q?y30ExV9kFpA0n4NJCQwmZvDmmQWIzXUJu/Zp/egL13NSBff99mXyPTbc0Jyd?=
 =?us-ascii?Q?3SAbX5jkDu0msWkp5uVrJ4GlOHyFUtUoHvaz/2mvsO40j+TDGt/zJfCeKiiL?=
 =?us-ascii?Q?dPh3tbjSaceAQ+VQ5ErQanin1KLw+djujx5OMVB+thO5vtKUHdvDSlCDE76y?=
 =?us-ascii?Q?tKDUYE3LspdFqDqiVrXmC6S+wxKXXVcL3c5glqWjtRihmHbrsk+e+NcH3DbN?=
 =?us-ascii?Q?XMSbiqi3bl//rfHJYk54uunqGGC1wYcWRYXmm6My6WsMEESI+aCIMnZNh3tQ?=
 =?us-ascii?Q?RCapBgdO4VnjiHZvIiJ1pisI8Y4NbrPczbRn8tF2XKIdlZz+5PKyXzsfQPzd?=
 =?us-ascii?Q?YhFGLlPyiJvS0KyhS4QR+5q+rHqKGv91xwk+X2kaILyWxxvLty2HvnbOJYrT?=
 =?us-ascii?Q?c2aoO4a3bm1JGXcUBpY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903f5702-5797-4b7e-e2eb-08dd6b0f8655
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 20:07:38.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBCzi8nM7v3+zlvgQm1DA9MZRB+P35+t2ugKcqbfgw9KjcaeEung05jOW4J7yxrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

On Mon, Mar 24, 2025 at 02:18:34PM -0400, Mike Rapoport wrote:
> On Sun, Mar 23, 2025 at 03:55:52PM -0300, Jason Gunthorpe wrote:
> > On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
> >  
> > > > > +		page->private = order;
> > > > 
> > > > Can't just set the page order directly? Why use private?
> > > 
> > > Setting the order means recreating the folio the way prep_compound_page()
> > > does. I think it's better to postpone it until the folio is requested. This
> > > way it might run after SMP is enabled. 
> > 
> > I see, that makes sense, but also it could stil use page->order..
> 
> But there's no page->order :)

I mean this:

static inline unsigned int folio_order(const struct folio *folio)
{
        if (!folio_test_large(folio))
                return 0;
        return folio->_flags_1 & 0xff;
}
 
> > Yes, but also we wouldn't have page->private to make it work.. Somehow
> > anything we want to carry over would have to become encoded in the
> > memdesc directly.
> 
> This is a problem to solve in 2026 :)

Yes :)

Jason

