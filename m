Return-Path: <linux-kernel+bounces-535815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62031A47795
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EE11885429
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56372219A68;
	Thu, 27 Feb 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1nSxGNM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC45A59
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644348; cv=fail; b=HTww1EgBUL3nbyL9Twej8nvrYT0fFmRbTm9OKji2YjxcuiixNKnOOXvxZpLA2Ir9gVWsK9okX7WjMPDoodFHe9ilboohRj0Y2xrKORzONY8B22bxymkQctoMkJpSJKr8LEMe5wsrxaE4TLqPfuAq2FgWJ2zKpZ/z3DpOsGAsbBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644348; c=relaxed/simple;
	bh=FHn2ZdYbxY4/0l6ESXmgwxiDRJVP2cYbrUPMvRZUQzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y2dzvoGq77olgSx/Lr0MGKMns+I7JLfKcfE+trZrjWNDGvuPNxoblnGx+sReqNrp8QU4YGK1aHGNoW+osk7qHjQ9bk6iAwGHwE5ziVkX/+PXZolqYOCOIihX4deEoiTfyNTYQ8inv2o2Tu/gIyxU07Vtlr7Br6uTURuHabGWNL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1nSxGNM; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BioiyFNa69dqvaBq5za1hhXMqZwUnyoKsrswNM4crL6gFkcIzx4+uhBmv0WyadeP0nfFBtaKSNjezOGLRG8t1sAdTtu16DTPTYNWnWGjgMlxzfemzG0NMdiIqAO8DQE3DmOl04Ng6tl31360V+xFzLQWRdMKOB8XwBGY4g/BSe2u8rjPlLzjCUISaHOP6lyGW+35oMPruAAHpxdO+hH6FErvoWpMWSfSbX3Oq/W+acwbdAF1Wqp0BZjH43Xs1RN8w1E4+hV4nig5vZE3RzGIlrFTJ4CxzjF9he91mLGMhv4TiyoX4WFD3YvlYExCCuHDMTFEu0NQXeWx+yiY5lAHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdqR82Yvs0bs99qX3OprJL2wG8JDC+FkMn+VM0r8Gjc=;
 b=mWIuqoxzImmHSynRbxpDKnVl2VhwqvGwmxyJ3AhwKp5qfP6ho0R7prhj4cRE+cbKMHyQ5jRK99ctK2TNmoJzf3XOzKgxOeiFSI/E9q3XHdwhR2ANTEKJW+Zhr0E7uV/rPVvtGn8gV6wkwVg3f/bhgF+H2dS6UM7qPJL1VvKvuwzMu60Ashj5bfzoOow2ZF2UjGrx6Mybjxr9ZTQ+UDexen0ME36b+8/W9lePq3F1IvuGZaSTOAfhnpHKozlElqJJIKfWq1taxFXigIY2ESkmTenyCAJuEFIjmgq+ZdVkycvRzgoVNjg2CGeHOBnNAbwtFCeCZQez6LMEm+DhzyX52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdqR82Yvs0bs99qX3OprJL2wG8JDC+FkMn+VM0r8Gjc=;
 b=b1nSxGNMW71E6b0hF6MWDjc1/t1lDKPpRQI5CSMYW38t5V00ygezziLsfW0DzIgzvAfyzbb32ht0jrp/tTF8oqqEjWVNaffMpa6XqO3PX/4+g9x++HoXof1CT6+KQiBU3X8k7UMF7cIaC6nzcKAKOpablocPFGa6PaUEHV9avwponKO1vWzxZgZ8bTmAL73VU7lXom+3qneGJgl/px0BGems/J0OyYYVhu//sHEbdbdOs+8+lKHBOFirfwwGD6xiReQ45j+wYOxa4RbqYc7axyc0r+YMy1eA30tyKci+VOx7ya0LdFGQd9Qt/HkYa987JO1JjhQbcNJ7NBhPATHIGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 08:19:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 08:19:04 +0000
