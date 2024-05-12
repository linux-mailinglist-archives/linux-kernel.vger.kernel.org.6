Return-Path: <linux-kernel+bounces-176952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9118C37C8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3802813D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEB5025A;
	Sun, 12 May 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rl8ILYZZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l2CiRwie"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5734F883
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534933; cv=fail; b=Oel03QWdSm4twBGue3zQtTFTrihDi1GcGrVoNojsMDidUkPpjHK49qBMfVnXpUwVdR/sgKdUED+O1Eu9trwEyyiVMcMcB9YnBPMTpEEQWcJLyTv65S4yoI3aI1qpxwWjs4oUPcnBfeZbo+GtrxwIHauAwV23nrAucqaa14QzPng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534933; c=relaxed/simple;
	bh=fD36z/yaZW8TQNghJ2oAHlHfbLNCgsD2Yte6oK44M+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwqx/o6nk4m0d8J7TPqTdnlOMWdclQ8PvsVZpO6fsZDYLtHCf3Xk6X7zwFxfnBEYcWOYuhj6+QY8zcsT3v4TsiD+7jH2TMlLdMXHOT80hy1KlEKjv+A2PNO+gEYUR9fVIYYk4yuyZaF8XGYxuAis/2AqMBdtDEER37xa1j02woo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rl8ILYZZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l2CiRwie; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44CGsvxl029379;
	Sun, 12 May 2024 17:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=p9o2wBSZQmJmLXjOJqZjSka60qsu5ZwADBFmVFQmphA=;
 b=Rl8ILYZZrORY+YZ+UP10C+0pGbi5k3BRLve7fEiYuyVSYdmDOtIxXi2wM/oM8OkzIf4O
 Hd/bGX/Gx94vtvjVqgg3oRc//9nIRgHNO9GTNM9/6WcOvnCZmmgI3M+bBsMHhqBst+Qv
 QPbcdo/3Hox8lOMQ/AUZYkh8IQh7GdLeyy1EAvMrz5iH4NEZfIurc+k0p1UBJDjQKkBt
 89NXqEztvuVeCXW2uBZ2hv2YjuicKUG5T64CaiNqN0hNK1OmEDas70VlURKAB3SSOSeV
 K4gGZpHUdEsQmE/7J2FS80A/5rZNzki9FzzKKi5mH4l5rWCXgbAX7dH0rFbnx4iKRwFc DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y2yy0r307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 17:28:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44CF0a5k038910;
	Sun, 12 May 2024 17:28:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4b8ytb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 17:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR4UJkPUS7RpJ+9KmbfWFN2y+/tpfdBl1N/GJ2pnX2xBK0oyEBYQTC9NhjZo+820pKIx9BOVIXBTSBeGKB912T6mXUyW7C+lCK4tLJi44qY0jFg383Ggh8FTQ8jWdoaNqq9rByXHTvylEU9kNXFDHrEWpezdg0u8XyRdIE9vVORpY754Agj/0/EMpo39QjA2PwQZmJ3J4RSaBFdAmRQp4JEI48X2/7TjWGoXsoIPiWIFFqoxcdpIGWheh98/A21VctpaBSl+4HxuOnAHMMzI+95U6S6yAaG2pdzomtl8DI2oigCT8U1iNRl5TfTsGeu9TLmu8kcD7jKXsR2U+aRJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9o2wBSZQmJmLXjOJqZjSka60qsu5ZwADBFmVFQmphA=;
 b=hS0Z5nKxktYwfH5x0a7SdOCbHrmUiJVgsyvMYQ0kj/Y3u0ivWoRXqdE6NGWE2/Tn1pzmYltu2IwGYhVeOvalbQuRe3pfHzgKGePUKmPB0v5MRgbVflV10UrWtxUOiSq3Z+aQfNjERVcXYezKmyfdujj3NofQDJz7OlLoBUGfSMSKnw2U8CmNcx16H76PFF31ku4KOoXjJg1vkTTllcTTLTPUmGq3reVP3GHzMD9uJ/nHJkpi7KxYfEQazqxPHY86qXbS/QtzScpgx0IurKqn9aDkzL4R1pLBgiHmUbTGzfvZiwxOuHjS4gHOgU+EnO436C5FrYMtW5VdjCCg0u+CvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9o2wBSZQmJmLXjOJqZjSka60qsu5ZwADBFmVFQmphA=;
 b=l2CiRwienUq9GVLRmrueonMHAaVjJDTgZAyQJ/F8eQAqJMUyVpx9GBTFzWMEFjGR01Yl3OUl3R/pX1Ct81xlkdQ+Zw9Qr4jse8GizelAGVCxOQSL5GL/wa2Nv8U3aqJI7K0lACzJS49P4pbLpmyrM3odLx58Pz4CIB15ck1aObM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:28:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:28:34 +0000
