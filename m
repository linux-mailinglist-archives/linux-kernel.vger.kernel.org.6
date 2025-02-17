Return-Path: <linux-kernel+bounces-518204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB381A38B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69687171F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6A23644E;
	Mon, 17 Feb 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="T1jMKcBG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2133.outbound.protection.outlook.com [40.107.100.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6B23644A;
	Mon, 17 Feb 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817521; cv=fail; b=sVQF/Eb4pWMYNV6Istw0Bc0aBL8GybVoGWmPn5YR8fEWbZLbX3r/tmJsdbjxOjdEmLzOrhMP08h3xNpk/tWWvGEmeU3iKbhN+zjUzBResHFaOv0NzEudgX0n5c/tqyXG7Lw3bVx28IpVcl8i9tfOmp2Hn1a0U7xeS9XGoD+2PQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817521; c=relaxed/simple;
	bh=nRBurPu6mVzC2oze+Boo0z1ERlpegH4QsZc+jcqCGrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mb5DH4O11P26mnnOKbOSpcWLjKc8+POqYgX1a94OmI/1kutOV4ZNhNXGWhGWqOsphZr0OwxAlPA5S4K9hQ+bZiHqYGptTzudygRuFrNEdNVuNKbsvjb4VYRuBcScwylByerfdT8J73RTcQNtsnHqhEgiuEd5urw4ewXI6pjc1qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=T1jMKcBG; arc=fail smtp.client-ip=40.107.100.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0cYV2RP1R0UoCrXPOZd+qxy5RLce7rqAhqJZccPvBXDuwYtwTdGzx/2MPlGUnfiIM9NpmHSW8KHTAPhyA7E7St4aDhOsywuxZ5pDxT3Y8tQlKS4L/5dnOpwVxdqjQq19ieb9vFq1gONQERJGaKfR54iFpliCnLBuhg+NPn7tHeRItFb0edbKm5P165r8Q1IRezsifDUx/lRDygSdyA8VRhueU85yLa3DcLKznSqQf9jH5jNmUVqsB6d3C87qe+N+E64VEBPe+JHnmaEa6hxyk695zmBJfIhcGVYtXoxAOxGLue6H04iMh3UFl6+t4zmxEDDfI12tYU7jtniIecYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJkIEvo0mf+shmccQijGtgNi85hXxtPRu4q68330VdM=;
 b=go0AbYrd4j6ghKu54I8mgi3In6z4WuVEzIRR9sUIbTRfDVmsBdp7vSEhlnv/47joyZJOwPeBPz0/GSYNe8EZRXUZKTZz4FXHWGneq5BRA7hmlM4J4cHhgfJzHoUIulRxJUVCMQIydJczLhbHWX71ovdDvCJlQMtH4zoU15x0B+kLpiHTsXRrQ/qLpl2vRz7DxDRyz67Wgw30eM9dzRpt6w95t2Kiz8LpACHImXwXqlyBq2Lo0TE9t/BYlD6AFe8FBJNuLFu/X2e7H/RFSPngWL60XHGw9J3dOrxaRtenkyui+gigcq/lojN8f+UErNoX2Ty6F77W2CiSOB+Pq3ar3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJkIEvo0mf+shmccQijGtgNi85hXxtPRu4q68330VdM=;
 b=T1jMKcBGrORP66KZQssP0VrXdUbThcD2BCGL4CRkL0n/5jAhXeNd0hTzmm2SdAaPOxdJZ0lnzDMQEIymY+ye2wyeFy1Laod+S0Tqa99Mg23juaxt+B85UjfKlTqjxAbHo0IpWYpuXMsw+pBBDULk2vTb+6/FtT7hEdeQlI1NDqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SN7PR08MB8443.namprd08.prod.outlook.com (2603:10b6:806:354::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 18:38:36 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 18:38:36 +0000
Date: Mon, 17 Feb 2025 18:38:31 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
Message-ID: <Z7OCJ2DikMvhAxVf-jkeeping@inmusicbrands.com>
References: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
 <8734gc8prr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734gc8prr.wl-tiwai@suse.de>
X-ClientProxiedBy: LO0P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::7) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SN7PR08MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f997ca-eac5-42a4-c56e-08dd4f8249e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwGgoCCVyB1aGtj2/2Bv1ngFkYVq38mXgLwsd/2282eAbzAhyC81hh5yAMFu?=
 =?us-ascii?Q?zTvz1ZI8rDZwkOiPhhUykB9zIwHlnfoy7dEDP2xndMA9KKpkWX+VEMhbNO8T?=
 =?us-ascii?Q?vn9jYpBfT1dWRlrcoUiGXYJGgPG+PA0wKcWGFhTdTsv7CmCHVE/MZT49dpze?=
 =?us-ascii?Q?ZalGf3u773ivqadBCDQnMzR3Neva92jonGdmWeCg0lsF85M9d9Sdq4cER43b?=
 =?us-ascii?Q?hj2AhjPmfmzFaqX29GP6VHQ7MNBWaGyw+50cnKJJmJzsqXCZuHAtdHiepyld?=
 =?us-ascii?Q?w7oiueP1b9Gh/KNFbQW+zQ1ThV3CsW6RE47xU8Kjp2Uh+c2IRaYpVsXueTiG?=
 =?us-ascii?Q?wOGSagaMOWp6gxTxf2qq2VE870wt4jzt4ZhRMc96nIs7eI2jHbSY77/pv3C7?=
 =?us-ascii?Q?w2tqHjq/9UfR0Eox2qaDutLUqlUkyuXoPVBKsMWHPLO4HO/bTsPjUkBLDynu?=
 =?us-ascii?Q?i7IQ/FQaoVmBZY8utqx5n427yzZo/4QdYBzh9AgjYBaDJ94OPWjDZ0uQhS/9?=
 =?us-ascii?Q?ZFvmoDP38tZwQcy7FJcKrXhJ8SIqROid8QnQGvvVHTyjJXzt6xUHFWalLqFB?=
 =?us-ascii?Q?4tDvveCP11EsPhow4WNgdd/nQR/mrNDgn0z9MrNPpnx1hMEStaYQJ80VI8KJ?=
 =?us-ascii?Q?QMsjX3/eWjNngC9cRzsBPJwLNv92LfmYoMl5ibKvpuwdJFoAEWwLOT3nSIMa?=
 =?us-ascii?Q?/0GIHDyDJw3FuQZaU6Lu7gzV/SZmYf5MPonKPhtdYWLW7YAc7L0e8qrJStDP?=
 =?us-ascii?Q?M9RVxu9F7VCqosUwhF1Zvv4hpJD/hjP4+SDgMCwE/E8emLQmtujEb113xtNj?=
 =?us-ascii?Q?hGhil4RaFTcfzOLOzoSGRxEr4CkmBYXubNJ1EVGyumeEKi6OM+bUmhLXf+Xh?=
 =?us-ascii?Q?KUla6kypv9oMgADr0c7sXfkZyEf/XAQ25dFnE8R7rDEOdt6FVYUuGdwyYmyq?=
 =?us-ascii?Q?ImJ5BIxUeQ6ZbM/lPPaJEp1Fu545wEcRdmapv2F421cUrw/qOSicDFNeWwUp?=
 =?us-ascii?Q?bYC3DAVyzLcsxp3AeZWpIfZKlan7vvmYFlv7By6HNqpbnpnpd7AUVppKMdrh?=
 =?us-ascii?Q?eITpxdjoTG7b77eP7ahOrFsInAf7IHf0dkJFB/hnU7dIQiboBEihVLcCb3N6?=
 =?us-ascii?Q?M24e3D5ysquMXWfV7soRKfC3pPoNIcLmONqWBN3PSnafEpCBUaagBXs6HqW1?=
 =?us-ascii?Q?Cbvybch/8PCM7UaFCrwmJlJ/DjHqmMZJHrHambF5H8IOHpIvcBlZswoTeeD+?=
 =?us-ascii?Q?zBNsQ08Z6xsEY2napx5JA8ycrgVA6aqdKDTyycGhQv/tlCjlcdtoadva+fV3?=
 =?us-ascii?Q?C2cWZbiC1zDlO8LdmzGTF53Tqwpr2Qag8zmAqNaL/x54UXYNfbcoMwhk5Ks+?=
 =?us-ascii?Q?spUWx/xX9T8trkCjgCiQVODHcO5KbvFZ8a+dZ64z6IjFU7tSup7y6X5pCQeI?=
 =?us-ascii?Q?HoUhp3CDxklW0DXvzWGk1tYN9saNVW1z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eqpal0CKsNuaCdqeqdd3jmHKJunOABZdb74uA5HkCcjjmkV9m1rUcP60XAiQ?=
 =?us-ascii?Q?hxTy6auEwbNQboTWLN+Y7Z/RVDVHf+h+OHSlSe5ncV+8INMGR/GYn/dQJLyx?=
 =?us-ascii?Q?x2n/2M3BMiUepnqXtcvLmVlh7YOkPmaYKKM2vUEC9cuN48wSiYjjsz0yZEND?=
 =?us-ascii?Q?WTHFKdcd+V5upyAg1h3NTC1819WsKRKLkFlhHmWa20RXbtQkmh+dOVoDvdZ+?=
 =?us-ascii?Q?jHdW6uwLZGSEN6iIrbkpotHnVk522fV5TBpMtYDv5RD20rGxj+7qh2w93Ci2?=
 =?us-ascii?Q?uORDNpKUCSGxI/Uvj0VlkB05Ib+rE6L9t62zODZ11M7GweF8i9lVPOXY/QSf?=
 =?us-ascii?Q?a7VAfpo2Iq2u7Uf8AFrpx0kbuB5AuaWpImxxGG+q4uWlTEZIKyRVm4IRoa9h?=
 =?us-ascii?Q?ajh0fOU6l30bXVIwKZMtI2r5yOaO77C2gcn5ikPpMtxaVt6dTU+j4qEQDwZf?=
 =?us-ascii?Q?DlLK9VbtNqaUqGe/0IdqNpY692lunh/R8sYj/agQMOk7BUvRU2kklCXPTTOC?=
 =?us-ascii?Q?gX1u44SfwfrKZ/7bfDrYff8aoTW4kNfQgebji5heizWuZo1KlZnvEV86Xtvk?=
 =?us-ascii?Q?A+nuD4x6pw81+9aE64dmgxn/9pAGbOzzJ1TYRnrK1qPcBqqrI3NFrgoCrUea?=
 =?us-ascii?Q?jtzpsux8DhDTceGNMhdYdNGQhNPh0WeNi40PiOPXvRKEEliI3O7/XOG1gXaE?=
 =?us-ascii?Q?uzegwncPMydJhQlbDptQP81Qp5jX1bx2hc1WCM83x46UXDY8Tt0vjC9vG4sy?=
 =?us-ascii?Q?5sIDMwcs2Eer+lI6WC5oYQMGCSGdlsR46GC1F5MDpoyyIQ8EpOOmlL2qrYQy?=
 =?us-ascii?Q?yV0QqmHokwALumG/mFIbO8ZVBR/ndV2rWei/E+Bd+d68CyW4sJVlPYOnGIqB?=
 =?us-ascii?Q?Pk1Rph7khJJDoPgVZZty8KSL6sgNyIF9RF/s2JepZpRe2lvEqv27YX6D7XYe?=
 =?us-ascii?Q?9PzzKJGFDEeDu3txXmJCVE0lxU8yQZPD2fS1IL7djg+o8BGM4ne6LhbA598h?=
 =?us-ascii?Q?nLapsfWtYQ/48DGzwXrQ6i31hxFYB6ss2ZCecW5h9YDxi3pu1KptJEF2Kj4Q?=
 =?us-ascii?Q?1EmRF8Ax045DTnm33vHJ7H7p0T6doeUaB5M5ozI0vjeUykIT+3lCIhA0OiJZ?=
 =?us-ascii?Q?9UJgI5Lg1I3ybhYMj6eMYby3pLNCOJFD2jikn7DO9p7sDmjyNWqBLfBDzwPZ?=
 =?us-ascii?Q?DyOE7j87eovdJgxFtH3b4qsAazugVd1YmxctlcimYl8rrv4PY6AN+xRNrxnR?=
 =?us-ascii?Q?358DuAfd3JiicuBW+E+9+UFmfOMFuI0beK6TWZ6E4OL+UufpkfIQa/UBURal?=
 =?us-ascii?Q?HHKlqHpjVj2IOy3ia2CvDe2YxENFdlffkbVNedJ599YQTW/BtivYXL3eUYDw?=
 =?us-ascii?Q?YXBrujJI3jLz9Dz/MmB98Jr8rIKo7qTF1QW8BdkureVjI9pSOGuZPQRCpDmU?=
 =?us-ascii?Q?J/e4hTJBtQO0iPG0tzzIfctA0j/JU2xNeSpyO8Xvk3/eoOSHL+XbXvGvJQD0?=
 =?us-ascii?Q?px0isuFdbr4bJ9aUzO5tKHgHsMsc53vYutLNAatfWdmOytfpYg7pV+ED4oIS?=
 =?us-ascii?Q?9mTDo59v6sLM6QrYppl5KH7aTVqUW+MXmHWa9GNYNPOZ/US2Sb+MinWlquNg?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f997ca-eac5-42a4-c56e-08dd4f8249e0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 18:38:36.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZtGllUqvxkdY8J2pgQE2Hpvu/w3EEDt6dc35WuldprWL20PHTr3uXREmW6o9JoU+51hpANJgmiWhgY9aLjRHVSccXPB54vm4Xfyb/sB2hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR08MB8443