Date: Thu, 27 Feb 2025 09:19:00 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
Message-ID: <Z8Af9PRa7LrxHpfp@gpd3>
References: <20250226143327.231685-1-changwoo@igalia.com>
 <Z8AWZBtrGN8h76AK@gpd3>
 <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
X-ClientProxiedBy: LO4P123CA0156.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bb8faf-4b65-4164-b308-08dd570765ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JA3Of/aR1xZeMfkP4LCxy9UF7IzPwkJKeTWVCjmPNmnEST2w8eqr+UNhXTXY?=
 =?us-ascii?Q?jfs6ZvPupA6tiQV5w/vfsegRI495d/Sl8+8Hi1Z5BrS+R15fQypx/RWo101r?=
 =?us-ascii?Q?ZI5cEuLSEX8sbL+ic/rm5Rp0fqAoxujutyPu5y5hOY1ZiKmMmIelgMl4nbiz?=
 =?us-ascii?Q?UoFfbJcPRuYtHkLvt3yZSiUTH2HInDcDrLX31lBwvyvVdd3SZriWVjEXXfc7?=
 =?us-ascii?Q?7yu9fe/BFJ3RLAzgpEBFypgWZ/gqgkaw0H+v0h0ans6RoQNwetxodb29l3ui?=
 =?us-ascii?Q?M49+ctfn+1kfNkwo0iGpQvAvKhTBUWlp6WStVwjQAiO/2v+Abma6cLW1sKAJ?=
 =?us-ascii?Q?LYQZPjcCCYwTLoSrjAGuN50cchekxsl9XY+FJlAjNfbZ1b10X1W3DgYJXPhW?=
 =?us-ascii?Q?JKyU+djBOyvdObtCGpnUjtIM70GW68lXqyhuOR6PhVsapP80kSLSRAD2jQVv?=
 =?us-ascii?Q?WD+4tOPIY1exUbVZ6LAJ01dJVFabCWdd9i08knS6Uwpd8D5BRgNggU3FYpm1?=
 =?us-ascii?Q?oVX78I2QJQcv/f0qm2d7F93WkyWD/ClWL7AycuTx+G9Y81eXu+d6BkgJwT8K?=
 =?us-ascii?Q?IpRqRT3VqV50vrh5I0ekAJWW7CzBjpWlspTJAWMGJPbVvJAV/ENQ8+HhJlWb?=
 =?us-ascii?Q?vUtETD+ZJ//1jgjMjZyIOzt5BgWPtRPt6EiRE/v24affEKPqDLtIOCxGJu+J?=
 =?us-ascii?Q?mWbaaOtV3zTfjDf5zKb19SIyWOHYdxBV7qkkYGWz2/S6UcBHaqscuz+mochZ?=
 =?us-ascii?Q?qWsmOcbuuyAytBpE6tVKVvmviT7D8Y1ykSIoi4Ymq/9PzMV0lVv8GqkH69Rz?=
 =?us-ascii?Q?AKLyuzACaUsWCcgZ72j0BLR7JmrncRiru3pRb/xOUtexmas+H3btq/CLuX9M?=
 =?us-ascii?Q?qnIvvYVEWmNiOSFlcnFX/X95nXjvEvtSPcqONn5RHcAHqkIk/ddXTylVcqHu?=
 =?us-ascii?Q?0RhL6fIYKAU2sdhzfJqNlkHOfErLxmz6GAW6av2ggEwgs8L9VubiOnmrDatU?=
 =?us-ascii?Q?yftfujPQJdctdqVKOFt8r07eyp8OgcLojmV8pwu/Jl+9Y7SDxZbdzSfgIM21?=
 =?us-ascii?Q?BOJTss+RtcQ1AI3hat1nFJLHvSg7fYvawmmIE2hmD6TX5MEnFOaD198BXLDA?=
 =?us-ascii?Q?fP4BUYozzzudkNxNb8unpT/lImrW1VbIO4w1yCIOINCgoathEPBXc697suwp?=
 =?us-ascii?Q?0HeiXFkoMfLJIuY+q/qSBclyrwak3B2QyYlxmVG+qOm2BRAOMu++oKeIrnIn?=
 =?us-ascii?Q?BI+Tut3fpQj8aHxktm0lnX5Aezgtg1Rc6OHVce3gvl7byQ+R5QlyzstdD8EA?=
 =?us-ascii?Q?EWAtuXbAejaBwrZHxm7G1aP7nPnyTBgF6xhNxmuMlg3xnxe4rrbkv7hxO/gp?=
 =?us-ascii?Q?rQQKi7NTcBi7kSzGYnu20IK7sMD6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTyG/FyizCnvHUcJTGIH8XX++scnFFpHK8cAO8QJdOpzCY0BnDKeecV6E0Wc?=
 =?us-ascii?Q?4aHKK4oVoD4u1KUMKIYifTYSrPh6upk33eZ8WXV4m7+imRh985QXg612E6uA?=
 =?us-ascii?Q?KZVCKMoIeit4IfBNRm/ctxt58AjA4BdGeU8XbYl8eF5bZgUghijcJByzMur6?=
 =?us-ascii?Q?aljNf6SeKqyb26KoJASVFfYPjrCPbyk4dw2msD/mogE9kuyv99gJZ1Fbulbt?=
 =?us-ascii?Q?+oB05/KLxWLqaSyMLsgmZjRDJ1PV5b3qrqVN+XJORMxfRsnE1B8GPI42Tgv5?=
 =?us-ascii?Q?pw92KTZMpnrVq42lGhFzA8b8bkzktgQglON7XNwQ1jRBQID7BWdHAcaUw7UL?=
 =?us-ascii?Q?bAe0GYE7+fRlxuGD3BWaHNqFdSq9YFuZGAbwkCDZeBKXRFFjuAGXgdYC1M9Q?=
 =?us-ascii?Q?GkqzSJLmiCzDh5wumTvUw0D6ImGD7F676cuqvVB8ZfM1KKUltoBRSuL2bFN5?=
 =?us-ascii?Q?DdeMdAjq6PB5MymNBEL9EY+3pHE4r3bbKBJxodsai+XFsFh0sxd8tf+Rl7+m?=
 =?us-ascii?Q?AUCgUPwFNksd9ZVcOgqPIXO+x4tLT2inQUhNHAtYb1j6duLMACXYanDmiWbV?=
 =?us-ascii?Q?qXp9shLS919iJziuRdIzJb67dpmhhpQ6z+u7Vbp/0hRZ22vaPno3bfSTBkhm?=
 =?us-ascii?Q?pruf8g0Wh9gWezJZwExrfyoTP/tFmuUN36nXeMJwisOHrtqRLRoOgBR3W411?=
 =?us-ascii?Q?TUreIzdwbJuvlpvzlOURZ6He0PHXveM9P+iGvw2+XPTYMFzvlpXmk8BOT5rT?=
 =?us-ascii?Q?f5Sc5GEpKBC/O5ojeqVsaAFuLlfEfUfNMWdb8rL/ZnAzBZ+sFdLVm5ZlzGoU?=
 =?us-ascii?Q?r/97mOuyRw8eWtONL9C9Wdw1aDS89Vlz98r48Fh0WCOZmt/KI7ognkS1ZS7u?=
 =?us-ascii?Q?8fwbDXcx2L4WnaMCgTA8yf1fRZh3F08UTnJU2RR/TjHsqvhcfQxAdG91DgW1?=
 =?us-ascii?Q?pReEQcl4mch4kzj4uEDoBOf3ZI3PWsQBVL6XkRuK6EM1DvpUw144EAQJAKfQ?=
 =?us-ascii?Q?+i+nm8ADg7JKX1HTDxsvJgcFAZzYaCf7VJKTF4vq9Cbo4ZMA/geP8WssywzE?=
 =?us-ascii?Q?+1hHJt0mjCnsdQe580Vj422CVq2EGDqh5VUtBcGSaaAqTzqMycfavhj9j2O9?=
 =?us-ascii?Q?A/COHJYqnu9sBJQ1bNf8wDpU/w9kmgnQo060DZy6aBeKysgoIzwPuPYFDbav?=
 =?us-ascii?Q?fjC22qTd3icDH8Fg8M2Og2jtEDeh/D6EmSdbu1IwbR90upneIwEbKJWsHd5P?=
 =?us-ascii?Q?3pr7P1iBQtPeDrAD5cGZ9heoqLKdcC1YsbCVYCVnjgTDKAwPiI4g0PzrkR8m?=
 =?us-ascii?Q?VKQrDRUnRMRIDK5fE0QBdZ9SgL9NiH9LAMtWMgxxXZJcMsGtPe2iTRTIOufr?=
 =?us-ascii?Q?g9OOcQ9+6LkaWnFd1rD0Hp+QwVDaXgyOa3fWFlXqyCtr+5htPto2eURi6l2R?=
 =?us-ascii?Q?x9xtLFjau/iy9xxP7bRu6ZYyJfABYJtSH7yFJX9ss/eUN7Vo2Dji/gCSn4uC?=
 =?us-ascii?Q?Tfa+ATV77voEAZPtSYDrhneuE2jeEpN6MewJ+yCHl6EhHwmHruB8Q+O+EMHa?=
 =?us-ascii?Q?Toe+0hkG/t1hzjOL85duvtu9NYXLPJDHd+KYcTjU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb8faf-4b65-4164-b308-08dd570765ec
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:19:04.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3NH8rJyToUtzApojTo2wcBs2JKLypQlaX2OC39efqUcs881gUvRJPzVSlKnYctlpJitmvyRGT9nDOiDs76asA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

