Return-Path: <linux-kernel+bounces-266290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7393FDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A524D1F22D90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B217CA1A;
	Mon, 29 Jul 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iKrXNFPh"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF774420
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278809; cv=fail; b=sWoXPKgrdjvtltUlaE9r+VTWfjosRiHhPiOs+PHgvy8aesm+xcEIRc3tkpbPeGt642eKZYYlbDlPTM58yEoWv38sg48THQul4LU8ZF4yRFa7VsnYjFPQH9ZoNBixvnVF2lDQuE1xQiV1PnfmwqUCRvkhUx9tNQt6oEqJWtqPXtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278809; c=relaxed/simple;
	bh=vjD+FVDrbdMFskfn+QrzmEmSrxI07oHYqvxLUps4xiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tk7GUn+Ps6TSlejga3xSrSP9WVmdKzuhvwdoqXMFmqh60GXPVGDfyB2Kxihx1et73Ty85th2VmV2o3XDAhAOD6WC9SS2kQfH9lC7TkgZ6lSpjwxPk/ZRQwv1gygjYUGTWafKISLrriXeCBbhanNMssLHOKUkMqZBH1QistSuv8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iKrXNFPh; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TIOUml015368;
	Mon, 29 Jul 2024 11:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=BNvGrkKwHEZveIIFnsSQRKMzc0uO7S+BHJA+Fw8j9jM=; b=
	iKrXNFPhbpZkFmp3xSPW5kR4Yq17I/znTNoxkGSeKxckDxUdDImdTzWF4RV0QXSj
	27wAPe5abqTzbuIqUO7gOaiVMBmJuShChT0QTTalphzfXWxJrCkiABOWoRPsOwS0
	A+RdpJ2A4G19cqc1oZcymaNvRwo8vePWjnGDbnD/pG43tOvITsqSEU3n/Xx8SdOR
	N6nwbCva535YoLk9QEgduLJSSw0uYf6Q6Su51S4/TjEykEcYwVrLNLf5f1/RihqP
	IP+o5S0biC304/xGyecVXPKzHyIR+VCjrA0eUGHtNz0f2a9+7NI/xBt9qCPqOudT
	tnovnZ0/l6LvXjyNhqqvjg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40mxmvj5y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 11:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5J4cg86wHMK9cNH3pw0f0A4TId7hGDi4ISiJ0lG+axWP02C0K78zyo5ufff5FsSshIS1FWL9rnlfJzsoxbDZfAnVllYiBhHpMLUEC49SzYP2IzVFQkKAmUepf864rt06CrsaPOsbXI2OLCA3uKX2ynejYhpIimNdsn5qPWR3UYk9WcsCPHAaNpzrU3fAt9NT46pCLC1ymhWIhOYna+rPfkQCf7rLlytlDnT0mEZBXHzSsLzF8n5FPhwIjwWhehgYDJtV3gQbslAMq/QXtDnZR1nlvCsPuGDgSNSKmLC9rlTpD6eaa4uozewPujZRYAxY7PIoaPJvnkUOpXea6YZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNvGrkKwHEZveIIFnsSQRKMzc0uO7S+BHJA+Fw8j9jM=;
 b=pb4EPsU96H3swsTqcmbO96rjhBGuPnEkwXX7dj9+SnMdQQjfcWcVuAVOyek9iidIP3OmNAYPoeUAATafTnRW66USRPHfCTnFS8Lu9BZID5o2zXnTCajKMWW3FugupYseb06uHrtfU2zhGLfTM5pTkk4cxcS2D1qqlDjfXljTrCpg+KeLDJGR1Lur6QnP+axnqKgTfc+5WhFwW5pAyxRRx9kb6jIoqjD8hQEkPZjxOO8SzKp6Yqg9soAfN7zFLpn4St5LyBcUcVQWXDk5boIpl8lGDGKtTcwSU2qVfB2PwWrKc7S0/2eS0HxTsY5MF7lYBno8nQWhiBsRwufyrlHbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB5130.namprd15.prod.outlook.com (2603:10b6:a03:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:46:22 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:46:22 +0000
Message-ID: <044edc48-f597-46dd-8dc8-524697e50848@meta.com>
Date: Mon, 29 Jul 2024 14:46:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,slub: do not call do_slab_free for kfence object
To: Rik van Riel <riel@surriel.com>
Cc: Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>
References: <20240729141928.4545a093@imladris.surriel.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20240729141928.4545a093@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::33) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: de318fab-215a-4101-fbc8-08dcaffebdc9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxSOVdTN0hPaCtCUWpMMUx3cSs2Z1BPbERqS1VpM0lKczQzSVhMMkJITUhR?=
 =?utf-8?B?aXF3b2Nxd1JZOEFUV1ZkNXllQmM1dlJMRzN1bEZEVVlVbVoyTXRlb0tXVVZW?=
 =?utf-8?B?K2lmZzRwbVF4NkZYWnFxN2gxK0RUcHVzNDhrUnVGRHpoWE9uVlN5K0pLbVk0?=
 =?utf-8?B?Ni9RZ1U3RmlJd0poT1AwR1JrS0hhZEUwT1plcEMzek1XY3Q5TUZXVXB2WUtu?=
 =?utf-8?B?ZWtjZGt3WTlrV2QrU3ptbWhnVGFwTE1IWGN0dllWejFlek5Eek1FZFlPLzFK?=
 =?utf-8?B?MW9mRmt6cWx0RGtYcnJRUmUraTVyc0dNT2lac1RZRmZQK2orWGwyUEN5aER6?=
 =?utf-8?B?RUw2ZzlnQU9SUkRLYzVjYzBMT003NkkxK3hzV0dWcUlmRWFGQ0VHUjZsRkcz?=
 =?utf-8?B?R3FDa2RFNmNxQ0V3WFJ1VnhSTkxxTjdRT0c0Y3dCclVyY1l3cUlsL3JSdU5y?=
 =?utf-8?B?YXA5T0w4OVVybk1tYzlrUS9wOVp3U3JoS2RmZG5Ra0ZUMklGcVBsV1lDaVVD?=
 =?utf-8?B?VzY1ZW15bGEzYUFndjFkYTBXSnNwTVBNYnRmVTc3VUtmRU95T2ZBL3NTWEM1?=
 =?utf-8?B?RTloRTl2RjIyVWxQNTBXaWZMZnlFa0pHazlvV0VhN3B6dFVncWhPditza3dR?=
 =?utf-8?B?TXdGc040SFJYamRXVUI5K0N4OUJTM09yQXE5eERqQVlqUXR6d2p6RmI1QW54?=
 =?utf-8?B?eW43VUNORzVmN2FBazFTT0R3Y2hhbkU5RWFySzJxMnJvNm9VK1VGUEkvc20y?=
 =?utf-8?B?d3JnS3YwMFMyblZ3bTJQdS9zQllJUFQ5OHhOVTVFQ2tJeG9yeGVDNmRNVTVy?=
 =?utf-8?B?S1NWMzA3MmVFTnZpR1ZFd05MSDFvLzQ5RnRGVXBmRUlMUnFidFA1OHVtTVB0?=
 =?utf-8?B?V0hhbWZhWVRhcytGQXZ5a09mWm0rNHplaUVYL2tkcWR3SkZuaE9uR0xhZ2h2?=
 =?utf-8?B?eFFqcldLYllGc2RRNkF4VjlCRWh4aytqdzE1dGd6bUtYblBrVUltTjA0MkhM?=
 =?utf-8?B?K1hRVHlpWWdkZzdiRFpVRVFqb3RGT3FtU0RlbGp3N1FranFWL3cyNTUxY0Ra?=
 =?utf-8?B?RDBIdjVuSEVCTHk3OTd1ank0K1FsUXVxemZwUFFpYXJyektHZDZnSHdqQVdS?=
 =?utf-8?B?MFh2UmI0d1RVb3Y2RUsyUmNKNm5HK3dNYTZ1VjdObnJIZXo5QU9VeC9KK1Nu?=
 =?utf-8?B?bDc2Rm1TYWY3YWFiOS9JdEZBNHVHWldKVTVXUFA5THI0MkRwQXdQVVNmYTVr?=
 =?utf-8?B?d3VSOW9MaDdVUkRabGpsU3p0VDZSYkRLOE5DMEppYUE2empEMU5heFNPVkdi?=
 =?utf-8?B?VGlSMnJDL3RERkxGOEhja1V4YjI3VWZvT2p5dWEvY2xlQmRTeWNrcHhIQnc4?=
 =?utf-8?B?YnZxT3p4Q1hFSUJyeGRYWUdsWnFmMHNyRXIyZGRwb0VkVWJHZEZTUDB0Yk5Z?=
 =?utf-8?B?a0VlWDM1eFRvd0s5U0YxMktFcG5WL3hCNlp6Y2lHdTJlSzRmWks1UkoveFJ1?=
 =?utf-8?B?UFBmaFNKaFlCY2RpUC9XZHJyR0wrUTRDMk85NUtvVTZ4b0RvYTFXMjN1djd5?=
 =?utf-8?B?dFJhMk9vU2RlbkhOUlRlN09WMUhDQ21hUkZaRlFKbS8zNm5tcG8zM1loUnVS?=
 =?utf-8?B?YVl3U3RhK1BOeTluYzJsOVRRbVNXSno0aGl4SEZZVGpualJ2bFJ0RzFxam50?=
 =?utf-8?B?ejdUc1pFOGlldFk2Z3NUVEtLbFFnQ0p5MDNDRHZMU1RlcktYVnVuTkMyZHBq?=
 =?utf-8?B?dDBVdndFSXNEdUlOZWkwWmtmVVBoZmRoYXI3disycldwcExqaGdETkNCNmdP?=
 =?utf-8?B?OW5oMlNBb0pXTWQrblY1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEpSajZ3V0NFNmpyaFovOXNvSUd0UUN4bXBYb0hKbmJUWkVrZGh0SDNwL0NP?=
 =?utf-8?B?Ris1TWNoREZwNXZEcWRiRjNVS096Z09YbzNJZ3U3Ny8wT0tLK0hSanFsR2I5?=
 =?utf-8?B?a3JaYTlBNWduM0pDWUxDaTY0S1ozN2V4Wlh1cGcyTTdRSlBpUm1aUElJUGM4?=
 =?utf-8?B?MGhoNEkvNjlxdEpXeEpNVnN4bmFXVU1yandCay9uUUR6b1Y5cEFNdHRkYldo?=
 =?utf-8?B?V0NLbnZmZ1BJekRPZzV0aWZiR01LcUNHaElmc3h1WmM3UmZXVG1wekxmbWNH?=
 =?utf-8?B?bkM3RXJtWmFhOUVTL0hqeWsxbFE4SllUd2RaMEtWazJQTXg0MGV5dDVhdVFN?=
 =?utf-8?B?Mys1VnRLeHFLaU9rM3VnejBVUlFDK05hMHVCWnhKZ1J6Mk93Qm1oc0xNZUpD?=
 =?utf-8?B?ZW9nZEdGNWhpaWJCc3doa0g1R1VhV0prQTRRMFBadklBeW1pa2xwUEQrbnlV?=
 =?utf-8?B?aWxSNnNvVmxLZFJLd2dvUll2NmpiQkhWcmtybVZkMk4waDhqMDdkWXRXM0M3?=
 =?utf-8?B?Y1g5MFZEVHFzSVRxbkxnTzVSTW43S2VMRkZPSzNlcWFkeDRiUDRKV3UrZ1Zv?=
 =?utf-8?B?OEJUcG5mUmtVTUp4amMyL3lIbzc2amk0enVUWjJOeXdDVjJmR1VYTTRrQTZM?=
 =?utf-8?B?ZE9uRi9yV213OG5PdFNBalQ3bVRPK3FuZ2lJZlQxVVQrOXBneThENUx4eGJz?=
 =?utf-8?B?Q1VPcGlGTW1tMFZla05ZaGZLR0MzeUUyUlZ4by8vWDJNaWZvVjduTEV1RTFt?=
 =?utf-8?B?eDZ3cmdIeTFSa21YK3hDNG1KRE1kOGIyL2JxcEhDY2NsS0lYa2dTV1BuZndz?=
 =?utf-8?B?SFhSY0hJMzRocFdwc1ZDZk04UTRjVVozMnBnWmNjdldWYytxcTNZdFl1S2d1?=
 =?utf-8?B?UGpBZm01K1k5cyt4NFRKcktUZzVDM3pYbDc1aWVzVUE1MFYvNVlLeW0wcFdP?=
 =?utf-8?B?MHVZRStMQklaeDlQb0NxWG9yWVdEN2dPMjVDRnUydUJ0TXZvc2xMOVFDdVRN?=
 =?utf-8?B?ZDVOdU1rNFZEVytJallUTkR2VS8rdjNhWjFkZEdPNG5GWFdtNlFjMzgyVHhF?=
 =?utf-8?B?QmcyVkNvYStDSnpUb0tXbHR0dmUwMCsyelpXTWMxcnBrRjNJdnJQVG5ubVEv?=
 =?utf-8?B?dWUrazZDbFN6ZVZidnlpSGNVZWpUUnFrRVlzdDRydXNMeTVZWVFQbHNhVWo0?=
 =?utf-8?B?UndIQ3U5U2tMUmRUWnhQVEd6U1NuV0RQY1B3ejlJNmlTSk8zTm1UL0lPeVVa?=
 =?utf-8?B?R0JjREJRRVhIWkk0Q2FLTjVkbFp2cFovSDk3QzM1US9ySHhmSWRuVjNsKzdJ?=
 =?utf-8?B?SzBCRm53bXowT3V0NzBXMGFxR1lnS2Y3OFZucmFJTU9xK0hFZkw4cDFmRWdq?=
 =?utf-8?B?bERDeThSRDJSN0VEQS9XQXc1TkU1UE5yZmlHbDRodzVYWEVqcXlPa3VPQnhj?=
 =?utf-8?B?cW9teGpKckZTbUppUWR2dzVFTkdzU2RnRTNWTzJqVEF6aXBLanI1cFhUUzBq?=
 =?utf-8?B?MWVmcUsyY2F6c2Q0UC9jVUlPdnhtRExzZ0k5cGFlSVREM3hkaDc1YUYzdjhv?=
 =?utf-8?B?MGVNSnk4VmVZV0NBK0c0d1VRMUtkelM2ZU9zVEdYcnV2NnNzRlBjMGt3bGdS?=
 =?utf-8?B?aTcvemk1UGNGU0t1Z2h5VktBT29CN28xS2dDcVQ3RklzVk1zRGdMYTZQWEJV?=
 =?utf-8?B?V2t6WXZGM2c5dXc1SEZZU2hsTldyc3ltanRXZFR2aUFUY2NxenQ2cXlSYkRI?=
 =?utf-8?B?RjlXUkF0SUxmbG0yamZJMmJEOTZjTnJIQ0NtNXREQjRuZWVBeDR3YUl2aFRp?=
 =?utf-8?B?UjgzSVlFQmV2TXRla213TkdkYVN6a2NKb1ZBMSthU1RGdmJTWi9raUQzSm9h?=
 =?utf-8?B?c3NCSGl5NVlEdHV3eTI3eGdHVGRLOG9wODN1VFErbTFqampZV1BFeU9aMTMv?=
 =?utf-8?B?OGUxU1UxVlc4a3VRS2N2RVNGZEp4MlJJWUhXK2wyS0xsNWVuc1M4Z2MveFNY?=
 =?utf-8?B?UnJDZVByOFBYTitsOWw0NndoLzFkR3ZKcy9FeHcyZ040TkJqNXJyWmNNaDJ3?=
 =?utf-8?B?THpsSzhOdnZkR0pFVUtOdHFMYnF1SkVRc0M0TWI4ajZvSXlxYlAveVhOTERw?=
 =?utf-8?Q?rdEg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de318fab-215a-4101-fbc8-08dcaffebdc9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:46:22.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 957clNwsS4VhbEeizf8k95neaskcjkuEIMzM6QMQJkILnNEycDS0A1bSi8GyB6/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5130
