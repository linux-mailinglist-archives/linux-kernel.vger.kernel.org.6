Return-Path: <linux-kernel+bounces-517485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E4A38170
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DE47A2D40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48411A3A80;
	Mon, 17 Feb 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="PYyqdPQ1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14687212B3E;
	Mon, 17 Feb 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791024; cv=fail; b=bgIdivfKT9mkjVW+MAVqYLdQqypsHMK2ly9nGc4l6rWiB3polDoUS8JTMgzJ9grg4uohLPnN/MY3nCRF+2uN51VWm/+sAAeGI83suKJUbh84mT8QFECVgKPi6i7EQbTmRtDG6rsPahu/OiolRx2bVoYlmqxWfXHaqd8AVzFINNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791024; c=relaxed/simple;
	bh=pr1htklzP/mOXf206IXUWBzbYIsE0LtWBHO5amDGuTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZPePY10mz9AiKSHITg6xq1cwC//3cVG7D8c8p7CMsyd4VfSpP2fT9zw2P2pe88tjTza7xAZOuw+NcUKf4BDZFqN/4bOKr78MepmCJ/WnOFrKJKGCArs6MqYKYqhk5dhr0MfbGJADXcY8huBmOLyQVqtMK5vTy5oYTd/18eX4D6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=PYyqdPQ1; arc=fail smtp.client-ip=40.107.220.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUj2R9CTypYdHdhJb7g0N4G3LJLBSR1Ekyj1UMFCEji9/rNb6DOF6KByEEcymH1LekfwVswAzseCiIeLr3tizLYpEXq4W/VlEJamh08TtjC1koTBSNEW1HXaqpCI1b1PZcCYpCMZiX2y1jbCo8EJOCuMU6m5NCaz6qqBQMAtgPuhQOAUgcW/O2B8pALRooY2Qg/ox1MCWe7eU/CD3vxBfNmk7qf+TAJp8Q+09O/LOSbgsEHBfsQKJUbAQ4LPVbSHp5YRX5py2DEw1z3xIEfxV85ADJlafZuXMLsbMpFtwO1rw+pJswQ0Kl3vhjyzGNLsuZTzwm+HkPB9n0bns+6TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d61U9ZcT4Oyi7R5wfpb+SPt9XrUwTxSNB3yUjOz2nFU=;
 b=L6AR3RK1WTS9VO9sht2C6hRn9p+QqCjctP63RMKRXwD1a9uIdSE42SSfvtlYl4PZhE2ujE96VIfZYB2nclHbU3VjWaV/+/XpukuWaj9b1GlBOOMzsd4+JIYbX+VJgkrRNyrc/IqxoxLT/sFXOcQKhhgGihNFo/8Y2ef6j14ODnWk+Kz+q/b1dx0d8xrw83zM5CuTpmBKXPkhBWcXhWgY7j9bJKbKuOh/QPZ9cKRltgVLuekvTAZtgV/JwyhwRKKe9Fgy4KRPdd0OMBA5ufkB7SpCc43DCsLgba29WYiFlxEY4rorHtoNrL+nPwv7z+MoWB9JEwv0x847RGanFAjZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d61U9ZcT4Oyi7R5wfpb+SPt9XrUwTxSNB3yUjOz2nFU=;
 b=PYyqdPQ13f9T+nJ8xBiZU5h/4oP0Sz/qB5qQ8IiRtSmymtRecjLiKPKZxz80uNsTPdQBpGNOlAu20TC/RKWF1A3irpNulLU7aW7UdSVsHzPoPEnkBrO8QEN3P06h6LA83WwQkHEkIsWgcKoDRjrYkn6xLQcFKrsY+7Qk1LrqRzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by LV3PR08MB10424.namprd08.prod.outlook.com (2603:10b6:408:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 11:17:00 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 11:17:00 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
Date: Mon, 17 Feb 2025 11:16:46 +0000
Message-ID: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0614.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::15) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|LV3PR08MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: b710be0b-179c-48f5-512d-08dd4f4498eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mBDQ824EC+E8vkOVTJvre1uKbi8MZhVhBztjjc/0iibx0Ut3XB9qDZ3xzHZB?=
 =?us-ascii?Q?bPfsBXaOn4mDqI1RhfXmxaDo5w63OBazLAiUlNECOPja+8dGnzF0b5texNKx?=
 =?us-ascii?Q?Q9gaiZ+IIU4hN1SSlOQn4Upq8uUv85R6KbYzsSeu1JBRW8S1MWQJHhtccslm?=
 =?us-ascii?Q?sz/qo1RwNDiM6oU3NQm1YyZvWFVB2qcC4nSrsUd95CSSbvBP+GZCzXI87bHS?=
 =?us-ascii?Q?XnEZ3rdmPwCTGrMz8N93f97vqMnTIF5PMtw7avoHhgHMUFp88Fs+dzqXeEcD?=
 =?us-ascii?Q?hIztJ1JDEhJdnBF73NyxkRqjSOeQxCEQP0giUICv9ISdLjHPDjbKdWavYAgV?=
 =?us-ascii?Q?uo6664xt3PAf2/tUCRGAGTS3sGpCCLIkAjxqcJDGd74igd9/AKCZhuGilhI7?=
 =?us-ascii?Q?vpzRhW8t+nfSAllbBqXLXFOrFwTsTcU7YAoJNHTJxigcoaeemff4Po6JV0cY?=
 =?us-ascii?Q?eEDjjJ0Py0VwtZC7zKiKlRXHeNmCaK17rHcrXP3pJfhYKScm93QgPo7qjEg7?=
 =?us-ascii?Q?xXpBy8g37uwjNd6XhOjtsIQywdHo75CqaXEBj1svVxNjahQrveOFOnEI+4HF?=
 =?us-ascii?Q?4zUvUF/QXPAWdHeBRNXxTPmqR5Y59nfaqIPTv4x1RxWbYrPOhjCJ1eVihr84?=
 =?us-ascii?Q?CZ90aXlR162IwUHCCtwpARLtLUCtdrCzUgC6F9SEy0QnfgVLz3R+eMKKaZK/?=
 =?us-ascii?Q?hfpE2D9/s7ab2G9FqJXkTXJbQLxST/yEmLgl7Hrm7GCpzxFlT6j4R6jCKL4z?=
 =?us-ascii?Q?4zLMED9V6M8NjP2aV9b+wPS1zgMnBmhlDZqO6rfQL/KXMi7dfz6V1ixqb0vB?=
 =?us-ascii?Q?SVOdf3Q4H4q6elQdTgwCXy9we6kv1wuBsx5n9005ptdGOXxUv297cZSK1Y5u?=
 =?us-ascii?Q?88gM/VZ7JDquZEgJPDB9+IxYye4GQyC1J8cIWyJPtzq4MJQuJALvJmcn8z7d?=
 =?us-ascii?Q?9xgmw8xZkdutf2+WJ2SkKE43Ryl8PJN8HUrk5LqEcPhGkRiSyELdJ3y7Aup/?=
 =?us-ascii?Q?iSHaKwBJuC5dpHAM7fRfoAVkz0g5OGMnodAcmupyu12N5Ka73fBTFoDJ2+y8?=
 =?us-ascii?Q?k08mlIgyjCta3QVM/fUnoIrjHP+ROHLsnRt41KmqGvK4qHzDwpw0tKEKhuze?=
 =?us-ascii?Q?YkxVy1b6/3pB7r+hY11jaLec7SFey8Venq56080U4Tm9WGLMKtahslg+RfdA?=
 =?us-ascii?Q?ZkALfJ/rjwNM0ecY15MJSwxEUU3+FmPnXBzx5JYp8bXRPMgkjhV3rCjRPu8X?=
 =?us-ascii?Q?UWO/EfCjCCVvvm38241gwzpZXbLlELQ7lF0KeY7bauYg0GCFqOK5Q4mg3qRN?=
 =?us-ascii?Q?/gd4f0vWvsXmqqkhfM5Lw6UGp7e873KzC1Y6oEeBMQut9V8B7QCfNy2P8J92?=
 =?us-ascii?Q?NIRxFo8lYMaWCVQMkXHQ0SiNIPszLkGA//zskXCoEL9s6kxQORY5l7l5XJK6?=
 =?us-ascii?Q?ViPgp4VwMl4DdTLJWJyL7Zo6F667IuMD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w87xD2jOOt1Syvgu7SLb8RWtSv6wM+89ygqFN8bKVCzagyXiWWIXrzhCWjed?=
 =?us-ascii?Q?RDG62RxW3KQXiOSsY8Fc4JT24vKT4wjpt3xwVumTvkAtCRqbi2K5CT4nufl+?=
 =?us-ascii?Q?yt+LTO07zwH19OK1wIvFCiuBqjPP5lzjr9NSIJEK2+kBKsD0apvXFleKczKW?=
 =?us-ascii?Q?HmQ9lQPwy4m90ZW//mEnxFiYvt9HWCtFjFujtwCEuRrWAI3nxvJU7DMznpkZ?=
 =?us-ascii?Q?48EzQ4bK9gTH9beNQXISXYoNtFQ/nnjIvrpXx45fNTfVIGfTB2OnsuTXX47k?=
 =?us-ascii?Q?cebMbd+ELdHmCHTw3bdspsmplsqgMDV0PaGuK2qWoPomJmaj0ZCVdHuB/S5A?=
 =?us-ascii?Q?s5rJg4+UzmljTmPSCM1SnXYIyPuUcx6X7QCjzcGSa6/6pRP2Wg6jBFD1VXY/?=
 =?us-ascii?Q?FaGapb/gkZn16ZLioXkpyR7vaEmWjjwL8734T1GWU7IkUCnGwdHPVB5qsbAP?=
 =?us-ascii?Q?RVHEzJPg3UgmmIZUadb//8ex/a934KIptV2G/NvPVsabkz8qhu/4qrLgKCHN?=
 =?us-ascii?Q?HRfEbtU8Uk2paNuEwpBWuq63P2IdPR0DCA34xopeZKNb+baFz9JMOlWB7YJl?=
 =?us-ascii?Q?OH/VDd20kjipFHmTe+Vq2Y/IMgFEfQyoRCERSuTaEwRWU18Wtw+wEU9mJ8Ol?=
 =?us-ascii?Q?tLPxjaJmgiLcaSkvxUd5BeXWoG7Vibh+wJb7NqBOFFoRqYiL+wAz/1pbmq+S?=
 =?us-ascii?Q?VhYtPUsLw3FEAy3nNGQZDCGb5FCNszBsRe9In9MCdIOZuAFE/sPm3PcJ6Wvt?=
 =?us-ascii?Q?RVBoMnCBtg57DOi0H6wkJZXUhkjwQ4DTKv01xkjpRc60+YbMH2rwLJTcK4cZ?=
 =?us-ascii?Q?G9i3E563vXRU8t9FaHf8qD1ZFtcKQpQk3I2sCc4G+1azl4nTGf9tqYNGbVDo?=
 =?us-ascii?Q?Pqpbam0F4h/RYobnksQ16rVlbnxBoJXlyDQ05t9aPmm/KDWue5ubdQZNMse7?=
 =?us-ascii?Q?gJijGDBOm3z3fPEFXZpOy7F7SS9sb8bIvdbMpXvV7gJfCjPJ8Ou34vv3NXY6?=
 =?us-ascii?Q?8YQQwwutvZ5Y3xx3jt2xTe7z5MejF21u9QgLpwiqZoShYR9dRDkl/1oScGZ1?=
 =?us-ascii?Q?qlOmiji93g5WlqzyVCLsPmKIlEjRl/uDp4oTPWJl3eFM96DFjAACjVV94fNa?=
 =?us-ascii?Q?IIexuTfycNFH7ViiBm2667XyJA3XaYSebGxsqPK/D6ujB0jBUUZ38wHavU4L?=
 =?us-ascii?Q?yzor6g2iyJQOrQSK9kX1jIy9MqThfjjTOZ3D9+X0lD7K1f7FuFNfj6HWqtjD?=
 =?us-ascii?Q?7nwMCpFKrLsHSbp6TJIWHgUJV/rUetg10597Qp9k3HyHUB98qtV779iCkmsM?=
 =?us-ascii?Q?gy2f7EzW+seGL9kkQB1bKOGRIx9rIDvwtIoLc+nk6pBAiu77B1YZhPFw7hC+?=
 =?us-ascii?Q?DremEG0f7x/UN2tcFAHNUAh0gSIUgLK+O5JYewdpVouZiXIz0rhMV3VsSpZc?=
 =?us-ascii?Q?LWM/lsBley62HrtyulG0jVRaWtGCtFSLSn8Jj5cW8zMrS0jTZOiVZGpyf8kD?=
 =?us-ascii?Q?YjuNTCJwgmHW+JXZL+6h5xvwU8uWqLP6vhc5+79No9jIMG7e0IwRzHkxTiGN?=
 =?us-ascii?Q?Yajzotb5NnW5VJD8JSX89/NykT72Y9+ISIrUtAs3QlCUUguSxhBZuVUHwd58?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b710be0b-179c-48f5-512d-08dd4f4498eb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:17:00.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +81VUG9AkwsrqDVaQudfylla9uTxJN5y4T0sHZnUZIEOXp1UwGhIYAKnVIx+tvO8TPT+nC+dKLTF8pw6FDq02OUVvCtw6DqV3MwdPkNqJmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB10424

I'm seeing a bug where data sometimes fails to send on USB MIDI devices
with multiple ports which seems to be a result of a race around closing
ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
pending work at closing a MIDI substream").

The scenario is essentially this program:

	snd_rawmidi_t *port0, *port1;
	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);

	snd_rawmidi_write(port0, data, len);

	snd_rawmidi_close(port1);
	snd_rawmidi_close(port0);

What happens seems to be the following:

	write(port0)
	`- snd_usbmidi_output_trigger
	   `- queue_work()
        close(port1)
	`- snd_usbmidi_output_close
	   `- cancel_work_sync()	# Work has not yet started here
	close(port0)
	`- snd_rawmidi_drain_output
	   # Times out because nothing is processing outbound data!

The two ports interact like this because they are on the same endpoint,
so should the work only be cancelled when the last endpoint is closed?


Thanks,
John

