Return-Path: <linux-kernel+bounces-247671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6B92D2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EE51F239D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5019307F;
	Wed, 10 Jul 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="GxTUkcqD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44833193066;
	Wed, 10 Jul 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618212; cv=fail; b=EvR8LIEL1FFuBpzVfKBTEMeQZ5pb9R5SnVYNtYodkNaJKHFj79L8+V5CvDK5HAHEtiu5FwTb8qiQtZ80ZRsYHbPD2oDc6sFzMv+2vhvAy3lNMi53w0ZmuF+UB1lp0+HM9OIgjKoHMjR+eQ8Y67U570TSigYT6Nc3z84ci9Z6Al4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618212; c=relaxed/simple;
	bh=n1KG49TH2twW3IiVz7fRytYKHiex0b6K/SoZS/QPsUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u7iUuRLaOJDk9/rtOiSBmv6DNa35aWdTsUMQcV8UzfOkvo9HwXpbB8sY2gmRrQWlty6lf83TsuNC58HyRHquA+PreXkh/oI+d3dLaI4Rcr17zgBr1F3wq3iMb+slG+AgUyHBjdhawz93Gzs9ceCew0j3WnpPqvIlJvwqajjGdh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=GxTUkcqD; arc=fail smtp.client-ip=40.107.94.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibxasrC35T7HSIBUUHzK3c6yOhZB+dHmVtRT4R9e07leDfPqkQLzl58ipTJfBbp/LtUXB0farz+GuQlj5Iue2x777i1mp6naI0VvVvDXYb+wrsFTfph60I71ulKi5Sja4Pifaqs/M2zVOku5AWvhITF8cGfd/5T7je3MyGcgGUATdE9QnKpmOXNSkZ0aOgferHgACBcWHi1G5j7OeXcX0mQCaVGvE30OcXreLSskRQLuaedkUC2PJ8fGoUlWPyNyPaP2+dlrSPAXG86W/rr1Y5EVFkBuQ0UfFlZ90bclShapGDJlfulML0KvYI3cp/VnEj44MhHRWN/PFqPPy4kr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wU44XrNTCcAo4dNR4aN/lThIy6KqSkpNUSIe+IsqHY=;
 b=fY5j43r2lOGohopHE/K2uqog3ZLh0LhDo4kSIoL5HkeFeDoBTgR/JfDiCHMVuj4vQvr+FjfDe+MESjr8oQzIga7czIBEuBosUl8YCct0rMKcgJ7JRJHHHAt/XFE1sA/yaq3FjuxK6X9l7Cw/GNQl2Q9YJGxQ+YW9Ox91xt3h//FFo1vEtTKFaatGCsJnO520mxFHpIHHniOZgvdj9nQvPBMG07Pi0iK4Zx9SaWx3ahvo0RE+9JyKQzG5qBfd3xAzQxMv4lM8o5SjtvHoeCFpGElIs3ae/pQZy6F+/cIbarEgj9sA1vLna19E+qS2reKSXDvvZtWbg2JjpGbsg9OKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wU44XrNTCcAo4dNR4aN/lThIy6KqSkpNUSIe+IsqHY=;
 b=GxTUkcqD7u7ivUGDDaJJOBSkPOoHH55Vyg36e2nNLJEAo9556SpLwyBlN6Yr/TOltbPiR7bHfS3GZGKNH0lpXaBDjAPDOkYuuux3xm/4sLLvdXXMWucyi3nWFNLDxiSk6pma3K9HqXvhmPmytyZxY3+6q7t7n5BAz5VERPVqJNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by PH0PR08MB8471.namprd08.prod.outlook.com (2603:10b6:510:292::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 13:30:06 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 13:30:06 +0000
Date: Wed, 10 Jul 2024 14:30:01 +0100
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_uac2: fix non-newline-terminated function
 name
Message-ID: <Zo6M2RntMo6Qnx3B-jkeeping@inmusicbrands.com>
References: <20240708142553.3995022-1-jkeeping@inmusicbrands.com>
 <2024071022-exemplary-zipping-1f34@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071022-exemplary-zipping-1f34@gregkh>
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|PH0PR08MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caec1c7-6ae7-47f1-3489-08dca0e469a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9E3DKEp7Z5lf3KE0RQmF0SR81qEI3gyXfHhifpvG/6PfCuT3ObTO99X120Kp?=
 =?us-ascii?Q?29NdasqUeOizgUX66vfVhLPrZ2PvlRnS6G2uPz9Fi7rqrP1aytr51pyIizQ7?=
 =?us-ascii?Q?iXEuLJgAn5gr85/jF0BX0NI36VQny6scFSqPNh072AHdNu4LTdqCP08tSoof?=
 =?us-ascii?Q?kiGnc3WDGsJqOX4gu1261HdhWnbgoVGgRSiPxrpigI0zaGfo/qlrgi8BkiZ8?=
 =?us-ascii?Q?D/R0rDRSMD4HMhZAZuJ74qGrLKG5SJb0e8ikN+nB4qtvS+xQuTXeNn5Pw4EJ?=
 =?us-ascii?Q?2jc8X+x1jSj86cf7NTPHeeLGTUxrMTdoZ78AyZp6JIu1ygfmEyEM/6b7ufH0?=
 =?us-ascii?Q?1j3W1mQ+CV1rckXg1rI1qF7XpcWp4NbisCZzFv7YTHqiy7t6Xn61x7GdV4SU?=
 =?us-ascii?Q?qSuLVJ6G7HhM4j5CdHi8uvRjUkChv8M7CWEmPZbeocGAq6M/HMlRWT3JvI/e?=
 =?us-ascii?Q?28CfMd1nOC4fg9CV7qOtaJtsc9Oq/BcQRSDMDH5Ex2VsKZMpJCRUGrrAMWfs?=
 =?us-ascii?Q?fGHqZIW3flerQz+S7uHzhnpPkjS4aN0HSdVnyWO8HN8KS+jeMOGe8+hMB9r4?=
 =?us-ascii?Q?2YBfW9g9oP/j/O4JI5TRE6kU/xKjFEEC7YEDIV1fhxw5wYf/UFQCZUz2U3Yf?=
 =?us-ascii?Q?peiQ8e0p810koMDqelhu28k4oxMOXdqWa0cxoSDdb4O1Ribf1imiWZ1GX1CJ?=
 =?us-ascii?Q?d2Wi15jvmhr6874t9bKznaiOauyvwretJliOZ+4mZ+WTbJd1iGki1whkMGmW?=
 =?us-ascii?Q?I9rLOpIMzqFCOMoe0rjpfh0LFA9bazZ5qpYfnCwluOoFOjBp4Ggdlci5fs4h?=
 =?us-ascii?Q?jBnPBwhzdxjGgkEkQwu4QlB2THAeGOJ2SpHvqtDHMdZP4FPm9Yk4RjicAQ7z?=
 =?us-ascii?Q?n+cHXJ+GcMNxKrl9BgPOzcfEWV4CCYdtjkBfwJ5qhe3D7lcK3xndCSrheAVw?=
 =?us-ascii?Q?gqQi7QaOGBMrKBac417fR/yi1KjKIS5IAKwob9mHN4NoWVzi/gVpv0+erQMl?=
 =?us-ascii?Q?iu71da5h7zAUPEmlBQQVt9JXF8epXJd5U2vZSblW1sFo8XCopK8Hr86EfaDt?=
 =?us-ascii?Q?3X08mmNAISZqHjup9PaJpiufl1vYWlCGjapxlaVDwK6ydvHwGjpjFxOO+Tf0?=
 =?us-ascii?Q?skaE60og+QHK/h5C1Tb5DQai4Xp2eAAGrQOeFoVcxumTxSfJK8Q6c+W+yTOh?=
 =?us-ascii?Q?M/p9qsVUzVZmNS1/XBypRYA0X/oLH88ZwU4y4wD9UdippZDGXxx+pbgWs0A/?=
 =?us-ascii?Q?q0qSa9OoOImyYQvjDKlJzT0Sj0BeCwA7HZIBHiT+cgqzCemasdqefG7BYnIZ?=
 =?us-ascii?Q?vBeJ2bW7lFlyz9wPJdevxjPy/q2ajTvKcOn1DyaFUS4pWXTxG3Ls7mia2wX1?=
 =?us-ascii?Q?AsCw1uzX2+4NbZ9L4jR8qmDQ1eILTMRa5nzFGjw87CsLxhlWCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPJecT3URltTjU6dqVd86f4yv2eCIjtb2iqVKeSBryNI6kU32+Xj9EYbSWeq?=
 =?us-ascii?Q?exQSXIvoWoUPe6ML3FGRhLXUP590WewetnBgeN1huLmW+yJD8/ihZVObhQCK?=
 =?us-ascii?Q?nqcp4BKntf7gHvFRAa/2e/bKni1gDFiAF/yIrmFDgm78/SuBs1s1XTJiGQ9h?=
 =?us-ascii?Q?O5Le4N2xMaLUOrGPq3MZXUkMwYcTrgszgiztDZuu93nnQTIKzei8vLSIsyDV?=
 =?us-ascii?Q?3denYuw8FPaW7hKIimK/7F6/4vD/eaVEUjyyAoZsq8Rk80Q2CRHiqlIE2wfJ?=
 =?us-ascii?Q?NeCa/JdWCLbSrl9PBP6ufZyhwN9R3so3ONGiwzDeRagzuSnWnjHlXf99PEGy?=
 =?us-ascii?Q?nTJRWrzKkC+3Z6+7jz/yoVCemWA7rVljZ1phOQN8RpilE/rlv/1JgN/e2uqH?=
 =?us-ascii?Q?epvg5YiUacklXL1aLiSZIa1y1end2jX3OYAV3eYg8Lf06pbWhBW/nOTvPuyg?=
 =?us-ascii?Q?7iPT/iF+kytpW1nkee+mTKz0NKIsqnwcbsfr1ZEsQN8t/CsVK9d5o777k4ru?=
 =?us-ascii?Q?eNva0s8VFOGdNeEEO8/bK6pcAWkVNpok1HcppIZX3wF5onVJOvsl76Q1iK97?=
 =?us-ascii?Q?6D1xHJnRwl9RGmsYth3l5EKoiMqIfrrNZ+hGbbeJo9R089GbsBQQ1e0xpklf?=
 =?us-ascii?Q?W3wtDlmVmflGzmsa2nfLYxbbH3XhdY7381l9WlY5JmeuwKIUjcKSSVuPeizH?=
 =?us-ascii?Q?uSJNETDRVxcIwab0IUqdNyA3O2/4/wY8CLCQPow8TEHQPwnftPkd9nMabxQC?=
 =?us-ascii?Q?n81FuxOeCTyy7IUeSZ8DCiZ9p4o3jWtfXMSpLHEMGfZ5B0fHWQFsSKeIqjU6?=
 =?us-ascii?Q?+gLZp9xCWBXDDbY0GJvA0fByPYoVRcc9nb9S+ZABCyTZRElDiYjzAl/9bluh?=
 =?us-ascii?Q?cJigoXmTx5yPSv6kwKncuob8eJH4YAYCZ+5E0xcP1SEjA2beb463Xy+nGTci?=
 =?us-ascii?Q?LKZykdg4YLOqTgpoNaN2lykqPgwfK8kObCSdXJo29upHBHNViuEFY1rq/+0r?=
 =?us-ascii?Q?WUNRE1HxYjkWuBvolwvyoNIeV+2qUls1qqdSd89H9baykvgTg79mtQH02A+V?=
 =?us-ascii?Q?unQqhi1Unt+Lrq3gSacI4NiLTon+ZBERMEhn99G1RFmg+ZVrz52UtjoOiZLJ?=
 =?us-ascii?Q?eQSqWk8GySwni50yD+AS7N/YZHIeRfllBvWjx/2SHZ2j8JJvtgzZsBsdjTIK?=
 =?us-ascii?Q?uSLXcg3T6vv4lI9fAL8QMuDvKjJgsfIhJv6KaRwtr/RtmbE0bpGmsN7wxx8H?=
 =?us-ascii?Q?r54ldeTssBmgoIGg/r63AgRDIRKJWJ7ZwY0HWMBpHCq8+t1HMucOcFkXOs7K?=
 =?us-ascii?Q?kx3g+tJ3rOBDuSpEPILbaGLyDQ0yxGfVOhLzkFvedZgp/uz1H8/1v+RBBpaL?=
 =?us-ascii?Q?d6cj3ERvarxNrRbv4jnw1i8ZAqTPcShdZ2INiREypQ8Q76WGgoJH2M0Jvczm?=
 =?us-ascii?Q?OA1Zun/4LOtdGDjvkT13wrvqXiI1VASWD54mWfHhWdqxn8Vtc3jXzkYv8BPW?=
 =?us-ascii?Q?jJfZd9Hudkg8VBpWfB9boPYMzqXEvGlrUE0P1lNP5E/3AP1HC2hdhDhL4MqQ?=
 =?us-ascii?Q?DnYoHTSRLzEnoKp5avuE5eI1LJ9ri6ro28KadRP2i7PpY7a3oGSGmCJ7NBQu?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caec1c7-6ae7-47f1-3489-08dca0e469a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:30:06.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdkVpWpLaD2wR8CLqccSSH82RL5NW3wEFygyrAdY4MW+TzKyCgdpLoQJJIyPme/0kLyeochuLQI/POsbhsH8WF3WVv8SLZ6n0Hh6Pvn1F+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8471

On Wed, Jul 10, 2024 at 01:53:22PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 08, 2024 at 03:25:53PM +0100, John Keeping wrote:
> > Most writes to configfs handle an optional newline, but do not require
> > it.  By using the number of bytes written as the limit for scnprintf()
> > it is guaranteed that the final character in the buffer will be
> > overwritten.
> > 
> > This is expected if it is a newline but is undesirable when a string is
> > written "as-is" (as libusbgx does, for example).
> 
> So we are changing kernel functionality because a userspace program does
> not work?  Why not fix the userspace program?

This file behaves differently from every other sysfs/debugfs/configfs
file AFAICT.  In most places the behaviour of the following two commands
is equivalent:

	$ echo foo >file

	$ printf foo >file

But for this function_name the result is that the final character is
dropped unconditionally, so the name reported in the USB descriptors
will be "fo" in the second case.

> > Update the store function to strip an optional newline, matching the
> > behaviour of usb_string_copy().
> 
> This changes the behaviour of a lot of configfs files right?  What will
> break if this happens?

No, this is just one file in f_uac2.

I can't see any scenario where a newline in a USB string descriptor
makes sense so it's unlikely to break any existing use cases.

This brings the audio function name more in line with other string
descriptors for the device manufacturer/product or configuration name
which use usb_string_copy() and strip a trailing newline if it's
present.


Regards,
John

