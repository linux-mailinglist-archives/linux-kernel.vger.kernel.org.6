Return-Path: <linux-kernel+bounces-367646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F69A04E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C3E289E04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7220493E;
	Wed, 16 Oct 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="DJBG9aiF"
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A99203711
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069108; cv=fail; b=hXv9R3vY2GfYNUFmqMuWtlsjH7Tft51y5l7bhzeT7gRYaRSF9UXRHj5YGo25EHuMHaen1k6oSUHwAy6Mne0kgQoDUddbLznIzWfg8i8D7iOzaSYrnH9sTJBEnMJDLMdfAS3FIERc6n+2Hs38bNnvmF8iTXfCYmj01188lZZx0As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069108; c=relaxed/simple;
	bh=8SIb16CHj+6e2QUUIP/7Ba/ONcyEK/XCJlYRS8jDiSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKH/wqEwUIcU7GkcF5zO07YufDHaoOErUV1udwWX5Isat+12pPD1LiK6IzrnXln3MFk4WduqH53XAnn3ugstfbj7x8CqsqWweeXaXyZWBLFMijEGJTPEVnqM+TG/4rDs0uzC0uI+bZw2UAKxQD9W0jOSuLvCIC8LxiVuUxwn1Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=DJBG9aiF; arc=fail smtp.client-ip=210.130.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1729069089;x=1730278689;bh=8SIb16CHj+6e2QUUIP/7Ba/ONcyEK/XCJlYRS8j
	DiSM=;b=DJBG9aiFrQtUgjr0LRQOw4JHgQbV2Y47A+7+AGFIQVwPWyMlgk+lnU0DZlDEhyH5lElRP
	bxUOvXrOPHuPHe7/v5ykowkBY+wuDWkgM4kJOLANGPU125zwH6m8i01XUpQjqvtClXMFCrBcFrA8v
	KscTs8CaiQpD2CA7+/er93dEMhiNWtXChWk2FzgMUWuMaPWp94e85XCGSdgwllGRhxQf4wjC7Um72
	P3yO+48uobw3EQ8RZCxhmgSGXRElqmWIgAgPH8DuGkdy3AHsL3pBW3szeA3QweQ2TXxcczR8gNCJ4
	JWHXXB9o6sCfQ5+VMYM/yCXPB6/jR8MQndATgJkppA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 49G8w9Qx3824658; Wed, 16 Oct 2024 17:58:09 +0900
X-Iguazu-Qid: 2yAaUsYsmv3H1OkGwH
X-Iguazu-QSIG: v=2; s=0; t=1729069089; q=2yAaUsYsmv3H1OkGwH; m=uecqIO3Eh1ZAMnW8pWK+y5TbfF9zQ950CdYCLCJErqQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 49G8w83A3425687
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 17:58:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQKHHajT24dQklNP106FB5d0LdU0tJmY+oL0nJQibJgklGFrGiY0l7Rh5ES4FS+soTEfJN7qLlDNm2eyLsDDCWz68lX8B7VeteMbPp6Zv/ZzUdERkFIP0RQdEigm0sC2LkYk1xmxYiRRwbUsRW7L1zlWkAeLN/CmUHOyyLftkERuQxUNqfJp8OPL2yolXMvdWfWmT/f3JSQQ46qXT+OQW9DiSEmdhR0MQeOp5hRRGbVlXcKhNhdNPkto+15ZjwtN9OVwlBV7Td8SegZZOnBoxh0c6iPfkMWyDIryut36+rKN1ia1DyqtevGcJl9JTNhAEpaH7rokyd42iRLBEaSKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUTY7ySlCAj1qA1bGZrzVsE9qCSUD/YjkBdhw5RQ0Hc=;
 b=ORAU4vLxhAr+gPVz+DD1KdZfGVAdOYAINGASpORatQk+FHm+a8QdwTjsnJ3EVO89zszsT3f4mCj0sG1G+kle+bESWlrHvmtffbaPsA1bDUY/EwOB6Tgqk2aa4OTBMnarJCSVOLsW8ivU/xtRX39hgKZTeb4LL7zDtQvMCEUgL+IU4RyOA+YnogjWpF+VmBthPhejHP6PN8/TUhmodeHaq1J30Det4RY/+xTpY3bT4VDJtJWQdvxwUlCg7pa7CXv/kfvQ1tHv6tDzf6+uZUSh9/0g2V86p73JIswYdU+M3cizggxuX3tgn38rh9ieucjoRh1pkCAPCsuBtrUYWdcsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <rppt@kernel.org>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <yuji2.ishikawa@toshiba.co.jp>
