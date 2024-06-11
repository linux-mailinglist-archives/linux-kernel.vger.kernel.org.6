Return-Path: <linux-kernel+bounces-209534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986A3903743
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4116828A44E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC96176227;
	Tue, 11 Jun 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jKzzt7P/"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A617557E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096210; cv=fail; b=kcuPQJTNVq81de+fLOE4jir2p2PlHuTOYzDADANQeV1Df+P4AayMuA6el2PTugbsnYkyjCbX7/EXSCDiWhaftEb1KjvrFyWILY3m/9U6HxDxctrOQrtQVgLGimmS4Y7BvI5yrWoN6rlmt0TspMLgQMVNHapKtDcOqhkbyv7uJYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096210; c=relaxed/simple;
	bh=RVyURmoeXZIp4B85tUH39SG6CHcL6Sx/0e8Axiw0bIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CIrUyjmu2S4bLP9bUY1T2n/6HnjSnYS7UC7HQC1wPDP0Na6HuPopUiPQPsncuCKzzv7GNNx0Ol41SyaK+LSgMFR9a38QWumrda6rVMTQnM2KDz1vbN4TCg3WsW0cbZIQ04WBVGSShcf7uUgk7PQe02Z2ISQFEZAtzHfqah8KyYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jKzzt7P/; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE2S+KLAjiji+Hqx5WKh7Tsjk4QG9VEi5e+xKbnEOmTPAW17eNsjthypEPHRK6qQfE3JEAMYYFOBhTc2bs4ETm/6huzsUHHP69uC8sdEUVjKWUvHBlWsISuciVPIIZEkuRYvqifKTjRNIHH7ZXnycoPabffh1Owsb6MCNC5oXpdALJPciRJz7trqe2+4LUPCjm2vvOwatOo6+jOpzkk41MMX/jvKHUXByNlZxTQ8ckNehW6y1GUw0fphE3eQqx6h5JH/7ee/bZDt6jtSsMxvoPqnoTSu0mz42erH8eoxqLkdpLB3oAne5Pp7/fiVVBNt7PODvXtN8kIdqP1nqYCVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERo6iNzYR8gGMDOMiAjuaEX1EaLcBOfNZOofX3ovnns=;
 b=RVUiNqBzxpt/+c4yQM/OQnY7eJ6l+y2cuXqWKu3wL88NyKRP17WIlGXZwTBCJC1HkkfhxEQWrXCPrnalyxY+d52D2uN9Mn1614md3WX+dkI7BeBg1pVC3LbTxPSk4K+ycv5iu72D9dcSUXBoouNrieOT8ospCf1SxOYxRNgOUykGTtW8y3UbWCohmmeRzTNAd1FFGhVg7Belxkd//+eYqTOMdIcQIBlyMaWsHtOfuVifTCdrt0b60KlHsuadyrw3hvCsWt9YFBjzr8FLnJLw+6RNwzJwmJj+6+sXj00agFA3/OJRMOlGJKi+u3ShGzB6Jz/O4J4JarWCcuu10Mjouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERo6iNzYR8gGMDOMiAjuaEX1EaLcBOfNZOofX3ovnns=;
 b=jKzzt7P/0W15yfU4NlOFGP0mXSb3Ta3nN6vgQpbvjEenLy9cdunp8cNWK50pn9twzeicSTm7dkFGJLbTtuz0xlqSGBRmLc/kjlS8cXERtrZLJv/yyuzuvEop1T5D23folqd/ZCkNodtjgKRn0sXVEcOOERfve85OWD9wedk7S6JhDOyP+K3nx4y0MPM6ACXHxersV9rK3LBBsSnoQIfzOgAq3iiJxguCmr7zUkn5sj4IBcW1RE6qdE5zd/9k2y2BjFSaC7QIOd5aQDNcbMUMHV4brCPM4uatarZxNH8SV9UbkrXd8YtNZYYrIU+7ncx2pmaskP+s6bQLiHudeAZ8Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB5827.apcprd06.prod.outlook.com (2603:1096:301:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:56:43 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 08:56:42 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH] binder_alloc: replace kcalloc with kvcalloc to mitigate OOM issues
