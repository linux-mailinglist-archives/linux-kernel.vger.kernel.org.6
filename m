Return-Path: <linux-kernel+bounces-399798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AE9C0457
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6764281FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33420C035;
	Thu,  7 Nov 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nXkZCCHH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o3DXUqnw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5C1D95B0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979697; cv=fail; b=rurhpPoFBKM3ydogrED++wYBQR7hvcsUd8Yw20+Q6CLVidGf5vYaoQwhBvmAIhbencDmWsPMRN7oal6aqFImGGF6qf6EqQD32CE9sUjSPxUByruwzY9rZb/FeRkqXV5RofVKbaQkOPge0hLE7MiXeWkVHpiKWFVBFYJwg2geM50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979697; c=relaxed/simple;
	bh=LxRclAQMRfxUU9ao0oZEBDy4X47GIRHbIYWF8lTRZc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbieteF3FMPlazrhq0lnwEOFtgKgXvoo89/TjfCrLos0mmVri+/HDFDuHvmndGMWDLgoQ7EOXGZNBSbX3YngFOmFb/fZTAW5AAvNEFumPW6K3CqN7f1nKjt2/iIqpEFaYuGgL+g1sVBfAoCFZixfpLjWCj0UlnWe4JGZDJa6Lw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nXkZCCHH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o3DXUqnw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71g810002800;
	Thu, 7 Nov 2024 11:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jzLqxztggBr222SOlkFRHRqyorAqoNrrh1mX5rpgJtI=; b=
	nXkZCCHHVNQpFyshPLYJF89YvdfcdMxuBejkhRq/vi8LOB2AsZUq8pLmT2J/Vscb
	mn/Mng8qXzKITixwKuD7Z0U2udLCs2+H1Uj3H/TYe1aKpYJbQCwGLxEKaGopWvl6
	YGxGhIRwQAgUpfahux6fl1GhdUJKyyo9A9m6P1TJ/WGQqSXvhaOWD+pSE+7plXb4
	PqWjWPd3donWW4eNUFZUCQz/AKQ+sr4nXAGPCbxI9WA6YggDSrfNH8EAQwDWt0+l
	1mU8tOADe3sDlKhsly7XKjsaYWai8CSSH1MCELoyYqGe26dktED3b7XzBX6NHhZT
	7xIJbBvGjFlgwKyPv6z5sg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c2bb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 11:41:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A79XjKp009749;
	Thu, 7 Nov 2024 11:41:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahg7j80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 11:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gekaPh7thv4PMNvGXyQePlUSYkbXFpxLzZoXewCkX6qteP75DnomlRFS2UHIIqT05dsZwmMOlbotHYMnhFWm1WjRNMPknL3S8cDybm2ADWGAcHK90JqO0gOfX3xxX0Ks8fWKjEVSyQYgS3GG2G1mVCcU7OOnnAsK0jRGVc3OgLHPjmMZTCN7RH8kl7r9RFaDhQmIljetzZC1pVfuEN9WLbMqH30w/APdgJd1OuO3+NKiAzGIgwNzKw7KVFcl4eNNMVt5PwN9bgFdo+3HwLLbQQHv6AKXhE16QLfixwd0FDdRI6WJpYSJLiXCP7cyPVyfaj906OVjPAwyyJzp1tjuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzLqxztggBr222SOlkFRHRqyorAqoNrrh1mX5rpgJtI=;
 b=aOYldhIPiptg7AYCIh71FnhYKUc0q5VhAxijw9is6AEUmQksEBz/vqtqM/cnbdplRVtzlc9eKb5Elbvj1FHYizXKKa9g0EdSaNXQRbdWtoLpvis5J87ADaZ+q6aAKIybC8TKpIJjIATe4o3KlJ7+LgfcJjh6erRmLUJH+dwasU/7+MRKGwQ28XxVLyeF2mCwV8u2q081JXDjR0mJhIKlg7Pu6K+49PaURep2qFrnVfiDkZFVB48MAIDccg+v2illxUjytC+XgyQyQzpb12+WYuT/zJa1a7B92uFKIfr9GpmztALQNA7iGktlY9FbNUEkZr0bfLI+c9UUpgHDUgBcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzLqxztggBr222SOlkFRHRqyorAqoNrrh1mX5rpgJtI=;
 b=o3DXUqnwPgbZoW0UOFzIftPqD6t+z43mB8LGbJ8zBuj34v7wTTLsupyINkHIYJF+1R4dZIuXnGTF/CS3hgUYwit2t9l6PTL6VolSX304wundNLcWFBBHrZ9I6ZHo31n54HBkXMqFKyWQPNUD3PXfZkDG08oJ3IKygssjNDAm0wM=
