Return-Path: <linux-kernel+bounces-523507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A8A3D7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03D47A368E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057471DE3A7;
	Thu, 20 Feb 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j3Tt2WSx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bm9rOHp0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820C2862BD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049358; cv=fail; b=WspVmGXD5CJE7MH2Vo7NP6y9M2BykL39biUIi8D61QJG3tz9kR/YwkVK7B9K7PXty6DsvxS8OxHc6pyLwB3X6/Zc+fie6rNjao6mJE25Q7LJShBtBMjcFFvAq2YRtjpTLIXSm1aJpnJthxCnvH43ZckXdM/eautEALa1lNqZfu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049358; c=relaxed/simple;
	bh=ALIn/Bgi4hLrp+acaRC8u0TsA6usJo9epOs38cALDTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXEqXYTXN/Qm35xjgbNjfMmHmI7RIStyHdeJ5ecrOysX4asvET5vIEADesyP8dJHK7DLjreGF3GCPPb83IQMemVGlUdPWWIJBGqx59WOKlxTJQi2kpbw/GAtZrhjJQ5n7pzjF55uQwteMucsn2GxTuos22dz/rbTMU2XiO/iEfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j3Tt2WSx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bm9rOHp0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fbd6001626;
	Thu, 20 Feb 2025 11:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rsfFPuQdQ1152jVutT
	X7PeHLmx6hWYIFzbCjLgxxb8g=; b=j3Tt2WSxVmipFflX7Sm5Y+JX0DPT2GqRdN
	zQSRI5SDK9M/32q+cXQMWfr0PMYF4kPd/0JSDURtGRV5q9QmyHFbAZX/1YEBrNpT
	/8odt7nDrdKi/ZdbW8wKENzv3CC0UiOPDFEXUwxKPozG6gIUPkv+wWWz0G13HxH0
	YpPg5CijH/Oh4uuXL8fKdJz2Xzb7WItcimOsI/hqBdqVsPXfrgRGHXDBTeIuQ27X
	VeleCOHdNxXWp2ExhBOZ1ny9JWNog1eJ12e97meF2FrE134jC2SpnXjG/82Wj922
	ZOBplWdjvgzY8t7F+IVjWDibS+Yw3RQHVt0UuJwUGb6/WPimVoig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00muwbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 11:02:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9UKpv011996;
	Thu, 20 Feb 2025 11:02:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b3qvfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 11:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2lEMmO1gfxHq39y5ApbJ9ikyuIR/baRJ9trkkZ208bVLI8ftOdQbxetO9hb3IjBde22rFEvDHyu5OSJCyLASwf48SDtUMx/cehThho6zbwcEQzHMgcARWZKGL4gJxRbVMS/kUVnWMScWWo0SqvaO25NgFHpkl7EdkKW9sq7WMVRCKjYNIl4zfF1g8uoswOB7LtbMZ/uVCWyvgQEp3fJXskgKHY/+MoXItwEm4ImTk+Cg3FJ/oTynD/oAnatkU5HSImpXXh24iBbGsyojaiK6QDbEpdH4/ZtNCrv91cXwfbzpIb1ZZEcfKptxWZuJDkYGxAjFzZgiJalLIfda566QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsfFPuQdQ1152jVutTX7PeHLmx6hWYIFzbCjLgxxb8g=;
 b=LojqE/nnxd+D/Oex5WbtxUWkR5vdEQgxVL4RANzq4j5yWt34ElsIc3/CEBBYMHSJpR6igbeVtPua0e3h5GeiiGVxwdEarj0xmPC97Wkq+b+iByFU8/3VUIeSTXh2FPAFKlyX6aM+Tx9sGAcUDv+41NiwyC5SxiSJLNIZ4XvTKicWUwuGEj573wixCAWkGluzDYeFicV7AWhrJOz3u/zjBxovGLvfcsd7DnV2aJoZflX4xwEHWVnOA2PM0BmiIZmarXueD7ZENv4Au47WBFxM9R0CUU5TVBCcmF7TamfwL7dIRkudVfgwhOXhRgv+Q1EjPIgACW3jBF8hXiuyX+rTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsfFPuQdQ1152jVutTX7PeHLmx6hWYIFzbCjLgxxb8g=;
 b=Bm9rOHp05FbMsyaRqa9ai7SKKrDrnoUswh2I8X8Xl0zdvIakK3ebCCbD3zLilGfmLuGhczpuYS360Kjim1PfRFpOO7yekaWzfgaR9nWYVuwIYCoyYJlz4NX93IFQMrTzFFc7pvwQJ6SFwEj9OjtTxDQgy32RHm7XzvK3E0isfTc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 11:02:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 11:02:06 +0000
