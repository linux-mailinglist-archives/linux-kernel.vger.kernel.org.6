Return-Path: <linux-kernel+bounces-519241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8EA399B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C131116A9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD9239099;
	Tue, 18 Feb 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="D5vYkBB0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856C22D4C9;
	Tue, 18 Feb 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876191; cv=fail; b=VRvEcq+yQmLpguhphaZ21rg3n4WxlWoFVSrKErVvVxxihtvk7/CYqs7EhReIz0prrM2Z2BvSGUWdgqwry03Hx8/yWINi0eoIRreGeN0hUW3/3QY9PjEp1NaoD4zHsbWXAJ4EbALGaFExMKBcFY6+uNJ5iy+UUcsIaa4LsCYiba8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876191; c=relaxed/simple;
	bh=PbIvCHwsSIA31Mbe9dz20y1DTTSWNCzjFjKRlAYXpTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fg8icFVVub8Sy4KZpa/25u5gVSgvgrHEXT57h8SyeWkovjHha1Y0J4/Tc/g0SpGWd3YfTfggCmygUzSl+HNXrEGGUzF3B+HRafLacyJtduA5IiVu/z803k0zvgGxMRhumYFH0q5tL2whgB9reHEN+wE77P57FgjtoHhtvYehF/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=D5vYkBB0; arc=fail smtp.client-ip=40.107.244.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKoZEmj6MxJ/ZAc03xxHHWe06Lx+41ILHqfUeKzgtGa20GjAsnoB4grBdeC4VjZnnmlRqVNXfWre33C5vHNTzKYdskE1Bpol58TLvl5BbwTyBB9Rd5a6ZXTZlVG/vHs6ni5iPzmVHV+VR9aM+2UzVYXcEe1fNaCy12xzsnWyoteLrM2GeeAhB2u6kLFkKHbmvdX3oM89tyN7qoslbTj0fdtGyotVAYLlqXzfOAxMYKNZueRSnX6Of+KEIsPIVHgeY62mHO9Z5ezoUb5Kz6wSObMJzxYYeJmMlV6sDfpfJe8SRGfY+ow0HsNeayqzSrNar+RSlUgpVZB/tXZ05HK8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdc3awizyXpUCVtM35uDczcHOk5FISfHsLBDt5hSaTM=;
 b=QNpMD1erjmLclKXJ185UGIBsrQMms7OM6dYJJ6LtLY5+8RxjLWutYuznjArCPBS5Tctdol2lF5dKM7NZRABFvclstB8ojamGq7EGJdggxZUVtKw0p0dfsz/zd90nOO2LKxHTOeM9p+EHoFFmuED0OVidPIuVomzex8hkmZi2QTcseUZCjP+aPWsn2PCAGg0i17kzzNgUnHRb2uQA2jI1n6j8QNd4qEOA3kkggkF3JaToj53wLSMlqqYnNAfd1cTf0fKg68T7uGX4YYX5qtNgjBiyp5799s3swWwHCpML7As4zjbuvK71zEHzEvOlLRQvd6RoFqDcFHiIh6PjmmUdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdc3awizyXpUCVtM35uDczcHOk5FISfHsLBDt5hSaTM=;
 b=D5vYkBB0fQJCj8gPNOaQRlmLWFvjJ4UyTu8OQTKJafNLGdMOyxEwFY9OVhvSYlw9zuVO8wnJyZ/FSZmhctDNOKqcZ2vGhYLnYzJhYo9FMCZnYrH/cvTa3/fY1RxJXU7H0JVfwFkNZS6BLamfSO4Ux6tLTAJzfwNYeJxvuZ9igUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by DS1PR08MB10198.namprd08.prod.outlook.com (2603:10b6:8:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 10:56:26 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%7]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 10:56:26 +0000
Date: Tue, 18 Feb 2025 10:56:19 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
Message-ID: <Z7RnUwatOnxYxNfI-jkeeping@inmusicbrands.com>
References: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
 <8734gc8prr.wl-tiwai@suse.de>
 <Z7OCJ2DikMvhAxVf-jkeeping@inmusicbrands.com>
 <87zfij65hd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfij65hd.wl-tiwai@suse.de>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|DS1PR08MB10198:EE_
