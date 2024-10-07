Return-Path: <linux-kernel+bounces-353177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C19929CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466551F22CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E601D0E26;
	Mon,  7 Oct 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmgQwVRV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XglZgE5J"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C43FBA5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298928; cv=fail; b=fb+G7Sxm6NDvHfDWsTJzgpIWzUypETGpOYw04v4N2KS/UJOkrZJDjRNpjhNM6h+gnBJVF46YtX6UvLo0Mjn5cIQDNW5h1G9vMjVbDAAny+/k5c/PcC6+IMXWYKes49wE/AQbx2IKUFmLcB5QnDrglbGPNhdhsTdu4QUj1RrOIvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298928; c=relaxed/simple;
	bh=FSQwpLIXC5hg++O/lvt8kcgPNwUnpL6OczKnnE1Sjcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=j+7cJpR5g8mBvay4o4TVV+2cekHxn77j7dtol2TzZqB9T6eQ7u7z30HCa/3CwNYD+M6Ajk9P97dQCBCVdVgnNRvaInQRBbCvDVstwRUiZxPfc3iWnN0myIiYrCDTpRzKH5bivCkETytKuKF0OOxWm7DB7gUfEaCj2I5j6rARMXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmgQwVRV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XglZgE5J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4976fbij012401;
	Mon, 7 Oct 2024 11:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=hZSIfkH/dXDkRLMsXRZ/Gd0UOLix0
	WHFODrBnk1N49U=; b=cmgQwVRV3ozJVMxlvdQPX04GHKLApHth+MHbfJuHY2I0f
	uUjim2/8qQtuixZ1ZQ6zYaPLJ8hm23o6K8XoIzGT2nRYTUbRuiwrOD/6E0ABJ6ve
	lBJPe/+wTRz5IraLPyE1iAtg5OgBr+CrKlGVlnLDNaLiLmbw3U1pJXcMboFGbyDW
	N4ziTqWGdANoWFGkMrrqB5j0by0U7saXVcf2a5e02vT05HxwRhL2irVCs8jjgbAA
	nThA5JQKx12YEeUkXz0H9rvNcsQVwaJ4ygpPcnxP0VQ3SFcOZAKJRZ21ff7IaTLx
	gDsqVHoUVqEpm7Q3eTBdQECeOmT7lSBk+SrFS8Ukg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yaeg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 11:02:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Alnef001243;
	Mon, 7 Oct 2024 11:02:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5m98n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 11:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOJTTrA5vMTTfIMOK1mDbhCg/G6FRhhpcbPHGQuHRX2UuVCLXWYRPFtdq05zlQbcr6z/DZac29yxULkbCADMzqL2OGWlkJOVwV2XcCLx7DY+MJla0sZbHzKT6rj8rv7juOX+Dakz7/XY/7G65TexOYyVg8jjxR3Nz/LY59t46U/LPIpnybiOrpx7KNDEEmzC6LizTLUM0Lsul5XpLfjPpLLEEa0pCk97ZP34JE8fZom6bwuMaOyi+SE+8C63u/+svEQAW602xHFZo7cmjBhc5EGRrUHXGsI4j5Di6Z7rA+W3kNnUYTb6X3xyOfU7VKklP52cGyt/yhB0FU5WRxlVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZSIfkH/dXDkRLMsXRZ/Gd0UOLix0WHFODrBnk1N49U=;
 b=qSmJz02Slrg4QBzZcJfwdfZbG9HSnZ0g7s5PQ6r3g9IOUfc7vY8zCSIV2R2r+qHtoGeYMZUCjyceJS39RGVnRrl7tSbnBL7PwqYXv1Vo/FtDSbNoyAAJgYlPyQbctNA7RZok9DdRi02hcFW4tHWuN1KIt5jbDX19lPrr+aiE5Y63xKgZq1IMMt3Q7W7ocHag5YeFgbv3tdw/5wuOlJXYPek6Q26HUmE7akF2LH0Z7aoOI5vyIOzBrCh0A1FbHlUSMhMrui3dOsqtEI4+2Az6cst6a6jPOl+n7oQITvoqAjsQhqEmVboRXO8XaIzkVP8g8k9dva2NLRVuepF2xumRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZSIfkH/dXDkRLMsXRZ/Gd0UOLix0WHFODrBnk1N49U=;
 b=XglZgE5JV0gi19gXvTy9k+xLxWhyQwVOaW1SXiSvqHQ/kpHBcLGar4Q8Gc88s1NdDvriEIokA5bb77uN9gi9txyaRbfEYmDhHRcLRjfj8YFOpgX5N8mCNG63oMKEzk7bX0hqs6C/CEQp6gJtj2qqJILXnla2equ+NTLNXnkm0w8=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH4PR10MB8004.namprd10.prod.outlook.com (2603:10b6:610:242::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 11:01:59 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%7]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 11:01:59 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-42308: drm/amd/display: Check for NULL pointer