Date: Thu, 20 Feb 2025 20:01:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <Z7cLpWNXSbuKKjpQ@harry>
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
 <CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
 <20250220033953.1606820-2-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220033953.1606820-2-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SL2P216CA0227.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: fc00c9b1-97bd-42c8-87b5-08dd519e033d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssq1mUwL7L26GL777+xlYvT6TFsrHuNeDI+bjog+N1TOYIAGq6+8OrtH1sV+?=
 =?us-ascii?Q?qx0oJevPJ1S4OSrOiT9c9LjgFBVfj/H6GsGgnndzUeM1abGyP+3eRt8MHQoH?=
 =?us-ascii?Q?oMGMAjLWGb0NrrydFJOe0dN7r1vyfzwcfvFp71OcpShzmkNsJXAsRAWOi9mF?=
 =?us-ascii?Q?LU1Sd6kVOcmJnGtrCGAssH/g9+Grce43s6jTneAn5sa2dxsKigRY1LbjK3dL?=
 =?us-ascii?Q?cw03cwwHX+2JIL4H+hya2eMhRXHLXuHJYhTxlSTDqSq5G3QLW6kup5lzcX+m?=
 =?us-ascii?Q?CA2EydjdTq2txeLeRsb8ooHfrRWt2Kq9STfWZy7U/elIrUK7yENxJB4XMjr/?=
 =?us-ascii?Q?p6aavmyKQ5m9kOWpjDDClkbCS5jFkAJy1WQkm3STqCeGxeM+GmFUPF1NZMsn?=
 =?us-ascii?Q?RDsvMu8IG+q/vaUDEmt1ha3C8ApHeII/i1b2aOtgdTkA/LwXjOJD0REkNYNJ?=
 =?us-ascii?Q?bqx1vgbfQ47buXD/EvDnqEBlbyQ1km3rR6kMSH+KZn4Y8MB8cV0BkwK9GMuu?=
 =?us-ascii?Q?+/cSK/O5mL3O9drue4bdUtXDhohKOdi4+w9soKf3jrmLsSST58q7WzavJGBI?=
 =?us-ascii?Q?U4ES3EFexj/fhZVrJJVDcrKQ6Z3iWvaM4N5k8NCizWj2FYRVcEVg1GTExZr7?=
 =?us-ascii?Q?bo0HY/FjR5naE8+vfWE0Ag6e5KREuuTuGZQx+t8dtouKOT/QTusCmnuhG5xe?=
 =?us-ascii?Q?v6PkE+pzxQhbtvuSyAjbN9x5J8xU0YCsYGQ8CPkN/ityidvkKTWZr1sryuUB?=
 =?us-ascii?Q?0eFZBGcY6fzsFDz3inIv46bjyoj2SjaFouU/4RWF+TGxZpQ14DRBbVykYvsm?=
 =?us-ascii?Q?oZd8dwrxiUL3MYMwtn8xxverFzr1ntxk0nazTSqF23k4Tc1e3c2ir7jH9foY?=
 =?us-ascii?Q?hzcpF4ChVmPf76bOQtISie6hEVsJnHhlRAlhMNuZ1PZ+HNqcyKqCwkiJvwEG?=
 =?us-ascii?Q?d/uT4quLn3L34YJ3SfoULfk+scML56k2e4NKXQZMoqnwqXneKZ9DhYk47Vnx?=
 =?us-ascii?Q?4HcI4sSQVtdnyvu6ByE2L1dhaNC5dWYd3Xc63skZC5fvHEKpnvoBV1VmMuwN?=
 =?us-ascii?Q?v1Ti1UPzPW71m1sbA31RQcBj4NcrJnqwZfU2rFpNpNZWtRDslDpB7N09UV5e?=
 =?us-ascii?Q?/HisgJJwRtj3RZp3ZGxHikge91NRP+aZCcwVtj0vtPvG1KQUDBYr2T20UJ9D?=
 =?us-ascii?Q?XVhAO8MgDHtraPUP/AhsN92MG/1Cl0Gfor4joZ4VUrS+a6uz61PeBe4qsacp?=
 =?us-ascii?Q?CW98x/PjBR9mg7Pyqungn4Lt66m6SiAaoFpCGL9q52SRrWITbdIVRYyN7Tz5?=
 =?us-ascii?Q?Lw8ZiNohvlUnnkje6g5fvzBRNbyBr1/nnJll1RIl4Mgh2NhW9+nCpMNAVVin?=
 =?us-ascii?Q?7MbzjOtFcNA6T4tVb1iFWIGgLILa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzkufBjNUf2EJ7N3ikZZJdZfEOER4CZ4DS1HDi0m9pH4AIeVX6+7dTHkBoS5?=
 =?us-ascii?Q?76rpl5XI9H/VSOrGEO98l/XJaocM1zxL3hnnsPNkAJiMzYEtFgM/YYre76Sd?=
 =?us-ascii?Q?r4Cq/BCc/kJfjr6C+a1bT7AI68VVwJek/WDj+Wktw92FfZRqPkTDTA76QVUH?=
 =?us-ascii?Q?atYqZA1fPRz7ayunCToztueF8WOjXDmyIEt4o0o+b0snWbi6QtlkN7RR5AK8?=
 =?us-ascii?Q?zjB7k1GZEqUMGhFvImCx+6M4kKrpiYT0gUcyWkIa3UQ6QvLGdl51M0TEaEuA?=
 =?us-ascii?Q?thyGDq9G9TZk12vzK+SCn8RWhGO8tbMT/BUMTnWf865L9mv12ihLaSot1WsS?=
 =?us-ascii?Q?mpW83v2wRTO+pD/UQbvIltSY+zEdcI6piIK0Iknbvilq6yDNpfTKbzrD6OtB?=
 =?us-ascii?Q?jKaFFNWAqzXvyZajp6R4BYAOD7gVkGC4HtyXI0aRwV9kXaVjDMlNwl1Hv3Kp?=
 =?us-ascii?Q?j5UEPFkGzDwR9u+VeQ88TbhY8AmOcswhd+1nrHqUUscuB03ZD0YuRswkPziU?=
 =?us-ascii?Q?+ZiOCQW9e8F3NaUCurf4xTXsJJ5/YIyCP4GNf4Ajgh1dqEiRsaoQohkJnJWH?=
 =?us-ascii?Q?7JSp4wqE09VyZsp3xRPo+LdRV+SbJLT8werk3/lRpKBAMYdfu90sfD1FAZpq?=
 =?us-ascii?Q?fMuPvUEvcR59RtfyJrt3b4NHwDJ0ZxqmR6M2ttkfTExXp/x01hBrN9EFkX1z?=
 =?us-ascii?Q?zV1KvenhQMYJKrfOGRNCBmAoe8K5yjJPEf3bustctT9af/6MDH0f0FCSni1B?=
 =?us-ascii?Q?yutyXy5JGHE8U9TfhL3UC24WrlOYiVv/EDwRLryPBfk7+ooYZBrijeq+G+z+?=
 =?us-ascii?Q?3c7SdLYP9kV7AQ0Nl9Rg0SQgevdn7i8bx8wJZOR5FyXYpr01HRjljxrVcD1g?=
 =?us-ascii?Q?0gkwO/Ljvhj39Ff0tQQTDeIdG4Ca3j1Xhk+Q6uw/uTQrZP8X70Cy871aN7mk?=
 =?us-ascii?Q?K9yFekDe2/20v4J8PKfrtRZDGQSOToxxiy19DU2muitcMon8sF5UktkWoxCZ?=
 =?us-ascii?Q?gOggKY+QDfx5zdGm1jG6yLdGJdQ4wx645+fV43WQoLiXgPs6Ue5Fm1VU6Wtu?=
 =?us-ascii?Q?FDl3yGJTZ1MjEzAVM0Emzq0Zuq/qQvVBPKs67/ELQtJOFDLmnHa7t+ZeT8X7?=
 =?us-ascii?Q?ip7UKCdR+EWfkw/PXjLKXJ+XydiD/FdKixi7p3d1IX5SZiSBsN69Aqbc/CZT?=
 =?us-ascii?Q?gwZsytB611PQ2VP+H5u5oL0bKca0IiJ9cvixdlSPzI/vXNwN4AeL8H2RXSPs?=
 =?us-ascii?Q?bsssRsK5Anuy/pZ07srFEPzmLvP+P1jn7G2RNSCq54umYQKAuOR//tYsZVv9?=
 =?us-ascii?Q?jdF9UvbrZ7kq7q62BQnKlrUdjNiVUMopPZMo4AcXdpQwb6+Tt9S8uCzIw8eJ?=
 =?us-ascii?Q?JFx/eFBht6VCSeWE5eSmrTKcvNVPpgju4x52KTvZd3Sjyb5o9bz7TCdfbRC3?=
 =?us-ascii?Q?eF4/fY+QX/L2nZ+eAy9PDUNJMZVLxc5M2ZIYIcYmicvJSSbZ9Ve+L0UBxoXp?=
 =?us-ascii?Q?lYeKUwds4X4MOW0APPfgobqU0UBam0eku90n2RCJVVDuYdFX59HR5bUSRqTg?=
 =?us-ascii?Q?FUUzk0ShlFOkt02Ad3jLBQQiYOdsniP9VcDQjgls?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V8wN3Z8dR1wKzD3sDO1awQ3XHNwUnPpx0NuFrFfPR64aK3iS2QGIxhVMevGUYmuFYXjJpT+DFDqDL8fk9yRn9Zx+Ew3JBVntoP8V8cUhPv5u9s778f735IBSQo0///+Dpqg0Wkpvr9ALaieC3DhwRylxO8Oc1WOmZu5IPk+Yg4lJJnK8LpU7e4kgGHgXpytzqMQbKqfUxz/SrArQnA5dJlPLV2aSLbB+eKpnkgtyK+ZlNLdVzlRhtjbRaKk+9wxME2rECYxnm6G7cOWPn2h6/kLsj8oZrCc5EEhhDXgYr9g4fy7gSRm12d+sSr2S67uuNRqmMPsLccM4XJfmLzZrs2Oz0R2C4cJonb+J2HMIAsKPzSfPvaS9oK5O2xoVhiLdtegMCSWzxA2pDwB7AV8vd+qiG+sZySrNrtFynQQ1sVEIGyquNTVp8SiRd5thYigpABnnfUE7/jLKFVoQdXgK9lOf+NRJ1KBRFBYrE6B9/sGm0Mkapf6PJMBZzEurT5bOkA0wzCYR8k9dAlE0XzhiczweInQP4Ysj7ok80Hu4Eu3lm7do9zPnJsSqhaJpbsHAsmPFDh24Dv/CbkB/SsY94NAZrCT7LWDp6aCvFZ/f0Bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc00c9b1-97bd-42c8-87b5-08dd519e033d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:02:06.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCdCOw/iXASoWlrFzTKzMGLRE0x/4XpmfeW/CP2FTj1KFmSY0Vk4zGMJehu+5+49xy600rA3NGvpgDKBn6e7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200082