Received: from SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 11:41:15 +0000
Received: from SJ0PR10MB4720.namprd10.prod.outlook.com
 ([fe80::7ac8:e778:e4b7:13f0]) by SJ0PR10MB4720.namprd10.prod.outlook.com
 ([fe80::7ac8:e778:e4b7:13f0%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:41:15 +0000
From: Rudi Horn <rudi.horn@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Aruna Ramakrishna
	<aruna.ramakrishna@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Joe Jin <joe.jin@oracle.com>, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Topic: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Index: AQHbMHpucV7Hizrp2kqRQDNKin6377KqosSAgAEFPvw=
Date: Thu, 7 Nov 2024 11:41:15 +0000
Message-ID:
 <SJ0PR10MB47208C97D877C27053E546DC9C5C2@SJ0PR10MB4720.namprd10.prod.outlook.com>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
 <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
In-Reply-To: <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4720:EE_|CY8PR10MB6779:EE_
x-ms-office365-filtering-correlation-id: 1fd52296-1a8e-412b-d56a-08dcff211644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UGTXohr4fMPv84qIuHO8kc29H4Sxd6PnBw9z9ZBPTlKS0KBlG0NWaClkdI?=
 =?iso-8859-1?Q?stXHbMTajnnrG2d4I+Rp5H65nTXiYvHfRmpHVJfo5sGKcK4E9GVYa1sHYW?=
 =?iso-8859-1?Q?5BjEEWG7Vazm72qCgIsF/wmhTlJFJF/FsmBKJLJg2U0AcQzSXLbCQh9tbZ?=
 =?iso-8859-1?Q?i8V8oGV35QY6Rqs4cYdGrPpLTfkPklP6uckqe+rF5y6qAEs4TLfeM1K39x?=
 =?iso-8859-1?Q?SBxxfnQ0aGVgLdvCM/Aayb2NbHxJycQuvGyH/5+phoRf7ZK3WGa+G2c+F7?=
 =?iso-8859-1?Q?iOZJwfWSE+IWDuRnaUr/myuazMPnjCA0lHWCFVhjpeTO/28Vle2ILXm8Cg?=
 =?iso-8859-1?Q?wJ+eLuIZDI//XtefFSUDzywGiO/aqkY3DBPfIStMZgNekvbt8LW07rcMgV?=
 =?iso-8859-1?Q?AwmO0LnYDvo+hP5RBs6BT+uZMs9pheOtkRovMa6aDt1uMZojWbU5nzNhyl?=
 =?iso-8859-1?Q?j9VSd9ryjOYDvEuwKr0TyaS3pbiCfLKvB9+vF4WUtO/NxwIFQC/1R+vKDJ?=
 =?iso-8859-1?Q?ROV6DbEUv36o1+DwjrE+CjOIw69ubAZJaMOPJu7Toi2b2QtexkfX1Mwkos?=
 =?iso-8859-1?Q?2WQ9YmGiHQqL/tql43OxTwH2aOTzZwTIU1OZUvnpqr67hH1DOTVpAkeK/6?=
 =?iso-8859-1?Q?oD8KdOho9LkuAKlkQNbFxbh8/u+Vlzp4b+Xk6wDKcC9NJ7ONn0wFyRnnZu?=
 =?iso-8859-1?Q?6/tk0VvqIehJHKM+ddL1CrWphir0ZxeoNcudfjN28pw2vxFc4JrV1eu1ml?=
 =?iso-8859-1?Q?fEi5xHc0tCDv2vFdU/VlJLdAgTPuD5O++Ur7sMP9IkT8Mff/gt+d+UzvT8?=
 =?iso-8859-1?Q?mBGxVdSUcXOoYdORKQc9ixky7mG9YzAohu8YnTn33UcR88u7wniSYHerNR?=
 =?iso-8859-1?Q?VMhi6Zrczr7E49hs48mFWh1oUQEY473Sapt9PR7XUE/Mjd9uLBvjI2Q1nq?=
 =?iso-8859-1?Q?nvj3Xmi1I/rTHRADt/eP6V+vBo3xyWlf5/g/SuGvumAtSuZFXaGunC0goX?=
 =?iso-8859-1?Q?/D+yQtz49HB67iS7Hve0zZ4odZrsiN/0qEC9QwS4zSSapTUMzMM08t0jHR?=
 =?iso-8859-1?Q?N1DIg9GSQmIeEKuI9pg022jB6u8Gn/VB8VX7qRb3QwK5MiyeWfydeGLJwC?=
 =?iso-8859-1?Q?sJghBIyFg/LtWeoGvwoYiPdjuYHmdOsJ8IRT/c4t6fhpxWgUbvBglmnYcK?=
 =?iso-8859-1?Q?5dLIbq/NB+Dm+JYr29nXOe2Cqg+m/5o+lOoAGIkZVoaaTP0i6Mt7f04ryj?=
 =?iso-8859-1?Q?ZraPwnGd8r94VDvI8bclTELi7/RRaMTeJhNAq85bCzF+/X8QHkYsOBRkgF?=
 =?iso-8859-1?Q?WzkC0SnSw7kq0ShRWVJrpdrfMD5rwe66oTVoS5Xsql7llWuPDd3j9Ya4Tt?=
 =?iso-8859-1?Q?AzTTrkQr5mSWBiy7h5JZVGycyPgRFXgwviMuXzoUbDcXQWHBvgBPqv7PQv?=
 =?iso-8859-1?Q?KN3mxXgFYf0f2lu2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4720.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t1sxPvZa6Ap+rL5qUAHF+4jjZTNbHlCqXIRMC60M/99non108JiY208pTl?=
 =?iso-8859-1?Q?VYtJ7UgDuNNBMkMj9eWKHFN0IOcz2xTMfq5yqeB8JjYIUWjpJW2+Yi/3S1?=
 =?iso-8859-1?Q?ogUKFWxUmt0vmsr1StzrLJNLMCDYreQ4EtVRBeYbrHyE8sTh1BLtwTAPnc?=
 =?iso-8859-1?Q?tzhgPy/akqtEnl69AGUaxoT8ziRuNCa57C+zaXj1kNeGsbmv9tfgrTLYm1?=
 =?iso-8859-1?Q?65F854Jh0LT3iZlaTK3rZNYXQJdgDg4UA9KUL5UPxS1Xtz+GS2GSmKSQgD?=
 =?iso-8859-1?Q?t/IIX5vJ3J75AKlpY/NIMeUmB8YMNJNcqhrIldFaT7CBjHOm5l1DcoZ12W?=
 =?iso-8859-1?Q?J7YDuPnvJZHj/gnOdDVOt0fbUwmFVSpAQ/GtL0L9dGAh8auwOKxFzAFzy3?=
 =?iso-8859-1?Q?6HbpyfxXVF2deMpD1FEVDefAmfijH9A6TmOQa4Xw6KKNsZQO1mITzR6pfX?=
 =?iso-8859-1?Q?+7SIkqWnEIO5KWnA5AXacb7+9kOs4dqC4I9X5q40mz2hcUHyz16YeZnyRK?=
 =?iso-8859-1?Q?fa6/MbMTGbQBnpBO8EoOWjBqEF+3ziWQeFBIz+c0+HEVKce+1DAAUMTMd1?=
 =?iso-8859-1?Q?bZemctIQ1Ukoa7CYQGCSAm62QlsyqV8laeAAbKFMhAJRJvZ9rUkezVjSnI?=
 =?iso-8859-1?Q?CsPzjjbrciTf2682xaS2J20+iOEjjQUt/+tETZgs54HkDjMZkbUDha5aHK?=
 =?iso-8859-1?Q?NZB9xNfYi4s+Ef/Lrf/Ew0fxtPpDlhVd7Euc1UVNQ68aKuSuzB1ap51tuq?=
 =?iso-8859-1?Q?V3XPYjTE7E5wxPNLtL63EclxWSpJN6EhCcsgGl1igGSpdlGJIzc8uQg+GZ?=
 =?iso-8859-1?Q?nais2KWehVlVvdlnlTFje1U3amRx6ApfEbClex4N0dBG2t+3009Dw0Y91n?=
 =?iso-8859-1?Q?AmlhMf6iQMUs1EFV1tOntZ0w1WZQ6GX4MpYk5yRyqwkrUr7BezFznsvRUo?=
 =?iso-8859-1?Q?YXM9wcvhEfFWBd8Q51KBGCJghBM3LSvGQ4+gbElFjndW93WyxH9KzHg4No?=
 =?iso-8859-1?Q?yRYHBfAvABSpZIVineMgn1HHp50bg3t8OnX5Y9sjtnqUDkcef35qV+qAGX?=
 =?iso-8859-1?Q?hut4fM61C4E/3mcTNbl3Py/whjIZj0UvAEWx77ZXGFUrEMDqyzShmd8uHq?=
 =?iso-8859-1?Q?dPn3HHiXrOcJ6Ylmb7qTVqDJErEWrdNc4vJ0wRV9xg+8xKHgmBHj7sxjsw?=
 =?iso-8859-1?Q?cFZXzXC6i4FU3ZaKdU6h3H3qK5/NrdQ1KBqxNs9H3YIRQX8ywiCEcSLZvs?=
 =?iso-8859-1?Q?/9ZYSRh/hHMCHgJMZ3VYqoAuXGuC2WQrT6/0Brly9IeJMpWZF+Ctj7GsQF?=
 =?iso-8859-1?Q?Sfs188E6oH/3PYMp0gy/eznzXRWvmsIoYRbz/PwZRLjYitO7j1f5RhNRTE?=
 =?iso-8859-1?Q?b+ARWdX0ysbNuspK3plq3eysL0XsvPaEakhWJKv95qcDVQac8/xdaLeDmI?=
 =?iso-8859-1?Q?IxrtFkXflWM77V/Ul2JSUH/cLEDXxO8c1cFG/IpzYlz3E0p5HBndgLv4je?=
 =?iso-8859-1?Q?RbMgD2cmDcLDxSqdF7MMPvv02J2UQnJELQHUOugMaT57aJfcjCdHmgSgcm?=
 =?iso-8859-1?Q?4b/D9HYlGl4SwC2iWdye5SZ/fRZP4uV0aSqKp4Ze5ra4aWjFq3W6A9Kun+?=
 =?iso-8859-1?Q?/yDYi6hRjKMHI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fHI5tQHa5q9eBRfLqAl8yCEEt1TH0ykFrUGQrW0SfRus7K9JxDqFVz+S5I4TUUc4vERi9xcBL9rDi+IZoeI+JtVCtpKq4KD/YdHGsbTnbgp/trkikcDb2cFzr3o2tEwkEzgL9zywwtTzADq2rv0LMe3B2dVlXW5hL8WZjqcZnJ5YCnunpzs5GLFvMDebJzd0/p2wIt6Yv6gMaDpfYkELnYpfg/g7yDJqPwBR/ybSWwU59vtnatjDFipX74wq6GVtrg536i3EGHCGi0TgpHCNdwC8RW0xoJN+fJGH2asRdnF+XarnmnePWnyhHkOLKK8gqaTBuNyEAKexhYMC+kmYu226JfyPTAFhstpSuZDJRKkPtc518fPsojP/AsJePO0yCFxTNYprmTNqL/WUkcMt5R+TPShhmlTnONnPMiZZGq+7KOmVp0plv+QDyRT3rqBwdJrfC7nUT9mK/QrAQh5DvYtLylUjqbUecgrs6dIYbRSiw0NtKZJExpX8E4bMeH/0usAADryZ9YomKdg46n03f75pl0Zyt0RqOhvVrgRjCPS3x/aCug3Bbv4N9yFenL9901qhEdE2ofiUSKvFn0qJ2QUIb5xZiC0mDON+TQZ/RSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4720.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd52296-1a8e-412b-d56a-08dcff211644
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 11:41:15.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IU7pYj2Bkb7HbKiu9hG600bY1KaaCjuipA+cqHyikpr0DSiyDaIAJSzei8S5fYdTZTUfwdAM35MWUCRFInzWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_02,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070090
X-Proofpoint-ORIG-GUID: Hoqrm-sRuytsMYrFw6h6620TkkNc-SoG
X-Proofpoint-GUID: Hoqrm-sRuytsMYrFw6h6620TkkNc-SoG

Hi all,=0A=
=0A=
> But the suggested fix is just beyond hideous.=A0=0A=
=0A=
I am new to the kernel mailing list, but I would like to refer to =0A=
https://subspace.kernel.org/etiquette.html#be-terse-but-polite.=0A=
=0A=
> It's yet another reason that the XSAVE architecture complexity hurts more=
 than it helps.=0A=
=0A=
The XSTATE architecture simply guarantees that an XRSTR using the state =0A=
recorded by an XSAVE yields the same processor state. It can prevent dirtyi=
ng=0A=
cache lines by specifying which processor state can just be restored to its=
 =0A=
zero'd state. All we are doing with this change, is maintaining the invaria=
nt that=0A=
the xfeatures value matches the remaining data stored in the xstate buffer.=
=0A=
=0A=
> Can't we just use the mask that xsave_to_user_sigframe() generated instea=
d=0A=
> of reading it back out of userspace three seconds after it is written?=0A=
=0A=
This is technically sound, but at this point in the code it is making the=
=0A=
assumption that xsave_to_user_sigframe() currently matches the value stored=
=0A=
in the xstate. This is more fragile if any further changes to the xstate ar=
e made.=0A=
=0A=
However, we could consider the the kernels representation of XSTATE to be =
=0A=
a pointer to the xsave buffer and a kernel value of the xfeature field. The=
=0A=
xsave_to_user_sigframe() would then compute and return the xfeatures =0A=
field as you requested, and the xfeatures value should written to the xsave=
 buffer =0A=
at the end of copy_fpregs_to_sigframe, possibly being conditional on if it =
was dirtied.=0A=
=0A=
Then update_pkru_in_sigframe then just becomes:=0A=
=0A=
/*=0A=
 * Update the value of PKRU register that was already pushed onto the signa=
l frame.=0A=
 */=0A=
static inline int update_pkru_in_sigframe(struct xregs_state __user *buf,=
=0A=
					  u32 *xfeatures, u32 pkru)=0A=
{=0A=
	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))=0A=
		return 0;=0A=
=0A=
	if (pkru !=3D 0) {=0A=
		/* Mark PKRU XSTATE section as in use. */=0A=
		*xfeatures |=3D XFEATURE_MASK_PKRU;=0A=
=0A=
		return __put_user(pkru,=0A=
				  (unsigned int __user *)get_xsave_addr_user(=0A=
					  buf, XFEATURE_PKRU));=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
I think maintaining this invariant is a fair step to perform when fiddling=
=0A=
with somewhat architecture-internal data structures.=0A=
=0A=
Thanks,=0A=
Rudi=0A=
=0A=
________________________________________=0A=
From:=A0Dave Hansen <dave.hansen@intel.com>=0A=
Sent:=A0Wednesday, 6 November 2024 20:27=0A=
To:=A0Aruna Ramakrishna <aruna.ramakrishna@oracle.com>; Thomas Gleixner <tg=
lx@linutronix.de>; mingo@redhat.com <mingo@redhat.com>; dave.hansen@linux.i=
ntel.com <dave.hansen@linux.intel.com>; x86@kernel.org <x86@kernel.org>; li=
nux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Cc:=A0Rudi Horn <rudi.horn@oracle.com>; Joe Jin <joe.jin@oracle.com>; Jeff =
Xu <jeffxu@chromium.org>=0A=
Subject:=A0Re: [RFC] Restore PKRU to user-defined value after signal handli=
ng=0A=
=A0=0A=
On 11/6/24 10:33, Aruna Ramakrishna wrote:=0A=
>=A0 static inline int update_pkru_in_sigframe(struct xregs_state __user *b=
uf, u32 pkru)=0A=
>=A0 {=0A=
> +=A0=A0=A0=A0=A0=A0 int err =3D 0;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSP=
KE)))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> -=A0=A0=A0=A0=A0=A0 return __put_user(pkru, (unsigned int __user *)get_xs=
ave_addr_user(buf, XFEATURE_PKRU));=0A=
=0A=
Let me try to summarize that whole email:=0A=
=0A=
The existing code updates the PKRU value in the XSAVE buffer.=A0 But it=0A=
does not update ->xfeatures[PKRU].=A0 If ->xfeatures[PKRU]=3D=3D0, then XRS=
TOR=0A=
will ignore the data that __put_user() put in place.=0A=
=0A=
How does ->xfeatures[PKRU] end up set to 0?=A0 On AMD, a WRPKRU(0) sets=0A=
PKRU=3D0 *and* XINUSE[PKRU]=3D0.=A0 Intel doesn't do that.=A0 Either behavi=
or is=0A=
architecturally permitted.=0A=
=0A=
Did I miss anything?=0A=
=0A=
But the suggested fix is just beyond hideous.=A0 Can't we just use the=0A=
mask that xsave_to_user_sigframe() generated instead of reading it back=0A=
out of userspace three seconds after it is written?=0A=
=0A=
static inline int update_pkru_in_sigframe(..., u32 mask)=0A=
{=0A=
=A0=A0=A0=A0=A0=A0=A0 u32 xinuse;=0A=
=A0=A0=A0=A0=A0=A0=A0 int err;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE))=
)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 /* Ensure XRSTOR picks up the new PKRU value from the=
 buffer: */=0A=
=A0=A0=A0=A0=A0=A0=A0 xinuse =3D (mask & xfeatures_in_use()) | XFEATURE_MAS=
K_PKRU;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 err =3D=A0 __put_user(xinuse, &buf->header.xfeatures)=
;=0A=
=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 return ... existing code here;=0A=
}=0A=
=0A=
This probably means moving update_pkru_in_sigframe() to the end of=0A=
xsave_to_user_sigframe() instead of calling it after, though.=0A=
=0A=
But either way, this is all horrific.=A0 It's yet another reason that the=
=0A=
XSAVE architecture complexity hurts more than it helps.=A0 We want PKRU=0A=
written out here, dammit.=A0 We shouldn't have to ask the hardware to=0A=
write it out, and _then_ go back and do it ourselves.=