Date: Sun, 12 May 2024 13:28:31 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lstoakes@gmail.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in validate_mm (3)
Message-ID: <q7omtpah3byvo5p3szra7kln63gtas35ml3kksltgj525pyezl@cn7v2o6qf2vc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <0000000000000a13ee06183e4464@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000a13ee06183e4464@google.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 877a5c5d-4b84-4480-fc3d-08dc72a8f317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7cpbyl08RWZwUcDFEI3IxU2CmCzeR/hXPAJOJgTj2XEA5qA/panhDExi+vQF?=
 =?us-ascii?Q?ijKU/rrCMUb0vCsA4ZMGBKA5dlCH/Wp+37jhLMMhmPW/y0XaqGVNNGmU8dNi?=
 =?us-ascii?Q?YXXbrX4In+NeQ9F1AxbtYvrc1hYQTNiH1uphjSBsE7DaBgtgdBRGDLfwSwOH?=
 =?us-ascii?Q?M0XH/4pg7006NwvUzZbOrubVSGYbkh2mYKXX5cuITZOSYInwmhHGiJ8TzDZ+?=
 =?us-ascii?Q?sGWoGwnAqb1eL9nhYjBHGetiK/w1P4vKOi7vcjrwHc/JZ8ETD1RtteDE+iyr?=
 =?us-ascii?Q?LRqfoSdhRWiKESuzFyTqpmlnsoy0c4nDK5ei3obvlv/uq+jqUeIXgL4glEYj?=
 =?us-ascii?Q?Ofx6JAYOboEN5uAN2trDt5QuOukJ+pG8tt1ESGccFFMF6g9S6IgLc8lETUvs?=
 =?us-ascii?Q?iOPmV5VDgwpO4QpeZ+bBTOyxUijxKWdWHcmdwrYGSF/2Wt1gC9/tpyXrtMTk?=
 =?us-ascii?Q?TV72SiwlG0Z1AlUMcMztApM3/qC1gzTixpZOeS6lFvn77Ul97YP9zxmsnCVc?=
 =?us-ascii?Q?kDlOyMnKQEuwj/63YEHtigTRLkO+dSWPPld6A57QCrwaonV+bf6fW0wozC9o?=
 =?us-ascii?Q?xGtOIz/rNhBU8LN0+jpaaJTN7tLfRHAhIXtoFdD42tWlNXdF3ql4nLzhGxMj?=
 =?us-ascii?Q?6IS1tGZK0WSbFuN6eNguocMVntj3jJIJiP1l6iP/MLDJB7TLm2SNmB2fVETY?=
 =?us-ascii?Q?PAhK0OocyVG6SelvtxW3yv5WGrvShQYraEYkUAcEFdONfJfGjG4cpAzWFkyY?=
 =?us-ascii?Q?uxrvqX1lIfdz5w8gfTFejUYsZ+XH3+AISyaQvcDeR3WqX8qi08Gs0AQhXIzP?=
 =?us-ascii?Q?YDINSUM+kBP5Mianmw9p1+ti84rns/LWQkL1MpBud0eQZHNKjZnBOMrrjuM+?=
 =?us-ascii?Q?Ed+hKxbguSKDUtMgEzZ/8Z80TMRtLGVG5AjF/02WC/Yf/G3pTsdYrBFZ/moC?=
 =?us-ascii?Q?k9uWhl5n6q5d/6SPqM33tEg8p6Z0cbzRDVI74RFYKOs0lLTDG30lHXK0o4jj?=
 =?us-ascii?Q?+GRWyEhUbkvpaFw6bnvaIhiZTTF73Klu8A4QQzNgQys+EqUE1RYdrbhBc7q3?=
 =?us-ascii?Q?xaSFP1vJv+9/RzaFmer+IhP3BFoOwdcVNuiNRRYKbud5eFpIBkvPgpMx3fyV?=
 =?us-ascii?Q?xqnwxwlQxPd/iVseYJyx9FwbzGqQEVRwQbsVHe2YWUHeldLpOrpBCrnf2pf7?=
 =?us-ascii?Q?ITVbv+iw2zNaxVfKp3x8fGCjpYcBHyATS0uBuSIBIkHMrBPM03hQ23PHQcs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MfSf2ijgL/ZpKFtc1CTKRKilfs6OBTM6LVwoJzw55Ni10PnOqAXNKDtkPBlm?=
 =?us-ascii?Q?tss4s2cOsmMgCL2D68lPv6CrnZm8CPaWIXK8LMbdRSCItQ3/f+gtL4LMCbR9?=
 =?us-ascii?Q?zqgUVP/pKOW3rUNWQQwXsIsJ+lF3ImpHo+ayMKlerNpk2bKlTV2Tnp1+/akX?=
 =?us-ascii?Q?rkeUBvgLWwHBUOwXsOQvVt+ntnnDmsDw0K26IRkUrPMbytWdNDljBD5QGkgl?=
 =?us-ascii?Q?V6Bh0a2hiRRHgp7mkSYJD6d8m/SnSOetgyrjL9nYyk7/GjI5ekWOib16tXXR?=
 =?us-ascii?Q?Gq66nfUZkftZGHqtvfG2aj1MMbmHFGVv+giwoPLI0o5WAHNdeUrZuv2N5Jmg?=
 =?us-ascii?Q?3mF6QpSWfESpsFggVeGQdrqFZ6n/EV3zDSxEKb+knHzATVHVQbpI2l/lvhrp?=
 =?us-ascii?Q?pFqptbBTAI8gAbQq+f18lMdrv+JIM+bisH54hyIqL1d5TWTRBq6Uf6TrvA1p?=
 =?us-ascii?Q?DhE7IdOMRrJiuyxngPCF0jcAA6yUfe//F1AtYEf9t7vfrpH9qRj6fSRWBlg0?=
 =?us-ascii?Q?N5TgSBd0Zqn9ReROCfC60rMpcA5ZNXpL3Cezzkn6WtcDhlvmV5l39EG4toH8?=
 =?us-ascii?Q?SffjQ9woJhomhsPDyDLl6+NByakuIpLzc+iNYgcy+u++Z45Q62+jkt7Ha7R9?=
 =?us-ascii?Q?ymE0kMj+l1cyxR8fydKSOAGZOeIjtbL5gXeIN50v4dOuC9783iFb2lQR27P/?=
 =?us-ascii?Q?oMLfWyKhId702HYpBM3Y3KxmaYWq1yBaXFW3/pTKkZbNGijaxZfaJma0jb3P?=
 =?us-ascii?Q?h28CSHWMwJazuJBaSs2DlbV1N1K0eh4xIIIUu8+ze4gtvopKS7UK8zkg4pE+?=
 =?us-ascii?Q?yLbLHGr8vnTw/AMySa21jA2J8n8Adv+OFMnPQ4nJE9FKhebqjrntih/ysH1F?=
 =?us-ascii?Q?e4P+xDpSdStPtbcwIXjvJYYebSd8XOi5JD5zBVDqyoZxp2H56BDWhMa6a9gr?=
 =?us-ascii?Q?64KD+0GHUaPBs47MDoUOTzqvB1GvT46aUGqXWSof0swlq1kNCGcNIyczGw1Y?=
 =?us-ascii?Q?ayw7A310sMxVB1pxwRj0xkXu9MxfiH6Kot1WTTQr9EQNXGw+OFCPdFQ4GJTI?=
 =?us-ascii?Q?WP4+0BDD9fEjxZYzBzXbvKVOS/gOuSImxK+CqGW2dBsRpBhaO/ra9qzrdInP?=
 =?us-ascii?Q?PDnBiyDbTa9h2l0yPnR5pXu3VZoJo8NzUKetUeeqWWzJ27KAHsMCf18iPXlR?=
 =?us-ascii?Q?+z7//zbwkDxWtnREa0wEww7gQHTOInBrya5Vh700NvltJDT4TGkEKeHrVbIx?=
 =?us-ascii?Q?5Y2Z9ENeGNhuWRppzWkW1psActnKwpNw//3BFcPqYgt8PPsjJQdGcZkoY7o5?=
 =?us-ascii?Q?lJl/RdLvI2e6RJ9DKrFy/ZzaOIfv61WFkvATL0TuoQae+f7gLJWDCV0qmPl+?=
 =?us-ascii?Q?+WRj1zXlW85OhsBIJsKOGuwWysIUoIb0ldt2+nn0o+sf22qapud39uiEUyXT?=
 =?us-ascii?Q?dU7zmn24d/nPDnB5B7cfCh0lP/ZjLP1Q98wrP0JhBXTt1t3DbvTmGwniE22Y?=
 =?us-ascii?Q?PdwwZa2dphw/f5S9lcdMn4npYlGzB5TWGfjn0+DLbxaezkEEvmXF+6TuCunb?=
 =?us-ascii?Q?VrMLH/Au6HL0pBOUMT1R2VghlBXbhN4Z4Cd7DSe4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fRQAeQfTb2ciK6Ci5VrhlM64FM/M0mp6722z7THOV9Pzo4HVszXR5fw5CPcZpBN1GMq0gWPRBkL1dPbwAxoWiVX+DrY/7D0s3rEhk+04KZcC9CGJBsBph5Z/azIh2KV44SPssI37JFxdmA1G6+fwwW7pKWU/AjTpRIIr9QEjTNlWXsclizGFgt4iofk73nRH9NTzbAyh4WLICgAFJnHngZD5jZNQP0B42T9wQkv5WDwIeaXBpX3DBhIxCI1+nHWOPg/kfj163gj5ktEHTYgTo046UdJH8Sjmuby21R+oMi0nYY0VoPQYXkjXoHHAtl8xDdMIRmQxcOVr/0/+i0/zc1p1zRRBJkdbpf4U9P9ZwkHGhbDi28MXE5hXRcO7FC32gBv4Dg/F7P+dODFH54vMvGY6jd8jfCz3wzUWxjVoHHxAMMqcitF5SuiPgg2D5bVoIqXMfp4bv5HtNBqQwfjQ+hynuCRg/+wAasL1ORJL0Lty+8KijX3qUadOedbFZroQo0d2HSH5XENBj+gmlzmw0iDrKDUSpPVM2TSwQPbLIwofesQOj4Uwk3HcyluyfxTU2Lm1l8YTpm7tiP7hKD0kjM+L83Q6v45gjpOVPBCiYLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877a5c5d-4b84-4480-fc3d-08dc72a8f317
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 17:28:33.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GKZ68ezxWafYVGyVfYpxN0/W4ysIJjbUNYYDOWVHQ4uZSXlHpdBIW0bHYv+iu+alvyVQENcyVDQRR5X8hzAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405120130
X-Proofpoint-ORIG-GUID: Jz87vP9au-f3wP5Hbn-WZj_l3sEMhdLH
X-Proofpoint-GUID: Jz87vP9au-f3wP5Hbn-WZj_l3sEMhdLH

* syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com> [240512 05:19]:
> Hello,
> 
> syzbot found the following issue on:

First, excellent timing of this report - Sunday on an -rc7 release the
day before LSF/MM/BPF.

> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f6734c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
> dashboard link: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10306760980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c8970980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e1fea5a49470/disk-dccb07f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f7d53577fef/vmlinux-dccb07f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/430b18473a18/bzImage-dccb07f2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P17678/1:b..l
> rcu: 	(detected by 1, t=10502 jiffies, g=36541, q=38 ncpus=2)
> task:syz-executor952 state:R  running task     stack:28968 pid:17678 tgid:17678 ppid:5114   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5409 [inline]
>  __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
>  preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7068
>  irqentry_exit+0x36/0x90 kernel/entry/common.c:354
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:88 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:122 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0xc7/0x1a0 mm/kasan/generic.c:189
> Code: 83 c0 08 48 39 d0 0f 84 be 00 00 00 48 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 c2 0f 84 8d 00 00 00 80 38 00 74 ee <48> 89 c2 b8 01 00 00 00 48 85 d2 74 1e 41 83 e2 07 49 39 d1 75 0a
> RSP: 0018:ffffc900031ef850 EFLAGS: 00000202
> RAX: fffffbfff2949b78 RBX: fffffbfff2949b79 RCX: ffffffff8ac92249
> RDX: fffffbfff2949b79 RSI: 0000000000000004 RDI: ffffffff94a4dbc0
> RBP: fffffbfff2949b78 R08: 0000000000000001 R09: fffffbfff2949b78
> R10: ffffffff94a4dbc3 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000300 R15: 0000000000000000
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
>  mt_validate_nulls+0x5e9/0x9e0 lib/maple_tree.c:7550
>  mt_validate+0x3148/0x4390 lib/maple_tree.c:7599
>  validate_mm+0x9c/0x4b0 mm/mmap.c:288
>  mmap_region+0x1478/0x2760 mm/mmap.c:2934
>  do_mmap+0x8ae/0xf10 mm/mmap.c:1385
>  vm_mmap_pgoff+0x1ab/0x3c0 mm/util.c:573
>  ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1431