X-Proofpoint-ORIG-GUID: dqoEH1J3o5Ux0qSQE57wxYymmLDA4KO6
X-Proofpoint-GUID: dqoEH1J3o5Ux0qSQE57wxYymmLDA4KO6

On Thu, Feb 20, 2025 at 12:39:43PM +0900, Hyesoo Yu wrote:
> Previously, the restore occured after printing the object in slub.
> After commit 47d911b02cbe ("slab: make check_object() more consistent"),
> the bytes are printed after the restore. This information about the bytes
> before the restore is highly valuable for debugging purpose.
> For instance, in a event of cache issue, it displays byte patterns
> by breaking them down into 64-bytes units. Without this information,
> we can only speculate on how it was broken. Hence the corrupted regions
> should be printed prior to the restoration process. However if an object
> breaks in multiple places, the same log may be output multiple times.
> Therefore the slub log is reported only once to prevent redundant printing,
> by sending a parameter indicating whether an error has occurred previously.
> 
> Changes in v3:
> - Change the parameter type of check_bytes_and_report.
> 
> Changes in v2:
> - Instead of using print_section every time on check_bytes_and_report,
> just print it once for the entire slub object before the restore.
>
> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> Change-Id: I73cf76c110eed62506643913517c957c05a29520

As previously mentioned by others, Change-Id is not used in Linux
kernel development.