Date: Tue, 11 Jun 2024 16:56:28 +0800
Message-Id: <20240611085629.25088-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d30235-2e8c-4944-d053-08dc89f469df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnIvcjdIbVAwMWhaMUFqbHl2UlFlVjF6WFRHZzlJVmFvYmcyOXJkVk9DSmM3?=
 =?utf-8?B?Nmh2UGxYL28yUWk5MUFKWGkwSDlPazF1Qnl4dDdqWnl3aDdDQTJxM2RIOUVw?=
 =?utf-8?B?cXVCbGh4MFMySURWK3NmbUp0R1FMMUV5ZkZtNmNEVkJiTVY3ak1qVzdBZE9v?=
 =?utf-8?B?L1ppbTVhRkIwbHdHNFhWR0RQbjVoZ25QK25NTzlyanlKcThnL1lSVUo1dGNu?=
 =?utf-8?B?K2t3bUZFd083VXo2OFkvMWdrRHNCcVYyQWkyWjEzSis4MVNPSVlCalJWNzVx?=
 =?utf-8?B?Tmt5UzBHY1NrVWczcWtObi9vdTJjQzY3SWRWcFF3U2FYeFlkazVJbnJjYlVL?=
 =?utf-8?B?bzJGTmRUQWF1cGk1cUljYzhIMjM1VEt3eHMzWFBKS3Q2R1Rycjg4NTFBcjlt?=
 =?utf-8?B?S2doWHBDaG5mbVhPaXN3SVZoRnFjSGtRZW5WSVJId3dzenordnNSem5XRkhn?=
 =?utf-8?B?Ull4a1FiajVSQ2wrbzVoNGJ2dUI5eEx1T0pSdGM1TVNISEkxTFhVNUhJZWYr?=
 =?utf-8?B?Vm9kYmJtakFpTTNHOGRrdFVGSkNzYnJZZXNXVzBoOWthbzFtVXRKSlZFWXdy?=
 =?utf-8?B?RzRzR0NyUS9EY1ljZVM2SkY5WjhDWVhRUWpWYVZMSDRDTHdCNk5Yb3k2aXlt?=
 =?utf-8?B?cEh2ZXgyQ3BERGJDbHQ2RG5kMkxkVFd3djhub1NEeVVqTm1ORlFVL1l6V1cv?=
 =?utf-8?B?cmErUVhLVG9nTzlwYStqOEhIeEVvSm5oWnhwVWFRVzVCeEpVN09lZ3V1WTFF?=
 =?utf-8?B?U0JxaG4yNjRUK1phNG11WUtUT3FtTFdMaFlwNEpOSjYzWThZTlhydzBQcWlD?=
 =?utf-8?B?ak5sTCtCS2RLNjlvVEFOZlErVmNwYUVzZUxVOUpkbVUrNnQ2bENHSTRIYUhy?=
 =?utf-8?B?cHM0NkRNdUhmcjVRNmtlTXBoUHB1Z25oL1VtcGlROHp0QmZibU9hMmV2OG5l?=
 =?utf-8?B?aGs0TkJjUjRSaHg1NkJZVTBBNnhIK05aQkhoTzg0RnVLN2tpQ085Qi9sN3ZM?=
 =?utf-8?B?c2NUVEJmbitLVHZlMDl0d2U5eUNsNGs3cngrSjFIZHZsZnMxd25TdHBhNk5m?=
 =?utf-8?B?Q1F3REZFa2JxVStnc2VPVGxtVFEyajFmazAxTi9rbWF6d0VuVGZ2VnhUTFZ2?=
 =?utf-8?B?WEt5Wml5Slh1K29iVmEwTVRGSS9PUS9JRDhXUTVkaGM1WVZEKzRhZXpaUk1y?=
 =?utf-8?B?UTVRTlRjZzBlOXAzcHVEVzhUVkZjQ2xzckl1NlUzL05SYnB6ZEk4TGlSbkNp?=
 =?utf-8?B?SmhuMzc0MHRZWEQ4a0JBeU5FbzBqaStXNmFReVVISisyV0h5VFlXbmZwK24r?=
 =?utf-8?B?UElRRlh2VGk3d3hqTktxdXY5T1NoNEI0ejN0eFVPekJXT0hmUXBvN3BDU2hJ?=
 =?utf-8?B?N3ZtQ0RhUWo1N2RLbFZxd04vNzlUa1Fkdkc1ZUZNVUV5dXhHWmlTdXJBeVNi?=
 =?utf-8?B?bGRjNEdqMU9pS1IyOXdEVFk2SUo2OGVKQUdNOG5mMDZnc2dTanc4eXc2Wm1K?=
 =?utf-8?B?OXRFSGM5VUgrM2lZU0s0bGJQWmtzaFdycWwrZm5raUtzeVROYjdEZWd5ZXlO?=
 =?utf-8?B?dUU1Z1loTUNaenI1UkdCcFVwWnpnZnYycDJJNmQ5dm1sQmhITHVSaEtGeTcr?=
 =?utf-8?B?RG9QQkVpaHdvN2FsNjVlcUNNcUNDVEwzS2JFZEsxOXowejBaakJ1Z3U0QmpV?=
 =?utf-8?B?R25iWm9GTUw2UGxHSjdPUjV5WlVMdFI4VjZPd0F1dWpzQmFTUXNqcUYvdG11?=
 =?utf-8?B?enZ3dVpqUXNjVWhkTStFRU5zMUxGYSs4YUtBNkdrcGpoQU9WQWpHM2xIeXU5?=
 =?utf-8?Q?quQtoq1HPjH5QlEJK4J2Hh/EZ5nNDN1NkHyq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBKYWRQOFM5Z01mU0lLYXMxVUN4NVJYL1dSanB3bDc0RzFLdjdlNEVYMFlG?=
 =?utf-8?B?WnBuQ1h3L2FDZEJ5N25vYmlIL3o4RzdObld2NE4xSFBRdVRxVURUM3cxNEcx?=
 =?utf-8?B?WXRMSWI0NFR5UEpOY2t3SGdHUGcyaTRSTUEvUEgwTlN4MmlBYVFRQ3FrZ3Vq?=
 =?utf-8?B?ZmN3SHlFUi82bDlyWHNXanR0VkRvaEIzYW5xaUMrN2lSSE9KTGhTT0oxVG1F?=
 =?utf-8?B?NTZoS1JEaWdxKzU1RlFHOWZNaFZmR2Q5ek9xSzVudUtUT1dWaDlZSUloUkZQ?=
 =?utf-8?B?TjJNVDZETFAvcDNCQzkyTlVsTGp2RkFBMXM5T2ozVWFMNlJjMXJianZ0YXgx?=
 =?utf-8?B?ZlRzNktlZXBkNWsyODI5NkpUVFM1Z1daNWZaN2lYOHAyTCt4RkV0b0hHQkRm?=
 =?utf-8?B?em9EenE5R29EdmpIUkg0U21kVXB3VmtLTHFDY3lydW5Bek9FTklEbmlPYlBV?=
 =?utf-8?B?Sk1HaTgyaHc2ZGpFQ3BqbEdMd1gzK082bG00RXVhWU0yN2JxZDdGZ296Vnpu?=
 =?utf-8?B?UktSN2pkVkUvRG5NTExpbEhzUkpQbjlCTk9TU2dEWjMySXE5L0tMOWxHK28r?=
 =?utf-8?B?bnFka3pmVXpST3FPTGlnWHdYQzZxVzIxbXJKYlRGMEd5SXhETitrN0ZHaWtj?=
 =?utf-8?B?Q1JYNXVjWlVRSU5WWG8wYUVNOWV2RFJocHlIc1NQbG1SeTBRNU00Z0I5TTFV?=
 =?utf-8?B?aXZqZXRZN2NmYytkTS9jSWlmclIvQ3RreEVzaTZoVFBmbmtxeHRNWjJOdDk1?=
 =?utf-8?B?dWJQUG83T21jN21Vek1hT0VxWXQ0VDZwc3R0ZTJGTnFoQVdKTnJRdnlCKytW?=
 =?utf-8?B?aTdNWFRyZTNWYWRYRXlLRlJXYzlEV0Fid2JYRU16UDY0MzFUeDJwU1VwUHgx?=
 =?utf-8?B?bVUzWWtBK0xNdFRtOUVId0c0SDNVRTJGb29HL0JFeGtsL0hDZ0JxamNUcDN5?=
 =?utf-8?B?Y2s5S2VjT0VJcXRvN0hwZUdZanlGQURiZzhCeEJjZ2c1bTNQK0dnL2wvRjhh?=
 =?utf-8?B?YmsvK2cwSTF6Z2lzTjg0WXAvZHdrRWFDY0FreWpOMGRaNEpiQXBzYzhoaDE2?=
 =?utf-8?B?a0R2Vjc4T1lFVXlPVTh2b041NTZ2T0gwSWdKZUlIY29yUGx6ZzlZMzBIbXNz?=
 =?utf-8?B?bHJ3OVpNV0hnNTZSbkw1Lzl2MFluZFljOUxINUhOdTZFcmxxdjAvdlB6MFFs?=
 =?utf-8?B?dURqRHd3a25HMHlBRXBybTRhRXRUYWhoZzJmQ0FCY0hDd0hRYjFDdmFKa1Fo?=
 =?utf-8?B?dzk1MjFmVHpYem81cUhyZ1JsWWRUb2VzamtwcnphRlNsZnBIUXgyK2FrY1Bu?=
 =?utf-8?B?bmVla2hsL0JuRnlzL1Rka0lPS2syOHVWSE1xdzB6djdwdnEvZmF1WFNjRjho?=
 =?utf-8?B?ZFJVSHUxTzNCLzZLcFFPWkl3a1hpTHpDSzRrT1NKV2ExZTdjREpqYWU3WlBk?=
 =?utf-8?B?Q3pFQW9XREhJaWl1ekk3STdRV3laMFVXNFF6OHRqSGxhdVRJc2xLOStEbFo4?=
 =?utf-8?B?b3BqY0ZGRFZqRGVCVGZIbFJLdWFlNGRHMmhXMTAyZmZKSTg3cEhhMFpCdUdK?=
 =?utf-8?B?cmxkVjV4eEh1dmZxcW4va2pUdVBCckdtUmJUVklueERKVHJwYmRsaWNRNGlH?=
 =?utf-8?B?d2JmcnpyU1U5dzcrY3MyVVRFNUthVUthTEFpOUVNZ3B0UXh1Vy9mc0RrVk1O?=
 =?utf-8?B?dnd1Z3VOTGtybldDd2xPYmpvYnhmL1RJZzh1NHh1aXhEVFNrUmllSCs0VTFr?=
 =?utf-8?B?YTlPZk5IZWQ1dU4wTDJBdUNwakhGclFwZndVZEFhK3NXUUU0OFN5SnAxaFFS?=
 =?utf-8?B?Sk12K1ZEbGxkUWZ4TEZtUUtsN1pPK0hpUzRTQmovbWdJRXFabW9aaE9wL0J0?=
 =?utf-8?B?dHByYzFCOCtsWHYxVG1mYjYwdEVUQURqSEJLWk9yQzJod3ZncEJ3ZDhKY3dG?=
 =?utf-8?B?eGFwZ2xRcXZiVWgwWE4rY1RQNlZBMFJwYkdTd0F5eThkdGlsS1RidHhianZh?=
 =?utf-8?B?S2hRSTc2UVAxMGppYjNhVG9NK29YK3RmdXpBN251aDFNVUpXRloySFdLdUk4?=
 =?utf-8?B?aVNMNE0zOTY4RkhPTkJYd0NsVllQckROYzFwcjF4dDcvN0gvK0xBRm5FTDMw?=
 =?utf-8?Q?CSRokSz4AbjtZebZsLc4x1RdN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d30235-2e8c-4944-d053-08dc89f469df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:56:42.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/EU5b655p7GjCgNjErNH4ojri5jq0ExzjhGNYBZhgyRAWlCZaPCtmrazHjgI7php3eW4nP8SsTHKDGGrFAl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5827

In binder_alloc, there is a frequent need for order3 memory allocation,
especially on small-memory mobile devices, which can lead to OOM and
cause foreground applications to be killed, resulting in flashbacks.

We use kvcalloc to allocate memory, which can reduce system OOM
occurrences, as well as decrease the time and probability of failure for
order3 memory allocations. Additionally, it can also improve the
throughput of binder (as verified by Google's binder_benchmark testing
tool).

We have conducted multiple tests on an 8GB memory phone, and the
performance of kvcalloc is better. Below is a partial excerpt of the
test data.

throughput = (size * Iterations)/Time
Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑

Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e1f261ec5c8..5dcab4a5e341 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	alloc->buffer = vma->vm_start;
 
-	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
+	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
 	if (alloc->pages == NULL) {
@@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	return 0;
 
 err_alloc_buf_struct_failed:
-	kfree(alloc->pages);
+	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	alloc->buffer = 0;
@@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kfree(alloc->pages);
+		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
 	if (alloc->mm)
-- 
2.34.1


