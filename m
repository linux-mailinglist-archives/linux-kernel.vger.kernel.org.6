Return-Path: <linux-kernel+bounces-245189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911D92AF6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27C5B2117E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133212D74F;
	Tue,  9 Jul 2024 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hsYiH6KX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zHWAOH6L"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4D12C484
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502846; cv=fail; b=meoNnq2W2f8O4mnRtDDvXE4EADCeNFAV1Zo2IxVuulSXVXVq1kVIl8J/2VozyabspgolT5+dYotM7+ieBN4NPLuZHrXiQU2CXjs8Q/NYEhoUDpKOBvWB9rz1OYYlKRH7ZcPKwxNdzaXfUt4pNzM68lJV3MXmdXZLAeohulNCg3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502846; c=relaxed/simple;
	bh=+Gyu26Ag/RLUka6XxRixA4fIaHRzESNNyhDqzB63w0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNVYcoijbwPuLykdzBroUyQUGtWGxaEdzXoGV2LwCm2qmqT+BMqBZkT3iePPHcKkNizRr1D93RVrACYNvxkjuUb+NcRdNtsmPuHGFFeFFGX/YemIDYzyncvYUX3b8yyGlFx1Zk/GJiV+sPbccieYSmJx5l8Ln2r4jNhzQ11v2+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hsYiH6KX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zHWAOH6L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468JfWTm023084;
	Tue, 9 Jul 2024 05:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=+Gyu26Ag/RLUka
	6XxRixA4fIaHRzESNNyhDqzB63w0g=; b=hsYiH6KXQLrNvC6tPx+KvhfxC0AP56
	fa77So6bdrh49yRWwMDg4i+bl29Pk8G4z6kUg4ubi9dyW8levUUdLJRseXispEzp
	G4Atxm7U/zmvJAobnnwJi2sAUVpFWqNDceip499xzgtoDenx+6bvtib7thXodb+S
	lgcSvtwj19nwXX/269YMMtsech7IntvtcW65OylHU9Bz5eo/x28/U6x/h0jrXeNl
	l7YPSZhRv/xIhfY66QkPdfmuzfSrcTs8aJ2gRYn055miMqUoojccM7T1Nk1WGA4e
	rqJRLt65uXIADXnPSlO+1JucPh+RqwbIp4tFAJetEEWvtd+SKmHl81zg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8c2eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 05:27:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4693EiB8007502;
	Tue, 9 Jul 2024 05:27:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu2pvsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 05:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsovHMfz051F94kDAlNXF6ScBJVaCoQZLhpGGgwoBJH5+Qaw9lIj2t/RlFne6/Br3Rsi/05AfevX7An7A8z+tmpJDmw9Gg+fGT01yuAtlZJgYZLfowI9S7eDCXqYj1F6LH4EdhqyVgGH/WzOIupTNUjjH7ID9xBdBMSEoILLO8aahUgk6klFx8MDHU1H0QVYvIfT4H9wJZM3alDZKOsbMT0N0qY4w2EgjyiMvuBNZL5p5EjNMzvUgSuFB49zn+HIoAbOCgW1zdvhkb0jGMFx4KCM/4UT93CQYBJ0nATRRRXnSzqXrC4rFnFfIR3KcGVOtE6NJEQoZ7XjMiYFZoXtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gyu26Ag/RLUka6XxRixA4fIaHRzESNNyhDqzB63w0g=;
 b=GEFYAvAxfEcAukLuDTsJZLniDXVHUjVGomfPb5sVn5f2xfU07SlL78DCe8scqLq/q+nIvmHRZXDCgse8AT8iFL1tI2d+tmp9gUkEBSk6R9BMMMqm+t5TvCk3ZE6W4PRTnAFKls4J+XYwHsbibEOG6gLpK8BN9rwoTxKJh/MosTxHAxyEn3Rc4Ta80tEn7C9OYigAMpnpDPYsdlWNs4su1FUAz9LeEvP5pPo3+AhOTVErGRRmFFEd4blQ2Ky/hNrjY7LrrE8wkKzXsfch26M5c77iMHxJYMhg8C6ax+kxVLKNMv760zYDSIbUZi1/J8OkFzCoUcBV8aoKQFrjtwAfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gyu26Ag/RLUka6XxRixA4fIaHRzESNNyhDqzB63w0g=;
 b=zHWAOH6LSk89MO4yCFIAqt23cR6x8xJFVJsvvM4sjbBiam3uOJWXNlKDEZyH6zubo1QDtpy3X4/ryuUWGLtUqFew3lWo5bMDuFoXSp34PebRLksly4OX8M1MCP7dXw51YOEWzC7bCwTgw4tOkaoaXdzplcemxT557pAKRDFkejA=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 05:27:16 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:27:16 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: CVE-2023-52628: netfilter: nftables: exthdr: fix
 4-byte stack OOB write