X-Proofpoint-GUID: OITVgu1XaFcuNm7CHQtVAYm9EXVQb2En
X-Proofpoint-ORIG-GUID: OITVgu1XaFcuNm7CHQtVAYm9EXVQb2En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_17,2024-07-26_01,2024-05-17_01



On 7/29/24 2:19 PM, Rik van Riel wrote:
> In 782f8906f805 the freeing of kfence objects was moved from deep
> inside do_free_slab to the wrapper functions outside. This is a nice
> change, but unfortunately it missed one spot in __kmem_cache_free_bulk.
> 
> This results in a crash like this:
> 
> BUG skbuff_head_cache (Tainted: G S  B       E     ): Padding overwritten. 0xffff88907fea0f00-0xffff88907fea0fff @offset=3840
> 
> slab_err (mm/slub.c:1129)
> free_to_partial_list (mm/slub.c:? mm/slub.c:4036)
> slab_pad_check (mm/slub.c:864 mm/slub.c:1290)
> check_slab (mm/slub.c:?)
> free_to_partial_list (mm/slub.c:3171 mm/slub.c:4036)
> kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4495 mm/slub.c:4586 mm/slub.c:4635)
> napi_build_skb (net/core/skbuff.c:348 net/core/skbuff.c:527 net/core/skbuff.c:549)
> 
> All the other callers to do_free_slab appear to be ok.
> 
> Add a kfence_free check in __kmem_cache_free_bulk to avoid the crash.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: 782f8906f805 ("mm/slub: free KFENCE objects in slab_free_hook()")
> Cc: stable@kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>

We found this after bisecting a slab corruption down to the kfence
patch, and with this patch applied we're no longer falling over.  So
thanks Rik!

-chris