Subject: RE: [PATCH RFC] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE
 check for node id
Thread-Topic: [PATCH RFC] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE
 check for node id
Thread-Index: AQHbH418luan8iNnYEeXjz+N8c32h7KJByAAgAAMVcA=
Date: Wed, 16 Oct 2024 08:58:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63886680F6999A56E19558F892462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <1729057030-4625-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <Zw91Ynr53eGwj91r@kernel.org>
In-Reply-To: <Zw91Ynr53eGwj91r@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB5848:EE_
x-ms-office365-filtering-correlation-id: 79114fe0-b51b-486c-2af6-08dcedc0a647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V3dNYmVRRDdpS0FYTkE4M0VFTGl5eHFoQ3ExUStyVEJyNGoxTkg2SkZp?=
 =?iso-2022-jp?B?MGM3aWxVVkxjeUw0Y2xwYzVzRUVlaHNoeGV4Y3psYjJqdkxtdnZZMHBk?=
 =?iso-2022-jp?B?WklwbG9iOXRBSkVzSDQwT0d4V0h1ellUUG9UbVovcGtPWU9FUlJ4N0Y0?=
 =?iso-2022-jp?B?K0xrVWpmb2ZvL0paVFQ5ZElEWGhjVi9TaExtNHBNcWdaeDdFaFBNczVT?=
 =?iso-2022-jp?B?bUtQL3RLdSs3bGFURDZBeDNMb29ncnErWHI0a0VHZG5POE5VYnUyaDlC?=
 =?iso-2022-jp?B?MnlPU04yUFV5RFYwYVZFdTlrT05YQkU0bkxyZTB1OWZiUUh0ZEQ0Q2da?=
 =?iso-2022-jp?B?Vlgyd3VjVGRzUkxHOFpIbW80MFJYQkRMNlpUa2tWSm5pUE9WZmVZWUI2?=
 =?iso-2022-jp?B?U2lzQTFMdW1oUElBdmNWTGZ2d3RzcDE2WWF3TXpRWGZmSjJUZ0hzUlc4?=
 =?iso-2022-jp?B?U0NhQmNrOG93eS9QclBVUDAxTE93clBFQXczWjZzNng0WU1HT3BXSGRO?=
 =?iso-2022-jp?B?VEVucGt5YlhTSTNUbVlsNVlvOVlodWV0bzNvbGovcm9vT2xHVEJjS1E0?=
 =?iso-2022-jp?B?Rjd3a2tqRVdlKzJkUUUzL2IwMzdKK1RjS3FqVE56RnZ0TE9KTDRLNEJn?=
 =?iso-2022-jp?B?U1JIcDlaUkw5MG9Zek9Lbm56ZU1rYlB2RnMyQ2ladGdDbVVGWXZZOVo3?=
 =?iso-2022-jp?B?OEpGcDlxVVpmQzVObTIzdk9iOVZzbU1iVEp6MEdWU3c1NVJqVDlWMXJS?=
 =?iso-2022-jp?B?WHRiTnJCNUh4VWx6RFZDbzV6Vm1pd1A0YkFzRU92cVlEcVg5U0FzT1B2?=
 =?iso-2022-jp?B?bnphMHJMT2s3MHR0WlRiZVlqN28rQkttR0czQVR4VmZmWUI4aDRXOUtt?=
 =?iso-2022-jp?B?c2xROTN0U0FHbURjSjR5QllWK0lZLzh3cVVVNlFEUXNmVEVsMVpZZmhC?=
 =?iso-2022-jp?B?M3BEZmg5MTZBVk1LWk1rV2loeC9LWDc4OXlMSVhJd1cwL3hIeUwrWGEr?=
 =?iso-2022-jp?B?Nk9EbVh0bThrRTU5a0xlSVIyZFZ3NVVRMVBCZlVnUmdWYUFmdHdpdzc5?=
 =?iso-2022-jp?B?ODRZLzdJbmgwMXpBcGZMTDg5a0VEZ1hGeFhmZUg3d2JnRXdXUDBwT0RO?=
 =?iso-2022-jp?B?WVRiMEJQQ3dyM083K1h2eHJacFNKT2ZaQitDM20vZ0NXTUtCWWhmNSs0?=
 =?iso-2022-jp?B?WFd6cTB5YW5nZDVhdE1zTCsrQ0V1Um5YSHZ4S3RicG9kdUpWS2h2N0Vl?=
 =?iso-2022-jp?B?aHB6NUpqcllpVTVxY0ZGSFhPazJCSE84VThUU2JOL0Y5Z2JkK3hqYXBq?=
 =?iso-2022-jp?B?dWNkdzZWM2JGNHBuU0RsaFFhbnlVMlNDU2pmbG8yaU5xalMwV2tGdVBT?=
 =?iso-2022-jp?B?SlJ2cUdjYTJJYi9nQ1FFRVZwSkZVUXg1RTBEd3Y3MUpQbE5qcXI1S1l1?=
 =?iso-2022-jp?B?U0s2RmZpSlF1NHN4NGU0aFBmWXZCMUNLSkN1SFY2S3FxbzJSd0ljdU5q?=
 =?iso-2022-jp?B?RFo5S3NlVEdjS2x6clh4VWVqTDE5TDRodUpUL1lJcENPalZZb2pwYTg2?=
 =?iso-2022-jp?B?NHhWSGJJK1NWNmJ2QUhVYVlzTXNmT2lNZS9BVXJGMWM0Q0lOWk51NUhH?=
 =?iso-2022-jp?B?L05IZUdQc0RSazUxakRGbzByaEhIV2xwU0pJSWhidFpjT3JPVVhPVW1Z?=
 =?iso-2022-jp?B?NStLR1VBQXBxaUtzK3RFNGRwNGxLWnlLN1NuODJzN003VzVzUzVEbHhp?=
 =?iso-2022-jp?B?dWFrWU5XUHFiY0NUb2hoaWFVSzVyYXJqK1VBd1RpN2Q5Uy9FRTNhVnBH?=
 =?iso-2022-jp?B?L3pGazQ3WHJtU1BNbEMvbUg0YmNqRVo3RVJTK0VLL1F0V3BLMHRybkI5?=
 =?iso-2022-jp?B?MHJTTUs2cTRLSjNsejZ0VmQvWDU0TS9BUzI0U3dkbHhyYXlFdGVwUjlm?=
 =?iso-2022-jp?B?bUhDc0FrYVNKZFIrcS9paHdVdXBMbjJRdXRkR1RpeDFLTGJQRGVZRzFD?=
 =?iso-2022-jp?B?Yz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dmR3aEZ0Z0NKbUFnMkhXRGFldDAvT0xQNXhlb2ZsYW8xditjd0hDUHpH?=
 =?iso-2022-jp?B?VDZPcDAxMjAxblU2eTBaWGZSYXIzS3VkenZ2eGcySmNQckRmVmpnT0dz?=
 =?iso-2022-jp?B?SThkcjFYcHlWMlFzQnJCZUVYQjVuZkNTM0sySUpCRjBuNkRUN04xdklo?=
 =?iso-2022-jp?B?TUJPUUNzZDdxUEtWczdMWGxJZXo5Vy9zVTJTdVh5WXAzYnJHZGZDZzV1?=
 =?iso-2022-jp?B?clBQb2N0VTU4aEpyRWg0SHNoZmlhNVNwWURYdi90bXNvVUpBNDVZUEY2?=
 =?iso-2022-jp?B?UXFlL09lYnYyRnRqejEvMHJiZXQ5ZDhyUGtWb3VHaTAwZ3pmR2hRSDRN?=
 =?iso-2022-jp?B?Ui9NODUrNERZamI2cW1iRXJWYWhxVEtFK2Nlck4xaG82bDdDVTVEMHFh?=
 =?iso-2022-jp?B?ZDB2NWI5N1NvUWpXUGdIZDdnME8venNzRCtrYVlKRkNEOWh6RHV0MmRW?=
 =?iso-2022-jp?B?YkNpWGdxYnhOU3I4MWpuT3pSV1Z6WjBoUmpYL01qa0dmaUVHOFJjUDRE?=
 =?iso-2022-jp?B?TnV6b2xhYW5OQU5pMDE4K0FFTDNZTktzYU42RE8wQWNKOXJqV3BWRDh5?=
 =?iso-2022-jp?B?WW05OGZFT0VMTVZuWGs0QWZnVnZ0Rk92Rk4yRnEraGYwVjdacGtLeWJM?=
 =?iso-2022-jp?B?TWpJRTd2RGZqcDMwa1FMWnFKWjhDekZLT05yQWYzM2xjK1JwSzc0R2k5?=
 =?iso-2022-jp?B?N3U1S0pJNXBvVDcydVZhTzk1SmNXVitneTFtemF6SGg1Y3ROQWdCaDdT?=
 =?iso-2022-jp?B?clFOcFRDWTZMZTRzSUNzc0lZbjF4azdxVUJERFhvUWlWNXF5bXptQVk0?=
 =?iso-2022-jp?B?cE5VYUpBaS8rNGxwWS9Ta0F2bVJkK3BhT3REQUhuVUJBVXhnME95Titm?=
 =?iso-2022-jp?B?ckZoTytBQlZVWnFwcUpxWWF1dUZJMWdXeFBYQkMvZk9SVkQrZWRKRFhn?=
 =?iso-2022-jp?B?bTlOVmRRTVp2QnBLUVEyVGQxcW4zU3hDMGpVaXUzZ3RhenNDWXU1NTly?=
 =?iso-2022-jp?B?TWowV3Jrb1hWR1d6N21tdnJPL1VrV01qNXp0ZEpNK3M5dGZZM0ZrZ1N3?=
 =?iso-2022-jp?B?Z2pLZzNDMG54OWlxUlRDZDJZOEl5elFhWm9EMTloWkZ6Ni81cnBhUThp?=
 =?iso-2022-jp?B?NzlXQVVsNDVBU2Fla1VtWDFVd3NJMVc1QjRDOTF5ZmlzUXU0aVBNNG50?=
 =?iso-2022-jp?B?czBYZmM1elY5bEM5WHI5cWZTUTYwYWFDN3E4NmRTWllleE8waGRvRXpY?=
 =?iso-2022-jp?B?Z3RpRHNXN2xzdkhzQTBkS1pVZVAyU1FjdUVLa04xbWtHak8vTXhqbk1x?=
 =?iso-2022-jp?B?SnhYTmptOEVuMisrdzFtc3V5bEdqV0FuQUVQMm1EdkR5d3pNd3hOL2d5?=
 =?iso-2022-jp?B?Y00vZURjM1AyaXYyRW5FbWowR0ZoeDJKSWpKRjN1M2YySGJDQjJtZHZN?=
 =?iso-2022-jp?B?TVkzSWt2dXJnaDMzeEpETnpmNnlyOU81MUIzR1RPZ1NidEludmE0ektX?=
 =?iso-2022-jp?B?WUl2MXo1ZHljcFk1RGpCTS9ESzJVdERhN29yMUY0d3BscUdGbTRUdVJq?=
 =?iso-2022-jp?B?QWhGcXNWV0Vzdmpnai9uSFplYnFhU1hEUENpN3kxUllKQTRJNTFUZENP?=
 =?iso-2022-jp?B?S0ZDQXpteWRuNzJoUTY4MlBaa1JYUVdVZC9raDc1d2o0OWU1aVRqQ2VN?=
 =?iso-2022-jp?B?Um9ZelpKc1NSNGVXb0MrZVRobTBKVWZwRHZtQ3VmMjJSZkN4eWF5NFZ1?=
 =?iso-2022-jp?B?TzhNMVZtY0pKTWhVY0tBZlJaWkhyT1VQdnd5a3IvM29hT0w1SlFhY1Vo?=
 =?iso-2022-jp?B?b3BucFVIMXd1S2dDVHBuK0hhcU84Q1pmdDRrL0xEMWVZT2lRZ09MZ0hs?=
 =?iso-2022-jp?B?UkQ4alRQZTR6VWc4RS9BZ29NN0hQZWl1Wm9JKzkyTTQrcG8zYmo4Wkh5?=
 =?iso-2022-jp?B?c21MVE5ScnlpUk4yOVJ4SGhqeEFrTW82ZXQ4a2syVjVPbTJVOXBxdmVn?=
 =?iso-2022-jp?B?Z2JqZC9mZnVBM0orRFNMR3djaXZGZ0J6VmtzTHk4a1BCc0NIVXdhUWcz?=
 =?iso-2022-jp?B?K2ZVOGtqcVhiQXpUZjF3OW0wSnUrNzRNRDlJcGY5UExoV2p1K1MzZ3My?=
 =?iso-2022-jp?B?VlptcVZ6d0REQitqdGNEd21wMjcyY1FpMnd5S1VORE5va2xUcDFMdUtQ?=
 =?iso-2022-jp?B?QWlZdHZJVzNCbXBhUWwwQVRIenlvai9iK1EwRmpKdG5ydkdEL3F6b3Av?=
 =?iso-2022-jp?B?ZW0razNwQ1ZpYWNicWhXcjFHM1Nacnh4bnB5YWFRZHJrOVBiS3loUXhE?=
 =?iso-2022-jp?B?NG9HdlBMUS9NSENxbG1pWDdiM0RHYUwvNlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79114fe0-b51b-486c-2af6-08dcedc0a647
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 08:58:05.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4TSMtNZdGvcTRxjvZphW6Q9VQ5fFmBPvDlO3Va8wA3geImitplUaruELEWGE9hv0L/4tuILLcnb77JLXR6C0Jh1iUyLeUVlAsGh+lP8asBHMYi1u9nAkR7MsTtR76kJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5848