On Mon, Feb 17, 2025 at 06:06:16PM +0100, Takashi Iwai wrote:
> On Mon, 17 Feb 2025 12:16:46 +0100,
> John Keeping wrote:
> > 
> > I'm seeing a bug where data sometimes fails to send on USB MIDI devices
> > with multiple ports which seems to be a result of a race around closing
> > ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
> > pending work at closing a MIDI substream").
> > 
> > The scenario is essentially this program:
> > 
> > 	snd_rawmidi_t *port0, *port1;
> > 	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
> > 	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);
> > 
> > 	snd_rawmidi_write(port0, data, len);
> > 
> > 	snd_rawmidi_close(port1);
> > 	snd_rawmidi_close(port0);
> > 
> > What happens seems to be the following:
> > 
> > 	write(port0)
> > 	`- snd_usbmidi_output_trigger
> > 	   `- queue_work()
> >         close(port1)
> > 	`- snd_usbmidi_output_close
> > 	   `- cancel_work_sync()	# Work has not yet started here
> > 	close(port0)
> > 	`- snd_rawmidi_drain_output
> > 	   # Times out because nothing is processing outbound data!
> > 
> > The two ports interact like this because they are on the same endpoint,
> > so should the work only be cancelled when the last endpoint is closed?
> 
> How about the following patch work?
> It's a band-aid, but should suffice.  The callback is already
> protected with rawmidi open_mutex.

Yes, this patch fixes it and is

Tested-by: John Keeping <jkeeping@inmusicbrands.com>


Thanks for the quick response!

John

> -- 8< --
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1144,8 +1144,11 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
>  static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
>  {
>  	struct usbmidi_out_port *port = substream->runtime->private_data;
> +	struct snd_usb_midi *umidi = substream->rmidi->private_data;
>  
> -	cancel_work_sync(&port->ep->work);
> +	/* cancel at the last close */
> +	if (umidi->opened[0] == 1)
> +		cancel_work_sync(&port->ep->work);
>  	return substream_open(substream, 0, 0);
>  }
>  

