Return-Path: <linux-kernel+bounces-525906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DDA3F73A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F340919C5004
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4520FAAD;
	Fri, 21 Feb 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cYA1a5nG"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020092.outbound.protection.outlook.com [52.101.195.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA620F08F;
	Fri, 21 Feb 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148104; cv=fail; b=I6+kgl2B6yqocqYX5hqAjf+FD91hwfiyPjq8jnosKMPqdf6WRvKaXQjQ5roIpo9DBwq7qZ9SMLpDH7cahmmgnP5uFmVm9R+Mjj9HVJ4kP+Yo7H8zCsj7iCS/oXvmDBVtFs7k5O698W+XgUyjdWoooJuUGDSzBmXXBt54YWhVLZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148104; c=relaxed/simple;
	bh=9/XCgbLOiX+O5x2O81JQNIe4x0Ss95sACdumhvod/+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbJkfR7GpTMbLKDAMRJk10baiNTCS5RwNJx18ITyKTfMfGLNtS0KXSIqa0vMtdZkj43fk2enh8BMF9EEJEzIXMvNigypJSlT3lcBMBkovhU462EN6r6o3waG5jpRw456/S7jTkV75r5753m3zP/d65ponzCFZ/nXOniyAh1A84Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cYA1a5nG; arc=fail smtp.client-ip=52.101.195.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MS5bdgUzYIyiHJnO3zoGsBv7t/hRLRjmfY98uL6DQxR4CyM6v/JKB8z5d3DJRXE1N/aQ3CwauguEJtEh3KGGJF4D4Y6GrY/0qoffODOzNfxpWV5OE+yFf/il9kERyErt/A6kWgHRK0g6CWSHZFpXrk9wKsV90Xjsrx57jzUEHnh7lNHTuZM2zXhjvJ4agoAigJidRWLKvOQw69wEHgE1MnOKceiXlBcc1kydfGbzwyGkXWmaQUsZUOsB2ANDC+gSIE2i5bPacTQTJZoMYMj5v82ZgLCdkxRXQjOyllg4Jmtse88K4QkI8PBF6wL3uQbuEIgI1dmtprjhxRwrEMA5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/XCgbLOiX+O5x2O81JQNIe4x0Ss95sACdumhvod/+8=;
 b=H91IDQ/E/SBk3YKSzixpZ/Lm4bYfhMkkLVw7MLmsffr0rpZVZBWzN+N77z9WcYwWTgUychKmwaPhBL87uZodML0V/AULqXJa+1CSeKFxZzlvxaarcPlWKP1AEUimE8GI09+88RiLnXXdFJ5/PT9S+xYuqyTVj8D733hMjFH4b7N1I5TxI1siBNHgZta5HDN5mapdZmPlCB7ohqEl3w60csyzFw9azvxWDSJTsQFmbckNkY40yCcjfwOIdYup2lt/6EExwBe887KkwLiX0ql1BwIjGT4KRXACh4OAV+T7jslFJoJXtWHJFGUUhmoo5AwW3/sXNORGUrKTAPQucpIZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/XCgbLOiX+O5x2O81JQNIe4x0Ss95sACdumhvod/+8=;
 b=cYA1a5nGTbR6g25TY5WCDU/5Y281TFgbXsLY+HXvqK7hyz9TKe2UyajLhMMhyeI2tOFPMyJg+tLZVXIztlXEOwUArKPJpIEEmtAzxI1Gbz1eVestv8q8WxKmPQYeS+BeLVOhZ3eUobsJ2yaNl/aljhKJvNWjXc+E83H75+N2Pzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2807.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:28:19 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 14:28:19 +0000
Date: Fri, 21 Feb 2025 14:28:16 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Michal Rostecki
 <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/
 core::ffi::CStr