Hi Mike,

> -----Original Message-----
> From: Mike Rapoport <rppt@kernel.org>
> Sent: Wednesday, October 16, 2024 5:12 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: linux-mm@kvack.org; Andrew Morton <akpm@linux-foundation.org>;
> linux-kernel@vger.kernel.org; ishikawa yuji(=1B$B@P@n=1B(B =1B$BM*;J=1B(B=
 =1B$B!{#R#D#C""#A#I#T#C!{=1B(B
> =1B$B#E#A3+=1B(B) <yuji2.ishikawa@toshiba.co.jp>
> Subject: Re: [PATCH RFC] mm: numa_clear_kernel_node_hotplug: Add
> NUMA_NO_NODE check for node id
>=20
> On Wed, Oct 16, 2024 at 02:37:10PM +0900, Nobuhiro Iwamatsu wrote:
> > The acquired memory blocks for reserved may include blocks outside of
> > memory management. In this case, the nid variable is set to
> > NUMA_NO_NODE (-1), so an error occurs in node_set().
> > This adds a check to numa_clear_kernel_node_hotplug that skips
> > node_set when nid is set to NUMA_NO_NODE.
> >
> > Fixes: 87482708210f ("mm: introduce numa_memblks")
> > Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/numa_memblks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c index
> > be52b93a9c58..b982f9260872 100644
> > --- a/mm/numa_memblks.c
> > +++ b/mm/numa_memblks.c
> > @@ -349,7 +349,7 @@ static void __init
> numa_clear_kernel_node_hotplug(void)
> >  	for_each_reserved_mem_region(mb_region) {
> >  		int nid =3D memblock_get_region_node(mb_region);
> >
> > -		if (nid !=3D MAX_NUMNODES)
> > +		if (nid !=3D NUMA_NO_NODE && nid !=3D MAX_NUMNODES)
>=20
> We have numa_valid_node() check for this, please use that.

Thanks. I will send v2 with it.

> Otherwise
>=20
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>=20
> >  			node_set(nid, reserved_nodemask);
> >  	}
> >
> > --
> > 2.45.2
> >
> >
>=20
> --
> Sincerely yours,
> Mike.

Best regards,
  Nobuhiro