..

I was concerned that we had somehow constructed a broken tree, but I
believe the information below rules that situation out. It appears that
the verification of a tasks maple tree has exceeded the timeout allotted
to do so.  This call stack indicates it is all happening while holding
the mmap lock, so no locking or RCU issue there.

This trace seems to think we are stuck in the checking the tree for
sequential NULLs, but not in the tree operation itself.  This would
indicate the issue isn't here at all - or we have a broken tree which
causes the iteration to never advance.

The adjustments of the timeouts do seem to be sufficient and I am not
getting hung on my vm running the c reproducer, yet.  I am not using the
bots config, yet.

I also noticed that the git bisect is very odd and inconsistent, often
ending in "crashed: INFO: rcu detected stall in corrupted".  I also
noticed that KASAN is disabled in this report?
"disabling configs for [UBSAN BUG KASAN LOCKDEP ATOMIC_SLEEP LEAK], they
are not needed"

This seems like it would be wise to enable as it seems there is
corrupted stack traces, at least?  I noticed that the .config DOES have
kasan enabled, so I guess it was dropped because it didn't pick up an
issue on the initial run?

There is only one report (the initial report) that detects the hung
state in the validate_mm() test function.  This is actually the less
concerning of all of the other places - because this validate function
is generally disabled on production systems.

The last change to lib/maple_tree.c went in through in
mm-stable-2024-03-13-20-04.

I cannot say that this isn't the maple tree in an infinite loop, but I
don't think it is given the information above.  Considering the infinite
loop scenario would produce the same crash on reproduction but this is
not what syzbot sees on the git bisect, I think it is not an issue in
the tree but an issue somewhere else - and probably a corruption issue
that wasn't detected by kasan (is this possible?).

Thanks,
Liam