> ---
>  mm/slub.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b3969d63cc04..de62fed12236 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1192,12 +1192,13 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  
>  static pad_check_attributes int
>  check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> -		       u8 *object, char *what,
> -		       u8 *start, unsigned int value, unsigned int bytes)
> +		       u8 *object, char *what, u8 *start, unsigned int value,
> +		       unsigned int bytes, bool slab_obj_print)
>  {
>  	u8 *fault;
>  	u8 *end;
>  	u8 *addr = slab_address(slab);
> +	char buf[100];
>  
>  	metadata_access_enable();
>  	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
> @@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>  	if (slab_add_kunit_errors())
>  		goto skip_bug_print;
>  
> -	slab_bug(s, "%s overwritten", what);
>  	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
>  					fault, end - 1, fault - addr,
>  					fault[0], value);
>  
> +	scnprintf(buf, 100, "%s overwritten", what);

How about moving this into the if block and changing 100 to sizeof(buf)?

> +	if (slab_obj_print)
> +		object_err(s, slab, object, buf);
> +
>  skip_bug_print:
>  	restore_bytes(s, what, value, fault, end);
>  	return 0;
> @@ -1279,7 +1283,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  		return 1;
>  
>  	return check_bytes_and_report(s, slab, p, "Object padding",
> -			p + off, POISON_INUSE, size_from_object(s) - off);
> +			p + off, POISON_INUSE, size_from_object(s) - off, true);
>  }
>  
>  /* Check the pad bytes at the end of a slab page */
> @@ -1329,11 +1333,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> -			object - s->red_left_pad, val, s->red_left_pad))
> +			object - s->red_left_pad, val, s->red_left_pad, !!ret))

I think you don't have to add !! to ret.
Converting from int to _Bool is legal in C99 and it will work as intended. 

>  			ret = 0;

-- 
Cheers,
Harry