X-MS-Office365-Filtering-Correlation-Id: 0937ff97-6e1f-4f46-f7f2-08dd500ae3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UArJZMAuYdeo9MQjEMrwh5HJNUTeX1JgcuRkqyXgxtrE4rxqESnWy4pntAfq?=
 =?us-ascii?Q?1BULszG91wwPxn9RR841JVUgK3iP0XTnyIzRUs4Gt5FfcdEcUROSFiwLPAUw?=
 =?us-ascii?Q?I8NUTa3mHe10e8xEzQFWnVvLK8v8JKlmb2bIf8rCVv0vZvoD0YnPfYyZALs2?=
 =?us-ascii?Q?5L9ACMSJofx6ErMochNYfLvGkLnaOkKPBqlQoujSzbJVA5tyUxnplyIB8lOf?=
 =?us-ascii?Q?n7BQEglktNgOtgiYn+Z2PR3oH8DOxTFAcDtTcGjR1aU/F0EiMGT8fXjIldX3?=
 =?us-ascii?Q?V2kxiaf3L1gVTRCG0PHhhMhAdux11/y9kvFe2zctoURHQ5nbptDxMEZKE6ua?=
 =?us-ascii?Q?sCxVDmZfubAuLoinx223KJZp/YZxur913KPx3ZpjnlpnDyEjS0sqSqWqUshS?=
 =?us-ascii?Q?x5ehS7P7YieZbQ2giat0W0mNuRgb/iVWAEfVATCirZD/fKmgqaNcXknbRE7M?=
 =?us-ascii?Q?0w2kDDc3R7np0Qm+odoyMLSjqH0n9mwZDTlDf+fLX8AWeoJ2T9C0u0Ih6M2n?=
 =?us-ascii?Q?hfV52EXdHLANL3UOxhsqS2w3GSRCmW5j5xPuSDZlk3pl/5Y7yyk4e8gbOf3S?=
 =?us-ascii?Q?RUb+D0Z0Q7oGfe2EPC1+6GXtIjzCLbTwqkRErXV8Y5+G+tEvPgvXwjCtpR6u?=
 =?us-ascii?Q?34pe4NeeGVGv/UOrxLrZlmwqFa+uPdKDVlctXNu6wejb0xNTaMOEKuWaT7+D?=
 =?us-ascii?Q?3t5ftRB9riLCvBY+Q8950WlCWnEx6yJsotnl6D50eP2XQjkD+YDkdauwOsKB?=
 =?us-ascii?Q?6hUKfExYqu/2wsrMJiOFYXaAhDBX4XykVQzbAQSXk7E1svznzjgiRHrAFmJZ?=
 =?us-ascii?Q?dU2nrCZ4kcU028xovns3AP64LrzatgTqq6wPAJbAnMutDA8U7NeyURBq26Vj?=
 =?us-ascii?Q?8azhaaFDJ9oe0V717pjhZ/kpHbC5z7RbIagmHWH06ZRInkSUhNjKkU89dcWe?=
 =?us-ascii?Q?UDM3ujX+zLuRWC0wWICQ34S2S3zNaa118rARxHwIoY1VGex55g04PXHskA7c?=
 =?us-ascii?Q?QeVStvZFUPffsLcNSEPVx4UQvWPdxkQHZwcJTxkzNi3f0s10H1e8Zng1l2Ww?=
 =?us-ascii?Q?Tu3zsm+xKaoohBAn39pr6kQGoOKwHsjGTzbgB5fXUv55oJxnIfms21pYuYos?=
 =?us-ascii?Q?jpaBltk5SK6EXGrvmMjKynqp4k6M9QHNafXlgYMBpMOT13J8SLfERIgZh4Nh?=
 =?us-ascii?Q?3GVmo6lM0R2Y3rWQe7OA1UrF1hNh2d67PMuaNG4uxHL7LfTfdroOGKp5arEs?=
 =?us-ascii?Q?U5ku8B345gj+GtarQQ8QLCk0Wi9lta4KGNd+lcBblxExXyK2qQtBBgSeVOYC?=
 =?us-ascii?Q?tzjryQNS2EfUZo5Ipfr1R02gnkxKMpjpsJGdq8Ae9fUAGQLPcVX7cmVPs2fn?=
 =?us-ascii?Q?bzeQi1NqiQ2/BRxsBxupXkKIoVUF+/ay7zRd+YO1yn1ybQI/KnB/H/JUcKUz?=
 =?us-ascii?Q?SZLGh5cOwLB/4dE+aI6MloNmYsDemocf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1weQSFQx+s69So2bMPjVH6Rcq0oemTgw3QI5JCVB9o5BKqL3iiUeVoE0OaDE?=
 =?us-ascii?Q?A8InSaqgV6mZHOw+Q3ur3ge4+t/ghGG2l3/Y9kx7tsrASoI6AsrzAsXFkuHZ?=
 =?us-ascii?Q?E8PmzTzvqsH3TkQhC00r0NkobrZKYjsmimhn8mW70zNq/pWMIlf2wsSESkfx?=
 =?us-ascii?Q?vRX34roXhp3x1byGqc7K6Gje9VjAssy8O70EgV0YibnK//AIUaKfij22f+NG?=
 =?us-ascii?Q?pwgtRWo5axBfcFvSrQzuBq/i8giZa1IVo6Q59n22GVPZfmNHP90IL1F+SVRL?=
 =?us-ascii?Q?/xyy5akJlq3By+2Pq0G7P7PnJ+YXHtgL+azRvkS8wyURFgr/zIqF6AvRJw3h?=
 =?us-ascii?Q?tJOuGJpmrj2JTWZdjko/XE/Qaiky0L0+ZAm7pDP9B0goAA8o5ir3tOqH9VqE?=
 =?us-ascii?Q?W/2jVoLBlqklu0Bn2UND5u7rCQSB0ko5QFimkyJJJP2QLV1yHjlubIZ1OB54?=
 =?us-ascii?Q?wUAZn2dxs+JQvWNMOuIDD+UaIjBsXKEYOr2Pz8E2BxalcResYK5nYpCc/2gk?=
 =?us-ascii?Q?QBM4vWSbuhFIw2RTLAWtyrIGhhSKT8UUKSWv6Xoty/opOTIXsOZ8BH2EKZ3K?=
 =?us-ascii?Q?Rumu+iGt2ssFlm2NXVhW747/uKfIODNIOEp6/Cz9W5vCasVUZ+6wCt+1/C1c?=
 =?us-ascii?Q?wdEI3hl4zyxZShPhXAnw1p8sFYfshMbazyhrdSc60s/vdWQzNwbfd7VEtsOy?=
 =?us-ascii?Q?dTNy09TRFun5ioIoBCtS3bu3DL2CZCGyXVeKzMSqUaYjFxeMsyPy3RVS9m5l?=
 =?us-ascii?Q?CWEVT2EIX89KaSITRldVLwtWgrG4aGLygPIU8SXUPuTFHLT6vxHJpKYQRxcp?=
 =?us-ascii?Q?wZgTeUHkA7gty7fEZ8EYU8lyy2+2mgkLjUjrtVM+c8p8DgKeVbGi3OYdEbvV?=
 =?us-ascii?Q?U7Sd/v9jS/2lwXKiDM4jFv1Y2XRgvYn1S6zjJs/jxioUqToTicO8QH9q+oPo?=
 =?us-ascii?Q?af6ACyDs8zv10ietM9XKKEp84NuI4YSXV24K9vhsh2hMufXbfU1E+5Q6U5LO?=
 =?us-ascii?Q?Z2Q8la1GfBv9JY7Vf7mo/UvZrOhAFMDi0IoZJiVmChjl0Mg8nZC/vLvTVW6c?=
 =?us-ascii?Q?ePnFwg6Av80ruJSXLWo4JNuikleeyED/QGTVzPGyzKNauDCukr2naNCdHq4/?=
 =?us-ascii?Q?Uu9r8uJPs2n9xzqPJXgaUkgeIaYsKUO3gHGdsX/zVrudqQAVwzAHkWGlnZnW?=
 =?us-ascii?Q?+ziliXdenlU8zYWzXjOGN9sjQL2AwWY1oG2uoHqo7gUk5FLN6paF2ycQR22R?=
 =?us-ascii?Q?DOi6vpfXkKdeBcN/QV53uk4ySSzjma/A77troMehZQ02oPCXZPWMfJ92Qe8L?=
 =?us-ascii?Q?QnckmQH2d1xA7SfvX+ob+D35UWnb76MFG3wFNqy9TyWA2JP310Xr3pm6IkaX?=
 =?us-ascii?Q?jSXvXpqRcAzyiOrYd1gPNHH4bqAH+3WfFRqElXmF3FdHfRos1icPzUBw+Fok?=
 =?us-ascii?Q?6M/TmdXOSsbxFhJt2ftPl+CGUs1Wf0uwaaaB9Dwmb4dYVSuMMXUK7S30kvoL?=
 =?us-ascii?Q?JoSOVFchbJjNTB8q8RAU5ZU8R0zVqKO5qCMEF0bghtJ2nLoTaPs4Cf7Dm4/J?=
 =?us-ascii?Q?lla2KzU2OOGFoAcPsySxZqh9HCs1Wz/tfwWJWiSRb0lJ3V3LzMmhW9kaAl5H?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0937ff97-6e1f-4f46-f7f2-08dd500ae3d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:56:25.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmzgQ5P/qVgxm82STYsDcVpo9bpJV/0QFH9N6XD20LAjDujZ83FSyM54salYy+P2iU08kLu8cs4Ws5Coju6w79vv4NR0g9gH5zR7rF52VxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR08MB10198