On Thu, Feb 27, 2025 at 05:05:54PM +0900, Changwoo Min wrote:
> Hi Andrea,
> 
> Thank you for the review!
> 
> On 25. 2. 27. 16:38, Andrea Righi wrote:
> > Hi Changwoo,
> > 
> > On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
> > > Add tracing support, which may be useful for debugging sched_ext schedulers
> > > that trigger a certain event.
> > > 
> > > Signed-off-by: Changwoo Min <changwoo@igalia.com>
> > > ---
> > >   include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
> > >   kernel/sched/ext.c               |  4 ++++
> > >   2 files changed, 25 insertions(+)
> > > 
> > > diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> > > index fe19da7315a9..88527b9316de 100644
> > > --- a/include/trace/events/sched_ext.h
> > > +++ b/include/trace/events/sched_ext.h
> > > @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
> > >   	)
> > >   );
> > > +TRACE_EVENT(sched_ext_add_event,
> > > +	    TP_PROTO(const char *name, int offset, __u64 added),
> > > +	    TP_ARGS(name, offset, added),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__string(name, name)
> > > +		__field(	int,		offset		)
> > > +		__field(	__u64,		added		)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__assign_str(name);
> > > +		__entry->offset		= offset;
> > > +		__entry->added		= added;
> > > +	),
> > > +
> > > +	TP_printk("name %s offset %d added %llu",
> > > +		  __get_str(name), __entry->offset, __entry->added
> > > +	)
> > > +);
> > 
> > Isn't the name enough to determine which event has been triggered? What are
> > the benefits of reporting also the offset within struct scx_event_stats?
> > 
> 
> @name and @offset are duplicated information. However, I thought
> having two is more convenient from the users' point of view
> because they have different pros and cons.
> 
> @offset is quick to compare and can be used easily in the BPF
> code, but the offset of an event can change across kernel
> versions when new events are added. @offset would be good to
> write a quick trace hook for debugging.
> 
> On the other hand, @name won't change across kernel versions,
> which is good. However, it requires more code to acutally read
> the string in the BPF code (__data_loc for string is a 32-bit
> integer encoding string length and location).
> 
> Does it make sense to you?

So, IMHO @offset to me would make sense if we guarantee that it won't
change across kernel versions, and that's probably doable, we just need to
make sure that we always add new events at the bottom of scx_event_stats.
Otherwise there's the risk to break potential users of this tracepoint that
may consider the offset like a portable ID.

Maybe we can call it @id or @event_id or similar and guarantee its
portability? What do you think?

-Andrea