Message-ID: <20250221142816.0c015e9f@eugeo>
In-Reply-To: <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com>
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
	<CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com>
	<CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8138b919-7a27-4189-7576-08dd5283fcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExRTTZEOXllT2Njd3NkRjlZMWF1WktjOEZYT21WOG9OWGlkZjZhTFJkeGM0?=
 =?utf-8?B?K2h4cmt1bTMxVE1pK2tqakU5SXVZRWN5ZVp0emNjQzMvbThuMUhPZG9TSW5M?=
 =?utf-8?B?UnVSOWJqT01DNUtkOG9TRi9LZktFZU5pYktCRXcxRGFaMHl1ZS9kamhTbHcx?=
 =?utf-8?B?aFk4UHFSMFg3a3ZISzlWSVA1TWViRUtab280b1FBdUFXaUxqUEM4WC9yeDBu?=
 =?utf-8?B?alJNVmJPTzlhMnRud1E2aHZzdHQwc0FIMUxkZ1RTbXdJNHVTWnNmdk5SZEE2?=
 =?utf-8?B?NW5iRUhoMk53dUh4aWMrMlRMcDdhSjczVXIwSVJyVWhpK0Q3M3FWSWRKT1RP?=
 =?utf-8?B?THZhNHlDRSs3bWlPR1BpdVlsYk53MDAzTFFub1N1anIyK3hQT2RzZ2dNeW1x?=
 =?utf-8?B?S0pGY1c3dktNUkhialJBa093VE1UNTVuV2FQUGpRNXVXWHpqWXUySnhsVWVJ?=
 =?utf-8?B?UTlCOUFORHVVQjRBNTN5V2JzQzkxckQvWGluQnppOEFiUE9wMXVqRGhhVUYv?=
 =?utf-8?B?ZzZuZi8wa2pDV0t0MmVzbElObWJ5ZlNqK09BdmZlbHdhZWxldFFMN1FVeWJP?=
 =?utf-8?B?S1g3V1ZwLy96NXJLV29XbU9HcFdSSzZQb1c5SUI1MXMreVlMeGd3WmhCRTNW?=
 =?utf-8?B?a0tXbkI3WWg3Z2dyTmY5ejAySmJIa2pFb2dQZGFnWXlkMzhvNHJKbXplRUFI?=
 =?utf-8?B?NXphV29mdzU4NjFqYTBMeTlKSVBKemdBM2lYWDlTWUtqRXZqY3F1TmRuWjRV?=
 =?utf-8?B?cnZ0K0ZGZWVZWnlDN1BUdTBxZElmVUVsZlVMaEd0QXdMTzRCNHhzRUJ5Zm42?=
 =?utf-8?B?blVEaFE1cGJJODhEQ3NEcThoWTBzekxLOVpkQ2cxNTRYMEpLbTJBckxQaFRO?=
 =?utf-8?B?TzFwT1RlTmg4bkdENHhZSk15WDVDNUtVQlFLVk5jdDQvNkozSzE1WDY3Z3JJ?=
 =?utf-8?B?V2FCa2ExU1NoQVd4N092Wm5zUkRxQUZkZkRwNDdkaGd5c09WTUJvZWFiSnFN?=
 =?utf-8?B?MlRnbVEwd3phT3h6MmVGWGUzSGw4RiswTEdHbE9kU0wvZXFvcnk5dlM0N084?=
 =?utf-8?B?NmFMcXFJNnBhUUNxZHhCb2ZCdkZ3OGRkOG1jbDlmRjMvdklWblc5WkFYRGxG?=
 =?utf-8?B?YkVUOGdlRFN1c3A4MExYU2d0MVpWVVJIVjBjeXJFM2dNVkR5dGVCaUtCQzRV?=
 =?utf-8?B?aHRQb1dZVlVpd0laU1lFL2Y1cytQR0tQcjF2d2NHcjZGL1B3YUc2L2tOUE9j?=
 =?utf-8?B?OWM0ZjdKcno4Sy9tRmw3WDJtamx2SkJtR2N5U2xwQS9hL1BPV29abGYrNXgy?=
 =?utf-8?B?N1lTb28vdC9GVlg0OUdBb1hqbkFBdVpZZjN5aFRpTkhlRU1ndC9BSHYwS1NV?=
 =?utf-8?B?aXFXMlBjeERXV3lhOWVhTms0cThoRU93em5TREJpQ0UzcUprcFFmVVZrb1NX?=
 =?utf-8?B?bVlmUFRqQ1ZzMmVvdlFEMzNUNFRIZTY0UnZsQkJOSnk0dERUeWZKQUNTM3Rt?=
 =?utf-8?B?dExRY2swOGIybS9EdlRad3B1dE9KWCt4ekVGaXErdFlMNmFucXN3cy81d1I5?=
 =?utf-8?B?NkNKbkN3a0FURTBjTXNXN3VXREh6djV3RnplK3I3aVNjZ1RKWnNYelV4eTR4?=
 =?utf-8?B?aUYzbUZzZHFENXl4UUZKUW9GRTNhRHlHL0M3UDBlRlhVaEljdmtWUGlyeTNq?=
 =?utf-8?B?RkFnVTdLek0zUHQ4NTFRZVVJenB1ckhRNmU2czAzMEdXaXZ4YXlNNUpoSk55?=
 =?utf-8?B?RzRndTE5aWx2S1R3YnFtSGliZzlTdEF6WGw3anFPWGJ1L1JWMktFeEl1OFdD?=
 =?utf-8?B?L0hBVVVrblNJbGgrMUpXNjhHbjVPZ2hiVUFjWkYvdlB5NXREbnhkVWpralNa?=
 =?utf-8?Q?XtxN7h3vH7LB4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnViVDlkMFhESVM1VFVZR3dTTGgvbnVtYU0rdTNOVDdNMXIvUXV0bmJQQzVl?=
 =?utf-8?B?c1JrL1prZ05hak11S0ZaVXEyUUc2WDR3YzlNY0x2OVdLWVExRzVqOHkxZ3lQ?=
 =?utf-8?B?WWF2eXQ5RzJQWTZkVEl5dlBYUXJlN3c0Uk1BTUtIYzBoTWxyTFhPRnNESVhF?=
 =?utf-8?B?bHhxWFI2c1FTNHZ5ZEJIOHRWbEdwR0wrdmpObmdWTy9ZM2FCeHZMOHlUY0lR?=
 =?utf-8?B?dEdkaHpXWkhMZTFOem1MOTBsL3BUM0p2TDJPUmdFalQxcDVFbUlxaDQ0b3lk?=
 =?utf-8?B?QjlONFBjbXZIR3BnUWJpMkNnMmxEU3ZSc0dNT1JNWDZCUmlEYmMycTZEQW9m?=
 =?utf-8?B?bkVZR2loMTNUTGlkL2IwV05oUmRzVzM4L3FQUmk0SkNRejY2Vm9aRkhDY0xT?=
 =?utf-8?B?K0ZCZld1L1pkY0U1Vm1UZWp3Q2JjQi9mcHlRMDZhdGJ0c1JmZWdOOW1oTE5i?=
 =?utf-8?B?cmtxYXlrOTV4ZFJDeGdMcDlWaEpOVjEwY1VTdVBYcnRWY2dEVldpTjRJTW1s?=
 =?utf-8?B?czRxelNDclcvdGpMMU9QYktqcE9pVkxVSU4xSU1UZzdWbEhJcjVDYkJUY2ZO?=
 =?utf-8?B?Mlo5bjVQdy9mNElDbWx4Nnl1My91NXVnSHgwTUFuN3djS1VuUUFzNUxNRFNO?=
 =?utf-8?B?NFJVOGZGK3F4OEtDOUp2ZEcxRXVQbjFQTTU5ZDhMM1I0UG0rMDVEbG1YeFQ5?=
 =?utf-8?B?Z3NLTTdYaGxvRlVZMFVNdFd3Qjhkdml3WmUrdUFsM0Y1bXhlOVVVUnp4NjZx?=
 =?utf-8?B?eEpabzRZaFhxS3M4bTJEL3dYQnVSNGVDYmlHNHRDc0xIdE5melhLMUNwV2ZF?=
 =?utf-8?B?YVRFNkgyWWN4dDNwK2wzZDJEVDhiQU5kTm41ck9DOXJkZytuVCt6ZVpQdDRF?=
 =?utf-8?B?ejdJVDN1Z09iblRYR0JLQTdIZjBNVGFLb0FrT1N5eVQzc1NhbS84MmhkZW14?=
 =?utf-8?B?ODlOL1VzN0hSWUR6bGFOOVhLUERmdUFYYUYrWWVydXpubjAyNFgybGxwR0g5?=
 =?utf-8?B?ZDBGWm9uRkt2Vk41NjFnbUJBeU5XUW9yWmFqVVNnV1pMeWRDSURnSmljQmp1?=
 =?utf-8?B?ZmhpMmh0TWpnc0l0TU9URUxzV0tRaHNOK0xKS0lMWldlWEZ1SUU4UlJ3NjN3?=
 =?utf-8?B?QlNxSm9EZFNWaE5mMTVBd0l1bmhENnlFQlN2VWM1YktycUdqaUtWWVU5c05V?=
 =?utf-8?B?aEh6NFhsVGN3L0RXcmdvK3BOYkwrK3VRdW5BeS80VmFlWCtRTDd0azVCNnpl?=
 =?utf-8?B?QWhTTzFjMEYwQkpnejVrMzFYSTRrc1Q2QmNjdlpqRXdGbkREQ2NFM1JiR2lh?=
 =?utf-8?B?SlFyZUp4N1orMTJBQi9xSStGUkFLYnBzQUp5dkpob0RMbTRHZFpXRlVYaEJa?=
 =?utf-8?B?YjB0VjZYbXlDWUd5ZlJQTG10b3RoTVFHYTl4cVdPYU41T2hZRUJDTU5vS3I3?=
 =?utf-8?B?T1VZRndpTEp3cjVmZCs0VEhqdU13ZFp3dkplLzhvbTQrU3c1MEdZNzFZQ0N0?=
 =?utf-8?B?RzNxK25DR2hYd0tFQldRVHlQUUtQa0QwMnE0NUhCNmJHZWdrQ2NndjJQUDUz?=
 =?utf-8?B?QlBqenBHTFpzTmVQd2RTVjhWblYrVWVyMzVWNHVnaDN3WVR0WjcvMTlsRUdY?=
 =?utf-8?B?RDNtY0h4RVJEVWdDVTNWcnYrekxtSEVRSEtkVG1LUjhRc0tjdDVQZTgwMjUz?=
 =?utf-8?B?NTE0cHpxbTVNaFE2OFowVXZmL2FzMC82VWZNVGJiRnd1WDRmTkZjOWZRV3Bn?=
 =?utf-8?B?alE0bjYyYUd4ZUU1MUpzMXowQ081cDk0L2VSS3E3SG5mZWpzQS91c1RJalJG?=
 =?utf-8?B?NkNsVURzWWhoVnhLWEhFT2dnRGpvT0dweWpUZHlTU1UzczIwWHpEemkxWVl2?=
 =?utf-8?B?RC94M2lnTlNuM2p2WVQ2Yi8ydlYvWHBXRGtDWVBKVER0TjNVcFlGWW1TY2do?=
 =?utf-8?B?bHFmQ3pZOXJMczIwR0k1Nkp2NHU4TjhUTlJtaE1aZkpKci84ZEN1d3ZaR3J4?=
 =?utf-8?B?YW01WmxiY0htUHFDOERsVTlYUWxnOFNPWFp6RSthRGgxTlQrVGpPTWZaSHhF?=
 =?utf-8?B?bVI3NXdoOS96OG9nTGZsNXJmdlZVcTdnSVF6SlBEQXV5dldScEgrNHFSK2Vv?=
 =?utf-8?B?anBGZ0ppSkZCOU9xMC9oZGR3UkZKRVd1Qis5Vks4M1VoR0JxdEpTWWtZUGZ6?=
 =?utf-8?Q?Xxg3PnH3P6P9UoufmaM/CFQ=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8138b919-7a27-4189-7576-08dd5283fcea
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:28:19.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6MMRqyaN2dZZlT9F8ym4yE5tXID0dTmnBANgJx7EGM6RLLPK5nJl7Hmfg4/0I/WfMn82dxtbIIZVdIcsKTinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2807

On Wed, 19 Feb 2025 14:21:35 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Feb 18, 2025 at 5:05=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Gentle ping. Trevor, Alice, Benno: you all participated in the last
> > round of review - I'd appreciate it if you could take a look at this
> > series. =20
>=20
> The primary thing that comes to mind looking at this is that losing
> the Display impl is pretty sad. Having to jump through hoops every
> time you want to print a string isn't great :(
>=20
> Alice

I'd want to add that we currently also have our own `BStr` and then we
have the `CStr` -> `BStr` -> `[u8]` deref chain which is quite often
useful. If we move to the `core::ffi::CStr` then we would lose ability
to do so.

The `BStr` is quite useful as a thin layer on `[u8]` to give a
semantical meaning that this is supposed to be printable, user-facing
string, but it isn't always UTF-8.

Best,
Gary