Thread-Topic: [External] : Re: CVE-2023-52628: netfilter: nftables: exthdr:
 fix 4-byte stack OOB write
Thread-Index: AQHa0bLc1MvUTJZJO0ydj7HfzDsXUrHt2+OAgAAB/QA=
Date: Tue, 9 Jul 2024 05:27:15 +0000
Message-ID: <18f16d08f3946fbee0917f759a855cb070aadf44.camel@oracle.com>
References: <2024032850-CVE-2023-52628-14fb@gregkh>
	 <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>
	 <2024070926-removing-chewer-2426@gregkh>
In-Reply-To: <2024070926-removing-chewer-2426@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|LV8PR10MB7798:EE_
x-ms-office365-filtering-correlation-id: c6e73e5e-2f26-42f6-57d1-08dc9fd7cb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V0hteHZKa2dWc01zeXJ4WEZoQlA0WUFxQTljVEllSEpKVHhjQlllSk5LaXE3?=
 =?utf-8?B?SWxqdVJiQWRibkZ4ekpPM0xDMDNVbGQycGJTbC9mUThaZHB2dmlhUm81dGVy?=
 =?utf-8?B?Z0NXcFRBTWZmMFFZV20xcitFWkFSTGFXVmRhVitoLzZRK2JJbkFDMXNCYXZM?=
 =?utf-8?B?YnYzK1NqamFZSUtXSXZqelV6ZU9hN0swRnZ6NTZleTI1dTYxbDBMRjZiejRY?=
 =?utf-8?B?VndFeFNxY1pKUHRjMmRvUm9uU3ZhdlQxNXM0UnZwdVlCWis1WVM1Qk92QXor?=
 =?utf-8?B?R013U1RaSGJJZ2hmZ0p3aGxFRGNQV1VMQ3dhQ25STTJxVnZFTTRRclBDZ1pT?=
 =?utf-8?B?Y3ZoQTV6aHZBMVBIbG9XV3NWVmxYdTlqaGROc05tRFZUUFd0T1FtZ0x3bkFh?=
 =?utf-8?B?TkVUa0c3TEVRK243ZTVLVGIrdjlGRkxIMmhYTnBEVnVERm1lTTIzK3kvSE56?=
 =?utf-8?B?d0d5ZStoa3NXaXFtZEJDUHJBZURKVEJKYU1vUkUrVHAzVnBmbmtvSnRtZjM5?=
 =?utf-8?B?N05rcDNSRzJINVlwcGZxNEVrbG5iNVdKNnZtRCtuakE0NHdBUzEvcjhscnc2?=
 =?utf-8?B?cmlIZVlWRVZPUEplaDJTZDhpWUJ5bnFsZFpmblVrWVpXaTN1TjFkNm1LQkpp?=
 =?utf-8?B?R3Jra1ZERkxmSFdqY0JjREc5MXByaWN3eW1WQ2pvQ2VwWnZGMlFXUjJ2VDFD?=
 =?utf-8?B?cUl0V2tHeG4wUWl3VU1zUy95TmxKRm1QTzl6WEQvUzdMZ2dFRk42S1N4bk9q?=
 =?utf-8?B?Z25CUVl6YXlVeUlQS0F1aTRvSjcyQnY2ODJuRHYwN3hSVzBDSEx6a2gvTnRL?=
 =?utf-8?B?ZGgwQlhPQnNzQ2dnRHpiR0FIUUF1K1ZzTUErL2lXbTBHRDRLZVcvb3FZaFJq?=
 =?utf-8?B?TE42NVF2VmpmUlZJUnJUZTUwZTFzMTB5M3FOZ2pERnJyTnpOeVV2NDUzdDE2?=
 =?utf-8?B?NW5hSThXbkhITGFMUDh6aWtOV05CNWdVcEl4N3E5dzBHektNdWxJdnRCNUxB?=
 =?utf-8?B?VW1HV3NzQlRkQ2lpL2hwWDlpTk5MYzFScm9temowS0p5dEtDTkV6VDl0ck1E?=
 =?utf-8?B?K3dMSDVoQ09Cak91S25ZLzUyUkJPa1l1eDdmNVB5NXUzdTNtQnBDMEpaTVMx?=
 =?utf-8?B?TkN3bTFaRDNaY2FiNVIrT2oyMEFBR3ltbkJFNUFmV1BUSW52Y0ZITlFVT211?=
 =?utf-8?B?M2dicnZqd28xWkdDMkp2NUViTUlYUVFHQjBwNFNCdlFBMHJPZWhkS3JFOVJl?=
 =?utf-8?B?bTVtRlFPV1dyTWZPTzhrMXRVRG9kYmNMckZPQ0RUZXRQV0txWk9hckdwUFRz?=
 =?utf-8?B?RzhiVk1ZL1B3aEdETldOcWFkY2VaZW1jNUtGUDVvUWJZdS9qdjNqSVpsS0Jk?=
 =?utf-8?B?V1FYSFoyamVNcUd5MjlBdmpxZmZrOWE4emhmeGlZbXpOZzVreEdYM096Nlc0?=
 =?utf-8?B?blhuaVdHZVpHaThwSDR1ZXlUUUpqeFdTaFZxWlZiSnJvQXJpOE1YRHFMOFNu?=
 =?utf-8?B?NmFUWmtMcUZYbkRncVZnenJ6WEltTG1tcnp1eXpDZnJlVTNrd04rUVpTbjhJ?=
 =?utf-8?B?WlI4OFFXZUYzcUg3WDdQOWJZSWlZSkJyb1E0aEoyUlpuMmEraWc3WE1CZS9q?=
 =?utf-8?B?VlJLa2VnMnY3bENXMWpFRy9zQ1VRQ2o2cFJDUzlRQS9oakpGVCtRK2EwSzlC?=
 =?utf-8?B?eTAxTWdlNUZDck9MSWR0M2lFV2M2OXl1bVlVcXNIYkV1RDFZZExqcWM4dFRl?=
 =?utf-8?B?SFV1RG8wR3QydUlqTFZsQS9RSkdtQ0t5cElGYk4ySlJUY3Z6SENadDAzTHhH?=
 =?utf-8?Q?hV3V8CQvlHvSMFu6s2WWbdbHZE3zlHbboECU0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b1BqQmJxUDB5WVJkSHBPckpVUE0veE9OUFJmbU5OY3p3TG1DMzcyOUVtSjJq?=
 =?utf-8?B?SFIrVmNuemFPSHNwNXA1cEdoWW5RSEh5dkQ1UDJaQUk3TUcxbjl2bXFUVVdo?=
 =?utf-8?B?Q0xObkpoR0I3YzM2bDF3ckU3ZU8wVlJvWFh1MFZUMGFiUTMzdjZyK1JtNlNR?=
 =?utf-8?B?NTJwaldzSnpJT0VreWdjSFhhMmJDUjNEUlZOcWphZXAvTC9HT29CYm5WQURr?=
 =?utf-8?B?aHRvNmZOTXNoNXlqOWRJWlQzcGF0bnJoYzdRdGNPZnNvbkYwWEJoMmh5b01w?=
 =?utf-8?B?elh1OFF2RHhScGxWVXBIQXNWc1lYUkxpYjZtY2lBUlRCczJKdDU0cUpqUDZ1?=
 =?utf-8?B?ZU0vUWphbHhYbCtYSEVJVnYxRlcvUTN1MjE3UWlQblA0ZG0wQ01RU2RMNUt2?=
 =?utf-8?B?YU4rSHlrS2htSWEwbmh1MndRQXl3YTJvTCt5YjZKb3ZQOGFDZjgwbnl1OWh6?=
 =?utf-8?B?My82eXdtK2dZL0luSHZZT0VINmpheU1EV3ZnOTM4UGY1M3l6TEVDZWYrR3la?=
 =?utf-8?B?UmRqNVRWMmF2M2Fzd1Z6RmpLNjMrbVoxZEhRaUFLR0JHdk83ZTVWd0pMUm9y?=
 =?utf-8?B?QmY4Q0N0TjFObzloT0dULzN3RXRlSFBEbjBCMVZDY0FYUHJ4UjBJNndxb3Fs?=
 =?utf-8?B?Y1RkVGFuaUx0NXl5TUJYTVdoSWlOQVJwUU1PNVNwTUUvcTRDU3NITXd3RTNS?=
 =?utf-8?B?ZkRZeDJ3bnN2a2FVdnN4WlBYN0dtQU1GWmdBTENKUHU0azlCay93VHhwejBl?=
 =?utf-8?B?WDFJTmI2Y0QzRTBwZmZvOXpCNEtRL2tqVlJJb1dGRWZ0cjBtZzN3a2VncHRj?=
 =?utf-8?B?Q05VWDREckM5RUNvYnlBU0tUMDB0ZFVVUkJuK2NabENMdlp3RXZoUVdid1hC?=
 =?utf-8?B?MXBYeFNqd2RGV3NOK1FwMTV4a1FMekp6enNXZTJ6WTZnWXB5OGd2Z2ZTZjEv?=
 =?utf-8?B?M0FBT0h1eGxIWnU3QjZwOTVCaFZXVjBJbG5qUWoxN0FvTzVqVFVSOVl4MEtF?=
 =?utf-8?B?bUxhMVBPNm9HN1haaWp3R0FqOG9ydDdxYUIzV3FhZ0xIWHZnM2F6L0tmL2xR?=
 =?utf-8?B?c2ljZmg2dHdhK2dUdHRERkR2eTVSeHVsWHNhWkpUYzh6SFNKMndDNXI0cGJl?=
 =?utf-8?B?a0F3QW1ybXZYNTIvOWtUWTNJdW1HczFvYlVDZXp2YnJrMXRwSE9nZi9CUTB2?=
 =?utf-8?B?dEZ4SEJnUzdVN2UxbkI2U1VMWms4SC82L2NYWXJRNk9jaUszWEVnME1Odmh3?=
 =?utf-8?B?N2QzYzYrczVCcVVYMk5keVQ4QXppcmFyc3JCZUU4OG5Oc0svNmtZWFlaM2pR?=
 =?utf-8?B?eVQ3OE9kZDJRU3IrYm9WMDNPbkJMSWgzSUQzbkd6QmplZzlFUDF6L1dyN1l0?=
 =?utf-8?B?RDBiSUJSK29qTmlPMjFuMi9wUlQ3SlNTYm5ETC8rTGxaY3dGbWpxTkd4NHJv?=
 =?utf-8?B?VTh0WTJKN1JPS2s3MWZBQ1V6ZVJoK2o0M2hQL2tnV01Jb1VhNVFTQTFpZCtL?=
 =?utf-8?B?K1dNdzJDcEoyckxFSjAvdWU3UXRTRElCbnRIeE5JY0V1blNyZmlpRHMva1ZK?=
 =?utf-8?B?QXBLeUZhVi9GekRka2NrRHBieS9hZ0ZhSzN6Yi9XT1JEZUJISGFGcXJnZGV1?=
 =?utf-8?B?UGVidTR2RVZZNEtGbWNXSForZ0IyV0RyWUFvM1NrRzJIWDBMUHptRlNvbHpz?=
 =?utf-8?B?TmE0TVNpOUlNZkR0K0FtR2JBRnU3NzFCT0J6M1VNbnhkSFg2aWlLczkrQ2RU?=
 =?utf-8?B?QytndzRTZ3FNektsblFVc3Ewd1ZvSmZvSjRWSTNwNjN5ZkcwbUhwR2pEK0Va?=
 =?utf-8?B?eWhzYTVFVzVIMDFBeDBGVU5KU2lidjU5c29rOXg5ZXVKSHZlbzdpZVl5WXNF?=
 =?utf-8?B?VGsya2hvWWlrN3M4V28zbnEyNTFpUjF2QVkvY0Nzb3IxUmt6MnFQOEhNZEFZ?=
 =?utf-8?B?SHZJdjFLUHFOMUJ4UHMzU2JIZXNvYWtZUGVmK05ucEFsc0pUWmNWNEgzcExO?=
 =?utf-8?B?QUxOWXJxMkVENkNEZnJ5Qkh0bTYrWVdXdys3ZGVhNVBMR1Urb2hVRkxIZWhY?=
 =?utf-8?B?QzV0b05CYXA4NitDQWxZMTlRTnVUUGQvU044RWpCcTFQNjRJcEU2TFVramRp?=
 =?utf-8?B?eVg4eHVpaE1tR3BaNFptWFJzNys4cUg4aWNhNVE2ZUhodjkyYXJpSkFZdkNQ?=
 =?utf-8?Q?r0KfZHQj3WzOZw+a5EfD0GWc6gy/9gWe0LEwF3uCnPXJ?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-x2NfQ7gzQxmmSPuyyqvr"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j9MWybJe1twnLPQTJnvB0zoMSLI0PboJKtriXZZXcNt5gWUzycTE6/FTEFvvqeGA54ecJ6UX9Zoe1kEtHAbcyHkVafiFYGDWwoHCOP3KEadu+KjdHPx+3kCcByxj3reaDXJM/uY526fIFCto5GrcVfNYYQrZRX5u+7SQQOahzXjIeEl5ElwPd91QDocxAOQR3Uf4ON6WSbX8AoYa9n9gPG8nK9cgkKp1FsZJIU3qcWNIwJdX440+1/xJrFNEmYVpesC9LHxJr4PdSdn6RevYvw7Dv+QZ/DFdFbwcxxId85LHqyo7DJmtZsarsAQ9Fewif6BeqhbH4vKJ4CS7W2E4vRY7+KUQkCa2nUC12WlMflAhz9247gWeCLQhIdzCQUD115W2i+WAYjDkqLbS6O062i0VOBx5NTrENtmQG0PKRuVVwUzxT8Fyvmc3AvOjIjdRA0ahsxnUIlB08ZLgR5fAbUJgMWeFpvRcA0dztgbprV9Z+tryFXzSqiHJcW/7l51kua7cI/ehWF0gaxfh9fOGpSHVmUWKZBlEjEDtYhG+lcaKtkz8RdDQqVdxzUiHozIvDMY55wxMIj3TTG8TmLi23ijcmvqr1rsKyphxB7xuHPc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e73e5e-2f26-42f6-57d1-08dc9fd7cb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 05:27:15.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdrSmVJHsp+TJ94beBEZWFjx7plaYLibYU/LpiSU/Rq5xQWuaF4XSq4iXwSr1KL4G8tatDlJZ8sWY1uEyhNCKUtoQhnZ5Om2iHCL6zBNwJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090033