Thread-Topic: CVE-2024-42308: drm/amd/display: Check for NULL pointer
Thread-Index: AQHbGKhUED1VoQoxHk+tt3kP+Vjxqg==
Date: Mon, 7 Oct 2024 11:01:59 +0000
Message-ID: <2fc2ba4addfbe40f7de3a5dfb146a3bdd3fc3edf.camel@oracle.com>
In-Reply-To: <2024081751-CVE-2024-42308-562d@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CH4PR10MB8004:EE_
x-ms-office365-filtering-correlation-id: 765c0e51-02de-447a-04d7-08dce6bf771e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEJXUno5NjdldXVMM09FamR1K2JOWDY5alFSU1JkalU4b25scE9tVEdBUHhD?=
 =?utf-8?B?UUhOYzZuYVFiZk90cU1ueUJ1MHJaZ0ZGdkNJLzkyRzN4Vm1GWDVxdkJJemhW?=
 =?utf-8?B?ZkRPTy95TGhyRm1tQUlyNHU2ZFZ3ZjZtNlk5NnhYeGZuQ3l4b0VlTjZSdHBV?=
 =?utf-8?B?MXdXMnBTa0dzSEl4UnNUeVVaNkkzWGFzblMrRm4wdVdSSHZXV0ZjUjkxc2NS?=
 =?utf-8?B?TjRuQklpOWJLRU9yUFo4WEFLTWZIaWJnTGVzY1pmWVA0akhhTEF0VXZKaDF5?=
 =?utf-8?B?aUdwUkR0VEkyTHdVdzBRbGJqY2NyUURqakpWemVzbEdLdFNUbE81K3pMb05B?=
 =?utf-8?B?aVZHbnhaeEYvTWd1WkJ4MHZZMnNpaUZCZU9nVmpaMDhOZm5VV3hKMlBucEpl?=
 =?utf-8?B?ZXlPOXlKaUlscnZ0QThndXhBWmhDYkFmcWU0KytyZzJMYjQ4YUM3ZlQ0R1FF?=
 =?utf-8?B?d1ZxREJJQVo2U2lta1JQOXpoUW1GQWFnUE1hc0QycnE1cEJuU1NoWVhvbmhR?=
 =?utf-8?B?QWliTmVkT0J5NjIzQjdVdzZ0Q1dnTCtoM1lvVHo1U3U3WTFLbm9DcXNTUlpo?=
 =?utf-8?B?WnMrOUNkSWdheTZVYjhvcURlcjh0czlOc1dMVDBSZGh6RkdEZG81UXFTZXBo?=
 =?utf-8?B?eG9sdCtUd1ovaFRQQ1FmczlONnpWcW02cVUwV3oxWEcwczFvR1ZyaUJBUmJp?=
 =?utf-8?B?K2VkcTRFS2dNaXJxZTZQZHNQdnFyd1I3L1haQnNWNmtWN3V2RTRwSzArblE3?=
 =?utf-8?B?dm1jMkR6RnhVemQ0RXdyRE9SQkNiUlJXL1l4V0lYY1FaYTg3czRtczlQaEV1?=
 =?utf-8?B?WWcvN0tWRzhzNHpHYURPMklRZTE0MkNiWjcyRUF1ZElBdWQ2K0RBeTVlKzlZ?=
 =?utf-8?B?Ylczbit0Zll6bXZxVVVvYk9TRUV1M09GZG8wYmNXbVBBMU8xeDNGdjlKWVUy?=
 =?utf-8?B?cEFxUU1QeFpYeEJYL2hxOTAwejJ4ZXVOdjRBQ1kxU2lwRGRQWGYwc2lyNmdq?=
 =?utf-8?B?Rmp0M2FsbDZJbnRNWUhYNDJGckgrQzM2RFZjYXRpeFdFemsrUHdSL0ZhL1Bs?=
 =?utf-8?B?U3FXR0VBVXh4VndvenFmaXhPTllhUDJER3NXL0hNV0NYQVg3MkMraS9Wb2hu?=
 =?utf-8?B?UWhDL0Yzb1BTQTAzMjJiTGVxU1dmN0xtMm5QaHRRV25WamQ1VGtPdGx0bEZz?=
 =?utf-8?B?dHJPQUQwSHVsTS9xWDdIUUJLVERKcTNjS3lJTi8zLzM5bC9MZC9oNTR6bjVV?=
 =?utf-8?B?TzBCOHdySmxDU3JiVkNpZlA0RE9QUFp4cTVDTTFweG9PeC8xbVdkY2JpUHpG?=
 =?utf-8?B?RlBaOUpLVmZ3NU1lcnNvb2s1OFVCRFNJUFd6YXZKVDYrMFF4L29ZQ25hNFpv?=
 =?utf-8?B?bi9sbnQ1NEo4WHRKR0Nzc1BjTjlwdXRzT3NqSnc1bzJxbDNaVXJHb2RScmNR?=
 =?utf-8?B?N3ZGQ2lWbmZRLzhrbXArSWVzbHhyVXFSWTkrWDEvM1FnbGIrc1M4QmFFamwx?=
 =?utf-8?B?cGZibHVnVjVJUU82aytRYkROWGg0TFF3Uk5JOEZlTzBVZ2ZaYzV2WTZPVU5W?=
 =?utf-8?B?S3N5c1I1RGs1UnI4TkVnemJuTjFld25IL25KdnVmeTdoOEo4anYyN0hmK2hD?=
 =?utf-8?B?VG0zVjdTeU9uVkFwdUlqL1pPZ2ZLMm12a1NCY3hNRHVGcG1sUk9zQXA3c25v?=
 =?utf-8?B?bzVlbm9hUGdGS2hXMGxXbENrazNuTHRCcEdSYnVPUi9BeVhSOHJLd2FhQkds?=
 =?utf-8?B?UTB6ZHhrVnJPenprTnVIaUxaTSsvUldURllCQjFYTDIzQVM5amJhcnhvaVU2?=
 =?utf-8?B?VGZHaDFWZFY0aFdCek4rdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkkzY0d2Q1pVYnQ3aEtVakhESjd1VHl3TWxucXExZkNFWHlEQThKb3QzYnIx?=
 =?utf-8?B?WWJ2ZGtkTk5JSHp1czkzenNqU2dQRm1YWDRXNGR1aGM0dWxGdEc0R2FXMlNE?=
 =?utf-8?B?SVZPdEwzTStYNVo4eDBvano0cjlMQVVtZExjR3JwUy9jQzZhUW1LanZzUVBa?=
 =?utf-8?B?WUVEOWJyS1NxamRYb29WOEs3bVZMb2JUZ0E5TSs3ZUxidkNSUXh2ZmxDb1Q0?=
 =?utf-8?B?OHJNdWFFUFF2REpHTW1sbnAxeVNtTGZBVlVDR1lkN0lUZkFpQ2NhRW43cm5C?=
 =?utf-8?B?REU2dWltR2g1T2V0MjJxbmZRT1lsMFh4L2d1eHIwTUJBRUZCNlk2clJBQS9h?=
 =?utf-8?B?WHROUi8rUWc3L1dRajRhbjg1QlZXWkdESHl4alF4bllXb3RLNmxBeW81eHBi?=
 =?utf-8?B?a2JkbC92UVk3WDZrbmQ4MnFGblNyMkM4dXk2eFJ1dU03eWZOV1pJTU1mTVVt?=
 =?utf-8?B?UjFNQTBxZm5qMlNadzJGYWlnVUh5Mk1tR3k1UmdZOGR6U25XZTIrMTg5eFFV?=
 =?utf-8?B?NTAvcXlCVkw2ZFI4bTJ3S3B3UXVyQ3FzdnJMUkxIS3pac3EzWDM5eGFOaGt1?=
 =?utf-8?B?czRUbkJaN3Q1UFcvV1llR2pqbllNcGJaazhjdDBlT2NuRUpub0NaQTZ0US9E?=
 =?utf-8?B?ZUE2dnlsNjlnY2NFRVZkSXI2T25oc3U3M3R1ZHNod0N2bHBwak1ab0V0eC9O?=
 =?utf-8?B?YW9oVHFORXZZWGtLSUdtcGJlcTcrZGQzTnljODVESVY1cjJwNkFqZksyV2Vo?=
 =?utf-8?B?Q2pnYm9pcG9YNEpzZ0ZqeWtnaHU4UDFOREdoQUxJSGZNdDBnV3J4Y1pCTkZl?=
 =?utf-8?B?M24rVnJ0QzRGTnBRWjVnWDNlRWQ3RlcweVVQYVJFdWo1TEhLRitFdWc3Tkk4?=
 =?utf-8?B?dzdXSTMvdzMzS1Jsbm93cGQzMU9qeGhZNFlOWEJ3RDdJdDFyUXFtZGgzS2dj?=
 =?utf-8?B?c0txcHFWZnNwL1FOL0s5WjEzRzBUUStUaWY2U1BTMUNUNHI5T2EycUhFVzRi?=
 =?utf-8?B?R3N1UkZQQ3Bpc3ZWa1FtWGJaV0ZMd1EzS3lCUm54Z0FDc2JRek1BS0lWVC9I?=
 =?utf-8?B?WG56TXhLTFFlY0xsd2xiSlRRbnBSb2RLOXY4d0VPRGdOS0J2M2NkUDhGbWM1?=
 =?utf-8?B?Z1Z6Q3pJMFErckM0M3NucWlmNHJmZjZlWi9sQW1ONERBa2ovRzdwaG1FVHBS?=
 =?utf-8?B?WHkvRWYxaVJQeGFWeTVqU2FnWnpvUnFmMThaR1ArT2pHb1JCRXAzWWJwM1JY?=
 =?utf-8?B?aWo5dlczMjZkcTR1Y3J3SGp5c0R4RHg2cTM0Vitmd2JQWGZrQzMwSjMwTzVt?=
 =?utf-8?B?bGtHWDhuOGRINWJtU2hxTWJiclJLdzAwTS91dDFQTTYrOWJiS3dLYktaN0FQ?=
 =?utf-8?B?UW9WL1FlOE1WdE90OEVyNy91QkVuRWM1Nml0T3FxS2xlV0EzV0phN0U1VmVJ?=
 =?utf-8?B?NUxvOENidzRFUnBBbUNlbjNheUtRS2ROU0k1TkYrNkN4NnNyb2MxUHQ1UE5w?=
 =?utf-8?B?ZEZEQzVUV2grWVBqelRhejhCc2hHTEJaNWVQdHhzNm12QWtZQitlQW5jMUdT?=
 =?utf-8?B?YWs3T0JBNlRESVViRkl0OExjLytvbEJGMTVCMkVtZDFGQ3JkZ0IxdURHSGxL?=
 =?utf-8?B?NSsvczRpZFcxRndMWWhuUldyeTZxUURLSUh3aEFSMW0yencvcXNKR253OGZ1?=
 =?utf-8?B?dEJyNzFLdldWQXM1OTYxcm1iUmk1Q1BoMmlmRWp5RGlkMUc0Tmt0L21IL3hE?=
 =?utf-8?B?OW1iS1hvZ2JCZnZzVDI1eU1JSTdmNkx6RXlEcjFVUmhDbTBVTHJJWHZndE9q?=
 =?utf-8?B?NXlPYVRKK09XK3ZhQUJYRlN2b0VTV3kvVXVWekVJa1VWdkxIL2xwMDE2NGFE?=
 =?utf-8?B?TnpHbThtQ1l2Q08zcitWOVNMZkVFcFNXMWU3d2JNQ2ZCZVd1dU53d1U5bGlE?=
 =?utf-8?B?QUEwUDE0V0VOdkdySmpkUXIwRkJwak1jV0c5Nk83OWtBTGcrcTlFY1FQRDhX?=
 =?utf-8?B?QjFLYjBRdTd2b2ppc1ZzazFoM3ZNVDFnZVNPZzRMR2JYdTBQbnQyYVVoMjlM?=
 =?utf-8?B?TUxEdjNFeTJtNEQvTWhrNFQ3YzlRN3ZsUDZpRnh2ckdQSkZHN0d2Y3FyWnpV?=
 =?utf-8?B?SUdSb2hLUmw1WjVVR2F5Q2RTSlMvY09sSTJQV0FxYkMrTjNLV0R1S3F5WmxI?=
 =?utf-8?Q?leIL7DunQINeWZaBRGdjEM64x48ViYB7Ln9/tTSBziqh?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-g9TqWuCSu0uykMIyvse0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4E5H7lxjGfxv4li2BcgwTMS6seJAtQXL5Z7tjDk1OYGuYC7CKOrJAYjRAxe8yPhIj9NiZz8WBFs+E4yfE2h4TFoktGyvH7rWG5RsUjHAXRpmdn+gKbFPxxuUlYoc2i5+T7SiaSAVUXnWPZKUQjv8KhEFVMWKRLulGhy167/q5wixj96GBN/+NIirOVjcS21BCkp45/TT/IcgNO0Rq6bQKEw1rXIJ2iV8CJTfrIhXDwoY8lo08K+hMiMmjD4uFIRxE1jkwiNfVa0JQIcgA6COG31uqoz8va4uiLBFMURgAfpVg736xgW3ZKxV13KUQVI9JDEp3HmIpZ0oNYLQFVDQAqdPMWgXNJDxuvN84cU3Yo0fSI8RuHMlLfC/6S1ZFHshSB1iKuKKa5emJzr9SX/3hQF5+PW/QlFZQIfaFDP/JdDWbGY5kTYmQft4z22DiAI44DW8hZHx1wtqbitVa303aEkEIocHa2HlxS0rKL1/wBbDMQQGAC55kZ9W5h3Jd1ERY4c9/OI1WNUSRxyxCY5r858ej/UrANMuMxVTKrNBXJ2O9akXVSTu/Ui6WyY71j2aEoh5sgA27j7cAADSjvLhDCPlH6U2ssIv7606i6ThFNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765c0e51-02de-447a-04d7-08dce6bf771e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 11:01:59.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkd9im8zqIw+YOQFbun1HB7jDF8pfNeX/Y1Frhm6ahDfPVCWlkY6sfWWOG4JEDXk+g2aCPro01LSNV6okgBP6WQ42H/TWVixxqzDAS/Pfec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_01,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070077