On Tue, Feb 18, 2025 at 09:07:26AM +0100, Takashi Iwai wrote:
> On Mon, 17 Feb 2025 19:38:31 +0100,
> John Keeping wrote:
> > 
> > On Mon, Feb 17, 2025 at 06:06:16PM +0100, Takashi Iwai wrote:
> > > On Mon, 17 Feb 2025 12:16:46 +0100,
> > > John Keeping wrote:
> > > > 
> > > > I'm seeing a bug where data sometimes fails to send on USB MIDI devices
> > > > with multiple ports which seems to be a result of a race around closing
> > > > ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
> > > > pending work at closing a MIDI substream").
> > > > 
> > > > The scenario is essentially this program:
> > > > 
> > > > 	snd_rawmidi_t *port0, *port1;
> > > > 	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
> > > > 	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);
> > > > 
> > > > 	snd_rawmidi_write(port0, data, len);
> > > > 
> > > > 	snd_rawmidi_close(port1);
> > > > 	snd_rawmidi_close(port0);
> > > > 
> > > > What happens seems to be the following:
> > > > 
> > > > 	write(port0)
> > > > 	`- snd_usbmidi_output_trigger
> > > > 	   `- queue_work()
> > > >         close(port1)
> > > > 	`- snd_usbmidi_output_close
> > > > 	   `- cancel_work_sync()	# Work has not yet started here
> > > > 	close(port0)
> > > > 	`- snd_rawmidi_drain_output
> > > > 	   # Times out because nothing is processing outbound data!
> > > > 
> > > > The two ports interact like this because they are on the same endpoint,
> > > > so should the work only be cancelled when the last endpoint is closed?
> > > 
> > > How about the following patch work?
> > > It's a band-aid, but should suffice.  The callback is already
> > > protected with rawmidi open_mutex.
> > 
> > Yes, this patch fixes it and is
> > 
> > Tested-by: John Keeping <jkeeping@inmusicbrands.com>
> 
> Thank you for quick testing!
> 
> Looking at the code again, I think the suggested fix isn't right.
> It still allows some pending work accessing the freed object.
> 
> Could you test the following one-liner instead?

Tested-by: John Keeping <jkeeping@inmusicbrands.com>

The patch below also fixes the issue.  Thanks!


John

> -- 8< --
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1145,7 +1145,7 @@ static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
>  {
>  	struct usbmidi_out_port *port = substream->runtime->private_data;
>  
> -	cancel_work_sync(&port->ep->work);
> +	flush_work(&port->ep->work);
>  	return substream_open(substream, 0, 0);
>  }
>  