X-Proofpoint-GUID: kwWO-c7Ks4VF7BhWWjpKcW1rxUVldSsp
X-Proofpoint-ORIG-GUID: kwWO-c7Ks4VF7BhWWjpKcW1rxUVldSsp

--=-x2NfQ7gzQxmmSPuyyqvr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09 2024 at 10:49:59 +0530, gregkh@linuxfoundation.org
wrote:
> On Tue, Jul 09, 2024 at 03:48:29AM +0000, Siddh Raman Pant wrote:
> > Is this a duplicate of CVE-2023-4881? It was rejected with the reason:
> >=20
> > > https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2023-4881
> > >=20
> > > ** REJECT ** CVE-2023-4881 was wrongly assigned to a bug that was
> > > deemed to be a non-security issue by the Linux kernel security team.
>=20
> I don't know, where is the information about that older rejected issue?
> If this isn't an issue, we will be glad to reject it.

https://nvd.nist.gov/vuln/detail/CVE-2023-4881 (see analysis
description where it just describes the issue).

Or just https://bugzilla.redhat.com/show_bug.cgi?id=3D2238312

I'm unable to find a rejection reason though, maybe that's on a private
mailing list.

Thanks,
Siddh

--=-x2NfQ7gzQxmmSPuyyqvr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmaMyikACgkQBwq/MEwk
8iqctxAAoe+28LBfTldXrcuu39tZzLFA35vDJ9y2UySRBaHSLjxLUBY9/0l5MoLO
RTwZ663KPtsosKpjhIs0zmTudIqJc1pnRTLYakDcQZw3XlqIOcdrJPVJ8iYJEbvz
xQoxl7yPDLWuuLmFEq+6zCWLCsPSzxl2MFf0Rf/Jlv7yt1H8RbTIDtWDlhun3QO8
dU7ZHq4ROW7Ixm9X7RqpnnS0FscwqBrboxANAWWm2NInLQInrCK5rPUMXz/8+U6O
crAqkp3NbweiR357NnCVstArHJXFDENG6PnvkebYpAca9y+KT/60NxsrH5TBxAvR
p7OErVRcNt9ZcSo42oaEulQIU8TwRhHxsi0dOG9U6+D0U0FCTMlHIneYv4hzh4kC
3PzWRMOYzM0MKajsqe80qCKLbcKjdz5Dgx3WkzBgBzp5GXPT7GOd9lTDzhTbCOjO
J7e0+fVQPmSmtKY6Sye4x7ERsqf+4vBlhCupaIGEQXFR8IU9CbPpqevXyt5MxanR
lXUss08LtyGIBPdsgvAuZfPzpPLjXQwNXWDDDzvgUB+osJY0DqgCsb8uzikaQIOj
ElL0G2VUFaaxM080qmRwyV8mGui7m2pTyMFPb2Cs3uG5/cguYUaMkZZS5pIOvGGW
gD4yyAJwTM2XwzgyJTlZCyXsCv95u9DHVIQFMgsxQPyX0QlZyxo=
=Nygg
-----END PGP SIGNATURE-----

--=-x2NfQ7gzQxmmSPuyyqvr--