X-Proofpoint-ORIG-GUID: MG2Ow9TURst29wo1IYJ3TcNvDpuTe495
X-Proofpoint-GUID: MG2Ow9TURst29wo1IYJ3TcNvDpuTe495

--=-g9TqWuCSu0uykMIyvse0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Aug 2024 11:10:13 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> drm/amd/display: Check for NULL pointer
>=20
> [why & how]
> Need to make sure plane_state is initialized
> before accessing its members.
>=20
> (cherry picked from commit 295d91cbc700651782a60572f83c24861607b648)
>=20
> The Linux kernel CVE team has assigned CVE-2024-42308 to this issue.

This commit is no-op / doesn't make any difference, as there is an
implicit NULL check rigth above it, as plane_state cannot be NULL
(checked at the start of function).

So this CVE should be invalid.

> Affected and fixed versions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
> 	Fixed in 6.1.103 with commit f068494430d1
> 	Fixed in 6.6.44 with commit 4ccd37085976
> 	Fixed in 6.10.3 with commit 185616085b12
> 	Fixed in 6.11-rc1 with commit 4ab68e168ae1

This also got backported to older kernels.

Thanks,
Siddh

--=-g9TqWuCSu0uykMIyvse0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmcDv5cACgkQBwq/MEwk
8ioBkRAAhlyw1oRFi+yy/Z9MztWop5zl9fo02RUXNGlCCFjom4LBB733Pu1TY9Wc
Ns3k/o6T643BTNQwiX1LvH0G2uGVBKaeSzoyWrlVl6+m3j0N4WAEbPEXcQ12Hx53
xCQm+2VvIyE4ABvVbeHM9qnyJ6J/hPHAjKB7c1TKA4whz5YDUH+BSrbNXycoDacS
CQdE6RHZ6yWlz8teleADKDyqDOGX/nod1C5GkQO+Myoibz2wgU7CBzNdLGDVvyh5
RYQr/ReGiOEHHJCx1hAbcSruhaqnYns+FaIWRk9p71wayQ/ZGuknED/EGp3yPQ2Z
ejrwjmd/pjLud/2yeITZIJhaWOFxgVOF60UQ4mvw1ND43yGziypGBvAYHJcPGNb3
xAi8R28GLHygff3nloB+pEScjOuC23GfFBZYBpvZrKxdyKbkDIRPAsrIGQELKmLv
8/gi3UNQnk00HJZdnohGIcz036nAR7KyNMgvEwMMgrHqmYpAXY6Wgcog+XAtcGcc
Wc9p3KiDkr6ENAuQ2WUe2ReF8a52n7HcQUKH+8BHD4vclmPIbe/cCTFrCDhCKM0i
9PQv9adUv82uaa5R3thEscz6UVPFu0V5/LCVGLvj3l6ZU/X+2ImPC3YAD5W8ZQg7
+2Rh5/gJ6pV9f/hF1XYUJgzx/k/V+LUF8CQ/NmZOEuGRtvP4ztk=
=zrCZ
-----END PGP SIGNATURE-----

--=-g9TqWuCSu0uykMIyvse0--

